Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795873228;
	b=TDRg6HtlkIU9THh2qTMtOqkx/Re6ayyvQgCLg6RVx/WGdjA+r/gI/AM8qElRCO/y3Jj9
	 zhdxwmp7tyb26omQ4ohGjcL3SubCkaVQXZfxdC24FCCMeFy0kHtD9JiSInNQm4PA8+jP2
	 Pq66QzeByU8RCV3ekFbxqPYMIzE8e/S3t+Nhn+CMsvkStduIf+rvWQYe3iHXnbT4oIPdk
	 9MQrfBonAlFkE/Kp1DHu+F5sqFBg5TTixU+B3XiDeFcPUx2Mbu82nUwBV375CVJDr9Uas
	 5byXYN+kUDzNonxBZHpN83jgWW9jdCIy+dqfpl6sDt/LR4pKRS9cU8oezbkYpsaC18w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795873228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=QyFV4pisqndkw4NPxkRB4pgaLfPMNmkrYfYabK5Jawo=;
	b=bNjomG8iaUEq3gSswzt4FCWDg9VVXWvqU/wnj1bD0vVJvN1Lr3vV4tHs3TtTN+iqzTFS
	 UTBzxeQOtBXMYFwgZWzLnCSH6qMrbF3vlkMKuUsKo+jlMon6CWcBdC6sjYuZ6DMNBXquL
	 YbpQ2c3Ft24tpSA2lMXqXRFrjldXSys1F7dC2OZEHcXfsZaOnZtrepBnF133CbkHAXbpB
	 YAuYIO+XJS+LYJZpZZ0lcsvcemIeCWiLqOwgYMwBwWtOllu96HWp4xKkRpDL3jhH++78e
	 4OP5FYQuP6xc+b/I6MRDnJbwxj27Ia5R+zuNNBT9J4KOSAUlymYMEs6WIu1t30IyTPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hyy8BE7T;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C75606A321
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 13:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C75606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hyy8BE7T
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4ac08f4a0b2so6338483f8f.3
        for <stable@vger.kernel.org>; Sat, 28 Nov 2026 05:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795873226; x=1796478026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QyFV4pisqndkw4NPxkRB4pgaLfPMNmkrYfYabK5Jawo=;
        b=Hyy8BE7ThnPiEgCqVkJoKTCxCsy9TFJLNY9Xbv5dw5e02Rrpqietxr4bgIIee3ira5
         rGlIml89ZGFsNTqero2ajm+P+6KFgWdpvWDgVIFUsHkWV0YSOmP9p5IOi2uSFZzhWhVm
         4nkF3R9OtX/3U/3Ihmmu5ZB/MyM1gM5FkALLdcX3396e+lJnBqGDreoTxX+tG6rBwIS+
         TfZwdzqLM8QkLn++l+YSRlYqIIHk3mE16+ggxqn9QxL9vyuEw5m5IiM6gtjF2c3eNVJo
         LDE53a/PCBf71+FrgEJlYOD5cQ+dDSMbgoMdK+qcEWZC9FXSeY+U4q8+AD4eeWjhEjHK
         oN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795873226; x=1796478026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QyFV4pisqndkw4NPxkRB4pgaLfPMNmkrYfYabK5Jawo=;
        b=V8RA1XLmcIaXlGogppUz8TeiWnAkpUZ/ynAy1U2lEt7S6yWHh2DHEBD5zu3xOdYNpj
         +do5dmxnSsXfi6KshFq7z63SgWvb+HJQ933c5Qw5fRZy9XRRaaWtOpz5hnoAjGe13508
         1DAsb3sPpY6M+QvvbQLzFlw976IR5LGI9bAC8DNqrzqrNnsQgjndRcLbUPEWqfBiRmTK
         r8vU9yfqk4y7o09a1lpksjtBqn/+A0ESH6h5cUHjnbDfpUooFezVZ+Ar6ZoYBMgbZClM
         tZTcNkw5lDUY713rdqF7tqYJ1kNc1LO2rDzHkYATBE2TmD3P/FFg7nRtdQIwXy4dAKbo
         3VBg==
X-Forwarded-Encrypted: i=1; AL+hErHKeegZCY3dnwpU3ZPQMvVV7n++13B2rI09n8sXiRsL68KvTzvaT1jUUWpvWpxPfieRRPmBPUM=@vger.kernel.org
X-Gm-Message-State: APuU4Z95VsySMQx3IUxpfwafX1sqnYUBhbZBourlUsNx/rY8Mpzc6i/T
	ictKnpxP+Sb1cSkVWpCU5R8s7u+2DMeDzhI4SfHyLNQXVsEaqY3ChLRS
X-Gm-Gg: AZFdTZcPJ7y062sPz8yiNOnb+PmI2EOsqyacXmtDgQpRiENX2ecn8XzUn29CshMCnUA
	lFIC2++f58gf7K4V/VF/HKRMniVhOQxks/u7Qt+UkRWiEYJl2YjdvfoS7b7yijCxUjIsdfGnLXO
	+0cq5EXVz8wmF6CWgq8Q5dU0OQBrFk6CcZki7K3q7TevzYcx+l8BkTmbXL+S1I0O3A+nmsOgLGb
	RurTahTDvety3rcrQ2qWCG41zvGtNDgCeJOfJBUXcI4LIc+U0K7L8foY3l8AfEuwvhzN63aioof
	lrY20C+zwCP8k22hPoUThdZxC+650cYecLIeo6AvP/t8tupbmuY+eIhddRdDl7okkw9as4bEuQj
	gL9HTD9deO15IB697+W7tz3L+ZineqEJzRFZWX/BsRmWPot5JqLblp7uEx4o1oIbWJnxN2z+7SE
	xrMm4zt29wBKA00OtRnVvqYSIQ4N8+S4Nq18zSIYiFX7l6FwhQOuQobQncM1BtMUXo0BVPa3zSz
	it+F9vm8dsjEeG2VunH9qUSL1K/W1dhug2QMnsuXLCIK9iHvyxZ5IgTVuNU1K+lRLa7/IdHrXNV
	W/CMKVMBxdxdqFx+NzdABC369dfPvfbh8CMvTu/us9N/sXAmjh8/Quj7IuK3W+AlN6vPGcSvQ74
	8LiWHQlvCjSDq0XgrwQBSTBNoBM2re2wcElk=
X-Received: by 2002:a05:600c:4e16:b0:4bb:69b2:d3df with SMTP id 5b1f17b1804b1-4bb88813024mr568205445e9.25.1795873226378;
        Sat, 28 Nov 2026 05:40:26 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm1404838525e9.4.2026.11.28.05.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 05:40:25 -0800 (PST)
Date: Sat, 28 Nov 2026 15:40:24 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v5 6/6] igb: only allow runtime PM if the device can
 wake up
Message-ID: <ri6pk2cv4qsc3lyumnpskogyadfhhk2aybgwyvbpdfoetkrbjf@efy5saiqmdzy>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
 <20261124235723.1135808-7-antonio@mandelbit.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-7-antonio@mandelbit.com>

On 25 Nov 00:57, Antonio Quartulli wrote:
>igb lets the device be runtime suspended even if it can't signal a
>wake-up from D3. Such a device doesn't notice the link coming back, so
>the port stays down until it is resumed from user space.
>
>Only schedule a runtime suspend if pci_dev_run_wake() is true. Devices
>that can't wake up no longer runtime suspend, even with power/control
>set to auto. Checking it when scheduling the suspend, rather than at
>probe and remove as e1000e and r8169 do, keeps the runtime PM usage
>count balanced if the result changes while the driver is bound.
>
>Tested with the 82576 emulated by QEMU.
>
>Fixes: 749ab2cd1270 ("igb: add basic runtime PM support")
>Cc: stable@vger.kernel.org
>Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
>Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>---
>v5: check pci_dev_run_wake() when scheduling the suspend rather than
>at probe and remove, which keeps the usage count balanced (Sashiko)
>v4: no changes
>v3: no changes
>v2: no code changes; mention the tested hardware
>
>Note: igc has the same issue: igc_probe() also allows runtime PM
>regardless of pci_dev_run_wake().
>
> drivers/net/ethernet/intel/igb/igb_main.c | 14 +++++++++++---
> 1 file changed, 11 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>index 80ae03d..853bdf4 100644
>--- a/drivers/net/ethernet/intel/igb/igb_main.c
>+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>@@ -5625,6 +5625,15 @@ static void igb_watchdog(struct timer_list *t)
> 	schedule_work(&adapter->watchdog_task);
> }
>
>+/* A device that can't wake up wouldn't notice the link coming back while
>+ * runtime suspended
>+ */
>+static void igb_schedule_runtime_suspend(struct igb_adapter *adapter)
>+{
>+	if (pci_dev_run_wake(adapter->pdev))
>+		pm_schedule_suspend(&adapter->pdev->dev, MSEC_PER_SEC * 5);
>+}
>+
> static void igb_watchdog_task(struct work_struct *work)
> {
> 	struct igb_adapter *adapter = container_of(work,
>@@ -5777,8 +5786,7 @@ no_wait:
> 					return;
> 				}
> 			}
>-			pm_schedule_suspend(netdev->dev.parent,
>-					    MSEC_PER_SEC * 5);
>+			igb_schedule_runtime_suspend(adapter);
>
> 		/* also check for alternate media here */
> 		} else if (!netif_carrier_ok(netdev) &&
>@@ -9741,7 +9749,7 @@ static int igb_runtime_idle(struct device *dev)
> 	struct igb_adapter *adapter = netdev_priv(netdev);
>
> 	if (!igb_has_link(adapter))
>-		pm_schedule_suspend(dev, MSEC_PER_SEC * 5);
>+		igb_schedule_runtime_suspend(adapter);
>
> 	return -EBUSY;
> }
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
