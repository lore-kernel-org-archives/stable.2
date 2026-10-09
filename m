Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712F3CD8B8
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579916; cv=none; b=T0KsObK+De2a82LdVxebca9Hiu0bXmISHS69II/20Ic8JZ2cNEMQtBV3mfiHMHe0RB9rq9xVLct5GbdWGjrNBQbvYEVP9PBVzlAYiYlZ28/CL9OEUdgjWZAQBH1C9e83SBClQEgaMJB+n9Sbqfwh4lEilV7zgFw6Q6d79+N6DWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579916; c=relaxed/simple;
	bh=+Nu025yH/RvvFjIsxob/PaiiM4yn9tn386mu+W7ZgwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQ/YZeyWZdb+POuIHiqIVbZjSeydIQ+8pV1/qMWLl2TUTnsmaLWLE11mMBAkUiTbKbOt5toHj4m4zdvbNOncqkvbOxjUEAmowASL25mlvSNFc2hYpMkOaf0xJ3UBZBtR8cvf0z8eW/TtgwGD3ffnlaJvf0QdWjES8I4GLXpZ3ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dk6HjfM9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk6HjfM9"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2dc63f8d8aso47059866b.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791579908; x=1792184708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/XlIPI97fbGdQAADLsaTAsOTEojxnbbvXQ30uj6lYg=;
        b=dk6HjfM9+LgAu1Z+5GzZH55S3NB7h0qsM17iUVgFToT2OdFU6DYA/t8fhbs8w5p/c5
         NTsxMB7Uz0IivH52PegUhYJEUZ9XGklPv8hVOAEPepFHnGH8FKOLjx0Jkdr0F8xeKehJ
         1RlWpu+tFw4EktFqvmQHacLpDGdDSagKLEz5520BUGvXSsUOJ6sRVbfftoK6mqWNfmZQ
         THPhFoHryfsbyF7FuX7ZJhm8RoZygvXnkwiRZt3GLtCzRI8/+E/ZqyzIYQjOhWYsYQq+
         3wt5NUaWWv7laNSxc3cVoQfl9C0+8+vhYBnX607ezGneB6HyOsOAY/+SG5Zide8ql4V7
         mrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791579908; x=1792184708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/XlIPI97fbGdQAADLsaTAsOTEojxnbbvXQ30uj6lYg=;
        b=lIqELdMmRYcPeZPKi/5wJr2w3yOzLTsrJosD/oJXs3Tg0pBxxXWz8n+M4G8J0e5h1f
         0EkOTBkQTa/gMWPuHXaiu8Orx5a2y706F7TZ0l1dMBSRV5YvAwdm9VH1cbpYd0gfHCj4
         ArA9veaC7LTyB+xZMg8aA88V7xOEhgziK4Fi+/+fIYgsLKmGSVwMiLJNYtqS1doZxUIG
         T2h3+oMmw1pslwLI4tbWS37V5+Zcu7C0TvF17iMhXGs9j4lWNmu5F8487odKWITJ31/Z
         rwX28vlN1NEiIeKhEIy/35m+Lu40d5Pchx4bsqgkCzPZgs56Fdif2lswVJjjinBTLQlI
         OFTg==
X-Forwarded-Encrypted: i=1; AKwUvBy/PMSiaWXicEuhW5oDUypa12j6cBao05qbB+/Pl0JnLXkM+Sttd0kH4TNw9bGBQwytQ4smTOY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ7mtWJFR4ZT39izYvAN3KNJl9vUUaqtfv8xQq0W0ADa8IMLgN
	UiwM0ihkFwIKSGP+sYdI2GEGuwaFh8TDIYGh3Fx0ogtGcdpnF3qcSW+9hdf5WPgJ
X-Gm-Gg: AYBFou1F02872aIZ08CECQZmnM56hE3pqjGnOQEb7qm9qGDLoxop6U1jQaapQFPlGsi
	hm86C+iEDdirfCRISW2opU4tGGz8JmLy4wNsGQYV21usivlEqN7/35RVh1PKAU0bDxmhB3llsRu
	ZKXX00ICdrDkpP2CFQV5V/hEMTRuWtH78CZPK0gIW6Z4qk1PSbt85bZg+KUKMurOyOZlsHfyurS
	YXIzasrSMI7OEorCdPyH8MjQs5GH/fqaMSDvRPEB89aFjZ5GiNEIRHGuvEtjq9eGS/A4ItWIjoK
	A7NE5vxsjLZMeku2ctOFhn5yDYuIWJh5blEEZDZeKF1JHz/+5aV8qKZVQ5HSSLu4Q6LL/BZA9jd
	SGUzXNC12p3Ur+DUSGx2NmrmPt6P9mcRYy5d8qsjvbFrBBafeMeUUd/S3K265bos3TngN7QPq+u
	NZws5dwIdyHAat/Qe0xlmXF/m08wMW8ORmnWWISoHqAxtule5kVWsnMDVedEH9rPbS/i9/zgnJ7
	UmA2IHD8VDvOoBtt3yHJE2kJaoFaql8X8oBQ+uk
X-Received: by 2002:a17:907:c1c:b0:c2e:1f89:df5 with SMTP id a640c23a62f3a-c31aa05b441mr323689466b.29.1791579907647;
        Fri, 09 Oct 2026 14:05:07 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9765d1asm142141266b.8.2026.10.09.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 14:05:07 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4 6/8] alpha: fix the local TLB invalidate in the UP flush_tlb_page()
Date: Fri,  9 Oct 2026 23:03:51 +0200
Message-ID: <20261009210449.971057-7-linmag7@gmail.com>
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

The uniprocessor flush_tlb_page() in asm/tlbflush.h has the same wrong
test as the SMP one: a targeted tbi() is only guaranteed to invalidate
the intended translations when the target mm's context is loaded, but
the gate is current->active_mm, which a lazily borrowed mm also
satisfies.

Test current->mm instead. The else branch it falls to already exists
here, so unlike the SMP side this is the whole fix.
arch/alpha/kernel/smp.c is not built with CONFIG_SMP=n, so this is how
the same defect reaches a uniprocessor, where the flusher kworker
necessarily shares the only CPU with the writer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Message-ID: <20260923074903.862898-6-linmag7@gmail.com>
---
 arch/alpha/include/asm/tlbflush.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/tlbflush.h b/arch/alpha/include/asm/tlbflush.h
index 0c8529997f54..9ae1902faf8e 100644
--- a/arch/alpha/include/asm/tlbflush.h
+++ b/arch/alpha/include/asm/tlbflush.h
@@ -87,7 +87,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	if (mm == current->active_mm)
+	/* A targeted tbi() needs a thread of MM to be current.  */
+	if (mm == current->mm)
 		flush_tlb_current_page(mm, vma, addr);
 	else
 		flush_tlb_other(mm);
-- 
2.43.0

