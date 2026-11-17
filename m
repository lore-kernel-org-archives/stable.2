Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906642;
	b=ibvzfi3QUPCosTDhlestfnHUcyXnqibhYLd2K7DaLtRUVmaP1khWKACukmyrvZpDiPNI
	 aObblW3hP5/sOkR/EWu4VtXm7x3T3Kg2aJYpuHrDgezIpTM0lKk+nzVhzGN6oWGenb/DL
	 ntw1kC2Fhlx1Tbh+SIuylEjZ40pDrEOcyZdDRiaap1/nsjv5abUmReMFkYalumUzU6Abo
	 RHt3X2HD9vuF/gqv/5QB+cFbYh9vnn5f706AZb0dHD6IS1vhxICA7Y+BMAqybhojyyGD4
	 r5O0R1GFpB7xJCGhSZ7TZi1NesvyqfqujwZSFKl6Pl0BUwDWNTNCs2/oiRP+WPRcpAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qU+9OGvRfJV1audZnO5SC1P0nvA1K8+fKrFIUfplFUM=;
	b=5nbFb9Wmgtj4p4+l6h/M6mfHAVJwbKaSNX+65cbH2Y6sq25kdbJzB6hrSi9FdyWHZJCJ
	 WHHbodTnmQ+AecMB3rltjj3UILtO3mxmt/d/wavvmmB8MYqLVsifNtvXq6ow9CJKQJ6Tp
	 jsjhHViWWF7nNSe/x/G47qA8dU8VdwbdN4YojKFiEVj5EzOnk1bdNND5hrfFdYYIoUI39
	 0SxAnIuWbu0tenfvosF8v7ylLHgbXHVfDnXe2qEsqR+G2SPQip0iIpUO6wR2S7t8JKtKa
	 y3xLPpvY5JPDIiTQmO2zvpgeSnASh3DlhJetHerx5EemEBCqrG1kas5Dh+YRuN/+bxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IY7t+LAO;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618D606A32F
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A618D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IY7t+LAO
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2efd7259872so5856285ad.2
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794906641; x=1795511441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qU+9OGvRfJV1audZnO5SC1P0nvA1K8+fKrFIUfplFUM=;
        b=IY7t+LAOb6XWNzzWCVC75cn46512CDirFSZ595tS/vBxXvnW7VtypiCoemppHn65KE
         r5+0Gx13IgBFWk6VdV6iXgguyZULkmTxv/+C2nu1Yy5NhSns3nkNERhjl0cAtGLXPs7q
         brRFF+CZ5Fub+hRiQi3FtrJmKx55qqvw6sNGdqGec6MDnoAVpdtvsAeZguNFA2iXBDMP
         00IuewHX28K7FfJEeWyncTcxAbtwbD5h/mfHKy9n7r0n2G9cRHdRn17TVLpP2kelvj/F
         xsyWK/gxkRy0nGi/7BaPeJUhZHqRlIU3dG/tc3vR9oOVniNjB0wJWZCBSNl/Kc3l0f5H
         IyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794906641; x=1795511441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qU+9OGvRfJV1audZnO5SC1P0nvA1K8+fKrFIUfplFUM=;
        b=k4iZSQiR1Xi4xE6fImLQ/6KcNo4zXlRchuBisAe2xZlLL1ENj2v4usmBGy/f6pGBsL
         tcIXWwMP3HBW0ZT6ciCNVSA/IlvQJFGC4HoQrjAlTETcL2BP4Ne8KoaZIwTt+/I2qmB3
         UuKL8pkj+idvDWx21R77BzGsoywuab3nEo17P8GfiZIXaAuvzgpmi2utmDSrdMScaH8V
         r0XImhJG37JOhqFnYWad9tqkGmhQv/H7otm/0F+ctkUxcckvdBCL7Ius9fkA0hQu3sF0
         Mulc/99e7g2wBLRpgnoE1aG+aByf+LxUuAaSvlszkViRAEQjUjdOu0R3yNvOdKiethBo
         taRg==
X-Forwarded-Encrypted: i=1; AL+hErEwXMvtyUYccoMzD0en0oYCeqwqsAMIJpMBsYM+5GULPoRfiI8XLdMiPsFbX2vmIjFnNuCN05c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9gIFPgHilDzBfnF94cn035btYjxMpNsB5xmoAmj2qaR+1vr8D
	im+6OC3f9hDB2j5JiwhgqMuQJ+M5Bfj9bmDMdPNhWT2AKR678BNHpoE3
X-Gm-Gg: AZFdTZcvvtqgtFh+tzfmaG0Hkv5kdyC9SskC3xpC18isnsf8k87qdGO4/C+IQ3s0zwb
	XqiuMEAiTwJg83hpNucqxSFrRLLeQrbj1pnSmSYFXkhKtiv86Qi2ckKlfgQtYztyk9VxsbNthAf
	DjDfHjsZvrxYayFpphTdNpwMrXRJKsAipOmdeakPNbsOzDAPTC8osqFdXhchBIOM5g9etBiztDN
	Os1nC9MC6kj9NETMb8+ZuUmvFGp0dc3HLsMOzOR77oTx1hz0nKYWPFNuhjpz+vh4Cd2f0eZ9Wb2
	e6spLFkzLpZ63tSgoYk8KVeN0ls9tzsACnzA0PwlFTkxvsy8jH6ZfQbNSJ2ET1xpNYBCpIVH5TE
	EoYyW8YsmRFxfWRh9E/kWIJCLk4VfWZ/qLZ3r0exrTGKul5rWr4Z4+kfeDf5axVADrN9Yj2xYsb
	Wq30kYN9I2uWBYoIOrLqWidqHSSW1xSDjYrj5LuwRe3CUYiKyOWD+8roPnV8aFbUCAk10a92XZU
	r0wZDD7jsSRvhjV2qc1Z/C9Gch4lBsjDi0KfQFjBTekxTnqu1N72gV8MIEclhWsB+3556P5eCyH
	U+wIAsmQwziEw6KY4tJfXLHNA3DtoqyoUFMMZ5dMOGg7VRuWh9Uio+3Lc7r4hIpb4QLBHaFAeVq
	rDOxo6PIPdJbau81qbThc6u83R0QN8uOzzR/NHWMKnmWZAm6GuOMTaL9UkZAXNKo+5CHPgLPSnM
	M1qTB/IU6ezVf4xlbxfc87O9GXntjkSN3Km4RuoKfMVmAoe45lfpYX+IZuiRCrXWEXXv1v0Ec1+
	2gv/6XYXZ+B5/y//7ZjHfy3BJdExqz9/Ar5JS19C4MpL78wvJp6dJ9u81nZZyer
X-Received: by 2002:a17:903:390d:b0:2e9:5507:b532 with SMTP id d9443c01a7336-2ee0dc5d126mr124593155ad.43.1794906640821;
        Tue, 17 Nov 2026 01:10:40 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7aa8049sm11241175ad.68.2026.11.17.01.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:10:40 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: David Hildenbrand <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: mark a collapsed mTHP dirty
Date: Tue, 17 Nov 2026 19:40:18 +1030
Message-Id: <20261117091018.63639-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
In-Reply-To: <dfbf361e-8125-4f8e-9567-65e80996e2d4@kernel.org>
References: <dfbf361e-8125-4f8e-9567-65e80996e2d4@kernel.org>
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

On Tue, 17 Nov 2026 09:13:09 +0100
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> I have a different patch on my queue here that fixes this as well I think. Please review.

Yep had a look and yours does fix it.

It's more than soft-dirty though. If the folio gets dropped while
another process still maps it that process reads zeroes, I had 64K of a
child's memory come back wrong. So might need a stable backport.

Dropping mine, yours obsoletes it.

Reviewed-by: Daniel Wade <danjwade95@gmail.com>
