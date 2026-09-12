Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D3C2C237E
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789227217; cv=none; b=gnUuTg/LB1+YpJ9o/tZG+eWONht3ZBBQqVW2In3qMQSZiJyYluu4Y2hbytn5lEuf0YQ7VsPcnGH9tJhmi/uh86nNsGal5ICkANLQ51uuFzSI5WghWf6y1s1mPn5oNZsYaga5cVtn+GFDIJNWi1LTb9ZWq3qCwhHrkU/okVH/2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789227217; c=relaxed/simple;
	bh=7ooQLM/mzalC2cFK9z81LC3H0Po3AhL7ZHhPKUjGAkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auuR6cl+93C68OZ5vweYEuXP0N914eNsL/97tls+IuJbhxTtDO8kZGWGU6lkTBtctO3bkmJzYEl6GLxa2vd+Dy5dxlpV8Uc+nkFbVZYE5jE6KB0x8gHJLfDn2fHtOMkfRTmREBV/R5XXpltbkDMv5qw4XjQMfhcz8zDI2Q0FRMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksp8GtJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksp8GtJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC241F00893;
	Sat, 12 Sep 2026 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789227216;
	bh=+eHDu5cQYGsA63iZ0otjtQ6ANoiJ6P3fo8Qzz3IXL9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksp8GtJTpp93Kps/TvMesiqXsp2d8F1+Jz1kYexLmM9cvrtaN6ch61Jl2TvoOC9/M
	 CTcdai5QJ93/uEIOvChXzIFz5H8QsTeJI1cd2QvOQyheaFTYz0XGTgQpL18BO/1z5v
	 3Tqi3kcQYu8fSTLJ4MfHVvufwMJLYqMDqVYI+tn+2AY1IyoA3hvArcds/oWIeir0IU
	 9u5Xa1O6SHv+KTjHqgGXgHScVHrYStKK/INNblS1mfqVT5ZgtHs8eA9eKW1K9tyDd2
	 CAh4sEmOXMaWjWpleSns4z+tIE3S43KwqWCzkrUAlPF78Atuu/dEcltfmZfA1w2gPC
	 MH4mgT+a+nXyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <treding@nvidia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/sysfb: simpledrm: Improve stride validation
Date: Sat, 12 Sep 2026 11:33:34 -0400
Message-ID: <20260912153334.3234026-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090939-yanking-taekwondo-915c@gregkh>
References: <2026090939-yanking-taekwondo-915c@gregkh>
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
index 30676b1073034..15e763d6c1995 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -694,9 +694,15 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
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
 
 	/*
-- 
2.53.0

