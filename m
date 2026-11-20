Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.134.164.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204631;
	b=dC7AKSilkNyWzWPq93MjVorp69t8kK5cnRcSaFjcSELib0Ww2zQ5Cd8O5QRfLDbo+JuZ
	 Agrl2xjWQIAYyqbQPBqplN8Bbf3lcOPQlHJvUs8a6bPwiFwXVYn46LSekqaaRvq0SDSVJ
	 x41bKEBASY6JnaUQPWjgibKDiFlFcZxgsVYVf9nYITzVfM+S+1fR6A4mDuSLOZEHNsT8+
	 leCeEIBNlED28jOusRUPUCmOz/0kofTNUe2Bno9CgNDGyFbeDoCgdzjLh8x6nAuV3Yh7x
	 oclm1xa8joDpcg9PE7kuz3MJKgkXtfMqFQt9LErWwDXwwwI03llZpYKrbrI65NkZlDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204631;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kts9umuHZcQ0nV78PhfIV7Gm0gO8Avsdz1JCYlFElQc=;
	b=UciwwlIdZ3owVNAHep9rnF8vZeuKmG48TWYevfYeCnuJqT3dHLmNhXyp3IYrjloN408H
	 /hpx7w7ZpcA3Tl3OnwQbMonUGW748aOvfivEqO93TSddkWUwx+VzQ2afMaJtylWs79ffM
	 VAaTdiUe2hXaaq28o9j/ius0c8DUAN7zbDchGxPnfsdZMgGnxRc2OhmOGHj6+pURSBIRJ
	 wdCgS3PnITNNceKxPBRKtJrNEm65vkcE6l+7hqK5JJulVdVxS2JKJLek92+obGc7CjUuw
	 Y+TxdbtqzAv/mAcQ/AywxuVxRdIq2dPAKl7ViIqZWbxzcIv3Qp+VOeeeoxzyISIu4Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inria.fr;
	spf=pass smtp.mailfrom=inria.fr;
	dkim=pass header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=FMA0IFMO;
	arc=none smtp.remote-ip=192.134.164.104
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3A606A6CB;
	Fri, 20 Nov 2026 19:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E3A606A6CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=FMA0IFMO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kts9umuHZcQ0nV78PhfIV7Gm0gO8Avsdz1JCYlFElQc=;
  b=FMA0IFMOazt28GH5anBaOmqLd5qcwmjAXAgk/ZpebDMblOzLbwVh+36U
   U+c1uRzx6TBxev85ZO5qjLi6aPBFch9qwWdOqR+638bsHX/d5yixPeick
   ApZyUBwRAntOQQ4E29kAvyemFtmWRzELUEjDItNXErqrlQUR/y+rgXKHb
   o=;
X-CSE-ConnectionGUID: 1l0saygmS3S2onbeuMaNnQ==
X-CSE-MsgGUID: lmGETQJgTsedddpLkUgNJA==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=zakaria.belkadi@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,223,1787004000"; 
   d="scan'208";a="163459881"
Received: from rezo-rennes-os2.pck.nerim.net (HELO localhost.localdomain) ([62.212.118.53])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 20:56:55 +0100
From: Zakaria Belkadi <zakaria.belkadi@inria.fr>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	florence.schadle@ssi.gouv.fr,
	frederic.tronel@centralesupelec.fr,
	louis.rilling@irisa.fr
Subject: [PATCH v2] block: bounce user PI when writes may remap reference tags
Date: Fri, 20 Nov 2026 20:56:44 +0100
Message-Id: <20261120195644.19511-1-zakaria.belkadi@inria.fr>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On an io_uring O_DIRECT write, bio_integrity_map_user() can attach the
caller's protection information (PI) buffer directly to the bio. The
block layer pins the pages for reading, but reference-tag remapping can
write to those same pages.

A caller with write access to a block device whose integrity profile
enables reference-tag remapping can therefore modify a page it can
only map for reading. In testing, remapping changed a tag in the page
cache of a read-only file. With a PI buffer backed by the shared zero
page, the kernel faulted during remapping.

Use the existing bounce-buffer path for REQ_OP_WRITE when the queue's
integrity profile has BLK_INTEGRITY_REF_TAG set. This copies the PI
buffer into kernel memory before remapping, so the caller's buffer
retains its original reference tags.

I found this issue during a source review assisted by an LLM.

Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
Cc: stable@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Zakaria Belkadi <zakaria.belkadi@inria.fr>
---
v2:
- Bounce the user PI buffer instead of pinning it for writing (Christoph).
- Dropped Caleb's Reviewed-by, since the patch changed.
- Corrected what the caller controls (Caleb): it chooses the address of
  the PI buffer, the seed and the device offset, so both where the tag
  is stored and its value.

v1: https://lore.kernel.org/linux-block/20261118154053.13218-1-zakaria.belkadi@inria.fr/

Open question on stacked devices: the test uses the profile of the
top-level queue. By my reading of the source, a device-mapper target
with members of different profiles can get a top-level profile without
BLK_INTEGRITY_REF_TAG while a member has it, because
dm_set_device_limits() ignores a stacking mismatch. This condition
would then not force a bounce. I have not tested whether such a
configuration can accept user PI and reach reference-tag remapping on
the underlying device.

Would you prefer bouncing all user PI buffers on writes to cover this
case?

Tested on v7.4-rc3 in a QEMU guest, emulated NVMe namespace with
T10-DIF type 1, as an unprivileged user who owns only the device node:
- PI buffer = read-only mapping of a root-owned file: without the patch
  the reference tag in the file changes; with it the write succeeds and
  the file is unchanged.
- PI buffer = shared zero page: without the patch the kernel oopses in
  blk_integrity_remap(); with it the write succeeds with no fault.
- Writable PI buffers still work, and the kernel no longer modifies
  them.
- Stored tags (as root): a write with a seed different from the block
  number succeeds with reference-tag checking enabled. A subsequent
  read using the block number as the seed returns the expected remapped
  tags, with identical results before and after the patch.

 block/bio-integrity.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index d3df726e0..aaea5802e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -394,6 +394,11 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	copy = iov_iter_alignment(iter) &
 			blk_lim_dma_alignment_and_pad(&q->limits);
 
+	/* Reference-tag remapping must operate on a private copy of user PI. */
+	if (bio_op(bio) == REQ_OP_WRITE &&
+	    (q->limits.integrity.flags & BLK_INTEGRITY_REF_TAG))
+		copy = true;
+
 	if (blk_queue_pci_p2pdma(q))
 		extraction_flags |= ITER_ALLOW_P2PDMA;
 

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.39.5

