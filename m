Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F31531C8
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782606495; cv=none; b=gTthSgP/Ftomf1Y9FZQCrz7qOoa/jDH41BdgEVZDYZ8GAF9HXtwiiPd1scwTXGnn59v5UD2WSXpKJ/Jzoc/rdEBVgnslEGSRvlzbQFViSCd+H7aEoOItW6X/QXu9A3Lv06hKbgAhetgmYZ0Jrjaq+tPnez0HCjxL0w0J6ogV6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782606495; c=relaxed/simple;
	bh=ukach6//OujD9p6sL3XrO28ru0ezc2TX7FIoyJAK1To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7RZTy81BQv/+N8r+wCt4j5zvC3Txbp7ojAWis3uPpe9l4iiWzznA3YbVo7CKquDeXRLCr0bWk75HsGZj0s/ui2kSoWeOE/4KQw8mS//fbOaUCcsV+3eA4iBGNZJWdyzhieIoy27/swgv13wOXKllE6WVtKRE9OHIeCfl7/kNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xzv1LjUO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xzv1LjUO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so15552575e9.0
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782606491; x=1783211291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Vt5aQ4hA6sI9gKzTAa2Ur+vxC2MjfYGoremwvMSA+g=;
        b=Xzv1LjUO/ViLvu0+GqH0l0zHUESUWka55oU3oXkrjzY4PrwtShfhEa78ZjP/TYtemm
         PRlMwM6lbV6IdzyYEu/om/eL09WIMt8SEhEp7UncSr4X6TyVHhvDOYajl9Wi4jPVyvDZ
         p3OrwWBF41ACf3ZWodW37u5p6lgpgWJFmIbZh/v9P9sTjLRg/kDXSsDuouQs/RHYtx55
         GmF+blWLXs3aGqcFqfYwEKvmLLnEMNTP603MvjbgDwCrMYH4xWKjfueDkKyVTVne9VEl
         JftMEpiqTWpRF1wf/UbqjCih1zFEmm/GEF00OgqW2tVoi2bSZzv1HkMjLDnPpAYOUZUi
         0rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782606491; x=1783211291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vt5aQ4hA6sI9gKzTAa2Ur+vxC2MjfYGoremwvMSA+g=;
        b=H3911I3fbkKm87p/1gLCD4GixeFng15bgUSpKM9pZIvRbu5EHzlJNHMrMw6nrhkMkV
         rRcNIuEkmu0HeIziYy58basnI+WBTgquExpJudL6M1bfM77F13PGmTFG7x0w/VwYIyaB
         BciuywQobEBtqcNwAhrmAU8lXc6Vicdjt8XpfqQR+TVDGX9nPV5Kbx5bX4sDQSsZB+PA
         4csyu4wcNXCGnEDHLG8g/zn61mb8HCTXzDqgdn5KBxCT+VHBT/ofVHADKYOCgPG77uiI
         uZ/CPwpDhfJkJOzfJoNWCWJ9HrBs1Vr79g2u++gg7QUaZddVXoBDXxGdtYt65SprX0xp
         KNWw==
X-Forwarded-Encrypted: i=1; AFNElJ9ay0yvt5f/pdJ+47bm2k359iQJCu1KlXfiy7Pk4uaIn1fj/tjrgUPPLCaxYOL3H9AFReclP7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsn78S12iKBN03I4BpnAVGcE2O7ofVbIRaBPlqro7FzH0aFLd4
	CNjBAuR0MDnpDTBbIQ4gPzRgZDEUxlIDmYrSIoy+egof2GG4LnM1PwyJ
X-Gm-Gg: AfdE7ckxHz9Dmx0woxNxIiN5FNX8P8yem+kp5PCb0tXCkS6YeJtkDEWkq8zv4ija67t
	dYvrKhhVm9Qra6NfS37V9iiI2Sp3Hf22RULoRzrqdd9DqNXkgfrHu4dx6eO9L6gTpVb5Q2Art8K
	i9OiC2HdRJm2qINvHHFU8zlsXCUF5v/hZ+c5BNOBkxRo2V+B+kAQyf/KzOaWRSMTVevYQRxJ4/5
	KgnYROFAdZaPtMYpJb1cj9lIBskGaLOxPOFZJRrQSUcQWJsYidw113RAAiL6WSNMo12msM5EqMZ
	pDm4kt1HfhzcWH6XbpxvQjEwxQ4W1u85qiLMs+cWWCfjBJJQzb/OiIDPHNVVQHRiMnhqXZYLoPe
	So+seUkZ3ueHnSlAoZ8wsp1Zd4DUW4PGsbY0rNYcQ5BlreenJHCSeKarPBX/A8ZVFHsqcIyivsP
	IEfpjXktPLQ1qRLOygkvMYpHGYkfNs0bxqQzUX
X-Received: by 2002:a05:600c:6215:b0:492:463c:48b7 with SMTP id 5b1f17b1804b1-492668985c2mr161633475e9.22.1782606491518;
        Sat, 27 Jun 2026 17:28:11 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690100c7sm216713895e9.12.2026.06.27.17.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:28:10 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] netdevsim: remove ethtool debugfs files before freeing netdev
Date: Sun, 28 Jun 2026 02:28:04 +0200
Message-ID: <20260628002804.24214-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool debugfs files point directly into struct netdevsim, which is
allocated as net_device private data. Their containing port directory is
removed only after nsim_destroy() calls free_netdev().

An open simple-attribute file can consequently dereference the freed
private data before the directory is removed. KASAN observed this in
debugfs_u32_get() during network namespace teardown.

Track and remove the ethtool subtree before free_netdev() on both the
normal and registration-failure paths. debugfs removal drains active
file users before returning.

Fixes: ff1f7c17fb20 ("netdevsim: add pause frame stats")
Reported-by: syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c25f4750230faf70be9
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/netdevsim/ethtool.c   | 6 ++++++
 drivers/net/netdevsim/netdev.c    | 2 ++
 drivers/net/netdevsim/netdevsim.h | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 9350ba48eb81..025ea79879f3 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -252,6 +252,7 @@ void nsim_ethtool_init(struct netdevsim *ns)
 	ns->ethtool.channels = ns->nsim_bus_dev->num_queues;
 
 	ethtool = debugfs_create_dir("ethtool", ns->nsim_dev_port->ddir);
+	ns->ethtool_ddir = ethtool;
 
 	debugfs_create_u32("get_err", 0600, ethtool, &ns->ethtool.get_err);
 	debugfs_create_u32("set_err", 0600, ethtool, &ns->ethtool.set_err);
@@ -272,3 +273,8 @@ void nsim_ethtool_init(struct netdevsim *ns)
 	debugfs_create_u32("tx_max_pending", 0600, dir,
 			   &ns->ethtool.ring.tx_max_pending);
 }
+
+void nsim_ethtool_fini(struct netdevsim *ns)
+{
+	debugfs_remove(ns->ethtool_ddir);
+}
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 27e5f109f933..4e9d7e10b527 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -1165,6 +1165,7 @@ struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
 	return ns;
 
 err_free_netdev:
+	nsim_ethtool_fini(ns);
 	free_netdev(dev);
 	return ERR_PTR(err);
 }
@@ -1178,6 +1179,7 @@ void nsim_destroy(struct netdevsim *ns)
 	debugfs_remove(ns->vlan_dfs);
 	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
+	nsim_ethtool_fini(ns);
 
 	if (ns->nb.notifier_call)
 		unregister_netdevice_notifier_dev_net(ns->netdev, &ns->nb,
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 4c9cc96dcec3..64f77f93d937 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -154,6 +154,7 @@ struct netdevsim {
 	struct dentry *pp_dfs;
 	struct dentry *qr_dfs;
 	struct dentry *vlan_dfs;
+	struct dentry *ethtool_ddir;
 
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;
@@ -169,6 +170,7 @@ void nsim_destroy(struct netdevsim *ns);
 bool netdev_is_nsim(struct net_device *dev);
 
 void nsim_ethtool_init(struct netdevsim *ns);
+void nsim_ethtool_fini(struct netdevsim *ns);
 
 void nsim_udp_tunnels_debugfs_create(struct nsim_dev *nsim_dev);
 int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
-- 
2.54.0

