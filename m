Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49FC331EDF
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791346238; cv=none; b=L+bdk51p4bwxIpRKwFcV5rUN/GtYb2NzZ6osIHJU63ohRwU/n7z3qanzuXVsJztwYo3Pb/b+G2fvvWiTg1gLoEFNv0EqGTMyoRgwKet0cCXkVJnK803o0a+/BYxjB4oRMxufpOdr4Wci3AD6GUSoETguuqEBU9azp3k29vKBbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791346238; c=relaxed/simple;
	bh=Dehgm5K17KIypaeoxVLrFfQbIbVwDYhVkmn2kILdwV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrEfkP3bgU8nrn6ZlprUk1lAlcmWUO1noTFVzG5FhoAhJ9Gh0N5Q1nb5sl3nsPl2DgOF3UittX1Vw4Qfkkm38P/EtyL1yf4hAZR2Rp9fiaw700SaLPm3dauttGmA2hKv8yQLYKFwUIA+ovlJXQegx1sjBFo438LaFpP7SGxci6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=TyUpRJ0f; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="TyUpRJ0f"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-81c5aac8478so787793a34.0
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 21:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791346236; x=1791951036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MBRXZKUt5w8de+h8RL2geRZW1pbP7GywRMbabudOQ+U=;
        b=TyUpRJ0fkdV7w7jhnkamoD2M5Np6Sj0eylTDuC8ZZ5I1yuide3B2q69m7EKm9IGsB+
         W5TgQSdzZxFsNTm/vURpVBsRwlNSc4qpNvJvTduUdNaXLrtbLO7DnqERnfoHqtwI/+4m
         KgmDEIhD1yZyk7SrGEz/DWqbpAWgV12+c2zTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791346236; x=1791951036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MBRXZKUt5w8de+h8RL2geRZW1pbP7GywRMbabudOQ+U=;
        b=aRd9lnY76WvpqZM55V27NPGj0es8Ep7qRcUvirureVYj+Hm8zjEHaht5xoVsY6Sn2X
         HZgFU0qHEntBU0U6eR1AlH3l+seuBaExQ7d+ndhivDZOoNqH+oMTWT56aqyaO8y27Ayw
         wwgOpVOLVNbWv5LshN2uFJt9Gj/bbKnSsBcwN0eoS1DNTw9tkPcCzmK0adY3uRUXeO3N
         oX98HLi9P9sy7a5fWyuj+ebn5Y4/+SH0unPWguCgL97BsEuzs2MkH1l/+bv+DyHbkwPo
         7lSTMwxPTdt1KVsve0HvndZjRjblImlOJ+ti3r/OKBZqOhn+5F1V+X7EZqDcniyiWQy8
         ll5A==
X-Forwarded-Encrypted: i=1; AKwUvBypW3wZeYSKi+hcLjSGxLhwlfk7kFSLAvtS2qGRJvHOAmzl6ISQHdxgzI1isdNR4sOQwgFu7To=@vger.kernel.org
X-Gm-Message-State: AFuF++n++Qqxb9vdYon1o8359Uu4zagyzDAYMumSzYuQPD2sVLL8e3+6
	mTjy/iYNPd0xwJmN9ZpAsp25QIRXQYM/3di+Ic8vtcKEwL9rjcszoOrb3T+++b1gPR8=
X-Gm-Gg: AYBFou0Da3btZwgH3PlnEewtncTsbwZ5K57Aid+pRe1/Gs7W5amWjvfi/gE9Utw/dYk
	XU1zFGLLEoyvaurgDTONsbFPV2wsr8THffOPIjUo5pX16/ub8ybZJAjPxZxlx+DXWTFDLT4K6h1
	ux592YeSvpgWOVZwwVJF4XBz6w5cMBz/9T8lpN3oD6/NCpO25f3AXm1grWNipMt/YBqiGP4ASlN
	23LWHdx+/BggckFL44kUX/XBqXazLZn8crVaC0ira24i3vZL9Y2+JpNcCuKEzO7o12jz2mxpA1f
	nJiglcU1IShKrag1n44yOLsSpnuEI3z393mcR13fKDim5yPBzMQm8BgoimXYd1ZtPiV3RwDWmMx
	g5lmwZjD85fyWaRWIhGChMzLO+WgMhmjDY1ouw4ddHofDu+N0u/d5pxwWoAn59fb5tiEckkPYr6
	B2CY9U7M2KdxxoNlZqgXwxVKIKDl6EU9T1Znc4BuziBWQCk9kXnbeFDTwOG4ICzKAZZ3yU+8WCU
	y8YMj5qzSxQcleWI4lc8ionz7EjIZduUd2CAjB5mwaBIcRUrHsRuIPM2ozNVDfoBG5Yy94LAkM=
X-Received: by 2002:a05:6830:6485:b0:81c:e3de:d194 with SMTP id 46e09a7af769-82acefa6e00mr2083117a34.10.1791346236482;
        Tue, 06 Oct 2026 21:10:36 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82adcb187c8sm1864670a34.22.2026.10.06.21.10.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 21:10:36 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/khugepaged: flush deferred unmaps before dropping a failed folio
Date: Tue,  6 Oct 2026 21:10:01 -0700
Message-ID: <20261007041001.43181-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

collapse_file() can fail its reference-count or dirty-folio check after
unmapping with TTU_BATCH_FLUSH.  Both paths put back the isolated folio,
then unlock it and drop the lookup reference before reaching the common
try_to_unmap_flush().

The page-cache reference does not keep the folio stable once the lock is
released.  Another collapse can replace and free it.  With its PTEs
already gone, that collapse cannot flush the first task's per-task TLB
batch, and retract_page_tables() skips short or unaligned VMAs.  A CPU
can therefore retain a user translation to the freed folio.  This has
been reproduced with unprivileged MADV_COLLAPSE on a memfd.

Flush at out_unlock while the lookup reference and folio lock are still
held.  The common flush continues to cover the accumulated pagelist on
both success and rollback, preserving batching on successful collapses.

Fixes: 6d9df8a5889c ("mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Changes in v2:
- Use Assisted-by: LLM.
- Explain that the common flush is a no-op after out_unlock flushes.

 mm/khugepaged.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 75639298efc2..e1a5890818ad 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2478,6 +2478,11 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 		index += folio_nr_pages(folio);
 		continue;
 out_unlock:
+		/*
+		 * The folio may have been unmapped with TTU_BATCH_FLUSH.
+		 * Flush before releasing the lock and our last reference.
+		 */
+		try_to_unmap_flush();
 		folio_unlock(folio);
 		folio_put(folio);
 		goto xa_unlocked;
@@ -2488,9 +2493,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 xa_unlocked:
 
 	/*
-	 * If collapse is successful, flush must be done now before copying.
-	 * If collapse is unsuccessful, does flush actually need to be done?
-	 * Do it anyway, to clear the state.
+	 * Flush before copying the folios, or releasing them in rollback.
+	 * This is a no-op if out_unlock already flushed the batch.
 	 */
 	try_to_unmap_flush();
 
