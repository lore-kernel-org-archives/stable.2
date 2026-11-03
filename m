Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716328;
	b=hntz9Rs78sBFNbhc/qXaNjDDx7w6dZeibWgG2FK3L2vsacFbJrjVWYJMB3tCTjTDgYgw
	 1VgNBkbPpRw7atdvvLaikNLrQkxMw2++EbWc8NF4jSYnDeGe2TAepgF4/fxJB1TscMpfR
	 JZxAEfm7rXAC38hvd5W37RTRvtkQp2pwobaQKzN7Anj3EZksaCmM1D8Uq5HYSCt79ixYm
	 pGDM52j1SfzIB6d9w80JYc+iD1PGJhANA1M9CGBcvNF10UW2gdA+ADwkmdxX2X6ob4Ops
	 kFBAIkeY0GeLG/fR++pmuhdda+qAFMb0snwiD4aAZqvsC0PLBXwy9ghCGWoVviIFhAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+sZ2SGBKL+wA+F9N/uPCteUC32WVd5RJNFGupXt8+xA=;
	b=uP2bZn81GCJhbWMh5Rkwf5iF6GujTApXbvxaToRxMvWD0nPQElC38AsrAUMPY2DEjoG9
	 39MinPFIT3tj9/dRhIbCi5Ocdls0BPEjRUciorPFET7l+/9uEfqLBfOJpFzIpRAdkOcCd
	 2hSWMFsFAKD5J0O5NYAHvwm8PiDUplaIIzq2sn/aIjAyzqkqRUcjesgl4PsLnEBun9hoT
	 7z50K0JNB7qt9iE1o7IXOXS34KFVvPfnfUYgFwue1yfiGEgrHnZPR5+HJzYioUCCBx98H
	 wqya0lC+scwaHPcFnXUip4L9t+RYiqIp1Jm+qkdaMd948PpZog5gdu1QaRSrTsnePUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G374LnRY;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA0606EEAC
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AABA0606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G374LnRY
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e985106c0cso39579205ad.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 06:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793716327; x=1794321127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+sZ2SGBKL+wA+F9N/uPCteUC32WVd5RJNFGupXt8+xA=;
        b=G374LnRYRE87zWe4QgbNOVNjB4B2zEt6OVgBzP9vXqSxdyQ38VEGqSfxGQcVB0wJGw
         l24EZaJhZ2GROWzwHLL6SB0xegHbvE1K9wRhFujr3esRAYV4iDzIBRvQCzIy/lROAb46
         /UJClnGHNu80uisZNEloGBg3Ge1eHiMwcwkjKiTEMI9ppaQeXefICEdStGTduIMBYwMm
         ZXEaFc5YHhX7U89ru9Ne5BToKNKSa8Gd3mdPR3wmLRahhDsNdWA/W3O5+oleX5bD9WW3
         hziTSDoydsqIyfE+imtJ7ehVhP4fj0gucKBxMWhfdX6KIUcyxEJcsABHdksLWHJZOVPu
         xanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716327; x=1794321127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+sZ2SGBKL+wA+F9N/uPCteUC32WVd5RJNFGupXt8+xA=;
        b=d7QP6hSVgIJs6kiBZLPA8EXQzb1rodl9znYXGPe6pbVqGQcRfVVTjrYMs9vvKCKQm6
         AoQYbwQGNUBoVIrVnz0DL3k8Y8xceqtGNFl2HRJdZKlKocL7P3BO6b+no09mEcHtaeSb
         2xgfdD/AyU2im6qNEL3LhdHjIMF0Cr4re6ApivFWv4MoSdTrSavzJVJ7gVmoIlmHRVBV
         LLpSdZXmYWRaQ0WQYS3UHhTwTIAUnxK6OrzMqNboSsEhBECfdeqojdLwKdIFgeyyHiKJ
         mkNqPA1GAfKm5Z+WRmgJwQZuhnCTGolydWBUS6v6A7y5Wiqp7Ldd301QUcktM8mS8cNk
         7hxA==
X-Forwarded-Encrypted: i=1; AKwUvBy0i5xBoN5gqj7xB+XpXZYRaDsNXzLahNL8uOZY1RF7R/XMZXB+zD/eP4U1k9IQCiin7NUoPo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+q2CkQIMDgJEvwJAnrKRLw61Hcy30vGco8i7m6EK74FC8Hkugt
	8M3OnltikLirkEgk7O64It6fC7h3SWWx6QybJoiNYRiwXYbM2nLBSqjP
X-Gm-Gg: AYBFou3sxjxWcBbMWlDG5STO+WR6Ka7nkDaGTH5xfHHioPZkXRXsKfSDynsSN3TV6WB
	AOBKFFOczwrOq/NwES32NGWinQOq60BwOjoVeX8mwR3eDhFT6cv07BvWg0h9ho7AbrGfNNz+5yo
	xUsq++4xlXlYOpy3mBD5dEQ9RriNqIBjNOns99DYDjoAB63J5hWhimDWSttlB9OMnPeoAOmRXjl
	b/V+6jGeXmN1BDyFMEgqlSnJQT74owcvE1m1lxcntyUAWHShwVGGipBKJmLiwYRx3n4JR9oILvV
	EGNOzvBBamqgxasKfp0VwmV+5DzBGlwLjkZiT6bpHILYCe1MN2g7IkYNZkm/pIrMA1Ns7JC95nt
	w9VIdH0P8I0GlvYRl0I02rrI7YKIJDeuschmgQU11bXrvfSUxQZ1SxeAxwJmtbmEvK9v24Del+4
	s2QSErakavzz6NikdH82RC6kYFhXt0ugH90O+WglQJcxY9CCrSmGob2zKVzd9kz8wKy4Kszqgfh
	d0o8zt3hHuELIs64/QWvaO7kwN79PcF/u6HwctmymGEJihnmNaUQUfxHPVpg9SzTxU7w1zgk0ts
	mqybnoR/EAtagGhUYKco5AxFVNJohRrRsmnzsQS6C9XFCIvfumgUnwsqk5XEkuNL2DX0ep/qn4g
	meXHcWRxJ4GtNPFC1WyhvlweZA6Lyf+hFfMJIgw88EGTqVUnEOWWBnUU+IBquycPaBP7hOQzDLx
	UWFPI=
X-Received: by 2002:a17:903:320a:b0:2e9:69b1:1b9b with SMTP id d9443c01a7336-2eb3641516amr136502015ad.8.1793716326715;
        Tue, 03 Nov 2026 06:32:06 -0800 (PST)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922fc14sm42816695ad.26.2026.11.03.06.31.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 06:32:06 -0800 (PST)
From: Yu Zhang <yuz08559@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Koichiro Den <koichiro.den@canonical.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 RESEND] gpio: sim: fix the configfs lockup racing with mkdir/rmdir
Date: Wed,  4 Nov 2026 00:31:36 +1000
Message-ID: <20261103143136.62155-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

