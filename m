Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F064BA9F2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446113; cv=none; b=aEQjb7BfNi0NHjMIJmt96YfjJNeBE2IEDTcN1f3QKEoVL69lEQpQQ527lo0uex2qDJj/s3jcjq+YW/h6v7896ZVMhRh0KFO1xtz4xig8z5dNh+k9Wof0rEAVcoXvTnNC1vq5GkKdiuQGv/iRfqrwZ0Wzp/tLCkjBcIqCIN0jiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446113; c=relaxed/simple;
	bh=L9+l3U1EJNl6oEB7Ist9Awd8zbzMQ1H6MPUjbvlbjmE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iXBiiLIxGlv/k6j5JK3l1Wt9CqoN76XH4qo4aH9YQDRr0L41G+yO9pzVl1jrJBDfuEhiUDXdeqootxh0A0OSPPXx5IH4tYarMibrg454wVM/gfyAa+Qo7EGOw7eVzRNPRfGpg2nD4fO+c4UPPL4NZdYOqBee9Drdigys82zO89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aeyOaH+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aeyOaH+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2C91F00A3E;
	Thu,  3 Sep 2026 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788446106;
	bh=+PF8+GrAB8ibFc7MpKa67wOYuA3mj7zztMubydg3L3w=;
	h=Subject:To:Cc:From:Date;
	b=aeyOaH+ZwVY0p5iNHQtYtxnTMN/4ruPWlB4uNM57MamY/n4IQGBen07FZPRE8bPsD
	 5BOyQ6Yi96MXojNLDugBg1F/S9QiyQ4z3fUVTFaF5fXcOZvvRbkkCQW+WAlJLodIEB
	 AkkH1R0Pu14ULeNeXEui8s81OQ5TOA+5TSTPtrAU=
Subject: FAILED: patch "[PATCH] SUNRPC: Reject short RFC 4121 MIC tokens in" failed to apply to 6.12-stable tree
To: chuck.lever@oracle.com,clm@meta.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:16:30 +0200
Message-ID: <2026090330-cranberry-daredevil-a4d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b94f6719dcd9f7a609bc5f459f85795900e77d25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090330-cranberry-daredevil-a4d4@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b94f6719dcd9f7a609bc5f459f85795900e77d25 Mon Sep 17 00:00:00 2001
From: Chuck Lever <chuck.lever@oracle.com>
Date: Sat, 23 May 2026 12:52:37 -0400
Subject: [PATCH] SUNRPC: Reject short RFC 4121 MIC tokens in
 gss_krb5_verify_mic_v2

gss_krb5_verify_mic_v2() reads the token ID at ptr[0..1], the flags
byte at ptr[2], and padding at ptr[3..7], then passes
ptr + GSS_KRB5_TOK_HDR_LEN and cksum_len to gss_krb5_mic_build_sg().
None of these accesses check read_token->len first.

The minimum safe token size is GSS_KRB5_TOK_HDR_LEN (16) plus
ctx->krb5e->cksum_len (12-24, depending on the enctype).  All callers
accept shorter tokens from the wire:

 - gss_unwrap_resp_integ() enforces only an upper bound
   (offset + len <= rcv_buf->len) before allocating
   mic.data = kmalloc(len) and passing it to gss_verify_mic().
   A malicious NFS server can therefore supply a short checksum
   opaque, producing a small slab allocation that the Kerberos MIC
   verifier reads past.

 - gss_validate() enforces only len <= RPC_MAX_AUTH_SIZE (400)
   before passing the wire-supplied length to
   gss_validate_seqno_mic(), which constructs a mic xdr_netobj
   and calls gss_verify_mic().

 - svcauth_gss_verify_header() enforces only
   checksum.len >= XDR_UNIT (4 bytes) before dispatching to
   gss_verify_mic().

 - svcauth_gss_unwrap_integ() checks only that the checksum fits
   in gsd->gsd_scratch.

Add a length guard at the top of gss_krb5_verify_mic_v2(), before any
ptr[] access or scatterlist construction.  Well-formed MIC tokens from
gss_krb5_get_mic_v2() already have exactly GSS_KRB5_TOK_HDR_LEN +
cksum_len bytes, so valid traffic is unaffected.

Reported-by: Chris Mason <clm@meta.com>
Fixes: de9c17eb4a91 ("gss_krb5: add support for new token formats in rfc4121")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260523165237.510204-1-cel@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss/gss_krb5_unseal.c
index b5fb70419faa..4d12d49434c2 100644
--- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
@@ -89,6 +89,9 @@ gss_krb5_verify_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
 
 	dprintk("RPC:       %s\n", __func__);
 
+	if (read_token->len < GSS_KRB5_TOK_HDR_LEN + cksum_len)
+		return GSS_S_DEFECTIVE_TOKEN;
+
 	memcpy(&be16_ptr, (char *) ptr, 2);
 	if (be16_to_cpu(be16_ptr) != KG2_TOK_MIC)
 		return GSS_S_DEFECTIVE_TOKEN;

