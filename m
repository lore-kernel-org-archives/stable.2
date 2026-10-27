Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091434;
	b=niQSyqer//noyjgy/VwK5yQnERe0S/KtYe+sPCCRpo+SPWhycKywJ7wIkZaX1fo2N1Qg
	 1b1K/BU645pCmguNSmOTDnxna5bEpRT/dt/3IdUCreuf8c1na4REPTxyrsbTIF4mdtXYv
	 Ke4K5VQrNgtyU8fJp+OsPkKC2XtdfyJ0bEmeC4kuC98CBUOrYrSk7hiq9KsVZxMISEQqG
	 UNtS3sGycx0DpbYa0QkcBmvTjt4FQk5/bmHe10caxZAgHaEQzdEtniNmQYNXlbHjbGx2g
	 Du4DZPKmFpoZBnzqsxNVcwlgqY46EIry59ZYB5sGdI2x/veB+42vHEmYONxVVkBeeHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rQvPpajMEW3Pt0vqDNzVq8Uql9PTHirPe5iQ59zrcc0=;
	b=CDoixMMg0Mf/JWDfuXH4iGAtCG/Hwh7GHSiBGTfUiz4EYJa+SREsBoVRjib3qXeO/Wzd
	 DwcKPpb8VOaEkFjKmXjTEcSCANhkffxut8BLabCQ3DfvssoBTj1kYUMC/EqC3BJpnnmfB
	 Ojs5XznS/c1/kg2g9SRwKo4sizkFhGoQ3AHmbvTi27IHBTjCb3RK4IPmWKZesmKNksjb5
	 u+MksFIm3JNW7p1MB5nygTj4ZMncCdnlINq6r4Yk2O6bZDd12UsDf/mt7jPNa5aLv3LPc
	 VzT3GiVPvrOm+zbh0x6r753niNirzrbB8LrZoIeEH7YX7ps/31xEFRjd1Mz77+QggJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Oer+bUen;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C2606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 505C2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Oer+bUen
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so3913318a91.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 01:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793091433; x=1793696233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQvPpajMEW3Pt0vqDNzVq8Uql9PTHirPe5iQ59zrcc0=;
        b=Oer+bUenZvvRQVR1jmGGc8r09Eh5uvcNUQ//3ybQfEqDA245e5l1S5dJJ186dM9pC0
         VnN2CKtc/Cix4HWdkbUTjGrsKTx/W4G3QwS5BWEuHdzMc9E0BqryTFTHXZPHpzThmHMp
         E3hiiw9LRHlEBfKyubWFiG+kP/xVb+Q5BSMYwJHVZg2PXmB9s7niihWx1ZSLgAud2ITU
         1K8vkqBL2/1YeuxbKfB5DTjnRLv7Xl9wyvFyqB2sUVnbXDaGmW1kp5igUyyl06pcVaI5
         /rYcStD14swBtGbA8PnMqCi6p08Cu4zlo8fMCSGrbIOAjbmFBaeKKIPsbgnG1tv8fIVP
         5lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793091433; x=1793696233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rQvPpajMEW3Pt0vqDNzVq8Uql9PTHirPe5iQ59zrcc0=;
        b=c8fVX7CjrhCQMswnOWOBFlxypfEzmhzb5Vjbhh3LEjCFqpKHHfxpAQDkEb1ZPPK+Cz
         n6SM17fvFqjGeDivMCchqMPS+2tBsVFFO9DrsW8wJFG+4jyz7d8sRmTJBLa/B1FsKTcI
         8kLklNzCiYM9uyX6otD32Ad/5211sXqBHPCcPyGJVh9SPMQ1ACegZU463PoNb7+XHP7t
         9ODnYHSnd4FSeVshhYkrm4cexuuEF3n0OZelx4TQEJZDNd60Ru4WGJHhgfOO7EYmDNxt
         2VO+F+RxwDMW28ZrLVwF1Se0gbF/bJcCOdLNm0M+DWAqMKZcFFRR1HN+svz2BLM+MNj+
         2EOw==
X-Forwarded-Encrypted: i=1; AKwUvBytT5c3CU3uAcUYh8K/8K8ZHJ3b5t1DOA4Kduvgviv9J0+gY5m2NApdZzTQI/yV5k5rbQ6ZNfI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1TEothCGDfAf7pnCwc2rHGbJ3ag3H4qMrOHjCcVxF122hj0tm
	3mwnQ1qdLtEwstp7PLMzzYHftLPujIk4Qa6pGZrNxGOmvdoynoCp8qghdDrFIUNx
X-Gm-Gg: AYBFou0/vK7JR9RRm2rGK4mKQLNULEGVoLSWOlp30/az4S7eW0nbhA6LqMzum9NXoZU
	xy32/cYowCVwulZaj9GdbQY7Enn2pOwO2EwYIzsVdbC1XPc6GYpaZ9J1B7J2qXznI4s7Q1SHGxq
	aG8BDgI+KaM1ACTtk+/zzzTx91aqb54Qr/FAJCuYLvMfhDcjpbFsswryKG18PWHqR2WmZpzunZS
	XYCkU2zLxeMJP1LHCu9P9ZOOVqhQt87Bolmjzu8oH9gc/znXfKheoO6ofsUkeMqxy9OGKl5iv5/
	Hq1wa8vVyi4EnoAHoTaGw9HTCIoP8hG2cdZ6If1cadAlYqolCBxCe4loY2esBqOt0jLjZLIOR5y
	DM+lVwLCN2yTWLOZCpnCbgrmcCcl9tiquGJWlxBak6flCkK1KZ2DyXwK8OV2TbZibMVGL3KNjKe
	vbXkCbSSxk1wpixhU9g4d6ImNmJwDPYaMSOGxvVBkFvXzpk8QOF9wiZH1wG2TQeqm3l4QOYpbGm
	alXyDHZs4rdlmgnxfHsqUnciTUmeONAkTspUdXEAIb+bWZrd0be8f37OJqHMRn7lVJkVrpifcdd
	U8hfzvO4GRoFiwQt6LO4VP8IG1IBUoQGsvr3TsMkFtM8hJpZOzR4nbiyX19qhtSaBCgcpd1Zhcy
	YffMMkfXCtPp3e4PsK6M16c4Zm9IOmfc9lxBjdutzmx8XuHUeQFDyKyMrwh00yX5yLrvcRkT+XJ
	eeVA==
X-Received: by 2002:a17:90b:2789:b0:3ac:adce:60be with SMTP id 98e67ed59e1d1-3adeaae6efcmr8052880a91.21.1793091432575;
        Tue, 27 Oct 2026 01:57:12 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066aec8sm2794713a91.15.2026.10.27.01.57.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 01:57:11 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Koichiro Den <koichiro.den@canonical.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH v2] gpio: sim: fix the configfs lockup racing with mkdir/rmdir
Date: Tue, 27 Oct 2026 18:56:53 +1000
Message-ID: <20261027085653.90471-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026060049.60599-1-yuz08559@gmail.com>
References: <20261026060049.60599-1-yuz08559@gmail.com>
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

gpio_sim_device_lockup_configfs() depends (on activation) and undepends
(on deactivation) the leaf configfs entries of a device. It walks
dev->bank_list and bank->line_list without dev->lock, while the lists
are modified and their nodes freed under dev->lock by the configfs
make/release callbacks. It also walks the lists twice, once to depend
and once to undepend, and the two walks can see different entries:

 - A hog created while the device is live is never depended on, but
   it is undepended on deactivation, hitting
   BUG_ON(sd->s_dependent_count < 1) in configfs_undepend_item().
   The following is enough to trigger it:

	mkdir $G/dev $G/dev/bank0 $G/dev/bank0/line0
	echo 1 > $G/dev/live
	mkdir $G/dev/bank0/line0/hog
	echo 0 > $G/dev/live

 - An entry that is being created or removed when the device goes live
   cannot be depended on (the WARN_ON() fires), but it is undepended
   later, hitting the same BUG_ON(). If it has already been unlinked,
   configfs_depend_item_unlocked() dereferences its NULL ci_group.

Toggling "live" while concurrently creating and removing line and hog
directories hits the WARN_ON() and then the BUG_ON() within a second.

Hold the configfs subsystem mutex and dev->lock across the whole live
transition. The subsystem mutex is what configfs holds when it links
and unlinks entries and when it calls the make_group()/make_item()
callbacks, which then take dev->lock, so the lock order is the same.
Record the entries that were actually depended on and undepend exactly
those. If an entry cannot be depended on because it is being created
or removed, undo the dependencies already taken and fail with -EBUSY
instead of warning.

configfs_depend_item_unlocked() and configfs_undepend_item_unlocked()
only take configfs_dirent_lock for an item of the caller's own
subsystem, so calling them under these locks is fine.

Fixes: 8bd76b3d3f3a ("gpio: sim: lock up configfs that an instantiated device depends on")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/gpio/gpio-sim.c | 109 +++++++++++++++++++++++++++++++---------
 1 file changed, 85 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 0c73bec..ad4affc 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -560,6 +560,10 @@ struct gpio_sim_device {
 	struct mutex lock;
 
 	struct list_head bank_list;
+
+	/* Leaf entries depended on while the device is live. */
+	struct config_item **deps;
+	unsigned int num_deps;
 };
 
 static struct gpio_sim_device *to_gpio_sim_device(struct config_item *item)
@@ -974,31 +978,81 @@ static void gpio_sim_device_deactivate(struct gpio_sim_device *dev)
 	gpio_sim_remove_swnode_recursive(swnode);
 }
 
-static void
-gpio_sim_device_lockup_configfs(struct gpio_sim_device *dev, bool lock)
+static void gpio_sim_device_unlock_configfs(struct gpio_sim_device *dev)
+{
+	unsigned int i;
+
+	lockdep_assert_held(&dev->lock);
+
+	for (i = 0; i < dev->num_deps; i++)
+		configfs_undepend_item_unlocked(dev->deps[i]);
+
+	kfree(dev->deps);
+	dev->deps = NULL;
+	dev->num_deps = 0;
+}
+
+static int gpio_sim_device_lockup_configfs(struct gpio_sim_device *dev)
 {
 	struct configfs_subsystem *subsys = dev->group.cg_subsys;
 	struct gpio_sim_bank *bank;
 	struct gpio_sim_line *line;
 	struct config_item *item;
+	unsigned int num = 0;
+	int ret;
+
+	lockdep_assert_held(&subsys->su_mutex);
+	lockdep_assert_held(&dev->lock);
 
 	/*
 	 * The device only needs to depend on leaf entries. This is
 	 * sufficient to lock up all the configfs entries that the
 	 * instantiated, alive device depends on.
+	 *
+	 * dev->lock keeps the bank and line lists stable and the subsystem
+	 * mutex keeps the entries' ci_group stable. An entry that is still
+	 * being created or removed cannot be depended on, in which case the
+	 * device is not brought up. The entries that were actually depended
+	 * on are recorded, so that exactly those are undepended when the
+	 * device goes down.
 	 */
+	list_for_each_entry(bank, &dev->bank_list, siblings)
+		list_for_each_entry(line, &bank->line_list, siblings)
+			num++;
+
+	if (!num)
+		return 0;
+
+	dev->deps = kzalloc_objs(*dev->deps, num);
+	if (!dev->deps)
+		return -ENOMEM;
+
 	list_for_each_entry(bank, &dev->bank_list, siblings) {
 		list_for_each_entry(line, &bank->line_list, siblings) {
 			item = line->hog ? &line->hog->item
 					 : &line->group.cg_item;
 
-			if (lock)
-				WARN_ON(configfs_depend_item_unlocked(subsys,
-								      item));
-			else
-				configfs_undepend_item_unlocked(item);
+			/* Already unlinked by a concurrent rmdir(). */
+			if (!item->ci_group) {
+				ret = -EBUSY;
+				goto err_unlock;
+			}
+
+			ret = configfs_depend_item_unlocked(subsys, item);
+			if (ret) {
+				ret = -EBUSY;
+				goto err_unlock;
+			}
+
+			dev->deps[dev->num_deps++] = item;
 		}
 	}
+
+	return 0;
+
+err_unlock:
+	gpio_sim_device_unlock_configfs(dev);
+	return ret;
 }
 
 static ssize_t
@@ -1013,26 +1067,32 @@ gpio_sim_device_config_live_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	if (live)
-		gpio_sim_device_lockup_configfs(dev, true);
-
-	scoped_guard(mutex, &dev->lock) {
-		if (live == gpio_sim_device_is_live(dev))
-			ret = -EPERM;
-		else if (live)
-			ret = gpio_sim_device_activate(dev);
-		else
-			gpio_sim_device_deactivate(dev);
-	}
-
 	/*
-	 * Undepend is required only if device disablement (live == 0)
-	 * succeeds or if device enablement (live == 1) fails.
+	 * Lock order: subsystem mutex, then dev->lock. This is the same
+	 * order as in the make_group()/make_item() callbacks.
 	 */
-	if (live == !!ret)
-		gpio_sim_device_lockup_configfs(dev, false);
+	guard(mutex)(&dev->group.cg_subsys->su_mutex);
+	guard(mutex)(&dev->lock);
+
+	if (live == gpio_sim_device_is_live(dev))
+		return -EPERM;
+
+	if (live) {
+		ret = gpio_sim_device_lockup_configfs(dev);
+		if (ret)
+			return ret;
 
-	return ret ?: count;
+		ret = gpio_sim_device_activate(dev);
+		if (ret) {
+			gpio_sim_device_unlock_configfs(dev);
+			return ret;
+		}
+	} else {
+		gpio_sim_device_deactivate(dev);
+		gpio_sim_device_unlock_configfs(dev);
+	}
+
+	return count;
 }
 
 CONFIGFS_ATTR(gpio_sim_device_config_, live);
@@ -1546,6 +1606,7 @@ static void gpio_sim_device_config_group_release(struct config_item *item)
 
 	mutex_destroy(&dev->lock);
 	ida_free(&gpio_sim_ida, dev->id);
+	kfree(dev->deps);
 	kfree(dev);
 }
 
-- 
2.43.0

