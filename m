Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E948F03E
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816160; cv=none; b=OcgQTqYNwn1JTKxggb6sm/6KJ8dMZKQsjWBYeyW1714k8eeWhj4AMmUFE9CkEdB/WoRfItzOBJBJ05l6AaHVURXdbR4O3MEHJB+cSRAxbfFpCakZHmfGEKlPxtPreMvHM+eCST+siNZ+gtjJvKKeErO+44JUkEVNqHL1Z5jMa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816160; c=relaxed/simple;
	bh=XlFul490VKRcEk5vaJT9EI/O1nrlg59YH47xGm4MUP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng/vvZFJMNpSH7gmBa0hTPSIeuV/aEGgbk2LdbdlsE/l2w1OTKtA7qM9AIKn77so+j/S8wemQZCKwwCi3Rwshhp2wmHZFmw6rbqrxUsBX88PSqFu7ABNJvZryS+Yc6pKdicHujP5fIN7u32DytljbFmEl0AJ4bgfcrza0tGIr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBAx1gVN; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBAx1gVN"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso4991791eec.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816158; x=1792420958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQKIylR728XA/uR565QiA5dBGsK2t0B8QrzEzDCmYn0=;
        b=QBAx1gVNeuZ6+NZqV5KX4CxdbSpDSOKRzjszqwWIOYNVDpwcsstJmKPYXYpQCZXR2R
         Eba32Q1sgyC0p7IW12CC6WvRfZ0ejtYpfr2f2WxwWmZxmW3rNqTHZIfQv1kW1srhClGN
         maqXsVN3wyMSY2BqF6wat7FPczTJKLd3U1mpGFxWid16VTm+amumnHOPXCiDtp1QEjK3
         b1962l/6B8qvpcdKmPlnNiUDQ1uISKzgn4QbQC2swI7poM3wKKVvkhkQ1uX6h1VGgAzm
         f0kMywd8EWoWTzSBiDg7YgdgT0bMMVkmdVl7uNKMC1v2mMTDrZ2Q771TRDpW4YDpn5/w
         pz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816158; x=1792420958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PQKIylR728XA/uR565QiA5dBGsK2t0B8QrzEzDCmYn0=;
        b=fdqAruYFm88xiNmD3e7p5J1obsS5IhQh/a5HwiveT85yGPfs1xPp5qwPrzFwNVja/B
         L+nxOXdxDuCXcLlEFgzqM94r8bK9ycFyMY1cbwJUeyfrLkJhgoBt07Dnq8OdvpdfxDbL
         L4Fixigj8SkyGdnuYF1HPcnXhb8FJ0j3rXPFGe7OePLn8JjWsSL9HYvfhlNr8TL34aFT
         W0fBo8AvgydYenURRIQZYJ1DBs1S+83n1l4oGHCzJRFxu+ZPcxlGoEQ64dJmpkJQsV2C
         d8NUdLSfdKfGsSN+oES3cqi49JLGbQK4ZXGPGIu+hxDGb01fG6AU6FVoKnl4KQPcxB8s
         LtRw==
X-Gm-Message-State: AFq9FYJ+/gNejp5NGPL8yEbRYm9yfNELHGKKjq4J6gtcmBl1sK06hpFw
	mQTHKuD5dpuGkyLoz0ZTuuQku3fcQR8O9VDAt86Nn0YnwuSjbBeLtAZVbg381A==
X-Gm-Gg: AYBFou2C4H9pxeU7ObCI0mALmGj+GgYpgOgvBnWSGPWwOP9U0WML1ZzC+NivBSmCEvl
	dgMWrSa/X/5Ek3qcdCjjHlfHkKnzE5idrimRdxHNKmqW/whpvzLEwlZRnzzDBi9Kht6Xs4XSOWy
	T+gIykBTeCsIbWq1QN5kjc3TP53T98FEQ1Jb+BNlevC5hxgsl6pV+iMZh76sXl8nJYQqjPVYaeK
	foVVBF0JVpOjTJ4rIhgOMV/q5AgIQshXBT/W0pctA1cDbh0aHr+RdRufoTcR+aoxV55gSBEPxMd
	EX0aJzQlVn6i0TrsB0x9nwMy57B4Awl/ztSuSA3Pa8a1AcOkxhym9X1WpfXDan51roBhV4OMeUg
	/TKe88bpD4hRjvW8utpAn7pc4CyaJkfOOjc5cqKegIIpyEZeq77W4Qt8VclTOVFpHSP6ghG85nh
	5WYs7HebrFVf2K4R4r/C1N8V07wpCFHL1f0io2gOUpP4WSrpRWwPOG6RUWZIUkiNl2uZ8L28N84
	Q+UTu9a3ommk5RuWQ8JH22Sa+Zf0fzAmqb0I5FcVAsm3aerPtTi7g==
X-Received: by 2002:a05:7300:de49:b0:35b:b3fa:40f7 with SMTP id 5a478bee46e88-35bb3fa4218mr963504eec.38.1791816157911;
        Mon, 12 Oct 2026 07:42:37 -0700 (PDT)
Received: from DESKTOP-1E7V4GR.lan ([190.177.144.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb1e05esm35399807eec.25.2026.10.12.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:42:37 -0700 (PDT)
From: Cristian Papa <pcristian292@gmail.com>
To: stable@vger.kernel.org
Cc: nbd@nbd.name,
	Cristian Papa <pcristian292@gmail.com>
Subject: [PATCH 6.12.y] wifi: mt76: mt7603: initialize global station WCID
Date: Mon, 12 Oct 2026 11:42:31 -0300
Message-ID: <20261012144231.22154-1-pcristian292@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026101201-cathouse-overhand-5997@gregkh>
References: <2026101201-cathouse-overhand-5997@gregkh>
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
index 86617a3e4..64dccd039 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -230,6 +230,7 @@ mt7603_mac_init(struct mt7603_dev *dev)
 
 	eth_broadcast_addr(bc_addr);
 	mt7603_wtbl_init(dev, MT7603_WTBL_RESERVED, -1, bc_addr);
+	mt76_wcid_init(&dev->global_sta.wcid);
 	dev->global_sta.wcid.idx = MT7603_WTBL_RESERVED;
 	rcu_assign_pointer(dev->mt76.wcid[MT7603_WTBL_RESERVED],
 			   &dev->global_sta.wcid);
-- 
2.47.3

