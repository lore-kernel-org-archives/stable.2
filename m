Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715F45629C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211153; cv=none; b=jtteDQgjqBoWrhS53FJAzOfKpQ1EEwlFki/7IhTnuTw1iYwmayqkKgiy+kBCjo/0IMCEDH5MEOpYZbG5+6cdQib63GS6mq/M+wZxhWnuP6QRnb6LmxUP/FotU7GfkatDgLXn8IJAOYAYqa7ogCFaudPswMCRvMwRU1APl/Vau4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211153; c=relaxed/simple;
	bh=U8dyeE2ZjfwoSNqhH5SB3JRkDp/E32wGLTTzgffWgZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxof6ToJVqBq3O1505xAkhV6Mo8VAXuNv0UIrLx/HSYR4vLQoDK+lAnB+6DmICfUwj6cSLtjn4CmB6jNZEtGHPli5FKlVCo+rLXsh1jGqC45/CVP3R3uJ3lSz58oPe0m7Jvn3Cdbq7EDrx8npzZEK2v6q49MWYWje9d2ztvt3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jLA/aQWv; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jLA/aQWv"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90e92b99ab9so13572856d6.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789211150; x=1789815950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ea2NflktZJdbiCBZKoJ2b9G1DxTKGyvVgfDXxJDHwxs=;
        b=jLA/aQWvnJb5+Kjnqljf+Bx7sfbJa5WKhYuY4xZvlYNQ3TI5fmA9i02WrFHZaRFlY0
         /b4TedtI26OywsNu7OrcBKkNt2OQXU1qxEzl2X7Ub8eBup/z0THRUufyIDl0KodJmiSV
         86+CoC4DFDI4+uW5mcEubx0U4qwGH7o3yG3eALZunXcFdOph5Alfq/Do45HWweoK7k2L
         WnUJnsXrClSMBY7qlppmm/e5s0nvox42yndEr96YDa5i9YB5OwY1rpLzrF++a8TLUXgS
         jSIZEZnXwM2O4OrbjGWsc12p4lv8WdQNRYCZRjtvAS5y9D7frbuQGkso1FFLdGA7tihZ
         f0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789211150; x=1789815950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ea2NflktZJdbiCBZKoJ2b9G1DxTKGyvVgfDXxJDHwxs=;
        b=Xh1jOSrOYIZG66ZTt7up0t2nlvM0WbECLM4DxvZKOVXGW1kCjk97dAe4QbCQT2mYFE
         avJezCRMIjzeIoIQ3NQK7awg31DqNFOChzM/qe+cbZcindIm/ydPvz9pFCt/3hrKgQ5B
         OWBhlqNy5e4RrufIQIojynZAle51/88gflcY4Zj3Apvh5oDYVdQQ2HAHNIGOHCeRvbs7
         0wNaM1YVngBiuVmdmEspQ3ZzonKgyPqxDwg1G2Q2dnR/1JjUGZgQ7skucBHhkyYhXtpZ
         W4WlwHTl28ihKB/1xb8hqPNYfjYCJRhn5VGzvfNCEQWVkajV/g1Scaz7YgEcKNnEkTK4
         n8tQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1Hek9PitIi5W1DxyElvgL2/aY7hv9oR42Z5EB3YBj8slPWkOtL+pGTW8sof+DG4hRjF3n9II=@vger.kernel.org
X-Gm-Message-State: AFuF++lQ1i8eRkGCrDRSK7MesM1G1zWtaWxxRO9mjOVLSGn4ywGu7Tp3
	YjEd5tZcQKniAJvZsUIl/zYvtCkjksof9PbMdTNGiIwruEMgZbuYsygBMCt2gpJ9DjM=
X-Gm-Gg: AYBFou3787PEAxecOT/3sdsgJD7nsJd/6Vja66cCXGAwdcLN/r3TpKYADbgNHYIzyvY
	042X3KrPAk0mVmlwZOb9UBfHH5CYY9ZDgt9meKPwKJYREjmdPcq4ZI5S1suGfYFE/KMI3trntJh
	xBN2zReirvSqpd5qi3yU/kwiIeTiSTjaUL3tJ2/pp/N8z+san2LzCN7wuw7+0OYH5m3hk64cFC3
	c+i0UfIt2JbtTk63kUqlDTrjeF4vxqSi7yVrorxykvpvuMtG/Iw0rTxbFzD2cBhqStvFus03jJN
	yQ2cQVFvO1MCfRhP7wSywfVf8FFX4nnP5JTXqi4E+Os+VsXG1jAC+5RQFK3b4oQClfogR4BkUT2
	LSRIdElomc+hc0GdGej+XK9lfswXYNmrPz396Shnjpz7CrSGe7I2HhcmEeTt6IGMWDOERxcGkXm
	4EDYrvo+C4Ckr7KcSF3m+Z2rNqy0aK/slipCC+iiSWVFveeuIdN5eu96lqER4vvY7B1M8mOew2q
	6fqcGTYs0hip2U6sja3AchCTjZVzQzAZ9aNvasMjLlEwkO3epmbRa4f5ZO+
X-Received: by 2002:ad4:5d62:0:b0:910:3455:53bd with SMTP id 6a1803df08f44-9121210328emr111288646d6.35.1789211149924;
        Sat, 12 Sep 2026 04:05:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120ef650a6sm44575746d6.0.2026.09.12.04.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 04:05:49 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	sashiko-bot <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: [RESEND PATCH] mm/madvise: use folio_trylock() in the cold/pageout PMD split
Date: Sat, 12 Sep 2026 07:05:40 -0400
Message-ID: <20260912110540.3203010-1-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MADV_COLD or MADV_PAGEOUT over part of a PMD splits the THP in
madvise_cold_or_pageout_pte_range().  Two threads doing that to
the same THP create spurious failures.

  CPU0                          CPU1
  ----                          ----
  folio_get()
  spin_unlock(ptl)
  folio_lock()
                                folio_get()
                                spin_unlock(ptl)
                                folio_lock()  <- blocks, keeps its ref
  split_folio()
    folio_expected_ref_count(folio) != folio_ref_count(folio) - 1
    -EAGAIN

CPU1 cannot drop its reference until it gets the lock CPU0 holds, so CPU0's
split always fails.  folio_trylock() makes CPU1 leave without ever taking a
reference.  The PTE branch of this same function already does this, as do
madvise_free_pte_range() and madvise_free_huge_pmd().

Reproducer: 400 rounds of eight threads calling MADV_COLD on half of each
of eight THPs, re-formed with MADV_COLLAPSE between rounds.  From
/proc/vmstat:

                     thp_split_page   thp_split_page_failed
    before                     3186                     860
    after                      3200                       0

The short before count is rounds where every thread failed and the
advice was dropped for that THP entirely.

On failure the walker returns 0 and nothing retries.  The PMD path becomes
best effort when the folio lock is held elsewhere - same as the PTE path.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
Assisted-by: LLM
Cc: <stable@vger.kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/madvise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index f75a9d139980..ae3d7127d87c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -419,9 +419,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (next - addr != HPAGE_PMD_SIZE) {
 			int err;
 
+			if (!folio_trylock(folio))
+				goto huge_unlock;
 			folio_get(folio);
 			spin_unlock(ptl);
-			folio_lock(folio);
 			err = split_folio(folio);
 			folio_unlock(folio);
 			folio_put(folio);
-- 
2.55.0

