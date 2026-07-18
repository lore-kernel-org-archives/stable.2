Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89F331EDA
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784417858; cv=none; b=jDRJYQE7evgeKscQO6uoeWaiurgSK/HAjt161q9EvjYUMqszFHVYtP7KCEE4lgCT/Die/aRmNUdy1U5As/GVKsBbn3w2SMgnpqQZettjhVfoHEmYLZ7jaCD08Eho/+G+04N+UZCvCWyCR8xcjWYJgW013ooUaKP0iG70gAz6kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784417858; c=relaxed/simple;
	bh=HWKjxDDo2CMACkIkPXsPGbRVg3irX3XWzzs7XBToljo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPNw/dDzeQvgqf8NI2irO5Kpdmh73+MdqJIZnO1wixHnKEaT8aZoW2QMJWlgqVHMocFRu44L3hexYVmSXoAN2Kp6qVtWwEHjC6pcZsFhY5pb3aBFnuEpJx2aY4YAtlB642Uf0CsRpvckm5kMp+azJWokPm6W2euAelgkjqL47es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIYzIBsd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIYzIBsd"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487b7b4066so9279131b3a.1
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784417855; x=1785022655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6q+CCRpDAQqdAMMHeOQyiD/gJgJeu1pHxCVEK914I8k=;
        b=PIYzIBsd6XVoBj9CXHaLPVUip2DNh+buAjZ9yFB3afi6xbaR8N8tA0BxxPX4NG6ZfT
         U+dXI5hIuMuC9Q6v/s2wvBU6ilXyePuhPJlhttROi2yiBAC6xrfH0i32D6h97ouSRKYb
         oT9hIb/2on/hTJyw6GvbiPCAh304yxqDD9hpv1I+uCPlEVoVYACAil71BdyMeunt97lV
         RWaxzjKwt+EgZS/5sCzngCiXxBbVjjfXPdFsC3PPgZXNgPIwkkdqBnXVCaoSxeOYiJdV
         9rs5kCuNCFtGy27XOwrN7tzCSoRKUMzCeLanF68DRBrCfV9jwI5y8g9S10kQX5zet4hw
         9ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784417855; x=1785022655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6q+CCRpDAQqdAMMHeOQyiD/gJgJeu1pHxCVEK914I8k=;
        b=dpsDxPB7f45hUcYYo8q5T98Sw5rYv54hB9dDst5oneAcKI15FoHFRZWnQOxeedLPvD
         YPSecisjPnnWA58TerG/3/U03vLmNtOH6Go+f4PDcNe+howh48E2cpKJZowGiMA/yQFs
         MKO8zBpFKH+iZnRnuCHVGKIkeYrzi6ruQlneLFja3FXGOuWBV3SqmGOErvrCR93nZ2tK
         AGHiN/4KpUiV0HODPuTovANwqiqVw0xTzqCB6nwMPmqlWIRVBajVC0Fv5DrtwTk0LQmb
         T1mAIBNzikU0yhd6nzJFnGNI40IDm4/jfR68nac66ptX/oqXPDxB7lp1BHXG8Ap20p6U
         WuPA==
X-Forwarded-Encrypted: i=1; AHgh+RpsuWSobVxmUPdpio/KIJXGYLrliFp7EaALaoE/2vLp6IZIpMoa9NjdrAz6zwATqGfnJqQIPAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpkwgk+ymPFt4qLXvqDr/rPk7oHHGHPN4TCNJ/B20m6ZFwgenN
	JWitEdqZu3qRznmpgkh0kAGa63Bu7RVUXRQxxTYi07uSg6S6D1bqH7bZ
X-Gm-Gg: AfdE7ckLf2amJPF5SsfetvdjWvAxzTTilj/LlSz21B0nwzQe4d1+qb7akx9FSPGL6pq
	L9h99VWkzXvumG9iK9Leh5i568dCjs4Yp+gwR/74V4kH/X5R1oEIJGhdUQ/wb/LjYoVx1nBym8H
	B7mwmlwnBw8pOBBcF1ls2ShhjaAXRwDI8umEDz+FZRt+tya5gpk52QBEwYY8EcWQZCGOR7O92nt
	l/U8v+7fNFgZyjPk/yB3URapgAWrj46Geh0eq8IgGjXgXLgfNb2WeAoTge+A8I0SjyIWqyyyc1p
	dn8iM19ilJoVVxZN4QqCeyI41BGXsR5KvHiGAR278rwhO9zHqvaFQSN0aK9hagj+IaAq1wLQso5
	ChL+14jWTTKdA8AGN6k0iT2WcvSIfM2nn7L8yKUt4/HbI0AHDqG/B3SVrNKTks2Kwsut+ZgUejw
	cb6YF9wQd5Wh0an50Xr+IdXqWFzJ6bcYMF
X-Received: by 2002:a05:6a00:a10:b0:847:926c:582c with SMTP id d2e1a72fcca58-84c292bc6aemr9369783b3a.29.1784417855456;
        Sat, 18 Jul 2026 16:37:35 -0700 (PDT)
Received: from powertower.tail474ae1.ts.net ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af30b89sm3381350b3a.33.2026.07.18.16.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:37:34 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: quwenruo.btrfs@gmx.com,
	wqu@suse.com,
	clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mykola Lysenko <nickolay.lysenko@gmail.com>
Subject: [PATCH v2] btrfs: raid56: fix scrub read assembly submitting no reads
Date: Sat, 18 Jul 2026 16:37:10 -0700
Message-ID: <20260718233710.176782-1-nickolay.lysenko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5387bd958180 ("btrfs: raid56: remove sector_ptr structure")
converted the bio-list membership checks from sector pointers to
physical addresses. The two conversions in rmw_assemble_write_bios()
kept their polarity (skip the sector when it is NOT in the bio list,
i.e. when there is nothing to write), but scrub_assemble_read_bios()
has the opposite polarity -- skip the sector when it IS in the bio
list, because then there is nothing to read -- and the conversion
flipped it:

	-	sector = sector_in_rbio(rbio, stripe, sectornr, 1);
	-	if (sector)
	+	paddr = sector_paddr_in_rbio(rbio, stripe, sectornr, 1);
	+	if (paddr == INVALID_PADDR)
		continue;

Since a parity-scrub rbio's bio list only holds the empty completion
bio, the result is that scrub_assemble_read_bios() submits no reads at
all. finish_parity_scrub() then compares the parity it computes from
the (cached, correct) data stripes against whatever happens to be in
the freshly allocated, uninitialized stripe pages:

  - if the garbage differs from the computed parity, the sector is
    "repaired" and written back -- accidentally producing the correct
    on-disk result;
  - if a recycled page happens to still hold the old (correct) parity
    content, the sector is deemed clean, dropped from dbitmap, and the
    actually-corrupt on-disk parity is left in place. (Scrub reports
    no errors either way: there is no counter for P/Q corruption by
    design, so the bug here is purely the failure to read and repair.)

The second case is intermittent because it depends on page-allocator
recycling. Observed with fstests btrfs/297 (raid5, 2 devices): the
corrupted P stripe intermittently stays corrupt after a scrub --
roughly 1/10 runs on x86-64 KVM and up to 7/8 on a UML build whose
timing favors page reuse.

Since the bio-list check can never be true for a parity-scrub rbio --
raid56_parity_alloc_scrub_rbio() adds a single empty completion bio
(asserting bi_size == 0), bio_paddrs[] is only populated by
index_rbio_pages() which is never called for BTRFS_RBIO_PARITY_SCRUB,
and rbio_can_merge() refuses to merge rbios of different operations --
remove the dead check entirely and assert the invariant instead, as
suggested by Qu Wenruo.

After this fix the injected corruption is read, detected and repaired
in every run (8/8 UML, 10/10 KVM), and the new assertion never fires
across the full fstests raid group.

Fixes: 5387bd958180 ("btrfs: raid56: remove sector_ptr structure")
CC: stable@vger.kernel.org # 7.1+
Suggested-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
v2: per Qu Wenruo's review -- the membership check is dead code in
either polarity for a scrub rbio, so remove it and ASSERT the
invariant instead of restoring the original polarity; clarify in the
message that the absence of P/Q error reporting is by design; move the
AI-usage disclosure to an Assisted-by tag per
Documentation/process/coding-assistants.rst.

v1: https://lore.kernel.org/linux-btrfs/20260716174511.8738-1-nickolay.lysenko@gmail.com/

Note: UML (User-Mode Linux) results above come from
https://github.com/mykola-lysenko/btrfs-uml-fstests/ -- for reference
only.

 fs/btrfs/raid56.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2909,13 +2909,12 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 			continue;

 		/*
-		 * We want to find all the sectors missing from the rbio and
-		 * read them from the disk. If sector_paddr_in_rbio() finds a sector
-		 * in the bio list we don't need to read it off the stripe.
+		 * A parity-scrub rbio carries no data in its bio list: the
+		 * only bio there is the empty completion bio added by
+		 * raid56_parity_alloc_scrub_rbio().  Every sector is read
+		 * from the stripe, so only assert that invariant here.
 		 */
-		paddrs = sector_paddrs_in_rbio(rbio, stripe, sectornr, 1);
-		if (paddrs == NULL)
-			continue;
+		ASSERT(!sector_paddrs_in_rbio(rbio, stripe, sectornr, 1));

 		paddrs = rbio_stripe_paddrs(rbio, stripe, sectornr);
 		/*
--
2.43.0
