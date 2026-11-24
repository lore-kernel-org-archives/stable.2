Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564663;
	b=sMrHwsD8ckJkw78l2FQMjB/WlRdcg3unm+SHF6X0Q0p/JINO9ybxAMNpqDgB9U1Q1itH
	 GlfR5UMJ2rPC0CiS/rlhoSfdQ8mKeJbFNCWlrwbyRDtpsZchrHfqgOtXUHGQ6CPyItUfT
	 GbQJQi6NEH4I1FwiQpX9svzP09L+K8Snhy+ZbPRU9mkXm6eXKIqxKnXH7d+Z+Ena60pp0
	 UDlQsXYE+NCssyFvGSl7Nog5QK5/FBBMXRnUDHzsaKlSDb9XIAU7YCxGZNfLE67SkKlGV
	 M7TYBcVbU9Fb0cJ901sgdLs24i+6ypRaM1MmuNJ8d2YPLaz5QD3VpinHdQQWWC9kOgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564663;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=zCpEUkgnC6nNW718VYsVFX4l9kDyJsq5iPDHI4it1XI=;
	b=P7Sz//3UokFjEFh0kh7edjdt5L/PFjmn7JqikTt6zuYErcLzPtAsgFh+NOAXv34sOCQT
	 9sbm673LLCV3v8R0PVIahdHq15GZgtQqQyKk6HelhwgM5hhl0Vqy4PZAOzSC+f4O49dId
	 uuNT0p9WgOeO8f0LGb8CTeF0EHxNsDVy88HRZoC892ICvVpsUMc8rUuZOKmgA3D3Z7eVv
	 QmSh2QPLDMJOXdqiWH7R61+iBXtvEE9aO1t3MA/PN3qvnywZKvdB/LCxcpVYaM48xU/3R
	 Q3VQVzGCSl0wmyq8pcJcEDHRnwEgRjlEw4s6cTnyOUeeT5AjxCOdQyEYkWpbasijbTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=RclqWh0z;
	arc=none smtp.remote-ip=195.10.208.46
Received: from mout-b-106.mailbox.org (mout-b-106.mailbox.org [195.10.208.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C4606A33C;
	Tue, 24 Nov 2026 23:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 607C4606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=RclqWh0z
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4jZ09Z1pQ0zNmCY;
	Wed, 25 Nov 2026 00:57:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCpEUkgnC6nNW718VYsVFX4l9kDyJsq5iPDHI4it1XI=;
	b=RclqWh0zW4yQcc6GrRBXcV9uuCLN0ckFv4ZxT0YoXpcuqJlJWSGbIK6KLgk+uYkkNd0UgF
	xAGL/od2acr9mpURA3z2IXVhAy6Qv0rbpyWqj4dMeMJz1B7nOl9ElXnE7LxuQXxdoUGDgw
	GqHTIYCt8AaXki0f92mpy388pRppX5Ewg/140NJZbj3/WTrwAYE19ydIUr7i3DLhssX3S/
	CPi7ODZNgMYrSkMQuHatkpwUpZ/Iszr5eBtz9Wk11lrEllMWqPuNEMbKSQ0xG1vbMELCyM
	2ONQiJAs81XbhUVSLe+mll8JeqgTcnUxciVOMiVVP5pXqIousqqGw+ogm5HjnA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Janis Edvarts Lacis <janislacis06@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 6/6] igb: only allow runtime PM if the device can wake up
Date: Wed, 25 Nov 2026 00:57:21 +0100
Message-ID: <20261124235723.1135808-7-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124235723.1135808-1-antonio@mandelbit.com>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jZ09Z1pQ0zNmCY

igb lets the device be runtime suspended even if it can't signal a
wake-up from D3. Such a device doesn't notice the link coming back, so
the port stays down until it is resumed from user space.

Only schedule a runtime suspend if pci_dev_run_wake() is true. Devices
that can't wake up no longer runtime suspend, even with power/control
set to auto. Checking it when scheduling the suspend, rather than at
probe and remove as e1000e and r8169 do, keeps the runtime PM usage
count balanced if the result changes while the driver is bound.

Tested with the 82576 emulated by QEMU.

Fixes: 749ab2cd1270 ("igb: add basic runtime PM support")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v5: check pci_dev_run_wake() when scheduling the suspend rather than
at probe and remove, which keeps the usage count balanced (Sashiko)
v4: no changes
v3: no changes
v2: no code changes; mention the tested hardware

Note: igc has the same issue: igc_probe() also allows runtime PM
regardless of pci_dev_run_wake().

 drivers/net/ethernet/intel/igb/igb_main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 80ae03d..853bdf4 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5625,6 +5625,15 @@ static void igb_watchdog(struct timer_list *t)
 	schedule_work(&adapter->watchdog_task);
 }
 
+/* A device that can't wake up wouldn't notice the link coming back while
+ * runtime suspended
+ */
+static void igb_schedule_runtime_suspend(struct igb_adapter *adapter)
+{
+	if (pci_dev_run_wake(adapter->pdev))
+		pm_schedule_suspend(&adapter->pdev->dev, MSEC_PER_SEC * 5);
+}
+
 static void igb_watchdog_task(struct work_struct *work)
 {
 	struct igb_adapter *adapter = container_of(work,
@@ -5777,8 +5786,7 @@ no_wait:
 					return;
 				}
 			}
-			pm_schedule_suspend(netdev->dev.parent,
-					    MSEC_PER_SEC * 5);
+			igb_schedule_runtime_suspend(adapter);
 
 		/* also check for alternate media here */
 		} else if (!netif_carrier_ok(netdev) &&
@@ -9741,7 +9749,7 @@ static int igb_runtime_idle(struct device *dev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
 	if (!igb_has_link(adapter))
-		pm_schedule_suspend(dev, MSEC_PER_SEC * 5);
+		igb_schedule_runtime_suspend(adapter);
 
 	return -EBUSY;
 }
-- 
2.56.1

