Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792994544;
	b=UEW8FuojNa+0mbUiPvslN9d41jY2KOWOZTs6DvxCH0SCLCG8+HWr1zpw9Fo+19KQHrS6
	 DfubYDNNUAb+M0sRmgO2D0I/Zq5vGrembWpahsS6djCDjLaf+kvUiS1gMmZXlRnqemqTk
	 dwRwx/sfsQ5R27JocArAa8ruxgxl5uEYvGiFou1oQ1k4HLMCTpKD7PhFjxsTZoFXeP2bM
	 vRrGgWgfpSHh5CYtyPcMxTvAaVJtJxTBMN3mjI0SJCR5HwGB6nnqIGnW/vm6hc8vCPRos
	 trnHgYQCTTsrg8bO6vpi5GAsJb19u6qhCW2q71PsfXoRnf2N1CO5nvkxn+JWEAfjXEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792994544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K5t5lwdyPHqIe+zGWPszmhrUHYwt42j52CshxS8SC8s=;
	b=4cBJKCAHxZcbt3Ij15WwQCMARUD1pKxMpWOV+6WSf0Ahmemcq26aNhiE+XnR8LyeYel8
	 SB9b8iyaJAP0LyGJ1TBM200+kWqbq7o2jCX21e7ztKdRyK+pXCPyugOi7fWm1g+a/50S4
	 NKtyfqnvarTmseM9W65SXSE0bGBakBEdXUmo/9ocGfYcejrvPBxDIHD887f72fCImWaZ+
	 DsTYYDbLO+b1CWufrzuBIYmV+6yfTneyqeiQLnp9WThAtgemN15W6mAu08dTJkNyY98oT
	 Vls1HYFp5QOpMEyydsZcRY6wPMkC9Y7A0agtOtA2+AIcnDAXQ2jzBk2BsnC07kKnojw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RZfpTO28;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6F606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD6F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RZfpTO28
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ea0efd636dso20237795ad.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 23:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792994543; x=1793599343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K5t5lwdyPHqIe+zGWPszmhrUHYwt42j52CshxS8SC8s=;
        b=RZfpTO28d8xWb/KIi5uR3p24SsrWLmGAhYKTvilY1NXeGjWbNSbGJByXxg3NAKtZbV
         L4MH7EqJVua1SWRpd5Q5RLa+T/PaOUifJs6ZfTz/7KizOLKXMtZPTdkNZaM6CdNraTqe
         ikhCSwcr+8LNkautPAWVWtFkloi7FX3a1+NOZDEJOk1MmAhNIuOADcsI6pz6wDLdwlOR
         Pqvho1KzmFRNdt5AG/6/VE2SstT82FMOf+PFyVCKW3zvZn7abufORuT5zXPDi9D1pGQ8
         Z5ftV1T+OzMZ/jvm6+3sJGv4guvIZYc5U9EqG6DId7gtjCHcOf8VuWcesKukvmZ4YhQv
         iTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792994543; x=1793599343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5t5lwdyPHqIe+zGWPszmhrUHYwt42j52CshxS8SC8s=;
        b=pvuxXYN1VxDgduDcehR3ngNigGUkDIGhPXWnBSGoiNqBvJP37svTO8Ciwnko+lNuPx
         nRnPXYufUtXUKsO6wyJr2/asMiR0J+YuknESaPwJlidxYjxEvycPIzoUrPxAX8fqdlLP
         10s+z/qvn6oxgfo/tmrDr9qod+vK6y+fhmgkYaiFOJ2wzKz6TvK1bYZZI8QU1IR1cOHl
         5LlWvd92Qe3nIcYfn0QtjQlcqH4YQmPo2zce0oa1VU2Cm9+znellYn0N7i6zJ5VEUpJe
         9yqKF5GFxVIaX0kqIk193Q5oUgO4rj0F1hDqIE2dYiQcEbT0B0UbvEm60DgKHg9xvp0Y
         HqYA==
X-Forwarded-Encrypted: i=1; AKwUvBwgrBkFZvGUpsslsdjwQYS0Vtlip5kYFK0rEOn2KNWMeh56aXVuevgmEepsNrdH+gbY+aTxasw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSIGIZyzv5dxKatJ1x4DyGfGeJ06uZxiCOUuKq9J7fkVd8nhc5
	iwqpuNJeSdoErqnxcxdM9g5KmFJvU8y3cNYVf192KcfX8eZqqjwkUhcr
X-Gm-Gg: AYBFou3ZvxHTuQXP53YhjEVC8Qpk9Xl9gzQ8WZhnfhQOv7OWJJboQCHgLmqst1WAknv
	412WIEms5UnHdk+louOyh8wqRxj3gcAM3DdPVHkxsNQ+Y+EJ3syFFQ08xcDt3l/iXDHnIbUfwOs
	unoIj82ZrJiI6IeOZhBbeWcQMAVZN8+WGESYS6wjZMsB5UPwJJpuzuYiDZ2mOWqi6dvNIbPDe8T
	vQIuTbX7G/um5EHECiY/4oj61Hc3ZPDDiA72e532Vjvd8hem6zGddmupmY7b0F3r9FDgdLFvpOd
	l8hc8FqP2Aokmn/w1UDegSjCzwYxcl2/ZBiplgkwrYw4aeekQAKKRMnDzzwD5LrRDWuDNd5ZF5s
	B5nEPd8PkNfsAG3+r1jnjojLqfeYlAfiQ3p1R54EPy6EerwZ/r47pe59ZujrVPRQZOHhIeG4jLl
	CqLV6ajhEcgHY6pNob8QxCPljT5MIjsqEQk/nS/fwXiB+y+zH3gLouKhMcSiegwe9Qm0H2ivME8
	/o9sBFt/0VU9HAUERqFNd0XsI5iGS46J1nfA4HU3thL+LzwdDwW+gtQLqGgmt7md+otvzhsOr9F
	ePlvMd89/G9/gE9kN9Nfytprb97lAqFxszAcVvJY0hWtU94NVe/wUUKJHU0wEsHPCa5K6cIRkT7
	JWeTYAI/LFW1pFvGv199knMZFFoUH
X-Received: by 2002:a17:902:da8e:b0:2ea:19a1:cd3e with SMTP id d9443c01a7336-2ea9c83381dmr51356895ad.33.1792994542732;
        Sun, 25 Oct 2026 23:02:22 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af31421sm12212435ad.7.2026.10.25.23.02.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 23:02:22 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Koichiro Den <koichiro.den@canonical.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] gpio: sim: snapshot configfs leaf items before depending on them
Date: Mon, 26 Oct 2026 16:00:49 +1000
Message-ID: <20261026060049.60599-1-yuz08559@gmail.com>
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

gpio_sim_device_lockup_configfs() walks dev->bank_list and each
bank->line_list to depend (or undepend) the leaf configfs items when a
simulated device is activated or deactivated.  The walk runs without
holding dev->lock:

	list_for_each_entry(bank, &dev->bank_list, siblings) {
		list_for_each_entry(line, &bank->line_list, siblings) {
			...
			configfs_depend_item_unlocked(subsys, item);

Every other traversal of these lists holds dev->lock, and the lists are
mutated under it: gpio_sim_line_config_group_release() and
gpio_sim_bank_config_group_release() both do list_del() under dev->lock
and then free the line/bank.  A line or bank can be removed by rmdir(2)
while it is not yet (or no longer) depended on, i.e. in the window around
activation before configfs_depend_item_unlocked() has pinned it, and in
the window around deactivation after configfs_undepend_item_unlocked()
has released it.  The lockless walk can then dereference a line or bank
that a concurrent release is freeing, or follow a ->siblings pointer into
a freed node, resulting in a use-after-free / list corruption.

The walk cannot simply be moved under dev->lock, because
configfs_[un]depend_item_unlocked() take configfs-internal locks and
holding dev->lock across them would invert the lock order against the
configfs rmdir path, which calls the release callbacks (taking dev->lock)
with those configfs locks held.

Take a pinned snapshot of the leaf items under dev->lock instead.  The
list pointers are now only followed with the lock held; each item is
pinned with config_item_get_unless_zero() so it cannot be freed once the
lock is dropped, and items already being torn down (get returns NULL) are
skipped, since they must not be depended on anyway.  The snapshot is then
depended/undepended with the lock dropped - preserving the required lock
order - and each item is put afterwards.

Fixes: 8bd76b3d3f3a ("gpio: sim: lock up configfs that an instantiated device depends on")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/gpio/gpio-sim.c | 56 +++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 0c73bec..562f305 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -978,27 +978,61 @@ static void
 gpio_sim_device_lockup_configfs(struct gpio_sim_device *dev, bool lock)
 {
 	struct configfs_subsystem *subsys = dev->group.cg_subsys;
+	struct config_item **items = NULL, *item;
 	struct gpio_sim_bank *bank;
 	struct gpio_sim_line *line;
-	struct config_item *item;
+	size_t i, n;
 
 	/*
 	 * The device only needs to depend on leaf entries. This is
 	 * sufficient to lock up all the configfs entries that the
 	 * instantiated, alive device depends on.
+	 *
+	 * The bank and line lists are only stable under dev->lock, but
+	 * configfs_[un]depend_item_unlocked() must not be called under it:
+	 * they take configfs-internal locks and that would invert the lock
+	 * order against the configfs rmdir path, which removes lines and
+	 * banks from these lists and frees them under dev->lock. So take a
+	 * pinned snapshot of the leaf items under the lock - skipping any
+	 * that are already being torn down - and then depend/undepend the
+	 * snapshot with the lock dropped.
 	 */
-	list_for_each_entry(bank, &dev->bank_list, siblings) {
-		list_for_each_entry(line, &bank->line_list, siblings) {
-			item = line->hog ? &line->hog->item
-					 : &line->group.cg_item;
-
-			if (lock)
-				WARN_ON(configfs_depend_item_unlocked(subsys,
-								      item));
-			else
-				configfs_undepend_item_unlocked(item);
+	scoped_guard(mutex, &dev->lock) {
+		n = 0;
+		list_for_each_entry(bank, &dev->bank_list, siblings)
+			list_for_each_entry(line, &bank->line_list, siblings)
+				n++;
+
+		if (!n)
+			return;
+
+		items = kcalloc(n, sizeof(*items), GFP_KERNEL);
+		if (!items)
+			return;
+
+		i = 0;
+		list_for_each_entry(bank, &dev->bank_list, siblings) {
+			list_for_each_entry(line, &bank->line_list, siblings) {
+				item = line->hog ? &line->hog->item
+						 : &line->group.cg_item;
+				item = config_item_get_unless_zero(item);
+				if (item)
+					items[i++] = item;
+			}
 		}
+		n = i;
 	}
+
+	for (i = 0; i < n; i++) {
+		if (lock)
+			WARN_ON(configfs_depend_item_unlocked(subsys,
+							      items[i]));
+		else
+			configfs_undepend_item_unlocked(items[i]);
+		config_item_put(items[i]);
+	}
+
+	kfree(items);
 }
 
 static ssize_t
-- 
2.43.0

