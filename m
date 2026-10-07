Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2C3C3F75
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390840; cv=none; b=SeVZ/2iq9/zslLnVABFGOCpFYuI950sMztHlIQ8DzsNuLGnSZ7B7BOczwHMy1FxOy7YdThiHEgokqEZ8MwOsQ389NQHm5PuN0tklRHw9wJmzI3Ga4wqEN2YfEuA6JXPZX+yOmL3l5IqztvqQk9N0hRU4+Az8dca05YSaj6w5ZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390840; c=relaxed/simple;
	bh=7evDrsn33ZOZyzUJ4PxA3QjtwQoT19qOjju1qVoOdc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUDemi0f+3ZFrUfzVdi6YuRBpivJoUX3zlD25pHjuBd/pgC3tQa0hIk/p7ak+G7bheb+5v8QBwl+IhghUeqdY63VrLOlfIoeD1ee5YCt1URZvLaGOtg/KIHo1oUbdG/4JV/RtvLNapAUp769qKC/sAI0C5SoJyNh8J+1xnVB6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oga+ACWQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oga+ACWQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so27346455e9.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791390837; x=1791995637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7evDrsn33ZOZyzUJ4PxA3QjtwQoT19qOjju1qVoOdc0=;
        b=Oga+ACWQ80glITGJf9Syxbn629N1NR8aWMjJTZz67vau6xa7Dwi6W+8Sepz4G59NLh
         02kMBmhByo9EIIBpNGwxzSZ5OxGq+nxCwZ81dtNC5+4f47+6pMvjpKMFkeeAtjir+Jb+
         Qpg/bLANel154jR3mIkcCZeaZkppiE3/7m+EpQspgi9E5+aNO1Ct/sU9zmbUrpETNkvm
         5QIKxGzDdR8hLTTY7IIoNec6JF7JIe9qWyOFmzbWRbqfz75OwU2W5L/NCWyiSZcymRoV
         KlbdXF6yUfa7hbExAVC0chlXI+GW5kzLDcmACVk44Di7DJEkbKWE77DODevJlPWwVFSF
         fVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791390837; x=1791995637;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7evDrsn33ZOZyzUJ4PxA3QjtwQoT19qOjju1qVoOdc0=;
        b=et9lUTYPVix5h119VLsBVOTpOq0XP/sCAa6hN6seF+ij3iUdIMqPTxw+T2mHCOgL0l
         k6Miz6LFkIDBXIGbMql38l/TB5yRc8Rb6t7NgK6n/Z89fRV/7ZEbFKpqd2ybHj1vIqFz
         43ORxunqQHmg5Wabp0+FhNY5B4zm8n8ueF2TPVgzs8d2oSueoN9jpv7lCz8DHXfHhXsK
         2PhV+8DHjmeaLH/yCquzlOkCc8mQpxd6iDNjVLz/7UYsAegKs+GGvwMm4sONNeGeKTTf
         N84CFq4BOhN0xvZVfeFz2sUIGhi83rtu4gBAcNAeF2Vo4IdVzEL96FP39X10iSqcm00P
         CBXA==
X-Forwarded-Encrypted: i=1; AKwUvBx79oEkYZjzis7Dk1tXaG/67iPosTmFaJpjm/uj4pmsTqsnas0hNDTKgTuZ0IGqkrFR0Ihpd8M=@vger.kernel.org
X-Gm-Message-State: AFuF++lchQc5gN1WStUWzzM9DbBYEupqm9nFa5r7EeteUwRD8nkepEPU
	6fYJ4GUpEl8siwlx7Tv3jdfjJfmn6OuQj6AarOr7QOJd7Ik5xEvix0U=
X-Gm-Gg: AYBFou33MTplDVUlcCUf92UOk5cob8qUFXbWF7c/n28ncKalW5ynbnCU9sPiqkXWSkq
	syP96LTUa1ayFY2JQ5Yl6JSmdw2l0NH8rt+vqHUGISHTssr9VJZnVRLLnZgCYuZwKAVOXnCmcgH
	1ft2sUW8HueOfzZcuhWmFqwM8KAWusRNaWh8HzlnG1M89aOblm0U8VO1P4Pci+J7doP+tUxCzID
	T2wbxQ1XiNwpZJ0PXlywBOXNX0qtkAD/k7iy8ThsPAakvexyazxBH/K0jvZKS5XxvnuZ9YEP0f1
	jud3cH1n1/uJ0A9MVXlYCssOJaPFPAr2OigMyTpGlU9jsExAgmjQvkrLW+Pqd+chekTSq9imF2l
	E2IArvUEJMUwiFfF7ejB/EwpZnOZJCC8CpNrOY/BjKFr5h2g0oYgjYG8Z13iLRWkb5Xw9Fg6IHI
	Gw/6ncdxRdeeKbm2oCpqoaFb8A/yw7TOFiDwDvn+i0i0qGU5yBkg==
X-Received: by 2002:a05:600c:1551:b0:4a1:7733:5102 with SMTP id 5b1f17b1804b1-4a180443559mr44304695e9.15.1791390837363;
        Wed, 07 Oct 2026 09:33:57 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71c0b860sm5647218f8f.11.2026.10.07.09.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:33:56 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] RDMA/rxe: copy completer WQE to kernel buffer before processing
Date: Wed,  7 Oct 2026 16:33:55 +0000
Message-ID: <20261007163356.407937-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830191344.2026524-1-tristmd@gmail.com>
References: <20260830191344.2026524-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Zhu Yanjun,

Gentle ping on this v2 series. The v2 addresses your review feedback
from v1 — bulk memcpy() writebacks were replaced with targeted
WRITE_ONCE() for individual fields and smp_store_release() for state
transitions.

Would you have a chance to take another look?

Thanks,
Tristan
