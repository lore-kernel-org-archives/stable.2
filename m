Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427759;
	b=f4ALe/4NL0bU8lcrv+iD0+Z9CnNvKQFE55+286bJQLqAwIY1J+qXAcnUUTo8AoHvY3jn
	 xdkR+UrCsI4JYttR+Q2NfVsbPMYhuNXbWT6t2Mnn0m6x7VlULfLb94Lw0T9Mo6CkWQT9m
	 aV2Vo/0kALYeE9oLN7OKfA/2eFcZ9xUhbpekOl6lDfW0DhICmekT+UTJZUaU5kc5KQKaa
	 Mo7VakruIaosa8/eq9rW75Zqd+V9zM3U3zNqZs8jCzIKJ7FIoPH1rxPK+wFHTnyuRW+Rq
	 00mJTD+GJNQZUqCMZx2VdNx1+7626/2lT+bz4LleQ0542lgjyW7HeE06fvDRsCGVMxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427759;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=f4ueN3+HTbk86AHxGrIafHoF+PtBff+ah6uckXieWNo=;
	b=ftoODbZc3IwuNU1rC8f8uExKNR28D2tg2Tkm33dyedF3t35WMGWioZ26ywrLM+4MGInF
	 HNzcLtO1cbQg9I4kdiKukgQIb/0cwqL/bWEgNTnHruz6xm8n6V7xsobvDBQGXtluWFwpO
	 sCNd1lwTKNlSPL9hLSYXm8Rbf5cZAQf6nCZNvHxU1td57+0QCmzirlWg6b1jmYEXWFtKj
	 h+X5atD4t3UMTfSyE2EuBNp/h3SSyBSFo/RZ9Vwy9yYKd4DaZTnSNVkt5q+7/JAWe/mkQ
	 EBTKOpbZAA8VbFxmmhspo3ws1TSm6Ta55aXKS2pZ08JGcFUVx6LVRpxEb8YJ2tP+pdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OlpdqSjz;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F91606A332
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48F91606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OlpdqSjz
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4D0B24E41279;
	Mon, 19 Oct 2026 16:35:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1241060582;
	Mon, 19 Oct 2026 16:35:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF88C10328D1B;
	Mon, 19 Oct 2026 18:35:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792427750; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=f4ueN3+HTbk86AHxGrIafHoF+PtBff+ah6uckXieWNo=;
	b=OlpdqSjzD5TUO2/O4PHG8w2QOgK37bG45GXP+nofEvF/ryd+c1F1fwKp2JKq5zv+SRFIDm
	Bb85j7rVUKO5Z9jZeuTYSQYV48T4pYGiHde1WCweivf14YqXx2/TRyyGQEdfjlJLf3N7Ld
	99J9smmNq7QqkCJSorDCaLiU2Q6lFLt/jRpTsrkuWgofQPiG4DAqT877m0F0lHagGoUE7y
	x6ZkfEn3wX8mJAa6x3ylS+CshkdU4JI2UqReR71SCUWyo9+Wgjsf6dA7e4xEPJ6dWy0wdJ
	a/Q917lGOSvibFFRqqZSSmY/wZdoDkLWkc99M1GOMPZctcF9g0X1QwiUdyEs1g==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 19 Oct 2026 18:35:44 +0200
Subject: [PATCH 5.10.y] skmsg: Skip zero length skb in sk_msg_recvmsg
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-cve-2024-41048-v1-1-f68f503fd029@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CUAyE4auQWVvSkmLEqxgXWKrWBZr3lGgId
 /cpy2+S+WdkT+EZ+2pG8ily3McC2VSwaz9enGIoRsPNVlg6ssmpQEmFdUdqQ6+duggbyumR/Bz
 vf/CAthauPziue36dbm7PXw3L8gW1Hk9+egAAAA==
X-Change-ID: 20261019-cve-2024-41048-4cda494e110c
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Geliang Tang <tanggeliang@kylinos.cn>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792427747; l=4645;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=GqnPy3WEo2lamKSWjeZtBKhw6HeKZ7lHoXkt9CgzYgI=;
 b=nEunJLndKbjsqz+jBJDnHxfklcVFahJHrDAtq6+k4aa1Bxowt8UiYudAjBfrrFQ8MQmqKTKTd
 78+9uyu9dV0AO68kMz7eNMp+Sz00WCEMelP0xNBuDsJ0lR+aoR7NP+o
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Geliang Tang <tanggeliang@kylinos.cn>

[ Upstream commit f0c18025693707ec344a70b6887f7450bf4c826b ]

When running BPF selftests (./test_progs -t sockmap_basic) on a Loongarch
platform, the following kernel panic occurs:

  [...]
  Oops[#1]:
  CPU: 22 PID: 2824 Comm: test_progs Tainted: G           OE  6.10.0-rc2+ #18
  Hardware name: LOONGSON Dabieshan/Loongson-TC542F0, BIOS Loongson-UDK2018
     ... ...
     ra: 90000000048bf6c0 sk_msg_recvmsg+0x120/0x560
    ERA: 9000000004162774 copy_page_to_iter+0x74/0x1c0
   CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
   PRMD: 0000000c (PPLV0 +PIE +PWE)
   EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
   ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
  ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
   BADV: 0000000000000040
   PRID: 0014c011 (Loongson-64bit, Loongson-3C5000)
  Modules linked in: bpf_testmod(OE) xt_CHECKSUM xt_MASQUERADE xt_conntrack
  Process test_progs (pid: 2824, threadinfo=0000000000863a31, task=...)
  Stack : ...
  Call Trace:
  [<9000000004162774>] copy_page_to_iter+0x74/0x1c0
  [<90000000048bf6c0>] sk_msg_recvmsg+0x120/0x560
  [<90000000049f2b90>] tcp_bpf_recvmsg_parser+0x170/0x4e0
  [<90000000049aae34>] inet_recvmsg+0x54/0x100
  [<900000000481ad5c>] sock_recvmsg+0x7c/0xe0
  [<900000000481e1a8>] __sys_recvfrom+0x108/0x1c0
  [<900000000481e27c>] sys_recvfrom+0x1c/0x40
  [<9000000004c076ec>] do_syscall+0x8c/0xc0
  [<9000000003731da4>] handle_syscall+0xc4/0x160
  Code: ...
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Fatal exception
  Kernel relocated by 0x3510000
   .text @ 0x9000000003710000
   .data @ 0x9000000004d70000
   .bss  @ 0x9000000006469400
  ---[ end Kernel panic - not syncing: Fatal exception ]---
  [...]

This crash happens every time when running sockmap_skb_verdict_shutdown
subtest in sockmap_basic.

This crash is because a NULL pointer is passed to page_address() in the
sk_msg_recvmsg(). Due to the different implementations depending on the
architecture, page_address(NULL) will trigger a panic on Loongarch
platform but not on x86 platform. So this bug was hidden on x86 platform
for a while, but now it is exposed on Loongarch platform. The root cause
is that a zero length skb (skb->len == 0) was put on the queue.

This zero length skb is a TCP FIN packet, which was sent by shutdown(),
invoked in test_sockmap_skb_verdict_shutdown():

	shutdown(p1, SHUT_WR);

In this case, in sk_psock_skb_ingress_enqueue(), num_sge is zero, and no
page is put to this sge (see sg_set_page in sg_set_page), but this empty
sge is queued into ingress_msg list.

And in sk_msg_recvmsg(), this empty sge is used, and a NULL page is got by
sg_page(sge). Pass this NULL page to copy_page_to_iter(), which passes it
to kmap_local_page() and to page_address(), then kernel panics.

To solve this, we should skip this zero length skb. So in sk_msg_recvmsg(),
if copy is zero, that means it's a zero length skb, skip invoking
copy_page_to_iter(). We are using the EFAULT return triggered by
copy_page_to_iter to check for is_fin in tcp_bpf.c.

[moved the change from sk_msg_recvmsg in net/core/skmsg.c to
__tcp_bpf_recvmsg in net/ipv4/tcp_bpf.c, as we are before
2bc793e3272a13e337416c057cb81c5396ad91d1 ("skmsg: Extract
__tcp_bpf_recvmsg() and tcp_bpf_wait_data()")

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/e3a16eacdc6740658ee02a33489b1b9d4912f378.1719992715.git.tanggeliang@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 net/ipv4/tcp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 458b8a694b9d..089751357244 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -38,7 +38,8 @@ int __tcp_bpf_recvmsg(struct sock *sk, struct sk_psock *psock,
 			page = sg_page(sge);
 			if (copied + copy > len)
 				copy = len - copied;
-			copy = copy_page_to_iter(page, sge->offset, copy, iter);
+			if (copy)
+				copy = copy_page_to_iter(page, sge->offset, copy, iter);
 			if (!copy)
 				return copied ? copied : -EFAULT;
 

---
base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
change-id: 20261019-cve-2024-41048-4cda494e110c

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

