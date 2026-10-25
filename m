Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967576;
	b=lpVwM/TeyvYFNhq1igFwvTynvSM3XNYQv+VisnrCwk7k4HtV5g8Ek7wQO/M7t/U1Id0K
	 HigPTlyBkE1oCFfosr6uA0DwFxaN0zfgHNgsXmbF83BEYKPacLLfQuo0Wq+qE/RSVYnkP
	 sZGHC44Sgtp5XEUge804LDRu3EJet/QzvR1DfO+0mhqbjInZ1l8ogOEVhSLjO/+Rr0Ar1
	 j/eKa5kqkyHzFJwIzEGOmbGjQVXjWVTWXzxNl+glQSFDUzNd3MDGeOIW1lD7gpIqNCzGj
	 IgPAMh8FaDny8Z6ltDCHxzeLOUVU3/8AcBc5c4gldwV53WiCn+SmRffkOEE5ZgvYKgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f0CD2JTVPSKVQ8ahg/uzbIr8a3vhy8fPw66NRM5eXd8=;
	b=sH2YMgtiulAuZsOruePlA0jSI69rmPl+h/jA97DxzNyeGnR2kEqpVQRQpRJ9aExGqEiK
	 y0hSS3S8nyICIAMbytzYuf6UvKluaIMyAPz41SvilNuvqFBVxl7Mbg3rBdXwqMtv0dOSM
	 O8oTGjB4x9pQ7jtsCQncf9Coe9xqLYZNtROefehuWwWRQC98Q4fKqZt5yQpMB1ylutXsj
	 IiV7I1Ft+3FS/FBFI08QgLEnkQYbJ2Ec4bRAFZeFS3ZSih1xC0OqoteSXyvngsdXwHXam
	 WwWztSEiAF5jKfxiNn0O4HnLVYDVGTgA1oafsOxXU0xG1EPN384QT59D/3MYIeHv3XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dfDtwcBH;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67D606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F67D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dfDtwcBH
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so1589138eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792967575; x=1793572375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f0CD2JTVPSKVQ8ahg/uzbIr8a3vhy8fPw66NRM5eXd8=;
        b=dfDtwcBHat6xDooPW5SkCB74KG8g9hnfX7NXJxMoZmGNkmPkV1IvA4zCYjlguG420M
         AqANLvUkrUVviRy6TEc2TZ/1a0yP2sV6Q9BR3hr4bT7GFdpva49ZrYNMSuDy8zTnzUVE
         xPel8ucoQ/l2Ku9ze4NRxCb9NSMLa1yLF56H8bjf9XLtlh4fYnZ6rAzm367Lvk/slooh
         pPzjsyuTh3d2mWQdRRPwueZmFRE+ERJwRWN+/Kf9UrWm4qNPqFAIIntoIIu9O3eh4hWx
         7UGE+vqoJGYvX57uym85BqGcZ8aYt28Uo/5SOF2x1C2kcC6iqqt+OfdmIg0EfSsMpNxF
         EeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792967575; x=1793572375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0CD2JTVPSKVQ8ahg/uzbIr8a3vhy8fPw66NRM5eXd8=;
        b=YDkp2kYvGwjE1co/uL9F8TDkAF8SAvPGGxagMBBzg/XuBvbYyc3mN0e+zGVF9gsScW
         bkDwe1SGkyX5YJZSLQLkttxVtkCWNpW5dUApMgB2vr9h399jRRWTqqXR+La9Ys2IAtZq
         NtawuFcEvUHVVn5JC8cnETLRL3r4PHyyKDBVj1Ne83rRuyp9Z9+LpmTO5ZbpOUrDFCEc
         IJh9ME6ewNjOJnwZyjU0H6zG7I+fmfcAPsAUc4CapKCRWtCjvBo2L8UVWutFSLEF0EiI
         musCIfDwBvhOwCL7cgDoYNxgt86qJPQx/NsMqf9GQXG7evMmnvXuK4Zye6TlOykE0TPj
         8E5g==
X-Forwarded-Encrypted: i=1; AKwUvByIUtWMY00EdZitB+rrIZcZNZ/vs8wFTRyplU7gRZm54qKnt5ltvWkpcoDQ20JWo6gI8eSDm/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUxx8TAnzoPUK5VAIIu01oFEOxRHUWQD3fOknQIJfyk7Iac5RJ
	SUOWXTYQT82gVpqdpp2Cc2ox0dUNpzTn8ik6LDGJmtakHRTamYCmvuSX
X-Gm-Gg: AYBFou0JvZSXwwfMHJzsp+DUHPigSsW90h7mHo4fIjkCdEyfweFUWpIIjYWvpQF6lDt
	hvKP7LuPftj6jZVnaVFieoT8tIXo9tnZri4bRDR+zy9f0lj9AmLiO/+oFo1oiReFbU+wqTmeDTb
	/RLYn2peJqPOrT6CSb8qwvrJLhSvkmSa0rgYlLx6GoXaqa88DaXK3bQ+8+40SRYRBTBBp/XYwQz
	B12GcoRvWxxW7yFh0N8plLaQttMFnHBjZQ9ssgIlywL3A4yVPdQOOeh2Yw84wnx9tb2gmVwxw50
	p7kHWYhz5NrKG8XwADAU12/60NwLmCyaE9/kejIfHOebwlUCmjAeDBR5m2hcJkhf5fsZgQIw5Xp
	S+QqV+dpf6OjT56OE8jdSS9FWGDPtOQhhQxUcdiWY34KbaFoDiIRw3Q9uEKQ/1h5nu56bMoj/eA
	CwW6ON7XNefeqzD1Ygl8NKZX18afX22r+piiX0IKDoP00kYxc70z/qkdrj9ou6f/bOMhYK96azI
	SJ8ibzo8vNP4gRdjA7jULwEaCzzEVrytfrFAd90xJ43xz++c5IVcClIM638+5VbSGJ3JjfcA5Ew
	i2oq24U=
X-Received: by 2002:a05:7300:fb01:b0:351:4a80:d94c with SMTP id 5a478bee46e88-369e862a0d5mr7633319eec.21.1792967574632;
        Sun, 25 Oct 2026 15:32:54 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a026e04a0sm1943471eec.1.2026.10.25.15.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 15:32:54 -0700 (PDT)
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
	khalid.aziz@oracle.com,
	odys.yuan@gmail.com,
	sashiko-bot@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] mm/migrate: untag addresses when querying page nodes
Date: Sun, 25 Oct 2026 22:32:26 +0000
Message-ID: <20261025223226.33740-1-dennylin0707@gmail.com>
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
Link: https://lore.kernel.org/r/20260721183257.706661F000E9@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
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

