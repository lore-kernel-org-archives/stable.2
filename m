Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050120;
	b=boIuSkCzItPeodbJZWO09lBh0k8+Q+OlADKeftZniLS64KryU25DA+rdKMJ2NpSsJU4Y
	 zLjom+Sh2r+sHRK3Z5pBKPnEFYMBvveG9pXII8Yzrn/xB7B60LAqF/DSGyGqlaRYtliV/
	 64jwp63+EEebU/Xl/O9cZ/OFQCTUy9ipYh3qrbh5tci1eBPRZd8pM7fWi6dgkzycAGsKl
	 hLgqXAHDB/vMsxX4TmQHt16tEzjR4IxjE16Ynj69+RS9UNy/ONdOIuLoQmhbgjVPPFfYm
	 +RAJt1dgZWBIY+I8dMrl2CuQflDu2OO7wL3XOhUDQcUZYdGQV/cgx42zNu7+3XZy5zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050120;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gStmxWUA3wSRLQJ735zS9XMWPYc7E8cuDyw3RzRrgMk=;
	b=07ofDz1/9FDnyNmUYPdf+/dYQh9o6Re1aasRi9jfbJ5C8aejXMbxBF9lh12lXctP/Irk
	 dsM/raw8bdU1yughuRZqwdB/14de6Jya6Rs/f0jSjzTrbeJpptLE/EHmeiuK9Dg1MIoru
	 9NsG0LoSFImfrBGsrlmXxLCwvmjDPYSmBuIKXHZG8eiaWCBw6r1fiMVcmoZH6gS8eUxri
	 Hlpea701NptsUSzhzSoV/CSMMul6IXESwSV8TyK1fSFsbW9oMUNig32og7ol9lAWsjDz2
	 MIe6BZMd/pNeOW2pGTlE8yYNDUsG+Nz+92sz58JJzPhNA9ERnCtGHT6myjdSDsb6KLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKR4uuNF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKR4uuNF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BD01F0089F;
	Sat,  7 Nov 2026 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050119;
	bh=gStmxWUA3wSRLQJ735zS9XMWPYc7E8cuDyw3RzRrgMk=;
	h=From:To:Cc:Subject:Date;
	b=EKR4uuNF8ATNxrr47wSvvSslCB0xRi7tNrwtKsSASRDYWcOOcqWdQ2SpX3/WhUS6/
	 dPTvQFuk8GSLip0LCdz7SprMyjXo7H6Yj1guQCecnIfLjuq0uupEC5FlCL63naxAPM
	 AX5kXSuezQyxHPMfE3ej24RgJO8LoFIdSG4gEmllYQI736Ai06qn09WP/u7KGUInmv
	 5opDwjcy6mSj4SeHUxfr109yWKoH8eS+XRQPVJ3EiImxQ2A/DkqEnD0O1y4zUxlmmD
	 dKDg0w2POy/fnkvwjdT/ig6HUMNM21qYL/2NvBZPHBUfWNGyOa/ZDhXEnM80nJ7Lpw
	 Oo+dsnfaU9e0g==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	songl@zju.edu.cn,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: bq27xxx: Ensure poll work is cancelled on remove" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:17 -0500
Message-ID: <20261107061517-failed-5.10-db560f4b1c52@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x db560f4b1c5253853f978385db066220e0c218dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061517-failed-5.10-db560f4b1c52@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From db560f4b1c5253853f978385db066220e0c218dc Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Thu, 3 Sep 2026 08:13:12 +0000
Subject: [PATCH] power: supply: bq27xxx: Ensure poll work is cancelled on
 remove

The di->work poll work is queued from the poll callback itself and from
bq27xxx_external_power_changed(). The cancel_delayed_work_sync() in
bq27xxx_battery_teardown() runs while the power_supply is still
registered, so external_power_changed() can re-arm the work after the
cancel, and it runs after the driver data has been freed.

Register a devm_delayed_work_autocancel() before
devm_power_supply_register(), so on unwind the power_supply is
unregistered first, after which no new external_power_changed()
callback can be dispatched, and the poll work is cancelled only then.
Drop the now-redundant cancel from bq27xxx_battery_teardown().

This issue was found by an in-house static analysis tool.

Fixes: 740b755a3b34 ("bq27x00: Poll battery state")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260903081312.225535-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/bq27xxx_battery.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 4d4809a70b622..cd30993b8a89e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -43,6 +43,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/param.h>
@@ -2234,7 +2235,6 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	};
 	int ret;
 
-	INIT_DELAYED_WORK(&di->work, bq27xxx_battery_poll);
 	ret = devm_mutex_init(di->dev, &di->lock);
 	if (ret)
 		return ret;
@@ -2255,6 +2255,12 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_desc->get_property = bq27xxx_battery_get_property;
 	psy_desc->external_power_changed = bq27xxx_external_power_changed;
 
+	/* Cancel the poll work after the power_supply is unregistered. */
+	ret = devm_delayed_work_autocancel(di->dev, &di->work,
+					   bq27xxx_battery_poll);
+	if (ret)
+		return ret;
+
 	di->bat = devm_power_supply_register(di->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(di->bat))
 		return dev_err_probe(di->dev, PTR_ERR(di->bat),
@@ -2281,8 +2287,6 @@ void bq27xxx_battery_teardown(struct bq27xxx_device_info *di)
 	mutex_lock(&di->lock);
 	di->removed = true;
 	mutex_unlock(&di->lock);
-
-	cancel_delayed_work_sync(&di->work);
 }
 EXPORT_SYMBOL_GPL(bq27xxx_battery_teardown);
 
-- 
2.53.0




