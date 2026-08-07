Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761F2C1788
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070180; cv=none; b=RvlA7ZX5UVFBjphe2WeYUbLnCqHuIGvweOXs38ON/niZ3H8b21hC2ch4XaaqL3/NZrs4s/xDVfHwIX1G1IQYPCLfehoPKsS7r6r0xrFp9vgewMinzdJ54tS+HL/w6eLTur8p7UeGJSYvdKqmxbIpdXVdHByGL85cOacJ6p/dbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070180; c=relaxed/simple;
	bh=KZSRYyF6I9F8wpyMEpggc4pQlokRQCAI8mzeS53w37M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3A/dcqWE6eyYIvw2NKZuTJobCgNpNqwTT2oBpdrseKmIA/fdU+zH6mi6f6nZsdEAt8ZTzaQuBwGOweKzcfsNXkcILFD4KssG9tZc9eHpORAMFcVLZTwhCXOeoUVqiVyYOtmkAHWqPHmF9zxWJ3ZjkVd5G+4hh8sMnpX6sT+g2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIqKrv1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIqKrv1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A001F00A3A;
	Fri,  7 Aug 2026 02:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070179;
	bh=zP/DudSBLiY8QATRJzqq17b9OecK28C5BKiV4iaWmcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PIqKrv1VWeEcC4u7raweaZd+3Kd3VzodQTZKA+X1kb7nEUYThivdsLK9rL9wLPEQ3
	 p4Q3SElhkanvnq14QaiiFPwCrXIOf/B/XiCqougzb3rwdbLms491RSg3Mn0YOlPaTD
	 AhOiUEllIDJl62+2pRmFA24I2UbWzERI4pYyToexR0eh7tkA0U5YkeLF6ZY7XqPJ+U
	 ZbAqJaPucEdxvVzum/lEfOecZWORwkahixmm9VQIELPcIQr9BAc5/rXHsuDFuFHkkh
	 UsUur/JAiyphzYUkxN/gXdjIseTYY1zt09TVFjTkPZTF7hocIme8CjwJMMBFogvvWk
	 xB6iVO1E3v5AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mm/kmemleak: fix checksum computation for per-cpu objects
Date: Thu,  6 Aug 2026 22:36:15 -0400
Message-ID: <20260807023615.1684238-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807023615.1684238-1-sashal@kernel.org>
References: <2026072949-quarry-sleet-f3e6@gregkh>
 <20260807023615.1684238-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 79c37ae3733e93d9d8ea12ecb44f717e61439024 ]

The per-cpu object checksum folds each CPU's CRC together with XOR and
seeds every CRC with 0.  Both choices make update_checksum() miss content
changes:

  - XOR is self-cancelling, so equal contents on two CPUs cancel out and
    simultaneous identical changes leave the checksum unchanged.
  - crc32(0, ...) over all-zero content is 0, so a freshly allocated,
    zeroed per-cpu area checksums to 0, matching the initial value, and
    the object is never seen to change.

See discussions at [0].

When update_checksum() wrongly reports an actively modified object as
unchanged, kmemleak stops greying it for an extra scan and can report a
live per-cpu object as a leak.

Fold the per-cpu CRC as a single rolling checksum across all CPUs and
initialise the object checksum to ~0 so the first computed value always
registers as a change, even for content that hashes to 0.
reset_checksum() is seeded the same way.

Link: https://lore.kernel.org/all/akfYImSNDh3OjIfR@gmail.com [0]
Link: https://lore.kernel.org/20260703-kmemleak_checksum-v1-1-5e0ab7d6966f@debian.org
Fixes: 6c99d4eb7c5e ("kmemleak: enable tracking for percpu pointers")
Signed-off-by: Breno Leitao <leitao@debian.org>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 13726533b7c5e..4092f38d3fc84 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -671,7 +671,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 	atomic_set(&object->use_count, 1);
 	object->excess_ref = 0;
 	object->count = 0;			/* white color initially */
-	object->checksum = 0;
+	object->checksum = ~0;
 	object->del_state = 0;
 
 	/* task information */
@@ -967,7 +967,7 @@ static void reset_checksum(unsigned long ptr)
 	}
 
 	raw_spin_lock_irqsave(&object->lock, flags);
-	object->checksum = 0;
+	object->checksum = ~0;
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
@@ -1382,7 +1382,8 @@ static bool update_checksum(struct kmemleak_object *object)
 		for_each_possible_cpu(cpu) {
 			void *ptr = per_cpu_ptr((void __percpu *)object->pointer, cpu);
 
-			object->checksum ^= crc32(0, kasan_reset_tag((void *)ptr), object->size);
+			object->checksum = crc32(object->checksum,
+						 kasan_reset_tag((void *)ptr), object->size);
 		}
 	} else {
 		object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
-- 
2.53.0

