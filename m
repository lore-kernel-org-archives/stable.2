Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045979;
	b=uIrEjd0pnK6p52w+9MebIx7qHvhDbUbPh0vuR2OC35vDcF2eW31Po/7HwgDy73tSk8UH
	 hqcHVSBX3k4FBDPBjTN1T494kA9zb2xwJIKuXZ2LOZKzhB1rlbsAVsph/SF9Sjvwnu1+d
	 syY9FkcYcBZJvIcOHrGcefWesTjk/QGETxY5FuegI2Ylplqt/HYgKODrOMKU3xGNWGI65
	 fsB25PtwHaaz3LX/B+CVOkpuv+LQ7cG75a1ZlrFq7f/K5XJVOPCWyc5wxpkVN3UUFBG+L
	 eNsv7CzJ8u+yjTPzZLi/2m8eCBWgASuK4vHSm9wapOcbLTNogbDc22fOxVHNcQt3lQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045979;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=J9TL4YBgpQOQHeZoW4ln/hSGfKQf9fwYX1sMPIzv4rQ=;
	b=du+KerPpuh8AbLwI2qJRf4iBbOAekS3cfeTJOG7I2xgc27IhPU6nuU8y57TLtrD/McE3
	 Go2bP52Gpax9dczXGDEdjYp/vl0jBD2fSLe+vf6ONST6iXq2A3HQ098VR7jd6tNfuJLpn
	 9KW0/69rK/zlTbXIOue1GWHoCv/1WwhhSl8E/phMjfcjEJ9O6NaVetsigyPJA13oWDTmh
	 OsVobXuUeUD7+tIuZGOdwZ61NRdGxwYWauICNJjAkrhx2qymfQrBh9MVNm32BbqiJ2j0i
	 /CHGX3QMfwi6WSRHFHAZ25AFrfC/xlg+VqllqQRKF8JN1zQHxm8ZJqaIikoU5bJOvig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0cPKjg2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77829606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0cPKjg2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AD31F0089F;
	Sat,  7 Nov 2026 10:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045979;
	bh=J9TL4YBgpQOQHeZoW4ln/hSGfKQf9fwYX1sMPIzv4rQ=;
	h=From:To:Cc:Subject:Date;
	b=S0cPKjg2VaNyaShwrnXWReX4K4H3VwGdiwEotrNYqjOqxu3pEk3tNIpbCxQBUDw3G
	 Gvv98P2WkOEHJA8EtjJVGXXhGpU+i8IDviVG3aiuJi2bmpQyz+IoJf5kYvUm8Kbljy
	 qR5SaelJShjA32xPEPu8QxxPsjW2ehc3F2tm0Lb181f95a8RRw6pEgI7p1ct7Rx9Se
	 XIJD2SQhezwzn5hZQWIARYdZR80nJ52m/rQ/GGfY2YRKnlae84cqhH1xMpfROjlDM6
	 nURdW1wZ+VKiY8WMoSaDBwlUhcLm5e9YLyrOL0bVabLz/G319FYYBVFkloYhF6kB/P
	 rMLXFMT+PGmkw==
From: Sasha Levin <sashal@kernel.org>
To: abelvesa@kernel.org,
	johan+linaro@kernel.org,
	caleb.connolly@linaro.org,
	andersson@kernel.org,
	abel.vesa@linaro.org,
	abel.vesa@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] soc: qcom: pmic_glink: Fix device access from worker during suspend" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:17 -0500
Message-ID: <20261107050617-failed-6.18-7d0767c5cd87@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7d0767c5cd878707fd6711023731549c83563840
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050617-failed-6.18-7d0767c5cd87@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7d0767c5cd878707fd6711023731549c83563840 Mon Sep 17 00:00:00 2001
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




