Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273593;
	b=qYoXJvlo3Q0ZjSpCcnxwzKmLR97DmVIz+bseL/7jQuHfDegBT7vmZiUnqxKFst4EZqXZ
	 KEAOZ5DCVuIm10ukiS64gXB2ZwyYf0IaRekSb7U0h6DfC+rjEED8M3McMsyjhBTYqJWjq
	 WfMWhpQ1fSyfyhrr6OC/sbtIYgvvGjJftom39MFIrJ/EZKR1NY6p32YIyV9JCxm1ogwDr
	 2aiH5NC8B9ptPk85DiwAfQ0XwlQl613sgKJajA3nBynpxaKOfBa2Bm+mR2OrkudoEakDo
	 DeeUaM/am2BI8Yt5bWxNeqnW/QGtAPYrR0dNbPsiBQiYNqvKgb58szhumeev0wNwmbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xJasMMkSe4DF0VWbYr7JPnzh+JyYgJo+hZ84tm3r48o=;
	b=L6gjih6jsfRIOU5bQgA4ZZ+cT22boWRqhZEQnzEHwNOFr+Wajb7tbsGBWu7fAqqiYdQI
	 00I1piec72RCgPvh3IbPo1jdzDN7Ll4pvpToy8XLAbZaotxy0f7tnmMe8FRcLIEGEfHrv
	 1mNPSGnn2bT7XMvrV4Cr21FMT286dT6tF1VrMEnIJ+jI9D6dLIY8hCVwWxWyPur1QUx3f
	 AUm4nMzzVMFM/Yk9gVcKXNp9fPAeyUiT4bSiLn5hn4YDv2bv1E4u99qmfhB1nqDKhsBKR
	 HJnYVSwASPdUC+4jrdYhAP5Hh1lnXsWRwu+G00dvsZWTR10vGuFJaaKtz6FpLNFxmDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkgY8zp9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AE606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkgY8zp9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9001F0089F;
	Tue, 10 Nov 2026 01:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273593;
	bh=xJasMMkSe4DF0VWbYr7JPnzh+JyYgJo+hZ84tm3r48o=;
	h=From:To:Cc:Subject:Date;
	b=VkgY8zp9QHRMGOBgpQjDO/kVPLnw1VwW78HwfW72mYpV+4WM4yI33EcjOgqow3iXz
	 YH2FvVSi8XSnTgutG4owJ0tT1CTgp1B7jTWsr4Ulz0YCq2+K7QTsNzLWZDXQiRazVy
	 ouAQkdPQFqPEfOdqoFgJxESNv6NMhVuZoWGb5cAkx/qYifRfHpD9uesECBZWOuPa/T
	 yI5R0lyXOvuhsLLUiQXybeWWPRZ999KMqAZF9NMG1XSG5nG+e1cZcFuHmpJUnaxNSE
	 H8mqxdFu1EnH+K02y22IKEvbkirw+EMjPPe9IXJ11awwO5iJ54zaPeb93vX486GwbM
	 RaMiViWYIu8jQ==
From: Sasha Levin <sashal@kernel.org>
To: matthias.goergens@gmail.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: don't use eloc after the end of the unallocated space table" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:19:51 -0500
Message-ID: <20261109201951-failed-6.1-94401199df90@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 94401199df90e1c2a50c6e4b73618ac5a4ba83ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201951-failed-6.1-94401199df90@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 94401199df90e1c2a50c6e4b73618ac5a4ba83ba Mon Sep 17 00:00:00 2001
From: Matthias Goergens <matthias.goergens@gmail.com>
Date: Fri, 30 Oct 2026 22:05:37 +0800
Subject: [PATCH] udf: don't use eloc after the end of the unallocated space
 table

When udf_next_aext() returns 0, its eloc, elen and etype outputs hold
no defined value.  Two walks of the unallocated space table still use
eloc after the walk has reached the end of the table.

udf_table_prealloc_blocks() looks for a free extent starting at
first_block and decides whether it found one by comparing eloc with
first_block after the walk.  If the table's list ends in a continuation
descriptor that leads to an empty allocation extent, eloc is then the
block of that allocation extent, which is in use, and if that is
first_block, the block is handed out as preallocation.  Once
udf_discard_prealloc() no longer frees the wrong block, this is what
still makes fsx in generic/091 and generic/263 read back bad data on a
table, in about one run in four.  Only take the extent if the walk
stopped at it.

When udf_table_free_blocks() cannot merge the freed blocks into an
existing extent, it appends a new one and sets only its block number,
so the partition reference comes from whatever eloc held after the
walk, and with long allocation descriptors it is written to disk.  For
a table without extents, eloc was never set.  Take the partition
reference from the freed blocks instead.  Short allocation descriptors
do not store the partition reference, which is why this half remains a
latent long-descriptor fix rather than a reproduced failure.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Link: https://patch.msgid.link/fd9ca4c4ba98c00c012ec861f6c0bc08a3b1d07b.1793349907.git.matthias.goergens@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/balloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 2ec577b4321c9..75124188e7452 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -457,6 +457,7 @@ static void udf_table_free_blocks(struct super_block *sb,
 
 		int adsize;
 
+		eloc.partitionReferenceNum = bloc->partitionReferenceNum;
 		eloc.logicalBlockNum = start;
 		elen = EXT_RECORDED_ALLOCATED |
 			(count << sb->s_blocksize_bits);
@@ -532,7 +533,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
 			  eloc.logicalBlockNum, elen, first_block);
 	}
 
-	if (first_block == eloc.logicalBlockNum) {
+	if (ret > 0 && first_block == eloc.logicalBlockNum) {
 		epos.offset -= adsize;
 
 		alloc_count = (elen >> sb->s_blocksize_bits);
-- 
2.53.0




