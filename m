Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AED364927;
	Fri, 18 Sep 2026 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722999; cv=none; b=g1BxRPsIUDLKDzV1jsKoCvhbM40AUAn5+eauOvbXflYIlxuJqafnzI96TtEzcNa+woQ7N07KvbU+VIvRrr+ElMz5Esofg3Mka3LgNuFktyy9tYEArK3KUvCqgaVeH1BqYAdWzXJ37u3M6PHAGtS0Ve17I0klpL62FoUd1QI9r70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722999; c=relaxed/simple;
	bh=7HP5JsYQd16uu9uvZXEXmpVum1FlQW2TA2dhY7SSqXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNOojPVdUyh0OMXM3iBbK3haNq13pCyVWOcO4w3QOpOKi8aCJg7dqmb4Jq7TYwP3goIF6GSJLBJjTV0zaJ8LBZ10g6cvkRzhnAHhSgNH+3cJwZj/N8gabLYRZXdGEK3yJ1gbBU5J95bsl9z/PHMgyclGpA70YCvp8OBbnTLxOAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=jwPsbS9V; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="jwPsbS9V"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 77CB78104E;
	Fri, 18 Sep 2026 11:16:29 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Je7zDcAKGo7s; Fri, 18 Sep 2026 11:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1789722988; bh=7HP5JsYQd16uu9uvZXEXmpVum1FlQW2TA2dhY7SSqXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jwPsbS9V5bBGHGMt9fw9tH7vDhA5qZvqOWQyebY0cn8q+YrqxFNnNNxDPAfvBF5gA
	 /PjFoTkmg5k3Y8KvY0hQKpgp0PMojcgFT0d0D1mWuGBtwcPB9NRmr6qorKKsdZ2qax
	 ie1nTVvm445A7pn2tQ0JWBocYSN8WrcLz3iFdkNNHtpvQXhVHVu6wDRLl2AvSz6yyn
	 fhopmIdPBXnI+M+S1UuqLdZPIEiM/G2zIpmA7DQ2j63OJnT9pDmokBKkwsfjiubFMh
	 WG/6/HJgK1AZW9R5i9Q/5c/fUTmZYZAnWLEGInfdm7zVST7qGLtSrGUB98TiAkky1c
	 5Qd3CgSEWDyQQ==
From: Marco Scardovi <scardracs@disroot.org>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Corentin Chary <corentin.chary@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: asus-wmi: Remove redundant per-device wmi_lock and duplicate rfkill ops
Date: Fri, 18 Sep 2026 11:15:00 +0200
Message-ID: <035f8cc544ebedc31f29bf1918ee54c623147717.1789722252.git.scardracs@disroot.org>
In-Reply-To: <cover.1789722252.git.scardracs@disroot.org>
References: <cover.1789722252.git.scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With all WMI method evaluations serialized globally by asus_wmi_eval_lock
in asus_wmi_evaluate_method_locked(), the per-device wmi_lock in struct
asus_wmi is completely redundant.

Remove wmi_lock from struct asus_wmi, its initialization in
asus_wmi_rfkill_init(), and its manual locking in asus_rfkill_hotplug().

Consequently, asus_rfkill_wlan_set() becomes a simple pass-through to
asus_rfkill_set(), rendering asus_rfkill_wlan_ops identical to
asus_rfkill_ops. Drop asus_rfkill_wlan_set() and asus_rfkill_wlan_ops,
allocating WLAN rfkill devices with &asus_rfkill_ops directly.

Signed-off-by: Marco Scardovi <scardracs@disroot.org>
Reviewed-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/platform/x86/asus-wmi.c | 37 ++-------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9c69b9b24104..9ceaea504e94 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -332,7 +332,6 @@ struct asus_wmi {
 
 	struct hotplug_slot hotplug_slot;
 	struct mutex hotplug_lock;
-	struct mutex wmi_lock;
 	struct workqueue_struct *hotplug_workqueue;
 	struct work_struct hotplug_work;
 
@@ -2245,9 +2244,7 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
 	bool absent;
 	u32 l;
 
-	mutex_lock(&asus->wmi_lock);
 	blocked = asus_wlan_rfkill_blocked(asus);
-	mutex_unlock(&asus->wmi_lock);
 
 	mutex_lock(&asus->hotplug_lock);
 	pci_lock_rescan_remove();
@@ -2449,30 +2446,6 @@ static void asus_rfkill_query(struct rfkill *rfkill, void *data)
 	rfkill_set_sw_state(priv->rfkill, !result);
 }
 
-static int asus_rfkill_wlan_set(void *data, bool blocked)
-{
-	struct asus_rfkill *priv = data;
-	struct asus_wmi *asus = priv->asus;
-	int ret;
-
-	/*
-	 * This handler is enabled only if hotplug is enabled.
-	 * In this case, the asus_wmi_set_devstate() will
-	 * trigger a wmi notification and we need to wait
-	 * this call to finish before being able to call
-	 * any wmi method
-	 */
-	mutex_lock(&asus->wmi_lock);
-	ret = asus_rfkill_set(data, blocked);
-	mutex_unlock(&asus->wmi_lock);
-	return ret;
-}
-
-static const struct rfkill_ops asus_rfkill_wlan_ops = {
-	.set_block = asus_rfkill_wlan_set,
-	.query = asus_rfkill_query,
-};
-
 static const struct rfkill_ops asus_rfkill_ops = {
 	.set_block = asus_rfkill_set,
 	.query = asus_rfkill_query,
@@ -2491,13 +2464,8 @@ static int asus_new_rfkill(struct asus_wmi *asus,
 	arfkill->dev_id = dev_id;
 	arfkill->asus = asus;
 
-	if (dev_id == ASUS_WMI_DEVID_WLAN &&
-	    asus->driver->quirks->hotplug_wireless)
-		*rfkill = rfkill_alloc(name, &asus->platform_device->dev, type,
-				       &asus_rfkill_wlan_ops, arfkill);
-	else
-		*rfkill = rfkill_alloc(name, &asus->platform_device->dev, type,
-				       &asus_rfkill_ops, arfkill);
+	*rfkill = rfkill_alloc(name, &asus->platform_device->dev, type,
+			       &asus_rfkill_ops, arfkill);
 
 	if (!*rfkill)
 		return -EINVAL;
@@ -2571,7 +2539,6 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 	int result = 0;
 
 	mutex_init(&asus->hotplug_lock);
-	mutex_init(&asus->wmi_lock);
 
 	result = asus_new_rfkill(asus, &asus->wlan, "asus-wlan",
 				 RFKILL_TYPE_WLAN, ASUS_WMI_DEVID_WLAN);
-- 
2.55.0
