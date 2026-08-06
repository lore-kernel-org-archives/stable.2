Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F63439338
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009946; cv=none; b=g6leOa3vYnJWkMcdHiDX0Lq1VrEuk4GlgQ9wQd0kLT8l10QcmdANAq74U5SSYXaXfRwG12aVrk7rnPUqloAUbKpsc3MpRr7TFOCdlzuug4oegKnNWYUz0jpKicTpoaCkrJc1M8PEWE4Gg6XHbnI416F/S0V5xee09QsjOSfQGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009946; c=relaxed/simple;
	bh=fGTj5wUGWNYrgZCqdVOIGZNhDS+g5t5Ox5DNiRIaYgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nVME7Q6Qa5YrpsofDHEdqa28Ytc+xUoNNj6DQMG6/kzdJXrAQb1PhACBATlGdfiKvpeZy6eetfsGNT+bNpI3okOjeRZbgl5bu8wdS3NI/oEaVLwALGG7fs6MaBZ8QYXu29MA1YN9ssOGfLC0RZlMMMJuhgoacBxndDNXkWbDg5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pLKqC0iE; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pLKqC0iE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786009942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OvkfXFmOnUsAWSYlP13MHQoRxVUlda8S72hxLk11WSw=;
	b=pLKqC0iEdAj0QR3vM6ni5JJbKuhGCy3Y9SNvt1tv05+pKyytFp/i5JmXb3Wf6v9WpaNwgS
	8/ClEFElTIosE1TH6ZqDv4ychOVRYj1fe2WnDSYkP3MlZUzxXW5fPsknUSmapGbc6y0iOX
	N65RrcbJmdFjhPp0dS8MuLEAzV4ZJ5w=
From: xuanqiang.luo@linux.dev
To: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	niklas.soderlund@ragnatech.se,
	kuba@kernel.org
Cc: paul@pbarker.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	masaru.nagai.vx@renesas.com,
	sergei.shtylyov@cogentembedded.com,
	luoxuanqiang@kylinos.cn,
	stable@vger.kernel.org,
	Xuanqiang Luo <xuanqiang.luo@linux.dev>
Subject: [PATCH net v3 0/2] net: ravb: fix PTP clock lifetime
Date: Thu,  6 Aug 2026 17:51:24 +0800
Message-ID: <20260806095126.57803-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <xuanqiang.luo@linux.dev>

This series fixes RAVB PTP clock lifetime handling. It handles unavailable
clocks and synchronizes clock access with publication and teardown.

Patch 1 handles unavailable PTP clocks.

Patch 2 synchronizes PTP clock access with publication and teardown.

---
Changes:
v3:
  Patch 1:
  - Omit Niklas Söderlund's Reviewed-by tag because the implementation he
    reviewed has changed.
  - Describe the NULL pointer dereference before the first open as the most
    likely failure mode in the commit message. (Jakub Kicinski, Sashiko)
  - Normalize PTP clock registration failures to NULL.
    (Jakub Kicinski, Sashiko)
  - Keep hardware timestamping capabilities independent of PHC
    availability. (Jakub Kicinski, Sashiko)
  Patch 2 (new):
  - Serialize PTP clock publication and access with priv->lock, and detach
    the clock before unregistering it. (Jakub Kicinski, Sashiko)

v2: https://lore.kernel.org/all/20260802090750.116215-1-xuanqiang.luo@linux.dev/
  - Only advertise hardware timestamping support when a PHC is available
    (Niklas Söderlund).

v1: https://lore.kernel.org/all/20260731063254.71260-1-xuanqiang.luo@linux.dev/

Xuanqiang Luo (2):
  net: ravb: handle unavailable PTP clock
  net: ravb: serialize PTP clock teardown

 drivers/net/ethernet/renesas/ravb_main.c | 15 +++++++++++---
 drivers/net/ethernet/renesas/ravb_ptp.c  | 25 ++++++++++++++++++++----
 2 files changed, 33 insertions(+), 7 deletions(-)


base-commit: 11028ab62899e4191e074ee364c712b77823a9c4
-- 
2.43.0
