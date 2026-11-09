Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215136;
	b=tbti9HyLD+QeR1nviNItktV2jFMmSQCEr4xDaBBaxO0KhEPvIq/peYbWsWgw1D0nww+T
	 umwDjmYS0kfyUEy5cK/pgPmK3H2FwPyTkQQtNN/r7kKsAqJdjRQsTTr31AcsC7OdkqgW4
	 nThh3Rmbl7rJEtm+sdDFH1C/DulDLgYekxdKSb6CjYg+lUkO3UkLkmzVKtvEkfKDi8btB
	 Pi2iY/e+kGkBcwOlcLA/wKIniUU3gjKnO3xHJUiSU4nHPCP1JDWzxxqlZv3uU+uxkj1wB
	 LR4mAlZAstDAOMbQ19batVOVwBLWX2Kc77ttW0QM5ThWsHH0PDgYDU/T93970CpnQTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
	b=AOLSc+HCOZ3FZq0TzF8fGlhNMKpAXyMPJm2oM/N6WwhRynONAAni/WdGtEH11YNz/LZG
	 r1BZGr4gyk0LsZjZnfknTz8L1kQOsFR1l1DrZJ/OKdrW2aHUjqYQF9S/RQ54kZsxwlFFq
	 y4LyGgw9igAdI1Inkj7qTVoqVlXE8bfHCCqnUX+Y54JgbX522GIOfspoujZLBbrbdYzd+
	 W/qlHaIy/POQwoDXb7ZFaozEKZiWjor1rZ74gcQX/biOQlohDTfXv11Yd+vGMj4IkKZzb
	 egjBILxPZq7op7SmKky9MrT1FkcF0nPeFF+40rialjJALIxsQmsaGklUo5Srh/+GN8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZU8SnwL;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29784606A326
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29784606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZU8SnwL
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492fcbfaa87so361117f8f.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794215134; x=1794819934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
        b=lZU8SnwL2d5NASFMGtKYuHPElv2TmETKWdr//7QajgisC5jhB4njc7KUHt1Fbm/0jf
         cfmuSHMKQJQCQmQVkYHt2/OtvJgkZWIllal6QuwtZyvb8oHsO/BCvtJG3MfUHtWV55bU
         ogpiFdegi07uEIhxazGUbvrwtR7T3CJuRBAki5nh0zyy4CFC9HfCFdfQ5JpdeAwscKk9
         apZ5LVAXNN9SxZtNPbqS08FcN1VYKFalsQQdogv77SKD6Hk5IXW/dVxgzJo13gHpqtMa
         5twU02rNCtvBDAkFC+Z1uo+EPlBBMek8UflGEOFFl/GpGiSd0MlsQmutcvYiSvuz912d
         BrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215134; x=1794819934;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
        b=H3G+rDn5GjndF0xTzZU9v9Ouuob4FIcSfnResFIDwiptyxyw1Ff+Oe8bk2ylndGfz/
         N/ttq0SbenHSVofQivK60m8bLKEjr2Dk+ZHEsu38F1+z4mxUVB0+TwOkgHCgOd6FAcKn
         Qik9fAj0Uh4mr1EfCJnE46OFHcqfYtqulHdr/H6/OKeuEnl6y4wBaZFbwIAmoh3D1ra9
         16v/dWIrmnw7auImM8Brps8hluFRF5lg2PVqGOlHIgQBVlwrfmYyc/dqLC/SwA7CeWr3
         ihTM8XqF9SxjKxBejx6quozfqJrPZs6g5xwxeWywTDWcz77d5i3Yhinhh+64Tl+FKeHX
         IobA==
X-Forwarded-Encrypted: i=1; AL+hErGbIoQrevPg4n1iPIj/qyK3o5NXnrSyf359m6I4WLvHL24BZIpmY1mFGLMnD+Ys6WT+Ry/Ivis=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+ILWl0kUhxz0H6xtIxaofUCPeco3AaCIfgmuNFpkCoYoD3be0
	AdwQKI115qXdTzQ4NN4fixAwI48lW9uoCv1wJPeD+yV4kfVPO5j8DSdv
X-Gm-Gg: AYBFou1FsQOWrkklmVdvxVYF3xW/0H54vA6ITvEkdfD7SIVfbm2F+34ZyPX5T2OxJXX
	/ZNHsTX0mwgjTYhTbKS/mShStM8T5Ddo9guHkqgJeIiJfAck1ORl4JmyS/bmQdG0FQPImMakkwR
	tnvxW9NgxoIgcAsrqjll7bFvBNUfG4LJw85OBWPvUSrcoTKdz1UkpPNSHZyjOVTmbGjFMpW/Pnq
	ZaM0T5dr/vYrrhz7Lvoq+a+M1xmipU68Paa4bdthGkBvMRSlZiB/NulUwARZDcjfvdJhIQEM8BR
	C+Ok9bkUq2qFaLJnIP6DertZofLy2q+UR09Xj71L87a1Js0Dps+QSiN7UDZ2jWf+lEOp7xoeGyd
	R43KR+EIGIvbedJc0QcDY4d4f8mBFok8K00g8rkI6ZcyDGvsOmzMn3QFKo1TYUAaJvfYxzzQ1ok
	usL/BcICJ6vRppPdxvF2qZznOiotaF9dDBHTEMBeHzeMD7S34425rSztpYmlQqhq+pXZSvG4RJP
	aduuNPIjJhq8S/Rs1JPus4rbRsQcI1zXS0S/yt9umScrSTbeQ+HNXOtPyFdmMqi/Fyhns12cHA4
	ISqi8CZShN3SvfWCFPSUFnQ=
X-Received: by 2002:a05:6000:2210:b0:48b:a7:6396 with SMTP id ffacd0b85a97d-495844a3a48mr6683329f8f.41.1794215134134;
        Mon, 09 Nov 2026 01:05:34 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596ea51cbsm9541323f8f.27.2026.11.09.01.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 01:05:33 -0800 (PST)
Message-ID: <8ff83fbf-2ecb-4f9b-ac8f-ee88fece67cb@gmail.com>
Date: Mon, 9 Nov 2026 10:05:30 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm/gup: limit pagecache folio refcount when
 grabbing references
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-5-c38f6809b106@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261107-refcount_overflow_stable-v2-5-c38f6809b106@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 11:23 PM, David Hildenbrand (Arm) wrote:
> Let's add a folio_ref_count_over_limit() check in fast and slow GUP
> before acquiring additional references or pins.
> 
> Keep it simple and use the check for all folio types.
> 
> Don't check capabilities with IRQs disabled, as even unaudited capability
> checks can take locks. Refuse access to the admin reserve, so GUP-fast will
> fail and fall back to GUP-slow if possible.
> 
> Also propagate try_grab_folio() errors when grabbing additional
> references in __get_user_pages() and in memfd_pin_folios(), so hitting
> the limit returns -ENOMEM instead of -EFAULT and -EINVAL, respectively.

nice!

> Keep the existing invalid-refcount warnings.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
