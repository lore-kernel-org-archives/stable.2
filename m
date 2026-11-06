Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793955900;
	b=0zTo+DFHfkCNytzW5ahBPFVSwZ3vUY7wxNUYlZ0b+Q+FCfqmlYpncoHSq6T8LyQ24Nct
	 bFvViW7l1dHxc4XG8WrsZS0VLF9WqUBdr1ASUaFfpWtzu5DZPVCf91MFKfFkWNxlc2q8j
	 XIqvgmQ3Pku0FTYyybGnZq2+QkT1JyT1r3YTlyddjOhG0pRCOm6/jqL8z+1z87Xmk9KOY
	 fdi9u0uOayN6/+Imp7xuNSfazBxZZ14aiLiStEkZujV+uYe4pjztwDMM48rtAOMxUrZno
	 weFOkgL5crxGxehqM5TBZMX0vffuAlQqUktwLJr9k6OokAuGtBVLRnMv1KOM3tUTmlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955900;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qT+CO1ROEeD8xYhFaFdRagN6Eagy/YoQJaHT5lWNYnU=;
	b=e9g7L0/HtY1SLNQ8h3F78DSzwpH/TUyUUA8RXdfeq69afNBNgq2Zlo6mJcpXREDWsn+c
	 W1VP6XGjdoqsH39KByRi9ff/lGE5r5pdbKcxvx+BIfl46OAltNrrFqaTTrAkQivK/j9Nk
	 CJjWJ/PjwFqq95hIJdngQRB3uC5+8B7J3Unt/hNWuI/qD9weXa7S2iC/xUb3Pdu3ni9th
	 MqHS59kURDw7tPrddftj4BSAXkWRaua8gXBYnQwvsyt+dh87+eK/4axgyDuXm/8rMVFl9
	 dOrdpKgXqdrqF5pdIoqELGu3cCtIE76V3swVjLchffHInZQDQTsqCyHZTS9ZXcRWUpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UP6BVeMQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912A606A326;
	Fri,  6 Nov 2026 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UP6BVeMQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793955899;
	b=oB/QY+Twf7ojXQIw1F874QykmP79dBheCUKaLOST4To+L+vBf98MTReTHVBnmMqSoJ3a
	 AlSMCFAgsA9y84THnhSpGZ3ONJRxAsGziKsVs4GbVdkb8m8E3DFoIaznHWRz+hbcfPfgY
	 wDPXyKJ/G7UJdppBI+HNOD5yAcp5ghzSalm9uJRQ32ngc/Dx/NovciVSwnPuwb9Joq1XU
	 lAk4Y+2fL3xJSuT9pKaA4FPA36rspHDcBPwEC6jx60IEvAztfaZwQGduwZ1T5bQne2vSX
	 tDhMdw9bT56kpvU+/fgFYC260qE1mklONsywaNd1pfO/+PdpazdIcNZZKOhHHMB4lBQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793955899;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qT+CO1ROEeD8xYhFaFdRagN6Eagy/YoQJaHT5lWNYnU=;
	b=ejrZlZcLwgG7Vjl1Ib/D1X3KnZT4PjzvSDvXrjNp48063jliNQF6Vkrmp5efHIdwRwFS
	 oqBLfD5eRxRCFkhmfsjpTQNdyJQLTp7ozk4c6PvxS+ekLyBiVugJSVNcLDwJeq5+KqPjf
	 ondEKvvx6WYg55KQ8gFYmQGlQNMrrBUFc91fNNGo9Xvnc0qezadHWmALnAYujsqskyaDw
	 RpSGZyZjux/u0QY2x+R+doRXhdWpEIgC6mDeJwp3fHgPLmersFVNSXfZ/fy/IxQGNNmV8
	 QfKKF3qlqzAfVeCCCGz48e6FfuOfjpdYDSAFlJsD4c6UgjD6mXFiHVCmC2bmyyqT26g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3CFEB1F008A1;
	Fri,  6 Nov 2026 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793955899;
	bh=qT+CO1ROEeD8xYhFaFdRagN6Eagy/YoQJaHT5lWNYnU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=UP6BVeMQrXnZ9e7n9eNiUOoZefgA7bnoSPeCticKzRkbs5qvWQ83UoUH/GoanCPr6
	 Ggi+wtftll8RbBHZSZxJcgVr32Q0rMV3eGMcMJtjfXCwb8HNLbYVkxipUBf+50ABwy
	 rcB+qR2Ao/TU0T5jci0iZYf6uUlknv8052eNkxQ0WjjAbQe3+fyJ4rBWqaehXGIcsV
	 gtQZLQwS8vtJY/8MrCz0xh5+LYgghRJ9xbQzB5cNY+CaHhXAIp2kWfvhGeGAWWiAS7
	 yEIJplzLU7tmTsTgq6s8xD1rB5necoWtW/4pT49ev+MY1YageVy6rX9AITL0C+EbMQ
	 yOee1oD3ahcAg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C3A0145B3F;
	Fri,  6 Nov 2026 09:04:58 +0000 (UTC)
From: Sergei Khomenkov via B4 Relay <devnull+shomenkow.gmail.com@kernel.org>
Date: Fri, 06 Nov 2026 12:04:56 +0300
Subject: [PATCH] media: verisilicon: suspend the device before
 unregistering it on remove
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-hantro-remove-v1-1-d0a4678886d7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7TlAPgn0lOqittYc01ohA/HvSc
 QZmGlRkwgqzaMD4UKWSB+hJQDx83lHSNhiMMlZrZeWQNxfJeJYHpfMpRBes0snBaC7GRO//W9b
 eP1YuNu9fAAAA
X-Change-ID: 20261106-hantro-remove-9afbc9b601f9
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Frank Li <Frank.Li@nxp.com>, Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793955898; l=3507;
 i=shomenkow@gmail.com; s=20261104; h=from:subject:message-id;
 bh=xS7oIoyimsaMRzqUpXTDBfcEIedzp94Ticoi5FpW/N4=;
 b=UveIQ1ueDQ9B30eFN2EHpuRf6itGbRtnVmhgM4utBXIjk1hHI0f0mylWYoYHySNVftCf9fxIi
 JL/Cv/6DmByCniakqQ9eDo0+UfNchjMmlWUmP1CQB8cNP+9XSUhhTR4
X-Developer-Key: i=shomenkow@gmail.com; a=ed25519;
 pk=FwuHDVe7aiISDMLmQEcMC+RflEIJ6kEp/ekwznWXmI8=
X-Endpoint-Received: by B4 Relay for shomenkow@gmail.com/20261104 with
 auth_id=1409
X-Original-From: Sergei Khomenkov <shomenkow@gmail.com>
Reply-To: shomenkow@gmail.com
Content-Transfer-Encoding: 7bit

From: Sergei Khomenkov <shomenkow@gmail.com>

The clocks are enabled and disabled by the runtime PM callbacks.
hantro_remove() calls v4l2_device_unregister() and clk_bulk_unprepare()
first and only then pm_runtime_dont_use_autosuspend(), which suspends
an active device right away. By then v4l2_device_unregister() has
cleared the driver data (it points to the v4l2_device, the first member
of struct hantro_dev), so hantro_runtime_suspend() dereferences NULL.

The device is always active at that point: the driver core resumes it
before calling remove(), and its put only starts the 100 ms autosuspend
timer. So every unbind and every module unload, with or without a
decode before it, gives an "Unpreparing enabled" warning for each clock
and then that oops.

Stop runtime PM before the unregister and the unprepare. If runtime PM
is forbidden through sysfs (power/control set to "on"), the device is
still active after that, so disable its clocks and mark it suspended by
hand.

The probe error path unwinds in the same order. It can only hit this if
a job runs between the encoder node registration and a later probe
failure, so it is left for a follow-up.

Found with an LLM coding assistant while porting mainline Linux to a
Rockchip RK3026 board (G1, ID 0x6731); the assistant also drafted this
change. Tested on that board. Without this change, unloading the idle
module (runtime status "suspended") gives the warnings and the oops.
With it, the idle module unloads with no warning or oops, and so it does
right after an H.264 or VP8 decode with the autosuspend delay raised to
10 s through sysfs; the clock enable and prepare counts are back to
their values before the load. The same holds with power/control set to
"on", over three load, decode and unload cycles on one boot. kmemleak
reports nothing after five load, decode and unload cycles. Built with
W=1 with and without CONFIG_PM. Not tested on other SoCs or with a
power domain.

Fixes: 556ab0b2741d ("media: hantro: release runtime resources when device_run fails")
Cc: stable@vger.kernel.org
Signed-off-by: Sergei Khomenkov <shomenkow@gmail.com>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 26e5d5547466..8af47375d471 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1286,10 +1286,16 @@ static void hantro_remove(struct platform_device *pdev)
 	hantro_remove_enc_func(vpu);
 	media_device_cleanup(&vpu->mdev);
 	v4l2_m2m_put(vpu->m2m_dev);
-	v4l2_device_unregister(&vpu->v4l2_dev);
-	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
+	/* Suspend first: v4l2_device_unregister() clears the driver data. */
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
+	/* Runtime PM forbidden through sysfs: the device is still active. */
+	if (IS_ENABLED(CONFIG_PM) && !pm_runtime_status_suspended(vpu->dev)) {
+		clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
+		pm_runtime_set_suspended(vpu->dev);
+	}
+	v4l2_device_unregister(&vpu->v4l2_dev);
+	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
 	reset_control_assert(vpu->resets);
 }
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261106-hantro-remove-9afbc9b601f9

Best regards,
-- 
Sergei Khomenkov <shomenkow@gmail.com>


