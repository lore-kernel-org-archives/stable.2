Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282244;
	b=nu5WaJGnTkqlNzXxP3kDuiRA2w+V+8nc1ngrtI9V+IB3bqtI9iZN3UABA1MbOhXVOaKp
	 z2nkWNGPInspjl2NmJiuiHYKGqv24JmAiEqg4vi8Y2CN/bK2KKe/Mfg2aIHESLnKp6xFj
	 L5zHazVPfUKtTMmMgbtpxqW8J5q2RlfsXDQXgPWW7lhZ4aZyCtDO9698JsG2LEXSEdnEj
	 dmeB9Kwscjajm/THEe/sAohXGEIPaG5ledRr0mrwrxvZXNRiRkSpdEOAwuEhgjCOVgqut
	 bLd5Hq5lB98Cq8vsRNqbf/rJRj6DTEBaoj32Ukucorgg5FLEz+MNh1KGd5lVncE4YdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282244;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/Bi+rSNZacb2g7NTCtXzgsxnkD1lbRTUSMvCp4eNLeE=;
	b=n8VoInm2eOcDUXGCG5k8xpApxVSdQmjxIUepQts0jjOwUBvfY0At5VCaCzIHXctNAjY3
	 IvlMZZVgKYbXhEBe2iwcuyYPd5UPPgmV6N1qyFqG1Mb/wjLXbpDGaFt+CJjGTtywdkzBv
	 KmEtM7otETHxrgUhEwaEGBbwYT6b7egO0BCNmZD+nn+gTwpQr4FdJnm44BnqVxeVoWuAE
	 HVcnY6+GAvFXJa3KOUqpZgI2izxxL0xuypYuaMuoioc9IWo9tjyFzYoRL0HrYVPkeoLtl
	 TTNYerr8AzstVi4Zgudpq9bcggUUwn/eBNAeC/RFgyvGbf9XZZ191c+cMUiFumZ3Vmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZzFgvmQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6484606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZzFgvmQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621981F0089F;
	Tue, 10 Nov 2026 03:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282243;
	bh=/Bi+rSNZacb2g7NTCtXzgsxnkD1lbRTUSMvCp4eNLeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VZzFgvmQSx4iUb4h2ZIKSYf8jFkPIEKFa6Bygu28BVPc0exQ+G7wT/bexJeMNVuVe
	 SXZrlSBJdz2+t/cbTWkSL0WyyELwDfCpzm3Sq0v/Skq7vUGkCYSf1rxUBsHS5bYK4W
	 mO39QyzbeY78OyKcXf+cVyufnTMqhqYOTN96owAEeQ1Rrf5qJUvWiHUf0JCSgT3Ekj
	 vvexAi5LEf5r0egDMuYeJRZ+c89AspPTJqs7335mfDb1R8virR5FHehC/kEOJlKA1A
	 vWaLfn5HDwLsy9tRO+m41iIY0FNrE/9iIXdZMDVIn2d9X/rws7TaP8HB4/syb+4hZa
	 DTMnrI5/rxFlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] soc: qcom: pmic_glink: Fix device access from worker during suspend
Date: Mon,  9 Nov 2026 22:44:01 -0500
Message-ID: <20261110034345.271920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051628-failed-6.12-7d0767c5cd87@kernel.org>
References: <20261107051628-failed-6.12-7d0767c5cd87@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 7d0767c5cd878707fd6711023731549c83563840 ]

For historical reasons, the GLINK smem interrupt is registered with
IRRQF_NO_SUSPEND flag set, which is the underlying problem here, since the
incoming messages can be delivered during late suspend and early
resume.

In this specific case, the pmic_glink_altmode_worker() currently gets
scheduled on the system_wq which can be scheduled to run while devices
are still suspended. This proves to be a problem when a Type-C retimer,
switch or mux that is controlled over a bus like I2C, because the I2C
controller is suspended.

This has been proven to be the case on the X Elite boards where such
retimers (ParadeTech PS8830) are used in order to handle Type-C
orientation and altmode configuration. The following warning is thrown:

[   35.134876] i2c i2c-4: Transfer while suspended
[   35.143865] WARNING: CPU: 0 PID: 99 at drivers/i2c/i2c-core.h:56 __i2c_transfer+0xb4/0x57c [i2c_core]
[   35.352879] Workqueue: events pmic_glink_altmode_worker [pmic_glink_altmode]
[   35.360179] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   35.455242] Call trace:
[   35.457826]  __i2c_transfer+0xb4/0x57c [i2c_core] (P)
[   35.463086]  i2c_transfer+0x98/0xf0 [i2c_core]
[   35.467713]  i2c_transfer_buffer_flags+0x54/0x88 [i2c_core]
[   35.473502]  regmap_i2c_write+0x20/0x48 [regmap_i2c]
[   35.478659]  _regmap_raw_write_impl+0x780/0x944
[   35.483401]  _regmap_bus_raw_write+0x60/0x7c
[   35.487848]  _regmap_write+0x134/0x184
[   35.491773]  regmap_write+0x54/0x78
[   35.495418]  ps883x_set+0x58/0xec [ps883x]
[   35.499688]  ps883x_sw_set+0x60/0x84 [ps883x]
[   35.504223]  typec_switch_set+0x48/0x74 [typec]
[   35.508952]  pmic_glink_altmode_worker+0x44/0x1fc [pmic_glink_altmode]
[   35.515712]  process_scheduled_works+0x1a0/0x2d0
[   35.520525]  worker_thread+0x2a8/0x3c8
[   35.524449]  kthread+0xfc/0x184
[   35.527749]  ret_from_fork+0x10/0x20

The proper solution here should be to not deliver these kind of messages
during system suspend at all, or at least make it configurable per glink
client. But simply dropping the IRQF_NO_SUSPEND flag entirely will break
other clients. The final shape of the rework of the pmic glink driver in
order to fulfill both the filtering of the messages that need to be able
to wake-up the system and the queueing of these messages until the system
has properly resumed is still being discussed and it is planned as a
future effort.

Meanwhile, the stop-gap fix here is to schedule the pmic glink altmode
worker on the system_freezable_wq instead of the system_wq. This will
result in the altmode worker not being scheduled to run until the
devices are resumed first, which will give the controllers like I2C a
chance to resume before the transfer is requested.

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/Z1CCVjEZMQ6hJ-wK@hovoldconsulting.com/
Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
Cc: stable@vger.kernel.org    # 6.3
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260819-b4-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v3-1-169b00e0d9d4@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
[ sashal: adjusted context around mode and HPD assignments due to missing Thunderbolt data handling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index db25f406878b0..f650c8de96394 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -304,7 +304,7 @@ static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmod
 	alt_port->mode = mode;
 	alt_port->hpd_state = hpd_state;
 	alt_port->hpd_irq = hpd_irq;
-	schedule_work(&alt_port->work);
+	queue_work(system_freezable_wq, &alt_port->work);
 }
 
 #define SC8280XP_DPAM_MASK	0x3f
@@ -347,7 +347,7 @@ static void pmic_glink_altmode_sc8280xp_notify(struct pmic_glink_altmode *altmod
 	alt_port->mode = mode;
 	alt_port->hpd_state = hpd_state;
 	alt_port->hpd_irq = hpd_irq;
-	schedule_work(&alt_port->work);
+	queue_work(system_freezable_wq, &alt_port->work);
 }
 
 static void pmic_glink_altmode_callback(const void *data, size_t len, void *priv)
-- 
2.53.0

