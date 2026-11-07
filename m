Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049685;
	b=MfPz4HMdEjMF4+3v4Ly2y99oWJjuwWV+1Y841QyU/e/za00zUjvzYtDQaTxUlzKe5rJC
	 7D+rf15IRdOme+TNRMmwEH5uN+YhtCCHYv+5onMM9s7uR22XpXk7FihccdfQx30M/09IA
	 aitUKuPQS4OQ5uffVyktbX6AjMfT/Dnisoollf5WFNCwMmbGmUFqFUIcEqMDwMeU57DFO
	 4vpN6E+HIkRllB2aoL3gRDqeOHMRh8wwzanSy5v+jbOHfH5Juj+QDUImDpMjAzPNFWUVz
	 Jx3RCSrkZe+twgVELpLpFlKFK7xuxwV/Uq2UD9homFJUNcJ9K+PtqH2A//mk4jqJShg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049685;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=48Pd2Qebl+zSPHs1VI/fujUHPHoc2zjXrDKEGY612xY=;
	b=iTXVm2alWM0lbqIdX4VAWaB4nptlV4tO6TFjrzgBqmfNKeZn/C+f6xAXqwABlFVqI8w8
	 ACHnrUlTWAXamOEOI8T2M6+BMkiXOzxR4mCNoOjoYYuPYMJZTi/iX0pNnl8HDXiduSsWp
	 rGfaxSSa01Vty11OwZsNl1Njs62wpdUZmMD4IYKQ89ZerHQyCFfWJJy234ZUdQ+M8HW9q
	 bs4OAGizqKCOD/gfqOuaQjAdPe/a4/pqQ/W7zCGVk2s4XVJG/d8K0PjlAl+s42xbOcIHR
	 WWeAYbxPsuABmVXqdXDOQzcGTYVp3hq0W+SEol1v9IAzQLHVo8vkKg7awYJnbtAz1BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+6lntHU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9E606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+6lntHU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E021F008A2;
	Sat,  7 Nov 2026 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049684;
	bh=48Pd2Qebl+zSPHs1VI/fujUHPHoc2zjXrDKEGY612xY=;
	h=From:To:Cc:Subject:Date;
	b=T+6lntHU6nBeOTAr6m1dlVLm4y0+mRRhlwZPIQul3Oo10uHUCy99VP71vQmLBDzpg
	 GJa1fzT3TGt+wB8ZQdlt4DK1qcfKoBUE7YA55nyN25qgGGwGJExoGC54PCRx9opI3/
	 zAWnyPFbyQ823uFDaZfzwIpToRhWVeFCthvug2VSzrQ6UEx1YMI6PNJI4w0XlA/Mn0
	 zrO1hTSouyFKgZtg20YyiOwqog+UqmFKqI4Mio5wa9wE+06mJ7CLF3+xjCjlGjciK8
	 +mKdkl75PanpJG8APkEwC0vKwZjXjUdhvfdNiVp23K8GaLU4X5s8/gt4FWunWls8an
	 sx0f4Ny+tYYOA==
From: Sasha Levin <sashal@kernel.org>
To: me@timdoug.com,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: generic-adc-battery: fix status with no supplier" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:08:03 -0500
Message-ID: <20261107060802-failed-5.15-8ae5a3f40045@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8ae5a3f40045ff486826ed6b6a83e39a0f380073
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060802-failed-5.15-8ae5a3f40045@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8ae5a3f40045ff486826ed6b6a83e39a0f380073 Mon Sep 17 00:00:00 2001
From: Tim Douglas <me@timdoug.com>
Date: Mon, 12 Oct 2026 22:21:53 -0400
Subject: [PATCH] power: supply: generic-adc-battery: fix status with no
 supplier

power_supply_am_i_supplied() returns -ENODEV when no registered power
supply supplies the battery. generic-adc-battery's gab_work() tests this
return value as a boolean, so -ENODEV takes the supplied branch and
reports CHARGING, or NOT_CHARGING if the charge-finished GPIO is asserted,
instead of DISCHARGING.

This was noticed while bringing up an out-of-tree Linux port to the
WikiReader: the driver reported CHARGING on a device powered by two AAA
batteries with no charging hardware.

Only a positive return value indicates an online supplier, so treat zero
and negative returns as discharging.

Fixes: 46cecd130d55 ("power: supply: Fix power_supply_am_i_supplied to return -ENODEV when apropriate")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Douglas <me@timdoug.com>
Link: https://patch.msgid.link/20261013022153.6707-1-me@timdoug.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index f3ca3ebb25333..c8ad3f11e8081 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -130,7 +130,7 @@ static void gab_work(struct work_struct *work)
 	adc_bat = container_of(delayed_work, struct gab, bat_work);
 	status = adc_bat->status;
 
-	if (!power_supply_am_i_supplied(adc_bat->psy))
+	if (power_supply_am_i_supplied(adc_bat->psy) <= 0)
 		adc_bat->status =  POWER_SUPPLY_STATUS_DISCHARGING;
 	else if (gab_charge_finished(adc_bat))
 		adc_bat->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-- 
2.53.0




