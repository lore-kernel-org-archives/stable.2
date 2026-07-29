Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C648AE0F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332749; cv=none; b=rqSdtvl4utcZhO+WOCtkUCWKqHOb0OW7CEITd4ZyAe2vW+Cy5VNx8ntYngPVgmZH8oBVWWh0sWWhF6LWC1jU96874h34h64AbiOq+Ey/pZROR6fU7PcDPrsg22/CS2UkW/Rn8zBHOVk/jSG+Lflwpc2x9RUsjXRBR0+QLq2PwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332749; c=relaxed/simple;
	bh=AUWgdjRXf2zQL2JZ63jXhk+csjkW+dHVT3bx2o0koIw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L3E0LmT0gcD0tLkhu0TllO1XRea0MG76A1uhElPHZcHMjqyVfyJRYD8iGnJ3j15npbJwEpCshpg8q5GitQH1ahaVNx6qDw+q7+Ish5hKwfct2KY4nFaFkkqbpZBIkFHO553NgrcOKs/JMLkRy2NSeyKAqVyQd3r5HabdUaz43Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=huCuYwEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="huCuYwEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E8E1F00A3A;
	Wed, 29 Jul 2026 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332748;
	bh=xmjd8qMq4XdgY04ZjwoIxGRqiAAJnZHD2iz+oF5w+8I=;
	h=Subject:To:Cc:From:Date;
	b=huCuYwEJtIaW29kVOKNbyoVVkq+EWVn1wEK/3JlgQAyAtdxmN5fQpXxC0hxtV3XAb
	 noQQkgI5kM5MEZfjCNW/hYwgnFAVt+qH0z6PrxcQx+p2G6NDROzkCAJrwN6SEdFnPu
	 eUSuwHF5uTyUtNkcyayj4eFztmd1tGDjGDy5CUQI=
Subject: FAILED: patch "[PATCH] mm/kmemleak: fix checksum computation for per-cpu objects" failed to apply to 6.12-stable tree
To: leitao@debian.org,akpm@linux-foundation.org,catalin.marinas@arm.com,ptikhomirov@virtuozzo.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:44:49 +0200
Message-ID: <2026072949-quarry-sleet-f3e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 79c37ae3733e93d9d8ea12ecb44f717e61439024
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072949-quarry-sleet-f3e6@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79c37ae3733e93d9d8ea12ecb44f717e61439024 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Fri, 3 Jul 2026 09:17:24 -0700
Subject: [PATCH] mm/kmemleak: fix checksum computation for per-cpu objects

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

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 7c7ba17ce7af..e196f53f9b46 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -687,7 +687,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 	atomic_set(&object->use_count, 1);
 	object->excess_ref = 0;
 	object->count = 0;			/* white color initially */
-	object->checksum = 0;
+	object->checksum = ~0;
 	object->del_state = 0;
 
 	/* task information */
@@ -981,7 +981,7 @@ static void reset_checksum(unsigned long ptr)
 	}
 
 	raw_spin_lock_irqsave(&object->lock, flags);
-	object->checksum = 0;
+	object->checksum = ~0;
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
@@ -1410,7 +1410,8 @@ static bool update_checksum(struct kmemleak_object *object)
 		for_each_possible_cpu(cpu) {
 			void *ptr = per_cpu_ptr((void __percpu *)object->pointer, cpu);
 
-			object->checksum ^= crc32(0, kasan_reset_tag((void *)ptr), object->size);
+			object->checksum = crc32(object->checksum,
+						 kasan_reset_tag((void *)ptr), object->size);
 		}
 	} else {
 		object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);

