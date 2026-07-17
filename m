Received: from e234-53.smtp-out.ap-northeast-1.amazonses.com (e234-53.smtp-out.ap-northeast-1.amazonses.com [23.251.234.53])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88E3F7A84;
	Fri, 17 Jul 2026 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286035; cv=none; b=Xz0kuS/kaRVeoEQhj5krTXM71MPU5/27BaBs871NYeHvNmrfkFSVeEZtKakoiYm3Vdo+rxgmt9KqypX8zkTQ7A8e203N8cwL1cNXUBzOcA0Bzhh0Fr3jlbIhKgCyIlJBruKTDF+z9/+K3TUZe5lk2/Dnav7P4dUz6tdUztGNPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286035; c=relaxed/simple;
	bh=xWCYjiYbaynh1mEZgNMgNviDRlvyEcEP7+Xg/gNItPE=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=N+sLIKHn+NNcU/l5uM92IPTxaJeEatkhZoa9MXDYSzXWt19YnICuO46tSmoqIcOxfgaPWPn+Q0+sIKrLuxkdziG3/jaEyLpU2diGdJ+yvNf9P3/RVCtzvYdka6GiCGkFSogGw1D1sJNXwLpND22CQWNfo3nPdWMPu7RGfdjlNUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clipsneko.cc; spf=pass smtp.mailfrom=send.clipsneko.cc; dkim=pass (1024-bit key) header.d=clipsneko.cc header.i=@clipsneko.cc header.b=WD9sNtxx; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=RNzRRxh/; arc=none smtp.client-ip=23.251.234.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clipsneko.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.clipsneko.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=clipsneko.cc header.i=@clipsneko.cc header.b="WD9sNtxx";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="RNzRRxh/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=clipsneko.cc; t=1784286017;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=xWCYjiYbaynh1mEZgNMgNviDRlvyEcEP7+Xg/gNItPE=;
	b=WD9sNtxxEl4X+9vKGMX31nqo5ZolFzPGMU9i4UR2ltWo4U2tq30tBMuSzh3WqJcv
	9kLzvjvZF2F5CTWzYtDqK7CqlYabWwSL283M2FGbFFuCGNTt03hgUuFDzizWHkeU6se
	iok7EJ9IBgTgCG5wTfmkaknHKGidALHnzFJeSB1Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1784286017;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=xWCYjiYbaynh1mEZgNMgNviDRlvyEcEP7+Xg/gNItPE=;
	b=RNzRRxh/bxIUUueL1JTdNNb7T/lCpLH/ytpUo2YgIixQGs8rb41DTd2/VMmY8yYE
	9nio3tT4YqkZ2xBkshVm0ndO95pv2a1AkWuCFgVQJlWjnoktZUCPw4XHHcI1bZbvvSb
	2myVBShVaL84jbwp6GDuccSmvL0jsWwh1AlJ8fSw=
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717105748.1194693-1-goliath.zhu@clipsneko.cc>
References: <20260717105748.1194693-1-goliath.zhu@clipsneko.cc>
From: Goliath Zhu <goliath.zhu@clipsneko.cc>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, goliath.zhu@clipsneko.cc, 
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: mt76: skip NAPI deletion for WED RRO queues
Message-ID: <0106019f6fbbf57d-e08cf023-2c26-4186-81c7-f5f09f3ecc40-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 11:00:16 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.T/9jWCDXa31y4gauYStyPOpWTrkJmzALuy1iq6HUX1VjlgPUmzq7ZFI3EvLLZ39jJzv+2I2PP/uhCYcS7tWi4X9gcnDJGZZVVULSu7C54EK8m7rG19VNcAtmWQSUeF+Ydw79jCgmJ2QuxiKzKA17O4fInWrH2kml2UpMwmQGC6+Ow2RWdTIMP19sAecDaYp3:1.ap-northeast-1.tL27A1JIpKR2Y51a8BkHZBekDcSR82jwOhKrSwgRw2U=:AmazonSES
X-SES-Outgoing: 2026.07.17-23.251.234.53

Commit 6b470f36616e ("wifi: mt76: Fix memory leak destroying device")
made mt76_dma_cleanup() visit WED RRO queues so that their page pools
are destroyed during device removal.

When WED is active, mt76 does not =
register NAPI for these queues.
Calling netif_napi_del() on their =
uninitialized napi_struct can
dereference a NULL napi->dev.

Keep cleaning the RX queue and destroying its page pool, only call
netif_napi_del() for queues which have an mt76 NAPI instance.

Fixes: 6b470f36616e ("wifi: mt76: Fix memory leak destroying device")
Cc: stable@vger.kernel.org
Signed-off-by: Goliath Zhu <goliath.=
zhu@clipsneko.cc>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git =
a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/=
mt76/dma.c
index f8c2fe5f2..ddcfb9e46 100644
--- a/drivers/net/wireless/med=
iatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -1189,7 +1189,9 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q =3D &dev->q_rx[i];
=20
-		netif_napi_del(&dev->napi[i]);
+		if (!mtk_wed_device_active(&dev->m=
mio.wed) ||
+		    !mt76_queue_is_wed_rro(q))
+			netif_napi_del(&dev->napi=
[i]);
 		mt76_dma_rx_cleanup(dev, q);
=20
 		page_pool_destroy(q->page_pool=
);
--=20
2.55.0

