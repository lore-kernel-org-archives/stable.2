Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819D559CA0
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880170; cv=none; b=tPQskNKx7MyQ+ZVHZzLiADlKIA8l+W8XU4GDHGMs4d53aN7REFdvgk4yZW+CZZdSDpIrYFAbM5cFLeCbzkF6EJD4DvjKjsB/dhbC04fzJJUJ3yT6QvhpmRZIi8XERCzrEaWw77mquj/89g3K98KW85MuxRyLOwE6atKfTAT3NcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880170; c=relaxed/simple;
	bh=hc911xxuUmZN8P+jG4Et5ZWTWNyakO0Xa7s2ndw9gms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rD16YJnUfbB5iIwaypzQ7NeZEvrnTrFo5MVwIrCscWuV/nBhI8aiO7pgFza21+5X44i3Iju6LJweqGHxQrT7nyTH084D4RmeWUyq14y/9V3SFQX60wswuHAgPDAR87hmhYZzUiTeRRCKsEFfo0N3pn8YkE51jDJEbG6zdD9HBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLKt9M/k; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLKt9M/k"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bfaa014978so2353101e0c.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788880153; x=1789484953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mGr9Cpmb+BSuPew2BBM6BAEAjAFzPbXBB7PZR5ZlT50=;
        b=GLKt9M/kujvwk5Y8aQC7tsdl9sjTIQMlyGnSGcLvrJT/Oxo4I4CpCYwkxVlAld0s8u
         sHZwtFzVGdEflwVPT6pzVbDWhgpvPgGgv8Rv/tUwGsoVWXt3X9hcXM5pQO4XAM4Y0vOA
         ggHKm3e3zpa8GuamtyjJjYzkEOt2hfqWj4nudjNMwKW/qc4XA1qSOFLgos/9l8Ks4CCm
         x86fnZZLWBv/ETujGhzwdEoBEHF+90ODZUvqikNXXhE82KYZRmmrePvQrN79/XP00OKr
         VWPTn3D6aGuOECmqP/dpsrZvTJNPnQ+gHMHv93yFNlBPkkGCrgrgLHgX1JYOX12A87Jh
         oXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880153; x=1789484953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGr9Cpmb+BSuPew2BBM6BAEAjAFzPbXBB7PZR5ZlT50=;
        b=qiw4JWaKA70aXhte31HhO3tJeZ8fZQHUEx/seQvba252VoN0+L5ginktgDLYrvDQnW
         zmpf+MSNZLqJTNziPfFd2CX48SWeaHYq8bMSdz2dn2U7x3etTfAquxYmMD5ZK0vHlzAV
         +MxwDk0O34rwyIGhblyt4UpwUTVUWaln4dxGTQv6VE9hwoTqLlFJ/vRSty1HqoVflB+f
         3PcfBlnH+r328f+NhWJ/6126yqTGstZ09OmlTIsKLsS1puLRYKd+aPvtslxA2VbjLjvG
         aPalmKdkQVpX3nZYkcURej+NGihEVEnuoL7krVhXwAVSkQfwbvIzdnUNjWwlz/pGjesU
         2FkA==
X-Forwarded-Encrypted: i=1; AKwUvBx6+x5o0O99wA/SWuEFI+y6bb39LkHEUZrmgssGaE2UWH/eR8x9neMuymoP+OcTriRYDEpA/24=@vger.kernel.org
X-Gm-Message-State: AFuF++lWvP9A1ijp4ysB4YlyrXzBjltpGzPQ+AfJsFtjQFG49ax8QKfN
	I3Wlw9WkADFhwKzgl6d7qvhij1/tOKS3jTeQ+HudccKej7a9IMJhj7qv
X-Gm-Gg: AYBFou3o/zpTkrqvGbxcDRp7wIBRouzDA4POWL0NWL+u/J+GNgom2nbyQDn9XRAuDTO
	5W7pkII7ZtA5luiNfy2y0Nwj6hn/0mi8RVtAhVPkBREUvLYi4fgzfTmIY7yz2jCRo/7SJTxsT4t
	+iEojmt0qr8Gx+vMoEfwHm0VA3i1vF3CptLnh8WQW9jbpLB4lMTsLpuAV921Dut6nuCxowVdr0T
	V3ouUHwP0fzATjPEBdRSQJRyNWA6YRnKOclYqUFpNLpEB11J5kq/qpYx+9hT4Gr/8jWPbtNd1b8
	tIHcHEFtzEKSOWRCA3I3raMHQGcju4HlRwNY3KXKPSEuyb3fXiLSzuumhXoNN5TFpc4NK6js077
	NFad1TqmyqYzenanDYX/rO3nbaSwiyrXbOMam3odjwGYjmisGLmJbx04NCID/BNgaYeJVdSH5u5
	CSWX6GOs3fymqpMoNc8BgZOsJgDbxuJNHmt2cJkEbrBgjutVBcUEfYgcgrn7QLcO8=
X-Received: by 2002:a05:6122:6092:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5c7ed83b793mr12351254e0c.7.1788880153383;
        Tue, 08 Sep 2026 08:09:13 -0700 (PDT)
Received: from adriano ([179.57.108.248])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec3b2cb1sm9940418e0c.16.2026.09.08.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:09:13 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mmc: vub300: fix use-after-free in vub300 teardown
Date: Tue,  8 Sep 2026 12:09:00 -0300
Message-ID: <20260908150901.58915-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_host_classdev_release() reads host->parent->of_node, but the
parent is not guaranteed to outlive the host. Instead, store
host->index_is_alias to avoid reading the parent at release time.

Also, call kref_put() after mmc_request_done(), as the latter
dereferences the host pointer.

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Reported-by: syzbot+f312381a95cc080992fd@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f312381a95cc080992fd
Assisted-by: opencode: deepseek v4 flash
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/mmc/core/host.c   | 3 ++-
 drivers/mmc/host/vub300.c | 4 ++--
 include/linux/mmc/host.h  | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b7ce3137d452..542bb033c6da 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -67,7 +67,7 @@ static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 	wakeup_source_unregister(host->ws);
-	if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
+	if (!host->index_is_alias)
 		ida_free(&mmc_host_ida, host->index);
 	kfree(host);
 }
@@ -538,6 +538,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	}
 
 	host->index = index;
+	host->index_is_alias = (alias_id >= 0);
 
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
 	host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 2dae474dcd06..c87c54aa0e99 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1794,8 +1794,8 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 			construct_request_response(vub300, cmd);
 			vub300->resp_len = 0;
 			mutex_unlock(&vub300->cmd_mutex);
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_request_done(vub300->mmc, req);
+			kref_put(&vub300->kref, vub300_delete);
 			return;
 		}
 	}
@@ -1946,8 +1946,8 @@ static void vub300_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		    satisfy_request_from_offloaded_data(vub300, cmd)) {
 			cmd->error = 0;
 			mutex_unlock(&vub300->cmd_mutex);
-			kref_put(&vub300->kref, vub300_delete);
 			mmc_request_done(mmc, req);
+			kref_put(&vub300->kref, vub300_delete);
 			return;
 		} else {
 			vub300->cmd = cmd;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba84f02c2a10..165d24104d3c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -356,6 +356,7 @@ struct mmc_host {
 	struct device		*parent;
 	struct device		class_dev;
 	int			index;
+	bool			index_is_alias;
 	const struct mmc_host_ops *ops;
 	struct mmc_pwrseq	*pwrseq;
 	unsigned int		f_min;
-- 
2.51.0

