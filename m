Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B1344DB9
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965921; cv=none; b=iNfYinNVGUxhszPpODgdMLko151/yTgvDaS1YNKRElfN9ZVMjg6goqq/jCEjqK5t47GHjgy9vA94wd0HxCw2c57TTm28ARgnjSvAGF0qe0OFfMAR8ERiKwgL/nfb6q286j1URZzhX21UHatY2EKpUwbM5VKtgYeCHU09MXR/yDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965921; c=relaxed/simple;
	bh=XeZnVF8VMOIq8NowPgSjmvHb8AkE7i+WvqIK6N6ANjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4dOhVOOQ5GPQeZxgUo5oDiXSKYRB8bjdT1+5k8cAgeOw24H45sE/nxdj02mh8D1M4Yyn+YNydLnfxW41dVDrHLKw10a1mu0BUR84YHQsUl6UTCkwinqBBLgkqAc7St6+dwqQAUWrpGda/9Mm3prn7W6CfLVKEoCvk4IGL8TbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOrOsyE2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOrOsyE2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1870768f8f.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965918; x=1784570718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DPs2lHQRfpK+TsWOFRy9KnqkkNN7TxB0PRSoapXl1VE=;
        b=BOrOsyE2uxxPpM+zui5vnSpr9UHpb4i+2dHjRQqlNk9zn5KE1MWyDihPWmO8r64qZn
         joQFso2weVNFzGNkZjmAJq+HhHZyS9FpOwq27b8BORtWeljy5xAFWfjeWT1mtxsn6Puo
         +uaXpNzcbHPKdj4KyikDbQ/nJYf9RaaaISxDczqVd40x+OGJ+ibZIfga4nJnx8PAgovm
         NuSCrfXid4+ERkCN4XUMWoHxIn7zhwVGzLowXTXuJ/YYJ6tZH4qHoxIG3lUDPpCG6B9X
         VE/acyvQdqw/e4xz6LZYdc5KWLrMQbFthP9uA5hJdstGuWGYBIGaodCshMeJ0E/bJMf6
         GNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965918; x=1784570718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DPs2lHQRfpK+TsWOFRy9KnqkkNN7TxB0PRSoapXl1VE=;
        b=RR19YwIfYw30xX51Q8gxH8IH3/SZpF3zhUG0MKz7VRn7MR9l0uwl5ozIQGfvhUCoEk
         2jUD1o8M+ZHtedZ71NwJ5v9NJhE8+680U08tlTIyN2CD7blBwd/SfW6NYmuqeJtYcmDi
         t3zVvDJG31RuUPSNc5OvF7Eete7Jrh0CII+kIJLudNmKHJDnCkKzfHZy3nOQUwK82t2G
         QgNnqM0VeSRVzuXRiW0mpeaHadL4fxsZdf9Ce1z0b9t7eLEn/yyAINcZRMlIMj6xQn5A
         7OZaKnxmG6RZfXn1ivz4Uc2feMm/dJgS7u3P5qRT3RK9KLr9LGUm7PIVNjDephWRw+km
         me5Q==
X-Gm-Message-State: AOJu0YyC1hZmrXdKXRxSn/vKhCOFBXQyN3DBjE7Q5BEHrqYHQj7awyiJ
	Zo60ogDNj4glaoEwzU7mn5Vela626IuQ07/Egqhpup/lpXTBJnM+60XcJsD5V/p7648=
X-Gm-Gg: AfdE7cnylWDfIClS+tau61Rp158I3nqK3SHSo9kH9gxPbaR8SzWSPpYH+WuBu6GtzX4
	4lPa4tVOq7Mp/znAnfk0Thi3Mc42dr8f18AALeO0rSu2Qi60x/2kOeFsY2OidTFkWQA2z9Eau6s
	lQZmeeaYKPaEVPr3wxvrWUf1fzvUJV1MzgBcUrlWXTcDoZFA3iS0foD02A3ovRA7EEvrLA0m3h2
	gLzHKxDDjb63IY5rLbMfkvoAofDjqbQ8J4DbOldmTXH/kWzIl7IWkBbfof+BR42+ydX/FVnXb/5
	ZZCd6VHhqkWBVtxOn3tfazpqip3G4Wz0Z34SB2uAH7XkB7Th7Wji1ST0neCKRhQDGReDN87R6Rm
	SxN8kuT4Eii1Up+0um4Q3EezohUzwaz3r8KA/H74JXB4QzABGOp1QOHc+WXN6shVNmaj5qwIjNR
	Gd91ou3smbCS51j6+bhepl9PcDsz5PjUmgaw==
X-Received: by 2002:a5d:64c4:0:b0:462:e086:35f with SMTP id ffacd0b85a97d-47f2dc88af5mr12536623f8f.21.1783965918210;
        Mon, 13 Jul 2026 11:05:18 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([46.1.111.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635aa34sm1230690f8f.15.2026.07.13.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 11:05:17 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [stable backport request] wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon
Date: Mon, 13 Jul 2026 21:01:37 +0300
Message-ID: <20260713180433.52394-1-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider backporting the following mainline commit to the stable
trees:

  commit 351dd7d2c80d ("wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon")

The commit carries a Fixes: tag but was not marked Cc: stable, so it has
not been picked up for the stable trees automatically. The tip of
linux-7.1.y still lacks it.

Why it should be applied:

It fixes a NULL pointer dereference in mt7921_channel_switch_rx_beacon()
(and the identical mt7925 path). When an AP sends a Channel Switch
Announcement (CSA) beacon, cfg80211 queues a wiphy work item that later
calls the driver's channel_switch_rx_beacon(); if the station
disconnects or the channel context is torn down in between,
dev->new_ctx has already been cleared to NULL and is then dereferenced
unconditionally. This is triggered by ordinary AP behaviour (channel
switch / DFS), so it is easy to hit in the field, and it hangs the
machine: the crash happens in a workqueue worker that exits with IRQs
disabled, wedging the cfg80211 workqueue and progressively locking up
userspace until a hard reboot. It affects the very common MT7921 /
MT7922 / MT7902 chipsets.

Reproduced on linux-7.1.y (Arch Linux 7.1.3-arch1-1), MT7902
[14c3:7902] driven by mt7921e:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:mt7921_channel_switch_rx_beacon+0x18/0xa0 [mt7921_common]
  Call Trace:
   ieee80211_sta_process_chanswitch+0x682/0xc30 [mac80211]
   ieee80211_rx_mgmt_beacon+0x7ec/0x19c0 [mac80211]
   ieee80211_iface_work+0x4c4/0x630 [mac80211]
   cfg80211_wiphy_work+0x13f/0x1e0 [cfg80211]
   process_one_work+0x19f/0x390
   worker_thread+0x1b1/0x310
   kthread+0xe4/0x120
  note: kworker/u64:15 exited with irqs disabled

The offending code was introduced by
  8aa2f59260eb ("wifi: mt76: mt7921: introduce CSA support")

Please apply 351dd7d2c80d to linux-7.1.y and any other supported stable
tree that contains 8aa2f59260eb.

Thanks,
Ismail Tarim
