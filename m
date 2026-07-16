Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A33442FCA
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223978; cv=none; b=OH7vVFGvKV+GpA1Y3HVLqz9YWg+nSL2u8auw4mqD5hhbMBZztTnlnvqfCvSLrXaiyFzlcgoVwDfOSKq+ZMcIwkWpc8JjM5fsLjkr5/lLhPaoe6AJ4eE2vEKr6JkSFsIyJTSempPSz9NSnr8Q4mRya/HlXq9DzP2Dh18H3PFV/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223978; c=relaxed/simple;
	bh=EpTvIEnfaRxAzHOYkqg2UVgcLo8MAhzTpHCqoMXBEto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R100p3A+tNvHqNC5k+kV93YbCQJpX2z1Muc+F6NoOTE5Zcay2xHwF7Sff2pzMvUXG333Yz4vHdJ/8tS86h63kujrIT9x/FDCGzNseeuyL0jZSRl8bb/BriG/gyGQ5qSIw5GkHuKqDA0gfocilq1Q++5AIUyYd0pDWUxjGgEWwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzadtqEv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzadtqEv"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e08baf860so4547370a91.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223976; x=1784828776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UvgAQYuXw0Pq8CkJOHjJsWsNL8Ayfq5NJDRoeLGCnyY=;
        b=OzadtqEv+z3ewmgNsPtt1CV89sAJyyXE747qUjZjiicNN+aRJLhtDG1z24ovHMeqvM
         hELmaJhwWRMwyDuAwuc5lgORWfuUC23FHkK+5fGrBBGfy+Md5JKa9BNJuKut4G83Pr84
         Qw1JfWP5oT8NXfG+7RJsSkVYAbQHEzqjcqQhDSOmF8ethRzdvMCMwcMUKCEZmtjr2eH5
         ZoIaWzi6JqVFq9ue/JiJnkMtJGAAPqG/5ItEquazzKrHx13zgmefHmgSkYbroIX2V1GC
         pd+1NCbPTBtwQCL7LUx/7nKz7nb2yn6JQypGImrXof7GXAVkjgWIcdvKo+IJIzP4Sr/1
         0vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223976; x=1784828776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UvgAQYuXw0Pq8CkJOHjJsWsNL8Ayfq5NJDRoeLGCnyY=;
        b=OVTsM76jJ9LGoxhysqRtP7W1kZJkmledKOibenvh03SNGRaOvLn+/BY44sC8w7zHoe
         Km0LqUj7STAvdghxDFe2wWS4+Uyuhd4SXn7wjKiVYAJdDqXnY9l6MpAnJ27VVYh/8+x9
         VpKKV7NBuJbXSoQzx9YUZxPwoZL1apRtOUICcO5l/poIbDfn+WnB7gAJMrvnz6NIIhOv
         QXJC7J1HW+y8yZ6mmnTrYgU0e7qcZ8Psm8YJ4sR1RJUAO/OQVxJrbuwv9/EiKozItrKe
         LeWibvX174lKmYXfraMy5aUmFftnMCltakrDxYAG3hobR3JAuQOXyZx7Crmwrp+E+h6x
         UHdQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLIJtq13a4+kg31ASXTYPS6lrWz1F8gqXqGe20wQ+wRNsLGcaUS0AM7po81tdsC2Uzmk7B/q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+JQjnQZ1n1E4Xx0dB7g3WmUrN2zSvath54k70nMoD7J3Ja8t
	6Qmp8VN9FoE5EhiAzDdQA61os5exZ1J08Vkg8ghLaIWU4GLPQezF3xvA
X-Gm-Gg: AfdE7clFYW27x003sfFl3wFbV62dOYtZl+fH2fle2KOS0js/hvC6fUgk8SzsN/hRQk/
	wjMCJHHjwurWaxj9tvkpwhfFWM1Bh1+8eQlrp3SITz6Ka6hOE7eSNt/8I/zQJIA8TGbrgKXPcDZ
	DigsqAlKaq6PlDsm4xDqRudolEEB0qGoZ8d+N4hDqKhh24XO/PBRZIQUYvJ/Jou/DaGwdCK1Wdj
	suiod1BZHE6f6xT2mhwbIhsdgBc7U1qDRaa4UvQH4+uXc8yNT7BMEMMzIxstGJ/L5crA+iswsiI
	da3fylwmHAaXZOShvh7/NvpM+lGMOMZdzEjG2AzRH+MOcGuktQ89wYWIOht0Xm53Zy8EgZ4GQ/z
	G2nBdxJsuyVttCJ/fi8jVaLVM9QY2NPhytOWkW5Obe3JGU+S0Kq6qb2bds52f5wVxsWox/P/EFF
	Zu9/gUHQNNpaI8W56XzHzf8Ern
X-Received: by 2002:a17:90b:3905:b0:387:e0db:3d90 with SMTP id 98e67ed59e1d1-38e2a0b5d8amr8781556a91.43.1784223976103;
        Thu, 16 Jul 2026 10:46:16 -0700 (PDT)
Received: from powertower.localdomain ([64.180.35.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39bc2c2esm1693546a91.0.2026.07.16.10.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:46:15 -0700 (PDT)
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	linux-kernel@vger.kernel.org,
	Mykola Lysenko <nickolay.lysenko@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: raid56: fix inverted bio-list check in scrub read assembly
Date: Thu, 16 Jul 2026 10:45:11 -0700
Message-ID: <20260716174511.8738-1-nickolay.lysenko@gmail.com>
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
physical addresses.  The two conversions in rmw_assemble_write_bios()
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
    actually-corrupt on-disk parity is left in place -- silently, with
    every scrub error counter reading zero.

The second case is intermittent because it depends on page-allocator
recycling.  Observed with fstests btrfs/297 (raid5, 2 devices): the
corrupted P stripe intermittently stays corrupt after a scrub that
reports no errors -- roughly 1/10 runs on x86-64 KVM and up to 7/8 on
a UML build whose timing favors page reuse. Instrumentation of
verify_one_parity_step() showed the "on disk" bytes never matching the
device content (stale 0xaa / zeroed pages instead of the injected
0xff), and after this fix the injected corruption is read, detected
and repaired in every run (8/8 UML, 10/10 KVM).

Fixes: 5387bd958180 ("btrfs: raid56: remove sector_ptr structure")
CC: stable@vger.kernel.org # 7.1+
Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
---
Note 1: I found, reproduced and created a fix for this problem using AI
tools

Note 2: I am referencing UML (User-Mode Linux) above which is coming
from the project https://github.com/mykola-lysenko/btrfs-uml-fstests/ to
run xfstests in the UML. For reference only. 

 fs/btrfs/raid56.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 00a01b97cc..93de764d70 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2910,11 +2910,11 @@ static int scrub_assemble_read_bios(struct btrfs_raid_bio *rbio)
 
 		/*
 		 * We want to find all the sectors missing from the rbio and
-		 * read them from the disk. If sector_paddr_in_rbio() finds a sector
-		 * in the bio list we don't need to read it off the stripe.
+		 * read them from the disk. If sector_paddrs_in_rbio() finds a
+		 * sector in the bio list we don't need to read it off the
+		 * stripe.
 		 */
-		paddrs = sector_paddrs_in_rbio(rbio, stripe, sectornr, 1);
-		if (paddrs == NULL)
+		if (sector_paddrs_in_rbio(rbio, stripe, sectornr, 1))
 			continue;
 
 		paddrs = rbio_stripe_paddrs(rbio, stripe, sectornr);
-- 
2.43.0

