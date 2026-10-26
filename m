Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044425;
	b=CXs1InqEjLW6EBjpik3BGPJfnfxdrcwoYRCLmF6Ep0AdsuRdQdeU2DHR5RXngHrgCgQY
	 RU1qOc6wW9NQj8yEps+FjmX4GSsiAC3h8ZRdGoAo//xImMNLoeUi1kN3XCsXnJW3qk+gU
	 XHD+GxiMHlSnEVlukM8Gq2k9JIXSklNusRN8Fl4w1VSiXfOuWeTsB7eobG4DsxIHceR7K
	 18ex1fuZgNPooKD2C+mgSfaSyEVH2LjJwWY0TG91pki9pxaxdk2M2apsA8JlGV+p90gmL
	 KmndP9nSXxXTMVp3Mj8Nl7NNQ9qhad4i32ZEh2FJHDJ3qThXl+4if0yoEOrpoJHrPmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DTIyB5b+yzQFZkwGlBG+chET3oIYSbYIvUVhe1jopHU=;
	b=Uaj7HlFcNB2DCBPH4k16z/scwQlG+0zy4D1IaCoZJi+n+KWoFMhXTM7p8bgyuq/I2g/l
	 oE22/GPIFQnlf5DmBFQU0y5WCC61oaJV7ewRSHVg8qYW3MLxBkcR9foo8y+8Q5hWvZOdR
	 tG8kDBNQ47+RezKL16X/iEtvip6eu698pnwShHTBq/ZcD6i2USJaKp8c1GvK0lTyCvlIm
	 NYxi1SCdo7b/83WTweJK5l152m4NjH8SwRDTRdOBfk7fVKDlf4//FsZ1quauYhWqNVC7G
	 gZPKr8sTNVKxcg2k1mZi73CmsHXopdjxrfV1C8VvhfaCljLPURjoCiAgFyZo+iyIMEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EsXgxSlV;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED5606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 19:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48ED5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EsXgxSlV
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so2068734eec.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793044424; x=1793649224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DTIyB5b+yzQFZkwGlBG+chET3oIYSbYIvUVhe1jopHU=;
        b=EsXgxSlViFWnvVaoy69Zj4ayaHK+nRSf1ObwNUSDddbTc5EF/OCvDYq1HMW3A8nE2p
         ufnh69MHW00wS9E92b4dY3wV+tYvZTH0MvMf6z8lIDcXyIQhMWZLCUYTLCG3ch7JCib1
         rCSKk3TO5nwIr9oseYoItL8H12Ac7N9v/DKXE0BZ7Ih44683TW9o6vnpg6B0vFkQOztE
         3bWFNlJJQ/QG9n35kX6FQdHp9bSSfdUJ2D/ITlEzqPG90MHAvwu2rv4v7Poff8iddyha
         cwA+/jZ+tm0g8tmVKjq9qUVwy94+ukQZANX5uOFBg+CK/iXKSaUfku8hsf/Q2sGl2Jse
         g+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793044424; x=1793649224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DTIyB5b+yzQFZkwGlBG+chET3oIYSbYIvUVhe1jopHU=;
        b=opKH2ag5lAmS60dTO0gny9OThAtUeuZXCbURTC2x5sL/pLFKZcai1DuxO0LteTr2qI
         CCcuzEzyQMqk72uXD8rCFy5XUAOjQB1eAtvJXVM6NUwoHOCYnKv50Nh6KAH4XdGtBHDf
         2cq9HpgoY8B+JRu/dsa9CMP0nPUyLzuk8BhoPOHSehQ5cUiwd8HXmlfaWB99bKrT/Z6E
         9rhumbflgrX4eTDbMKzyrXE4m7ej6nDpRLL3Ju80S7ZtInuvQHfoSpBgkzwQ2hoC+Gok
         MYmf/s3YJPWJqGz/5DDGPw6GumvI84465iM+hOu6qpaqVbEaJdER8G2DbqNGUtL1de8B
         x4yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFxaEsZ1El6k3hYS09woKvPWug8BTVHrzK9cLn2x2QqTAm5MpSWfxJTJmkAfmcjC48XCJJ5hs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJF01rMu9+JFA07425tNNNSpV8SVkiTLwXBr+fHJBYaoGxEn5Ya
	ABoEQjbAmB0lmExBx91STs3GY7cIxXCbE91E08foB9RC0gU82hZ+CfQj
X-Gm-Gg: AYBFou2411+fPgkSnesmGLo+i0jraFmS5mF5wjweBGZJMpi3zBed0+viXn8rJfNyEAg
	g3e6ixpIseIepjEdEdYr/nKT5T75vGcq5UGjxks+EE7JNe4weBwtdi0qzK2CsxPydWh7me8xjo6
	MfCmkGCpgg6BeQW9XpyXvMkcadAP11T+CNdYP2iTHCgen+ueojRBXqRsmHs5A0Zc/QPOu4wV4k0
	k+tePos4y4hAwXRgOFuejP0lbkKH0Eon7lbcgms29HbZlxTO5ffRZLF2DrhCOoLLs0LTY4zyHxu
	4Mh25oN4Ds6nW3uq5mvOze8sBcCy0ny2e6LhXx8INnr7kUvIHAp7nVhKGOhJFnQ2Dz+O4gFxm+a
	77WvPbFDgUZK7Axd8pBKk7qntZ7ExdtcrcaW8y2xzAdok9jvjQtrRLP24WUrpskyX8PhpSNssZ4
	99wiMNggpbsp0XzRN8HydH/6P1X3IXqFA6aRD2RKsB4oKQhHQHtdv7dEIWQNZvyAw+Z1xl+Egx5
	qNI0wNMbx9L5ezGRhsWkwBpsfC/S2XJ9I1eRO7dhHmEJ5+ZLL4R2bV0NQNZkE4irUrvYDsn9+3Y
	4+sEEcqp
X-Received: by 2002:a05:7022:1508:b0:182:6c6c:d876 with SMTP id a92af1059eb24-19934a928c1mr12215723c88.8.1793044424317;
        Mon, 26 Oct 2026 12:53:44 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm25821501c88.22.2026.10.26.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:53:44 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	andreyknvl@gmail.com,
	catalin.marinas@arm.com,
	vincenzo.frascino@arm.com,
	odys.yuan@gmail.com,
	sashiko-bot@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH v2] mm/migrate: untag addresses when querying page nodes
Date: Mon, 26 Oct 2026 19:53:29 +0000
Message-ID: <20261026195330.46757-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When move_pages() is used with nodes == NULL, do_pages_stat_array()
passes each page address directly to vma_lookup(). A valid tagged address
therefore fails the VMA lookup and gets -EFAULT in its status entry,
instead of the node reported for the corresponding untagged address.

The tagged address ABI permits these pointers, and the migration path
already removes their tags. Apply the target mm's untagging rules to
the query path as well, while holding its mmap read lock.

Fixes: 057d3389108e ("mm: untag user pointers passed to memory syscalls")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260721183257.706661F000E9@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- Replace the report Link: tag with Closes:, as requested by Zi Yan.
- Add Acked-by tags from Zi Yan and David Hildenbrand.

 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7e3a81f06974..994c78782a54 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2461,7 +2461,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_lock(mm);
 
 	for (i = 0; i < nr_pages; i++) {
-		unsigned long addr = (unsigned long)(*pages);
+		unsigned long addr = (unsigned long)untagged_addr_remote(mm, *pages);
 		struct vm_area_struct *vma;
 		struct folio_walk fw;
 		struct folio *folio;
-- 
2.43.0

