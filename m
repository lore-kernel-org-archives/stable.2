Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB2490BE6
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816153; cv=none; b=hoJC5k+YeEhR8Mk8kbs9T9MxGYs5c79FazgSW4Pvr2Jh+0JCiReaVdHwOdJwrnINY4MB1qipbiGVwdMTGZ81EhnxHTFCFRL6qQCSyBEH3KLYr6+VnJLt6HjUuypljbs4YN6ZeNNWf7CsuTRxumr0FJ6D2KZx4DPwe0JPs8jSx4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816153; c=relaxed/simple;
	bh=GXcmEkDMXV0PJF6vQYXGBRUvm+yYuzWihlV54UWJ1Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rktsthCSULbjocZ0ZDftCjE2ree98cel3+Jmp9ES2dBoGeIyRS0IiwbwiyARrENN7NTP87tmGP0GBpaURgF/nF08afao8bnNTA+SKj5cxH3/GyWGCfYTtuQZfg3hMcyA21+6u25FQzonxIpdqxkkWReod2YDDmeuW7sRfHlW6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaSAS99o; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaSAS99o"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15ea896ddc8so2732754c88.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816152; x=1792420952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nYM3q/vGUWbIB533yoSZcGK47w9RfoM9szM2GCUz9+0=;
        b=WaSAS99o8ITyXEGctKkn9a8/KxLAVs5n/oG7oz3Bu9K5flCl0er4MOWXnSpFOyFP4X
         +OcbEXbhBQ0F3Kx2g38zqpyMxiMLer8HjZDb6V5gEUQs91G8SJ0CyJIM/P0WJlKTs/tS
         0xVdmuFGdppcDmFtEFtpVi3XpgsILwcm/QpOYEgaUx84ioGUOfuiA9Pvzz6Iy5GiFI6x
         yHiGuIyDlHbiOW9sOyPsSuuDLZETWIsK+dOJPutTGlMHi4JxK6vSYRnwR/IdPJ4rFO8+
         zKmemBTGVrcPVJZEqXN1DApJHEHnCx7GBhxV6X5qnoNEq7Vwt871kJjsphluLbKZqxma
         05jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816152; x=1792420952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nYM3q/vGUWbIB533yoSZcGK47w9RfoM9szM2GCUz9+0=;
        b=bwwjjPvY67HKZCEcD+NtH8aiyaJBmVmDBa0y/XjdkLJ1D/VHzP3hVqWsveMEqPoRy5
         my8EqDNsgoNUWDZNur6ro/2E7pqjXsJFix31eAZhPZulpxnq7dS2WeUCupWTwLnMMvJv
         dGZOc7H8pd4Rr3yacDWD9T1M+SH08mkLt2w0s49xg8s5I22Whpt2GRBlkkj9E8QFJQYt
         jOi2KvTWFnerE/ve0r4Mqg1nqmgvgdPZGNc1d1CP4SCmo6GvUq3UmTdmOedAQpW8Z0KC
         CvY8Vn7YyAKVUM+SxaSg2Oe0mEwLdWPCxqhRCwxslKA8/fnx2ff+l06Ka07IsnATm9hS
         HgoQ==
X-Gm-Message-State: AFq9FYKDVViAY0UnMZcYNb7f2x1pkdsDI+qkIE7SEpRN+MtzfLB8W8Ol
	xIIH2/7S+scPj9RAibSgUWSz3bkjzQRAnRrQaZhbP41MCDYCPwwyL2SPQP9F1g==
X-Gm-Gg: AYBFou0BLwVfIEPxNQIgLnwN0dlQ1oFIFLwzFMRxF4B4btUXdzqeovW49fNagQdMOxe
	fCDe4TNUtDMlSH7T93ie+peL6PJ64rTagkm8qgGNd7SzS6wkadHnXrvgsTtY88z/Nc3m8g3z9ZU
	0mbs9mXL3Aw+o9scpvoA/0uXyGDCw8uHu6u/EeB1ccfsfMdcOmZ6Iguf+aF6xNepfLQoicfI2PI
	FlJJ9jw0xXUiFxTgbrkmvqK3yg6IITOQJbbNAcRErP7HNai8DQ5t59Txjm8AQQ4nFnSTtZEyyfp
	/90jrB56MkgYyqLo8gDLqe7yzT+3DQZq5pbjBDzNYm0rJ00pYrnU8Leb1kyK6iOmGnNKv5/v6KM
	3gDc3wC3NZ1H1mqb3O0QANJM2TUeEN0+pjrX32HOGWu+tg3jcmQY300ZQYvfZd7kgBCdVY7TGxs
	ABMHNEKGV5z1o3+MtxaaLXuYnyvGufAM248mZe3r8E6/sXOk7vIs6cJgh2yYBUoh2ANaaS1LB5u
	ovuGBj1kxwyuHGPrAI63p4ph5l4fXQcXXowMeo4X/M=
X-Received: by 2002:a05:701b:230c:b0:143:2967:c0b1 with SMTP id a92af1059eb24-16a5fc91121mr13807483c88.25.1791816151474;
        Mon, 12 Oct 2026 07:42:31 -0700 (PDT)
Received: from DESKTOP-1E7V4GR.lan ([190.177.144.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becb11sm28575777c88.4.2026.10.12.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:42:30 -0700 (PDT)
From: Cristian Papa <pcristian292@gmail.com>
To: stable@vger.kernel.org
Cc: nbd@nbd.name,
	Cristian Papa <pcristian292@gmail.com>
Subject: [PATCH 6.6.y] wifi: mt76: mt7603: initialize global station WCID
Date: Mon, 12 Oct 2026 11:41:50 -0300
Message-ID: <20261012144150.21849-1-pcristian292@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026101201-tidal-cinnamon-5943@gregkh>
References: <2026101201-tidal-cinnamon-5943@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 456de496b53ae73e6e3020fec815dbdc88aa7c07 upstream.

mt7603 uses a driver-private global station WCID for frames that have
neither a station nor a vif, including frames injected through a monitor
interface. Unlike the core global WCID initialized by
mt76_register_device(), this WCID is published without ever being passed
to mt76_wcid_init().

Since commit 0335c034e726 ("wifi: mt76: fix race condition related to
checking tx queue fill status"), mt76_tx() queues every such frame on the
WCID's tx_pending or tx_offchannel queue and links its tx_list. The first
injected frame therefore reaches __skb_queue_tail() with an uninitialized
sk_buff_head and dereferences a NULL prev pointer.

Initialize the WCID before publishing it.

The fix was tested on an MT7603 PCIe device. Three wildcard probe requests
were injected through a monitor interface. The hardware queue head and tail
advanced from 0 to 3 and a second radio captured the third request over the
air. No oops or reset occurred. After restoring AP mode, a 150 MB transfer
also completed without a reset.

Fixes: 0335c034e726 ("wifi: mt76: fix race condition related to checking tx queue fill status")
Cc: stable@vger.kernel.org
Signed-off-by: Cristian Papa <pcristian292@gmail.com>
Link: https://patch.msgid.link/20260904010702.16306-1-pcristian292@gmail.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ mt76_wcid_init() takes no band index in this tree; drop the argument. ]
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Cristian Papa <pcristian292@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7603/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 0762de3ce..02d7b36ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -222,6 +222,7 @@ mt7603_mac_init(struct mt7603_dev *dev)
 
 	eth_broadcast_addr(bc_addr);
 	mt7603_wtbl_init(dev, MT7603_WTBL_RESERVED, -1, bc_addr);
+	mt76_wcid_init(&dev->global_sta.wcid);
 	dev->global_sta.wcid.idx = MT7603_WTBL_RESERVED;
 	rcu_assign_pointer(dev->mt76.wcid[MT7603_WTBL_RESERVED],
 			   &dev->global_sta.wcid);
-- 
2.47.3

