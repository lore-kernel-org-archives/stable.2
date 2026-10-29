Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269123;
	b=GAMlDlxhPdK9QUuZvPq/b0+ZpjmQi27zk4+b78oQgSurcJXVgD17qbhUKkDL4nPgPcty
	 yI9PewfpT1y507ZmrZh65uutKgT5h6WuaE2mNb4/dDkI1a8tokCtNnB8fxQl4csO75qOn
	 4RPQ8yYIUU+tBkUj4hVzASHwPYhpnwGD/s7Xmek6P8TbpETmGzt7mgYW+qx57xSvibsao
	 n+xwUD2YlZiXY65vmq5ZIpPmHSzKQJ+5Iazx4G2hqhyu2VX7YOZIGzUsA4h/5PbTBNEh8
	 n9dFVWEDZTnFrWjyXUdutJCL2OKEWzuX498W+q689c+EZQGmGxCoOitsTPVkReQR1Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269123;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=XpQcrguvfG92mrR/1zjrsuKSPP3ZCLK4NMxFB/iVLxE=;
	b=0QK5ceCRwBP9EQjyZ52qp4pZc5pHM5JdWOOJcddJUAUxZscVI7P1x+7VnmJxRPNI2LeI
	 AyOYoeA+GTvlr2VJHDkxpHP04UMxgkoRcDY9EotqZpucs62p1KYvQ/IT+kV90gfeLi2Us
	 M2EJBAg6ReUah4f8Ux21sOerbwVY8C9jyRbCOabZqUqDUZN3osaePXLKbJq+PS4JwO4zx
	 RLPNz70suK/lEmso1EZKsBzY9DIbhfhZItD+Oft73QiQkLLQHRVDg1uMiYLW6SzVwqipI
	 U3bPk+nIIEzqh5YV+W0S0PoXKOBbkrCGbhb8awEEGfUCW6FE6fLQXbK0FhpZFsdqXVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGZKVN5c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA960A262B;
	Thu, 29 Oct 2026 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGZKVN5c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B0E1F031E9;
	Thu, 29 Oct 2026 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269122;
	bh=XpQcrguvfG92mrR/1zjrsuKSPP3ZCLK4NMxFB/iVLxE=;
	h=From:Subject:Date:To:Cc;
	b=UGZKVN5cSz2uXvbrzke3kpSyVoCYXXylm+V8uh5iNqo7vR+jXc4fct3C/1z9hoytj
	 q7fgajy4PetaKS1N/uz0mIPjLjzWiA93XYt1lfamyEW3KRvt1xcTrsEkEipoRVT+uN
	 jMzpxuq0ux6ZhRpBEvgLxRv8tLrQjoB1wt8mfX9PAr7a28GT1/QyJHK0NMULn0iDXg
	 fB6kydmZoGzukHD/2kdwdB6Bma16AK+8UNB6gmk/8ThrgP8sdKuesF/OUWOPNIDbAB
	 5d/cCx9Xu8fbkmHVjNO7lMFZpCvcJftvxjXgRuZF8qtUbYUJMwq8G9b12gTpWrFCGJ
	 +1AUYXgsnEk+w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH 0/2] mm/cma: accept memory of CMA areas reserved with
 memblock_reserve()
Date: Thu, 29 Oct 2026 12:18:36 +0200
Message-Id: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw6CMBAAf4Xs2cbS+AB/xXhYygJrbCG7xZgQ/
 t1WjzOZzAZKwqRwqzYQerPyHDPUhwr8hHEkw31mcNZdauta4wOasL4Sm/Y69Cc6N4i2gdwvQgN
 /fq/748+6dk/yqQxK0aGS6QSjn4qahUeOx4CaSGDfv/x3LhWNAAAA
X-Change-ID: 20261029-cma-multi-97fd4e58aa08
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
X-Mailer: b4 0.16.1-dev

Pages of allocated CMA areas are released to the buddy allocator with
__free_pages(), which does not check for unaccepted memory.

This usually works because memblock accepts the memory it allocates.

However, multi-range CMA areas, used by hugetlb_cma, and fixed CMA areas
requested with cma=<size>@<base> are reserved with memblock_reserve() and
their memory is never accepted.

On TDX and SEV-SNP guests the first access to such a page is fatal.

To ease the backporting, each case is addressed by a separate patch:
- patch 1 accepts the memory of multi-range CMA areas
- patch 2 does the same for the fixed CMA areas

The second patch won't apply cleanly to 6.6 and 6.12, but I believe the
stable team LLMs will take care of that :)

---
Mike Rapoport (Microsoft) (2):
      mm/cma: accept memory of multi-range CMA areas
      mm/cma: accept memory of CMA areas reserved at a fixed address

 mm/cma.c | 4 ++++
 1 file changed, 4 insertions(+)
---
base-commit: 5b0764a53235d3c77e1ed674e836e1b3fe1a4b1f
change-id: 20261029-cma-multi-97fd4e58aa08

--
Sincerely yours,
Mike.

