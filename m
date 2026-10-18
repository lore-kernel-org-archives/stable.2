Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780749BD85;
	Sun, 18 Oct 2026 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328084; cv=none; b=DqkLxaYnNfTfH1H7bfYj1AWU2IYtmbj+tQPhTUq4B96vvSkFR/SIsGpGEiWi2KGj6y/Jr1cQUBtlD61wXz2vOGhl3ffmk4+eQ94y4/MjuhHu3eqWgM5OatnQwtgfSTkwKRbaDjOi8igBpxN71kmnTaWY2qe6ttJ3LsnWzBakl2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328084; c=relaxed/simple;
	bh=K91a2wxHB4FwHjmzpZ+I8QAbJM+TqaqqZTK9Xz5tEV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O5i6P/nI7ZhSIkxXi5XdHgOsGiUZ6LI0U3c4GUbW9pNZJtD1exa9PEKhIAyaNO+AX8QF7m/3R2WEuimHeFJS4a75U/S394rWKbx1E4idEVI6jIDukWnkGkMYzteqfBMS4SxcZNWK5roMG8vUUjXxdRJvYv91jou3lsFZ0f7pfWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9kBrk8t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9kBrk8t"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1790CC2BCC7;
	Sun, 18 Oct 2026 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792328084;
	bh=K91a2wxHB4FwHjmzpZ+I8QAbJM+TqaqqZTK9Xz5tEV8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=J9kBrk8tRWxqPI1HwKePVInipTv6MAC3dVRAYCerC4PEQn3se0qIBJ0VBCco3x3WS
	 rkw0FAcVni71gmgqZtlYHNG3UHJjuuFCE4xlzf6fMsS/syFoHhm0pKJPs2TsBq5lD1
	 4l3R3h75Dvue8mSM6fSkcekfC78ASbNM7zm0Upmg+8AWVQwnJPy1UCYz/4fCZ2niHf
	 xDYZ6bhXYvpp15E9zk1b/R+qwwTK9R1lO8dSW/eOC9PgIUYM2bW/OZzQcGbwr8el8F
	 n0H5UQFwGPdufLvAA/diJR22uDdVjQ0ZL7/ZYunIYEPoP7O737yZLkaCdQCyL09Khf
	 StEisds+CiEDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CB0CCF2C4;
	Sun, 18 Oct 2026 12:54:43 +0000 (UTC)
From: Wenqiang Zhao via B4 Relay <devnull+berringtoni36.gmail.com@kernel.org>
Date: Sun, 18 Oct 2026 20:54:41 +0800
Subject: [PATCH] media: i2c: imx415: Use target vblank to calculate vmax in
 s_ctrl
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-fix-imx415-vblank-exposure-sync-20261018-v1-1-920383f39185@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJHB1GoC/z2Nyw6CMBBFf4XM2klaRER/hbigdYrjo5AOkBrCv
 1MhcXmSc8+dQSgwCVyzGQJNLNz5BPqQgX00viXke2LIVV5qpSt0HJE/sdAnnMy78S+k2HcyBkL
 5eot/8VKejVKVdUdnIOX6QGm7XdW3nWU0T7LDrw/LsgLwKY07jAAAAA==
X-Change-ID: 20261018-fix-imx415-vblank-exposure-sync-20261018-967b008cf3fb
To: Michael Riesch <michael.riesch@collabora.com>
Cc: linux-kernel@vger.kernel.org, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 stable@vger.kernel.org, Wenqiang Zhao <berringtoni36@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792328082; l=2337;
 i=berringtoni36@gmail.com; s=review-20261018; h=from:subject:message-id;
 bh=VZBNv5G7PV61F4nW8nKw7nfhwmNHgpYp0zx5Th5RsKU=;
 b=y0I4RN8etmVzJc8kZI4ijc+eHURND8vIc9jRpYcBLr/nlkZAZnWI/CvPCnLD8HG9caALmaLkR
 FidvMg+pI78BzJVZVppB4EWgKkv/PIteF/ytW1S2ImWzInv3DcHqyIv
X-Developer-Key: i=berringtoni36@gmail.com; a=ed25519;
 pk=rRiAvRvS4MMqogNnloZgVnqWliVWNDq+PcP6vMYXOvs=
X-Endpoint-Received: by B4 Relay for
 berringtoni36@gmail.com/review-20261018 with auth_id=1226
X-Original-From: Wenqiang Zhao <berringtoni36@gmail.com>
Reply-To: berringtoni36@gmail.com

From: Wenqiang Zhao <berringtoni36@gmail.com>

When setting V4L2_CID_VBLANK, imx415_s_ctrl() writes the new frame length
(format->height + ctrl->val) to the IMX415_VMAX register, and then falls
through to case V4L2_CID_EXPOSURE to update the electronic shutter register
(IMX415_SHR0 = vmax - exposure) so that exposure is preserved across frame
rate changes.

However, in case V4L2_CID_EXPOSURE, vmax is calculated as:
    vmax = format->height + sensor->vblank->cur.val;

Within the V4L2 control framework, sensor->vblank->cur.val holds the
committed old vertical blanking value, which is not updated to the new
value until s_ctrl() returns 0. Consequently, when VBLANK changes, vmax
is calculated from the stale vblank value:
- If VBLANK increases, SHR0 is computed using the smaller old VMAX, causing
  the actual hardware exposure (VMAX - SHR0) to jump by the blanking delta.
- If VBLANK decreases, SHR0 is computed using the larger old VMAX, causing
  the actual hardware exposure to drop by the blanking delta.
- Additionally, ctrl->val is clamped against the stale vmax limit.

Fix this by using sensor->vblank->val instead of sensor->vblank->cur.val,
which holds the target vertical blanking value currently being applied.
When setting V4L2_CID_EXPOSURE directly, sensor->vblank->val equals the
current vblank, keeping behavior unchanged.

Fixes: 3bcae55ab96a ("media: i2c: imx415: Add read/write control of VBLANK")
Cc: stable@vger.kernel.org
Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
---
 drivers/media/i2c/imx415.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
index c3b22b238..e5aa741fc 100644
--- a/drivers/media/i2c/imx415.c
+++ b/drivers/media/i2c/imx415.c
@@ -729,7 +729,7 @@ static int imx415_s_ctrl(struct v4l2_ctrl *ctrl)
 		fallthrough;
 	case V4L2_CID_EXPOSURE:
 		/* clamp the exposure value to VMAX. */
-		vmax = format->height + sensor->vblank->cur.val;
+		vmax = format->height + sensor->vblank->val;
 		ctrl->val = min_t(int, ctrl->val, vmax);
 		ret = cci_write(sensor->regmap, IMX415_SHR0,
 				vmax - ctrl->val, NULL);

---
base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
change-id: 20261018-fix-imx415-vblank-exposure-sync-20261018-967b008cf3fb

Best regards,
--  
Wenqiang Zhao <berringtoni36@gmail.com>


