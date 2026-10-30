Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352991;
	b=i+xF/rhA+Nb2idEFkUhP28Iabw/S0zihFClKgZIXljo/aBCQ51/A9vD9vJ5SB1q9UCnU
	 hdsWBAg8ZKDvzUz+LlT0SqBPTgFO/eBI/4q+XL7oMcAt0Q1LRje4bFP9vNebvQ9ZamtBV
	 yO49QVtXxIXAZQTMV3rUzIuVo5bUc5Mvcj0sEWNWcx2zcaGfrS+HXvLhM4m0Iect6D/wg
	 6dzBpbcU5GH/gzUqMOtPj6E2CafcIIt0JEa/ztf3t8Cpb/zUiBpQ8OfWhEglP04/B+ppd
	 aRpVeXncQ/bXej1IzqBTzUkYF5X4qmAVVH4MX12UHdmmO/7Tda+a8ztSdBK+CV8r+Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352991;
	h=DMARC-Filter:Received:From:Date:Message-ID:To:Cc:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=oMmBa0NNo8veO6C4YZRvUwQefoEZxCtMA+jO+Kv/UwY=;
	b=YbteDxjiB+MZAsPKihRkdv7fyJksiBELqscalTXzpOmuuEUeQfygcD8+AOuP+l8dg8ST
	 jaso/dMgOCEVZjfDn4MG0+HXPJGa3kohQILyjQzK2buON2HmQdbNBcbhMVAvSe3t5DX+V
	 ik0SZbMw5LaImVwAfZHGBtXlarlvStCrhesEPALSrx8BBDeBkBW3OG8hoNdey2Auc+Dek
	 eqJGEUvvs+U5M2zlgzfYCX7tjqaybZQ8DtVqUuuJ8Wzj4HF1f8lKLSZXrh8va3O1K53Xy
	 jlzjO1rEgFkl7hrDfswjhDZnUTv49Y9btBo14CZQAU6y2GWXhsSZVayqrsbr272nLBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=En6oBxQN;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06895606A31A;
	Fri, 30 Oct 2026 09:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06895606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=En6oBxQN
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [61.37.18.93])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52eda3c1b;
	Fri, 30 Oct 2026 17:36:15 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Date: Fri, 30 Oct 2026 17:36:14 +0800
Message-ID: <179335297474.14852.9229658182764909973@stu.pku.edu.cn>
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, zihanx@nebusec.ai, stable@vger.kernel.org
Subject: [PATCH net] mac802154: use pinned interface for beacon transmission
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
X-HM-Tid: 0aa18c2ac47903a2kunm84d54b4c37185
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGh9IVhpCHk8fTxpNHx9KSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVITFVKQ1VCSFlXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=En6oBxQNvgEZLIjU5x325BX3vj1yTNMAMcPBbhnUQumawIEZjQwnAiAJ/4pbjn52HnXUNnPQtw43FbiW0KMu+jDf6MnJxTttHWzMam5I6FUYakl/NfIM4IOS58SQ7mHj7ItFj0fr1oGRJ8seZ1iGaeuuSlBDQy2zOf85DaTXz+A=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=oMmBa0NNo8veO6C4YZRvUwQefoEZxCtMA+jO+Kv/UwY=;
	h=date:mime-version:subject:message-id:from;

>From 1e3faf146431b4c28bdf0923fa54754c1f8d8902 Mon Sep 17 00:00:00 2001
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Date: Wed, 28 Oct 2026 17:18:59 +0800
Subject: [PATCH net] mac802154: use pinned interface for beacon transmission

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
