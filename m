Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CF351C047
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909577; cv=none; b=XT3jMGHWPF9EgexZVXCSkB3fRcKg0DhvRFNJLnD+eEQ1ihkbNQiYutEgm3CWld0zGOIOnQHMAJG/kdWqZn088KcVjne7GhvNnq/ky3j29azH2DYmV3kcIqGM/HNnlgo7E56pFz0tpKg0Q3d7txA1XojL2NwYIDuXo9BzUETIGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909577; c=relaxed/simple;
	bh=aMdlHivVE24MrjO3cUhU9sukhGwbcUYf5TJ4ocTvuEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbjgaXaRzEI0hz4+pJ79bwoCrEY3ZQ0yyjD5twvDNB/e8L0bAA/Nr62BOZsQTQJ0KRogi5ZQpQL/Es2WmVUedxKjC6OgBNQjGS5trkAZhRnzprpEdQeWvNS5xftLNQA6tRGfc2cnufEtEke7TL2zwiEHSoDynwl5dofEAeAq3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESmWMp6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESmWMp6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12B91F0089A;
	Tue, 13 Oct 2026 16:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909575;
	bh=Y3jKK+DgZTmrCQ6rlhSgG77EeGlvDizMsURvcA5F754=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ESmWMp6ShupfTdrsCBNwsCci40y8PqVvOGlBr6ov8DvF7uu/9bDqm5BvjQumkGsBW
	 xP43QOgcX/VW4T/ysylYn4he5WErMVv63/hoA563we+sEudeZ0/xNaybaWyseM+aYk
	 KBM4wpsirVi5aK5MTLvqQx88p5U/ktAWksxvZX0rHC6wr/k5InMktdfuk+53be/6gO
	 WlL42kLzn70DUT3O8Q3B2Zqh4DXRfQK/e5FcRYIOsWwvelEL4tKXQU9ZtBAJRXU5Ka
	 O8bCntRR2sd5SY7Xye0KAUgLShHrLwM1TP2DhJmzmF+C2uqTQhdLJ6lPdf1GDc5L3k
	 +x2fIYnyvOR9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] drm/vc4: Fix firmware reference leak in vc4_drm_bind()
Date: Tue, 13 Oct 2026 12:39:31 -0400
Message-ID: <20261013163917.466761-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013163917.466761-1-sashal@kernel.org>
References: <2026101258-operator-prior-e880@gregkh>
 <20261013163917.466761-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit b816da5d5df1461446a0a5f3fe2b4948a659a790 ]

The firmware reference obtained via rpi_firmware_get() is leaked when
aperture_remove_all_conflicting_devices() fails, as the error label
returns without putting it. This happens before the firmware is
consumed and put further down in the function.

Put the firmware reference before jumping to err.

Fixes: c406ad5e4a85 ("drm/vc4: Notify the firmware when DRM is in charge")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260916154015.2056797-1-vulab@iscas.ac.cn
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index dd6bd490d4da9..ca6a8f96e461f 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -353,8 +353,11 @@ static int vc4_drm_bind(struct device *dev)
 	}
 
 	ret = aperture_remove_all_conflicting_devices(driver->name);
-	if (ret)
+	if (ret) {
+		if (firmware)
+			rpi_firmware_put(firmware);
 		goto err;
+	}
 
 	if (firmware) {
 		ret = rpi_firmware_property(firmware,
-- 
2.53.0

