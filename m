Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E3478E39
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228018; cv=none; b=ci+/tBb9+j28p8HDG5sApbdO5lFrSMBPdo1kvKOH6bKk48ZxAZDfkTUrHwoSboHIYR4yAhiw6XOJQpE3V68F6xEfMgU95Rd1JO0N6IODDhHAmjZjHAkkKFtx0Jd+XBM59w/yZUrYt17q9AO3L3kqPdvzHhAiV7b3uwa0EOAqB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228018; c=relaxed/simple;
	bh=MdhFm0blhfSRlHO8K4cxd5XbE36omh9VHFlRHjYZFYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stPe7A7M6hnq7g9YsaF5HCOVWLW7GaslAFTtYDHUCuCKTHYYx5yFszRY6bslCoK+VeydAJ2miZdNWTQf6wm9oG6PwT+V2mWDrPpVeYMlYQ3E4l+7kDx/M8YRimT53xMpwNzdpMn55gMPjP9meI+5tth+r15q4/cXjYQwiaYUbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXcaGA8z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXcaGA8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B211F000FF;
	Sat, 12 Sep 2026 15:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789228016;
	bh=yTs2waLp5RzeXoiipnbeu0DHFLXXVEAgbnlappw4FlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VXcaGA8zMSZCI5KRp9jpdjcr90rbt5eVnY+dT+zUERzbMN1nlFlZKjD9rPhjTIUYY
	 tggTXRXnoeNkd6C0d48/FhgSj8MYBqhfab550LceWsC0/Wf8CP8+6NFf7C8V51MtEk
	 xf9Xfg/INitNz9VDTXbkjS3WRNS90RMRbP3MlG1ehKV2H+XunthBgcn6//3cL/3Qfx
	 hEqaFfgpa6O4DcdLobYPEGR4M5NC4tsy9C+TUPsCeh3xc15oWhl8sHkp8l6/K5GMS8
	 iJ2tjQoypSMEtA5Rrj/PVc/AnohFMQLydmtqST8UkBsqmV+UL7gOZdz+GS5CheoWU+
	 ybNMnQIQbo6zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <treding@nvidia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/sysfb: simpledrm: Improve framebuffer-size validation
Date: Sat, 12 Sep 2026 11:46:54 -0400
Message-ID: <20260912154654.3432152-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090919-operation-hull-a6ea@gregkh>
References: <2026090919-operation-hull-a6ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 03f1a3545b721fa7fdadd00080e237519a286a97 ]

Validate the framebuffer size from the firmware against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail probing on errors.

v2:
- remove unused function simplefb_get_validated_int0() (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Cc: <stable@vger.kernel.org> # v5.14+
Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Link: https://patch.msgid.link/20260625094509.157581-2-tzimmermann@suse.de
[ adapted shared drm_sysfb validation changes to the existing local simplefb_get_validated_int0() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 07abaf27315f7..b5df36aea6575 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -54,7 +54,7 @@ static int
 simplefb_get_validated_int0(struct drm_device *dev, const char *name,
 			    uint32_t value)
 {
-	if (!value) {
+	if (!value || value > U16_MAX) {
 		drm_err(dev, "simplefb: invalid framebuffer %s of %u\n",
 			name, value);
 		return -EINVAL;
-- 
2.53.0

