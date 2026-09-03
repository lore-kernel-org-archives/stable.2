Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04414B66ED
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445842; cv=none; b=FnQtardeIQwYlkvwbHT6fliO8/3gYb8RPaMrcdHmN8wY3UmFM4XzlU33KSpVnmXHaIatCdr3+N0PcctIQZyOdfasMp0K3FghJiuwl0GvyvdO172CWM+wivB0xOCofW06kfwp3bak+4IAq3oycsVS0PYiY3m74KuCeQtsiGwqNw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445842; c=relaxed/simple;
	bh=aowAOVOW4QoqSlPpoJJYxq1eQJrjaISEpXN7xgeJX9A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dGx6NXQWDD+BK6fn+oZv3fRrvY6cNvv9+ny3gkIGc1okAoo5llTs7kvSQE7X+sGZBmRYoxtkXIgu6UG9J7lbQCajXlKeWGH5RCEjL3qeuZjCKQ3AMhaaSTGwAS0CBJZ5grPHCKgdTR8fdoqy4Nuu5ZlWvSjmSiUETAu8Bf3pyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dwPIdFaM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dwPIdFaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1511F00AC4;
	Thu,  3 Sep 2026 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445832;
	bh=pPExgSFk6XDIIv4PypDluCdLsUVrPRVogDCxbFr7j7k=;
	h=Subject:To:Cc:From:Date;
	b=dwPIdFaMOwtS3UBDompINxmOQ1zcuW74rOUBNyi1fJGKtzVlB4D90K/EB1htjNKMC
	 bbEfQub+VjeeOaem9s3LAxd7cNcPC8St2v5HfFhBdGLNiFb+PwEuxnCkNMp0IA0ECm
	 m+yrGKiULjgd6fhAN9Z01X8gYqJOJfrrlpHTziSw=
Subject: FAILED: patch "[PATCH] SUNRPC: fix gssx_dec_option_array error path bugs" failed to apply to 5.10-stable tree
To: clm@meta.com,chuck.lever@oracle.com,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:07:04 +0200
Message-ID: <2026090304-mouth-annuity-d658@gregkh>
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
git cherry-pick -x 5e9a94539b1ec17a89177d952badfd0d844d694a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090304-mouth-annuity-d658@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e9a94539b1ec17a89177d952badfd0d844d694a Mon Sep 17 00:00:00 2001
From: Chris Mason <clm@meta.com>
Date: Thu, 28 May 2026 15:32:09 -0400
Subject: [PATCH] SUNRPC: fix gssx_dec_option_array error path bugs

Four coupled defects in the gssx XDR option-array decoder make the
error paths unsafe: a NULL deref in the caller, a refcount leak on
the decoded group_info, and a latent use-after-free that the leak
fix would otherwise expose.

gssx_dec_option_array() sets oa->count = 1 before allocating
oa->data.  If that allocation fails, -ENOMEM is returned with
oa->count == 1 and oa->data == NULL.  All other error paths jump
to free_oa: which frees oa->data and NULLs it but also leaves
oa->count == 1.  The caller trusts the count:

    gssp_accept_sec_context_upcall()
      gssx_dec_accept_sec_context()
        gssx_dec_option_array()        /* fails, count=1 data=NULL */
      data = res.options.data[0].value /* NULL deref */

Independently, free_creds: releases the partially decoded svc_cred
with a bare kfree(creds).  gssx_dec_linux_creds() installs a
groups_alloc() result into creds->cr_group_info; that object is
kvmalloc-backed and refcounted, and only put_group_info() reaches
kvfree().  A plain kfree(creds) drops the wrapper and leaks the
group_info allocation.

The natural fix for the leak is to call free_svc_cred(creds) before
kfree(creds), but free_svc_cred() invokes put_group_info() on
creds->cr_group_info unconditionally when non-NULL.  The existing
out_free_groups: path in gssx_dec_linux_creds() already called
groups_free() on that pointer without clearing it, so once
free_svc_cred() is wired in, the subsequent put_group_info() would
touch freed memory.

Fix all four together:

  - Move the oa->count = 1 assignment below the oa->data allocation
    so it is never set when oa->data is NULL.
  - Reset oa->count to 0 at free_oa: so count and data stay
    coherent and the caller sees an empty option array.
  - Call free_svc_cred(creds) before kfree(creds) at free_creds:
    so the refcounted cr_group_info is released.  free_svc_cred()
    either NULL-guards each field explicitly (cr_group_info has
    an if() check) or delegates to a helper that is NULL-safe
    itself (kfree for the string fields, gss_mech_put() which
    guards with if(gm) at gss_mech_switch.c:342), so it is safe
    to call on a partially decoded svc_cred where only
    cr_uid/cr_gid/cr_group_info have been written and everything
    else is zero from kzalloc.
  - In gssx_dec_linux_creds()'s out_free_groups: path, release
    cr_group_info with put_group_info() rather than groups_free()
    so the teardown matches free_svc_cred()'s refcount-aware path,
    and clear the pointer so a later free_svc_cred() on the same
    creds does not release it a second time.

Fixes: 3cfcfc102a5e ("SUNRPC: fix some memleaks in gssx_dec_option_array")
Cc: stable@vger.kernel.org
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260528-tier2-v1-2-d026a1415e0b@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index fceee648d545..f2b8f919adea 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -222,7 +222,8 @@ static int gssx_dec_linux_creds(struct xdr_stream *xdr,
 
 	return 0;
 out_free_groups:
-	groups_free(creds->cr_group_info);
+	put_group_info(creds->cr_group_info);
+	creds->cr_group_info = NULL;
 	return err;
 }
 
@@ -242,12 +243,12 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 		return 0;
 
 	/* we recognize only 1 currently: CREDS_VALUE */
-	oa->count = 1;
-
 	oa->data = kmalloc_obj(struct gssx_option);
 	if (!oa->data)
 		return -ENOMEM;
 
+	oa->count = 1;
+
 	creds = kzalloc_obj(struct svc_cred);
 	if (!creds) {
 		err = -ENOMEM;
@@ -294,8 +295,10 @@ static int gssx_dec_option_array(struct xdr_stream *xdr,
 	return 0;
 
 free_creds:
+	free_svc_cred(creds);
 	kfree(creds);
 free_oa:
+	oa->count = 0;
 	kfree(oa->data);
 	oa->data = NULL;
 	return err;

