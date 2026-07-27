Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027F1624DF
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785125276; cv=none; b=SgayHfciWYjEnme1eZ100fV2GQC2ouLsysSkTKWsePe6493BmYNmwcZ8L1ahj8jnaHIwhXeRaXUhKUZPSQAM8uA1m4kOJw8jOkI71aJuiyLKgUwVkhUfuUJoXIPLJE+mYmXZal5mtEL43SlaOP2Os/QGCMtnip8tjRShCscC6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785125276; c=relaxed/simple;
	bh=Gxp3Un4AZGgro1b7wJhIj9cUYRY3ZZI3yEbM0aXczz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnVtCdCC5r2n8JyPlRT953dnGN3exzLozvyCzPm7mgVz1x0iVT2kk1R8bDsMjDR3XG/Ao09wPyNT8T+kd08IjjBNezCa4TF1VPsAsvquRtEYbFe9gKzKLldga5ZLcadpWD7BTStSIiGg28S1ETg/TJ9xddCY6HIQwaDsWmRvBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En+3+cYH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En+3+cYH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso25372895ad.1
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785125273; x=1785730073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=86uk4Z2sGa/3sM3sJKSYmohCJPc9h2SJlL31GgQy+No=;
        b=En+3+cYHN4RCisczuYSD8uDNcyN6CRfIWxFRSXzGxnQwuIJFcqHjaCxgT6HI8GvkeK
         xeProrRxw42d/B+pqnBf3um0kd2GPwn7TrflTaiVty5D4B55KwHCbdZiKJcQcsu8L4uC
         EvsZmL7cHJlrTjrlMt5sD8fyy3u4tlRVRRldUlfxfGjaYmHi0sgJV16himEYyz3QW+VD
         4U92cgpqJOQgd4Krim85VAWqWL/cTzRFppYhQrKLeCDTHW32vSguylDxOYMLZ9qABoaK
         nGAOa9p8Dkq9nabU3pm/Z4TqcsGkyZqYNdUvDc8IhBSkpljw+YAaaQopzR9tOslTMrnv
         42eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785125273; x=1785730073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=86uk4Z2sGa/3sM3sJKSYmohCJPc9h2SJlL31GgQy+No=;
        b=Fi/BliWeQlmxI5TCyY7DZS//1Cg+a/RAyxnVwzkzhf6PqQuiTK7kZkV3cRikKytgZV
         hEOJS78nZ1SIN5p5Jn9VOdTHvrI2ykDPQ5efYbpwy9YxUSwmJ7/YW64s0gN5NskXIDFR
         Rux9r2B7WFWDs0Wzufxp9ZwyPSR4eyt51UJndmH5/eEPG4Z4dkRAiNvK3PTgzBF6M+zz
         CaSjllPN+5v7FoTOP0Na4imc4bxUEoHZ0zw7WV8jzGHcrK4D1FWlUR93u5196Uw9NixK
         1Y3VWNgwRBAeVejGE1WoB7xXm3697YglkfwYP9Ct5VcETxx0eb8w94grEDXGc/X0i/Vi
         3Fig==
X-Forwarded-Encrypted: i=1; AHgh+Ro17XIBOp/LJGnsq1SgTJWlu9Ikpda6DwPQm81XXp+21QZUvcMsa78cfmdNtFAMR/C/REqBpUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOa2BRw8F1cc7LAD+AoyvSms7Bd+L2B41MPf2QTk/Nmm7xb8a
	RCbsqxMmFizz8g9VTVQbOSbEmWeu1NCaiQKyvZJ1t/8bEgiqPFdxqj9N+ZC7655S
X-Gm-Gg: AR+sD12xchy0fj0F2wLNQXkEzggCH6FpolPr9QCLNkdsmyua0n1m2hsYmUiHpFObFHc
	AMr8a0o6BLgGyl1LnEqXbWp8yZXOpOFWd4AQq53y5fNqdNCkAWq2saMfiafc9Fvo/ACMGO9A6wS
	TO+bQ3DcERvPfpMoSUIMhVuW2FHLMfcHMh2Dd419KIfi27s1nU8KbklUaRwXKCv2X9TcSjmqONe
	5xfxONy6T9vla4a6/jWP+ESHbwQfbURV2ugVnb93/L/rqWsYO9Uw4cKI3jlnUzMKWt7w5kr/dUJ
	AInwHWU33BtbeN8eoxia6oEOn0fCzNz+866AVTUwcICjDLfgzY9pGBmF6FYj25GyJPvJLJ/VP8K
	dCWmkmumzllzDCrLHXCvnpGxLf1lGBrImUdYH9pKiT9uEY7IOb7yseD8hV8fpwktOUU3N3ctE6c
	CblYo=
X-Received: by 2002:a17:902:c40a:b0:2cc:61e8:5fba with SMTP id d9443c01a7336-2cfde866e46mr72199415ad.32.1785125273513;
        Sun, 26 Jul 2026 21:07:53 -0700 (PDT)
Received: from kali ([58.187.6.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cffa9243fcsm5645825ad.64.2026.07.26.21.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:07:53 -0700 (PDT)
From: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] partitions/efi: reject GPT entries with starting_lba > ending_lba
Date: Mon, 27 Jul 2026 00:07:27 -0400
Message-ID: <20260727040727.1910700-1-nguyenlethanhtung555@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_pte_valid() checks that both LBAs of a GPT partition entry are within
the device, but never that the entry describes a forward range:

	if ((!efi_guidcmp(pte->partition_type_guid, NULL_GUID)) ||
	    le64_to_cpu(pte->starting_lba) > lastlba         ||
	    le64_to_cpu(pte->ending_lba)   > lastlba)
		return 0;

EndingLBA is defined as the last LBA of the partition, so a conforming
entry always has StartingLBA <= EndingLBA.  A crafted table can invert
the two while keeping both within the device, and efi_partition() then
computes the length as

	u64 size = le64_to_cpu(ptes[i].ending_lba) -
		   le64_to_cpu(ptes[i].starting_lba) + 1ULL;

which underflows to a value close to U64_MAX.

The "extends beyond EOD" clamp in blk_add_partition() does not contain
this, because it tests

	if (from + size > get_capacity(disk))

and from + size wraps for a size of that magnitude, so the sum comes out
small, the clamp is skipped and the partition is registered with the
underflowed length.  From then on bio_check_eod() is evaluated against
bdev_nr_sectors() of that partition, i.e. against the bogus length, so
I/O submitted through the partition device is no longer confined to the
partition and reaches sectors owned by other partitions of the same
disk.

This was verified on 6.8.12 with a crafted two partition image: the
inverted entry is registered as a partition of nearly 2^64 sectors
with no "extends beyond EOD" warning, and BLKZEROOUT issued on
that partition overwrote known marker data belonging to the other,
unrelated partition on the same disk.  No privileged step is
needed on the victim side beyond getting the table parsed, which happens
automatically for removable media on a typical desktop.

Reject the inverted range in is_pte_valid(), the single place every GPT
entry is gated on.  The code has been this way since the beginning of
git history.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Le Thanh Tung <nguyenlethanhtung555@gmail.com>
---
Compile tested on 6.8.12: `make W=1 block/partitions/efi.o` produces no
new warnings.  The behaviour described above was reproduced on that same
kernel with a crafted image.  is_pte_valid() is byte identical in 6.8,
current mainline and linux-next.

 block/partitions/efi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 9865d59..000219a 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -461,7 +461,8 @@ is_pte_valid(const gpt_entry *pte, const u64 lastlba)
 {
 	if ((!efi_guidcmp(pte->partition_type_guid, NULL_GUID)) ||
 	    le64_to_cpu(pte->starting_lba) > lastlba         ||
-	    le64_to_cpu(pte->ending_lba)   > lastlba)
+	    le64_to_cpu(pte->ending_lba)   > lastlba         ||
+	    le64_to_cpu(pte->starting_lba) > le64_to_cpu(pte->ending_lba))
 		return 0;
 	return 1;
 }
-- 
2.53.0

