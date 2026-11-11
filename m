Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409951;
	b=fPFbv3wC7AsKQbkfTJQp+6Hh4pJljLhKOJa9v6CpQrE9WfruO36j4Cg9t8/F8eBGwe0I
	 AXtS/D5K7XQPNXnKwmM3wa2UnWri1Xvx+3zbwiKwNTY2KRiqa9onRk7nJ+SLuZMG4jSUj
	 L11sgJe3GrxQXPAjAmyQTeCBn2b0jlZFwjZE4ZJRAFSugv9JHHDKY/xoOYD648/Lv1nP5
	 IrV5XYyFeOIXFcY1GrYYaxngWKNRpxOAcnKhEN1px3obV/75bPplvahtIsQinNziYviaH
	 iL3K8g/HscoHNgrkXY6FSgAzBavm2oGu0+7Wa9vKzVI9XIVUaXjf8S9aoVF8Te80dnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qTGtM7Ofzjp3w1Y5B8L7M5PtyL5+PFOBWxFd1883tSU=;
	b=VK119Vroo7+arPN4LzoDH8O231M/6JSA8/4lnuqUMUW3/2uAx3lCyQ611HD3yS/1X2yI
	 2ElI2hLRrMj4nymlvflKzuU87nV8VgrglcAGJmXVRvb3yFDEpe/kQgiM8mPEbLhiD9MUf
	 p3PRC0lznSAZJy/ebiVzhERPbpoefgzAwEnItGjc6TiMGnbe7nYnM3vPe5FDdbq4y+rCb
	 6eLx1XFy9Hx4K5jl6YyHn0Mf01OBVzCKotmm3Wea3Zu/P/p8Zer+Rh6zLGUDfJ93/09EX
	 Q/8iYiFtsSiHjYBV0FAp/oEiskrUjqzFNDjbtjWD8ZGHNoimt8eu9m2RWgWG16VHI4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KguZj5GL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE1606A8AD
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KguZj5GL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4253E1F00A05;
	Wed, 11 Nov 2026 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409950;
	bh=qTGtM7Ofzjp3w1Y5B8L7M5PtyL5+PFOBWxFd1883tSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KguZj5GLCtt+j8RLcjHNUKkS2D/3cw5wDEk1QJMpLhEmj5ewZEo6uEpmLrsbJAmw5
	 21zoWxJa8IT0lYMdaslAHtYe9Ll8ds3RrFAGdU17UdTlYS0WftfsKTZSNylTF3ysiY
	 0/13JaUZ+aymNNIGX1r3xPKUj4A14z9cPHvx8vdmWyCiFkttuR9jo3V03JP+vsIGid
	 4mSA5Fwh9QqvUS7mPQzADK0tPCCawaxzSrmdUTN+1VcEXVXtsPdFHIeIRXuQu7qZUy
	 MhHfXKSnvvbyHVkLOf9ObDnafhGAWFOBbyEQvrgUmvqeVqIxYRhx9wT7s+NKvjYLur
	 gMXzuyjOww2og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] LoongArch: remove redundant numa_nodes_parsed node_set()
Date: Wed, 11 Nov 2026 10:12:28 -0500
Message-ID: <20261111151222.2591661-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053948-failed-6.6-87c6d144bc7b@kernel.org>
References: <20261107053948-failed-6.6-87c6d144bc7b@kernel.org>
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
index 8fe21f868f72d..62b92cb7e45a4 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -339,7 +339,6 @@ static int __init fake_numa_init(void)
 	phys_addr_t start = memblock_start_of_DRAM();
 	phys_addr_t end = memblock_end_of_DRAM() - 1;
 
-	node_set(0, numa_nodes_parsed);
 	pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
 
 	return numa_add_memblk(0, start, end + 1);
-- 
2.53.0

