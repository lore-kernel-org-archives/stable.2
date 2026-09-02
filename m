Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EFA4A9D74
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364945; cv=none; b=GzzI8lLV+X/mixoWWrgHeCFDxbKMD7T6FTXfjmWweBobkBGPROM+XH5hRs5eNvtolfv0lB0zJk3W9d3WjD8HkEtCO/t2duq+/tnlzRDLxrjc61cm4ewwSegkeJmG8kvfjP61NC3i/CfXixsEVfz8Hj4oPVbZwY+e2WROlwURtAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364945; c=relaxed/simple;
	bh=hJMYz/tDWDESYnEK651tCJ0LJplvgwS5n+itwwqAeHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn9C0pzljdFWSemDI9gbs/AOnUKiQaHCD07apnP+zZ1Fr9EosnynTVe2iypCQttu+bKfpopiZcQahZrNWX9Mdg06ndrWeuXR+0HUoh5ZHpnhKIHFEburS5EnZTbLW4QZST1tEGT1IbbrId1p20u99xofMuH0nh8M8XqtFuG94MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PekL3VLn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PekL3VLn"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1679636a91.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788364943; x=1788969743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QyRI5K/D2UL8ohnuHgzhdDNvsAlVZY47bGS7E8xJ6wM=;
        b=PekL3VLnhf+EPJxoqqM15e4rnLZ4eYzFncvZr1rmWc7IYnOeezrlErcSlM6Odses47
         sXmzko6fdsjqzf6JUlCh4MPt5JF2YqNABYwnORipWyRCaADCqJegnX2Xz2IdLv2JnXc+
         gGH17ElF1QICL1uH/+SjoZvTI0CK8eafcnewDhz8ITRlHaRF7jyH7HjS0FX7rLhyy59I
         82Yb9fB/Cv4F9vMIgt+SMErev0NEyDtr6SM6sUk7m0EI6jPybFxm+DCE1tKgE1S74nc5
         Wz4qP9LULS128YK7XlzOQ4nxRxWjyK3c/MZJY7OV6s8RaZBauQGqbGW1hKrUhkkF2jzr
         WtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364943; x=1788969743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QyRI5K/D2UL8ohnuHgzhdDNvsAlVZY47bGS7E8xJ6wM=;
        b=XlbBSXRTY4qPUZjLhxF4QvUeJ0I35wvITPTTPtvWNyYZhBDWXGUz8vtWoymktU07WD
         YPZFRuSwEl5tsy9I1XDOH5711iuHVLR4o5lLeXwk0qh0iTglklMKiaAbNFF9Yedi2pDA
         dgMi8VOpoRhvFZW944ogWL4WB5ahqjBFNKEBISVuYJ7Lywmik4GK5EoIUbtPX9hMuYEL
         mv/HYcPVbJYoASaFp9n6nd4Vcsmmbxn1aJB5Q6bh9sKriX5lTnko9BnwMtOqsqi0DY34
         I8DbarwTguhu6OfFf8Q8tY6r5h9s2lcQHkyUhviRxfCGpaDXtFWl1CLIs5vi+XZOWcwE
         n4bQ==
X-Forwarded-Encrypted: i=1; AKwUvByzlGl26RHJryV1g+mFpQnkKPqVeEYLXtwdua+dqtL5dXiZ6Jdcd4Ol5n4flFccZ5YzVa4ZOsE=@vger.kernel.org
X-Gm-Message-State: AFuF++nE5TgsdYeXaWscOs90A2DE9aDp8CVC559mxF1bp9jzQObK2y0X
	0p44wzV9CMtiMX37oGkc2dVx5/RqAEkF8rt1WcZ4pYo5wElJuIRKlgg=
X-Gm-Gg: AYBFou0R2UWeRqUZql2eYm68Fde1zyKzY+k+u7w+6XUpVz2hD1sklPTKxDOEnpmcdrZ
	b9jBtanXGR4jcqX8J2e6CKXqlnOUvazFURgfUZ8m1QVWAx3KlZj+YiFyQR03ePtFkeh63wFi48F
	VsF9hO0PTUYKjrVk9woNBcC0MTZODgKINwQ9VDnBkEgzNtLG3QnADR0Cp21FWp4WrCYr2uyO73S
	hSkort8+3jS/GkC4QEtjTjDlAWMJo36yp892UcN6OM8MQvkRmgG7NtQfj8jcSeMmXhzsvYp86kd
	+h1zlEL6A8N2e31TCMVQ7HCKUaKadNbLmbLpj8MTiQMjMpiESPBq2OunH/vlCpKPkM9b3wBcf/y
	JnHwZEgHUGtkUkZpRoqN82jqhT2lkQW/Enl79jbRAV8DYBVnSnDaxyEWE9m4DnzrzADDy/XOIQW
	rULeH9zn8WyOj04CJqGFTISeoMihJmePeHPoFQw3EbJVVZz5XNUY1hnoIlJvmXs8dX4hw2gb7K4
	O41XnC+2YbiU086HoRLRabq5euhyCGexOsys/T/
X-Received: by 2002:a17:90b:1c87:b0:396:5fce:8e24 with SMTP id 98e67ed59e1d1-39aedf1aee8mr6992785a91.4.1788364942843;
        Wed, 02 Sep 2026 09:02:22 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b7bd00sm7327447eec.14.2026.09.02.09.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:02:22 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: axboe@kernel.dk
Cc: colyli@fygo.io,
	gregkh@linuxfoundation.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v7 1/2] badblocks: fix in-place round_up/round_down usage bug
Date: Wed,  2 Sep 2026 21:32:05 +0530
Message-ID: <20260902160206.322319-2-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902160206.322319-1-adhikari.resume@gmail.com>
References: <20260902160206.322319-1-adhikari.resume@gmail.com>
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
