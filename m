Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375481;
	b=FiJPcTKmYjaIhgKT9vvWD/LRQXrNrIQn7jVfDJWOJsXjaWGgUKmtnABErwljJDXyJn3g
	 fH9y0CyNqilQBmcjlVgHBCRoP2M0c9NCRNfHn6B8tlgkNDjUTBfr45EoKiOTsf4xm/hXR
	 /YPlQEYg+9YoaVfqqkv2UxoftwjV9d1RhBAxGIrytUale+7AM9Ics1PM75bCTuicsBYua
	 Lg5YX2jhOdCtBAXp2H+mcgL4IGd2AE+QTNRY1Ityx/t1qkidrfvICKm1gpVlumrIBs93Y
	 4gqQ9qu6Q30iuIxoqSAAbcV7qwxvuwAuImSQiohvU7UEs8xukAK24BZ/wKt/hFiK38A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375481;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TM4300ynVj56R1yAfUhdSHiB+9FZEDCjo5dKTPk4HbE=;
	b=OCysNxjkhr0aGXJHAJi30ZLixVW60pLjOXih2Ivit9nwgwSRBsWag8XFaPjwxGnJRZfg
	 uZZlKGr5z/FBoA6LFlTb0XtkxhbFQTxJhclE9bjtD5k08p0xH6MCld7v8hgJkFYsKnU9i
	 aF5AYbatfoPH8GlKvNllJPa+w8KweuHrHYVG4lE7h6FfQUn6hYtAciffmq7A3YUnp9NSc
	 0cSuPvNeBLu5GdzfhRQYYXYLuqxR2PcZugtyPJ3nIMtfIA2MuzIAu5JncXjQw924Q2Hy3
	 lmw4yQ+pnmIhO7vyUlPQ7mXoaGh2NE1s35HKdi+RN85Sse4TCvK4em9dAhv5fsZE2Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="GS/+SAjL";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08A606A31C;
	Wed, 11 Nov 2026 05:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B08A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GS/+SAjL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794375479; x=1825911479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=puKIpX6ZiFMLpkLQOCcxTMxREkeXgFUZUCvVOUptx0Q=;
  b=GS/+SAjL1HAYyqcA8P4UOpFsn9i4Db52M2i8bxta5J8tZjC9FL5aWK2O
   dTqjJkxSvlxpbz0VwaH/WbmM1S1BULHmw1j39gddz36spm4eYBlI4d/Pz
   BosW7iS+AK4wTXZNkKZGCWsAz7zPI0B9xSLl40pmTghIXf8FkweoNXu2z
   xYbiYrHeP88sWXaPHmO8gHrFOd4qrvxJQ56Zb4aQrdhSgR1KPw8MTt+dM
   LmVGfx5F9l0iekqZslp7HiRB2oUE9kkPJz04/pPHmNt5tIKqGsRPDd/O6
   e8SSEbY0iV5SDerbR+5JQ0cLIWkeJv2LOjci1/g5Y5hGPohXBbmFsmhj4
   w==;
X-CSE-ConnectionGUID: YollsKrkSWyGumYlNQLXEQ==
X-CSE-MsgGUID: onslGFLxSU2l4/4RXq5fdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3047276"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3047276"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 21:37:58 -0800
X-CSE-ConnectionGUID: 6Q7RpQDzROyZWen9Dj3xXQ==
X-CSE-MsgGUID: Ak1aABBOR8aI6hevP974vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8761142"
Received: from p16nuc01ptl.png.intel.com ([10.107.254.77])
  by fmviesa007.fm.intel.com with ESMTP; 10 Nov 2026 21:37:55 -0800
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Looi Hong Aun <hong.aun.looi@intel.com>,
	KhaiWenTan <khai.wen.tan@intel.com>
Subject: [PATCH net 1/1] af_packet: Fix wrong timestamps in tcpdump
Date: Wed, 11 Nov 2026 13:37:28 +0800
Message-Id: <20261111053728.2611070-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
timestamps may need to be retrieved with input from the driver
.ndo_get_tstamp(). Support was missing from mmap'ed AF_PACKET sockets.

The problem was noticed using the igc driver, that since commit
069b142f5819 ("igc: Add support for PTP .getcyclesx64()") has migrated to
use .ndo_get_tstamp() that timestamps were wrong on the receiving side,
when using tcpdump.

Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
Cc: stable@vger.kernel.org
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
 net/packet/af_packet.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index cf6429f09477..7197236c8a3b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -456,15 +456,20 @@ static int __packet_get_status(const struct packet_sock *po, void *frame)
 	}
 }
 
-static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec64 *ts,
-				   unsigned int flags)
+static __u32 tpacket_get_timestamp(struct net_device *dev, struct sk_buff *skb,
+				   struct timespec64 *ts, unsigned int flags,
+				   unsigned int sk_tsflags)
 {
 	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
 
-	if (shhwtstamps &&
-	    (flags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
-	    ktime_to_timespec64_cond(shhwtstamps->hwtstamp, ts))
-		return TP_STATUS_TS_RAW_HARDWARE;
+	bool cycles = sk_tsflags & SOF_TIMESTAMPING_BIND_PHC;
+
+	if (shhwtstamps && shhwtstamps->hwtstamp &&
+	    (flags & SOF_TIMESTAMPING_RAW_HARDWARE)) {
+		ktime_t tstamp = netdev_get_tstamp(dev, shhwtstamps, cycles);
+
+		return ktime_to_timespec64_cond(tstamp, ts) ? TP_STATUS_TS_RAW_HARDWARE : 0;
+	}
 
 	if ((flags & SOF_TIMESTAMPING_SOFTWARE) &&
 	    ktime_to_timespec64_cond(skb_tstamp(skb), ts))
@@ -476,11 +481,16 @@ static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec64 *ts,
 static __u32 __packet_set_timestamp(struct packet_sock *po, void *frame,
 				    struct sk_buff *skb)
 {
+	struct net_device *dev = skb->dev;
+	unsigned int sk_tsflags;
 	union tpacket_uhdr h;
 	struct timespec64 ts;
 	__u32 ts_status;
 
-	if (!(ts_status = tpacket_get_timestamp(skb, &ts, READ_ONCE(po->tp_tstamp))))
+	sk_tsflags = READ_ONCE(po->sk.sk_tsflags);
+	ts_status = tpacket_get_timestamp(dev, skb, &ts, READ_ONCE(po->tp_tstamp), sk_tsflags);
+
+	if (!(ts_status))
 		return 0;
 
 	h.raw = frame;
@@ -2424,9 +2434,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	/* Always timestamp; prefer an existing software timestamp taken
 	 * closer to the time of capture.
 	 */
-	ts_status = tpacket_get_timestamp(skb, &ts,
+	ts_status = tpacket_get_timestamp(dev, skb, &ts,
 					  READ_ONCE(po->tp_tstamp) |
-					  SOF_TIMESTAMPING_SOFTWARE);
+					  SOF_TIMESTAMPING_SOFTWARE,
+					  READ_ONCE(sk->sk_tsflags));
 	if (!ts_status)
 		ktime_get_real_ts64(&ts);
 
-- 
2.34.1

