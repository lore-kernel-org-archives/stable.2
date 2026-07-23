Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E6F33C18B;
	Thu, 23 Jul 2026 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821502; cv=none; b=FvqyoxCVzK/OSmjCQfTVWUa1oSxN52q5BN7sa01BOJ4B/ll1xW2jnphulc4OvW2Qrv436QD9bLB3E4TT1qDkKds9y1RoWK5nBGFFfGetCEqvcMpBB8fd6WoN47v3+WaXE3Lv4rbRCMnhS/inKReXJLa1Arm+7l2TgMt1DO+DF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821502; c=relaxed/simple;
	bh=L5WhXl1coFr5/YzoMg+vNwfNEONEjc1zLYItXp/gY4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qKrNLmZp7kCwXHFv41SjgcKMKThfPrMzi5gliUeA7prlTNtPOnOKYLtydzfeWoeZiqdEmTeGWA4CJMu4NL/9KhJ7AvbyF3wjfftW2DE9k3qh9AhFY9Jj6o80rCg538gTaAPfXPZ9C3wfR2ma8BZiyavwV6OTQx7qlHqpCbgUXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPEGYTxO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPEGYTxO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 645A2C2BCB8;
	Thu, 23 Jul 2026 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784821502;
	bh=L5WhXl1coFr5/YzoMg+vNwfNEONEjc1zLYItXp/gY4c=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=GPEGYTxOldo5VZIx/K83wicVN1rclF8m/kuer8lqo3zvBTE0MXNkT97aozzPMOSTb
	 bBYO74oWgjzFCreMnAaskbfPKzIckOBntUpDdfNIgpRNFiU9LfNwzRGTw12BW/y4C0
	 ScmhBOiZivQYk8qbGYWSMIJitDR2Mbk+jsiNuHObc+hf/W08z378IV7vVpR77yrwxI
	 D60k099m1EWvX3ZLpN/SEUoyWKDWr9L1mEPmt/bWsk7d2Gbz4rGFNEXvVr3maIUP69
	 cf4HmdHWgzxRW+bXcm4ivewIvPZAq9rtD0pVqfFC9FNHdtxQ7+vOCtC3Kn+ri6IAas
	 dxPrbNik7koTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB45C531F8;
	Thu, 23 Jul 2026 15:45:02 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Thu, 23 Jul 2026 17:44:56 +0200
Subject: [PATCH] hwmon: (pmbus/core) notify on the hwmon device, not the
 i2c client
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-fix_hwmon_notify_v1-v1-1-5a24c528686d@free.fr>
X-B4-Tracking: v=1; b=H4sIAPc2YmoC/x2MQQqAIBAAvyJ7TlCTpL4SIVFb7iENDSuivycdB
 2bmgYSRMEHHHoiYKVHwBWTFYHKjX5HTXBiUUI0wquYLXdadW/DWh4OW22bJjUY5trrWzSShlHv
 Eov3XfnjfD7qlFTdlAAAA
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784821501; l=1985;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=mvBVaQ/t9TqovxzoIusrFozS/2VXRXLUOR6BEPoWm7A=;
 b=GOwMDFU2EGh4zEkApIoHvh9my2mZaaEDWVKHquKMgbTaCoC9rXGKANGnvQfBbCdPJ6sM0YrCR
 T6H4mq8FnABD1ab9+ILw0N2+RNSYyO8SORzscKRW7XbcD8AD55Oza5J
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

pmbus_notify() calls sysfs_notify() and kobject_uevent() on the i2c
client's kobject, but the alarm attributes live on the hwmon class
device registered by pmbus_do_probe(). Notifying the parent i2c device
is a no-op for both poll(POLLPRI) waiters and udev listeners: the named
attribute does not exist on that kobject.

Notify the hwmon device instead, so poll() wakes up and "change"
uevents fire on the inX_alarm/tempX_alarm attributes when SMBALERT#
reports a fault.

Fixes: f469bde9afd1 ("hwmon: (pmbus/core) Notify hwmon events")
Cc: stable@vger.kernel.org # v6.4+
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Found during the review of the MPQ8646 series (v1):

  https://lore.kernel.org/all/20260723131352.182B61F000E9@smtp.kernel.org/

The sysfs_notify() half is a no-op today: the named attribute does not
exist on the i2c client's kobject. Note the KOBJ_CHANGE uevent source
moves from the i2c device to the hwmon class device, matching what
hwmon_notify_event() does.
---
 drivers/hwmon/pmbus/pmbus_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 3143b9e0316c..0081f16c3a95 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2985,8 +2985,9 @@ static void pmbus_notify(struct pmbus_data *data, int page, int reg, int flags)
 
 		if (reg == sreg && page == spage && (smask & flags)) {
 			dev_dbg(data->dev, "sysfs notify: %s", da->attr.name);
-			sysfs_notify(&data->dev->kobj, NULL, da->attr.name);
-			kobject_uevent(&data->dev->kobj, KOBJ_CHANGE);
+			sysfs_notify(&data->hwmon_dev->kobj, NULL,
+				     da->attr.name);
+			kobject_uevent(&data->hwmon_dev->kobj, KOBJ_CHANGE);
 			flags &= ~smask;
 		}
 

---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260723-fix_hwmon_notify_v1-74e1a94346c1

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


