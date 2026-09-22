Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE9544890
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080887; cv=none; b=DxRGKrA7wblJFkjnUQ+IIttbZI/h7MM7c4oyvVf09+yZuGmmyP/tOAZ3RM59r1llzg39TZCpcbnGzClLTIQWtB8gcFGM8k5WhQ9g+seluwUTyRrdnnzUxBBfZ7HUDMEqbRV6dJdSXIvVUoy0vlzDwsjZqJqcS9wwrsuUqcPMayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080887; c=relaxed/simple;
	bh=QZXui/sNrmgEF8EYt9qJR72fsL3JvuFjYWH/NetcEM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFfjwq0tSvphV1h8wsbiNPXgWutc76P5OIzJtwnSWsaoTP40dS1eRWTpXu4ggLTeTdQ4NFlmcZsAznsScaYqt67p2cwKsz34Dj5gI+1Qp3cEwnVnCc/ils8zdevnlenUSrCnCb14DfqJhLMxkmtAZHjRAfomsVwwdNAIZw2zXM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yckl43p/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yckl43p/"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba91so2857138a91.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790080881; x=1790685681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iw/dw+ccTq952L+vCfsl+Z5DyyMuf5zXMzQFZZc0Va0=;
        b=Yckl43p/X1qGl9jsdqKYhbPDSUBjFoDIEqjPfz5Q2LQZVt492bLshmkDxge67eJYOh
         qGOOFo9T5yMZOht4YlRNL7ndvYFk5akmskD1UjXM5MxZ6cJmqW6Nfu1NPRV5rxviKB11
         xA22aUOz0QCkoSEXoThhLaiPc4416Gs4kCLHXON7lRNXpP09n016wUN+Hsol+jWutkLh
         x3HLNeEdHu0sgh9ifwaMgatCzJUxdFal0wUpqV9AatNpf+cyXBJx4nDKT8NJoQBbsdcK
         16f/Nz9lNM5tnqdbSSeYZw3FTjTwNRRw2Vdv+Z+/fdu1CHlYbnA6Kwd3it0HycY57MDf
         i4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080881; x=1790685681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iw/dw+ccTq952L+vCfsl+Z5DyyMuf5zXMzQFZZc0Va0=;
        b=AzO6AAD3/4ugGlB+WZzZmrXKE7VSd5NWFo5FNK4+ahtlLll/hPVrQIlngmSRhXdNbl
         aNyTFjE1KiApCSLzX2Eqkq5bWlqYxjCBWxq0mBeGXTA6kZSKb2rOa5L3F87h43eyxHWq
         KdsF0hoLKk9JhNC6W3rlTzlwEn+l4hmTdXsiYndsy0VVI787800RZHV9KHFVzLtwd1PH
         F0E2NMf+pmL/v+iiNXD9HE10oFjRxLrZJDPjY5a7WZmdj+oowmM8wBGVEiNqUL2UOF92
         HtFl5Wy7pO7niypTxj5oL/bSYzfmeDVc/JUGhx3DjrH+wvuAYViwMBy1LN867tCDofHH
         6oiw==
X-Forwarded-Encrypted: i=1; AKwUvBzeL8Gh6BZ7Iju3sTm1eHvyNhLv+cony0cbrItsrzMPb6fAzJtwn0/MGnxvkLuMEWARWNxi2ck=@vger.kernel.org
X-Gm-Message-State: AFuF++lH0bOLz3Fqn66bzkwm9DYFH5lIBWxcrjcieNax1et9fnfbRzPx
	1R7t8/cmSXLHEF5Zhn+9/C3X6hb/sKOSCuV3Jp32gTvEtYEWhclhOeo=
X-Gm-Gg: AYBFou03A5YHqdj112AZckse0XXSWaLyiNcwbFVICXuObCF/cJOkqh7Hj7mKSiAWql9
	7te7Mej3tn6azWwgVDp1QdDNSXsNDxyekilW9OJTil6YqSQoIq2+sQwgwKKHSr1bojGNvlngUoD
	yGmHWLrLkyCdYTtmJ1HkAIwx51QcduWzXiDSOupzjWJqldcvMPQPT1Ba6HGQLat7la6CMHrlSEK
	aYHAQj6qlOEkzmZXL5fTEISH78CMDHs6d5Zy8HOJq2e0EiZCI/00FVoz4Bn/Gpj1w/SfhOVs3Bg
	g8l9IevefFsKpofiq9TTA/GCdtQuoU+5cxknzmPkUBu8D8P6MM50fjZ1jFrBKviSTE9x/a9WoX8
	RIXID798pEheX+9PbJBNq3bu8wwXKBOD5L2X7H8ZJDQOUwhcizyeqr/Q+EVg+vp5z+ipce7czhK
	nO8aXxuxQ+cFSkZ3cPcKDnPA9FIE/B9yYEbN45GIp2gJE9WTheETp4tk8mRpgEchcETJ8CKdp8i
	Lz0mJ/K3A6Nr4V8lbNFPD1Qj3o=
X-Received: by 2002:a17:90a:ec90:b0:39e:4c81:6c65 with SMTP id 98e67ed59e1d1-3a0731f717fmr1052233a91.32.1790080881311;
        Tue, 22 Sep 2026 05:41:21 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:2466:805a:e198:cde8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5cd2e4sm3134535a91.16.2026.09.22.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:41:20 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	surenb@google.com,
	aarcange@redhat.com,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	mhocko@suse.com,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH v1 1/2] userfaultfd: clear the inherited uffd bit in move_swap_pte()
Date: Tue, 22 Sep 2026 21:41:13 +0900
Message-ID: <20260922124113.1675993-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <49208ed6-6c20-49a9-9c0d-0e1cffe1898f@kernel.org>
References: <20260919004630.1159895-2-donggeunyoo.kernel@gmail.com> <49208ed6-6c20-49a9-9c0d-0e1cffe1898f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the review.

My guess is that wp protection always leaves the destination PTE
non-none, and the move path has

1566	if (!pte_none(orig_dst_pte)) {
1567		ret = -EEXIST;
1568		goto out;
1569	}

The move fails when the destination PTE is not none. So there's nothing
to preserve for wp in the first place.
