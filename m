Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794028724;
	b=O3LtvdA/kVLVtJKVW84pOQATkHLGM0VNhfQ/GrtrFyw1pQIGEdugCaU3h8RKqgY5OgIX
	 OeO4GkkO7A/j1qPY4XKQBgU4dymZKAPHvEzy98R/LUoFkGkD6dJcIoCLmsZjZ2ebtI5Vz
	 IVGnsKADMbohHJgt9/4T3XFVJ6EKOsHs0ydgI6fVOG59KKE1Zfatu9Q7WiQKN7K2BdKyj
	 LJkHi1+bHr4Vmo9Uh2jlgpO2iDTORVlndll3Fywh69gGWVB9SoOEwMGlWu1kpRIuhJiSC
	 aX+KNDhOjmtHWUTDM0Nz8ETsdud3p+YFDNHwhKuiYnXrHLdsZsswmVriqY4AGQLbjCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794028724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=69iwLbdEo82R3C2faWyiFypCoPu1ycnBrcOnH1bGBkg=;
	b=15RWgf7TI3IVrp2Set5zYHMWn+VE63toZVknmeo9Fjtw3eWjs/ZtmdZnLJVdsIEDoGO9
	 EkUyL1Tptnd8ZDV5iJXou+ARz3bEqBS7NDvBUTB/pbeTiIIegtoo4GQ2hV52PMHlFJmNC
	 ZG/mMhgRNRd2k44zFqgzLP1Rqo8YPhhNfkNrs96Kecihl7AxrdLFh2k+YmKu5Gmu4yXP3
	 z5nR8wVJPe7gE93MNlX1juNxiaFgObwJL4r9m3mbTAnSzj7bCbBRC1WJMPLADLbxT0vKq
	 HXb4ZJQDUkDJgdbfwRZ95xSz3WxmmRTtpfP6nf9fTpdSMN2WDsuxeyhgWMEzUcQPTxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5v5llPK;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC092606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 05:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC092606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5v5llPK
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so672887a91.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 21:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794028723; x=1794633523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=69iwLbdEo82R3C2faWyiFypCoPu1ycnBrcOnH1bGBkg=;
        b=h5v5llPKaFu3fMlhcSWhfngsLZGQd1TsUbhsX3QVDmc9B0roRkq/BB1xhC+cbZGT71
         gsoeU7oTfZsWAi4FaTjTShYUrrfBzMX2KNC8ZJG07iUr4Fc2Q7R8TiPEUchyrNx19LrB
         sqwcarkOC6aKMXpV/Cp0Cw1B2HWHmiFYt4rtur/gJiliNQXYcZSfKXqT4G8HJvCRHVwy
         ZFFKVW3bcubzPMKQD1u3aaLOPHRNoiN8P/lUJC5+aikahIHxco7AzjfW8tPNWgXcsfvq
         MOFVqI4ZGCxigpeA26DC4+gyp1BBT5m4egxv23UMlbSeskvfXVY06IrKv6VgBQ+vd8UA
         +lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794028723; x=1794633523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=69iwLbdEo82R3C2faWyiFypCoPu1ycnBrcOnH1bGBkg=;
        b=rtIExBUUcLyjamiN7dLqwqzH3VdLmAqI8pc/bZsa5WFnNkmYqJQVFj0auqXORaZPB8
         F2CXtrU6v3Fxrdd5FLuF7VnSKKlGt8xetFGLdkmKxsnM+zDEDYyvSlS3EtB2MErv73SA
         wQ9JDpHDN1nka+r8uPohAOerNAwt9eiYmrB3bmq4ulGdcQ8YWqaBgW6Zi8opNdWDZQxY
         1WwE0CEYKN66xUPK2sLhzBMPcUUFwpUO8p2XB+CM4k7HexL5UtvxGn4kUrNZ5xJV3Hnv
         3aQELebnXPzic1M+oJu7MbHT2MhYs3p8F+WM7pjx9RRU1Yc+ElYfNKNhf1ndf/l19Sta
         Y7qQ==
X-Forwarded-Encrypted: i=1; AL+hErGzMvBRgda8h2s6WDW8S4TxGq6QEHc5/gHC1GdapITP1HH2SUIRxWYQEZaw8JaMT0NkeGA2a28=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+Zu4lH+mkSp9Md0ZQcU+Q5OWcPFgs/uZQMlD0Yyc+yEWyrBDl
	O/KvUkdV9qjq0bwpCTGlmFvnTRL06kRe8qN+y/Odn5O70P6qhEeXWQxePmlt5BlF
X-Gm-Gg: AYBFou1amJjIVUIi4nHMIi7Ru0XATVSPISqIfBwdSd9cvwgznRhO8KpTaR6Yflaykww
	2bs+RUxAPQUgEz8gmCHsYkN6+MHWjJD1HUsgbYRaQ+yJhUTJTwqCnLgmdZrs7wGgh7SV0SnjxK+
	PrGNCqGNmLT5WpdYyCmecz09tlwd40s5OeP36iSa7K+Oifkeu9Em+lM6XY0XFrwhfrWd6n2Bdmm
	nTSj49CluPOpbrTqAqaHRyFr01iRWeTNnRnbp2/7i94WEnIiHT0IYCKVLXPBsWsUQaAasVXexLJ
	dLgMP/KFuthMHWRHnokBWEdB4V0V03bpAVYIarTf3IIc/6xv5+Gd3+lKthwXnWA2yGoTrhONycy
	cGfHvgkraD1YQ5omte2/Z9gqycI6zPwc/iFBJa2T9IK0vBXh+d55SmgM8+D5YI08hDkZRQRQHmX
	dd9B10+jZGMm5i5N+GriT5aY8yyfaJ1C/ThIymE0xlew0WPBrb9YIt5xhVKIK+D4aXducbTHgoc
	Hd/xWTamNfpmVFCKJ28qatjJ1ZXzfxTI+2LobeybpO9iqJCXWXuJEaTnxLP34pJirpZeg0mokIj
	SC4AnDP13rfUeGSgrfxdbhIHZO8bCrg9N7gtZ4/sG37rUPkR
X-Received: by 2002:a17:90b:4d85:b0:3ab:884b:659e with SMTP id 98e67ed59e1d1-3b0db6d7bb6mr4232399a91.9.1794028723184;
        Fri, 06 Nov 2026 21:18:43 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057c1c2csm1785860a91.2.2026.11.06.21.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:18:42 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/ncsi: disable the ncsi work before freeing channels and packages
Date: Sat,  7 Nov 2026 14:18:25 +0900
Message-ID: <20261107051825.3313019-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

ncsi_unregister_dev() frees all channels and packages via
ncsi_remove_package() and only afterwards calls
disable_work_sync(&ndp->work):

	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
		ncsi_remove_package(np);	/* kfree(nc), kfree(np) */
	...
	disable_work_sync(&ndp->work);
	kfree(ndp);

The state-machine work, ncsi_dev_work(), dereferences channels and
packages (it walks ndp->channel_queue with list_for_each_entry_rcu()
and operates on the per-package channel lists).  ncsi_remove_channel()
and ncsi_remove_package() free those objects with a bare kfree() right
after list_del_rcu(), without waiting for a grace period or for the
work to stop.  If ncsi_dev_work() is pending or running when
ncsi_unregister_dev() executes, it can therefore dereference a channel
or package that has already been freed -> use-after-free.

Commit a0ffa68c70b3 ("net/ncsi: Disable the ncsi work before freeing
the associated structure") added disable_work_sync() to fix the
use-after-free of the ncsi_dev_priv itself, but placed it immediately
before kfree(ndp) -- that is, after the channels and packages have
already been freed -- so the channel/package use-after-free window
remains.

Move disable_work_sync() ahead of the ncsi_remove_package() loop, so
the work is quiesced before any channel or package it may still be
touching is freed.

Found by code review; not runtime-reproduced (requires NC-SI capable
hardware and the state-machine work racing device unregister).

Fixes: a0ffa68c70b3 ("net/ncsi: Disable the ncsi work before freeing the associated structure")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 net/ncsi/ncsi-manage.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 1d63958..1c2dadf 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1960,6 +1960,15 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 
 	dev_remove_pack(&ndp->ptype);
 
+	/*
+	 * Quiesce the state-machine work before freeing any channel or
+	 * package it may still be dereferencing (via the channel_queue /
+	 * package lists).  Commit a0ffa68c70b3 added this disable only
+	 * ahead of kfree(ndp), i.e. after the channels and packages had
+	 * already been freed below, leaving that use-after-free window.
+	 */
+	disable_work_sync(&ndp->work);
+
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
 		ncsi_remove_package(np);
 
@@ -1967,8 +1976,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
-	disable_work_sync(&ndp->work);
-
 	kfree(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.43.0

