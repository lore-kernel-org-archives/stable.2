Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163851;
	b=Gl9CQPJyPXPBqCRBWJjBhHGAueK3QJ3ChlgVJV3SMde67LBQsno1tfsqrQULWVMkoOWA
	 q/kxYdYRK0n3d4M/KGWc3Sr7N2K84Ri6TqEeLO45y+U5hwUvYLEigUj7j85EMtEVpS1L/
	 zfvnoPxcQ6wxNCmeIXetUsuuRCajp+FM++AUaEBUEb1akYMtk8erI6OqX4I0DQb8IrmIA
	 7r0lhmOQQgQQZfvnzS7ZrEaro4ZSVNsRQN50+q28lqfyIOkxkw0YlncZBQoiKW+5QZp83
	 rtCMsb6Uk+K4+rN7Dzo/4zixAT9vyNhiBEkDwwVrvDOZXY3AIsKh9GjYt6QNYK9Zi8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163851;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=iN3NuJW0NrAQeJl8hnA8WPW47zZnm0NMu3n174y6fXM=;
	b=J0NH9dMc1VEKoywC3yUsY+hDo76lMc7A+YfEKIBU2YtOU3Z2eK3TostLzODcwAc7arpR
	 i06ry5oQo4G1EuIjGuIGLtzppb3YJc73OCoakjgi8zYZI7J+qte03yQpuqb658C2H/HnK
	 jZ92DsFsyqMxgVEUFoyZ+kCt25Nguerf0UWuduhexIbJTDaEjgZ2DpEiKjGFTz1WhBAxm
	 n4ZhPiCXTKzWdZ9G7+7Zo9/fAefSKkmMBl89JalCpZ0VIU76GTDT7RzcUGxWi28huLGlB
	 aUkJdhqVPh9oSNMb5CJMY8wQU13R9Yh3iIVTeySUA/+xAiUKzu0flB70ioZTF6Kr8NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HQ6cD0h1;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD24606A333;
	Wed, 28 Oct 2026 05:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD24606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HQ6cD0h1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iN
	3NuJW0NrAQeJl8hnA8WPW47zZnm0NMu3n174y6fXM=; b=HQ6cD0h1/ga2mBgH7b
	v4u6RdpotSm66iY/hFJ82F6RHdIpA2JkGmUcZx5vcHTJWp0tc+KG5k+ONejxnTlF
	FEgVTjtCKnZiQH4jmmo4yLDISNBFGjcjj9UzjbNiO2vq+SCgthrw4cuHwC6v15Eh
	eEimVhD5r3qe+yaxv9nQBgCzI=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X28rguFqvXzDCw--.30877S3;
	Wed, 28 Oct 2026 13:03:41 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Michal Kazior <michal.kazior@tieto.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/4] wifi: ath10k: clear monitor interface after add failure
Date: Wed, 28 Oct 2026 13:03:34 +0800
Message-Id: <20261028050337.127464-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028050337.127464-1-yaojiale02@163.com>
References: <20261028050337.127464-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3X28rguFqvXzDCw--.30877S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4fGw45Gw4fuF4kCrW7Jwb_yoWDCwc_CF
	4fGwn3Zr47Ar15tF48GayxAry0yF1UXF93try2qrWrAw43XrZYk3sa934UuF97Gr18AF9x
	CFnrXFyYvwnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0sID7UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7w2++Grhgi3cHAAA3A

ath10k_add_interface() publishes the monitor vif before recalculating the
monitor configuration. If that operation fails, the interface addition is
unwound but monitor_arvif still points at the vif that mac80211 will free.

Clear the published pointer before entering the common vdev cleanup path.

Fixes: 500ff9f9389d ("ath10k: implement chanctx API")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 8e604697d6c2..36b694ae6de4 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5875,6 +5875,7 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
 		ret = ath10k_monitor_recalc(ar);
 		if (ret) {
 			ath10k_warn(ar, "failed to recalc monitor: %d\n", ret);
+			ar->monitor_arvif = NULL;
 			goto err_peer_delete;
 		}
 	}
-- 
2.34.1

