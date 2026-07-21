Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9542BDC28
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625898; cv=none; b=g/8CDjpPpTtheDVdvzztb/dHp6dnA7JifB66XS3xXw4zdTHtMEf1/j/j3z2PL6riWBnv30FwIDPICA1OOM70zaZxTgvdGtV+biStE0VRBIxqjvqNBpO5pxT+2oyOA7MZZoeObDSUcXpqlKhx2c94eCJr74o85Rdgz98VJL5vt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625898; c=relaxed/simple;
	bh=0U0oAcA9o8sdBN9pKl0cVteVFaA5+ODIdL6bQcmyNmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEbUW39KQRL9XKPPuu61tliAq+qmmmH4j+WGG9R/cpL0/6HlfDXNI8t2S39PVuOvA4+PbGSjBYISOL5As6G6en5xG0c9FaG34sexlFYDVprzVuVs3ZkocAnDBjq0d5Ivs6FMQDecHoTRvDab8hZBmCItG47rv3C7rebcIAzzBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AWYax0qi; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AWYax0qi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784625893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2FQXDCxrT8tPYV+NgHQ01O/7Lq/+d5KF/3y46YmuZSI=;
	b=AWYax0qiizAfZB7H7rUqAhJ/kXN26xzpuRUQmNnSQorVoaI5kU8WaPXQKBsEfNC9NMd2xF
	BXYL+4sdJ2tVjWOZLoF8WCWgow1A4bbA0uss3W8LqVUqG3JJklidcNWwkxO0N+bjll+xz8
	7zLjyWoNcryk5UdJ2ttVIJ5+RiWFvjU=
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	roel.kluin@gmail.com,
	tactii@gmail.com,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v1] igbvf: fix DMA mapping leak on Tx error
Date: Tue, 21 Jul 2026 17:23:23 +0800
Message-ID: <20260721092323.39372-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

When mapping a fragmented skb fails, count already matches the number of
successful mappings that must be undone. Decrementing it before the cleanup
loop leaves one mapping active. Reusing the descriptor then overwrites its
DMA address and loses the mapping.

Remove the extra decrement so the error path unmaps every successful
mapping.

Fixes: c1fa347f20f1 ("e1000/e1000e/igb/igbvf/ixgb/ixgbe: Fix tests of unsigned in *_tx_map()")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/igbvf/netdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index c5ae15fcdca75..3d2aba5c3f126 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2190,8 +2190,6 @@ static inline int igbvf_tx_map_adv(struct igbvf_adapter *adapter,
 	buffer_info->time_stamp = 0;
 	buffer_info->length = 0;
 	buffer_info->mapped_as_page = false;
-	if (count)
-		count--;
 
 	/* clear timestamp and dma mappings for remaining portion of packet */
 	while (count--) {
-- 
2.43.0

