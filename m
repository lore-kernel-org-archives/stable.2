Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA493D565D
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579911; cv=none; b=tL6dN64Pva2ExTWZ8R5LiA1S+bEz2qNmok+2yACm9rO9SAaUul9PuQMQ9wae7G7TTbqhdy8DF8PO6TQ2O5TMx80wLOxGIEvH3Ybu7T11i8ZJ7XnEc/0GfKaB2kzpaplZ24PiIOVRFgY5WbZ2QPn4lhBJNb9ea7Sxll5J4875R60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579911; c=relaxed/simple;
	bh=nHn0HkfqTbiMd61zpNP0ycTKcDNOwfgaeRH9NwPUJCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRb/jrcuhb5pLSysOZB/HdUKy+0nd2Z+1sxsNevFkLnb9BB4r79DICHkFdxXkrbks6OykL7yk5NLcSx7CiVIJ/jAZyQE8Zdk95E1999KD36QDVyrdXjHhZRBU8yrw2YHTueE+yGpeHiIcZZ+rF0eq3iuSyVndGqwVFUTCX6P9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbcM5VG1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbcM5VG1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e40d62e77so27028766b.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791579905; x=1792184705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJkUJzSF2t27pvsqhrx6jHTfwNy+aaqYO7t+PVIi7Ik=;
        b=dbcM5VG1xC0eIV5BMnnW6s6qm+93GfAEZYAru6BfhE3by5vqRAZg1hWiRZv6dYBXqf
         mbuK2/+E6f6JYZ4LUjeI2xCmRjOLJw6Qb+KvvsS/VNyTsmfGn/hhuMjDgyKYhtRIcQCN
         xZfiGGZ+rqCgTQ92H0deEPPeykY4uNb0CgpYxmXplrysm+1MQCHuXMluI5D6QValFxmp
         puz2rlU6Lq1CVIpbVMFo5zVlTj0pSVFO5WOg/zGs8NNOVPLkKkV64VZ36ycVLiCof+De
         9vpiLockrLI++GdWSY/oT6i8EH0QO7PmbIw1xWSs3Z0L/nXBa+eZP3f6QaZnSU1t5sCw
         k9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579905; x=1792184705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YJkUJzSF2t27pvsqhrx6jHTfwNy+aaqYO7t+PVIi7Ik=;
        b=iw0zbXC4jN6y6ezID4TWa8WIgjOwTDXoLcnDACttgYhfhVGhst+VfgdJfaAwZ1TFnX
         h3sa6SwXx6tjxADzVPuZcr7tbvbXwUycYTydTivkeyl47B/axrllF4r2jSKbq3Wwn7EH
         MbJLSTuxfUPRLl5otRDmxNFlAWwJWg+qnbZWZ/4TT+h8X5HaHERseQKieMBXsDRgk8W9
         fFXVn3NTgdsxOQlXvauwHQG6SB+ktrL3VnMPVHqFcMVrog9L/KWlMcc3rOb1ZNUo5b+H
         A1ACXwNv55w/903oNk2RFt9YbkrnNfU2K5L3UVXCrtRwm1O0kibp7/Eq31dWFqsbBJOW
         ps4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwpT7dhuGRkfo6cTgTZ3aG8A182nUdXkUGoh+P/EqLfmkWCgW5ZmEuhvk/0ljuh2GYTmmJ6EVA=@vger.kernel.org
X-Gm-Message-State: AFq9FYItuRZPePG4YyGfWsPQlAqxBdhwCRKu3sCx3CzTuJyInAhMpbBa
	2sqPXMAwgZWn6IBVe516Xx5Aeavs7CBP5IH+9sZrjGu4WbvamAq6AVbg
X-Gm-Gg: AYBFou37Eds/0PSBxCqQR1k90qIU42EGUXWuPEHr0DLAB4m4o/SXTrBhRoBAjQR8oNk
	5L0VS7qGyQeA1iPDfhUjX9EkKYU0wtOz7odYIR0HlqMMzOm/L0jFUhp8sq+i6oR40Rv9lJK4oPv
	PENFO1xi3Bbam9JdlglNW9DwJbNBUjIMmLTkV/6Wtbk3aknwa3dL+RYIacCdWemUoHgC+hsqWyw
	1TCDOIwKaCSJY7WTY0GNV2zqT0RAWIRW7memYWEmZD8rITtQDTWvPig/NXdgM6Mqj11ctN8+r1U
	E6dwOGaxJcCl4ezvcCZ8gTokrBUxxCFZ7XmBB14jT1SjINEQ6iyJ1gGlXTVXqrfBjMTIvWmd+cB
	qKmVy66AevgbSU3hyoxMi0l+NLkx7MylyPA9W+Nj2K6yVSC+8FXbAHYV7uOGKCDTRIx/8UoQY5r
	3VF1cal13LY/v0JzKD51FzIdYsS6F8a8OYL050tvEzrXWdtsgS6kgh9gCORNoRzarflJxe/YcbD
	ekaKe4q00/wgqmhdwNVyKQWTruI/kSZXxllAjpk2akQE9sRi80=
X-Received: by 2002:a17:906:f586:b0:c29:6de8:d143 with SMTP id a640c23a62f3a-c31aa00dd05mr330212566b.19.1791579905479;
        Fri, 09 Oct 2026 14:05:05 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9765d1asm142141266b.8.2026.10.09.14.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:05:05 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 4/8] alpha: invalidate the local context in flush_tlb_page()
Date: Fri,  9 Oct 2026 23:03:49 +0200
Message-ID: <20261009210449.971057-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009210449.971057-1-linmag7@gmail.com>
References: <20261009210449.971057-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the target mm is not the calling CPU's active_mm, flush_tlb_page()
does nothing locally, and smp_call_function() reaches only the other CPUs.
This CPU may still
hold translations for the mm and can later reuse the old ASN together with
them.

Add the missing else branch. flush_tlb_other() clears mm->context[cpu] so
a fresh ASN is taken at the next switch. Add this before changing the
current->active_mm test to current->mm: that change will also send lazy
callers here, so their local invalidate must already be in place.

The uniprocessor implementations of flush_tlb_mm() and
flush_icache_user_page() in asm/tlbflush.h and asm/cacheflush.h already
contain exactly this branch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Message-ID: <20260923074903.862898-5-linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 1ad448105201..e4ba0aab8a66 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -697,6 +697,9 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	data.vma = vma;
-- 
2.43.0

