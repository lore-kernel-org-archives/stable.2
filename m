Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED92472F82;
	Thu,  3 Sep 2026 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473497; cv=none; b=WTapX0XNC8iOle4s2SF2kkLo/ZvtfthdNm65pBAjtoMuPv3ZA90KH/c9YS9RkILwjRQ0FTen2D0NqF5/WSgGrhrupKYi5yGCXGz8KulSMIb/cxFfxmSr4YudReAAuPIcBzwvxkC1qhdCQH7ceQQfJzfgGDJPJ4FOPPTpa+wmg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473497; c=relaxed/simple;
	bh=W4adNK9wHap67IwYHlPqYCU2ZuM/zEiJSpxe6p88pU4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BY/lYre3889kdzF8mXiWd2749C1Whg0dgXmJWZ/lhb8WS4XVKVgIWUj8mukHS9+SadKZSMGFtQn7MrNg4C+7c9jjCfJVI91c6wycJeqYBiiQHVNIzopK8L3mlzc7bu9SNFzcRCtxlzElnfKiiEq1L/iqW2L+1bz2zYkrOOryU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KEuw7Wz+; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KEuw7Wz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1788473495; x=1820009495;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8bvVSKGyqzAbltjDl6J/8kLDZ0LjBdrpennMpgSZanY=;
  b=KEuw7Wz+v5lCenYVBAFuT6Ceax+EMDTFv4nc4cS1vhSuFisKNrwTXh0w
   v7hcysXJblGNYLhavva4OPlM29TRY1JFaHYKZa8JilOvTF57xvkIDG2qp
   R29A3f4B/rg4YQ9o2njvJEF1IU6ytySNS5pEIHii3HYB+n0ZXPYjzwEs7
   NkDtruQeajjdolTql8QJABRIT46hsnGXnVzMW61/b5Uw1GA42wm81rnnZ
   ECEEs1MyGOANHgFT/rDTtiwwNrZdGN6TMYN7YsBwI99/q9iCxA305QjhX
   SkaEnn78zi01G/RrXa1PZyEqgNcWIP0MFw7Ck89+uJz/lvv6vjBCNxC8W
   w==;
X-CSE-ConnectionGUID: noX85ADCTkuAETgCnDGBEA==
X-CSE-MsgGUID: fwrdIkPLQqOvHY+3wrmteQ==
X-IronPort-AV: E=Sophos;i="6.25,260,1779148800"; 
   d="scan'208";a="27266811"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 22:11:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:26155]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.25:2525] with esmtp (Farcaster)
 id 6def88e6-3c67-48f7-8b54-f8752f10b407; Thu, 3 Sep 2026 22:11:35 +0000 (UTC)
X-Farcaster-Flow-ID: 6def88e6-3c67-48f7-8b54-f8752f10b407
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 3 Sep 2026 22:11:35 +0000
Received: from dev-dsk-surajjs-2c-afd24e6d.us-west-2.amazon.com
 (10.189.247.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Thu, 3 Sep 2026
 22:11:34 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: Bjorn Topel <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
Date: Thu, 3 Sep 2026 22:11:30 +0000
Message-ID: <20260903221130.27316-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Jason Xing <kernelxing@tencent.com>

commit 22ba97ea9cc1f63a0d0244fae38057ed452b6ac7 upstream.

The TX metadata area resides in the UMEM buffer which is memory-mapped
and concurrently writable by userspace. In xsk_skb_metadata(),
csum_start and csum_offset are read from shared memory for bounds
validation, then read again for skb assignment. A malicious userspace
application can race to overwrite these values between the two reads,
bypassing the bounds check and causing out-of-bounds memory access
during checksum computation in the transmit path.

Fix this by reading csum_start and csum_offset into local variables
once, then using the local copies for both validation and assignment.

Note that other metadata fields (flags, launch_time) and the cached
csum fields may be mutually inconsistent due to concurrent userspace
writes, but this is benign: the only security-critical invariant is
that each field's validated value is the same one used, which local
caching guarantees.

Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Link: https://patch.msgid.link/20260530042630.80626-1-kerneljasonxing@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ 6.12: Apply fix in xsk_build_skb() since missing patch
	30c3055f9c0d ("xsk: wrap generic metadata handling onto separate
	function") added in v6.18 which moves handling to separate
	function xsk_skb_metadata(). ]
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 net/xdp/xsk.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index da7e11e3bfad..76675ce70f03 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -665,6 +665,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
+	u16 csum_start, csum_offset;
 	bool first_frag = false;
 	int err;
 
@@ -733,15 +734,17 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			}
 
 			if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-				if (unlikely(meta->request.csum_start +
-					     meta->request.csum_offset +
+				csum_start = READ_ONCE(meta->request.csum_start);
+				csum_offset = READ_ONCE(meta->request.csum_offset);
+
+				if (unlikely(csum_start + csum_offset +
 					     sizeof(__sum16) > len)) {
 					err = -EINVAL;
 					goto free_err;
 				}
 
-				skb->csum_start = hr + meta->request.csum_start;
-				skb->csum_offset = meta->request.csum_offset;
+				skb->csum_start = hr + csum_start;
+				skb->csum_offset = csum_offset;
 				skb->ip_summed = CHECKSUM_PARTIAL;
 
 				if (unlikely(xs->pool->tx_sw_csum)) {
-- 
2.47.3
