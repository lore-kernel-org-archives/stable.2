Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DCF33ADB0
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652160; cv=none; b=EXTfuv/8PmsNy+U6WSxERRhIzKzE6jiNUhPfP2gGJSVusddNSAa9qFpxFQM6WQOlstkIgZTqvNs8mebcyoqx8k5IuYMJSUG8zSFA6f6Tbl/H+3SdNia0p1PVoodVbIvhl5VymKf6eLk5jze86LOOciGOmPRUubZOu4pe29SSDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652160; c=relaxed/simple;
	bh=aMqCQlU/51nTh4McNUnDQbM+oOF6RGhLFFsMPHidHeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovQs/8FkaCf88lma1RD/5gTh23haA9npttAA2mtjY+hOjlWmzNErsQs+ni9U1zk23SjHCabW0BTrlDtqCJA4yuEMSgkiEtX4bos4ohrDghgE/MmaUMferQ+bnpQu6vI2dGJvZAsbLmTFz5x/sW3iIusfL0suKc2DVs21FiYOvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEDymNyx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEDymNyx"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso6862247a12.0
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784652158; x=1785256958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QyRI5K/D2UL8ohnuHgzhdDNvsAlVZY47bGS7E8xJ6wM=;
        b=jEDymNyxm/iIQVS2mjk+PcCdnaD9yA/k18Mp+HdwGBuvdf4GvJuA37vUuyOsObXw8L
         X7M+ZOIr1gIw+OkES4TnWPKRf3VTstG/kwnnNhZ/9THSWmmjJy74z1gCk6qo+FGl3Kg0
         eumt83orAttqJS+6+kjLfU7XQJAhP7yCjx89zzb8giyYvuzNQ7J0DuQX+ZRu9/RRP00G
         m3KssMN9J+UfxMb9yEJGsfqJtXakB2EYsyUsspfSe/7EsShZNX3uKAxJLXyXiRGq7akb
         exf35fI/L5G6m+sLi1fiOmnEB3B2sjJlkzE73nZuxxaOFX8dq1tSX0GCUNIkNgvUp82g
         MlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784652158; x=1785256958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QyRI5K/D2UL8ohnuHgzhdDNvsAlVZY47bGS7E8xJ6wM=;
        b=nbx8FELriNybmaalj/AljBkQ/JUA/vA4BPbGjd+tzOvTiF7UA3XL/+o1gJZN5Xybhv
         3QGuugA8cTxDGCQPZmveB+TVgDsmABHZRNv07SagUk/zPuLhUEc9o8nx5WQ/zZEuH2cA
         hMcqAicgkv0VD3l9aIKgjRUx2cIXq9cBAMAVq3ivAK2DIw931I6dKk+JzLpj8B43sK12
         O3+hCpr+C3aTv2qqmYku7HwcOpUnn8Ze22PXUpN0TQ8mFhKu5DbpgbrWR3c2rc9Xln7P
         NPyDt/IPYP7dYAcGi7zOuZuaC3INOz9B79+/oxasnUOd4WY59CIYOrv8PyLB9cpjiZHE
         8P4w==
X-Forwarded-Encrypted: i=1; AHgh+Rpjq5O675VcYHIClYaJ+2fQ76BDOKdQaFpznfUnzKiUA98/8oN8vCPVHMXWTA/TTDxuK1VNk0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysO4m1IbkE0c5ieFUVOsgkPpBKQELGfSR7Mr7vRw1yUnJUlGIx
	oQNW4kMgOpZ3tUINyVVMRgf2iPA4m8gTBhysGrxCIy+gNYnobw4wWQFrw872yq4H6dh2
X-Gm-Gg: AfdE7cmieWQkaLN/QOu/ayIdvegjirodDmdqkD/xyrdgVDTc3JccQ+fbhYLOkggHeIU
	fA8+eoSh4msJx7Jz9+4d7FkIlnGe3qwAaoajDGDp8BXnEjzHlUlbrTGUzb44AkQ3ztDU7Gnaw4S
	7Pkm6kMkVld+Exj/k5zRaA42cAIVaoTXVhgszvgCJqPTfYpNBkCDQoJ4P5NTOKeJK6BMmOreZ8e
	3q+ygO4YJIIac+/wvL/gHTNVlk6coH4OHlLte+vpe0DTI5eO0lCuolmxjMgCduwV6llcFIOHMyy
	j/m8q4n8x5WdOGYAhOT8lLd7IWtQWBQsfUGcNGZDE7bj358/scAMIK7dLsAZesSuqypCUmF9Ta8
	iUZVUMx8wVYINsX+MI/LZipqBCtm28jeXXRVOUiTeste4aaqYvTOnnH0U0VWinI/7v4xLrarlm9
	u+AyQbW+9eBSfrx1GHndqn/LzEQmhgqRTAX7I0O9cb3INVEteGEyBQfA==
X-Received: by 2002:a05:6a21:4a81:b0:3c3:8298:da0c with SMTP id adf61e73a8af0-3c3ad972c12mr22065654637.41.1784652158424;
        Tue, 21 Jul 2026 09:42:38 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1c7ff4sm447487eec.27.2026.07.21.09.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:42:38 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: colyli@fygo.io
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v7 1/2] badblocks: fix in-place round_up/round_down usage bug
Date: Tue, 21 Jul 2026 22:10:23 +0530
Message-ID: <20260721164027.637078-2-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721164027.637078-1-adhikari.resume@gmail.com>
References: <20260709131904.596684-3-adhikari.resume@gmail.com>
 <20260721164027.637078-1-adhikari.resume@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rounddown() and roundup() do not modify their first argument in
place; they return the rounded value. _badblocks_set(),
_badblocks_clear() and badblocks_check() were calling them as
bare statements and discarding the result, so 's' (and 'next'/
'target') were never actually rounded. Depending on the caller's
alignment this can leave 'sectors' unchanged or, in the reported
case, produce a range whose end never advances, causing
_badblocks_check()/badblocks_check() to loop with a non-advancing
cursor and stall the CPU (RCU stall) when called through the
nvdimm ioctl path via nvdimm_clear_badblocks_region().

rounddown()/roundup() also do division/modulo on the sector_t
(u64) operand, which requires libgcc helpers (__aeabi_uldivmod,
__umoddi3) that are not linked into the kernel on 32-bit builds,
breaking the build on arm/i386 (reported by kernel test robot).

Switch to round_down()/round_up() (include/linux/math.h), which
are mask-based, assign their result back to the variable being
rounded, and require no 64-bit division, fixing both the
non-rounding bug and the 32-bit build breakage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604301231.IpPh4AiH-lkp@intel.com/
Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
Reviewed-by: Coly Li <colyli@fygo.io>
---
 block/badblocks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index ece64e76fe8..1f786b193fb 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -857,8 +857,8 @@ static bool _badblocks_set(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* round the start down, and the end up */
 		sector_t next = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(next, 1 << bb->shift);
+		s = round_down(s, 1 << bb->shift);
+		next = round_up(next, 1 << bb->shift);
 		sectors = next - s;
 	}
 
@@ -1071,8 +1071,8 @@ static bool _badblocks_clear(struct badblocks *bb, sector_t s, sector_t sectors)
 		 * isn't than to think a block is not bad when it is.
 		 */
 		target = s + sectors;
-		roundup(s, 1 << bb->shift);
-		rounddown(target, 1 << bb->shift);
+		s = round_up(s, 1 << bb->shift);
+		target = round_down(target, 1 << bb->shift);
 		sectors = target - s;
 	}
 
@@ -1307,8 +1307,8 @@ int badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
 		/* round the start down, and the end up */
 		sector_t target = s + sectors;
 
-		rounddown(s, 1 << bb->shift);
-		roundup(target, 1 << bb->shift);
+		s = round_down(s, 1 << bb->shift);
+		target = round_up(target, 1 << bb->shift);
 		sectors = target - s;
 	}
 
-- 
2.43.0

