Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23684854F6
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908047; cv=none; b=LqpvOWuezW7quLOUrSsozl1dJvRzfMTljQBLyurGBndlpQfTRRbT4XLK8EOtumMN3D/6gelSU21wEBWACEXKyIlDkuPH116jHysv+TOPxwFVOlQGkjepG0y44LOtZ8+Ujs+xXRcJ4GrzDbnnCfi7ZOIQvsI7X+7nRPSvP/DXKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908047; c=relaxed/simple;
	bh=mQ/MoC96/gYtvtlsm26R4ObjM0FA7CPk/rr/6pUfyw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8/W2kIcBphVkaGm5Z80fEOS5yRPX9pm5bz///7ag/NmDsy3RoNODXAMhKHDJyz6HrcTPcRPgebWDTqM6BYl87DqppR/EXrMzbLJYhBKMdi6yUDimAcnvdJ6JcgtiyU0AO4n8k9Gr2v3+gwlSK32YAz7O4KvLL8mQ+k2jqomF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLRAktZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLRAktZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49A91F00A3A;
	Tue,  8 Sep 2026 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908046;
	bh=kjqr+DbiTfNtzU/eV+cPXkxxGRbKXya9ypK1pNLmU/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kLRAktZxHfL8BSShkqaGmjortFYYJybRbpWiMYxIeQWbB9rokEq9OiJeG+Gsb14kC
	 vDlz+ECxj8GRmgbci+y5M6Bmmv7zU3K5vi96vxKifYhbTx5xgUkNeCgh/sYWYvgyhC
	 2l/EjwuM9pU+d+Jp4ictKKI8p6Sx1SbGVN3XJ+Ym8OSMPeCZiohE/xeV0EqFO+sy6M
	 3S61ehRJY8Ndk15OfPWoM/zU7NOUgZ8wQP4sDmep99PzCopq1ecdx5LJFAbKgnBeQg
	 zEufHJ0mmKqGs9V5bLwjqx/XiFAdvtM+TCy+oxLMKtt5RJpQ5W5LJpFb+zqCB9MdiH
	 RFdFY2cTJPhpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] SUNRPC: fix gssx_dec_option_array error path bugs
Date: Tue,  8 Sep 2026 18:54:03 -0400
Message-ID: <20260908225403.538655-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090303-aloe-vitamins-c1af@gregkh>
References: <2026090303-aloe-vitamins-c1af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

[ Upstream commit 5e9a94539b1ec17a89177d952badfd0d844d694a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/gss_rpc_xdr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index ee91f4d641e6f..ac9ae42a69762 100644
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
 	oa->data = kmalloc(sizeof(struct gssx_option), GFP_KERNEL);
 	if (!oa->data)
 		return -ENOMEM;
 
+	oa->count = 1;
+
 	creds = kzalloc(sizeof(struct svc_cred), GFP_KERNEL);
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
-- 
2.53.0

