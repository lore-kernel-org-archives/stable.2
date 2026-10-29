Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269129;
	b=5qz/ltT0E87SX8g8bHVwrO4DxVbDuA2kWjo1A4oP2ehuM5n/Wxwyoz97gaCn6AtzC8yT
	 +5Uv0DRRHZnpW+YJzpDNn6yfZtFv3se6ZCpCrplSzKPUIT+0x8z9KZqZXw+pi8hRrStDX
	 zeRCNQPiKxhe6C4R7hzOyV78FQYerDWLMO9iVHrOaxEEDD049GyYiFxgzT53xpx3QSH2h
	 PmHQYV/is1vwu22eyhSyJEaizGN0ZkzCYteli/Uo7C0XnA9gmQJ2L1ecqB3QGHGbIm+Vp
	 ORGySrxr2VVsfF+6C/G+TlZDcGy9swB3CcQJN5R4ijKKJtZCrDiI2slaDXTzu5GgBag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269129;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=TMyNi9h8uZB0CnN21h3FMGgHT3Z+cop+m15S7SnkkEE=;
	b=KhBbgC8NX4ltHYyuiEt1jEfyWLxK6rgH9uHmnzKLBd+GWc40wYcJJF69xR9BCbKaFbJE
	 NANcUhEP4DNcYsSFPP9YAyd5Jw4ret1ts9fjAi6IKWXtYBrO5vzxHIrJ2c2F5GPGlKt/U
	 xjYve+xJszHb9spJ0kZak0TtUyG9/nxn5nBLFIvW9byk1PFHmbbo+DxxsenT2CZI5Bgx7
	 tLm7PDhzOTyly8yX6FQChQ5cEpOkX4CzG1ZfndpKT08GS7VG2nTy7cluKk1rONsc2UDOE
	 GCsfYwWwLPEQDVHPZtGFsO4LAxNfoY7okKuXRZULwtj+csXRvAytjOZ2RTgLuBzUjJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLNZ1CIW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B8606A31F;
	Thu, 29 Oct 2026 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kLNZ1CIW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800F61F01829;
	Thu, 29 Oct 2026 10:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269129;
	bh=TMyNi9h8uZB0CnN21h3FMGgHT3Z+cop+m15S7SnkkEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kLNZ1CIW2YxK0uST8iiMQenMa7zmpUsZAyb4dVyOsejE+jvn/l9vgOMmNecd2xd48
	 jLuQs/kZGYQg+ozRL0n6IhurzDdCEhRo34ZyLlqHTCgjl56zP1w8mAoLGwaHEUlos7
	 XtKu82hBX81C7OX3yfRMEihSQnbDEBI2nDB5BE+JjQhabRsawia8vcrJ8sEz9TwHaa
	 dtUbAzMsCJdShBOyvNoLtEIOdw2tn8qslCCM+VFfnQBLkn2doBYK8ZhpkAck2GUgT2
	 U9roVrXu+3qvHtQcvut7xEHw4hDV12vHibzvr+Li4hyvn13zMM43+TVQEF3TCOgmVg
	 rK6RMcRR8tWpA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 29 Oct 2026 12:18:38 +0200
Subject: [PATCH 2/2] mm/cma: accept memory of CMA areas reserved at a fixed
 address
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-cma-multi-v1-2-2cbced8b5cb7@kernel.org>
References: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
In-Reply-To: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
X-Mailer: b4 0.16.1-dev

CMA areas allocated from memblock have their memory accepted by
memblock_alloc_range_nid(), but areas reserved at a fixed address with
memblock_reserve() are not.

If a fixed CMA area is requested by the cma=<size>@<base> command line
parameter, it may be in regular RAM and on TDX and SEV-SNP guests it
must be accepted.

Accept the memory of fixed CMA areas as well, so that all CMA areas are
accepted regardless of how they were reserved.

Fixes: 75d090fd167a ("x86/tdx: Add unaccepted memory support")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 0035efb1130a5..f61d52796f4ef 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -381,6 +381,8 @@ static int __init cma_fixed_reserve(phys_addr_t base, phys_addr_t size)
 		return -EBUSY;
 	}
 
+	accept_memory(base, size);
+
 	return 0;
 }
 

-- 
2.53.0

