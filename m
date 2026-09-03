Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344924D8DB8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449314; cv=none; b=cSTMb68jbKkq+r+ZN+4pzH5Iljhyj8by8x7XpLbGGd0NEmyH41nXoCIFbGWiu1px2hsvpjPNEAmZz+SzU8/oxYIyeF5SPF/HASLxPSY7d2kM01G3haFQ00KxzgRm1uJgRb891gFLykMb/E6D2ysTHBI3FY7RzUzu8V6pOD6Nels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449314; c=relaxed/simple;
	bh=4zGIJ9DBt1qZtmT4qT841xhu/hwOcBfRwX9ikGyRz9g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dmBec7/cMvRh5012qmLRcne7w2qi/rqm3NY+gpCDl/W+cE9hWK0SbE4Zd+Gi5SurwNhYmtLQY/zB8E3wppPhJ4jBFFGUZ2Q1qHvBQ6JvbL1zL8Pa2QpcOpjXAB8KXpNoPN1g0/WYbqn99uyRMc9dcHn6UwEVk4rn9POrdb1cEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YgitJcUY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YgitJcUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D0D1F000E9;
	Thu,  3 Sep 2026 15:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449313;
	bh=Ujy0ZCXYOZkzk6owgaahAZKZp+LUKRwqBHmry5fqx2I=;
	h=Subject:To:Cc:From:Date;
	b=YgitJcUYwdAwuC2LzvE0UUJg8L+gpplNhfYo8IL9mBrnPo0nVA9xmaES3QhZRnJik
	 f2P75pyWTDVMcxJ90xwTEvwEMpQ2DoBt0UPHtZDba3YkbcIBnjj1vv1B6VvfJjVfWC
	 d8wuVyJi7NOF8uH81JwSrbVAv7WcUIXj2i+2N+G0=
Subject: FAILED: patch "[PATCH] power: supply: max17040: propagate register read errors" failed to apply to 6.1-stable tree
To: m13940358460@163.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:00:14 +0200
Message-ID: <2026090314-unplowed-trance-1ff3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 659cc3d8d5ef246263873fce72c8cadeeed073cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090314-unplowed-trance-1ff3@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 659cc3d8d5ef246263873fce72c8cadeeed073cc Mon Sep 17 00:00:00 2001
From: Jianing Li <m13940358460@163.com>
Date: Mon, 27 Jul 2026 14:48:25 +0800
Subject: [PATCH] power: supply: max17040: propagate register read errors

max17040_get_vcell() and max17040_get_soc() ignore errors returned by
regmap_read().  When an I2C transfer fails, the uninitialized register
value is converted and reported to userspace as a valid voltage or state
of charge.  The polling worker can also replace the cached state of charge
with the bogus value and emit a spurious change event.

Propagate read errors through the power supply get_property callback and
keep the last valid cached state of charge when polling fails.

Fixes: c6f4a42de60b ("Add MAX17040 Fuel Gauge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
Link: https://patch.msgid.link/20260727064825.948-1-m13940358460@163.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index e94d53b36aa4..98d34d5f3c80 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -192,8 +192,11 @@ static int max17040_raw_vcell_to_uvolts(struct max17040_chip *chip, u16 vcell)
 static int max17040_get_vcell(struct max17040_chip *chip)
 {
 	u32 vcell;
+	int ret;
 
-	regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
+	ret = regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
+	if (ret)
+		return ret;
 
 	return max17040_raw_vcell_to_uvolts(chip, vcell);
 }
@@ -201,8 +204,11 @@ static int max17040_get_vcell(struct max17040_chip *chip)
 static int max17040_get_soc(struct max17040_chip *chip)
 {
 	u32 soc;
+	int ret;
 
-	regmap_read(chip->regmap, MAX17040_SOC, &soc);
+	ret = regmap_read(chip->regmap, MAX17040_SOC, &soc);
+	if (ret)
+		return ret;
 
 	return soc >> (chip->quirk_double_soc ? 9 : 8);
 }
@@ -261,7 +267,11 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 
 static void max17040_check_changes(struct max17040_chip *chip)
 {
-	chip->soc = max17040_get_soc(chip);
+	int soc;
+
+	soc = max17040_get_soc(chip);
+	if (soc >= 0)
+		chip->soc = soc;
 }
 
 static void max17040_queue_work(struct max17040_chip *chip)
@@ -396,10 +406,16 @@ static int max17040_get_property(struct power_supply *psy,
 		val->intval = max17040_get_online(chip);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = max17040_get_vcell(chip);
+		ret = max17040_get_vcell(chip);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		val->intval = max17040_get_soc(chip);
+		ret = max17040_get_soc(chip);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
 		val->intval = chip->low_soc_alert;

