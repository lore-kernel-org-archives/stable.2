Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16B3B27FB
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246750; cv=none; b=gHkXNtmtltTz/cJO3vJCmDyS0NMPYsxkpQEeGXOwLkRvozPVZXFqvWFOi4t1dxSEn1nn8Wtp2HyzvE1BS32ipCRelse6MNaXLxZ+CSdJQw4h+Hkl2H8ryiWC54jZvqD7cpRNKNwzJwX57RtV3m5pqWX96gF3PJlK0wE6P35taC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246750; c=relaxed/simple;
	bh=q714YL1MJe30WLYdYxtjctqqZd/b6qqXlgrDBXHLRJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8H2fi8YZNtnhhNjiJjsBvg5DC3RaLZi0osSwvH4x7KpRVSBqFPT5Sy48NFXEoB84b7GnbNgHBtcOAKLUv4rAXoa4n1QrVOv5q2EcJmAM10lbu1ovTTMTRAw3j5cLT+eyHOcuNiT0J+WE6E5SuHhfDMmueb1EhX1V0CoBanAoz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0qRw0vC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0qRw0vC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758BE1F00893;
	Sat, 12 Sep 2026 20:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789246749;
	bh=Bp74YD6Ky2EUSdFabFf+/u3MhWyjsrJyVZD9rdYsRig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o0qRw0vCLKKSeITuI1baDIZtijLAzAAyxx4nQThW6CMlj235WShHHsol+Km9ig3S3
	 +gqv4QMxVu9ZElM+PCaVp6iFqS01jmcqaZjX61uPfrHtQcKGx6di9I+wIzAPiTKLuf
	 nKiGTqvcs+MKjPY8BTUDz3cH1/o7Xc/jFI5lxPtjZQS2+a8v1MY6ghgXijTFCbagPF
	 6+4Y/enwOUDGM9IOL1v6iKBp2Wu1wi3VyGNLdC7uLBDNoA4rsOM5p2DdD/pwTckVeY
	 PHr/WSDj0OSbrvZI8MGoLfE/xAmZIg5hVOlXi7up/DayACSaWptPFtbN8IHfUbtO9j
	 ivEnb/x05fTLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <treding@nvidia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/sysfb: simpledrm: Improve framebuffer-size validation
Date: Sat, 12 Sep 2026 16:59:06 -0400
Message-ID: <20260912205907.3933891-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090919-unstylish-evade-283b@gregkh>
References: <2026090919-unstylish-evade-283b@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 18489779fb8aa..c32b328ff510a 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -50,7 +50,7 @@ static int
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

