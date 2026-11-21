Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795239053;
	b=J1anD1WnjzoJiNUrKwu7c8xfr7TypX7jdAiRM+yz0OG3AX6goRwRMWUlboFOta0YS+Ye
	 IEWeN9BtDAZTtSn/KGZaN84wy86g7Yoez6BJno5DyCaNG7ddTqXBi1o3HQiFqTGJmPt2R
	 R6OxucQA/WvhiB9t7fqGTNlrzTTl2OAFR/RgI+7pCaa/ZrgPjlc0sUhqPbSKdUbCM+d+R
	 LNB5NyGjRYBoK1we+SOwv77cElRS9G7Xo1kOAD7Rcm15UeDnEHnv5nTka/OX6zCzi5zaM
	 YypMk1ohTj8Tp9/udZ0TcCkqtbAIMEAVEHh2Hq59mp8LaScKltUoRRHMSfjPcA7n+Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795239053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6h7S1Z/Yg4pL1JyrxjPN4A6nDLlEh5v9NxEZIV677W4=;
	b=BRZoOjvl76Mye93E3qUguBm5ZcvvEXfMaJYwJLcxdUBv8KvlpQKtgMf1Owk6uJfdQrxg
	 HXgsWWyrvL/bxEpo71VYmLMJ140Sd4324rCjeHpzEFQv8Br2EyCIe8GdLoAH51MSeX68K
	 nIt8frP7UokV30XBDk7F3ZEoiMsetlnc8CteFljn9XW3Ht/rRVo2IcXYiWyXaC/VnSYm9
	 3baHX9KQJEN+OBV+Zr8McQpCdMT9xTL6bFls9jk+Rb4PK4dj0KbKUrcifx1ByvtsGihD3
	 dTt46TJvvafR7wB5YCS5zGs8cLvJKL6Xk97R6Pd9E/jLnTJkslipjNU/Slgzx7Jwv3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDGIGh8X;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12522606A6A5
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 05:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12522606A6A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDGIGh8X
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f06ff94acfso24935ad.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795239049; x=1795843849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6h7S1Z/Yg4pL1JyrxjPN4A6nDLlEh5v9NxEZIV677W4=;
        b=HDGIGh8XXuu6yFs5aKL2Y/+U8+5jXNrGXkzEe0/GwzpL/UTmJWLhS7qFFSs8ym2AfQ
         DbHqnJ5ZwZHpzx0eNkroFT9fd4xzei1MuSH5OL6YnyzbxsFUj9CDnjQO5rqbG3PNPXtk
         KRsryNkz7TqJ9bTVw4zPmpzSm9Qr/y74HZSfMAccWQwylHRQUoRVbFhwFc6RlPqvOHLU
         YXLu2BoGm8Z5UervBGgFhGiRjcriO+KbWDi0ggPNI8+ycvFEw8mSALPMRKrTRrQku3P6
         qP6sqX5lLXmE0ZW98Qdt+ZaIKpAdeVEWdqh4uSIeD5qh4EB1cotryl2Fcc/x5gmynWS9
         +CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795239049; x=1795843849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6h7S1Z/Yg4pL1JyrxjPN4A6nDLlEh5v9NxEZIV677W4=;
        b=waxg//+c8RGvHciRN7joQ/Oxu9mg/oISvLIu8lkqd8SA05oDXWbmwDQGMAn8jOscT2
         UD7BZBNv5+kTo0t35DR2IeFV5pOlawxtddrqRqC3Y9d5c+qcq97XXP5kc2By7XNeetxe
         QV26EgpFl99Wo+aw+EQMYjpbUkwT1igRAfZQl0DXfA75ouQHPCSB4r9sP5LtAk2SwRsX
         2BJgVro43DjKxZ7XC7nxv5dIaMe4dH1yssOzNKQdT8rqqiMGRb3n4FEVAiC+Dnh8lOX3
         aOLpl4xktDcGTlNdpjF+aLtqz9d4iE9GKuMFQg4wpEYz4PqfB4z302HHNwLqZSypUeis
         lLtg==
X-Forwarded-Encrypted: i=1; AL+hErHKpetTd1arZPP41EkXLi8KSrP+twl/5NLKkbTt/Q8lpzeT90FT74S/YKihkTj8q3bTma6ioi0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KrSIru5imbehPll+wfTFwQofZ1wYDP5YncR+8m3U4wtHO9TIp
	UtLXoKPsvxTAmMK7WNWkdATCx784x3j0c2CMoB9fhN5z7zETyqiz2AiT
X-Gm-Gg: AZFdTZfd2PHP/jvgMsA6OybHngTbWdJY8wZvcbHQ+iO4rDhis5nNI7joOxG44Bnk3t7
	nxUVNBaIv6Vg8M+/1mvJNop+MlStXN1phbsb8BwO85QtwKCY9b9uN6dpz+GIsi1WgpGGmsYYJRD
	m1PmuccY3a5p3PgeudO19KdDLHJjyOYENhWYHh0NHDaJvafZd7WImbFOPGB1s72oppGKkYjlshE
	BfYSDmC65Ft8xL42lQXoKbveGe9sRol1Sw0NavLlC1//1fqlURGAymYKrdQ4Ved2xz0+BfUB1q1
	VHevyzAyZajcryBrjU7map72JyPZwVAhlwjUxIBSKFXv+5az5waodBYQviqnbveUsC1dL2Q4GwT
	4ubv/gkGRgwy0sQtkBry5fG3D/i45HRBfnfpOeZSaW6gay+D2daP1QEaD92n8J5qpVxsFLUlANe
	fLk2dxABLutDKUtMqstnItg0XoWooyqUYXPjA/AOD66YOzorqSTdHvkYUzOGrIY9L+yTcp1h3HM
	ipg6yHUikxl8X8DcKgM/dqrvYZMq3PjAsQvt/aJTTnhgt7ssD0kh8HfLnldt1o3AMZLsu1yEeY2
	1eYjHe1Ax953bUF3WrAs51M0d2LsdzxQ2QQTpv/Aku8rDlmR
X-Received: by 2002:a17:903:298c:b0:2e9:5714:6075 with SMTP id d9443c01a7336-2f03f117c82mr51260805ad.17.1795239049247;
        Fri, 20 Nov 2026 21:30:49 -0800 (PST)
Received: from localhost.localdomain ([115.73.20.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0433a3a43sm18751085ad.62.2026.11.20.21.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 21:30:48 -0800 (PST)
From: Nhat Tran <nhat.tranminhk2@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Lars Poeschel <poeschel@lemonage.de>,
	linux-watchdog@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nhat Tran <nhat.tranminhk2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] watchdog: core: Don't report time left for a stopped watchdog
Date: Sat, 21 Nov 2026 12:29:50 +0700
Message-Id: <20261121052950.287506-1-nhat.tranminhk2@gmail.com>
X-Mailer: git-send-email 2.25.1
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

watchdog_get_timeleft() calls the driver's ->get_timeleft() regardless
of whether the watchdog is running. It is reachable through the sysfs
timeleft attribute, which is world readable with CONFIG_WATCHDOG_SYSFS=y,
and through WDIOC_GETTIMELEFT, also after the watchdog was stopped with
WDIOS_DISABLECARD while the device is still open.

Drivers may not be able to access the hardware while the watchdog is
stopped. omap_wdt only holds a runtime PM reference while the watchdog
is running, so on a BeagleBone Black (AM335x) reading the counter of a
stopped watchdog triggers an external abort. Any unprivileged user can
hit it through sysfs:

  $ cat /sys/class/watchdog/watchdog0/timeleft
  Unhandled fault: external abort on non-linefetch (0x1028) at 0xf9e35028
  Internal error: : 1028 [#1] SMP ARM
  PC is at omap_wdt_get_timeleft+0x4/0x14
  LR is at watchdog_get_timeleft+0x24/0x130
  Call trace:
   omap_wdt_get_timeleft from watchdog_get_timeleft+0x24/0x130
   watchdog_get_timeleft from timeleft_show+0x3c/0x80
   timeleft_show from dev_attr_show+0x18/0x4c
   dev_attr_show from sysfs_kf_seq_show+0xa0/0x138
   ...

and the same happens with WDIOS_DISABLECARD followed by
WDIOC_GETTIMELEFT on the open device, once the module has idled:

  Call trace:
   omap_wdt_get_timeleft from watchdog_get_timeleft+0x24/0x130
   watchdog_get_timeleft from watchdog_ioctl+0x494/0x668
   watchdog_ioctl from sys_ioctl+0x128/0xbcc
   sys_ioctl from ret_fast_syscall+0x0/0x54

If the ioctl comes before the module has idled, the read succeeds but
reports 59 seconds left for a watchdog that is stopped.

A stopped watchdog will not reboot the system, so report 0 time left
when neither WDOG_ACTIVE nor WDOG_HW_RUNNING is set, without calling
into the driver. This matches the software fallback for drivers without
->get_timeleft(), which already decays to 0 once the watchdog is no
longer pinged.

Tested on a BeagleBone Black: with the watchdog stopped, both the sysfs
attribute and WDIOC_GETTIMELEFT after WDIOS_DISABLECARD return 0; with
the watchdog started through /dev/watchdog0, timeleft counts down as
before (59, then 56 three seconds later).

Fixes: 452fafed839e ("watchdog: omap_wdt: implement get_timeleft")
Cc: stable@vger.kernel.org
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nhat Tran <nhat.tranminhk2@gmail.com>
---
v1->v2:
- Moved the check from omap_wdt into watchdog_get_timeleft(), as
  suggested by Guenter, so it covers all drivers
- Return 0 for a stopped watchdog; this also covers WDIOC_GETTIMELEFT
  after WDIOS_DISABLECARD on an open device

v1: https://lore.kernel.org/all/20261120124009.24264-1-nhat.tranminhk2@gmail.com/
---
 drivers/watchdog/watchdog_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e8c1fcb53c56..b67a68316bda 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -435,6 +435,9 @@ static void watchdog_get_timeleft(struct watchdog_device *wdd,
 {
 	*timeleft = 0;
 
+	if (!watchdog_active(wdd) && !watchdog_hw_running(wdd))
+		return;
+
 	if (wdd->ops->get_timeleft) {
 		*timeleft = wdd->ops->get_timeleft(wdd);
 	} else {
-- 
2.25.1

