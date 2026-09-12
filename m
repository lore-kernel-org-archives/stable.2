Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACD42CB1C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789227042; cv=none; b=UVSeIAZg4+xiwbpbRqsZXx6Mx7oL2S4leVAFpPMdKTmi202hmCwTBs5d3YwGnJMu6XkfUTVQid4kJ+TdrURKo9D5EKrWwRMze/NoufVTavfOThVXprq5PbrsQxGLLWRMtqcahIae3SafPCkaTmPKK27DXJBB+KD1aQqKskbKbPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789227042; c=relaxed/simple;
	bh=uKSEHybZG4x14X8prSz8MPVwD+sGnjJZ2+kItY5JZaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftHvtvMmWHEXuNflWjftPL1OKmGxvdRBhhKdZn43OJ60yI18zxJsmYI1zP5bhuO6rsh2agJYKKmgyN0lMp34R1ZkmVReAXVFAT0OZawj5PZYC21tVi12W3zYTSvNVKobtEobGl5V2kgGLJSzskMXpic7XYvZZIHv3ZqAJFyW3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOgHvcB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOgHvcB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1CE1F000FF;
	Sat, 12 Sep 2026 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789227040;
	bh=Z7MM5m+t50MDRJ+SFxoFl1bzXrSD9/GwRbV9JKBdsvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dOgHvcB23vd0DUiFHIirMVtWvyJLh44/hSiOwdaLQRvxvZGUAuo8gKFMp4z5FfbfK
	 dSurG6WhUdxBxECDTnYvvWGwyQOVSaVX6pDWzc3EEmpqoSwZIO4bOp57PU62xQNUzs
	 w7BdHEDh6EIsKDHdCMk+3w3ZGO6lWrSfDhsmUP8lg94uUzXwmi5UpxlUirKUVbbvXm
	 gUjbWhzbL6IANn97cKul6PDCLkqYM+ae5QY2XVazkwFUclOgUys7pEB73Fnf9pP+Vl
	 P1Z58K4bfctrvRaNkmc/M9c44N+jMNGbiUIO7vb2I3ahtwvP4ANYLfDcoQ40aMledd
	 h+c/Ci6fVE3XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <treding@nvidia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/sysfb: simpledrm: Improve stride validation
Date: Sat, 12 Sep 2026 11:30:38 -0400
Message-ID: <20260912153038.3190980-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090938-kissing-slacking-a098@gregkh>
References: <2026090938-kissing-slacking-a098@gregkh>
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
index 07abaf27315f7..fb483cbde07d5 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -853,9 +853,15 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
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

