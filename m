Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471558;
	b=16XTZP7fcc7QOf7ab7uKW0ncgozTBNd4qlobH3QAMf7Ma/JdDG0UrVaTjczy1q3eWnpH
	 ZHmsQa0dzBkT+pq9cl0OMMfgs/Db5YwwnVhMBSzkmdqmCjhwFZSr0hjFl4vZfdI8zCsJ6
	 syUMybT35e1gQjfT4iaYb3cARUkAMRHzm9JJq2RgwKv3Jzn24L0EbvXDOXalAIY/p08cG
	 JjovKlZcvPYQmkehrzTDNWtIv7KY7NFM1Oq8ZdiIee/NVBi27h+D67vxSxzASL4647Z84
	 MJ0eO8uegVMUq9ptf/D/JiPqNOMoPfZ3zOg9gREQvSuksuJtU1rKc0hcPXjbsnUQWyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dy30eMt3vU3rBVs8jg/VKAGf/rC7hTtPztUsfmYfLTU=;
	b=GAPRLMB4XSv7eDsaPIeJuPoy17J/a4KDoG1KsfPmT18eWq7VIGnrDbLgNLCztal2KhR6
	 2BUdOS51s48wm2UH229n3mFPbdGRIY0I5vF7l0+KAFoFurxichrNjs4P+1W4W7GpxNbvW
	 zjDBigTFAuWSALfUZQdjx77+CvLKl8k24inDx7m538uUS4+zMR5VyV1lPzo4cEam/rXvC
	 2lNmYvnOD+ky19KYG2e93qyLjvDXoDqu1J2Q3EZFjiW36VbxrQw8J3m25Yi5kTbO/J70s
	 JMZbeBlHx9dm6OA7WF6GtL6yXH9XjSrEihWpaT8FJV+JW/NgjNECC7QGCpI3yZ86jtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJKa7TG0;
	arc=none smtp.remote-ip=74.125.82.195
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371AC606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 371AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJKa7TG0
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-36a315ed211so649313eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471557; x=1795076357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dy30eMt3vU3rBVs8jg/VKAGf/rC7hTtPztUsfmYfLTU=;
        b=YJKa7TG0kbJZoxXiJs+tNS+DXAfZpxLimpIvdn+d4iPyb0Bc9xnqVssuDcKM3Rot/S
         x0USRUsYMqiHoE3/pdAp8Dw/LqxOAIumqxP/1v7ZMjg1hqW8VZrVyPChw6N2d8GquoVy
         hMQXfkmom1cy0EjUmhzJSEOojkspF+oL2UlfVXL9GPuk8l+fgEqDOldom2nU2fWklB7y
         +0fu5j/Xrg2a9fYJqjg8jKxVSeakaJtY9btA7mJ0w08tYakjIEqbaz2KAa3xSoAh1/5Z
         0ozH6Y0LrI1XYEpjReBYi+JNEdUXPusG60ALMVe7Nlw7L4iPNQ6qUtZOkSQZ1shcaYZY
         90Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471557; x=1795076357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dy30eMt3vU3rBVs8jg/VKAGf/rC7hTtPztUsfmYfLTU=;
        b=uVRKk1yY2uF8NZ2hJcODJkBQElxgg/HjxGSW6IRJN87WckI/uYEau3nm003YQHRSFv
         AKOwV3p/mWtgarBJmRwSL8P6/g04aVVv0D/sbitKIBch0jeIiocpNaa+fxsseD/1bo+L
         +EtJGa6Bi/9k5ZMmOO9H1GkVaS/UJbQRILbu4rc/Y4u2vw8lL8vQQrjuvaHS/Ngoe5pb
         h3iT9Bvf6Xz3/7YVeTiFgRoct145BAQ1gDAWwg5NmqpIkIwfzsX/OjZBFqAtaNILrQAJ
         uyfbaAo08ivWSyJNmAIgd3M2NjFk9jDMxTZRMHAavnQczxNM9kOBNZwhmrb1RUYJhGZO
         FN8g==
X-Gm-Message-State: APuU4Z/vjggzH3IL3xboso96O+oaZabVzUY5+Q++jH3IbiIW75eeveGb
	vGteTOnhvZPAH+x4maEBw7NMWZP3a6nBdkLEOYKb7rLBn1HvkAejXmkKyufV37nmkS3UCQ==
X-Gm-Gg: AYBFou3Mo24PF5UILH1iV5Sd3+hnKvJalasv90z4QW0mTOi8zv9/EPZVpDyGR/v/Hz/
	krupr1FPwCpeiHMw+AC6XDbYiObMyhxTwIarGJu8LFXzFaa7o26LJQo6CqZY247D6Mfy+eQis6t
	KJ005X1ufDTzKurUh/2EscQDadvVxkIJ3lDh2q7AJUb2Z6bmknumCgMnA8S5w1Q2EXdJvGLWb93
	8YhTOYk9QewfEWF3n9wEZbhBVkQpxDPzv+/7rQMeihDrERKKILACZugP+XYpSPrlvqJx6rR0/NU
	rosrxfar30ZE2Q9YEdG1QjTRYCxGuPDtZX+4Yz3y9wJSLqXo6xUkCsaEt0/jGW+yD4M26zDJ/jx
	z2nxQoXyd4UArfEu8TIhgHpdSrHyZI6ac78bVAA9PauCgXbPsrlaqxPJ95e1EqeesUd0/TBQtzP
	DT/wElRczvUr1iqMQxQNt57L10BFMg9nR9rtxiqPyDMz6MlQbZWrfM4NzAmz9XlCnit5cFfhWT1
	j8aiZzaNkKwfCNNXRDeOaO6VExSGzgJfDnlAh1Zl/9zp79VO74antGqHbC7+wvLcwOl9N0dH2b4
	wMUd6XoDShLRBOgL2hgrkelM6QYsAodZ0E/85fNSKzSZ7q7IiQRt0BX0IMQPAOzaxTcKw1FXtsX
	Yh1eZ8dzKGApT8u5YZWnv0meZJKt+pVEHz4ashA==
X-Received: by 2002:a05:7300:d083:b0:376:c208:ed7a with SMTP id 5a478bee46e88-377e093e03amr1713912eec.8.1794471556947;
        Thu, 12 Nov 2026 00:19:16 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e9e03sm46569358eec.23.2026.11.12.00.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:19:16 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	odys.yuan@gmail.com
Subject: [PATCH 6.1.y] mm/migrate: untag addresses when querying page nodes
Date: Thu, 12 Nov 2026 08:19:05 +0000
Message-ID: <20261112081905.6095-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109201716-failed-6.1-7d8746d7dc9c@kernel.org>
References: <20261109201716-failed-6.1-7d8746d7dc9c@kernel.org>
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

[ Upstream commit 7d8746d7dc9cc4003661011424e5880ea7ae364b ]

When move_pages() is used with nodes == NULL, do_pages_stat_array()
uses each page address as-is for its VMA lookup. A valid tagged address
therefore gets -EFAULT in its status entry instead of the NUMA node
reported for the corresponding untagged address.

Strip the tag before the VMA lookup while holding the mmap read lock.
Use untagged_addr(), the helper available in 6.1 and already used by
the migration path.

Link: https://lore.kernel.org/20261026195330.46757-1-dennylin0707@gmail.com
Fixes: 057d3389108e ("mm: untag user pointers passed to memory syscalls")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260721183257.706661F000E9@smtp.kernel.org
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <odys.yuan@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 72ee689..09acee0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2168,7 +2168,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_lock(mm);
 
 	for (i = 0; i < nr_pages; i++) {
-		unsigned long addr = (unsigned long)(*pages);
+		unsigned long addr = (unsigned long)untagged_addr(*pages);
 		unsigned int foll_flags = FOLL_DUMP;
 		struct vm_area_struct *vma;
 		struct page *page;
-- 
2.50.1 (Apple Git-155)

