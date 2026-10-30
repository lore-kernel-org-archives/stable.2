Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375242;
	b=hdv05ufFFotNnIj1aWrEPQydZmI/ZV8paswpI7ucnqwaH8eut5hr6MuItHo8NaiAapO1
	 zdhmfqeh0Oyeoa+CUzCiJBwyWf3Y/aDLZMfbE8nL1Y0M8FK1gz8q2ileQGY4bAWXn22C8
	 kJ34IE6vZN/KMY6l1K64+Rs9rIQWiuI1gqnx0wEtsGQB/44/SnCT0beVYDh/6slS2Bsa2
	 LhwhEbtKVE/uw0xEURD4Ar88AhB/lqt8IiQzgx4Q0wodgtmH9J33i/W0maZPPd/su0gOs
	 AhW/XWc9tpyrKVFH2qI3KujFTgqFkRh3364O6Lq5rJoS8LtZTn2v/wse3HwwrmN5UTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375242;
	h=DMARC-Filter:Received:From:Date:Message-ID:To:Cc:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=TkzP77r82PgJhlEt37DzzRPlLBoRcB+18qVguFptgJo=;
	b=tEoQy2TK3RCCcuR0vs/WZNm10WRxgTgsFucV12IvFf+Bf6zApzqUPrxrzs5NviSDFkOh
	 8Axy1K5ubeHMeU4ExbxI2hDMcUnRlP2vbO3ogjAgrUZkHJHAHp+t0VwbvHS7D8F0Sia6h
	 MPLgjerlNQ2mdNsll/y9iUs3zxPQ/hJcZ2qK07k0E6ewic4E+bAVYiQV0gML6SIWJiiEV
	 q4omFiRH3Hm36mP6UiP/U6rZDKuVQTNj7lyOtTFieZWUISzLgEPpHmwzPWVKEDiKBH/dh
	 IgPSUEGnS0gnsGgQIcCeFlO0rzOehvaXuBZ2LV9qpCTmxvJLZLh1+8vxfpXjBH3ehYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=AuuVadKi;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0C606A31D;
	Fri, 30 Oct 2026 15:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0B0C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=AuuVadKi
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [61.37.18.110])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52f6740b9;
	Fri, 30 Oct 2026 23:47:11 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Date: Fri, 30 Oct 2026 23:47:10 +0800
Message-ID: <179337523079.51423.6573078122047317758@stu.pku.edu.cn>
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, zihanx@nebusec.ai, stable@vger.kernel.org
Subject:
 [PATCH net v2] mac802154: use pinned interface for beacon transmission
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa18d7e5eeb03a2kunmc338adf345e31
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSk9KVkxDGk1CHxgdGkIYSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVITFVKQ1VKSktZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=AuuVadKiZUHGg7jF8BFp+9vUdOdppkQmeyo8V1Ww7qXC1qEpAqXMtwJbLZ1SayoqJ3aG/QxHZjJoL5wEyKwGfIZskXdJbM3kX33jue0UJfEDdNWTCMQHKRCzrrZJdhurLw2YQfnFSPbQRoLaizcNiHKUPxJRJoPZikJ1/hUgW0w=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=TkzP77r82PgJhlEt37DzzRPlLBoRcB+18qVguFptgJo=;
	h=date:mime-version:subject:message-id:from;

mac802154_beacon_worker() looks up beacon_req under RCU and takes a
reference on the selected interface's netdev before dropping the RCU read
lock. It then passes the selected wpan_dev to
mac802154_transmit_beacon().

mac802154_transmit_beacon() ignores that argument when choosing sdata and
reads local->beacon_req again. If the beacon request switches to another
interface between the two reads, the worker pins the old interface while
the transmit path uses the new one. Removing the new interface can then
free its netdev before ieee802154_mlme_tx_locked() dereferences it,
causing a KASAN use-after-free.

Derive sdata from the wpan_dev already selected and pinned by the worker.
This also removes the redundant RCU lookup.

The reproducer hit the use-after-free on two separate v7.3 KASAN boots
before this change and completed without a KASAN report in three runs
afterward.

Fixes: 5f26a690e8ef ("mac802154: fix netdev use-after-free in beacon worker")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
 net/mac802154/scan.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index d393b1f..9f0e45b 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -353,7 +353,6 @@ int mac802154_process_beacon(struct ieee802154_local *loc=
al,
 static int mac802154_transmit_beacon(struct ieee802154_local *local,
 				     struct wpan_dev *wpan_dev)
 {
-	struct cfg802154_beacon_request *beacon_req;
 	struct ieee802154_sub_if_data *sdata;
 	struct sk_buff *skb;
 	int ret;
@@ -365,19 +364,9 @@ static int mac802154_transmit_beacon(struct ieee802154_l=
ocal *local,
 	if (!skb)
 		return -ENOBUFS;
=20
-	rcu_read_lock();
-	beacon_req =3D rcu_dereference(local->beacon_req);
-	if (unlikely(!beacon_req)) {
-		rcu_read_unlock();
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
-	sdata =3D IEEE802154_WPAN_DEV_TO_SUB_IF(beacon_req->wpan_dev);
+	sdata =3D IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
 	skb->dev =3D sdata->dev;
=20
-	rcu_read_unlock();
-
 	ret =3D ieee802154_beacon_push(skb, &local->beacon);
 	if (ret) {
 		kfree_skb(skb);
--=20
2.39.5 (Apple Git-154)
