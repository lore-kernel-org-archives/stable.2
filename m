Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793027964;
	b=p1uGyEJyPgfpkHc2LXHe78lYnQPQ+pUzVpNKQXJRxQ5s5HHVHUwLvZYBxu4mxZH7wJcR
	 IXscHl/UTOwkokSAwYTs6L6zneZAzs0Dn0EBInYKswDccNsOeCrTYlCnheXCFmuWK/RB5
	 YVHJ5hvUsLTTFLtWPJBrA6Tv2id+rEgMoGQFB/6mpDeKccADWKuo5PZ5AViq3KTwqb5th
	 kVx9IInMcGvbJhendZwquGfUEZsEQN2NZfWQJtnf885eRpLQljwiEn5N0GAt2gttG1bCk
	 Elr9h/3ro+XS8stW1b/cwt2cQZ4VN6yOVSY4TmZlfe5gT2o6d8jNJdmQhF+ypd7pitw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027964;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oec+Wt3gHa1boqU1HQuJjZMLSuduFm7h1veFSZGd5Z8=;
	b=4CKOE7M4+p0T6mundsuSMD9TvYHCdO/xOx+2uctJu+93AtkzcvHgdkvlPnOaT2lSz7MX
	 EuTT4Y/ipaLuLrsAY/GFhnwDoKXHzeqkkP7rgRMTa8Ac/FLtJjm6jTaPDu3mDDfw9DC/u
	 6QuoHtvtKL8jgYGDRUv6ilfXS9N3JlGunbN7vz5SDN+dckwjsVdYuL1N2SBzMOZGPifSu
	 oDjEsgLJIdAW/A7VdcHVGksSB/EImcVLLAAh0AZKLyQ1WDzwupExgoIeN5FF9LPq8fjbh
	 A8WcOjSRZRUbD+UF6/RjMtok8Tu5klJ1CluncZCOC4obVVNNF7NNDm/r0UszOOUe0QA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0t5NWQd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C16606A320;
	Mon, 26 Oct 2026 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0t5NWQd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793027963;
	b=yZlmAG/6kDJ1pVk1famdY35V8HRCuDqcAYtQNBzITYb4rx8W/s1o7kYsDx2spE93EJmZ
	 cz+Z7akQRVle4EjXOafUdwndYsfaCPM2yCCjE3VItEB2bEiVmukwmZN2NcaV9BwgJjEHb
	 /ElSmt4rr0LE59If3wc/sr4MCfDQR3NTmFaqNJ6PObZC+O9UWksrutrFS01L4PmsbZxc2
	 TAFpuiBh0iKEOLHS2p7iBJ28OSAzieO5lqoADS5zIamVoYqZC1kTEouFAba4blm4OJ80r
	 DqfSkuFSeCKljavk/XggL4ywytHEo47xRTcP8XgTfFMSfqMnDwTtrbvchjYr/YBoSdw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793027963;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oec+Wt3gHa1boqU1HQuJjZMLSuduFm7h1veFSZGd5Z8=;
	b=TO952MsxUNPxN7ZlFOy4K/t9wqLWIqnplApmrjmXkCRsNKKgpMUTadkG8gpOFTorEI/I
	 +fQM16CRBd8ZTBusOEt1HYW62V/XwK8YWUtSm8b74uC4qUr4GllALfP2EHZBiBIDUm1pX
	 bDCqeVJHM+W+A2d0jaghWPsLAFDXLOxt0GQFkthsVVcZ2j7KnMWMJgKoAXpJ/EVwBntSY
	 CSw5DSstXpxO5vLYeXL/qwnADPlgjaiHy95p4BuT4oZGCfARQYpIOQphUzo1qDQEW1WSO
	 nE/tL4EKx0DRCc1UZ11Bo9NpaEztq+UCkh34PjLzs38L6uPvdNTGdJP8sgwB/miJ88Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E5D5A1F01828;
	Mon, 26 Oct 2026 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793027963;
	bh=oec+Wt3gHa1boqU1HQuJjZMLSuduFm7h1veFSZGd5Z8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=B0t5NWQd1nYWesXGLcbrS5kIqaa+VvY0/tbodjEnwvJ5wo1tIqTUI06PKj6l/bMKT
	 xBd/oyTG7CIhOUfZ0ieIllPHBiBLyaNT47UGekYDpLrda5OoUEpOz/jahJzFjwAjM9
	 idmReAf/WQBEc+OhKhSP34qzldEOlBeFiiRp8Lxfi9TfUuyVLyzAY/BLv8n2Ps+5XL
	 VIu5H7skGiDMOUWglf42kNzmVflS2YiiqWw+UJXAmkxzEQrrICeEhpSpRiXFREUz/3
	 nswRpm4gku5MjlqbJUe0s6QT9ZsnFtaJaY7MJPz411f64fmJlRzAlWYs/W6lZSjDwZ
	 NdqNPFzFfPn4Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4C90044D49;
	Mon, 26 Oct 2026 15:19:22 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Mon, 26 Oct 2026 11:19:22 -0400
Subject: [PATCH] mm, swap: stop cluster list scans once swapoff clears
 SWP_WRITEOK
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
Message-Id: <20261026-swapoff-writeok-v1-1-4f4cd420aa33@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINYtLk8syE9L0y0vyixJzc/WTbEwSjNKTEk2SjQ1VgLqKihKTcusAJs
 YHQvhF5cmZaUml4CMUaqtBQDWLk8TcwAAAA==
X-Change-ID: 20261026-swapoff-writeok-d82f2adc2a53
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 stable@vger.kernel.org, Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793027962; l=4058;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=13fz6rqNh91gTcPzM8hXNMOTAxUdtQgWk+c7vws4zJ8=;
 b=vg9IYQzJgsesZ3/7DOx8iiu+UpwzJK/cT7keQ9ZTtaH4xqfxdkhcRRPeZI97Poq9QOz1X1L6b
 rOOceG7nTAZB9hJbL18eVW0RArdVG4aOyGUa783AMsl5Gc87b5so/gq
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

SWP_WRITEOK is cleared under si->lock when swapoff starts so that no
new swap entries are allocated from the device, and try_to_unuse()
then waits for writeback of the folios that still use the device.

However, an order-0 allocation that chose the device can race with
swapoff clearing the flag and then loop forever.  It takes a cluster
from the fragment cluster list of a higher order with
isolate_lock_cluster(), the allocation from that cluster fails because
SWP_WRITEOK is clear, and relocate_cluster() puts the cluster back on
the same list, so the loop keeps finding clusters on it.

The looping task is in reclaim, and it may have set writeback on a
folio whose write has been queued but not yet submitted.  swapoff then
waits for that folio, while the reclaiming task, stuck in the loop,
never reaches the point where it submits the write:

  CPU0 (reclaim)                          CPU1 (swapoff)
  --------------                          --------------
  shrink_folio_list()
    pageout(F)
      /* F under writeback,
         write not submitted */
    folio_alloc_swap(G)  /* order 0 */
      swap_alloc_slow()
                                          del_from_avail_list(si, true)
                                            si->flags &= ~SWP_WRITEOK
                                          try_to_unuse()
                                            folio_wait_writeback(F)
        cluster_alloc_swap_entry()
          isolate_lock_cluster()
          /* allocation fails:
             !SWP_WRITEOK */
          relocate_cluster()
          /* repeats forever */
    swap_write_submit()
    /* never reached */

This results in a soft lockup on CPU0 and a swapoff that never returns.

isolate_lock_cluster() used to check SWP_WRITEOK under si->lock until
commit 07adc4cf1ecd ("mm, swap: implement dynamic allocation of swap
table") removed that check.  Restore the check.  Since swapoff clears
the flag under the same lock, isolate_lock_cluster() then returns NULL,
which ends the scan; the swap slot allocation for G fails, and reclaim
goes on to submit the write of F.

Given that this is a race, its reproducibility is non-deterministic.
We reproduce it by using a non-rotational swap device that is not
synchronous, with 64K mTHP enabled, where one CPU repeatedly pages out
two 64K folios and a 4K page with madvise(MADV_PAGEOUT), while other
CPUs run swapoff and swapon on the same device.  In my tests it
triggers within 20s in each run, and with the fix applied, it runs for
300s without any hang/kernel report.  This bug was found and
reproduced deterministically using a deterministic hypervisor that is
currently under development.

Fixes: 07adc4cf1ecd ("mm, swap: implement dynamic allocation of swap table")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Before commit dda8fb68b590 ("mm/swap: also use struct swap_iocb for
block I/O"), reclaim submitted the swap write right away, so on 6.18
to 7.2 the loop most likely ends once swapoff frees the slots instead
of hanging.

Reproducer: https://github.com/manitofigh/swapoff-repro/blob/main/swapoff.c
---
 mm/swapfile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 601979b97f95..2b03d14b5f52 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -627,6 +627,10 @@ static struct swap_cluster_info *isolate_lock_cluster(
 	u8 flags = CLUSTER_FLAG_NONE;
 
 	spin_lock(&si->lock);
+
+	if (unlikely(!(si->flags & SWP_WRITEOK)))
+		goto out;
+
 	list_for_each_entry(ci, list, list) {
 		if (!spin_trylock(&ci->lock))
 			continue;
@@ -642,6 +646,7 @@ static struct swap_cluster_info *isolate_lock_cluster(
 		found = ci;
 		break;
 	}
+out:
 	spin_unlock(&si->lock);
 
 	/* Cluster's table is freed when and only when it's on the free list. */

---
base-commit: e9011a65d78258901ba123c5f522bef26d29902f
change-id: 20261026-swapoff-writeok-d82f2adc2a53

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


