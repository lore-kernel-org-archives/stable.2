Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795545923;
	b=JEEVBoY/hlHb2EQFGQjtNw0fCqPk0rstZ6mShUiZazi251vDwXOcDM6AcKe5a14DEazl
	 L+BA2UcZIXwsBwfUYDtr7vVVX7SCfksC15vBqd68Ci/219iZ9EIUEVwyAH6rLerC/PcbY
	 eGcZ1HRgFkTEJeRMO+xr8upL3WJaKLdm5ceztWZ5XV/UBblZz96rncDyrvlU9kUZ8gbMo
	 PpMYoY6A843HdW3nqntt5U4kQdQvZY9lyRDKMRT3+YxlYpiXoibAqWfb2X/bBux7Z66Dh
	 hDU2PvsiZu+D/G7KRSBRrPiaeeTYjvaWn54lU0OzHkgbt22gsvlGJHjJpc41mHzDP5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yTtmFC9qSzyqzhkMZ+nRiaHuo2O22TiUVuXKFLL5NIQ=;
	b=FTn7Uzr/3ifubJtJZ+QqIBWWQLkJrHlXKYfpQdb09GgYLSr4J9n1u2QVQjKrzFA5FP4D
	 fR2OGdcze5Eb13R6XJzS0ZOAXvLK68YKcOl1xEbFcrCJXaEyAzLTaESbRjYCDy78tQWUY
	 zVNgVeyUtA/RdGifTeDKD+T1rk6uuCr0ur8IkjxT2+Mf1vb0r6Wn0c8vsEhUsC4UldjZv
	 o2Qe1/t0UDLD6wfaEOQxmj3s3w/d1roQdCvET41pXj8G8cbjdXAT+4U6I2ovQFsPMwpDI
	 Ae4+D9J8nPzpbBaVAPdTFnDtgkdfiUc2+oKebRRqt3yLT6TDdAIEBQS5OerceLjxC4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EVc0Idzc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F324606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 18:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F324606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EVc0Idzc
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb5b33e2ffso126725e9.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:45:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795545922; cv=none;
        d=google.com; s=arc-20260327;
        b=otPeBMoTJLttDWq2IrUP19n8NPGMVQ+QjWE4+4tBc/dBZbxQ3JzOWerNdW6nFwn41H
         6q8E16XPp1qApMfAjelWMZ4QTDTtnld54SLKKvupiIJ8Ak7OQ+BYaPxphggc0Z8tgKgf
         qLre0ArMbAWPrS3atXemC4ggaNUp7KKQNcM1uwHVlgEae2jtA9iB+o/qZ1hE7wCHINVp
         KE/J1hQHqibFbhsPpzrKNT4dufAzhzJ7kiBK599Dn8Ut/PpRKfqPYRFci6xMQfT78M69
         3JLdhMDOjc8cvCzt+UzI0PuDyIa4cc4iRCWynn0nRbcInz8nKj/Wyyouaw/Qyq+nUOFK
         q7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTtmFC9qSzyqzhkMZ+nRiaHuo2O22TiUVuXKFLL5NIQ=;
        fh=7sOY7lUZcmpaF/nuYEabpuSGOXU3mooioPyICFQnc6k=;
        b=eUqnEMTFjUpYGg3YFN2WaVv5UnIMFB1gvNLAXXSPdYl190mkaIFmakRBFMH1oxI7ek
         wtvdTh88fY/gHFihiHzQ+wEBaW1aADfncAkSRDH+UbBb4lKycH1Zz5ovFfEaoMq94uls
         OpuwaeFioMvT0x/Ij7BKsKcto00wdV4hexIh6/7ALOdymQM9UbqeRZHJFlbLV9YPRUhh
         RRRkMWmvE1zeVnJDQGsI5hZBFO4ij9CjE8YxfKrKiCzXA/bmvl2hASFmzCGg2fjoFmQH
         2GWd5H9WdIPDC0mGZosFMl3Rghkdm6QrQfwudreAthVhp1JlSTuLeA0fp0M1sm7GXQXM
         M1Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795545922; x=1796150722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yTtmFC9qSzyqzhkMZ+nRiaHuo2O22TiUVuXKFLL5NIQ=;
        b=EVc0IdzczLGPm/v2iU4n6hBwE81QsJ8zWG+yjfbboj4t5N8hTiOE88NKhVmJi2crtR
         HTXndKx4NydBQeufRJk8PsIC/q9Clfe8wcxX2IMKisD8MckBSGi4QA0f0kjKZTLytFDo
         sYNo0OnMyYwTcH2VqcD/FEtFlzIHABB17UKW7QKVuF454x/QcOHfBPIXEkv5azRuW00X
         i2+CQUYNWlmCKVBuIvlS+WryE6UKIqemHi4Q47djEbPNhXxsxa7+TqDozJxDxmVE9jys
         iNI5C2ahSuqb24t8mTZZwrpfkVPA054RYqPSVfONF5BUbX4rp/35PHmzO/gwEDN6ptZp
         etIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795545922; x=1796150722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTtmFC9qSzyqzhkMZ+nRiaHuo2O22TiUVuXKFLL5NIQ=;
        b=z6ANgDAxxCN5tyvzHX/KWdCl7bOmJmUdsDdiV3tV95C7LCsAF176OfP+hkrd9qQRuV
         +pR8sZ9M9ImB3sbL1DQF9KWNwbHOaxImnRKbqhOx2dEr+RP3BywHp6Ccxsu3LqmNChFf
         F3S9BoqtP3IDeBsvhxZIy9hYnk8TOiXlRd2Pigc5Uvrh9KveWq+KeVdQKBq6fkrrXhgZ
         oAfFP212RfZNdfRIT8XLRjQUlhe6DtNAN2vbP5ZghX2Zv+6iWLLRxpAMhpYVyAfRF9G9
         WeRz54ZaJJk6WnJ29Nfw0M2riB629Tv0mrK9w6jW1+U/FuR5Cwy6BStIT7fMN7/jUe4U
         lujw==
X-Forwarded-Encrypted: i=1; AL+hErHF1aL1/LoY65RxQy1TxrYI+l6+1/jmj6UamDRQmuuCBsVcPGGWQ8KImkGaZeJ0ppLpNIER4OA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0EH/IbfHprRkIz5Mv/T/KNUCSIGCXxI2aPfisETyOoDNBeIa9
	qMvF0rgFLDFsPswg7btvvqs2acFyRDQLpTWC5Rm00aros1IdUJYlcdTgHRSTRL7oHdyfodTMkma
	6u5aIPz6tQPEgVmcg+pcMroUsDxs+q10fUi2bbLX0
X-Gm-Gg: AZFdTZeHxDdfYX6NKxN++kIfOkq2mQoDz0/SF8X6k0u8IscyBBJbwbth1BbbfMYUHfc
	byPgA2OSSuHO8WxBNej0STHIWaq9qhkOI4wPoi43rKgfZp22EK+Z2d5uxL1SESJZ0WzhC6H1skH
	ctSPDpaX9tPY5uBm6cOnHUqA1RyrjEvd8nzoZmEMG75mJ7mAvsz2fM/OydKQPxFn9BC4uEu2fVH
	xCFATwDSSeMbsySMdM8FM0fUVyArEm9+R7bLBxvYQwJjZAD+V4XOvivqA07rZ8kp7+WLCt3Bg+z
	ZvuMoAc2qImv7zVJ9ktny+abcGWzko/2gg2t6F1Jb08tov8YTAQmmcLjoyNcCg0kj8vzhaz/vcl
	uU7drW5lNYpnJvy5ahxZMyRxy+dZ/sajqbtjM3dRNy4WDwfQfPtOqMugyvEuDmB8C8pmuTXx/L/
	Ui2V1eThMWOfpnGYpJsX1nL9NEUqUdbUZIjdnPkhj6SCmi
X-Received: by 2002:a05:600c:470d:b0:4b6:24ca:8848 with SMTP id
 5b1f17b1804b1-4bb9169c773mr3294835e9.11.1795545921491; Tue, 24 Nov 2026
 10:45:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org> <20261117-huge-pfnmap-fault-races-v2-2-276007e73bcb@kernel.org>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-2-276007e73bcb@kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 24 Nov 2026 10:45:08 -0800
X-Gm-Features: Aa3M54pkUi88VYe-fpktO26ba_xgIBRMnt9i_jgdkEnyzZZvFIfmSEN7jCPiH-0
Message-ID: <CABdmKX3ZihvsJfPGDhg+tmjn+xVfhKkZUshr8NbO5T1BmVcOPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mm/memory: remove racy huge PMD assertion from walk_to_pmd()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
	Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
	Roman Kisel <romank@linux.microsoft.com>, Saurabh Sengar <ssengar@linux.microsoft.com>, 
	Naman Jain <namjain@linux.microsoft.com>, Michael Kelley <mhklinux@outlook.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>, "Gregory Price (Meta)" <gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:32=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> From: Eliav Farber <farbere@amazon.com>
>
> walk_to_pmd() asserts that the PMD entry it returns is not huge, but does
> so without holding the PMD lock, so the assertion is only valid if nothin=
g
> can concurrently install a huge PMD entry in the range.
>
> This is not the case for a VMA whose driver implements both ->fault and
> ->huge_fault and which invokes vmf_insert_pfn() from the former.
>
> The existence of prctl(PR_SET_THP_DISABLE) is problematic here, as it onl=
y
> takes the mmap write lock and faults taken under the VMA lock are
> unaffected by this.
>
> This can result in two concurrent threads faulting the same thing
> disagreeing as to whether to attempt a huge fault and thus ->fault and
> ->huge_fault running at the same time and triggering this assertion.
>
> So just remove the assert.
>
> Target the commit which introduced the first driver able to do this for t=
he
> fix - vfio-pci. DAX also mixes fault orders within a VMA, but serialises
> them using its own mapping entry lock.
>
> Link: https://lore.kernel.org/all/20261112051440.16140-2-farbere@amazon.c=
om/
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> [ ljs: rewrote commit message ]
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
