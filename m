Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047027;
	b=h9UA1vxEdVjXoN8xKg00Yd8qtNDu+USRTsfXTf3XEJxZZspJ6Lz3VoV7h1w+d2EFPUcb
	 Wxc3FZWAU2wpaA8/q4de/LpuHZb6yIBwsaP1jhyrV7vs8Vaj6TLHbfEAW24BJtL4Dwc6S
	 NZg5zKfr3oxf6I9I3ndJev8E0JA9eX2i+MgrtrpaA4Gz2MwrA/bKJ7aeyA1Q4Srg/Il3I
	 z06KNUARb5N/3tbj9DhTiB+wJFM+IhJyTSIQwWmGZB+VyXnlS6ooVmvfTiwi80O1/n1A8
	 DiExZZdUsG7ywN+W0xcmdMrVu2lWsVSWqe47wiFKtSKWJqWzGs5grpJKxhQOHwlACdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047027;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=seNd/RNBBITnnUv90s2AJ9wlkaVuuT0NesMOUGuwvwQ=;
	b=Loe5nPBBfdWUv/YH2Y3+g6Vs1GjhERoYOxs/33t1Kjkb5XasZADzp4MGb/ECNwb3uBUK
	 YzzfvONB+jy1dJc5k3KWc+awPNSe4GPfYhE2NGnF8UoNtYsMIZ86SxDd9o/fIGhuyHI+n
	 Vhdrd7nnSVfxZEI9ZF3myMuNfazAWjuHOChNoxzuunEtcGYzm2M8FDj1c+kfez8L6MsZU
	 YV1UBqn56D612JAZsoawds5sOUn/qzUVij6MCXCEDHT0DQwbadxBO+gPcb5gZihsP5naR
	 fzsjGeBhBMN9JpMU5wzZE1wu5ok17XchUxAmSV5y/3v4U5rYBM/C1gdxMohDpGQd6Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hRrD/hgD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E53606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRrD/hgD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02731F0089F;
	Sat,  7 Nov 2026 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047027;
	bh=seNd/RNBBITnnUv90s2AJ9wlkaVuuT0NesMOUGuwvwQ=;
	h=From:To:Cc:Subject:Date;
	b=hRrD/hgDmjShcpNwdVeecM5hBdajWcRjCVXSf2rp6kulXnVy0Vy8jEgpUOBp0Niyz
	 shP78OcYRMkIaCDJkpWohhRyc2vdk5SpefUhybPQZ2IdwjNcWOfbuHKBeSBWnmwcSK
	 /PepAdg9wFruq7EDGYo6jl8pMHm9G12QAjmKurGLwYKmgKyUb2JPSDvnC85BvLBv91
	 WVdm7HWDcBlEccsp6zURE+IE2XxlUIOhEhCTSKXhRmE2lMHVspHGMJk2WaeNP0rmjY
	 dqsHudSz2nkYv6sWzwahWJxJmni8+Nj2CvJv0g6016HPmK/fL6Zc3cQct1QiFjWLdy
	 7bwo17oir9otw==
From: Sasha Levin <sashal@kernel.org>
To: turbine.bmw@gmail.com,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: qcom_battmgr: Notify charger supplies of online changes" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:45 -0500
Message-ID: <20261107052345-failed-6.12-87fd20da8ca8@kernel.org>
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
git cherry-pick -x 87fd20da8ca8bacdaa9bff5860167f208077dc51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052345-failed-6.12-87fd20da8ca8@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




