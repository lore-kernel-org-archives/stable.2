Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D238B146
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490289; cv=none; b=uw2NiXeOrra5txtRb17tsexZbjZZVFRB+asNLSw0XOCEQVIPcE5exrsj3sTL0pzPYU5XcXGnkrr0teOc2aUgW3dufqeed3IPAFp6n1ujU1nQ3X7lR85910xP9uHI8YZT02YpfMbyonkTJrtparxBBkgK0geqcvfjT32URavTWLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490289; c=relaxed/simple;
	bh=44zC080o2feE4lXK5+Ws4oC9VoaMk5L5HGfIv6FZxeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mpds+adk+QiRHi+y2Ny02oVqZhEvzpd9Y5zHDXDa33Ne5/kVxEn64nkVaUyutrEiK2Zgeg9X1frqKlLEgcI/lWXhF2EHqgQKyn//2LLE+FoJ7sVYUD3DLg6mvl+1vsD4TLqRMCFqn0P8c+zjyvwXIwUF+owOOJZa6VuTPxplA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=XB7Jp+sE; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="XB7Jp+sE"
Received: by dvalin.narfation.org (Postfix) id 8D31C203FC;
	Fri, 26 Jun 2026 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xSdkX64CvI5SFX38RxDskz1mseUxr/uCS8oHCOhrp8=;
	b=XB7Jp+sE5yAYZZtQ63xWfeARSiGjdDO9wa6PmUuNyBPgc6HsSjdgdIrIswyvvywzRispVA
	7lEC8Z4CqpecN7AlaJOEYJ+6h7gSLjuEZS47hJpueALazBZfOOHDjoNiXlfnSpyWyvmeGI
	wlVXEFL1qUQfMbdVrXpwpkSaa6EHG3Y=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 05/25] batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
Date: Fri, 26 Jun 2026 18:11:03 +0200
Message-ID: <20260626161123.124273-6-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161123.124273-1-sven@narfation.org>
References: <20260626161123.124273-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 33ccd52f3cc9ed46ce395199f89aa3234dc83314 upstream.

The cwnd is always MSS <= cwnd <= 0x20000000. But the calculation in
batadv_tp_update_cwnd() assumes unsigned 32 bit arithmetics.

    ((mss * 8) ** 2) / (cwnd * 8)

In case cwnd is actually 0x20000000, it will be shifted by 3 bit to the
left end up at 0x100000000 or U32_MAX + 1. It will therefore wrap around
and be 0 - resulting in:

    ((mss * 8) ** 2) / 0

This is of course invalid and cannot be calculated. The calculation should
must be simplified to avoid this overflow:

   (mss ** 2) * 8 / cwnd

It will keep the precision enhancement from the scaling (by 8) but avoid
the overflow in the divisor.

In theory, there could still be an overflow in the dividend. It is at the
moment fixed to BATADV_TP_PLEN in batadv_tp_recv_ack() - so it is not an
imminent problem. But allowing it to use the whole u32 bit range, would
mean that it can still use up to 67 bits. To keep this calculation safe for
32 bit arithmetic, mss must never use more than floor((32 - 3) / 2) bits -
or in other words: must never be larger than 16383.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 0fdcafca3aa02..4ff80e4214ff0 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -154,9 +154,12 @@ static void batadv_tp_update_cwnd(struct batadv_tp_vars *tp_vars, u32 mss)
 		return;
 	}
 
+	/* prevent overflow in (mss * mss) << 3 */
+	mss = min_t(u32, mss, (1U << 14) - 1);
+
 	/* increment CWND at least of 1 (section 3.1 of RFC5681) */
 	tp_vars->dec_cwnd += max_t(u32, 1U << 3,
-				   ((mss * mss) << 6) / (tp_vars->cwnd << 3));
+				   ((mss * mss) << 3) / tp_vars->cwnd);
 	if (tp_vars->dec_cwnd < (mss << 3)) {
 		spin_unlock_bh(&tp_vars->cwnd_lock);
 		return;
-- 
2.47.3

