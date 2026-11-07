Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048251;
	b=QFUiqfuTOuxyHWkLVBC+jOB+wqhAqWhTtOtK7DrRvdkydm8WOjQ7++juGBW3xVv03NoP
	 jdbg9MOVo7AParbrZCvuk69FhksmYBahtNafGqYtGnesM6M5VOZP1SdaG3/GNO7XQ5Z7L
	 8YqasYpYsTPKvtdmuUQtnCNipyN+P99eCjY54Sjgl01LDq2Z9X1aSloNGV7d7XH0nhX62
	 6JYUtfpI+PLu7WjeOJ9QDEIlVsVs0GSykor2tb/pE40j6z36myPZPNTtr/vIEqRHwhFMG
	 2gCcLRsGCRKWAG/Ias169P2sre8UED/krYXk78jh14L5sP4dQ+q6/DPPCszoIegD1Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048251;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tuB697fh6069SoBtET4rDvg+cOg87RD6uYAJvYkIl5o=;
	b=U2rVamTui6rhdLaiZIL2Zy+Qret6UNtq0AjHEIW5VKu+mKdLPNQdP4mIAWOc0pPDC+jx
	 VTEdQ/QRAU2YSlwUl1z9VMn64gFGS0OC5VJcBWjtH2Zfna5RDioU09wiz1tykf4TMnjx/
	 bMC6PLJTZv5GR/kpQmwpetOHbkWqOBVSS4iUbKZuSuvb3hUdeqrBLD4/UYkBrXbqBT2ya
	 KJuYLx0nRFgJgZE2/wsmeSHCjvOMAl9WLI3mQQ7u4DiB/GBwXRoanFtXgIMtj1OLuIkqx
	 xlVIBO9TJS5omfVd9pLQ53LF31bQOMcJnRy7aDoMRZRUv5uJz7OPzL1b/qAGZUIzEcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oX7+0Dol;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D33606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oX7+0Dol
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA8E1F0089F;
	Sat,  7 Nov 2026 10:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048251;
	bh=tuB697fh6069SoBtET4rDvg+cOg87RD6uYAJvYkIl5o=;
	h=From:To:Cc:Subject:Date;
	b=oX7+0DoltOq8cJr6jr522W6u18JQipQtm85jQlbNF97do4zTNQEj4vIwflY3WZVUz
	 I/3t6j06tFZHR9quCZojr/Beoq+J0DMZeOOVj6Rkh2llR8AsyPEcvtlKZxFVjlUZfv
	 1qlaBqt2Eie9haEni09KrNjzELbTIg+LRGtKGq7SwbB8UX58Zw2smq298alKLE6pqj
	 zAd5bQnynCz34pl9cAD4EOEVBMjfwpi4WPJbh0RKlBWcwJmQ7UpDpCLDfKwF/RXyPu
	 z6c3nFN+T01657W1t83lzRYB+kyPuYnlUjl/l19udXQfPFb1W+Oyw8G/hapILkcisQ
	 +RA3vk4rzhpFg==
From: Sasha Levin <sashal@kernel.org>
To: tharitt97@gmail.com,
	benjamin.gaignard@collabora.com,
	nicolas.dufresne@collabora.com,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: hantro: disable runtime PM before hardware teardown" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:44:09 -0500
Message-ID: <20261107054409-failed-6.1-8e26d4c20ed2@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8e26d4c20ed218db6c3123480a4a4e2545680566
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054409-failed-6.1-8e26d4c20ed2@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8e26d4c20ed218db6c3123480a4a4e2545680566 Mon Sep 17 00:00:00 2001
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
Date: Wed, 22 Jul 2026 16:08:19 +0000
Subject: [PATCH] media: hantro: disable runtime PM before hardware teardown

Removing the Hantro driver may trigger an SError on RK3588:
	SError Interrupt on CPU6, code 0x00000000be000011 -- SError
	...
	do_serror+0x5c/0x74
	el1h_64_error_handler+0x34/0x50
	el1h_64_error+0x6c/0x70
	regmap_mmio_read32le+0x10/0x20 (P)
	_regmap_bus_reg_read+0x6c/0xb4
	_regmap_read+0x60/0xdc
	regmap_read+0x4c/0x80
	rockchip_pd_power+0xe4/0x600
	rockchip_pd_power_off+0x1c/0x60
	_genpd_power_off+0x98/0x198
	genpd_power_off.part.0+0x178/0x288
	genpd_runtime_suspend+0x210/0x300
	__rpm_callback+0x48/0x1e0
	rpm_callback+0x74/0x80
	rpm_suspend+0x10c/0x580
	rpm_idle+0x134/0x1b8
	update_autosuspend+0x30/0xc4
	__pm_runtime_use_autosuspend+0x48/0x64
	hantro_remove+0x8c/0xa8 [hantro_vpu]
	...

hantro_remove() currently asserts the device resets before disabling
runtime PM.

Calling pm_runtime_dont_use_autosuspend() causes an idle device to be
runtime-suspended immediately. At that point the Hantro hardware has
already been torn down, while the generic power-domain genpd code
still performs the power-off sequence. genpd regmap_mmio_read causes panic
subsequently because the reset lines were asserted.

Disable runtime PM before asserting the reset lines so that no runtime-PM
transition can race with hardware teardown.

Apply the same ordering to the probe error paths as well.

Fixes: ea71631b7129 ("media: hantro: add support for reset lines")
Cc: stable@vger.kernel.org
Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 7cffbde8ce6e6..26e5d5547466e 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1210,7 +1210,7 @@ static int hantro_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clocks\n");
-		goto err_rst_assert;
+		goto err_pm_disable_assert_reset;
 	}
 
 	ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
@@ -1264,8 +1264,11 @@ static int hantro_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&vpu->v4l2_dev);
 err_clk_unprepare:
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
-err_rst_assert:
+err_pm_disable_assert_reset:
+	pm_runtime_dont_use_autosuspend(vpu->dev);
+	pm_runtime_disable(vpu->dev);
 	reset_control_assert(vpu->resets);
+	return ret;
 err_pm_disable:
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
@@ -1285,9 +1288,9 @@ static void hantro_remove(struct platform_device *pdev)
 	v4l2_m2m_put(vpu->m2m_dev);
 	v4l2_device_unregister(&vpu->v4l2_dev);
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
-	reset_control_assert(vpu->resets);
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
+	reset_control_assert(vpu->resets);
 }
 
 static int hantro_runtime_resume(struct device *dev)
-- 
2.53.0




