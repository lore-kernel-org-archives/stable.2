Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794750169;
	b=Hq4uUWNwHJqgK6v6TPMwGEiFkmWQRDp0oyw4Alpg3fy5oC/MMjRghShyrlGbJX4g3SAG
	 bA/GXTqNCUgAfmsKc6bMOzB9nIkYpqUdo02+ERfPYtFkG3spLsObIzuVuQzCq6M1Ent4C
	 MwKSEvPxpIIfU0lGylDy9s21u37nmlG4g2uUSj+SABxbWrbwogF4VnvBs3eS3XQEgKzNd
	 KFghL986BxF6LitZxwKallQ1riKvY7/43qmHWhpa99yMQGg6jgeaAEOkpR3/cIuE9B+Er
	 aMrHkMS4hhr7BOXPPcemOXTq5ZHQkgKZg0R/FrwkofTmXSLxniT/QlqNXJ7jFU1re6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794750169;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=21E6zrB8ozWrQ/A3H3YZJaHcRgH59KtHBfeSZHAvgWY=;
	b=rx/rQF3kssp4XZ7KNo2z6CZUshMHIhs3fVMRUpRM+SvYi9gVeGuypJ1W6H/9oyvtvrko
	 x6Tz9oHil5Ztp2KeHXdzhNPcZXXAAcz3bZk+uPBmyMXLWPe833XuSBisYoOGfB8SWM18c
	 tP/bKeo5iTiQpHdh1qd16VJbbJ2vrck5R9MvP6dfQ9ZwqPrtgv8gA6VPtTue/lsXdzXUK
	 1HAiqUXuRcBfn69Hu/PAPBT/BpTm9mZDY8rNJjCv3dj/YCec7kxRrTgSAHiRBtmNqev9y
	 SKqCndbOiPnmHWlAUl0zTOhWGR4cL24DKnHyBLBhbmg30tDSsTp/Qz64IVa2SCeJR6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=h39VGpmw;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A3606A331;
	Sun, 15 Nov 2026 13:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239A3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=h39VGpmw
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b8d4a0b;
	Sun, 15 Nov 2026 21:42:41 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v2 0/2] net: plip: fix private work lifetime and balance
 the controller IRQ
Date: Sun, 15 Nov 2026 21:42:38 +0800
Message-ID: <179475015898.114908.1534399014158681174@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df72218103a1kunm6a37fc6bc5347
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTE5KVhhCTB1LTx9ITEkZGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=h39VGpmwuP/CLtvr3jZqvxwhZCHTEV+7IX02zFMFAi00Io2z11tCgHX8SClTtvvEn6nnXHxsQU17pfgzGOs8J7Da9wu+Uds97NTLe1YQwed9ci/DPYdnxoe1GPLsvC2aVDdWrizORUQzU0l1HOvO6oNfpGCzVZsqVwDGGywHILQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=21E6zrB8ozWrQ/A3H3YZJaHcRgH59KtHBfeSZHAvgWY=;
	h=date:mime-version:subject:message-id:from;

Patch 1 keeps the private plip work disabled unless the interface is
open, so teardown cannot race a work item that touches the parport or
the skb queues.  Patch 2 gives close a tracked IRQ-disable reference
and releases it exactly once, and restores the port state while the
driver still owns it.


Hongyan Xu (2):
  net: plip: quiesce private work before releasing resources
  net: plip: balance the controller IRQ when closing a transfer

 drivers/net/plip/plip.c | 193 +++++++++++++++++++++++++++++++---------
 1 file changed, 151 insertions(+), 42 deletions(-)

-- 
2.50.1.windows.1

Discovery: found by the author's in-house static analysis tool.
