Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047342;
	b=NbO/Mn4wgCSAW/Qnske65WxgFc06ua1sGbhkTM0g5sCgpYwesPyuCWCVAyM3ZcQSs5UP
	 lz/YiJ41NIzqTFy7XBZCsCverq8kw034H39qgOp1/WNpQ7rmyn1Wee/za44qDzadbBABD
	 aeGeCrewvcpM+FaK7EteSBPhhv3HYIfjL+8DdLq2l9uFWWOJzt90xGXVUyiCiOd/l/MzC
	 4uc6V4OHpTDnJeGZKrD+QN+0xa9JPYJsitAJGrA3fZ+avgXh4rSrTHFOj4GQoLAcJiv5e
	 st2KmXqGx+LN6TVsRPoU6ivCFp/H/TMGEphQZZUw0QUNbSmOfvXSB8oIe2dUzrupmJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047342;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q1QkQj/st4urDIBaMNEHCwUGB0psdpiANhprPD0AmE4=;
	b=Yy90cfNGaHytf7cXdugGgWJlHHKMR7wC1YGj9qrYCPzTtEZX33EYa2KIn6mhh9sQXXOW
	 MfLb2QeumCvG7bTv34wODxbvZpzoExOsR/SrQfvat5EOngB5SiUFp2hmkwI82s4UuZlMJ
	 Su/4fQHmT/r6LL1xz9/PUw+NzGFD4IL+3+uDMgT8V2bakMeIEk7TawyoDQISFcD+c1i47
	 e5CM/3A/2vDD5t78urgtpM/VeFjdpeFsknfdvuF4AqAZ53S1y2IKvhRXNS38BxCdQ7GEh
	 bg4JXIu+Nzm+u29a1ZF1Y9IOIN3N4+FRDmMkUAmVZQ4CpiiKLzbhzzcw1alHt1A4muw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2ta7vnv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B8E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2ta7vnv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A0F1F0089F;
	Sat,  7 Nov 2026 10:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047341;
	bh=Q1QkQj/st4urDIBaMNEHCwUGB0psdpiANhprPD0AmE4=;
	h=From:To:Cc:Subject:Date;
	b=d2ta7vnv5b0emTr+7s9Xtpg+jZxequWxqCUXp3dGiAKd+4vazmb3+GlFJ9mXOFwSE
	 i8u9WGQn+E3Icd9BWGMbW++eCARUFfiK+A9LibFU8JCJdpYpBhG6VSj/R4rTDeWuj8
	 /XUlKTnJCUTz4uovbyFkeaWEmBQYC81R+7QDwCfyRlVPYqiCLtBKLYAK/yxship152
	 +h0W0LoOXeWBsiW2XFLikrqe8CXnFvuU/90N4DWMnRh7IKyWkbfMKnWxe3vHB0BuNc
	 FRWakIpNTg1oJV1BB97YUey6IhM3Bfdv6NN+6MZ+SF39oUKcPxQSaiHwHa/p72eVv/
	 0a/Afdk5G1yWg==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	songl@zju.edu.cn,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: bq27xxx: Ensure poll work is cancelled on remove" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:00 -0500
Message-ID: <20261107052900-failed-6.6-db560f4b1c52@kernel.org>
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
git cherry-pick -x db560f4b1c5253853f978385db066220e0c218dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052900-failed-6.6-db560f4b1c52@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




