Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471314;
	b=5PjLTARuxvma3iq4XGWW+9AoaI3EowPdTBmX9DZBBfaZ01u96t9gXv+2THgJbbGl3vYr
	 OvD7g0JnaeQMgaxTicwEOzWcpMGoLKQb7+CdA6kA+s5M/f5LgLQevSuTbj7d/oxxPZCHR
	 G67jSny9pW+sVyInhUbYPI6aB1frZ+6LVvwj6xps/EycPv66IRG6MkZXOkDDqM5vcCtm1
	 Xpj819rE2Se77QL95kSN+UAeMdK1RoLN1BUDnONKxBle8W9EJEImo4GdbtrdCskZKm645
	 TNVQddJ6BjNHXVbxzaAxCuXGNyhMqmXPzUIQmzoziE2uXrPeu32v4TgO/TBvxlblJpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471314;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1+Qk4yxS+WLSAlHfFLvNSdF60pD3i/Az3wtaXQpUJAI=;
	b=oqwojwkIATyR0O9Z6+fMMl3N3s7yf6bvz7l+xeOakDioEu3j1OUbCxs4tLSq1nkXA16H
	 Xa5VSKJnAmW258t6orEnmBHeJxBaCDZo6nFRLxhqDDJeG8Gao2cehR547JlzWVJzD4THt
	 nUkVrRYOXQVLaNtqIXJ+DusKJVDyHE2kqWWOltxl19VvIxAiD1dXIMweMRmo80vF5FvWx
	 slWsgMqjea4qM3B1Ovs8sjEt6YzOORq5OFZ8Yc47Vu6xs8GPogTCOVfDI0EWI5JVqm8ce
	 M7qJfvvvROkXkmDkzbNpi2iKNWYtSZrudodTPJPzhi/lHF21OrpjU/NhBhpwyP4pxgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fUalKROb;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26913606A8B1
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26913606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fUalKROb
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36fe5944e9aso3907878eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471313; x=1795076113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1+Qk4yxS+WLSAlHfFLvNSdF60pD3i/Az3wtaXQpUJAI=;
        b=fUalKRObaHNMzuWubdu0Wa6mF+JSgWHFTVR4pjJbUGLDUpUd9csQV9hUB1pA3IRdM3
         vZtWnA1O1Syx0UtnHW4LEd0edKe+X7Bi5Mt8L8FtSDgYLSBvRLvYrOcla+tN2BSySRBb
         cnWke7R2nSmt9S0YW/oximQutwS190OifoF7gJgQySoPOGCrlMHdn7aK6beTfodiKp1C
         8/SFdLDuTjhHPT0qxWpGX0Nex9pttNHbjNx9SAf9jaN9p+KThpjhEEgxXhzNzdX0uKTL
         XMA6jlaAa2TDKrzNdgZJBKZwHVAATHFxnntKqXJ85tT6TlkYUhmjP9YsmkOWmzHWxPRK
         rerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471313; x=1795076113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1+Qk4yxS+WLSAlHfFLvNSdF60pD3i/Az3wtaXQpUJAI=;
        b=mqdJqoydeB6mA/8gL/PUvG6Bfjb6KWNDyECUnWg4YDe6fVDw3/6ISNjtVttmuofFML
         QQJRof5Mn1d5+x2n5DxOLd7/HDRCjEyDvySkdYl0muUFQrOP22Ee9Y7H9DJQDDr4UaBq
         93yXeF5n2l5tAwbFI/5BdmG1TKthcPNM/cN06j2xBMjTqDox8di4ij2BEFDT/Uknk/U2
         vijLpBmv/Gy5KC0ig/UBYtnTvtSGkRf205fUDprwHmIIcVZuKpKO1J1SW/zYKxyCO/Z4
         dtJVO/hmCVo+vEGY49vQtSv9bMcQRoUGQFZUUlIHghY3Qg7fwT2pAqAbd5L4BVcDSL6n
         vewA==
X-Gm-Message-State: APuU4Z/0FfrZ1qQp/SLwjP3lw6cO2Cu1bwkCoMV1KBOUXz4m3X0VLXih
	1WKqV+xOhcNNci76l6+lJWXIL6FHZWbkzMxje7FOnfTC1fMFF0Hyz+O/dlZw9/vsKovvYw==
X-Gm-Gg: AYBFou3XVYkafV+ImnQMQpVqVD2mjGYBXv7yg7Y5UuKo26tBf51atp53COe5NqKxqpM
	R/elEpf+TYkfS7fe4lhDG+TWM5jzqK23ED5FQ5CUALBswKp16qdfeYnmucXIM/6/GZC7FtNB5FC
	VFrhXPjsEipGip3wn5RgxlmCDJOEb9ond9mmR46+sZ6nHkkt/wpSwb+KgbW2rMKjYak6pXrfKIR
	XyOCti+FzGUa2LTJaJO4yObwmX4YMD+Sb5nAbGVs0hrfZEG4m2ckGjuqbygVt9JFCpFybGWiEkm
	X4MEEB60ej26CoI5/O08klV2SpS5dWHAWrKwrRDFaRRmJb38PWq64/pjm70vr606BDqtcmhW/WM
	oefO+cOUxmKi2bCNMw5d20+gvulJbI0X9vIGDj9Ccr6DdlxChYEgE7L5jX3ga/wLKY9OxO1Yj/j
	ONcRD4Piebug9cM+hG4lIimg2bGxyJfU7uRhe9oDpMul30N/O6w5TBH+JR+bsR34InKuKneI/pj
	EfJAwOuIWtahE+4mNsk5CAWoKYUR/PLRIsBIgyeVQ6q3ilOsc9qtavN4upizjIJEm4pzQydXBE3
	spX9N+GsjRFtR36kRq1GL+bnsE5uxkGyZR9WK2JDv4efdtTpEZAvxIFBjtJZEvJwQDx6LNqtQUg
	sAEN7IFoPdwE/vtiadNzb6yVfkjZr1GeEdwbOow==
X-Received: by 2002:a05:693c:638e:10b0:375:dbeb:b363 with SMTP id 5a478bee46e88-37686d341eemr5344731eec.28.1794471312570;
        Thu, 12 Nov 2026 00:15:12 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe3261csm21034033eec.4.2026.11.12.00.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:15:12 -0800 (PST)
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
Subject: [PATCH 5.15.y] mm/migrate: untag addresses when querying page nodes
Date: Thu, 12 Nov 2026 08:15:04 +0000
Message-ID: <20261112081504.6060-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109202213-failed-5.15-7d8746d7dc9c@kernel.org>
References: <20261109202213-failed-5.15-7d8746d7dc9c@kernel.org>
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
Use untagged_addr(), the helper available in 5.15 and already used by
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
index 728fbb0..cea3510 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1889,7 +1889,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_lock(mm);
 
 	for (i = 0; i < nr_pages; i++) {
-		unsigned long addr = (unsigned long)(*pages);
+		unsigned long addr = (unsigned long)untagged_addr(*pages);
 		struct vm_area_struct *vma;
 		struct page *page;
 		int err = -EFAULT;
-- 
2.50.1 (Apple Git-155)

