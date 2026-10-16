Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6383BB9E0;
	Fri, 16 Oct 2026 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162553; cv=none; b=glkD42oNZ4cG3KIoW3StNdV/ZcKQyVKLeFJrWUedZkmCFjS7J4ad24NHgAtJ2tx0Jo/VHgudc3R+2QRHyuERo3hYHLj0l1U205OjWKMbbSrORKRIoxDuUTpjgAFrRIRLZaDHJeP+VbObd5dZ/zTp4h5wBBXJrLJSh+vne8PGFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162553; c=relaxed/simple;
	bh=KsN7Ym5ScGqp7KpuK3hYa5GAaiNMJsK+9n3FnYHTCjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xk5oV3cTfdhohN2QeXIiEoh8rEyUWrYlig8H0a8YaP23q8TH523t+5QF+9EvAIpUG0j4I56RUwLJzb1V+20Rn8kwKt02NGZg6w3o5sUTHD80vxvaywMHH5MHVzqlhhlea9SsTLV1DI7MrbeKnf4Z+2xHJiT9sQrCHx/F6SdVeDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsDAa5UI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsDAa5UI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EC9AC2BCF4;
	Fri, 16 Oct 2026 14:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792162552;
	bh=KsN7Ym5ScGqp7KpuK3hYa5GAaiNMJsK+9n3FnYHTCjI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RsDAa5UI5CNO1RWr4xKERpCyXa//HzMrrw7alQbGQzYd7mB8HF7ozPm7MNlVLGHT5
	 oFivKL/f7907sQrPGW8xzbA45yRvn2G1RtZbMFO7PgcKJM6KRlyBWXuACTe6fJ4F9M
	 +YWHJlkXai9nXDp7Um0DxEiMg+KHIC2Z5vaO0hFdN0PUr7MDy+pKYUaeui2lPe0vq8
	 RoewsbzBPod2LXEsEE/RZ5mht+tWSvmMROS44Fvfisk1hqjiv3hjXvcPJ6P24phUsb
	 A4C3fiIuyQiZ9gkW7BFsNHGhG5cR1PTg5M7zzBp9O5pGT8DZPbD9hCsV843OtYxLLq
	 YR+LEScie72Ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E3ACCA462;
	Fri, 16 Oct 2026 14:55:52 +0000 (UTC)
From: George Neacsu via B4 Relay <devnull+geocausa.gmail.com@kernel.org>
Date: Fri, 16 Oct 2026 15:55:52 +0100
Subject: [PATCH] media: qcom: camss: tpg: Skip the unnamed test pattern
 menu entries
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-camss-tpg-menu-skip-v1-1-0a0a24e36316@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mz3eTE3OJi3ZKCdN3c1LxS3eLszAJd88S0JDMjI0NLU0MjJaDOgqL
 UtMwKsKnRsbW1AGyHUMFlAAAA
X-Change-ID: 20261016-camss-tpg-menu-skip-7afb62219512
To: Bryan O'Donoghue <bod@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, George Neacsu <geocausa@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792162551; l=2642;
 i=geocausa@gmail.com; s=20261015; h=from:subject:message-id;
 bh=EhYu2Sf5sRq8nG4xWwgv19XdQhle1nzxQog9NV/jvME=;
 b=tt6dLw6XGpWAdQXXI+3d+vqV/+tbdo586S1BIMNGL6Zsa2RBHRM2IIigDOaKGR94k1uJCC75Q
 yGavmGxUco2DjWRc9KH797OaEmv7sJCAwxQsdtqb6n9y/Hvo2//WFdz
X-Developer-Key: i=geocausa@gmail.com; a=ed25519;
 pk=KyQk/iWbxsikewDBh0SwlHI51RvAqahD3loqmRp9DVI=
X-Endpoint-Received: by B4 Relay for geocausa@gmail.com/20261015 with
 auth_id=1199
X-Original-From: George Neacsu <geocausa@gmail.com>
Reply-To: geocausa@gmail.com

From: George Neacsu <geocausa@gmail.com>

The gen1 TPG names its test patterns in testgen_payload_modes[], which
is indexed by the hardware payload mode, so entries 3, 4, 7 and 8 are
NULL. The V4L2_CID_TEST_PATTERN menu is created with that array, a
maximum of TPG_PAYLOAD_MODE_NUM_SUPPORTED_GEN1 and no skip mask, so
setting the control to one of the gaps makes
v4l2_ctrl_type_op_validate() dereference a NULL name. The oops leaves
the control handler lock held, and a later rmmod of qcom-camss then
hangs in v4l2_ctrl_handler_free(). v4l2-compliance -m /dev/media0 does
both on X1E80100.

Skip the menu entries that have no name, so the core rejects those
values with -EINVAL and VIDIOC_QUERYMENU leaves them out.

Tested on the Surface Pro 11 (X1E80100) with next-20261015: the menu
lists 0, 1, 2, 5, 6 and 9, setting 3, 4, 7 or 8 returns -EINVAL,
v4l2-compliance -m /dev/media0 completes without an oops, and qcom-camss
unloads and loads again.

Fixes: 51fe835c485b ("media: qcom: camss: tpg: Add TPG support for multiple targets")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: George Neacsu <geocausa@gmail.com>
---
Fix for a NULL dereference in the TPG test pattern control.
---
 drivers/media/platform/qcom/camss/camss-tpg.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-tpg.c b/drivers/media/platform/qcom/camss/camss-tpg.c
index 5764a60fa3..2e80834225 100644
--- a/drivers/media/platform/qcom/camss/camss-tpg.c
+++ b/drivers/media/platform/qcom/camss/camss-tpg.c
@@ -453,7 +453,8 @@ int msm_tpg_register_entity(struct tpg_device *tpg,
 {
 	struct v4l2_subdev *sd = &tpg->subdev;
 	struct device *dev = tpg->camss->dev;
-	int ret;
+	u64 skip_mask = 0;
+	int ret, i;
 
 	v4l2_subdev_init(sd, &tpg_v4l2_ops);
 	sd->internal_ops = &tpg_v4l2_internal_ops;
@@ -470,9 +471,14 @@ int msm_tpg_register_entity(struct tpg_device *tpg,
 		return ret;
 	}
 
+	/* The mode names are indexed by hardware payload mode, skip the gaps */
+	for (i = 0; i <= tpg->testgen.nmodes; i++)
+		if (!tpg->testgen.modes[i])
+			skip_mask |= BIT_ULL(i);
+
 	tpg->testgen_mode = v4l2_ctrl_new_std_menu_items(&tpg->ctrls,
 							 &tpg_ctrl_ops, V4L2_CID_TEST_PATTERN,
-							 tpg->testgen.nmodes, 0, 0,
+							 tpg->testgen.nmodes, skip_mask, 0,
 							 tpg->testgen.modes);
 	if (tpg->ctrls.error) {
 		dev_err(dev, "Failed to init ctrl: %d\n", tpg->ctrls.error);

---
base-commit: b810335a0699d1810683796b0e3ffe8827ddfe6c
change-id: 20261016-camss-tpg-menu-skip-7afb62219512

Best regards,
-- 
George Neacsu <geocausa@gmail.com>


