Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968595;
	b=sTzQsYOY/7YRUUvym7biHArAAC1awkzT9D3cNQ6WHgCNS3e8E6WNCFw+pvcxYeyyue/G
	 5GpedGGoFAikbaaze9vmOUXBUHjOELBudf8WiSE3W5u3UC1fxIPBl7N2UsJ8LRwIHN86I
	 7t1zBQ0Z42zE6DgDQ7NviHC0XWfCdgr0IKwNw6fNGi5nyesiwMhD6WW51bIRiRlOLUwJy
	 /0hrL2iCdsv9WLtChtAtes0q/mgwYrm/02VI4fhE/S0yWxsPOraaX8vrNQIgluYuzTJiI
	 I+6RBJiW4pkDMx4kWQ8CgYhSjxsoObTzMflBnu0efQHNoaoUnqb6Ubq80KOg5b7Sdiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968595;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Hx7cpP7lpaGh7AkuWcK+sQJGurQzMQvP0gaLMaol2VI=;
	b=yzo900uQmy+xTQvLXgHRRMb1bxS8SVMAVnt37P2WaRJO/awwQxePWFd2FTnL371Kl1e/
	 H9XnPK8AD3vqesZXU/+Lu42pvxQwgeD6UZpx4PM/Fa+J5WhSBixFmMXETEIh09P5ylEyI
	 Wn/6bKopOwmsErAKmaMCIz4NuHCmcRG87hABOsjIMPridcIWxoZ3qRZA7cPlBCClPlaHi
	 KiAnag6v07UpNA2rhUU1j0t1Vbm/YpJ4c3N1jnvzhzLzaYJf34avtsItrTK8F8aJxwXXx
	 ok2aZvuHWo2a8TjHQmL7TCVxQ0fDcyst/BGblUN1wXEOD3DvYcMfdOxqMhW4Mut5aIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6oYfokP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4FA606A326;
	Fri,  6 Nov 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c6oYfokP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A3A1F0089F;
	Fri,  6 Nov 2026 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968594;
	bh=Hx7cpP7lpaGh7AkuWcK+sQJGurQzMQvP0gaLMaol2VI=;
	h=From:Subject:Date:To:Cc;
	b=c6oYfokPli5HnMjDqiK9hQc1gt/5/2rgTk2N+PdsEogF5Rb0xC4EkwKKSJdzoc9K8
	 HS1XTD3nLraUpK8VowFt9JqOWw2mOuq5pvzIYhtQZTSycqJgjprckLu+K75x2XZ7wh
	 gwTUfzewIpkbk6W/WyvJbVYR2+ygkHdCfxilGV438DT5X7DVGxkr7ALB+/4cLXV93T
	 SS2tiUQPMwleiF/8oAU5p7Xu8bFYaZF1oi9QtcuYHUtKGYNkWCiCwysrt8KxbQRiBE
	 Gx9IK5fWfjXxwY7je/WymljXri9BgQhnfcD7NSslt74Ve/0wXDa7bYeyS8AFFMG/XZ
	 FxSyu0e3fnlCg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 0/2] mm: free unused page table allocated by
 do_set_pmd()
Date: Fri, 06 Nov 2026 13:36:11 +0100
Message-Id: <20261106-khugepaged_set_pmd-v2-0-d2457b5e377a@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIALvJ7WoC/32Nyw6CMBBFf4XM2ppOoyCu/A9DSB9DqSiQFoiG9
 N+luHd5knPPXSGQdxTgmq3gaXHBDf0G4pCBbmVviTmzMQguckR+Zl07WxqlJVMHmurxZVjOJRd
 NgRfKT7ANR0+Ne+/Re/XjMKsH6SmVktG6MA3+s78umLy/BwsyZFoVpVSIBZblrSPf0/M4eAtVj
 PEL+WSAHccAAAA=
X-Change-ID: 20261105-khugepaged_set_pmd-60a02f718e64
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=david@kernel.org;
 h=from:subject:message-id; bh=rnCuDIVL0uS0OJkHISNSKHBKcslE0lMw5D+UBBh9Sj4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLenjw8rfl0Ged9i0xbRk6FjPMLN5wT9PqmG7s9LtDZd
 YpXUeTPjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACZyUZGRYf9izc7zz+8tLarw
 1GP2O32cYSXfgT+xeySf3y2b4zKf4TUjQ+/CU/zTy97d/OZ/ujqIiSfUiKdV+ZuQ4bfDHxM+7VI
 W4AYA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

This isn't super urgent, so it can wait for 7.5.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- Free the table in do_set_pmd() instead.
- Add "mm: don't allocate a page table under RCU in do_set_pmd()"
- Link to v1: https://patch.msgid.link/20261105-khugepaged_set_pmd-v1-1-cb79ab117199@kernel.org

---

David Hildenbrand (Arm) (2):
      mm: free unused page table allocated by do_set_pmd()
      mm: don't allocate a page table under RCU in do_set_pmd()

 include/linux/mm.h |  3 ++-
 mm/filemap.c       |  2 +-
 mm/khugepaged.c    |  2 +-
 mm/memory.c        | 16 +++++++++++++---
 4 files changed, 17 insertions(+), 6 deletions(-)

---

base-commit: f44fd601f72e09e44c667b9234c9cd469856679c

change-id: 20261105-khugepaged_set_pmd-60a02f718e64

--

Cheers,

David

