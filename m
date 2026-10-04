Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1339CCFE
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791112537; cv=none; b=sux3xR5XtwzjGZ+V0PKA5zsVFxno15DQcW0D3hIO7w0TgKh71lOGYKBtt3bBI85Rp/hvz4ym9PhgV+Pua6GzmXlTVlNe2QNakIl+Drk3Q9qYd/R1fl/H/8g95AmIHAnNxDoOpq5jPRubcuBePkiNsfwyD+DNA/TjzrBsP7xO1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791112537; c=relaxed/simple;
	bh=5souf5P8cdCDKNKE8Vfd9AYxuOtIE3Hf7UU1MdVziio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq0AujPseTV77+x+3C1JyhphqbTt+UcHavrRNWJ0U7NMScQvmi5k8Yy3bYqXtBju/+RVoEyh87ctD4ITyJa6CS34GSbRwq1HcWAiCM+dryDEAGmjXt30vnk0yVleDlqw/WG2LcTMFaiy7WQu1zoWHPv4LgHgqDNq+LZJ5pV7hcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4fii7NG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4fii7NG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a7bf792424so317823a91.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 04:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791112535; x=1791717335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tsx+aDb2dwCtUhjqNMOb40F6ukqlNEoo0x6nqwwDid0=;
        b=o4fii7NGfBvUvDI/+fVjIoC9oPfR3VhAO4DFVri39Kd1n6gF5/6YfJJO7gZ0dtRthp
         x/bQ12tMNPP8f4KVMS+2DHVHHY9Y37L7bsdHp+CsS6tsXEF9TOfDThE5HaovGPCmtn0T
         Da/+/jsASYv2s7gt9q7xGRehXeA/X7QL3Ve7leZMH5zyhQNvLcFFjDCj+fdJ2DjsNd3w
         2LAIeak/P/5gbwFN77gZ2z6M6QRWb3R/Dc5+6TsMlZIyekmOpDsBCjeo93yB7Wkjokzr
         2scGZrKu+EdiSBX0C+Ri4bxe0rWBAI44vKM9t2ki029kIebOQWcL/1d3exNTDOcwywPs
         OfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791112535; x=1791717335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tsx+aDb2dwCtUhjqNMOb40F6ukqlNEoo0x6nqwwDid0=;
        b=vQIz1pXWqPSPvw2CtL25AsNGdIrN3swQNvU30/qixoeNSRpOjIBa+1iobsQmYYlDBF
         yhSB66emSiRlPrO/+GoOl6w9IxfnB9XHNkMgz/+W4T87I53jMQCDkYFnRvdS4rotJM9Q
         os2jTBNCJ6PzY7QSPevdlvg9yCO8o3sglV8Bk86oNIOjiCyj4iojMUqa0dgw8f9dK5/v
         5zqBSFUznJXymD8IUVP3bP5ZFoT8aL1kgmqKUz548Dmztt2kcIRTd1HrV9znEesddni4
         xq8KKK6igG1NqM9z/0gcW2hprfjmN5R9QNDVc3sopCGlyd2Q1SpnSfJI+WNyc47X5wPv
         rndQ==
X-Forwarded-Encrypted: i=1; AKwUvBxV+E1iYBO+6AcXugrSrRdDvOhWUqMSEuJdw8mOYC1VePhiEgo34HbXRTgzDQ7y4ECCD1jaK8g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKN4b0EabrPFUU8R69F+9kzV5nvJ7C+XPZnei+r0/JrdFaklrf
	T2FWn+ZhaKVNouYS+/Y0Ewqp8rLh5Lt0KwQchAMN5hQAFAiip2LVDwHL
X-Gm-Gg: AYBFou1JB3ZUEmzo3OTxYuLt8j9hfgMFqHJICX5bqbUIfFOrYGkh8QuFtRMsim2PeQi
	3YL9VNYmVF+1aB9uNkpKwe/wLAXRgxCTMIMcsqQvM70XEh5ksgoiGUC3Oed32T0K5swybvWhIMK
	3QqIV3EtCQ+YfcFpY7/zHqp1lBUk4afSKSEPYhJDDczhi2zew2Vt+FSLpIIYzcOcIvMxyQ6Umou
	Ce6fBF8GbG7RpV3I2gdDOlvi63/KI0CA1W4uDLJGZOJhaz/xy5bZ1rOWVC8gkmCD3Xz+RDLdY+T
	e3AynRlgmnWa9QZyQs1HStT692AcAEZlhvWvTpKDYgrF/czNU0YYEIAxVsR7O0JXkczFVQX9l/A
	5PR2tCFIh9wnU2PoDTFswECDRlPf3eNK1eMo115oobTwsS2OrjeWSzR1Job1zXKAKFxGOyOB91C
	64QSmRmmRfMy+0N02F1JX6k/lNYiyb20SvGKdH3pUIbb2W2trom0wNW3mfFzEr66QsY1k5d6BVG
	uZEgM+HTiYy9LVGedlO2Xc=
X-Received: by 2002:a17:90b:3949:b0:3a4:7d7c:1866 with SMTP id 98e67ed59e1d1-3a787775e3cmr3455592a91.61.1791112534791;
        Sun, 04 Oct 2026 04:15:34 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f73556efsm2776007a12.9.2026.10.04.04.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 04:15:34 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] HID: wacom: serialize mode changes with device removal
Date: Sun,  4 Oct 2026 20:13:26 +0900
Message-ID: <20261004111353.118025-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004111353.118025-1-jinmo44.yang@gmail.com>
References: <20261004111353.118025-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_mode_change_work() takes both siblings' struct wacom out of
wacom_shared and tears down and rebuilds them, holding no reference to
either. wacom_remove() cancels only the work owned by the device being
removed, so a worker owned by the other sibling keeps using this device
after its remove callback returns, and hid_device_remove() then frees
struct wacom along with the driver's devres group.

Reproduced under KASAN on hid.git master (fe2ec83746e5) with a uhid
reproducer that binds a sibling pair, sends a mode-change report and then
closes one sibling's descriptor, 10 boots out of 10:

  BUG: KASAN: slab-use-after-free in wacom_parse_and_register+0x4fa8/0x58e0
  Read of size 8 at addr ffff88800be431f8 by task kworker/0:2/75
  Workqueue: events wacom_mode_change_work
   wacom_parse_and_register+0x4fa8/0x58e0
   wacom_mode_change_work+0x333/0x7e0
   process_one_work+0xa3b/0x19b0
  Allocated by task 11:  devm_kmalloc <- wacom_probe
  Freed by task 82:      devres_release_group <- hid_device_remove,
                         under uhid_char_release <- __x64_sys_close

The same object is also written: wacom_feature_mapping() stores
features->touch_max into it, four bytes at a fixed offset, with the value
taken from a feature report. Closing one sibling's /dev/uhid descriptor is
all it takes, with no privilege, and a reference on the hid_device would
not help: struct wacom is devm_kzalloc() on &hdev->dev.

Serialize mode-change workers with wacom_remove() using a driver-wide
mutex, cancelling the device's own work first so that a worker blocked on
the mutex cannot deadlock removal. wacom_add_shared_data() registers its
devres action inside the group wacom_parse_and_register() opens, so
wacom_remove() clears this device's shared pen or touch pointer under the
mutex and no later worker can pick it up.

The worker also snapshots both shared pointers and returns on a NULL
wacom_wac.shared, because releasing the first sibling's devres can drop
the last reference to the shared data.

Fixes: 4082da80f46a ("HID: wacom: generic: add mode change touch key")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
Applies to hid.git master (fe2ec83746e5). It does not apply to for-next;
see the cover letter.

 drivers/hid/wacom_sys.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 40770affdbde..ecd7b38b1418 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -764,6 +764,7 @@ struct wacom_hdev_data {
 
 static LIST_HEAD(wacom_udev_list);
 static DEFINE_MUTEX(wacom_udev_list_lock);
+static DEFINE_MUTEX(wacom_mode_change_lock);
 
 static bool wacom_are_sibling(struct hid_device *hdev,
 		struct hid_device *sibling)
@@ -2783,22 +2784,32 @@ static void wacom_remote_work(struct work_struct *work)
 static void wacom_mode_change_work(struct work_struct *work)
 {
 	struct wacom *wacom = container_of(work, struct wacom, mode_change_work);
-	struct wacom_shared *shared = wacom->wacom_wac.shared;
+	struct wacom_shared *shared;
+	struct hid_device *pen;
+	struct hid_device *touch;
 	struct wacom *wacom1 = NULL;
 	struct wacom *wacom2 = NULL;
-	bool is_direct = wacom->wacom_wac.is_direct_mode;
+	bool is_direct;
 	int error = 0;
 
-	if (shared->pen) {
-		wacom1 = hid_get_drvdata(shared->pen);
+	mutex_lock(&wacom_mode_change_lock);
+	shared = wacom->wacom_wac.shared;
+	if (!shared)
+		goto out;
+	pen = shared->pen;
+	touch = shared->touch;
+	is_direct = wacom->wacom_wac.is_direct_mode;
+
+	if (pen) {
+		wacom1 = hid_get_drvdata(pen);
 		wacom_release_resources(wacom1);
 		hid_hw_stop(wacom1->hdev);
 		wacom1->wacom_wac.has_mode_change = true;
 		wacom1->wacom_wac.is_direct_mode = is_direct;
 	}
 
-	if (shared->touch) {
-		wacom2 = hid_get_drvdata(shared->touch);
+	if (touch) {
+		wacom2 = hid_get_drvdata(touch);
 		wacom_release_resources(wacom2);
 		hid_hw_stop(wacom2->hdev);
 		wacom2->wacom_wac.has_mode_change = true;
@@ -2808,16 +2819,17 @@ static void wacom_mode_change_work(struct work_struct *work)
 	if (wacom1) {
 		error = wacom_parse_and_register(wacom1, false);
 		if (error)
-			return;
+			goto out;
 	}
 
 	if (wacom2) {
 		error = wacom_parse_and_register(wacom2, false);
 		if (error)
-			return;
+			goto out;
 	}
 
-	return;
+out:
+	mutex_unlock(&wacom_mode_change_lock);
 }
 
 static int wacom_probe(struct hid_device *hdev,
@@ -2916,6 +2928,10 @@ static void wacom_remove(struct hid_device *hdev)
 	cancel_work_sync(&wacom->battery_work);
 	cancel_work_sync(&wacom->remote_work);
 	cancel_work_sync(&wacom->mode_change_work);
+
+	/* A sibling's mode-change work can also access this device. */
+	mutex_lock(&wacom_mode_change_lock);
+
 	timer_delete_sync(&wacom->idleprox_timer);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
@@ -2925,6 +2941,8 @@ static void wacom_remove(struct hid_device *hdev)
 
 	if (wacom->wacom_wac.features.type != REMOTE)
 		wacom_release_resources(wacom);
+
+	mutex_unlock(&wacom_mode_change_lock);
 }
 
 static int wacom_resume(struct hid_device *hdev)
-- 
2.53.0

