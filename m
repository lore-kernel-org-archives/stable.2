Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F53AE1B4
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669951; cv=none; b=M/CcYm6+BuuwMPgvXmSNFTDlGF+mnUCDE5cSIjxnyF++ZZK+CqRW8CYl6ArHgL1Fp6G1zqjWnCiSU/LILSEeyzKJiPJ0HJmXdFaoF/NBAWOntnxUzywVOsl9ty2cNRIvMSRIhJjJ+shiiIJKR35GrY2TBvPrGCVYWFPHuJQASCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669951; c=relaxed/simple;
	bh=Z825ymmrGFuxeUN7qaVr6NI6h9pWkYbnOdxqFIhNCRc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gLOY1CDbsNe+6AoIYN8aYMTByNZUFqYwWcZTsg2Cpi1J/fPpvt0UnpvnPIjUBJUgwm2nzNKliG6bxItB0GAlQbhyYSSUZGeVQU0JmGc2pb+WOWG3N3HkGm/WLBUilHwzOrDof1tByop8iw3pJc+pajWVvvJyDaDtUQQXgOdUCmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TUERphAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TUERphAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100481F000FF;
	Tue, 29 Sep 2026 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790669950;
	bh=XGOiQSiGqZ05UrtyuokM6dojRkj1DnM6FnEaxYUD2jI=;
	h=Subject:To:Cc:From:Date;
	b=TUERphAyYbAWL0YYyx+AyIY20oPflWZpZ1hotsQKWnQ0Gn8GrxUJ2H8THB2+dNbrG
	 9pF7Vlgxc5g4E1/jU30/sO1JXN7h5/L0/P0eXUiZ5Koe0ZyEpj9buI+ZLnA2ues5k1
	 YP7P+ngfMzoXEqQWmiIBExHORdd2evqR4IwStp74=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix acpi device leak in" failed to apply to 6.6-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:18:57 +0200
Message-ID: <2026092957-surreal-herring-0708@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x a997baa61179b450bd55c4810c7ccfed3b753a54
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092957-surreal-herring-0708@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a997baa61179b450bd55c4810c7ccfed3b753a54 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 09:54:32 +0000
Subject: [PATCH] drm/amdgpu: Fix acpi device leak in
 amdgpu_acpi_enumerate_xcc()

amdgpu_acpi_enumerate_xcc() looks up each XCC ACPI device with
acpi_dev_get_first_match_dev(), which takes a reference to the device.
The reference is dropped with acpi_dev_put() after the XCC info is
initialized, but if the kzalloc_obj() allocation of the XCC info fails
the function returns -ENOMEM without releasing the reference, leaking
the last reference to the ACPI device.

Drop the ACPI device reference on the allocation failure path before
returning.

Fixes: 4d5275ab0b18 ("drm/amdgpu: Add parsing of acpi xcc objects")
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9211ef48b31ec66999cf55e04d0cbc60cd855fd5)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7f5abb03be1b..8b8acf98fdfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1167,8 +1167,10 @@ int amdgpu_acpi_enumerate_xcc(void)
 		}
 
 		xcc_info = kzalloc_obj(struct amdgpu_acpi_xcc_info);
-		if (!xcc_info)
+		if (!xcc_info) {
+			acpi_dev_put(acpi_dev);
 			return -ENOMEM;
+		}
 
 		INIT_LIST_HEAD(&xcc_info->list);
 		xcc_info->handle = acpi_device_handle(acpi_dev);

