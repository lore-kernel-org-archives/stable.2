Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594299;
	b=qIsHBSpZh9XUttR+CZPoOkpSxA0Z/b9vK1kziqlOHOf45lv1olAtyiWCKEjq1wnOd1hV
	 t5ZdeYW+a8h14Xz1HyEXPDJag+cY9b8zqvZsa6A4ZRrVMALo6DpuHXJZIR5U0fOHNArHN
	 3tP/jxFAwAAjx4uhrRYDC+08LU0x+1T//HDZntnqfZd1uVD+QuTd772acYaZP/gqi86lK
	 O9oft7QmYCxqIkUD3XNmSF9ocO3LweHlzmrCPSfna36zsz4baW3Ix892il5pQ2LIVNizU
	 mqhS+obbpB7UkY96LR4rqe4gZK4Ptuh6/xOY1+1DT5nFRvqcL7BX0hQiyZn1IpRBegg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594299;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eB8NiTbL69tL5od/2b9iUlpcVGJLqkhBT69NKjTXQ80=;
	b=goUsztRemruCqFF48thjUBX3z8t9n5nNCq9dptKt4bv5NbDShvY8bRtTdSml/X3OoysJ
	 Ayw0S/K1ud5lVIoPlfpgDyx43j9daVAR9PWPQ7GAmzv6BOTeGf2czHUo0sFkvDUocjEc6
	 qZfUN8q00cA7ng4dTxJAbL5XxalsJq0+wFp7dst44gsOl22g9eI9bKC3CXaI4FgKcDsJk
	 G3Y90PCuVIfSo2YdLzkoDEnZHF/jex6xOcuL2majOLtbyBcIAOH3hKFMHvUZjproN1OMs
	 blmRJgechuvlq+Hc08K/ooMc54q2SpKmlezhJALhQQTw/YvyTgHbau00ugNzjbY6dOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jnk9EPeF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42744606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jnk9EPeF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933B71F000C1;
	Wed, 21 Oct 2026 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594299;
	bh=eB8NiTbL69tL5od/2b9iUlpcVGJLqkhBT69NKjTXQ80=;
	h=Subject:To:Cc:From:Date;
	b=jnk9EPeFDpyatGCmmSiOeTxHpaq31GXJ7MWf1cIB9fsKp6Q9jeI0JU3s+tpk7qBms
	 h4Oz1UPiJFkGomDiIuAWYoBAudZSQzBgtV2SioVLHGy3OxTE1H+01GGwt9jPbrQKy7
	 evN/yQlr2MG2oDhTUtlzy5JhHjcaPrx/6EkZPGJc=
Subject: FAILED: patch "[PATCH] drm/amdgpu: free the userptr ranges when a CS fails after" failed to apply to 7.2-stable tree
To: Jesse.Zhang@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:46:29 +0200
Message-ID: <2026102129-frying-registry-eb6b@gregkh>
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


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 1b4da805a0ba354a549ce07459c871c17dd94fe0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102129-frying-registry-eb6b@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b4da805a0ba354a549ce07459c871c17dd94fe0 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Fri, 9 Oct 2026 16:05:05 +0800
Subject: [PATCH] drm/amdgpu: free the userptr ranges when a CS fails after
 parser_bos

amdgpu_cs_parser_bos() allocates an HMM range for every userptr entry of
the BO list and looks up the user pages. Those ranges are only freed when
amdgpu_cs_parser_bos() itself fails or when amdgpu_cs_submit() checks
them under the notifier lock. If amdgpu_cs_patch_jobs(),
amdgpu_cs_vm_handling(), amdgpu_cs_sync_rings() or the early part of
amdgpu_cs_submit() fails, nothing frees them: neither
amdgpu_cs_parser_fini() nor amdgpu_bo_list_free() touch e->range.

Each such CS then leaks the range, its hmm_pfns array (8 bytes per page
of the userptr BO) and the BO reference the range holds. An IB on a ring
that patches the CS in place (e.g. VCN) with an unmapped va_start fails
in amdgpu_cs_patch_ibs() and takes this path.

Free the ranges on those error paths. Ranges amdgpu_cs_submit() already
dropped are NULL, so freeing them again is a no-op.

Fixes: fec8fdb54e8f ("drm/amdgpu: fix userptr HMM range handling v2")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c52a9542ed7cfd527feb938bd0accada2ac8d267)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 03b41f803520..ef8a61ce4b1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1431,6 +1431,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_cs_parser parser;
 	int r;
 
@@ -1465,25 +1466,31 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	r = amdgpu_cs_patch_jobs(&parser);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	r = amdgpu_cs_vm_handling(&parser);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	r = amdgpu_cs_sync_rings(&parser);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	trace_amdgpu_cs_ibs(&parser);
 
 	r = amdgpu_cs_submit(&parser, data);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	amdgpu_cs_parser_fini(&parser);
 	return 0;
 
+error_free_user_pages:
+	/* amdgpu_cs_submit() only drops the ranges once it got that far. */
+	amdgpu_bo_list_for_each_userptr_entry(e, parser.bo_list) {
+		amdgpu_hmm_range_free(e->range);
+		e->range = NULL;
+	}
 error_fini:
 	amdgpu_cs_parser_fini(&parser);
 	return r;

