Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041D2443AA5
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390826; cv=none; b=ffo/sC/3lfIs8K4sZVk8JDqSIDePV1NIhp22tk7ac+hGx1RVgR2/s6afgAqfl72H268dydLPb4x6HNJorEpe9dPf73ikI+b6C3tYBIX/VEXoRH0ZxXygAPmtHkbIf2CGnKI8k6PSCeYem6cBhJSz2GqBOr1gmCK1176sGcdiTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390826; c=relaxed/simple;
	bh=SPL4waYZ68I07oMi9zqix6oLnOBZXLRhkO7049FeIOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6OCTPHc0biJppKv+g8zEpY9Z1nB4wpWWA2d9wxHCM2FjIExfFchJwLsKy+NoPoc63ZIxuM9M1Pncp9hKBc7cCvp6tEdcj68TOSaRCVD/dVxbbRG1+Q/cDZVOXYPTnQIcNpF+OucN9LNSzqmGW0l5lZ84rsKkc4kfAqfBuTq9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhCqFi6U; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhCqFi6U"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c167aa9500dso2930266b.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390817; x=1786995617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPXRarnAO1rxE2tnGzCY8f31rq9Ep14HorPF8zSq0IU=;
        b=OhCqFi6UtJdECMQe/r3cWXui8d7fzyM7NFq1YW3hBuE8bPwf3PA72L47soGZa6xj6p
         7xC/gxrRJAtKZb+5mYJZrPEi9KUVuzc+/YpJM2n1oWlEkw2dzKIEoraygiETm0oi0v/S
         lS6MCWZUNGrHp/3X1Hb4JCi0ZTbzdrNfo0jNTLRhefGbtEJFQpX+6LtL3m9ZTzEpqch7
         buqCzIzbfv4h/1P1Kar/R1LBAKdVdAcnxs+lPKt6748TkGC98o2NnjW5ygnp/BvCXbqU
         vZFccBXWCKmnHTzW6cvFvqJ9tH+b6drCRqIvdgc6wW9LYA5Uj0FgTsNcP9C4TVkUaCg+
         CqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390817; x=1786995617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cPXRarnAO1rxE2tnGzCY8f31rq9Ep14HorPF8zSq0IU=;
        b=Mpe1PrAhXd4APeOlJncSgpluZyOye/aQKXfBJ9JcephJt00YeYgj+uzDHgsF17lIft
         XUds8grYAit7XTw88w1zqvN1lr6t0TD+7I9lzT9TZXzWtCulgNysvuOuSm7ZD6nN4KwS
         vOKccMAF6M45OuM2IpCgUgA/X2QDyoDeeSkRG5Vu7DP2Dfj/LG02xUSVNdlVuYyRhpM3
         MjB03Lt6yk714FumoccI0fvxeo9mkOuluDMTHKJf0m0KqDcKOH47nC4B3rRweHlwPOre
         hUA3aLcNiOzIs6Pdw16CnuDxXvArKGAXDdATWnkHfb241TFIJGClk01uBSQsSewhF3Ev
         Ioig==
X-Forwarded-Encrypted: i=1; AHgh+RoQpqvguA25X4ENa7NvNDBvuNopyGuN1MB3jwa+VERCi9704BoKSlTif9sFRMtqLh8UY4/R5Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4497F2Utyw5UcJ8aqHDvlelc8uOLAXgRZfHA9f03Uo57iS74
	br86lA+Xwx0SGnqkK3rAHF+XGLC4SNJ/wua222ri9MfTkbJX3xUeADzR
X-Gm-Gg: AR+sD11mXqqcIsSfukEd7eS0qK8ecaCT2z7zin6Wa2XN52vfkoCaqqXorL5wM17BwDj
	46SEjuQGPdSNByasMRBQjkE97hZYVDVTYSZdPxJYnvc3xjjE0h4jnyicNSLPvsimYApzhAejSdO
	r7qJrxgLDOe1XEO3G2zWEMInYr0feT7xAJT1tATEeD8EW09gsNV2eyiasO6R1svXGcrjjZe5QCX
	H09OeUCzsX8zJVLWpvkfHIfpvNXuoPodIzwR5LJVSuVPbKXodS7Erb31XnyWmIO5tsZAmDHTiVL
	lVnwTkgFpElQvEZr7wNMWnXOcGDyfzIV/+1H+Lpk814wwKNJzeAW3G+7AAumz5/pCUMCBDz8zdK
	1tsFW6kOCzHSvSXgb/rBfdi0cHEJPAAuyP/wzs68UEwKMskpuYbYsxC5szmw84GK7FsmXO6Sbl4
	GtEwiZMtLVfqX8kw5SePxFX+WJZzOLGTnXLvXCeRKB0cb1SBvM5/w/Fd1piyeYkfF50vl9ocnr1
	jgC3MBhTVcx4luC39LN/DaWmaD50KI=
X-Received: by 2002:a17:907:3f05:b0:c1a:5d49:f99d with SMTP id a640c23a62f3a-c2039c03342mr1839607366b.7.1786390817019;
        Mon, 10 Aug 2026 12:40:17 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a84sm449928966b.3.2026.08.10.12.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:40:16 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	macro@orcam.me.uk,
	Magnus Lindholm <linmag7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/7] alpha: invalidate the local context in flush_tlb_page()
Date: Mon, 10 Aug 2026 21:34:55 +0200
Message-ID: <20260810193902.3286353-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193902.3286353-1-linmag7@gmail.com>
References: <20260810193902.3286353-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the target mm is not current, flush_tlb_page() does nothing locally,
and smp_call_function() reaches only the other CPUs. This CPU may still
hold translations for the mm and can later reuse the old ASN together with
them.

Add the missing else branch. flush_tlb_other() clears mm->context[cpu] so
a fresh ASN is taken at the next switch.  With the previous patch this also
covers a lazily borrowed mm, which no longer takes the targeted path.

The uniprocessor implementations of flush_tlb_mm() and
flush_icache_user_page() in asm/tlbflush.h and asm/cacheflush.h already
contain exactly this branch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 7856d23b3384..a5a42ae4a7d8 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -698,6 +698,9 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	data.vma = vma;
-- 
2.53.0

