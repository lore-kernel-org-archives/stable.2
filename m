Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793437203;
	b=tXbranBsA0QHAIfuZ8p4UGOEZsbm29dKwA7Ga4ZCMovslddzhx/lfZ+5rBq4HprI9E1w
	 5Udg3cC1tOLlmI7umLW+EgDMDp9u8elCe9wXqiUPyHzUdAKDHOlxNFGwhZKbdSje2qVbh
	 8UJGFo0y8ecmxIsEH6WV194rAQ+kZchXUAzMgfOImkyz8LN/DhlV2PMJDOjvqGVYEuE0m
	 JP26wRF2Lgrz3fup1UvJ+IyMsx5RZ0xyuXkaaRlJW9r1cl7bp1+g2rPCMkW7JJG73CV2v
	 fznZ+MirwHppvKvn8pjLpDikHaVWISVLIeBjjCbwNfdnOgjIOwYtPcRtlB/oGdZSnRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793437203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+sZ2SGBKL+wA+F9N/uPCteUC32WVd5RJNFGupXt8+xA=;
	b=sgbwAYJoAqc9qdvo7K9MX2FvweHhgxn7bLpqx55uHmU34SGXkj15VB1zCOekAoQMOx/o
	 3o/5WCV61LPoSaNndtDHus7/uETntJrmPWMLMfZhrxdYS/OVWxKyBgKSPimDE2wRynhMQ
	 25oBu5B+/Mdak2Tscl1VxkwNqZvLaU9VwfAlE6qus7oo1EvtexK8yvuHp7ktasBjHygMH
	 4gUycIbtOu2rQdXWcutdNEBBdH0d/dBhQmvDQ27dBx7SNWkfGxkL7uSl52I3s0fq+QyQt
	 mfd6Tvb1o3wzs/jxc8HaZ+HPn8BNXgk4TMWnMHqau6EHKWN/T7z5PplqWRpZiOahjiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wLC4nbCN;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53133606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 09:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53133606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wLC4nbCN
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e98798cbddso7137975ad.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793437203; x=1794042003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+sZ2SGBKL+wA+F9N/uPCteUC32WVd5RJNFGupXt8+xA=;
        b=wLC4nbCNzS5Lc4pkvG+1R0lZT4CKRKMLrcJ3C7eYNgveSM4ha4ySCLJTKQctRIzj3q
         pp+KACA3l8OqyNhgTlNA24UEH0JkmomtWkd4Zl4Ixyf3DCuwSbqXpFh7REB+uNN94CD8
         46KwRIDy2yqHlHmQDz5dMvJsa3ZEQTg9YVyEZAMtZuq7b3HYXNBPkKJapl2yfAPeJzSk
         PCEtVj72AvkpDVsxtj2QQlHPD7e81GEHcBQZuHZcPZeVNplsA3nOOvBxYA5SrJ3vReKK
         +HkxaLToOyKReO41QPDuKw/FZtH7JVz9Hf0n4+ioOZvwNyiLer2CE5A0Ogt0bwJiG60S
         RCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793437203; x=1794042003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+sZ2SGBKL+wA+F9N/uPCteUC32WVd5RJNFGupXt8+xA=;
        b=diSENr49x2sZV7Xxx+FuDTcQJwOv9MpASRGYsHPF54XLRa8avQR4XwHkjp+xbzCxrF
         G1cU9bZYV36mUKDjd2Snkmw8/WOxUmh6h6Fm2blWTfcC20MbuCUutdor14/j2GI3yZEe
         U5dv/1mILos9X6+a4IMEHzUGZyIXiqQ05krhQowZ/V6E+bGd1q7/F5uaVBYjN1+yFCAt
         f6FxTyt1JvSNScNBttXI00cB4iTV+Gm7fpmoJVoolHEuv75dHNwWBKgjaGiKkecC384i
         ARCU4EOO0Fgwd/Ly2rrIv3CPVo1eexsIbKYz4DNJheBSnuzC4w62S3zRqQ5g9Q0ubfZR
         BK/g==
X-Forwarded-Encrypted: i=1; AKwUvBx9RuYOk8eHkxdZgbHcU6zNpQ8dxkgjOxnT20qy2vGUPgpdkX1OV5mhHAb3bwEJWP7pCrtWC2A=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7S72WX9cVAZfzQNOjdzwXCUOnQRPO4VuD+CfNNINxp8Nw8yiN
	4CXwiETqfI8Kez8azQyMAO/5Hu4G6mgPqyO6bi0Rm9V0HEOlds84Jccd
X-Gm-Gg: AYBFou10gdZiCbvtfD6QaP3z0aux84J6eqEhmKsIb7CGw87fefo64VkQEPl1nEqqJzO
	SlvU2Xyt4z155Zj6h6d9XRM26KKtKWpfInYH5KZXSUnbLWEaHqkMtHwVd7dMbihrUDt1GCUo2VX
	eOevz2b99m1T8aJSiKlMtZBf0drSOEZaa+XF21IYDd1ONPbc4vqnuRSDsC4k8WUmHRxKIRTYGlM
	v6wfyxJEKpOitSlsI3esXnskHiIWLM2iWaKTADijByKL+sqLHJNpI9VoQxq9PjQhpm2uHKxjEhH
	DsoNJFrze19quku/LwypY9qFnQXoRcJDSn97RJZMkyKZcnDIksvNVwmttSxWvbZPswdzaKtbi1n
	rvyrW3kiy00RF71AGxI253Dz9ObXQlouD7AnvgbuspO3q6KkrTom6CVDHeEjheUnC14kjCLnG/Y
	4HV9o6fXXVxPs9VjaoEy44WegR5l2nLyNN2VvCmPzxKE54XxIRTeIV75yzlGQp2jTHueVke10tx
	PeI5kwNsVSAza4r1TkYV6Yr1+felg+VChtDQbOMa5gCKrWqvvP0jQRsUhpPNNq17pesgEv3qm0b
	ibJ51OSY+iZtKrXjE00rxaDXW4YsaKnop9fROT8yKjV6JR0gwYt0zxoli2xqdcM/RVWvFpOJclL
	xwj+raih4GOVaPAtfmQIeAsaNwl7yRVgP/8mnrFDN5tkB2FUH78PYlBPtWJ7zRfVkuyIN3udydM
	GbuN+cZ1HAorKsUxvUc0ZWblrn
X-Received: by 2002:a17:902:d548:b0:2e2:d9fe:51fb with SMTP id d9443c01a7336-2eb363ffa94mr46855425ad.4.1793437202530;
        Sat, 31 Oct 2026 02:00:02 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392486bbsm13932775ad.30.2026.10.31.01.59.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 02:00:01 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Koichiro Den <koichiro.den@canonical.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] gpio: sim: fix the configfs lockup racing with mkdir/rmdir
Date: Sat, 31 Oct 2026 18:58:21 +1000
Message-ID: <20261031085821.23385-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027085653.90471-1-yuz08559@gmail.com>
References: <20261027085653.90471-1-yuz08559@gmail.com>
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
v3:
 - Count the lines with list_count_nodes() (Bartosz).
v2: https://lore.kernel.org/all/20261027085653.90471-1-yuz08559@gmail.com/
 - Supersedes v1 "gpio: sim: snapshot configfs leaf items before
   depending on them". The v1 approach of taking references on the
   entries and depending on them after dropping dev->lock still raced
   with mkdir/rmdir, as the sashiko review pointed out, so the fix
   was redone: hold the subsystem mutex and dev->lock across the whole
   live transition, record the entries that were depended on and fail
   with -EBUSY instead of warning.
v1: https://lore.kernel.org/all/20261026060049.60599-1-yuz08559@gmail.com/
---
 drivers/gpio/gpio-sim.c | 108 +++++++++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 0c73bec..abc73bb 100644
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
@@ -974,31 +978,80 @@ static void gpio_sim_device_deactivate(struct gpio_sim_device *dev)
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
+		num += list_count_nodes(&bank->line_list);
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
@@ -1013,26 +1066,32 @@ gpio_sim_device_config_live_store(struct config_item *item,
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
@@ -1546,6 +1605,7 @@ static void gpio_sim_device_config_group_release(struct config_item *item)
 
 	mutex_destroy(&dev->lock);
 	ida_free(&gpio_sim_ida, dev->id);
+	kfree(dev->deps);
 	kfree(dev);
 }
 
-- 
2.43.0

