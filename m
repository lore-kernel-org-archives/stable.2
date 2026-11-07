Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047784;
	b=or2ZWdUkoc7tnTTWoy7XsW4VQCoKYuaC3x6jk3gwFVgk8JJfRyjIN5FiBepwY42xM9O2
	 51iLjwQw9dbhdlLDYEgiz4oE4E3gjpVQ8rxBDOMwK4TJky/S+vvtxQEzjoyK9IqwBnF4f
	 f4yfNqXpjuFPDaJXw9Y6+9CR0u/3CceM0e0vXOK/P+eQE3jXnBwDBhdpvRt6FW8Qhb6J3
	 JRdHxyYYFHFE4AzDPUG6MpUL/LqD0StunGULkoS4G8ZUweUflgmazG8Z2lBHIoI1XjH4g
	 3pP6Vg8A+XDFqhctPBY8ktptkggcY0eUQysazdCwc+wd52F+smoCYRYpV7P1TWh6gBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047784;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1QAX6gpnPxtM1KMnrv9p9+QLzAQI0fBkme5i12tnqyo=;
	b=ik+KICmCOtTJnJXRpA8bs6E1V8Q7mPWVuoVw10zdU0Pu8Ssk48jfyEaEr6RgU3nY2GfZ
	 /lePZ0wgFt85MMx4vDyIai2bkJGNkDnfnfp39nHP9cUPcmXNuOfCtmQ8qABldUbCppMP+
	 L5+6Tll6RJXUPTw98iBkF4rR/nfdet1hv9Yw2h7ubiAE4UGn6jcDEXhHs7uC2zNpPfogk
	 ypGukA9IKKMYSArw6NW435WYIpJ31BZAaKrQfOYWPDN94NOLZYCJLMZFa8SX3BwLdrZKY
	 v3c/XKLD7Jlj7F0CowHwA35/NgMDm2pq5ylikacJOoTExr/zZ/8RyKpe4tz6muGQPrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dj8ynuY9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dj8ynuY9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47A31F0089F;
	Sat,  7 Nov 2026 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047784;
	bh=1QAX6gpnPxtM1KMnrv9p9+QLzAQI0fBkme5i12tnqyo=;
	h=From:To:Cc:Subject:Date;
	b=dj8ynuY906M+/JTywnpxDMgme4ur9jUGBk28iYs7MPGYoDRhMABZI4fjspWKBBc+0
	 FtCMFY3FDq3PL+hRVbmPwdy0RPB6yPc7KVr9BV4fDnD6sDKcluOjmdH1oYvUkai3Mf
	 6SGtXsVm8Tv5Oxc7PtSewJSVpaMPSqoRqIjHWBew6SsPgpxtlv3WQJKhgOC1WqWRvI
	 OBZ0y/hunK37AUm90Q0OJkX7mQZQISKiNL84J45eLVRMEnyK+FDIzuLNCyZHMy97Wr
	 PayDN9e+NZn2ztBLQyLlJW/Y54Rmrj8YCMTm2YwTYFOH8p50DyjMzLxZTfnKINDsOq
	 uWtd9R6I95n0A==
From: Sasha Levin <sashal@kernel.org>
To: turbine.bmw@gmail.com,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: qcom_battmgr: Notify charger supplies of online changes" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:22 -0500
Message-ID: <20261107053622-failed-6.6-87fd20da8ca8@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 87fd20da8ca8bacdaa9bff5860167f208077dc51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053622-failed-6.6-87fd20da8ca8@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 87fd20da8ca8bacdaa9bff5860167f208077dc51 Mon Sep 17 00:00:00 2001
From: Brandon Williams <turbine.bmw@gmail.com>
Date: Tue, 13 Oct 2026 13:34:51 -0400
Subject: [PATCH] power: supply: qcom_battmgr: Notify charger supplies of
 online changes

On SC8280XP and X1E80100 the AC, USB and wireless supplies take their
online state from the charging source in the battery status response.
The firmware sends no notification for those supplies when the charging
source changes, and the driver only announces the battery, so userspace
never learns that the charger was plugged in or out. UPower keeps the
state it read at startup: a laptop booted on the charger never goes on
battery.

Call power_supply_changed() for a supply whose online state changes when
a status response is parsed. A supply that is not registered yet, when
the battery is read during probe, reports its state when it registers.

Tested on a Microsoft Surface Pro 11 (X1E80100): after restarting UPower
on the charger, unplugging now sets OnBattery, and plugging in clears it.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Brandon Williams <turbine.bmw@gmail.com>
Link: https://patch.msgid.link/20261013-upstream-battmgr-charger-online-v1-1-731973e133a0@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/qcom_battmgr.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 3529d4a564ca6..99ae0920f7264 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1255,6 +1255,23 @@ static unsigned int qcom_battmgr_sc8280xp_convert_temp(unsigned int temperature)
 	return DIV_ROUND_CLOSEST(temperature, 10);
 }
 
+/*
+ * The charger supplies' online state comes from the battery status response,
+ * and the firmware sends no notification of its own when it changes, so
+ * announce the change here. A supply that is not registered yet announces its
+ * state when it is.
+ */
+static void qcom_battmgr_sc8280xp_set_online(struct power_supply *psy,
+					     bool *online, bool value)
+{
+	if (*online == value)
+		return;
+
+	*online = value;
+	if (psy)
+		power_supply_changed(psy);
+}
+
 static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 					   const struct qcom_battmgr_message *resp,
 					   size_t len)
@@ -1324,9 +1341,12 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 		battmgr->status.temperature = qcom_battmgr_sc8280xp_convert_temp(le32_to_cpu(resp->status.temperature));
 
 		source = le32_to_cpu(resp->status.charging_source);
-		battmgr->ac.online = source == BATTMGR_CHARGING_SOURCE_AC;
-		battmgr->usb.online = source == BATTMGR_CHARGING_SOURCE_USB;
-		battmgr->wireless.online = source == BATTMGR_CHARGING_SOURCE_WIRELESS;
+		qcom_battmgr_sc8280xp_set_online(battmgr->ac_psy, &battmgr->ac.online,
+						 source == BATTMGR_CHARGING_SOURCE_AC);
+		qcom_battmgr_sc8280xp_set_online(battmgr->usb_psy, &battmgr->usb.online,
+						 source == BATTMGR_CHARGING_SOURCE_USB);
+		qcom_battmgr_sc8280xp_set_online(battmgr->wls_psy, &battmgr->wireless.online,
+						 source == BATTMGR_CHARGING_SOURCE_WIRELESS);
 		if (battmgr->info.last_full_capacity != 0) {
 			/*
 			 * 100 * battmgr->status.capacity can overflow a 32bit
-- 
2.53.0




