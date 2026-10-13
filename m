Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520851AFE9
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908504; cv=none; b=GnfQPZYhTodEaU6Ab90Hjfff5ngfdTGOVfBDmD5Bll5+CI3ExzhMjJNKBPZlnQZvPzXL3o7gcQ1Bb7WTDLedmEZOCihaZdwZlal50zgUqzGeLEbhVACTR3+5h1kwZhb+Bt7J2c8D8RCGiEcJmlT5yuKHpuObpAvtkdmO5Pz55iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908504; c=relaxed/simple;
	bh=05nVIYE0Nu+byc5KKOVluiJCmgfdMClX0CFMN+Uu4ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqNABfJjaX9pzJH3wymICE613Vxg94rBp4SVPo0NKBFaj70ZR00WKZkG2caRPqcuuYo+gH2mUxNzQlCn9XW/mawYlefTvNYsWy59QpL6QB3XPXdAHneyip/UPRAQYpSRYXyPJNgP3CigySfNMBeYh0gD4TlqG4q+c3pz5Uo5MQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXyXBKw7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXyXBKw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97C21F00898;
	Tue, 13 Oct 2026 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908502;
	bh=cWaxLtXyh5LSdKwJqPkqPZiIRNceuYo4wpSQlXW02RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SXyXBKw75W9KBh47fBpoR9cKNZMrMtNKbsZMaCtwWWydAmZqYFM0/ieMrvkhbj8u5
	 RzulBxE5oKFwrtqfzcyOc6F3jWG7HRfOTSJpDDGftxKHVPTIa4aJlq3cST+3K9eawR
	 NxTJwVuwM4GxLt8hPFXVMoAxBapsKhgLKWFg+kczDnb4KWU0fU5MZjEhQhSH8FEWPJ
	 whgT7F68dLmE15OCgIV2cTOr0hJYXt4q7JK2y2YSSwDa9o/G9R7MOSnHM7lI+YC6Of
	 WTV5alaRB790ecOrPD7/gKZAGz5jVu6eGOiL3hrFyHg5absoQZWAExh4wJLmTpakRV
	 ODVVHWvzlks0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/vc4: Fix firmware reference leak in vc4_drm_bind()
Date: Tue, 13 Oct 2026 12:21:39 -0400
Message-ID: <20261013162126.419852-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013162126.419852-1-sashal@kernel.org>
References: <2026101258-emporium-attempt-639f@gregkh>
 <20261013162126.419852-1-sashal@kernel.org>
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
index 802e716f7dc83..871d4096b74a0 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -357,8 +357,11 @@ static int vc4_drm_bind(struct device *dev)
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

