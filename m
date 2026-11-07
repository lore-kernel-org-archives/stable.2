Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046751;
	b=rLIlKbhAG9/yKOlKJ4CNsumc/tsU+4hX6r5Ud1VXee3I5kkhlMRVHMOeiETuohBGBT3h
	 Zr68JstgM/rqoqEjMqodeUniXQUyDfJLPzJ2UivUWH3Ai8f02pxImyd7QLNERXQ276+F1
	 BiWoi27MtdgLbvwk14iV2g+FM31YGefEADhOCJHeRr5kfnMKuvI34XoZ/1oP6eKIcx+Ov
	 7WCr23TEvbXXPQuUgOYEw7mRt698rVUlpAozQgPe5YLm6ZRguVK+4SEcw+I7ufbUBAVrl
	 28y94HOnmBz7I8rDrBk/Nbdr8hkR8ChhZuoqn9/VoNw39slELqbS7stMJ7h/YORQEpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046751;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cacc0tT6MA9FoltaXGV9f7eDdDR6piLj/63MTxZKQPA=;
	b=Cfl4lF2hSVNlUM3n+ZpK2p7S7qq/X052VuegPSE/NVpfgupOf7wK+hQHkahZA/7U8hrx
	 uj+n/eeKUvTTW352MeCxTfQoFXf4ZG2rWoQVf6jR7z4d/8kuPiyoVctQknHYwtq7S1wMD
	 YCmnRC27DDE6I7XCptfNlrQwCkNfMNPa7riwhFIkzueUN2ScmPK3KBx2ev9f2Cf+qIXCX
	 GJpF7Wj7KMgqNq3V4WTE43fyGT0gkpcZX2+UB5PB5f/b+wMjuae51z2ibL8pMCQrOgb05
	 renVajZ4gpe+RQfK/C7teka+DlW2ZLrugA3iEtmcy7U3ZO2VqnVLFjjxLuRlLc7+6bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXja6TKn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC032606D81B
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXja6TKn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EDB1F008A1;
	Sat,  7 Nov 2026 10:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046750;
	bh=cacc0tT6MA9FoltaXGV9f7eDdDR6piLj/63MTxZKQPA=;
	h=From:To:Cc:Subject:Date;
	b=XXja6TKnPlJHUBifxAgtJ2JSeE2NoMQB0vkU8WLJ0KxXHNhX7YKFj4Nv3tCBUnESF
	 SdD2MfFf5L7rwrPYyrmBmgJuf2tfE40oqNs6R3Ovgb1fmUaUi/3x5BaeFDHTA/xYzf
	 KGdnwioYqGk6LKtdRBhrnYEYB7ElBd4IFzXXGxn/o6dnWa6CaCLQwrq8yll3kHM3ER
	 p5AkDdR2uEGIURDWSuAWuRe7LhLA5AoZLWY6lDKycIFRCfQ3o+Jz4tlnMikTarqY7m
	 ZzNoHx2EDMjsGfRI9V0GrXHtFWBpRnX7Vr5gDnMAoL8hk7D3NFUpv23X3YUf+S5+ft
	 PmYC4HaKp0hZg==
From: Sasha Levin <sashal@kernel.org>
To: abelvesa@kernel.org,
	johan+linaro@kernel.org,
	caleb.connolly@linaro.org,
	andersson@kernel.org,
	abel.vesa@linaro.org,
	abel.vesa@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] soc: qcom: pmic_glink: Fix device access from worker during suspend" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:08 -0500
Message-ID: <20261107051908-failed-6.12-c7c56b6ec077@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c7c56b6ec077cb96657494b8c18c2c78625035b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051908-failed-6.12-c7c56b6ec077@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c7c56b6ec077cb96657494b8c18c2c78625035b1 Mon Sep 17 00:00:00 2001
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 19 Aug 2026 10:23:28 +0300
Subject: [PATCH] soc: qcom: pmic_glink: Fix device access from worker during
 suspend

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
---
 drivers/soc/qcom/pmic_glink_altmode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 13c434f8d03a6..465e5d2316a04 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -451,7 +451,7 @@ static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmod
 	alt_port->mode = mode;
 	alt_port->hpd_state = hpd_state;
 	alt_port->hpd_irq = hpd_irq;
-	schedule_work(&alt_port->work);
+	queue_work(system_freezable_wq, &alt_port->work);
 }
 
 #define SC8280XP_DPAM_MASK	0x3f
@@ -502,7 +502,7 @@ static void pmic_glink_altmode_sc8280xp_notify(struct pmic_glink_altmode *altmod
 		alt_port->tbt_data = *tbt;
 	}
 
-	schedule_work(&alt_port->work);
+	queue_work(system_freezable_wq, &alt_port->work);
 }
 
 static void pmic_glink_altmode_callback(const void *data, size_t len, void *priv)
-- 
2.53.0




