Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673350;
	b=yOxMBm4JQHhbSANDQcLIss8crgd6VMRqh1XkbQyAx4bJnjd39qWfCXz/QBAAaxfVENXF
	 2iZgNNiHwXptzIGKw55LlRxKzQXOM98eMs8jwcGvTPJYxCxW6Uqk4eQy5cO4iaw8oeibK
	 J5sRRmb/EJUEzYolJTmJgaFfyhNocHn7vU7nulSBGXnnAOA4M+Xdwknp6mQUMn4FYz1TW
	 yBp3VHktHjbklJppZKbuhFwnCYhx8wXXh2hSwsRh9gdpTQR3BsK0a5kWLZJHsTYD/8+Ro
	 4WwIgJYKyhV4wzGTwSZBGojfoWgfK3A/AGURvDF3JJLGetxa+trqweb5xvipN+QNpgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673350;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eouL48TwOCuWqx1AdcKF13Oz2ktEEc2mLJ1YoGSNCIY=;
	b=YOO0wVkvNmUZvR6Sv4mAsgDlIbOTP7Aqall0c/+dbu1nMe39KMvQ0VstjcSF5w6MCDdX
	 4ai3Yq3oWpMXEDfV9PNVRZhUlttdikVAJC0UNSCShkUw1OU9vAAtVrhwkfUrbWREpsHfQ
	 aDsIQgyWSJRHpbbsqNtTf1oDfp18vmAVMuGXhmn5rpBHwf2PU/g8uVWVdz2F7FtIxzyuK
	 j1adH7Rq8kQCJfCP95DVKARJMugjca/ye2iwQYppOh+MT1r7v3RXEV2/24PMNurxcOCjS
	 r0QrXJW6IhZJpk9pjppxQ+Ci7qk5VkA7180WgjgUzaAZf1cRji37LYM3nUvqbkNFJmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9GjuJq6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99E606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9GjuJq6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C056E1F000C4;
	Sat, 14 Nov 2026 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673350;
	bh=eouL48TwOCuWqx1AdcKF13Oz2ktEEc2mLJ1YoGSNCIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h9GjuJq6N/6TsmnkRKS5IRBvvVXHwMNczL67Q3as/oLEi1Zozie6JxGoQr5TeHeWm
	 UcnNOb6oK7Y7NaloTTtoNPclgDmPQM7NRZPJZwWl1Mhs1NjoEPcjdtt0Q/oVQgKyq5
	 Y/lNZozbwYQ73reJtLCuFYYpPV5pz/AxGw7bvvp3HOuuopSEKclfc0kOGUEB6ezjIn
	 R7JkTiprBBYpHCp5Lk0BAcAeG1fYKxtun0W62AdFvuVCHL95J9+BL0ipDVX2tqqfMJ
	 xvfXtYmBP80uluWvW5ZwY+kWqg+TJ/HbjbTOO4mKSSTTDmmLGADVKZPDBpsgvIYMnK
	 /v3uM5Qa44Egw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/cma: accept memory of CMA areas reserved at a fixed address
Date: Sat, 14 Nov 2026 11:22:26 -0500
Message-ID: <20261114161849.4002504-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201234-failed-6.6-f8f9cbc34a30@kernel.org>
References: <20261109201234-failed-6.6-f8f9cbc34a30@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

[ Upstream commit f8f9cbc34a309a388c052706f3329d1b52985aa3 ]

CMA areas allocated from memblock have their memory accepted by
memblock_alloc_range_nid(), but areas reserved at a fixed address with
memblock_reserve() are not.

If a fixed CMA area is requested by the cma=<size>@<base> command line
parameter, it may be in regular RAM and on TDX and SEV-SNP guests it
must be accepted.

Accept the memory of fixed CMA areas as well, so that all CMA areas are
accepted regardless of how they were reserved.

Link: https://lore.kernel.org/20261029-cma-multi-v1-2-2cbced8b5cb7@kernel.org
Fixes: 75d090fd167a ("x86/tdx: Add unaccepted memory support")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: moved accept_memory() from cma_fixed_reserve() to the fixed-address branch of cma_declare_contiguous_nid() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index ac363f16d3923..27e27e5d70cd3 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -318,6 +318,8 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 			ret = -EBUSY;
 			goto err;
 		}
+
+		accept_memory(base, size);
 	} else {
 		phys_addr_t addr = 0;
 
-- 
2.53.0

