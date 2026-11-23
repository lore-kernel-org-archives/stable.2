Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795454501;
	b=WFJ7JD6wI6/JkGUrmji5kOovew4Bfxcf9khEDql0UmqT1a4+Q6KNN3YAYOZoC/SoeyXA
	 l5S3ofa5h0VnY6ikUMgKCwbeJrWQxz8GPB2DQuGQQvt8pG11oVhIngIRjqVbplZ97V9k2
	 MpsLWJdFZgwSLxARM32AtZJzz9U70JP8vpRV3c5reJmxiThNDj+aCCJneGnjId3EK8Wr3
	 KCYWghx69tv5MDk6QohbIESqYx7c+B2fMru/oWaOtQRKl8n+ixZsDCsMHBbZfWISdNJnt
	 JiQNpSvh192Vsw+7Kv/msLPEGpr0dY8GCFbdCNu/O6HG9cutbUmbCJ+5anU0wlgmm4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454501;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yJ5tdaDKAQFPPpobEHTb3m5msSlT/95ZPGIa7uQNwzU=;
	b=0wzOObptdS3boa5kqg+Rf52s72K8H/FE5Wzp+o7ni5ukQfY2L0jAEuuW97sVcgigif+F
	 zf7HhHzWCGgmPS7IhIvocQYjS/EGrNAgJCXc/EnhMt5rjtsb7LgcFEkC4IZh/CoDjiXJF
	 jsXBH5G0X38Rlf/D1DkmiTdIya9j12+7wpPUnnpFGx+lzgOVDuvA7w3K41/zZUzj7Rc8Y
	 WNTcz4kyRhE2MgtUICYDtQm8M1it8ip2qio1P+w+rDzPkSYDqDS7mxfmTwowZlp07SWTO
	 VGoxjqMhWZ141wqtvmeAM2IiMijZLN//8eVMt5OTjilQFjNJKliYcSCH9m/DbtiNnkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYPiHZXO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF899606A31A;
	Mon, 23 Nov 2026 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYPiHZXO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795454501;
	b=uFzMR40oaq2oPYXahHxw7cLxEzwdbkUNVaNoS5fhK3kHFG0FP6GeYU1E7G8mBkaa05+Q
	 3TAcfLfQ3PnRJ2ajFCh+0jCSR/EyCmG4xYhvMnrvf89HlTuCpJ5yCRcYaGRL2Z7aaF5hv
	 ptMvohuIpT7q3sYxR31evs6U2jeN1ub7aqRQiVeIPXWXsR+7QXJJ4qGdlfPfbete91I8A
	 RGOGRGZ+IoGT0hCKK6L0Zi/WMKv/STZOC3zWPemOgrwaVVMmX3IElkONr8200E5dAGFeL
	 cJCfket4SI7LG0RI3WNwAZfAdnx+SxUiORJIdz26jaFQ/RYu3PUS+7NEHf4f7joXH0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795454501;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yJ5tdaDKAQFPPpobEHTb3m5msSlT/95ZPGIa7uQNwzU=;
	b=gGXYN7xCKNyQ689zozuAbrbbtZ8gcze98fYvrQzrDRmcxvYJXYnvxZjnqypm/SBrfDD8
	 27bXvzT/25cVxBl09GTeDxkcXURqMzQ7Xy15Cy7oIknIYia6mLoppe/++wk0PbuWyHrPg
	 LhM2HokH0NjhhY+FxX92jGBUvjKIU6jnAUr9lCSQqT6hXrmirOacI74IHzS6KftrdYyPD
	 fuumfa7xDhIK4VoyNq39/Br4/cFWMS3W5m63tDkNKWtIfLBpdfpsffG922lIP31bwbKOv
	 fVFte+wv+JU/jGOujD0DpbH1g+Bx9U8QwTMCpikBGqYpPIcy8/nFYbRcOD8iceIsw4Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BAED91F000D3;
	Mon, 23 Nov 2026 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454501;
	bh=yJ5tdaDKAQFPPpobEHTb3m5msSlT/95ZPGIa7uQNwzU=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=gYPiHZXOsBYul424C2tHonPOl2PUFVErl5MJKKs5meCWR3SCWIVrVW7TwUN7+k788
	 htE/P1KKvAIxp5SbhTkHTW7stPvzlysM+qJjGsspq54+LItHqU+J1jtnrtupC6P6bw
	 2KBbYGPeL7dZZ8Iaj5QlT2g/pfdRRBOmgTCR13NWhhZh6KI/KT6hXtR7HLG6njDZ9R
	 /cBmgdtAMa2xFBtIRqqvHVxANgxoDUE+zMSX5x24zDvHbkfDAZ24njq/WSH1Sw/UOo
	 bBsYe5S+PS92YE+trbrCK0DiEuzGkFqNMFDHd7rkd4kIrGGGvah/gjftW64QohI6P5
	 NmljdJyJ4CfqA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4262B4C581;
	Mon, 23 Nov 2026 17:21:34 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Mon, 23 Nov 2026 12:21:34 -0500
Subject: [PATCH] mm/shmem: don't drop a folio whose swap write failed
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-shmem-swap-write-failed-v1-1-41a0115dfbf1@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTuJHQMhXsW4KO2PjBEkHRASw
 t2puvwW721kSAqja7FRwkdN30OGOxUUOj88wBqzSc5SOScXtq5Hz7b4kZekE7j1+kLkJiBKXaI
 upaJcjwmtrr/z7f63zc0TYfruaN8PouPc8XsAAAA=
X-Change-ID: 20261123-shmem-swap-write-failed-bced285e8526
To: Andrew Morton <akpm@linux-foundation.org>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@kernel.org>, Kairui Song <kasong@tencent.com>
Cc: Chris Mason <mason@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, Tal Zussman <tz2294@columbia.edu>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795454494; l=2695;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=YZkS8z4nKi2wuUKuI1w38QEIWGBn1hka4U2KKfBBdd8=;
 b=d1A2Jbz2YdcvzAkeX34oY+L/eDQiZJwjs+Ba8yDMxbqQPOWBbjimDgjlrMGcsx8rIoPhofk6v
 r+eHSy/2jevAy45EgB0WGi0sTG14AtoEENRVU7lykD94wVL2tH1oNET
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

shmem_swapin_folio() drops a large folio that does not fit the mapping
from the swap cache if the folio is neither dirty nor under writeback.
The folio can belong to another file and be under swap writeback, when
the swap entry was freed and reused before the swap cache lookup.

Swap write completion does not take the folio lock.  On a failed write,
swap_write_end() marks the folio dirty and then ends writeback.  Since
dirty is tested first, the folio can look clean and written:

  CPU0 (swapin of file Y)             CPU1 (swapout of file X)
  -----------------------             ------------------------
  shmem_swapin_folio()
    folio_test_dirty() == false
                                      swap_write_end(), failed write
                                        folio_mark_dirty()
                                        folio_end_writeback()
    folio_test_writeback() == false
    swap_cache_del_folio()
    /* X's data is lost */

The next swapin of X reads the slot whose write failed.

Test writeback first.  Both flags are in folio->flags.  If the
writeback test sees the write ended, the dirty test then sees the dirty
bit set before it.

With the fix, a folio whose swap write failed stays in the swap cache.

Fixes: fc2c19648d68 ("mm/shmem: fix swapin livelock on a mismatched large swap cache folio")
Suggested-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Managed to hit this by forcing the order in a VM, and it's gone with the fix.
---
 mm/shmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e351cd425d69..867f43315af1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2664,10 +2664,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	 * A large folio that does not fit the mapping, e.g. because its swap
 	 * entries were freed and reused, would be found again on every retry.
 	 * Drop it from the swap cache so the retry can swap in a fitting one.
+	 * A failed swap write sets dirty and then ends writeback without the
+	 * folio lock, so test writeback before dirty.
 	 */
 	if (error == -EEXIST && folio && folio_test_large(folio) &&
-	    !folio_test_anon(folio) && !folio_test_dirty(folio) &&
-	    !folio_test_writeback(folio))
+	    !folio_test_anon(folio) && !folio_test_writeback(folio) &&
+	    !folio_test_dirty(folio))
 		swap_cache_del_folio(folio);
 unlock:
 	if (folio)

---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261123-shmem-swap-write-failed-bced285e8526

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


