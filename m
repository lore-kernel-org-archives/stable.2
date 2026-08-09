Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A15B1AF0BB
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786274316; cv=none; b=mxGBVhjibVVBmlOsIZIofFQBOX6hleuTlv1cH6TGycEEeLesuGCY0pN7E/FkvchsWfFHDLB2fT30XBoQM+4YsImB5zPBXeum1zpAT1VV3IeB82O0YOgH8VX1klZ0IcR6y4a/tLrI3ZgSb3SDKfuQfdayWsjZuUJRtdJwPgIXoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786274316; c=relaxed/simple;
	bh=+9ZjbX4UQFviH7Agoe1xwf+FTfMycR2CovtparGje7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJMgomjcrtRcLokSiFJ/olMtBWkoNLO2O5RJBlCu3cDUTzWEpx89RXcw6Vknoop4IrbtvhHS1NwFGDWcrCIv9Q2Cls96f1VENfPDSXo6+7Zcct3K9M1no4w9D6ZPN+P4KnZORpC9RQ1Ay/WLaeKCPJ5ybmb9/ZHyRSyayp2nuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=Dg1Evw9s; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="Dg1Evw9s"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-383cb94f742so929609a91.3
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 04:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1786274314; x=1786879114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjK25Df0SDLvqraZ1GZPGP7sM8hZJyuv8qAUSFjj/ss=;
        b=Dg1Evw9snn4gy5Oi14l9Gj1Dv/z8cHhKe77VXTav4lwCEbPZMCmco0eYfG2zl+3iLA
         rKPtQlu65QiSqSexQ03wqctmOVTU1KbFV2uUIyZXhsd922fLc3iD014rX/In6fIIT07b
         CnDpBKhITN8l0FfLwORCO7ZdJDPIvp+P2V1jSnq03t7A+/8tRvB/xPXkrmYRotINMVAi
         8y7jlJ8iYJjV50nMZZWEKR+wIk211rgNK9snnUfxm/eDX1BvHc0kH+0lb6m13gZyU4gx
         ffH+xa5ynENlIUjYtVSU7hZ7ljmr0O0k2YFUkj0V9dxpiClgP8LGBQtgysknIcup1jIk
         x/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786274314; x=1786879114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjK25Df0SDLvqraZ1GZPGP7sM8hZJyuv8qAUSFjj/ss=;
        b=LJkk0hEZidtgbIodDnbAuBtBVSJGr3Z3eSYROdFCIeAjvJhsATfBCzu/2C+Nd6vfNP
         6jFZK+SQfAqe7Ndy127EzfOJdZgWoyX2GXOvsvEaaMgPnoo8Pcrf1lX8ukh46rxyQ1j7
         7TFkgj/LOWscTiF5BZuHR1Y5NvW7/sxl0lfpbtUMB38+hnPLtJnp74L8Dm/T8W4dltOT
         Su1h5OsQemZxWtFlI6B/QU8dnAvN2zU0rwj7UljyKGr5hoS/tgp3fPUHUfxtOk80SUMl
         Dlj6WjTHRIDfnGB1EGOa23xuNuVTlYXC2WAg9reP1QzXAvJiaSyORAIiXIZ4yk0QLJ0/
         LmAw==
X-Forwarded-Encrypted: i=1; AHgh+RpbCFohuFlYB3Bvw8ZwmB8fdKnelfOtIpdDLLDQGQWCDAYAPMjvXc9XSEKMXDi1y9sm6WcR/3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YylNkxBE//F7oc/LjS0N+6OS3eZi0cZ0GYKZTrlhjQReXLlpDhI
	ndujg0oNKVjNrE/aPLN1QJcQWmiJTeHKbJcfJigCk3W36glSUFkEYKqTVZ5a1md7B2a2mk8Incd
	DWkzfKlw=
X-Gm-Gg: AR+sD11SMFLNYvkirI7HkuwwCjdmRGPuyecrd/5KQnNu/GHTJj57gEZ9JycDUnGjypx
	RRvD1R6hzJH22m0RCOvkQCBtAcTuOosFG6joPTbCUsatsTiwXMgeveLxGByYTR+d8tEIfV4TXX+
	KD5X4YHQYDk97BI8evCnN7Q7TbkWgdyyXtVsJfoxRRQWHVh9krCLV7o3YpngftbDB1eUJbvNRoe
	e5cASNEtdszP88p3mjWCxLKCUQ/lYrk11Aml29lwcpe5gqAHC+d6JFBYk5B6jbWQipEw5TK6ppc
	qNyPk2TGquzMOCCW5+LV7y+TnS3JIy9Hc6YbKC6XSx6UIirfZ0WpRVbDVnsieq+0WDfwAvakkt1
	HG+tzcpBxHaqRjX4XO4z/6XKHS7jfK/O3mF79uFp9WxnmWLtBCDU2txNmdyU1nY0YczYgp5DVTP
	riYQex7UOhFFVXH/x5fGY77ehx9e+xBGOOF2ELDr2Y474Yw4OTs2QnnsUc8yrZArs5PiuNbRbor
	BUdCixXAkwH28NT8ZEtqJRxVArB
X-Received: by 2002:a17:90b:4430:b0:390:b41a:b92a with SMTP id 98e67ed59e1d1-390b41acf2cmr11096291a91.4.1786274314360;
        Sun, 09 Aug 2026 04:18:34 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b136c67bsm4138321a91.0.2026.08.09.04.18.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 04:18:33 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: idosch@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH net] vxlan: do not arm the ageing timer on a device that is down
Date: Sun,  9 Aug 2026 20:18:29 +0900
Message-ID: <20260809111829.78834-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_changelink() arms vxlan->age_timer whenever the requested ageing
interval differs from the configured one:

	if (conf.age_interval != vxlan->cfg.age_interval)
		mod_timer(&vxlan->age_timer, jiffies);

There is no netif_running() test, so the timer is armed even on a device
that was never brought up.  The only synchronous cancel in the driver is
the timer_delete_sync() in vxlan_stop(), which is .ndo_stop.
netif_close_many() drops devices without IFF_UP before
__dev_close_many() runs, so that cancel is skipped for such a device.

vxlan_setup() sets dev->needs_free_netdev = true and age_timer is a
member of struct vxlan_dev, so free_netdev() releases the allocation the
timer lives in while it is still queued on a timer_base.
expire_timers() unlinks the entry before it loads timer->function, so
the timer core writes through the freed object's list pointers:

  BUG: KASAN: slab-use-after-free in __run_timers+0x208/0x654
  Write of size 8 at addr ffff00001adace68 by task true/192
   __asan_store8+0x84/0xac
   __run_timers+0x208/0x654
   run_timer_softirq+0x154/0x18c
  Allocated by task 189:
   alloc_netdev_mqs+0x64/0x720
   rtnl_create_link+0x4ac/0x520
   rtnl_newlink+0x758/0xd00
  Freed by task 191:
   netdev_release+0x40/0x58
   netdev_run_todo+0x4a4/0x8c0
   rtnl_dellink+0x200/0x4e8

The rtnl operations involved are netns-scoped, so an unprivileged user
can perform them in a new user and network namespace.

Arming the timer on a down device never had an effect: vxlan_cleanup()
returns early on !netif_running(), and vxlan_open() arms the timer for
any non-zero interval once the device is brought up.  Add the missing
test.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 40051c4dcad5 ("vxlan: Allow changing ageing time")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1ded27768a97..824144bb7774 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4500,7 +4500,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
 		err = vxlan_multicast_leave(vxlan);
 
-	if (conf.age_interval != vxlan->cfg.age_interval)
+	if (netif_running(dev) && conf.age_interval != vxlan->cfg.age_interval)
 		mod_timer(&vxlan->age_timer, jiffies);
 
 	netdev_adjacent_change_commit(dst->remote_dev, lowerdev, dev);
-- 
2.50.1 (Apple Git-155)
