Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594305;
	b=5EHdRyp8PNtN5DmRRJI1fTyaJWFO+leWEU885LcFR+FUX+Sf75DCR2HuCuL2voarzV44
	 QHnOIccFe2VEgk7iaHKjEeFngbVOFEJHo5dJ0VHexSpQih4aezY9TOP+0kqZ3d0DD1Id1
	 TZSkHMv+tQLP6w0dUacuZB3j80KKno1ryVbCH8mcrkDXxh3J3g2JmhXlfOiXzxiFHz4rB
	 GYipCKNqp8Cco2KuT8HWpECtcKenR7BLFS0+cgMHELuV/gkJGw2bGg5LQaBqgQIf9fUUB
	 84C/hAoXKEUAPoJXvAAWlti9RMk2AAZrwaSf+cpsh2I0tTBzm6nD6O94zKCQbtJ7Q4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594305;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S2hihoaKFCYYWKz4vA6mnJsDS/ZxKlIxLRp0bIN1RiY=;
	b=xNaeqrrTJW0JW8fvh9/Q/xhDPmW1pVK7tO3/8WEeoGasKMNUhcOR4U6Fi/W9fp7rGbH7
	 GnC4l3Mtn6P7V6ohgIbeJ4jjprJExG1qbx/WeAyt6hoVXLWDrG8ZOH9HEX/voZrpoiF7l
	 uqentL9Hrv8X9LlGl7vt8PqsZlWyNuN17nyDL3gvzypQsDj08CkcONHVt8SWdq6RIr4+N
	 0B6iKJuY2VheFqNlIR20n/DE3wagiRR6A/ZbWKc7pLRgcDStbxBFPZqOPqqPR+6DZlA3x
	 sQPb8qqJAdxUtFwPnTYSR0wAhNB+iaAUMoKqZKaYTKAA8ujfeHxokVfCCqp7Mf0Tq5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Vk1eyVYH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4DE606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Vk1eyVYH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE3D1F000C2;
	Wed, 21 Oct 2026 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594305;
	bh=S2hihoaKFCYYWKz4vA6mnJsDS/ZxKlIxLRp0bIN1RiY=;
	h=Subject:To:Cc:From:Date;
	b=Vk1eyVYHFG/4YYd+cVVTGpWKYfG4gVlXZoVtJqGESp5vWpGuLyGO/d/+qfbm7kdgx
	 mmiq7W7dwZPlnlSl0cuXEEnN1iyy3F+7M0XMbfRt8nOrE09zICjrgyZ/vbrPWVKEFQ
	 5n2GM7FJY29LnxmGuUtOQhC89XVqflQMT4certPc=
Subject: FAILED: patch "[PATCH] drm/amdgpu: free the userptr ranges when a CS fails after" failed to apply to 6.12-stable tree
To: Jesse.Zhang@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:46:30 +0200
Message-ID: <2026102130-uncaring-epilepsy-5ad9@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1b4da805a0ba354a549ce07459c871c17dd94fe0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102130-uncaring-epilepsy-5ad9@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

