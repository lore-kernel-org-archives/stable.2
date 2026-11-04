Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786231;
	b=i5JRjOUWPkoDN8bpPgwNbKPLfhvDbJsKxo6R4hnuMFwLMs+9q85Irxte/u4F+bxKqeyW
	 YumI9GRUW6Qe7mp51Zv71Jv6/JWjcMbVXCd//4mj+ocbABYcZbi9zoc2hwApHYH2ZteKf
	 xIIAmfQ2WXlnvlQOfIlpQ/A525+s4EBFZzZQGZevTI8WYWlw+3i5ZKwwsZT/QgJ5MS4pZ
	 G+kRRaaQh5wGxB7wKJp9CTN2BXrxF/r0CRG+2NfsSza33rP6Id/q0CdVh5Mzb0NWIgvcu
	 2fAdntsERPgAQ/Oc4uVordg69ic/muuJ9qPeRvqhg+12ZI0k4I63ea/NbUOyC8ndnyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786231;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=a6xsRKL+cULQrPCgB872GUO7WGH3fVoHR5W/L6Dktxc=;
	b=nvYU4DnlYrg5D69fTlY3P1mVpNqN4MV4a0UB/2pIgRKX7xmpRZS1MYT/4Y7JOpshVVZe
	 NkxtANZBPeOP8etaK98HGxokuOZ3ISBOpa1317VDQqpK+QgX/EO8y2fGv8FzvrcGPNsoD
	 Ll09sg5aJSvS0XlfFjIVOc6pS/FCCb0dnD7J+5fOpC5VC+aCRrRuFm0NXj0ikD4d7X5UJ
	 NZkk7UR2nzjH2Jo6m/YluNksadWRVz4c94bck2HfllDAsFW7bdH+iMgaHSN9Zdqf9ggB2
	 a7TqPw6zMWBVmr95ilh8OVm0z9M35JbHM9frq8vLNS5EQlydR0W34ku5N3s5chXelZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC5D606A31B;
	Wed,  4 Nov 2026 09:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBC5D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5378c9734;
	Wed, 4 Nov 2026 17:56:53 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, zihanx@nebusec.ai, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 04 Nov 2026 17:56:53 +0800
Message-ID: <179378621331.55520.8126896786309171541@stu.pku.edu.cn>
Subject: [PATCH net v3] mac802154: validate pinned interface before beacon
 transmission
In-Reply-To: <179337523079.51423.6573078122047317758@stu.pku.edu.cn>
References: <179337523079.51423.6573078122047317758@stu.pku.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1a5fd751103a2kunm548c819715b7c9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUlIVh9JGR9DTRhNQxhIT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=HcdXRJRLjUqPKYOJ0DTRm0wpGM7p/u9thhdHqcbdpobq3OHTLTnharDfUguXFM3WSHSrheVMNd2Z9i71r0NWL9gTS+uf+2ruRkRIeYGWCZt+5CqEOxQARhOjNWSP1ud2QRSbEZtGCX3QRN68ZYZkiY1Dc8+gcE1pX4ZfmLCpQYQ=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=a6xsRKL+cULQrPCgB872GUO7WGH3fVoHR5W/L6Dktxc=;
	h=date:mime-version:subject:message-id:from;

mac802154_beacon_worker() selects a beacon request under RCU and pins
the corresponding netdev before dropping the read lock.  The transmit
helper used to read the request again, so a concurrent interface switch
could make it dereference an unpinned netdev.

Use the pinned wpan_dev throughout transmission.  Under RTNL, verify that
the request still belongs to that interface and that the interface is
running.  Build the beacon from the protected template while still
holding RTNL, then hand it to the locked MLME transmit helper.  Free the
skb only on errors before that handoff.

This closes the interface-switch use-after-free without transmitting
through a stopped interface or leaking the skb on the stopped-device
path.

Fixes: 5f26a690e8ef ("mac802154: fix netdev use-after-free in beacon worker")
Cc: stable@vger.kernel.org
Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
---
Changes in v3:
- revalidate the request and pinned interface under RTNL
- serialize beacon template access with request replacement
- free the skb on every failure before the transmit-path handoff

 net/mac802154/scan.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index d393b1f4e74e4..b3c8076b8057a 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -354,35 +354,31 @@ static int mac802154_transmit_beacon(struct ieee802154_local *local,
 				     struct wpan_dev *wpan_dev)
 {
 	struct cfg802154_beacon_request *beacon_req;
-	struct ieee802154_sub_if_data *sdata;
+	struct ieee802154_sub_if_data *sdata =
+		IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
 	struct sk_buff *skb;
 	int ret;
 
-	/* Update the sequence number */
-	local->beacon.mhr.seq = atomic_inc_return(&wpan_dev->bsn) & 0xFF;
-
 	skb = alloc_skb(IEEE802154_BEACON_SKB_SZ, GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 
-	rcu_read_lock();
-	beacon_req = rcu_dereference(local->beacon_req);
-	if (unlikely(!beacon_req)) {
-		rcu_read_unlock();
-		kfree_skb(skb);
-		return -EINVAL;
+	rtnl_lock();
+	beacon_req = rtnl_dereference(local->beacon_req);
+	if (unlikely(!beacon_req || beacon_req->wpan_dev != wpan_dev ||
+		     !ieee802154_sdata_running(sdata) ||
+		     !netif_running(sdata->dev))) {
+		ret = -ECANCELED;
+		goto out_free;
 	}
 
-	sdata = IEEE802154_WPAN_DEV_TO_SUB_IF(beacon_req->wpan_dev);
+	/* Update the sequence number */
+	local->beacon.mhr.seq = atomic_inc_return(&wpan_dev->bsn) & 0xFF;
 	skb->dev = sdata->dev;
 
-	rcu_read_unlock();
-
 	ret = ieee802154_beacon_push(skb, &local->beacon);
-	if (ret) {
-		kfree_skb(skb);
-		return ret;
-	}
+	if (ret)
+		goto out_free;
 
 	/* Using the MLME transmission helper for sending beacons is a bit
 	 * overkill because we do not really care about the final outcome.
@@ -402,7 +398,16 @@ static int mac802154_transmit_beacon(struct ieee802154_local *local,
 	 * transmissions, wich anyway does not have a huge impact on the
 	 * performances given the current design of the stack.
 	 */
-	return ieee802154_mlme_tx(local, sdata, skb);
+	ret = ieee802154_mlme_tx_locked(local, sdata, skb);
+	rtnl_unlock();
+
+	return ret;
+
+out_free:
+	rtnl_unlock();
+	kfree_skb(skb);
+
+	return ret;
 }
 
 void mac802154_beacon_worker(struct work_struct *work)
-- 
2.39.5 (Apple Git-154)
