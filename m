Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.134.164.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016472;
	b=HxPD6rq00Z+MaXQ36vhAp23ktQ7sBcBPxt4WX+af8Y4dkpujRdhjCQ2DrbHOqRuyHomg
	 zPPy1VshefP5ESZYXKyaJMDHPdE3qMGiYe6T8DVywHZwxPiJt/I+AXeWUgdFZly/YvkrD
	 uznpBNBzkpgQQO16jQg5LyLMPaWBNcY4V/32RUryT53R+xHyxKEhRtiDBTb6qvYNmbyCF
	 cwaWwDtrndLEB1GY07DjjD/ZRtEsCHCp9op+fbIp6K3TfOCDNQDF135kGHUwDTG7ga4C8
	 TvIOOG93dSg93V6ZmvFtBbUWMx5BWq7SI6VQfrz+bxPyB4kNRNT9fz7X2A6eFEZX5Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016472;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4VZzvnNyCzqoZS6AgGQvdB6TpwdyO7nYmEyIGI9OWVA=;
	b=KgIKqxhRn3ZKvr15ZRL8VEvpWYd7rYyKkT90QeOJPsDGdIJfzi1S6m67FL0gu0kQbbnX
	 nFcYqSwiSzTOp/sG7xv4dTbKPttnmTZEaRj289zrSkc2IaVf/dROOPTeDXv/lddnSfqK0
	 rleZNHx27ady2ZG7bS7V6KIGbuqG8TljM1xHD4ucYLfDBCav7nwiP6Y8uEyJRTV5CpXaT
	 PyW5PqJOmhBRKKt4NURgcv5HeLk7koEg3aU3UgzHQ/5iYQZVY+Sj8ZUSYYOEiVFEQ9fvZ
	 l78LvEYX2i52J9NxjuH0d1mBWeagvIxx5HxLUvLps/TI6mDV5xF8ZZ/Xio8D/EjA0tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=inria.fr;
	spf=pass smtp.mailfrom=inria.fr;
	dkim=pass header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=u+28VSsl;
	arc=none smtp.remote-ip=192.134.164.83
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFEB606A31C;
	Wed, 18 Nov 2026 15:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCFEB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=u+28VSsl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4VZzvnNyCzqoZS6AgGQvdB6TpwdyO7nYmEyIGI9OWVA=;
  b=u+28VSsloqU+wKHZO6pZR1TTAW/FnMi9BqjzDAFJUohgJZAst7CNk5F2
   YgsLbeacQccQJGlURwpaT0HBH4oqpNWf1JBBuohZ5wVSH1KX7AkOcGZGE
   /kg1rvtahDUfKhLnxaI7nlpLi2pinRS6QwC5nyt90Da7MuxHqJ/XEUTCk
   E=;
X-CSE-ConnectionGUID: nW7qx0IVQLeebx4H0iZwhA==
X-CSE-MsgGUID: dq1/kDuFR7a3WJLUwUa/gg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=zakaria.belkadi@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.27,219,1787004000"; 
   d="scan'208";a="306148046"
Received: from wifi-eduroam-85-131.paris.inria.fr (HELO Dellisimo.paris.inria.fr) ([128.93.85.131])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 16:41:08 +0100
From: Zakaria Belkadi <zakaria.belkadi@inria.fr>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	florence.schadle@ssi.gouv.fr,
	frederic.tronel@centralesupelec.fr,
	louis.rilling@irisa.fr,
	Zakaria Belkadi <zakaria.belkadi@inria.fr>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] block: pin user PI pages for writing when ref tags are remapped
Date: Wed, 18 Nov 2026 16:40:53 +0100
Message-Id: <20261118154053.13218-1-zakaria.belkadi@inria.fr>
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

For an O_DIRECT write that carries a user protection-information buffer
(io_uring PI attribute), the PI pages are pinned as a data source,
without FOLL_WRITE: io_prep_rw_pi() imports the buffer as ITER_SOURCE,
and bio_integrity_map_user() pins the pages and normally uses them
directly. It copies them to a kernel buffer only if they are misaligned
or in too many segments.

If the integrity profile of the device has BLK_INTEGRITY_REF_TAG,
blk_mq_start_request() -> blk_integrity_prepare() then remaps the
reference tags in place in those pages. So the kernel stores into
whatever page backs the buffer, including a page the caller can only
read.

Write access to one such device is therefore enough to make the kernel
write into any page the user can map for reading, wherever that page
comes from. Two examples, both tested: the page cache page of a file
the user can only read, and the shared zero page.

Pin the pages for writing when the request is a write and the profile
has a reference tag. A read-only buffer is then refused, and a
never-written anonymous buffer gets its own page.

Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Zakaria Belkadi <zakaria.belkadi@inria.fr>
---
Resend: my first attempt today went out with an HTML part and was
rejected by the lists. Sorry for the noise to those who got it
directly.

Found by a source review assisted by an LLM. I first sent this
privately to Jens and security@kernel.org on 16 November, because I had
missed that Documentation/process/security-bugs.rst asks to treat such
a finding as public. So I resend it here as a normal patch; sorry for
the duplicate. The patch in the private mail was truncated, please use
this one.

I reproduced it myself. A reproducer is available on request.

Affected version: mainline v7.4-rc3 (aebb72744764); both cases below
were observed on it. The path exists since the commit in Fixes, v6.14.

Path (line numbers at v7.4-rc3):
  io_uring/rw.c:220, io_prep_rw_pi(): for a write, the PI buffer is
    imported as ITER_SOURCE.
  block/bio-integrity.c:368, bio_integrity_map_user(): the pages are
    pinned without FOLL_WRITE (lib/iov_iter.c:1784) and normally used
    directly.
  block/blk-mq.c:1377, blk_mq_start_request() -> blk_integrity_prepare()
    -> blk_set_t10_map_ref() (block/t10-pi.c:483) stores into them:
        if (ref == virt && ref != ref_tag)
                put_unaligned_be32(ref_tag, &pi->ref_tag);

Setup: QEMU guest, emulated NVMe namespace with T10-DIF type 1. Root
gives one unprivileged user (uid 1000, no supplementary groups, no
capabilities) ownership of the device node of that namespace, and
nothing else. That user does one io_uring O_DIRECT write to it.

1. PI buffer = read-only mapping of a file. The file is on another disk
   and belongs to root (mode 0444); the user can write neither. The
   write changed the reference tag stored in the file, as seen through
   the mapping, through pread() and by root. After dropping the page
   cache the old content was back: the cached page was changed, not
   marked dirty.

2. PI buffer = never-written anonymous memory (shared zero page). On
   v7.4-rc3 the zero page is read-only, and the kernel oopses with a
   write fault in blk_integrity_remap(). Up to v7.1 the x86-64 zero
   page is writable, so the store lands: on stable 6.18.58 the write
   succeeded, and a new, independent anonymous mapping then read the
   reference tag where there should be zeros.

These two pages are only examples. The device is the one thing the user
was given, and it does not limit where the store lands: that depends
only on what the user maps as the PI buffer.

Conditions: a device whose integrity profile has a reference tag (NVMe
PI type 1/2; SCSI DIF type 1/2 by the source, not tested), opened for
writing with O_DIRECT. What is stored is the 4-byte reference tag of
the device, at the tag positions, not data the caller chooses freely.

Fix tested on v7.4-rc3, same user: both buffers above are refused (the
write fails with EIO), with no fault and no change to the file or to
the zero page; a never-written writable buffer gets its own page; a
normal writable buffer works as before. Not tested: v6.14 to v7.1 with
the fix, stacked devices.

The patch makes such writes refuse a read-only PI buffer. If those must
keep working, the PI buffer could be bounced instead, always or only
when pinning for writing fails. I can test another fix.

 block/bio-integrity.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index d3df726e0..3ee2d49d8 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -487,6 +487,14 @@ int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta)
 		return -EINVAL;
 
 	it.count = integrity_bytes;
+
+	/*
+	 * blk_integrity_prepare() remaps the reference tags of a write in
+	 * place, so the PI pages are written. Pin them for writing.
+	 */
+	if (bio_op(bio) == REQ_OP_WRITE && (bi->flags & BLK_INTEGRITY_REF_TAG))
+		it.data_source = ITER_DEST;
+
 	ret = bio_integrity_map_user(bio, &it);
 	if (!ret) {
 		bio_uio_meta_to_bip(bio, meta);

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.39.5

