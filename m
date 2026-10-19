Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [51.250.60.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE84B9206
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403598; cv=none; b=gZDMPxKqzSFSK+OZ7Ws1i+cQN0739iv2HVps4rDRTfKvxSTDI0kvafslcsOieXtKeKZ5L5D6R6+GycKsThg9Fc5tx/un5xT7TZSQnb0aEIvgV2OzIrvKQIKqB0lSEfytfMR/2e9GX43h30vXHXEL4oPOqWd6B9acIh4UrCtN8vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403598; c=relaxed/simple;
	bh=8X/HacCS73Mg3CMma/Fn2q/h/8sgKijnGsfWMhEKjKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKfY1afpI+qWilhzlQnpTr0oz2gDP13ys5eQkwSgTMP5ULw8t6i74agRMP3tQ+M5jSCVrZbr3xf640oLZJB78PENrgRzhuUlww/kjQFN64Y+mmqMOSAzGzMF2tLqI1B8zhGjiRhRfwEatWin1rM7SVCNTj5K+jkrvrN7a9PD3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=EAscG9Qb; arc=none smtp.client-ip=51.250.60.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="EAscG9Qb"
Received: from mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.yp-c.yandex.net)
	by forward101d.mail.yandex.net (postfix) with ESMTPS id 0B701C004D;
	Mon, 19 Oct 2026 12:53:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36 with ESMTPSA id 5rV6YbUhriE0-XS7qV1MG;
	Mon, 19 Oct 2026 12:53:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792403589; bh=la0J675PTXW8ZmPSnbPqOI+Rr2RKyEb+JKleV5KItkg=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=EAscG9QbuFiFpz0oj2euBxWeTvwEZC0GYm0X7iPJ7dRHmciOppqT1BeX1v5bbIZrV
	 dpa9bhKzZEeoHszKMw5NAbfrrtxGXc8icGEOqVr51JXhAT9m9lD2lqjYhYLNCxEyM4
	 75u3MXfHaXQndTsYdkCG1U/U6LOt5GAK8rGmFg6A=
Authentication-Results: mail-nwsmtp-smtp-production-main-36; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org,
	Levi Zim <rsworktech@outlook.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 6.12 v2 2/5] tcp_bpf: Fix copied value in tcp_bpf_sendmsg
Date: Mon, 19 Oct 2026 12:52:36 +0300
Message-ID: <20261019095239.221813-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019095239.221813-1-dmantipov@yandex.ru>
References: <20261019095239.221813-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Levi Zim <rsworktech@outlook.com>

commit 5153a75ef34b3f7478ca918044d0f05eed8fb3f9 upstream.

bpf kselftest sockhash::test_txmsg_cork_hangs in test_sockmap.c triggers a
kernel NULL pointer dereference:

BUG: kernel NULL pointer dereference, address: 0000000000000008
 ? __die_body+0x6e/0xb0
 ? __die+0x8b/0xa0
 ? page_fault_oops+0x358/0x3c0
 ? local_clock+0x19/0x30
 ? lock_release+0x11b/0x440
 ? kernelmode_fixup_or_oops+0x54/0x60
 ? __bad_area_nosemaphore+0x4f/0x210
 ? mmap_read_unlock+0x13/0x30
 ? bad_area_nosemaphore+0x16/0x20
 ? do_user_addr_fault+0x6fd/0x740
 ? prb_read_valid+0x1d/0x30
 ? exc_page_fault+0x55/0xd0
 ? asm_exc_page_fault+0x2b/0x30
 ? splice_to_socket+0x52e/0x630
 ? shmem_file_splice_read+0x2b1/0x310
 direct_splice_actor+0x47/0x70
 splice_direct_to_actor+0x133/0x300
 ? do_splice_direct+0x90/0x90
 do_splice_direct+0x64/0x90
 ? __ia32_sys_tee+0x30/0x30
 do_sendfile+0x214/0x300
 __se_sys_sendfile64+0x8e/0xb0
 __x64_sys_sendfile64+0x25/0x30
 x64_sys_call+0xb82/0x2840
 do_syscall_64+0x75/0x110
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

This is caused by tcp_bpf_sendmsg() returning a larger value(12289) than
size (8192), which causes the while loop in splice_to_socket() to release
an uninitialized pipe buf.

The underlying cause is that this code assumes sk_msg_memcopy_from_iter()
will copy all bytes upon success but it actually might only copy part of
it.

This commit changes it to use the real copied bytes.

Signed-off-by: Levi Zim <rsworktech@outlook.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20241130-tcp-bpf-sendmsg-v1-2-bae583d014f3@outlook.com
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/ipv4/tcp_bpf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 0e7e12117913..abaaf3e70ece 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -520,7 +520,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	struct sk_msg tmp, *msg_tx = NULL;
-	int copied = 0, err = 0;
+	int copied = 0, err = 0, ret = 0;
 	struct sk_psock *psock;
 	long timeo;
 	int flags;
@@ -563,14 +563,14 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			copy = msg_tx->sg.size - osize;
 		}
 
-		err = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
+		ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
 					       copy);
-		if (err < 0) {
+		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
 			goto out_err;
 		}
 
-		copied += copy;
+		copied += ret;
 		if (psock->cork_bytes) {
 			if (size > psock->cork_bytes)
 				psock->cork_bytes = 0;
-- 
2.56.0

