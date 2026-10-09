Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7423D0930
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579921; cv=none; b=BXpFflOUB38/HucrvI/ZLCkKaGx/4NTG3hU1U0l2i+qVpG1K9uvK/1PVPkAkelwcqwyf0GZdE6R9oFA/bG920SHfhIaruOgzK6py4BtgxKBTibdpEQtowgmYRrVMHJwd6rZxOBmIfkvWZknHLrBGiGB1EOQyH2vFkNQYwRFuQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579921; c=relaxed/simple;
	bh=5andsTa8guQZkx+SfoPlH+n4TbEPX6cOtCcngDLHNCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdYANVQ8C78zKSJ/kWQngPTt2aT+CZG2R8BIPMIp6wcVHweRpIryoAaongI2XE1YoERm4DntPpONxdxFRGGCp9fAHJJM+k3SlxiEaACeVOSQ2/av8lAxKpEjD2zhWgzMWT1Uwdw5L3s5eKPxjOt+48nqgu/SErUyDT8dY6WDrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a58sNPl2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a58sNPl2"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6aaebeadf3cso219816a12.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791579909; x=1792184709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6x26UZ+wvq3ZWV1vplJdUFrejcdIKhR4wACBzfYHUKk=;
        b=a58sNPl2kqpxmxXEvJoV8cXSH59JQ8QYsEi9aAbEmUFgoRtXROcL94ikEONSO+Z/Tx
         pZGGKd5gBzTKATrDSC/YlSFLsGTeRLRJXHjSdDEtMoWLfG7Lb3+KArWAVUWzBgT09h14
         c9wYRv4INcl0BQqoLxTmJuBegjY+4Oo7jb5JiSFfWQ0uzcSr3lxUAvS+8dL+afflwqkz
         D9qQ5/DcKhyUyVhcZEUMn0SPNxYWojaUKSaPckVFv7Kj+X6xDtpg/vymMijvm+rVT+gy
         uVXfytF7nMQ4qoe5HSjVUbvCulWxuOx++FQnwJ0yi2TTdDcov8dL44XE4ae8X3p5nOQQ
         8x/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579909; x=1792184709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6x26UZ+wvq3ZWV1vplJdUFrejcdIKhR4wACBzfYHUKk=;
        b=fkpYgsOUrwnF1mruwIe1iRhAxAsDIzJwWRAKYqb/iuSdhUkzWpMC5J2XY0Q+f8KkDc
         +XWpyaADJxJwHKsIqrFIxDKvXzVCoQNSGZJcYTp4zikW2EWVkf2K2v2RmVpcby6fpgF/
         hUOWGwI0dlriGw0Oox6JW4wyUa2706Kw6DDSJptfR7XEAcYCA957cFumzaPp75r3zk3I
         rV4QurQbUK6B7gTainkaamiPD4AHny75ggYf0xJY9YEx2+pYY4VbCCQPLE3PAWWKRo3q
         y9FiG8oj4hLF2Jmzi2NotHuZgtUYYl728m4QdY6Deo2Nfj6eQm8EQ2BwRS9VurZ0uCML
         m84g==
X-Forwarded-Encrypted: i=1; AKwUvByyXd9rJ7IeqFiJVEtr3CrbU2jGM8ZQACVYnDXl3Vdfqstyu+D6ZsDn3SWZq8K3oc6l8+YlyyY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEen6T7GuJbKxrkt5KXQ09MhLbd/MLTo9FejpzGrUGVDNYhiC9
	PGDz1Nupkp7Z+2iRvZAjsSE3/7ROsWn6keRi+iUEGBwDWIp1Gp1LIGNv
X-Gm-Gg: AYBFou0ZweOZ2qaGvBR/LBrPTerER+c1f2gNtWyQ/omnLCInSbIUyVIX94wL8+JkFGs
	P66tPFbOAaHdqSfb4+CacrC2X/M3rgufF/mq5L3hdBsThwOPsaGjO183ysuR+LOjijiOKHGEdRz
	TSXAUtXFnJt0KVwdmGZ+5P7Atyhgc6v+ZUJAHqsp0OfcyNj9gtE83TVRdAH2f9KLoMbtSzPEJUE
	TuNr/FBtTG329hv5yP5LAW6i/y/pA0kSGHFZjfT2lHtvcIoIBLAI03e3Si1qncdY2SS8M8sVcFK
	BQ6ATkLCWmka2dN/bAWu5hTO/Oze6n4CIghaqTAj1oaNygS5njvNfRYQ68FAwacqXFnaFozRElF
	xriOfdVYq9d43tKVb451rGLcmEtKMTfvfZfrSjxUt6wegrSfqORStoxAwnsoYK5syFqvpSd144s
	6OQ0kXjIslR5lDl79g9jkcM2lxXknpnq/2YuDdn1B9olXkEEcZINyL4AOjrPFi+DbveXwOIYPA+
	+9Ut25DVkObNZ/X5LDd8FJvy6i9p0ePGzAA9ygW
X-Received: by 2002:a17:907:6d17:b0:c26:1648:a069 with SMTP id a640c23a62f3a-c31aa08e576mr337775966b.36.1791579908651;
        Fri, 09 Oct 2026 14:05:08 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9765d1asm142141266b.8.2026.10.09.14.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:05:08 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 7/8] alpha: invalidate the local context in flush_tlb_mm()
Date: Fri,  9 Oct 2026 23:03:52 +0200
Message-ID: <20261009210449.971057-8-linmag7@gmail.com>
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

flush_tlb_mm() has the same caller-CPU omission that was fixed in
flush_tlb_page(): when the target mm is not the calling CPU's active_mm
nothing happens locally, and smp_call_function() handles only the other
CPUs, so this CPU may later reuse the old ASN together with the
translations it still holds.

The active_mm test itself is left alone here. That path calls
flush_tlb_current(), which loads a fresh context through
__load_new_mm_context() rather than issuing a targeted tbi() against
whatever ASN happens to be loaded, so it does not depend on which context
is current.

The uniprocessor implementation in asm/tlbflush.h already has the missing
branch. Counted over a fork-heavy run, flush_tlb_mm() was entered with the
mm not this CPU's active_mm 2934 times, and 632 times while otherwise idle.

The proposed Alpha hugetlb support routes hugetlb invalidations through
flush_tlb_range(), which calls this function. Unmapping or migrating a
hugetlb folio from another context will also need this local invalidate.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Message-ID: <20260923074903.862898-7-linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index a5a42ae4a7d8..988e397b0b8a 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -649,6 +649,9 @@ flush_tlb_mm(struct mm_struct *mm)
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	smp_call_function(ipi_flush_tlb_mm, mm, 1);
-- 
2.43.0

