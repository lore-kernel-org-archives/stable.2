Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190533;
	b=XonP/V9OQVuQiCV94o20JdOsILRzL9KzzbNeavcobee9+LdlFN/t8ndYzhDdl9xuEMD2
	 CW6UzUzzym3JoWOOZWcC1vpWVOT3CDXbWIGFi09lbQkjyf0Pw/uvRiewaCLvSFbjgIp7h
	 xyIBT18zd2yrO5m3m3Qjtnef376VbjqhEDk/l0dPIxJ73uIxcgQjg/DTmW8FUTB11i2za
	 dnuhLaMEC+FINZmTk4SjYeK6+li69E6fS4JzmGcQMcD9wtyNn5ELOXZjppsXpp/b8+5LI
	 RB0HUyNPtVaKsWOExQcArlffcxNm2tHz8D7uyt0vMnFwzyw4BYWu+E7Hq9Kw8SpfMFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=dApsL/dlRKoFxvBs2GETZ/NYEsxe4Hnp92CF1CLUeuU=;
	b=BOTt3vNZejIDHg+9auaGAWc3h+NZ2V7/uKXYqQ9v3WolAEg+cKEFqj/bU58WK22GHl8o
	 coCkvhCwH+ERb40x+uCHuSFDMPoPqPo2vcOHg888l9lhDvky+nC8oFuIXXh+hbjb+6695
	 ZBNscvJQHijAvwZvsl+lfwFuB865bd9VvlqzBY/UxqKbNohSCuCq8T/iQ2TdjlxtrkyfR
	 dSjlEHObd7RF+OPlcQTmX/OXg8xHqD6UciqCM+JWiYpF/f+31AexeBfNehxsjLawQZTpl
	 mqmNgjYEPseOPwD+hU9y4jQ66kt4IugN8vJP6fxHXqbryX135MCY5RxJKhoeOcti+Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t4CUSqYw;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300E606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 16:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D300E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t4CUSqYw
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-862b9c2e78aso651175a34.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190532; x=1795795332; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dApsL/dlRKoFxvBs2GETZ/NYEsxe4Hnp92CF1CLUeuU=;
        b=t4CUSqYweHqu+sOy/9IwfBzvby1J11Ei2Ie24G7H2zDvWMmrK63gqIm8/gLFLOPLyV
         qfNvbQ9EAC2eOil3qpni+5DwkJNLy+g/L84suyXe9npP0i4usrFeEoTHKxRac+fQmwSb
         olAiVKf+86TJ8+yEVOlGsna9223O05zipiRvC/OprljMxZzWDSvPr4GxKy+ivvg9J5iJ
         f5gChIHMy7uaNlp8YBtL7h4eRpLq8pDCI1R0avg9BverGCOGFCjzGuaentMV+nodsALU
         SMEX/Y7vSlRnLdyscV+g9tgqscJtkBOQ+AMYJ64+Gp5syMLaYLEoJ4N09a6jPJgiTVhO
         6AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190532; x=1795795332;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dApsL/dlRKoFxvBs2GETZ/NYEsxe4Hnp92CF1CLUeuU=;
        b=J9l1fgChOfYPA7hoFoAsfmnYUy2qUvemB5jd6QZZjPqoeTl9h+QTHfDBYB1eAEJA2m
         uD6Ydm781LIyqnx+TkUAz1czbS5yPX6A1wzPVo69Mv0hSxMMy42CCMMRIYejsnzSy4Ab
         KM2VSuC0CkYkYWWRVbTfWLlQp8nbABln3RdzQRDP9hJT7Csr66mfZMb0iO6tBZi+moFF
         EV6+fgU5TBD//85RPRGck/GPQKOa9iDQH4Tae8+evYJQs3y4aqM5jS5ZcY5uDzObf4dl
         E/pshzCahkl+vckCYi8fG98yJEZ10hNhOzJItcuDHs3UVN50j/4Gujmd+LwgznX5zVOK
         lvGQ==
X-Forwarded-Encrypted: i=1; AL+hErEZSinrJURGk2kxCycIHUUAt3G0S3tJUnfcWnKv5VMxxSDCty4DuYuWxJkRXRDEZ81NwFzSw70=@vger.kernel.org
X-Gm-Message-State: APuU4Z90z+E4QzG1Z9FVh8UwtoLo4nExT+R53a1gjmddVhq31ZSqXK1k
	xJ7Xx80y6vKa6Z5DDan6PivOU9zIu2dAfMhJtl7LGfRqWwCDjfiKnPek
X-Gm-Gg: AZFdTZfDVKYohJItoMFenk6MTqe2A26LDZ/IT4GTvOJKTH0yCTEoYyBvyz1vEv97zU9
	wGVpwV2Tbt26SLKtF2DY3Fmnlljq6W6rS5Hu6qEXUbPgpjg1S51anH/DlS3fz3IdQqw0tCAgau0
	uyV6+W9Ax/Li49dT6NzTZqvHKmm7zRDq2I/jrIiXVDColhONy90C62OOEv+T+fpR64nVzwq/wOL
	IgtupR5IvGqiAu7nem9YvN38ue+mXq9jTfUK30Q6QW+rONHXjOzuoUx0/+sz1vAB2kpERQptv2i
	Cy5iqwNtHrrIDxcFWEqAMNttXm17W4Fx5wZ/6cNQb+IzPWs9tckILpqUn5EIxe8ETiytxlZIBzF
	aZw0DkluO+KmVxV9/DzbFTxJGbi+gX+Vk53ci5HG9oDZetQ/26mlDF+NsZOUmpiMmAWfdfzXD3e
	hlMXSJWXz5JHREsfvI2hf/dTr0kAWdiu8BYMhEBMP6fv7UEGkGME+TETCL6kN3RYT4iQ9FEtp32
	QThfZOmYGhTHbc8w6LUD5IHq5mr5LMprQ9mJ5wxMcr/L8pVlEni/vcUc6XDK4rbREDrRYB8OiTP
	qEvJIA6SX2K79Bj/prhJjoi2etvpHfHOu7MMYb2osaU9p6hdg2JeKlHcKTPOyfbHfRVFLTRA65w
	JzKbEp3/4xTkuj3ZQk7b8rcs0wUk9gew++Dd5un+U+Fgjy1rNe7TijxEQmf+N/ytTU5Ccb8+lgg
	k07Nf8Au05zm6snckMV3OlnsqA+/zUBMUjl3/u4LZIsVkW8WFtsXHuoSSp0f77KS/Mq2UirGmG
X-Received: by 2002:a05:6808:3193:b0:4cb:f21c:a794 with SMTP id 5614622812f47-57a0ac257d3mr3853052b6e.28.1795190531576;
        Fri, 20 Nov 2026 08:02:11 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34252251sm2522283b6e.6.2026.11.20.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:02:10 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 20 Nov 2026 09:02:06 -0700
Subject: [PATCH v2] mtd: serialize dynamic partition registration with
 removal
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-submit-mtd-partition-publication-v1-v2-1-8098cde01961@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WO3Q6CMAyFX8Xs2iqbiOKV72G42EaBGv6yDaIhv
 LsdPIFJm/S0PV+7CI+O0IvHYREOZ/I09CzU8SBso/sagUrWQiUqkzK5g59MRwG6UMKoXaDABhg
 n05LVWz1LSDOVG8zT8oaZYNLosKLPduVV7Joxb7QhouOG0R7BON3bJraYfo65u3jekA+D+25vz
 jJy/vuIQ4I1VaUSIy9Xic+609Se7NCJYl3XH5KuSIgIAQAA
X-Change-ID: 20261108-submit-mtd-partition-publication-v1-4629be94d7e6
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev

If a flash driver is unbound while userspace adds a partition, removal
can find the new partition before it is registered or release it before
its sysfs attributes are added. If removal finishes first, the ioctl can
even register a new partition on a master that has been unregistered.

Hold partitions_lock from the start of partition allocation until the
device and its attributes are registered. Mark the master as being
unregistered under the same lock so a later ioctl fails before allocation
can read bad-block markers. Clear the flag when registering the master.

Fixes: 5daa7b21496a ("mtd: prepare partition add and del functions for ioctl requests")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Use mutex guards to keep publication and teardown lock scopes explicit.
- Link to v1: https://patch.msgid.link/20261108-submit-mtd-partition-publication-v1-v1-1-cbff20b1351e@gmail.com
---
 drivers/mtd/mtdcore.c   | 4 ++++
 drivers/mtd/mtdpart.c   | 9 ++++-----
 include/linux/mtd/mtd.h | 2 ++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index b170c3144ca8..5ee1eb29fc1a 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -918,6 +918,7 @@ static void mtd_set_dev_defaults(struct mtd_info *mtd)
 	INIT_LIST_HEAD(&mtd->partitions);
 	mutex_init(&mtd->master.partitions_lock);
 	mutex_init(&mtd->master.chrdev_lock);
+	mtd->master.unregistering = false;
 }
 
 static ssize_t mtd_otp_size(struct mtd_info *mtd, bool is_user)
@@ -1206,6 +1207,9 @@ int mtd_device_unregister(struct mtd_info *master)
 {
 	int err;
 
+	scoped_guard(mutex, &master->master.partitions_lock)
+		master->master.unregistering = true;
+
 	if (master->_reboot) {
 		unregister_reboot_notifier(&master->reboot_notifier);
 		memset(&master->reboot_notifier, 0, sizeof(master->reboot_notifier));
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index ddded0dbe77e..b20fa4309084 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -278,13 +278,15 @@ int mtd_add_partition(struct mtd_info *parent, const char *name,
 	part.size = length;
 	part.offset = offset;
 
+	guard(mutex)(&master->master.partitions_lock);
+	if (master->master.unregistering)
+		return -ENODEV;
+
 	child = allocate_partition(parent, &part, -1, offset);
 	if (IS_ERR(child))
 		return PTR_ERR(child);
 
-	mutex_lock(&master->master.partitions_lock);
 	list_add_tail(&child->part.node, &parent->partitions);
-	mutex_unlock(&master->master.partitions_lock);
 
 	ret = add_mtd_device(child);
 	if (ret)
@@ -295,10 +297,7 @@ int mtd_add_partition(struct mtd_info *parent, const char *name,
 	return 0;
 
 err_remove_part:
-	mutex_lock(&master->master.partitions_lock);
 	list_del(&child->part.node);
-	mutex_unlock(&master->master.partitions_lock);
-
 	free_partition(child);
 
 	return ret;
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 8d10d9d2e830..cd7b4671c456 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -224,6 +224,7 @@ struct mtd_part {
  *		     not only the master partition list, but also all
  *		     sub-partitions.
  * @suspended: set to 1 when the device is suspended, 0 otherwise
+ * @unregistering: removal has started; protected by partitions_lock
  *
  * This struct is embedded in mtd_info and contains master-specific
  * properties/fields. The master is the root MTD device from the MTD partition
@@ -233,6 +234,7 @@ struct mtd_master {
 	struct mutex partitions_lock;
 	struct mutex chrdev_lock;
 	unsigned int suspended : 1;
+	bool unregistering;
 };
 
 struct mtd_info {

---
base-commit: 14b6830335eb6d70dec7a235094d66c22d38eb07
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes
change-id: 20261108-submit-mtd-partition-publication-v1-4629be94d7e6

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

