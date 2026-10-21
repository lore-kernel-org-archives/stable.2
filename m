Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595544;
	b=sGPC5C0wnLFJ49ZN+LZkc8c3eXn+N8+2SU2GqUAAdpH4DsW9HqKPoREa6r87LAQB2CAB
	 3kftXQE6b/d758y4MwH+GQzkXcZLFbYOEJtapOBp+d/p54PFbFSnSDgQQI9KSSKfMN/9R
	 kj/IW98+W8tBMdBhtm2FvyGLs4YC5aa8w82e7n7T+sborCcCwPvf9dwzgZU5AKOHu42JW
	 nJuYE3IXpGyx0p9X/LkQASg+bh2Nw49UwYruKQR1vyexB3EtkwDQXXB9z61t5VtncZT/R
	 YUuR+INR+FiqmWKFq5RiWagOfY//pqDaph20j5+9+yDQkz0GYXP5wYM7Q1f+tmgbHZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595544;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o4XR9xROqukzXraLnUCfzdfJeLe//TtTcJ3PO+9sHvo=;
	b=ki09eQ45yGomM4xv+hgGDM0pooz1qqTrPbpOosA07Xlw5H4s2Ie7AUNdIwcsRO41g3Td
	 nrBp1oA0R4pPNio9qqkJ3eTtsfeYffLCrHBez05lKNDPjEXlZEInQ1S2NqqvUI946kbop
	 +RQyByUiFMpyrIaVSMJnyM7eB5yDk2SwX2Cvcagxqf/P1lpX2y4XY7as2czdtGvdzap/c
	 LtYeGBKU4nzmjPRS+zlv8MZ8j+wxCbwDypooAU8DJtnTdRuEA2WTulrQto8FUo2oGjSyZ
	 KGZbFpkYtGgQcc8Uc2jm7SgHHFyS+NThJRSg6zLWQWsLoeMxhU8kohrzXbQlvuICBpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="IHk4/yPt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8130606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IHk4/yPt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490201F000C1;
	Wed, 21 Oct 2026 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792595543;
	bh=o4XR9xROqukzXraLnUCfzdfJeLe//TtTcJ3PO+9sHvo=;
	h=Subject:To:Cc:From:Date;
	b=IHk4/yPtfO8s4hGUijdxLuZFCbyVWyGfIIhSuErOj3xfuAAhhnnsrlsTJ7W6J+qCB
	 KISwI5hzw4dHZYpIFjGv9zeIIOwvc6VnVnpj8JRSAQoYFTUFRrUop9iX+LZeGZDOiv
	 sbANIdcb87efdjzsN5A0W2H5d+FRsAw2xGOQIpCU=
Subject: FAILED: patch "[PATCH] dm-integrity: fix infinite loop on discard with large tag" failed to apply to 5.10-stable tree
To: ben@cressey.dev,jose.fernandez@linux.dev,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:07:08 +0200
Message-ID: <2026102108-cahoots-counting-9b8e@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 18d80c77b4c7dd20699e81cedfbbff4e9d198f28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102108-cahoots-counting-9b8e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

