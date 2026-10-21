Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595534;
	b=qcQwhMNhUMvoK934l0M0Mr9UkbkakWmrOdeKqhu6OQ785T7V4zRtJG8pXoQntbBwhmGt
	 MjK48WtqlZygK94629t9oHghbD1MIBR+fbKy1HHGVAPli13MGgQHjEHJb+U3qF/pPkC5k
	 DAGtCOxRADKP0LEx5uK2sg5h43AoXSJxwDOSwnG9bAIFOaaHgpIhREyOuP5jiP6a6smjS
	 l5iwf1ZOIxn8RaEA4RSrA7dQZhmXU+HDFHZcYntVAePpC5lyolBA9NodbXJW6Wa1Q87/u
	 VmrVRjJI8IG6IP7Zo3sTWO+D1Nbr8BZ4+9lsOayWAd8aGOV9FJJDk3UyjSYtBHBq6gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595534;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qG6nEGhN3w8NU9rN5osxvEVOTKNfdNebfFi5wnUSc9s=;
	b=oO9GhYwxNeU4LERPoSBWZXyJkRLVVqffa6tHSSdSsDuar2MB1R5I/wrbtEWf9cIgAzGV
	 hbumBeiXfhHr26cWP1fLVjHRhVLelZS/N0COZO4TdTQ3aJ5zUy2bKeQmuZLyKWCrvluKo
	 TdG17skB+jwNYpxDcNgoEd5cRl8XyU8lv1odO45Q70+oWXOm+yYPUNHbSwUVee9ap2v64
	 s6oBWU8MJK56+9IW7oWcbu5WDKmtRsl9/DgM2PnGqbrul8M9fXY5CKkXbbyZnMWqHeEbz
	 DN8LgDc3h264kO8xvk1IXew94+3bVt8upw7GtuCc9vI2mH7UPEk8D6fSaZtHh732cig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FokXyIOq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A99606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FokXyIOq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2D51F000C1;
	Wed, 21 Oct 2026 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792595534;
	bh=qG6nEGhN3w8NU9rN5osxvEVOTKNfdNebfFi5wnUSc9s=;
	h=Subject:To:Cc:From:Date;
	b=FokXyIOqlWaavCrx9PjC8rhEAADFoCfvAs3GBAq7HlqyfpMlMk/03JurncLF8MNkU
	 zFdWBXcApeIHf/9ZunMQAHfrhathPhpM2hbIUE/0nuoKWlbcaHQL4BgQXALPYAQa5m
	 0TC2oQsXuA8H65RcUipl+K9s4vHoI8VvHQiLT4iM=
Subject: FAILED: patch "[PATCH] dm-integrity: fix infinite loop on discard with large tag" failed to apply to 6.1-stable tree
To: ben@cressey.dev,jose.fernandez@linux.dev,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:07:06 +0200
Message-ID: <2026102106-constable-postage-e400@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 18d80c77b4c7dd20699e81cedfbbff4e9d198f28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102106-constable-postage-e400@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18d80c77b4c7dd20699e81cedfbbff4e9d198f28 Mon Sep 17 00:00:00 2001
From: Ben Cressey <ben@cressey.dev>
Date: Thu, 20 Aug 2026 21:44:58 +0000
Subject: [PATCH] dm-integrity: fix infinite loop on discard with large tag
 size

When integrity_metadata handles a discard, it fills a buffer with
DISCARD_FILLER and writes it over the tags, max_blocks blocks at a
time. If the kmalloc fails, the buffer is the on-stack array
checksums_onstack and max_size is set to HASH_MAX_DIGESTSIZE. So if the
tag size is larger than HASH_MAX_DIGESTSIZE, max_blocks is zero, bi_size
is never decremented and the loop never terminates.

Fix this by using sizeof(checksums_onstack) as max_size. The array has
MAX_TAG_SIZE bytes since commit b93b6643e9b5 ("dm integrity: fix a
crash with unusually large tag size"), so max_blocks is at least 1.

Fixes: 84597a44a9d8 ("dm integrity: add optional discard support")
Cc: stable@vger.kernel.org
Reviewed-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Signed-off-by: Ben Cressey <ben@cressey.dev>
Assisted-by: Claude:unspecified
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index d4fe85d61d33..5327d7c6a71c 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1979,7 +1979,7 @@ static void integrity_metadata(struct work_struct *w)
 
 		if (unlikely(dio->op == REQ_OP_DISCARD)) {
 			unsigned int bi_size = dio->bio_details.bi_iter.bi_size;
-			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : HASH_MAX_DIGESTSIZE;
+			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : sizeof(checksums_onstack);
 			unsigned int max_blocks = (max_size - extra_space) / ic->tag_size;
 			sector_t sector = dio->range.logical_sector;
 

