Received: from mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3398442903F
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493180; cv=none; b=CZV6O6p3qrwBSEkMvt/GQWe20JhGdFcSkdYO+sov4G+qcDb7RdW4roJgNBOsqqs+FJQ5zIfq7tJ5qB+AxMZwg+00toHeN/+8hl1mvtDujm2VC4lyBSPZRiCOe02q/PcJS1FUF4BSn0c0v0VUygRxKZgiGcBATTjLSXLF3uq1ZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493180; c=relaxed/simple;
	bh=IObySP5kGPDx4B1PIEfAuPC/D06sFocz/fzz4DvddHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHr6drXAtmbNVPm9JjUvDh8gDYHKPzctPy03aaOJb4QquPuN2A+ND14Lpn4x9bpu9JXYjYNQqYjzNY4sInYeO00Ojc3manNhVS2qYhkc1vdOCEShbmEwxdKnPLSB/E9t7245j53eydmJl0CI83Dlrl2WKyDG44v+C++MFkN6Cog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T//im3oM; arc=none smtp.client-ip=91.218.175.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T//im3oM"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IObySP5kGPDx4B1PIEfAuPC/D06sFocz/fzz4DvddHY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789493174; v=1; x=1790097974;
 b=T//im3oMY91OOlQ6SC8Arc87Av+Sx/CPTCA3WXsQZ71m8wZG0wRqlGQ0YE2tj6KDb8mkbCbZ
 5TFIxh0Jy8NFdGQyVRtBvtQ5rHKJ3wY6lUhH1OAK8MVBm8XiLX5kjZ/mBPi0t7sPL8POX14vP99
 ChkkKz/l0xUx4EJ87IUDLsFU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7af38004fbef57db;
	Tue, 15 Sep 2026 17:26:14 +0000
X-Mizu-Trace-ID: 7af38004fbef57db
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>,
	Hugo Baigue <hugobaigue2004@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: asus-wmi: fix use-after-free unregistering kbd_led led
Date: Tue, 15 Sep 2026 17:26:07 +0000
Message-ID: <20260915172608.14234-1-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kbd_led_update_all() registers asus->kbd_led with
devm_led_classdev_register() on the platform device, but kbd_led is
embedded in struct asus_wmi, which asus_wmi_remove() frees at its end.
The driver core calls .remove() before devres_release_all(), so the
deferred devres release runs led_classdev_unregister() on memory that
has already been freed. Whether that faults depends on whether the
slab has been reused in between, which makes the crash on module
unload intermittent and silently corrupts the led classdev state in
the remaining runs.

Unregister the led classdev explicitly in asus_wmi_led_exit(), after
the led workqueue has been destroyed: kbd_led_work can then neither
run nor be queued anymore, since asus_ref.asus is NULL too, so
kbd_led_registered is stable and the classdev can be released while
the memory embedding it is still alive. devm_led_classdev_unregister()
also drops the devres entry, leaving nothing to run at unbind cleanup
time; it warns when no devres entry exists, hence the
kbd_led_registered check.

Fixes: fac55d29581f ("platform/x86: asus-wmi: Add support for multiple kbd led handlers")
Closes: https://lore.kernel.org/all/CAO84+x+P2_xyHP89+nGVSMV6bL+dy0P9=vyEEfZGnFhv0hBNWw@mail.gmail.com
Reported-by: Hugo Baigue <hugobaigue2004@gmail.com>
Tested-by: Hugo Baigue <hugobaigue2004@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: zcode:glm-5.3-flash
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/platform/x86/asus-wmi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a65090429ca7..daf8bd17e638 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2088,6 +2088,18 @@ static void asus_wmi_led_exit(struct asus_wmi *asus)
 
 	if (asus->led_workqueue)
 		destroy_workqueue(asus->led_workqueue);
+
+	/*
+	 * kbd_led is registered lazily by kbd_led_work: now that the
+	 * workqueue is destroyed and asus_ref.asus is NULL, the work can
+	 * neither run nor be queued anymore, furthermore leaving it to
+	 * devres would run the unregister from devres_release_all(),
+	 * after .remove() returned and the struct asus_wmi embedding
+	 * kbd_led has been freed.
+	 */
+	if (asus->kbd_led_registered)
+		devm_led_classdev_unregister(&asus->platform_device->dev,
+					     &asus->kbd_led);
 }
 
 static int asus_wmi_led_init(struct asus_wmi *asus)
-- 
2.47.3

