Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409193;
	b=d4bTee9kK113dkjlbx7rfNF9r168tN6vLPXwPpkb5HaLIiGrMhHZq2xP8LO/538vaqab
	 K7RtBoRFl6a3dRxjZ8yy4nyQ2RF51Rjt7bAyllYYgWwZpN5uytPyr91yXOYpJWrGw9QqT
	 WOuiQh5291aIIkl3B6iw1quYGzSnF6UION3vwsF8kZKrg4hiOJELnME7Eo+4PXy4HBCTC
	 cfY7NEfhe5Kjyu61RY8EGfECIG/li7ZCmAJZLgdng7kgVYHT0Bhip0kNUBF6YH3J3Xrtw
	 SeL01/QYI7u5QRgTepFYplOfh+yE/dNDyTe/px3hRvSlMm6Zq59sTn/Khq/cMJ/64Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409193;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=azDKBlXB/5va2oxPzg8MAbZq/eNLcvMX1pAB7mvOLfM=;
	b=wNJaY5z7E/YDRMId+7Rct2ptfNpfLshr3udPyLRfpvK7RyvyjSYendSbV52Tq75oGKbI
	 8azWnEe9OFGwRpEiJJJSaHnc1fK7yR4Q4BOTMNfk3j8jP96u/nfEefzIDXpdiRkul8U6p
	 BXL6858MJs4PI/2rKpo6ALJlmPIxlr9iC2xv8kbSQv3EVCiDLIdog8bROw3UOMT7kARUY
	 b0iAUl8VAQth4TYhxeNyb03tu4XsNATh03SzauUIdLabLu7yZ12DuLSJBTZJDGch/WCu9
	 v1R/VRO5ixIcw8KPKD3r1j846OR2V/1Qt5JEa/0rLyypU2sfEbyENLtL3AoquQwrEUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMxtIdZ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A1606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMxtIdZ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE8F1F00A05;
	Wed, 11 Nov 2026 14:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409193;
	bh=azDKBlXB/5va2oxPzg8MAbZq/eNLcvMX1pAB7mvOLfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KMxtIdZ3tuMOFOAMGA7ne+6QsEb/G1DYovKXJJPghGSMGsVSsZg91c9v80qzyQz9+
	 BeI1bVhcv3XCL2mqDs0lr9HNRwoIzQ8lliYZP8/CN+Mr/4sBv8C0vixasb6u666DmL
	 2XOzVa7f/AoEa7B4JRvcFDT/SAIhkVNE0JLMvX5duMSJePK574ZKj1x3SqPUayK/f9
	 afG1wbjb24b6WtwwLhh/L3l0euniC07sx7760WAJtsL0bAm0t5MCUXCfv1AxWXhu9J
	 lcESMFIUGYhn9lVReH/PTnFLkjhoz3m/+4okkuiWr7yDApwE9FriaQPUFXVWrxLWlJ
	 nLA8+06oKNSEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] LoongArch: remove redundant numa_nodes_parsed node_set()
Date: Wed, 11 Nov 2026 09:59:50 -0500
Message-ID: <20261111145945.2469530-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051511-failed-6.18-87c6d144bc7b@kernel.org>
References: <20261107051511-failed-6.18-87c6d144bc7b@kernel.org>
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

From: Sang-Heon Jeon <ekffu200098@gmail.com>

[ Upstream commit 3aeac07c5b1c3399487f4b38182f8cfbc3dbbd53 ]

numa_add_memblk() now sets the node in numa_nodes_parsed itself, so the
caller's own node_set() is redundant.  Remove it.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Link: https://patch.msgid.link/20260703041329.2797584-7-ekffu200098@gmail.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Stable-dep-of: 87c6d144bc7b ("LoongArch: Don't init & online empty nodes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/numa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 8b89898e20df1..c96c536237151 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -216,7 +216,6 @@ static int __init fake_numa_init(void)
 	phys_addr_t start = memblock_start_of_DRAM();
 	phys_addr_t end = memblock_end_of_DRAM() - 1;
 
-	node_set(0, numa_nodes_parsed);
 	pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
 
 	return numa_add_memblk(0, start, end + 1);
-- 
2.53.0

