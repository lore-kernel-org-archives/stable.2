Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409437;
	b=DuWEY4q/4/B6v+nL1vUj7UedEcT4MZBjP4NNzURjXdJcHU4ijSNUvIDL6+fSlK1Nxj6P
	 uQMwoZtWxcJvvGJ/q1bA9Ay0RupPTnTRb3aP0QH00v2JZUNAegQW3gFyXayf1g5pZeKMM
	 VNZbx9g45TiR8OFGuKXJ+tlQnU79Skic2+AK472r6bzTfo6VPnqLngJsQ+rNw9c25PKk3
	 qW1ggoovfygC5PnEVBFqbDlX93vs/Qb3kCF17zrGtbv61q21AVEP11X2RP67teMVXtUx1
	 l8cEEYB4O+o9azDeCK1aANnugLsyNCJ4TLMISoFUSmy+F9G/wgej8+x1dTmqzZZPuhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HghP/JN3RspysRX+SWUae2hFYZJt2XHn8HUerRXCZ2A=;
	b=fsiV0wG7KWbR6Kf+2ECEoqRLvGEWF3bdiRPvZ4JSa1QSPfI0b2JFJcN98E1QNXbQ67I1
	 oSRToriA4KcAIWRExNSnl24hpB6zaLdj3BjvuUBkLsnnkzUU1qCAEBRsPtMJIUqgzW81F
	 x/oBCKdVt2LoUN6LhlYKB65DS0CtBYYspa743qRrvbhv/ULDZCAct6ttVqg1kbJCBZ/vp
	 sGmuK5t/OVjrlUf4yE1qS8wc3KVLEwockH4Hcsue++EeoBGVosEjIsfb35rbOa9x4Z8Eo
	 HrNp63sT2IpsW9ItDmfJgjgqTv8icBw3AZLlBUFGAKeZblRPljxUenuO2sKlWRjDeCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzXOTE3z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3602606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RzXOTE3z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1B11F00A05;
	Wed, 11 Nov 2026 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409436;
	bh=HghP/JN3RspysRX+SWUae2hFYZJt2XHn8HUerRXCZ2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RzXOTE3zsOt5a9MeRdEoNQNtKJRTJujLKNnqw57Gw8VgFMiWEE+NOc8s9tnNcXaTC
	 kTzOphQ3JkWw5yjt23zBBrOvjej+0VriSnMSDoVycNsE80mQsX+VEOI5I3KZDqWgiS
	 iEDnsFt9+lQmgst+ONvxNTo3feN7Fyftr/PbLyizN3G93BvK0w5+aLd4Cg7aw1QSzY
	 0Ge5Sk0bnpMeDv1MG9lirGr+UOcTKXuqTTBwMerOvYlkrUnH/SJQhxS/9TJseShUh0
	 K6YFJGF/hiIxkjSwvxVIVFBl/LkAQinN12vDNdSawVu/Lx/UZLNsynsM41H2jw0cxC
	 DEg7KSRcdMJxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] LoongArch: remove redundant numa_nodes_parsed node_set()
Date: Wed, 11 Nov 2026 10:03:53 -0500
Message-ID: <20261111150341.2575597-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052654-failed-6.12-87c6d144bc7b@kernel.org>
References: <20261107052654-failed-6.12-87c6d144bc7b@kernel.org>
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
index 84fe7f8548209..aefe9984be794 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -318,7 +318,6 @@ static int __init fake_numa_init(void)
 	phys_addr_t start = memblock_start_of_DRAM();
 	phys_addr_t end = memblock_end_of_DRAM() - 1;
 
-	node_set(0, numa_nodes_parsed);
 	pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
 
 	return numa_add_memblk(0, start, end + 1);
-- 
2.53.0

