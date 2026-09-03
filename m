Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208414BB7F0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446124; cv=none; b=FZFkaWRm40R/0YU560KyQHpccmuKzBrfWT6GcSiv67sluO9gVKLAdEz7VBxdXM+NpVPh7rdZiNSkqFopyttPcOdIrM9SMAGyUw21VAVWp+5PaN+9YZwHTLVayUQ8VBqYNTROUGM9jrbRi8rTh0ReU3rjlV7qebwG6i1tKzPKk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446124; c=relaxed/simple;
	bh=3Z1QZqgjTTnOHMUw+ucq80v225BzkOPZ30uj4ztEWL0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uUjtFPYRBGT/gMiNsr+cAOtm1HGU7k4EJG/JRsspO5+XMcp0qEqmUGecvGncVIkHzMFgXr7gVxSYPS/6YFfEto9dXxXKucxfrdb/xIlrR4fFQLGwaflA3JzjETf/A0M8ya+Ag/va+Z9y+SeoW3Rzb5/ovTkT29I1RiILuglqrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OCpp6jX/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OCpp6jX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A231F000E9;
	Thu,  3 Sep 2026 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788446118;
	bh=ZHjJI7JIrXXFWu4MKioze/AubjGJb3E9suvRniZJj7I=;
	h=Subject:To:Cc:From:Date;
	b=OCpp6jX/u6UPLQTBMimWtRz5YBMkSUf7R5pW7zG//1gKKCYMo/y3+yZpdnjOZGiuI
	 kMKcbZDnqmcmGLHMUfkZPoCsAuhBKSJPN7q3jlK31KBavWFQ+MXDHTA6JL+jFrzI+t
	 vD4H6dN2aYd+fo/U363+Q2RNYwBv1x83DGpV0K7Q=
Subject: FAILED: patch "[PATCH] SUNRPC: Reject short RFC 4121 MIC tokens in" failed to apply to 5.10-stable tree
To: chuck.lever@oracle.com,clm@meta.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:16:32 +0200
Message-ID: <2026090332-staring-hunchback-c28b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b94f6719dcd9f7a609bc5f459f85795900e77d25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090332-staring-hunchback-c28b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

