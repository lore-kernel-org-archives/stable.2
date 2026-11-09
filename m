Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231564;
	b=IACN9Tu3ZKvr2lsMzPqJLs4HpqQOoP5zphTNWZuLyqnE+0fQle4lZnVC7ERmxF5ykDtU
	 iF6e7PUz6Vu9zgx3jPvmt9Wz+P0UjWsTRVmalR58UI/42QbdELqcvRhDI1YhvF3iW/BRw
	 b+5oLA3t6YDjD53iuGed+VSAkzImlGyfOmEJ+4ITOCfgImOylyIuBU0FJP3xn2NF91a44
	 EBVdxt5c3dVeaL664QC4mlWQ/YSnxv/ISV5B31SqCzQPpliSrZv1QfnYu/4pS+Zyx90uK
	 DfSyihCWnLPEsszrRXY7x89OoockQrXNBVYTLD7NNsOXAiZ0/TSpjgByagdrIXOJcdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231564;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9EeOB9u+/9zwiIE4qzGkedjBVs8MINTSV7waj5u02a8=;
	b=Yq7sSmf77rBSBeNK9INfa6gSuy/Ghdj9Fev6j5wkVgQKxLELe02OmdhNOxQt8XGI9pAO
	 wUL0abR0j6eKPymjWnshlm4T64IXnY9Dp/cT5P4WeIFMqz3+KhBOwyTR8gIDMz25LEONw
	 2jIcvwGlph6AY0RNHz4FqmyvIXXTJF1vw56AZTnUpyMELvjd9OjFgbPTaDwBHpkmYJ+k+
	 cmerX146mFA7n2I2a2NSM+PaV8nPfUAyPy1TjPVy9GzJbr8Nq6Ido/FyzgJ3fSBzSRMZM
	 ZM9FtfI9JatVettpFSMjiIjOlPcqeUqqFyNPTs/EwH3i9F0qLqYZYwA3D/KfXViLUpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DM14gBG5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E1606A338;
	Mon,  9 Nov 2026 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DM14gBG5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA6F1F0089F;
	Mon,  9 Nov 2026 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231563;
	bh=9EeOB9u+/9zwiIE4qzGkedjBVs8MINTSV7waj5u02a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DM14gBG5jHclDjY0Pkk4xcff2oUoW6RZHDO7esJ5sBtC7qzKEWaYZc8uci1xgYev3
	 hKVHbinkFf++S9nUWcZoBArAsMp10Xzh8W6vhNvTMVcC33M8aP8j5VTyDhIZuvYqRo
	 gCATQsDjSZdHrUIBFwCyD5SU4tJidgojqcmv10EACY+E/W8aKCiBPr456u23Shb9kj
	 rUqSicm568UvVuQ88/pchRKCr3Nb//3eJGCwgfMDau3/xz3iymFDw7jvSXIvXXo8AZ
	 KW2eXAhfnoWgTDcky61It+3067wjpYiG5bFnoZGdBUksT481mgoSbr6FpAUBoFxwNF
	 1uU9HfqiDXWSA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Ping Cheng <ping.cheng@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.10 3/5] HID: wacom: Fix Use-After-Free in wacom_bamboo_pad
Date: Mon,  9 Nov 2026 13:39:04 +0000
Message-ID: <20261109133911.3026622-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109133911.3026622-1-lee@kernel.org>
References: <20261109133911.3026622-1-lee@kernel.org>
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

[ Upstream commit 3a523ecf9ac3fdd33f5eb31c43937ee44135395b ]

wacom_bamboo_pad_pen_event() accesses wacom->shared->pen locklessly
relative to wacom_remove_shared_data() which nullifies it.  This
can lead to a Use-After-Free if the sibling device is removed while
events are being processed.

Resolve this by introducing RCU protection for pen and touch
pointers:

 - Annotate 'pen' and 'touch' in wacom_shared struct with __rcu.
 - Wrap lockless readers in wacom_bamboo_pad_pen_event() with
   rcu_read_lock() and rcu_dereference().
 - Update writers in wacom_sys.c using rcu_assign_pointer().
 - Use rcu_dereference_protected for comparisons under
   wacom_udev_list_lock.
 - Also use rcu_access_pointer in wacom_sibling_pending() and
   wacom_mode_change_work() to avoid warnings (while lockless access in
   the latter remains a pre-existing issue).

Cc: stable@vger.kernel.org
Fixes: 8c97a765467c ("HID: wacom: add full support of the Wacom Bamboo PAD")
Signed-off-by: Lee Jones <lee@kernel.org>
Acked-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[Lee: Use explicit lock/unlock calls and top-of-block declarations in
      wacom_remove_shared_data() and wacom_bamboo_pad_pen_event() for
      -std=gnu89 compatibility, and adapt to res_wacom]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/wacom_sys.c | 40 ++++++++++++++++++++++++++--------------
 drivers/hid/wacom_wac.c | 14 +++++++-------
 drivers/hid/wacom_wac.h |  4 ++--
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 94e12c56e040..465d075d16f9 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -882,15 +882,22 @@ static void wacom_remove_shared_data(void *res)
 	struct wacom_wac *wacom_wac = &res_wacom->wacom_wac;
 
 	if (wacom_wac->shared) {
+		struct hid_device *touch, *pen;
+
 		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
 				    shared);
 
 		mutex_lock(&wacom_udev_list_lock);
-		if (wacom_wac->shared->touch == res_wacom->hdev) {
-			wacom_wac->shared->touch = NULL;
+		touch = rcu_dereference_protected(wacom_wac->shared->touch,
+						  lockdep_is_held(&wacom_udev_list_lock));
+		pen = rcu_dereference_protected(wacom_wac->shared->pen,
+						lockdep_is_held(&wacom_udev_list_lock));
+
+		if (touch == res_wacom->hdev) {
+			rcu_assign_pointer(wacom_wac->shared->touch, NULL);
 			rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
-		} else if (wacom_wac->shared->pen == res_wacom->hdev) {
-			wacom_wac->shared->pen = NULL;
+		} else if (pen == res_wacom->hdev) {
+			rcu_assign_pointer(wacom_wac->shared->pen, NULL);
 		}
 		mutex_unlock(&wacom_udev_list_lock);
 
@@ -2350,14 +2357,17 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 	}
 
 	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
-		if (wacom_wac->shared->touch == wacom->hdev || !wacom_wac->shared->touch) {
+		struct hid_device *touch =
+			rcu_dereference_protected(wacom_wac->shared->touch,
+						  lockdep_is_held(&wacom_udev_list_lock));
+
+		if (touch == wacom->hdev || !touch) {
 			wacom_wac->shared->type = wacom_wac->features.type;
-			wacom_wac->shared->touch = wacom->hdev;
+			rcu_assign_pointer(wacom_wac->shared->touch, wacom->hdev);
 			rcu_assign_pointer(wacom_wac->shared->touch_input, wacom_wac->touch_input);
 		}
 	} else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN) {
-		/* Pairs with smp_load_acquire() in wacom_sibling_pending() */
-		smp_store_release(&wacom_wac->shared->pen, wacom->hdev);
+		rcu_assign_pointer(wacom_wac->shared->pen, wacom->hdev);
 	}
 }
 
@@ -2373,8 +2383,7 @@ static bool wacom_sibling_pending(struct wacom *wacom)
 		return false;
 
 	if (wacom->wacom_wac.shared) {
-		/* Pairs with smp_store_release() in wacom_set_shared_values() */
-		if (smp_load_acquire(&wacom->wacom_wac.shared->pen))
+		if (rcu_access_pointer(wacom->wacom_wac.shared->pen))
 			return false;
 	}
 
@@ -2844,16 +2853,19 @@ static void wacom_mode_change_work(struct work_struct *work)
 	bool is_direct = wacom->wacom_wac.is_direct_mode;
 	int error = 0;
 
-	if (shared->pen) {
-		wacom1 = hid_get_drvdata(shared->pen);
+	struct hid_device *pen = rcu_access_pointer(shared->pen);
+	struct hid_device *touch = rcu_access_pointer(shared->touch);
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
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 059572ea0509..4c7ad9dc543e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3203,6 +3203,7 @@ static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
 static void wacom_bamboo_pad_pen_event(struct wacom_wac *wacom,
 		unsigned char *data)
 {
+	struct hid_device *pen;
 	unsigned char prefix;
 
 	/*
@@ -3215,13 +3216,12 @@ static void wacom_bamboo_pad_pen_event(struct wacom_wac *wacom,
 	prefix = data[0];
 	data[0] = WACOM_REPORT_BPAD_PEN;
 
-	/*
-	 * actually reroute the event.
-	 * No need to check if wacom->shared->pen is valid, hid_input_report()
-	 * will check for us.
-	 */
-	hid_input_report(wacom->shared->pen, HID_INPUT_REPORT, data,
-			 WACOM_PKGLEN_PENABLED, 1);
+	rcu_read_lock();
+	pen = rcu_dereference(wacom->shared->pen);
+	if (pen)
+		hid_input_report(pen, HID_INPUT_REPORT, data,
+				 WACOM_PKGLEN_PENABLED, 1);
+	rcu_read_unlock();
 
 	data[0] = prefix;
 }
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 957247e6ba1c..56d54ac53b3d 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -287,8 +287,8 @@ struct wacom_shared {
 	unsigned touch_max;
 	int type;
 	struct input_dev __rcu *touch_input;
-	struct hid_device *pen;
-	struct hid_device *touch;
+	struct hid_device __rcu *pen;
+	struct hid_device __rcu *touch;
 	bool has_mute_touch_switch;
 	bool is_touch_on;
 };
-- 
2.56.0.506.g506a7eabc5-goog

