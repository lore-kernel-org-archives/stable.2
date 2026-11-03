Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701310;
	b=bHCDM4lREILgC/2CVT7ZeQv2ogP1nC5qvyT9UMqkCC78KapGFVsIk8nLh5Co5LovdJp9
	 24wUeAikAzyL7fKFb+sW8L1zJsFSn96Sc2hTf57Vlw1kPP3zQifEGXUFa7l5CzJNgQS+V
	 fC386+9elpOi3sUkkSEIwop5byq3Auy4KNw969+jhyGk3tq7kIwunWYoWpNDL31DPrqeI
	 W0PkdlD/+gF/G575kJ1poQeRQtBmrPniYaMgW2rFVY7FjJ7AemBAdaMvSrfqhnwAv9h2m
	 eH+QFCFuvcSWsh5eKflKiwUlk8XYPvK3B96U3WP0g74krFPTy3jRcPuKYGujONO/vMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701310;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kRe24PIbtAiU3wBzNvox23Aq93ZcBlXwCFLzVmW9yTc=;
	b=ztw3iacDIp1qe5kujBeAd5mR0ErZkdmwLDTTxz6oQ43aj7CJLM4vIXTI4P6cSms1ime/
	 +aBEN/IWwOYgP1aCBdMU+w5WaUB+kxnyh6zbg9MlIDvRTFSD1z6Gazrcniq0M7uNkAgTX
	 SZiJPQoO4oXXiYRE/5n49DTXoD0Y87VyG7qJdZgIGEsbinYnnxfhP3D+bX4DD0XKkPUnw
	 6ju+x3W7DrFSNxJ2y6e5RuuWoHKz8E3m5BPedRKop5gf/mMqUEQDq22T5NV/5G5LgjTDu
	 lLZPTljwEgjfsAYtNboUeApUJmN1TXREitzC4kAVk941jcafEjEnltACRFN19cmg+Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kP7lr5DB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAC606D806
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kP7lr5DB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836F01F000C1;
	Tue,  3 Nov 2026 10:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701309;
	bh=kRe24PIbtAiU3wBzNvox23Aq93ZcBlXwCFLzVmW9yTc=;
	h=Subject:To:Cc:From:Date;
	b=kP7lr5DBQBXufgeCAOrqulbsSdkn6ocVKY332MnfVIofVM+9b06t16RI7vNSp5aqF
	 3pFts5YjhI+RQWU9rKSTCPwhWQnS2egkfPOMvhMfemRNgjYCz7FyjAmHEBQGx5DUyu
	 4nQaTHdbPbcuWWgXz3Zrvl7bplgTLM+4Z005TxK4=
Subject: FAILED: patch "[PATCH] ksmbd: fix out-of-bounds read when padding the final compound" failed to apply to 6.6-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:21:41 +0100
Message-ID: <2026110341-crispness-repave-e347@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 714f27729121d59f103ca4dad7b0c2d1c125cd71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110341-crispness-repave-e347@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 714f27729121d59f103ca4dad7b0c2d1c125cd71 Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Mon, 26 Oct 2026 20:40:21 -0500
Subject: [PATCH] ksmbd: fix out-of-bounds read when padding the final compound
 response

Compound response handling pads the last response of a compound to an
8-byte boundary by growing the final iov and the RFC1002 length.
smb2_allocate_rsp_buf() allocates exactly response_sz. A command can
fill the response buffer to within 7 bytes of its end, for example a
QUERY_INFO whose output is bounded only by the space left. The padding
can then run past the allocation, and ksmbd_tcp_writev() reads those
bytes when it sends the response.

  BUG: KASAN: slab-out-of-bounds in _copy_from_iter+0x744/0x10e0
  Call Trace:
   _copy_from_iter+0x744/0x10e0
   tcp_sendmsg_locked+0x2290/0x3f80
   ksmbd_tcp_writev+0x10c7/0x1ab0 [ksmbd]

Allocate room for the padding when the request is a compound, as
smb2_read() and smb2_read_pipe() do for their payloads. response_sz is
unchanged, so commands still fill only up to it, and kvzalloc() zeroes
the padding.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index db3a0500f9f3..b306bc6e21ee 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -969,7 +969,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	struct smb_version_values *vals = work->conn->vals;
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + vals->max_trans_size;
-	size_t sz = small_sz;
+	size_t sz = small_sz, pad_sz = 0;
 	int cmd = le16_to_cpu(hdr->Command);
 
 	if (cmd == SMB2_IOCTL_HE || cmd == SMB2_QUERY_DIRECTORY_HE)
@@ -995,10 +995,17 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	}
 
 	/* allocate large response buf for chained commands */
-	if (le32_to_cpu(hdr->NextCommand) > 0)
+	if (le32_to_cpu(hdr->NextCommand) > 0) {
 		sz = large_sz;
+		/*
+		 * is_chained_smb2_message() pads the last response of a
+		 * compound to 8 bytes, which can take it past response_sz.
+		 * Leave room for the padding. kvzalloc() zeroes it.
+		 */
+		pad_sz = ALIGN(sz - sizeof(__be32), 8) - (sz - sizeof(__be32));
+	}
 
-	work->response_buf = kvzalloc(sz, KSMBD_DEFAULT_GFP);
+	work->response_buf = kvzalloc(sz + pad_sz, KSMBD_DEFAULT_GFP);
 	if (!work->response_buf)
 		return -ENOMEM;
 

