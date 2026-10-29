Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311900;
	b=QwC8z4cn2bF7aLr4IGdQXQSRq0h01/gT0419ipgR+ReuNFPNpzKQuM/i4SwlmvmApX89
	 YZeme9NbPTm/0oNjW+DJ3RJ0CimfLRqcXE8avojziGHbxeiiqZGv7TuZKmU1DcnxJ17i7
	 RaxWJmuYokHTeWIGjKLqWgTvdu8aJzXdPNN9CLTcpEX98xxuUtiURVIU+u40IKyamJW+D
	 iTAioLo1DYuMnn7uCxudce875dX0K6GeL/WcSz4+29H4rUqugFPD2Z8H+9CZymDzT6BoB
	 SWRHWHLd97yvKrZTylBN+quFpEQNuTsSKk46cYJajGnBrFzfnn/muSfDtXPwSNUEKjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5jNtZbHxCXS7Amya3dC3EE3s6XNWDFBG2KE54hDksKQ=;
	b=1AY060R4hns6dB5Ms/cKIj5b1dHpPAF1e9SrNlHloN794zL5U4r7tBMfWvnbvfjGTH6k
	 dS6/mJXc+Gl8cH3NPfQbB5vg1UxNWylVbD70xamxbEo66X/uhJDUNk52W2CqCUU2qINYO
	 oQ9jUTfkugbBuY2+6wFVQpWGrWYA8R6OVkbiXULJxaG3EdhMqS/eFxt2O8X4TfhlkL1Py
	 5imodr4yBKWBQX2ukDbpY0bdp51ywX7p+1gUiWU5faUIicEIW6Ow92uWLWIH9DaF08Yvr
	 1xiakJmY8eIHd+oeS6r2ZqyqJ3O/+ifl0GRwYoJFOz8Giow/nH76xUfmPycyIRoQQFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JoZdQbsF;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B77606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 22:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26B77606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JoZdQbsF
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso438395e9.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311898; x=1793916698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5jNtZbHxCXS7Amya3dC3EE3s6XNWDFBG2KE54hDksKQ=;
        b=JoZdQbsFVWPXIont+c9qQKJKUugHbIIPKhgkwvBEeX1Nrf1kAPMM01K3WqnfJfFwv6
         syCiNUQV6b4DoGN2IcVUiCe4uPUuCZtMejWSVcZH01CGV2nMY3fAI6LHuJTMva71O+nu
         DPMEXHTLobv6RcZuqJ8+UE4PhEectz/1LncuIXpwIxzexKN3EV32aWzq9X+reDQSMIPP
         AwJRc8Vv42P4Zewsst/0OHNwogxY1e5rDTQ3ZgX8tpjVRIhL/+4czp8Elh/Uz0o+R6J6
         Fz0i8E7ouEoc2GK8Rzm7FNpRNzKALZHZyuEP8BHrJXgdJdG4HoS8w936F2H4LAzZ450O
         +16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311898; x=1793916698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5jNtZbHxCXS7Amya3dC3EE3s6XNWDFBG2KE54hDksKQ=;
        b=iMnj6v4SdWpV8ynLqbWcx7Poi4ilt2PeMKPjbaDFHD/2qpjZRwDNz4XuAox03tchpB
         bHUC0ScbgTvu7wZz/ta4daCWGAMmtuRXjfJA3mvBSIRJwaH/aGWgbstQSYOHKVol01Ba
         dVXTUo87wU4KUFPjfuon+Km72Y07ElK8AcT7Bb0UHWrEJlxgrJJpTxambjKs5/nmVtr9
         BIfNjK4JNuom7rpPGA4ju40gESRqcEh3ie7DNuuBB2G4WH8mtNHShthMID92IQX9tH7Z
         aLeoJXP0vvmuFGwUv4fU+yBjAQjxogQnJqcTixxkiiZJ9jnWZybgIwPviUlfLPorIOCy
         7dnw==
X-Forwarded-Encrypted: i=1; AKwUvByXpYYBrskJWZ2EjWoTjyuwbgCY54fzLWFegJLHGPD38+CbJis3rMXmGS1e9oRq47gLFA0Ugaw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpBlMt3FgcN9PKpBmME9yyIu0k6LcoNHWB/dhjTfGFgrhcgqjH
	6zKay080p4ggGLCmQtB3wRXC6iuhGinlg7ifdgEBXzV7dmAPNwwYrPDN
X-Gm-Gg: AYBFou3IMxEI1GhzErE0SiAmukc2VFLZxmDlQj8EfqiB9TwH4CXzP0j7sQe/TCJnUwT
	c/DmVf1ZGjQApqpftwzis33nZO12W+1Kpo/XNAEyYm4B7ZGK9C9DW7Sf/yS4E0FYcGfOBjjokTd
	+1/0bwnJPz+OGlN3fQb2m9uUGqzl8JTMTPjP3lXfdcJgjO5EyLUPPWs4gSqvb2Am+OR1GcloDu2
	moOwI9XKGO34gBcQCLcaxsHRtH83ZbcwNLCNL2NdRZD2coBbDgzIzaFtKC7tk/sIxvpjCflonX2
	WuYsbEv8KEn2QyqgotPiCDK7ysQj9jMVyEzCuxr3ghzE4hIhyW+LEBhoddIRZk7Gi8FTGZAZtcE
	fGHGZMuYH3mb7vwhiSoQdnSj/+RPEJ8JaGPB3DZC3rVHgEG4xSS48OqYm3RHk7BGsJYC0Nffwma
	IF+NDP4U4K45dIbtWeCHALCeS6YAYBYpSsqj+rP0/RYFtPtG5KwRWu/tS8eS1ZwlzW1jm72pKM6
	/J8yO8LlRL4Lqha4VUGJEC2V4pJojJwazQupeXEMQg+KV0uYXgkJtSYtJtyMIGq6gk0QDVd+bM+
	sPX+caXntBpPtQ==
X-Received: by 2002:a05:600c:46ce:b0:4a6:7d6:821f with SMTP id 5b1f17b1804b1-4ac189928e9mr7162435e9.29.1793311898530;
        Thu, 29 Oct 2026 15:11:38 -0700 (PDT)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81a896fesm104011305e9.10.2026.10.29.15.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:11:38 -0700 (PDT)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/userfaultfd: recheck WP registration in the hugetlb UFFDIO_COPY retry
Date: Thu, 29 Oct 2026 23:11:01 +0100
Message-ID: <20261029221129.89068-2-azpijr@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029221129.89068-1-azpijr@gmail.com>
References: <20261029221129.89068-1-azpijr@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mfill_atomic_hugetlb() drops its locks to copy the source page with page
faults enabled and then looks the VMA up again. The retry doesn't check
that the VMA is still registered for WP, so if the range is re-registered
without WP in that window, a UFFDIO_COPY_MODE_WP copy installs a uffd-wp
PTE in a VMA without VM_UFFD_WP. That is one of the leftover uffd bits
hugetlb_fault() has to tolerate.

The non-hugetlb retry goes through mfill_get_vma() again and fails with
-EINVAL. Do the same check in the hugetlb retry.

Fixes: 6041c6917903 ("mm/hugetlb: take care of UFFDIO_COPY_MODE_WP")
Cc: stable@vger.kernel.org
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 mm/userfaultfd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3b71712edab4..a70ecfc8a998 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -810,6 +810,10 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
 			goto out_unlock_vma;
 
+		/* The range may have been re-registered without WP meanwhile. */
+		if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
+			goto out_unlock_vma;
+
 		/*
 		 * If memory mappings are changing because of non-cooperative
 		 * operation (e.g. mremap) running in parallel, bail out and
-- 
2.55.0

