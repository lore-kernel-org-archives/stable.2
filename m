Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701315;
	b=4NPSbZG9QIaWn2kMjzXSTN/MPXXh8cVis1JtNCp1zme6ev6/kOuFsn2SYhmg1PFvi3wr
	 10lMi9Eqi/ls+G0HOlgwOxCDatrNOWSaG8FeuHFA1H/4Vy+Ov5USgDB3WmcdbgNE69Tkz
	 vyydsvD2Zi1dPswqm4SeteegZjPu5hU1BrLlSQ5sU7sL5MV8o/wDqy3qic5Tm1K3d7Sw9
	 RGZwm4RpMBi2R8UFEtLj7jsxnKQVG7Ll43guNv9xlcuLPmdRgdWFtqS6Sji1hVyo+W6wV
	 YGG18S8XmX6zMGyjy1lL/RZCc7hPWMYr4MMCdRDhwwPARxDOgn4BlAnAe61s6QYlxFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701315;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tZ84vGRGWFLdn7FuSP9mNBUeQIyKlXvra2VzoLheRR4=;
	b=4NttLF+K8cMv9AdJzCUBoQV6H+3yYUw7pFnTjBQdEfMzP2SNYiA81rj2zuuH2dABg37D
	 hJ0rrltiE90J8Z8D2RSz52qb1LHk99QX0Z/VwqzIJnxb7dLyWLhRdnjQWxDWBim9cFWho
	 EbLv0x3yQ7g3KQ8KgfgCsm2iZhVGlj9XNQ5VJdvYM/fxgoYPXTOtY7J1j+iptdj22kh60
	 eWzApGp92BS5b1bIuxXS1lE2D3Z4RTNaZr5/lmQEzgEIDhCVOtgQ56IirLv4E55f6HF0q
	 eo8K08J0aaRIX+UOO30Kfgveb1Du0yqsBf6xFOuPJpCUTHAJcWEe0lOVinSP8+3jFyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="Hk/Xgzze";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65EC606B11E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Hk/Xgzze
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FA01F00919;
	Tue,  3 Nov 2026 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701314;
	bh=tZ84vGRGWFLdn7FuSP9mNBUeQIyKlXvra2VzoLheRR4=;
	h=Subject:To:Cc:From:Date;
	b=Hk/Xgzze+kbNgasbGtFgPT68XYIf4yuPnv5jJjgmr+7Qr+MZ1pXg3tuacdjdlDYP0
	 XMq9KbHQcYEvUQ3HJJK2ljOkvv/VG4SgDyFqm+df+xyOSt0RNlHbopLl9hRGT5a4hY
	 GAiJIE7926zKyTacp98vCXBPcMuG3iYZrH7zpZt0=
Subject: FAILED: patch "[PATCH] ksmbd: fix out-of-bounds read when padding the final compound" failed to apply to 5.15-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:21:43 +0100
Message-ID: <2026110343-corporal-pang-fc06@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 714f27729121d59f103ca4dad7b0c2d1c125cd71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110343-corporal-pang-fc06@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

