Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273130;
	b=H3fC3H97M9LRzJr2Q2+Gy+28Ypk6Tsz4zskmpfY6Z6RhWpRtJNCzHsJJJmQNbkOSD/ew
	 zu5Pqx50KHBf5Z0N5NLvprnLpk4CctITAe8sVDEN0K0o2xalNW+5h+8E3TZAL0WwC4ykY
	 s36oZBsK5fWmGb546bP+3PldYYOKHNoxMCGHMWlAK6CX8YmoAPIpXFbcLKxRJgxlebY4r
	 zz07qDmwB6DLzurz59aIJxP0iZZxOfJSTMIoxfmTDc3Ou5Mey6wSK+uUVNc34E0DER5/c
	 KmMjqSPvrIj+BPTIG/HSTDhF2V06D2+Llop1VIQemqWsKrkPWVikiUPS9BRz/KQD5iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273130;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eWCvhvB+sqO4Etwam/rA9+qcf0SC4IkANw+xU5j2+bc=;
	b=yLJSgmYe2M1szA7SZK45mf3PP9vweI9WVu/Cmv0jMxd97YnvRp94+8flDRCYgUoTBWlf
	 gyP+u4RYWLFm/zjBosCXkrYYyFV0om2mHAnZTURUxHZPHnpgIJFyQ4FyPsOCgaUj6Oehi
	 7YkXsxDMLGbf2AJ7D5kxxKHEwyjBArwi1C8Cm7cFopmuTnMmbNPkZbkxkDb1KvQCHRlmg
	 BhDF18dFicCZ7SupJcDlGDpTwfXEEeWJCQJISwqFqcwoZ3Ebu9CGv74wgcqbXidpmWFRo
	 H5jk04k0/IvRa4k4C0m2Yc2UOeeBNW4i86wwu045hrKFchqqevmjv6l9NgXvBDeLBhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAVVYCXt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAVVYCXt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F40A1F0089F;
	Tue, 10 Nov 2026 01:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273130;
	bh=eWCvhvB+sqO4Etwam/rA9+qcf0SC4IkANw+xU5j2+bc=;
	h=From:To:Cc:Subject:Date;
	b=gAVVYCXtkvPLGjVaiAB7BEjZI3kI91sTWReRRi8bKPm4zYSxVgWcwYxOl6LWZuM4W
	 mma/bwRPIRNYBMe8L6pTcyMMMvMMhJ9e+WVEV0O6L9+W1dzW5KgZc0eVwWBgZk9XFk
	 lC/k7bBO5zWbvNUVDaUFTzUplmoBlMpvXxHFggkhvkb+qXIapr8Wbem1yygExoX7tt
	 aUP/A25/Lp5DzTrJ2Kh/12pJPp57VTuK4RBPby2/lyyTzxMvg8SF+078cGaEHR7Ii1
	 yG+OVpWxy6KKvDaiyHenNg6HjaJaBXEHS7fv6UwVLpdHCIjGcAUPlu4FH51FIKqlr6
	 Vq9s6f/lWFzkQ==
From: Sasha Levin <sashal@kernel.org>
To: dennylin0707@gmail.com,
	akpm@linux-foundation.org,
	jack@suse.cz,
	gourry@gourry.net,
	willy@infradead.org,
	shr@devkernel.io
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/page-writeback: avoid 32-bit overflow in dirty threshold shares" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:12:07 -0500
Message-ID: <20261109201207-failed-6.6-9597c2056e05@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9597c2056e05bd79df9d343a9b42e84a54de1c52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201207-failed-6.6-9597c2056e05@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9597c2056e05bd79df9d343a9b42e84a54de1c52 Mon Sep 17 00:00:00 2001
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 21 Oct 2026 06:06:54 +0000
Subject: [PATCH] mm/page-writeback: avoid 32-bit overflow in dirty threshold
 shares

The ratios used by __wb_calc_thresh() are scaled to parts per million, but
the threshold and ratio operands are unsigned long.  On 32-bit kernels,
their multiplication can wrap before the result is assigned to u64.

For example, with a threshold of 25600 pages and the default maximum ratio
of 1000000, wb_max_thresh becomes 4125 pages instead of 25600.  The shared
threshold and minimum share calculations can overflow in the same way,
producing incorrect per-writeback dirty limits.

Use a u64 threshold for the three ratio multiplications and div_u64() to
retain the existing division order and rounding.

Link: https://lore.kernel.org/20261021060654.27855-1-dennylin0707@gmail.com
Fixes: ae82291e9ca4 ("mm: use part per 1000000 for bdi ratios")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: <stable@vger.kernel.org>
---
 mm/page-writeback.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 499a35473e4f3..0694ec4098f6d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -883,6 +883,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 {
 	struct wb_domain *dom = dtc_dom(dtc);
 	struct bdi_writeback *wb = dtc->wb;
+	u64 threshold = thresh;
 	u64 wb_thresh;
 	u64 wb_max_thresh;
 	unsigned long numerator, denominator;
@@ -894,13 +895,14 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
 			      &numerator, &denominator);
 
-	wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE);
+	wb_thresh = div_u64(threshold * (100 * BDI_RATIO_SCALE - bdi_min_ratio),
+			    100 * BDI_RATIO_SCALE);
 	wb_thresh *= numerator;
 	wb_thresh = div64_ul(wb_thresh, denominator);
 
 	wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
 
-	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
+	wb_thresh += div_u64(threshold * wb_min_ratio, 100 * BDI_RATIO_SCALE);
 
 	/*
 	 * It's very possible that wb_thresh is close to 0 not because the
@@ -916,7 +918,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
 	}
 
-	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	wb_max_thresh = div_u64(threshold * wb_max_ratio, 100 * BDI_RATIO_SCALE);
 	if (wb_thresh > wb_max_thresh)
 		wb_thresh = wb_max_thresh;
 
-- 
2.53.0




