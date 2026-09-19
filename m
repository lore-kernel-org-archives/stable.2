Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B22D9EED
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789795431; cv=none; b=W+ndrXvyEVcvXiDG0iAMP5vRkgHt2w+LI+4NdtFULZZiAXe+IWn5x7Bsf4i7vFOCZr34wGnGkfvR9uRAST+FQF0oSz0/5sZYfP3K8lZMpKhbz1wiZsVX2w2aIScA+eAHwoNMdWt2QSmlWN9VeuNkXBBifmh21wbf0Yi8++Cnk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789795431; c=relaxed/simple;
	bh=+FitaPU7xxm51lVtdh8ABlftRiy+/s0hAsRKVPTqrv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPTb83TAhvF6nwpB7NoUzBRamDSjI6mctgcYKCb/FbR31iXoUKrxnINDrHVgg+yxbYzjm9ObuOoWhxrlcMjV0+ZFVKVJSop0BZrhkIxWgwwDHXJaGTH21YeQNiwnAo+HsAKh8D9YCmNlRAD5zwf8nx5dJTuvNzpb8LpgWnFBJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUwLoynz; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUwLoynz"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d822dso9905155e9.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 22:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789795428; x=1790400228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+FitaPU7xxm51lVtdh8ABlftRiy+/s0hAsRKVPTqrv4=;
        b=TUwLoynzxSuZQOfoQ/cCY0bTNiugno4GS0wNlIlbyuv+6cdfirtR1yRMtAHrNvLYwD
         WYILXlJNj+M1G+knaDOV5bxlF7LCyg8nu1IZgkALjhLyjQuwVYAhmBiad2fLKthZ4t2+
         2UtAqzv5qcQrb+nVX62MSxs7iZH1pVURyHWkkBgNJTgf0pH2zXU3EEeAqNbgJ4DCMUo/
         WAIv5nfveCI0E9xbd6w0Hjnu/SEVt8X0XCRTND4AZ4f1BT/v/5vfQkBAzxkktMi/ruMf
         7Hz4VMYfnBXBT10iVM6LCSUnuHUUxTDCKztj6sB8SdcLScE+xNdiG4S5RuatH2B2YWRE
         20BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789795428; x=1790400228;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+FitaPU7xxm51lVtdh8ABlftRiy+/s0hAsRKVPTqrv4=;
        b=rQ01B4xYqx42HHxrTnYEq4e27ttaHV0yE/bNxTGHSL6Vn+mynXitYWDFlsY+GpWPpK
         qkML6KePHyz3WNNsBARuHcHuk+WuulNaP1P5IJpBMKaB5hbpfK4N16+3Aq7MRnYfTQ4Q
         hFVwjXmbhWYlR7nq4ZsT4vBOlXqnxITfzR+LH5TC8HSYUcinrSxP4wrbEL4k0ZczDpQG
         09V1uZK/0VewTCcoM+LMDpAKfHliVTMP969CJrQ68/UR8RGUDi4iRIJWpyE6CU4T16jD
         v5N4nGqY4J1qqoaZS2hMLOf0mg2n3HpyLSLwywW1CKFhkveJcWu53H92RcQYUrvqCvcs
         TArQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6Zv4HutGYoC22o7/uDOpz7FyPmLXm6v0eHbv7Aeci4v6vzHvZMbkVHf3QOt8uzKQuQ0HSx1k=@vger.kernel.org
X-Gm-Message-State: AFuF++l2SN5l7tcXD7rmxsTv6xYji+lrgBmweNoqli/qomyOesOzwpjz
	7b2L+lMJYgxcxwEQtkYGGOQg2bmkhFnyfF6OPihViXAm4nxEZnO2FcJH
X-Gm-Gg: AYBFou1pdvHjiZN9gjdR1AIy7TVxyBaSjN7nFY+oL3+nTERG0LtvdR1fuiEyMtPV8wU
	EJT/CjwCXoIUyga9IdVBeQsCOK3sqivUtNvlQ68hQwmU4AqkCet7rdWxjxFsd1yX6noLRy12bNE
	FxPSlhjyeTJMiLPaOAhNSLF0cLA5pHM6mrpPrKP8H2/pX6fNy3vuXubAYHEOlsT2xT3RKhXQq8l
	0RDmanPulqJe8dR4WXFVuRvyMxFDlNWlRFOzJFF5RJ5BevVoLfSnBTXg/4UJWv8ewayjIm6wXwx
	uoLgjVViRty2z5hVQ6mc8msO4obUci7NKSRe6iKN69p5uiJXHTQAhF+zlB8JbxMkwixrN9KMfbD
	Rx0WP2j4ud9DXKWNbQGrkQPNIRnoCeKtzgiP20c2V8koUjw5GpuhUV0ZLi5qBLRvtWhzM9OkAca
	lVUGq4aTc/gJaFOyTIB/J34f5JEWNqV1GWjjPJYCuckqlDgwq2iKphXoT+ZHqIqYUeVqVJHBnzk
	rFcy1Yqs872gG8PnrWJzZhjgNh3IkZlLeEfkgml5AAOPg2Ah9DXZtylLN4UlJ9sOe6+LUD4dS7Z
	K0LLEUAK9GHrt+TbDdAj6uGzexkyM8c9OQ5QwK+r9F2Bzc9vH4TnLliFWb5lvwUC1bwbrGie3Ts
	Ovw77mlP3c/kLGAE=
X-Received: by 2002:a05:600c:8b61:b0:49e:69ff:c6b1 with SMTP id 5b1f17b1804b1-49fc5749edemr69948685e9.31.1789795427940;
        Fri, 18 Sep 2026 22:23:47 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc6ca43edsm109505565e9.0.2026.09.18.22.23.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Sep 2026 22:23:47 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Steve Capper <steve.capper@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ARM: mm: LPAE: Change THP helpers to comply with generic MM semantics
Date: Sat, 19 Sep 2026 07:23:44 +0200
Message-Id: <20260919052344.23653-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260824055938.27594-1-kmehltretter@gmail.com>
References: <20260824055938.27594-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 24 Aug 2026 07:59:38 +0200, I wrote:
> pmd_mkinvalid() clears L_PMD_SECT_VALID from a huge PMD. A PROT_NONE
> huge mapping also lacks that bit. On LPAE, pmd_present() therefore
> reports both entries as non-present even though they still describe a
> huge page.

Friendly ping on this patch.

Adding Anshuman Khandual, David Hildenbrand, Ryan Roberts and Andrew Morton
to Cc for review of the THP helper semantics.

Thanks,
Karl
