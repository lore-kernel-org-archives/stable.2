Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048101;
	b=lZdOb2QoQAuG3FErxzorTGcIraZoQO2QExpM8T6b0Sl3VhIRAIYDi6isJ+4Kck8c+n4Y
	 5y6MZOAO+39mAOSsS4+1uWLBslsS05k3dLvg2UDh7PTJnrn+CF4ps5BEkEnhaDtSCDQTI
	 XIltaFWQG2nsVgdvXNM8rY05S46g7XOcaCTvicPFjawVgz2ZFQKyXH6esNtAql/563ZbN
	 nQG/7uqyeQ55ei40r91NLc6enEy7JBJ5fHeqk3RBoRXuLmkIl2WBg/NYMJb/Qqh0n3iRI
	 z3B+GHRLVRqp3tEB6oVOuUvhmZ5bXQK4dGWWoAb4fUalEMK1oIUw2L+nfazOu99/nNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048101;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qo/ZMp3V1ZYTb9mXAiNql4kAA2rXOvqoFwgSnZquzY8=;
	b=3POcEaOXFQcgSymPDGzNc51ox04k8vYNI5J7fQZxBZPc0HFzXj2raAD5LGajAt5dXffd
	 is9GdXgNGlg/8KCtpf82fMMm8jciivqiLaCSDppn38ZFMmc3t99zWITycFYcJlv/GYWp2
	 DJkZEV/vWrEEtPH3zLzBZ87Xnt0rlisvtAqAwWk2sxI8JOi28Va1uwIQmdZjhlwikoHEI
	 Zby/AtB1qXK/lWx2GfYlZwBtOWy3daLaCoaGDfk5tBf5UkwsNcTMAdEQ5LBOMDNeIznra
	 xDpzL+bx/4Aw7gbZgT06hHh+RrYNwXhFaVjqV8ETaO3/+0DxK7cQCuhHozOH6oIyRQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1hNUdHS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07C606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1hNUdHS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78541F0089F;
	Sat,  7 Nov 2026 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048101;
	bh=qo/ZMp3V1ZYTb9mXAiNql4kAA2rXOvqoFwgSnZquzY8=;
	h=From:To:Cc:Subject:Date;
	b=a1hNUdHSYE9gHy3lzjsnwej+37ayqE+TJr6TnfyJC6YtDV1qYtwv3UvjhgTCS5+at
	 qHnXqxlAPjxIKGNW39F9L5uZVfMlh/wjsohVsOWVR39Zlk+4wI1e81MyN760KvDEEi
	 V1U6FD3o1/J+Gs7us9s9NqIUXggfJEGt1MnKN5uDTfUh1Vynm/mcGXd5plnChNNweA
	 CV/4qCciKByZFWKhI3dFbyyft2VGc29/oC2TQlpeYuMfGvCb8km/RZ/WX27+T3E9yS
	 buNw2QgGQfUAfURFPNRCm89JHPX2mpLAR40Y3GsLJCInPZaAKyDIRpopokOLC4DFkT
	 0MNQkWWvb+k8A==
From: Sasha Levin <sashal@kernel.org>
To: fanwu01@zju.edu.cn,
	songl@zju.edu.cn,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: bq27xxx: Ensure poll work is cancelled on remove" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:39 -0500
Message-ID: <20261107054139-failed-6.1-db560f4b1c52@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x db560f4b1c5253853f978385db066220e0c218dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054139-failed-6.1-db560f4b1c52@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




