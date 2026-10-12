Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8957418373
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816827; cv=none; b=SxvRDJU5fzyye8re9psVz6H/TE2SAcKhjQ1wEH06a6XVefnWoeptEBJapv1Y1chkQZUMaLT2mmqPr4t060hj9uskqmHiJeECUpZW8v2e8fQ1tFfncrtYA/4+op0Nr07JRSHWs+mge0Ejd0WuDEgRs8cWyRZutWMXySeoS153534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816827; c=relaxed/simple;
	bh=pbvnFmtx+Jbmtn47kPBntTy22pDmg3WvDvOJt6l2ppc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nvv3rBiQ9rXL+jPU7q8wxUekjwjcn1qi6KOgaETm9/6Wn4ejpKbxVdOS/tDdtDB/562gJjqLGsYdOFIEJcJVJVZ9mezwb7mzGuu0n6o8cP0EwEJ7JOHDZFrhkfcYRmtmM5TdCKpwIgl9RqUw1pzTZqfZW/+6TcQGDcP0lJE2LaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b5ibrEib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b5ibrEib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05B11F0089B;
	Mon, 12 Oct 2026 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791816826;
	bh=dP3BCOuZrIqG/OoSa0G0Tsx2CV2DTM1wWBKIrVl2wAY=;
	h=Subject:To:Cc:From:Date;
	b=b5ibrEibhK7LxnJLT+iGUsRrMf8uOdX4eb8+SWxbU1ASpl6pNt0N4mrm/qLV7ntBm
	 SSUJlWex+6fl/vgLdnV//4a8KjmlQom2q2gh0msvguRwWkenc/2CYV+v9Z6aBYmClO
	 pAIhzdNG1Jm7bNXojNY8acnnayXoYI/OqOGo+ZuM=
Subject: FAILED: patch "[PATCH] dm-integrity: fix buffer overflow in inline mode with large" failed to apply to 6.12-stable tree
To: ben@cressey.dev,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:53:50 +0200
Message-ID: <2026101250-why-icon-9fa2@gregkh>
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
git cherry-pick -x 764b683a6180fd72c931c13fea98d383506a3475
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101250-why-icon-9fa2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 764b683a6180fd72c931c13fea98d383506a3475 Mon Sep 17 00:00:00 2001
From: Ben Cressey <ben@cressey.dev>
Date: Tue, 15 Sep 2026 00:37:35 +0000
Subject: [PATCH] dm-integrity: fix buffer overflow in inline mode with large
 tag size

In inline mode, dm_integrity_check and dm_integrity_inline_recheck
compute the checksum of each block into an on-stack buffer of
HASH_MAX_DIGESTSIZE bytes. integrity_sector_checksum pads its result
with zeroes up to the tag size, so if the tag size is larger than
HASH_MAX_DIGESTSIZE, the padding runs past the end of the buffer. With
CONFIG_STACKPROTECTOR the kernel panics in dm_integrity_check on the
first read.

Enlarge both buffers to hold MAX_TAG_SIZE bytes, as commit b93b6643e9b5
("dm integrity: fix a crash with unusually large tag size") did for
integrity_metadata.

Note that this is not a security bug because the buffer overflow can only
be triggered by root.

Fixes: fb0987682c62 ("dm-integrity: introduce the Inline mode")
Cc: stable@vger.kernel.org
Signed-off-by: Ben Cressey <ben@cressey.dev>
Assisted-by: LLM
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 92970e12267a..0862f31b8498 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2721,7 +2721,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 	outgoing_data = dio->integrity_payload + PAGE_SIZE;
 
 	while (dio->bio_details.bi_iter.bi_size) {
-		char digest[HASH_MAX_DIGESTSIZE];
+		char digest[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 		int r;
 		struct bio_integrity_payload *bip;
 		struct bio_vec bv;
@@ -2788,7 +2788,7 @@ static inline bool dm_integrity_check(struct dm_integrity_c *ic, struct dm_integ
 	unsigned pos = 0;
 
 	while (dio->bio_details.bi_iter.bi_size) {
-		char digest[HASH_MAX_DIGESTSIZE];
+		char digest[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 		struct bio_vec bv = bio_iter_iovec(bio, dio->bio_details.bi_iter);
 		char *mem = integrity_kmap(ic, bv.bv_page);
 		integrity_sector_checksum(ic, &dio->ahash_req, dio->bio_details.bi_iter.bi_sector, mem, bv.bv_offset, digest);

