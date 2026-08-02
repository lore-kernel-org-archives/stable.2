Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE893C5833;
	Sun,  2 Aug 2026 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688005; cv=none; b=mfT9n1bl3Em7zdbHTRLZwt8zaHZvkr3eQcaVHJZv8rfNtu8LZmj1hNUYigdumfoCuC4Gnx5SdYxbual17C6gHzIh+7R/YbhjIJGrmSm8t2YPj+tGynyN/J41X9htsgUseXbDFqN6DVCrEoQFMdlJxzBM8hurSdj+EffBdoBj7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688005; c=relaxed/simple;
	bh=yf/Wtcy4X8myT49I/nXHYz/zUI9Qgg5E+qxFaSvv6V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fG76GD0xAqUHUZQ9xBQhuAc05ru6kpukrPXWdLyVsOpa5vSUFCNQaK2WcxcRg27oeB20ssNjiH56bxdzLsD3pAZ8gT2Nefxu/AOYIRYLv+bgRnvfiIvvxnkVuUAgNv5X7x7SkZPHEO96HJpmuNccb2ER8UQfND7ePJ7HUTC/BME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofUbJFVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofUbJFVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2AB1F00AC4;
	Sun,  2 Aug 2026 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688003;
	bh=FjpIc++QZPjZOYYyTcv8UZquOm4P+vQqtVegyQJWS98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofUbJFVR7en0yO0u2gPuMSNQGF9LpRv6jXSWh8QWsDr0ac+40r0HMmVvt7WTuctK1
	 KQLtO97awGBVMnLh4R8Vqj+ZtTKLPAVpJXiGf5mLcmpdIqLCCAThLDY1lhwcaBm0cs
	 VW1NZJPqcEPC/AxOP1D/ukzLmOuZZQ6Ka0krAe4nah7mQm8hSpJtEmUMOyJnWHlyzW
	 5/sb1DYCZq8M60TAb7NKEFbgs1zJ30rqFC0apy1d3FYlAOr6nooymr0K0QaDyqGB+g
	 mx/1InCGj+lfKu+6C4CK9X2mqg3dDC3AR1olcCKFxgT+N8+TTvMDDxtLlzF30mykpc
	 WymgJ8KHGWQLQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 9/9] mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
Date: Sun,  2 Aug 2026 09:26:30 -0700
Message-ID: <20260802162631.90304-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802162631.90304-1-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_get_in_active_mem_bp() uses the sum of the active and inactive
memory amount as a denominator.  In an extreme and unlikely environment,
active and inactive memory might be zero.  In this case, hence, it
results in a divide by zero problem.  Avoid it by changing the
denominator to one if it is zero, before it is being used.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org

Fixes: 4835e2871321 ("mm/damon/core: introduce [in]active memory ratio damos quota goal metric")
Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 67ad1f07c29a4..c79b854e1a971 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3014,7 +3014,7 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
 	inactive = global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
 		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
-	total = active + inactive;
+	total = max(active + inactive, 1);
 	if (active_ratio)
 		return mult_frac(active, 10000, total);
 	return mult_frac(inactive, 10000, total);
-- 
2.47.3
