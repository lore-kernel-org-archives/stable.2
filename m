Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841636;
	b=ec+E3xPbDuhVHrJoj0dbhAMhvFJZ21peIRZZnnld8QXwv3XtsnQ9WitUXuDL6pV7jZLW
	 gmbVIGr/77k165I2hSqa43vF7IrGz3XUJchCNSZN27J2CJttPKlzWL0RT/oUm70K+qbvJ
	 JtytxC8ebMzz1BGO3Ok1lXMBvxE2QmNwOH1mtnavDY8mGcfOhz9jk0eanH1CBEXvHcbD8
	 WEg86VCudPZ7GYsX1L9aXTIlzvx9r+y/uddGYls18F2khs5E+UgcnP7h4apsQBchYRK1l
	 CiIc6ETiGMH3btLais6k8hd/IAMsZn3g9wKx4D9LPDuhjG24tXyMBTKmzprouN6dz1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841636;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2Z5TqtpnMk3mBwsYMciP/4XrcUBcxTvv+6N/ymI5s7o=;
	b=y1kKZL1OF3r+hToZ8aqV6tGmW3RVlREUB+COP8U5Ml9U9YUO2Q+7bNPVQWuStvpZZ2ya
	 IAfZEOemMOCEcGciqWeE5tBF0ccHdcKo5sV8ekrsTJvnOJAUpJgS3vC2fEQtolyruxEDH
	 e3ByrH6D/f7UqWWe4xto4nDBPM94CWThiDJWHWncfO6B7VMbeZJkoGdm11GdA0ygDGsDa
	 pW5xwd/rlLhVhcviRoj/Tq/PaHQi64O5pXP+Ju01VMrB0nuHxsgZnZiMES8CuGuVqft8/
	 SqHmCL5cMSvImCU6/mCVnODljLdDse7s3tVtkMdBaPrhvPF+xZuiFjlbZBiQ9ctHpEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="neeh/JxC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB5606A339;
	Mon, 16 Nov 2026 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neeh/JxC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548C11F000C6;
	Mon, 16 Nov 2026 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841636;
	bh=2Z5TqtpnMk3mBwsYMciP/4XrcUBcxTvv+6N/ymI5s7o=;
	h=From:Subject:Date:To:Cc;
	b=neeh/JxCQ8KhWMT1ASqFudUros9bMuT/k3e+b6YcIbhlFSqg/KWf0X74pYD0klhhi
	 Yw82eW47iOIpl9tBYZbDGIcqxiq4X2lASVcgeV1HxTJPd282H6wCAFqfTWafk4BxIV
	 9GA5x/dRgc16XSlrrJsJCpmg7BId+gA8MbyBBuPGMugcmD3CbnEF6U8nON/8v1fR2h
	 FzNSWw7+9Br3Tpokdio2tyivE4Rud0gO3IKwV1E3tOaZgMsoyakFlGDourx/2w2wHU
	 7KP/i0dRFFwdXwBt1gIl9k+YmXEtYu70iOYlHmojaTWWZlV4i0EfGHOqqqxf2pbs77
	 1aaJg0xm7wp+Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 0/2] mm/huge_memory: flush dirty file PMDs before
 removing rmap
Date: Mon, 16 Nov 2026 16:06:57 +0100
Message-Id: <20261116-dirty_file_pmd-v2-0-571883053174@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/3XNQQ6CMBCF4as0s6aGKdIIK+9hCEGYwigCmVYiI
 dzdgGuXL/nzvRU8CZOHXK0gNLPncYBcmUhB3VVDS5obyBWY2FhETHTDEpbScU/l9Gp0FpNN7Dm
 u0iyBSMEk5PhzgLfit/37/qA67MpedOzDKMvxOOPe/cVn1KgvNaIzlSGbuuuTZKD+NEoLxbZtX
 4tE/lS/AAAA
X-Change-ID: 20261113-dirty_file_pmd-90e63640a593
To: Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, 
 Ross Zwisler <zwisler@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=david@kernel.org;
 h=from:subject:message-id; bh=idU/K1Zt+rfQyeUYE3QGExobNZd3DZ1ROw4P1GPUcO8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+y4io3+H5fH/PdMu51zh4HDrXWP7i+vZUvenPU/GNu
 xTZhbg6O0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiIcTXDX4GkFO5tDXXN6k9P
 LO378GjaL4akD/lZ/dNdlJYd5P10aR/DX/HsuW03vJpuJgbcyHjJdabhydNbfwNjY/0YlNqKHed
 3MgMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Details in #2. Now includes a fix for a preexisting issue on UP in #1.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- "mm/mmu_gather: delay rmap removal on UP as well"
 - Added
- "mm/huge_memory: flush dirty file PMDs before removing rmap"
 - Adjust comment in zap_huge_pmd_folio() to talk about stale TLB
   entries, not mentioning other CPUs
 - Adjust patch description
 - Pick up RBs
 - Use Closes instead of Link for report
- Link to v1: https://patch.msgid.link/20261113-dirty_file_pmd-v1-1-8c11f2a2e65f@kernel.org

---
David Hildenbrand (Arm) (2):
      mm/mmu_gather: delay rmap removal on UP as well
      mm/huge_memory: flush dirty file PMDs before removing rmap

 include/asm-generic/tlb.h | 16 ++++------------
 mm/huge_memory.c          | 39 +++++++++++++++++++++++++++++++--------
 mm/memory.c               |  2 +-
 mm/mmu_gather.c           |  4 ++--
 4 files changed, 38 insertions(+), 23 deletions(-)
---
base-commit: 25f5c92e1ac06496679ea229e5c825aa88968efd
change-id: 20261113-dirty_file_pmd-90e63640a593

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

