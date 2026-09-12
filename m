Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D3282F1F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789227594; cv=none; b=JzmIDHKWr3sXgbZqagxV2d4pVMnVuVgr5HnqT3OA/CxMfLjOyQR24t4bDS3um4O14gc8Ilib1dZgfAzxKyDKrxc4zfEgV6Z7d+4kUd2FL3ElTkr3GOIFFqAQIFHxwQ17EwBpS1cg4voefh3QqtBpgwqi7D9AMUmJK55c0//Y1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789227594; c=relaxed/simple;
	bh=ikJFrdaXEVAPrGxnWcXjH9DZpKPb9RXaeQNYak02PAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji66JtostT2ZI1OnrZiKB+K/ree8r0r+uhqOgBSLrYc7eGZ0c0MPDZ8LrCiVEtNN2PNV8qopgywHAn8CRqGv0nyPLFU8PBOhBE/HN85u3jzlGGsmQfnvSGq4vsWBS2X+SnEMbtt2+tDKGMywmIcRESxeNi6MoZycdBx37T8Y/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyhBFpnR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyhBFpnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6867D1F000FF;
	Sat, 12 Sep 2026 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789227593;
	bh=lhY1CyadawTI/pRiyeEQpQ/PENLIkoBvXJuOFcYu01s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dyhBFpnRxFWlvATvPqo6KD3haBGTJwM6bP7PIkeIFC0CO2EOVLXmVOr6LgnHo49Z1
	 /6V2GSN1t9BCwi0zBXd3GEI1k0gP6Bky0cxe7mkmHiT70Wzf/c2o8ti0E2SJLCoTYd
	 9bRXpa96GbhUVlvepYacWnA/ZWyLkNJrI0HhXQDx5eBu3Uoj49njlEneg4P6Jwzioy
	 4cYXNtzGzeROnX+kIqSutT9AUEMgX8ZCpVE4VqpgNhlVesgLQtfpxBMLQ7llBjo5Gf
	 D4hFNcH7LJM7rb6guwKAYA6G0UYgf2sjoGeiavC8iei+PBDGzyuKlSprsg2vGL2G/9
	 Nw+1Z0/TiMoxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <treding@nvidia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/sysfb: simpledrm: Improve stride validation
Date: Sat, 12 Sep 2026 11:39:50 -0400
Message-ID: <20260912153950.3238234-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090939-outsell-gallantly-799e@gregkh>
References: <2026090939-outsell-gallantly-799e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit df6533f11688aa30be3bb883c7637f4ffdbb7cbd ]

Validate the computed stride against the maximum value INT_MAX.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Fixes: 7bfa5c7b28d6 ("drm/simpledrm: Compute linestride with drm_format_info_min_pitch()")
Cc: <stable@vger.kernel.org> # v6.1+
Link: https://patch.msgid.link/20260625094509.157581-5-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/simpledrm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 18489779fb8aa..4b5ccbb13ecfe 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -693,9 +693,15 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 		return ERR_PTR(-ENODEV);
 	}
 	if (!stride) {
-		stride = drm_format_info_min_pitch(format, 0, width);
-		if (drm_WARN_ON(dev, !stride))
+		u64 pitch = drm_format_info_min_pitch(format, 0, width);
+
+		if (drm_WARN_ON(dev, !pitch)) {
+			return ERR_PTR(-EINVAL); /* driver bug */
+		} else if (pitch > INT_MAX) {
+			drm_warn(dev, "stride of %llu exceeds maximum\n", pitch);
 			return ERR_PTR(-EINVAL);
+		}
+		stride = pitch;
 	}
 
 	sdev->mode = simpledrm_mode(width, height);
-- 
2.53.0

