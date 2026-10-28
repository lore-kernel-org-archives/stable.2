Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161925;
	b=tJZ8FW/qRlupxU24dfja985c60mKbnyX9ddjh5jWEClSxkMPIaDGwQXOYd0ka3vwZy6s
	 KWuPDF2UI9HQZKzmv+6y9t6abpndQwPm69Mhy92CSHt4N/a9RBgRTLm/SgfVqJ7YInkX1
	 kFlDZvga2p28xTfZNEK38lqbpHO+vTABjA8p/cmoo+i4dTsZjCVXp9/z96QTVfS7NNGXs
	 QmW5TN62auAhWK4Rb2ilrxJROaoYw8mhc7GqcrLsqEkBtJ47cedo1tcKSDWvepuHeWoR7
	 06ymSlfaLUtEJh9dC+QnzYpcWowUSYiODNaSkeK7ngrIORMqqm2jrc78tk+ECgYdOOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yM14926zPg3ZfRwCbYZBe9j460yUUMo0egqFW1RVlJQ=;
	b=n18e85ooKZh6yojIiyF3/MMphUhS7l5hffaSoOM6lajp7RQWzvNqoyds7JscqX+hUpuL
	 j5GFNnQjoUWyW1FGDbPizIaI3VUxNrsKvDpXirHFZS5JzdMn+POHRy8HHWUiHx1/2rm+3
	 denhT2O4v8Fpj1rZJXqB+vvuBzrp4Kx6c1V2b4mgdAOwCHEiLW6uyh5BipYDDRz/mputT
	 sgCDJWCrQs9yZjzEGUdzMjB/+2OTYlLlBUpxw1erxV4LO/hGJjRVmg7gt3CVL/wh1zqoO
	 5H4nIBIy3P4cVZzMh/96XCe3dqbTwATWVAfJvrnYTLJIuCdlM10psa8vBSkoKW8aJ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=XKUxt1pO;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAC606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FAAC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=XKUxt1pO
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-676804a3a22so546597d50.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793161923; x=1793766723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yM14926zPg3ZfRwCbYZBe9j460yUUMo0egqFW1RVlJQ=;
        b=XKUxt1pOjBpT1oR0Rna8fq1yt2L6uBNBxCIRQjlix2Cczel6chttmbX5yCRuKhsYxj
         6icJovGdzvM8e1m2EUJjBRZQRPb9KMPLF1H8L+lFy02ciU/rnyZ5zr/ESlwDFojYCFXG
         tjHLZA6ZAgDWgiae3IAw84h6IuBB2LZSVMfkCDSId4DuTiMs6biP8hk0fPNpJQHp2Q2j
         O23YdGhjlFLcrbC3PQ1o8R2tcqDrDMvBm7FAeGUM/rkf9hTuEr7TjM1EqF8hxiiMx+Gh
         XuQs+k93UVqRCt0gj3blcDyoCptfCZA6eaz7tAb5ta0Y8i0DS78Vc1sgcjbBiMbSDJKo
         r5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793161923; x=1793766723;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yM14926zPg3ZfRwCbYZBe9j460yUUMo0egqFW1RVlJQ=;
        b=jwFf4YW2epNanVA/R4gUObZTMLNqvBVaqntG4/PQiBkuytBHzeq0PDZSmp2mGREMnI
         7y0NZO39EHKh9SSKk7LnC7ocjzKwzrHHelZ67GVYBcVRhCP0Ygv4FrXM3wW4Mz7zKeui
         U2TSWDOEhovpzsEnF2iDaIHKMC16HwdNUCFsJJQ2MtPEMNzdUBOALHueJz4mYn5iWvNj
         xx4kB/W1jv3N02+bqFE8Y/5KBKH+4tiAvxTCCYntsPrj7rRMBXr+3KsWk5Wfe9zJGhSK
         8StlPAhesz4sD2sCYbR4j9mO9WxC1/S6K5XiFQO/uR6cnk1azSX+LYZzbWYgpVYXh5h0
         1Zdw==
X-Forwarded-Encrypted: i=1; AKwUvBzpd0oZjfKt+QBHC9eaC5C2GM0UvjhRtWjoQcoqnm0k4nsJanYz7gkvTPiW8si+SxLWpWUp6IY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjlw1ucO2nMzajR8T0wiGBHd5RRMp4EmImNvvukL9BEIL7f+4r
	+AP9KtvTMSaY1VoWYQVKCr/y2H6hnFDOJ6IyN9U0isKusTDitzQE0o6lvRHU+JD1dg==
X-Gm-Gg: AYBFou1He9OkZ5+Cwvlfscc5vLme10PLHjqCMMyPibdgXry+llOsJF/z4UV/UHmDybm
	gQbLuE7zGzqe6sq934m9yz7OKdhBnVMlMf80DJvMCBpxCFBNK93mSS1FfL/9lS3kkphKa0d/QU7
	rNCqdmBMPm8dDxzHn7AVglpbkFytdb4N2+3X3xAZQLsVzPtRVvpVTbdfFNlYta/OfTuHQxi6ZRh
	X7/AMa6/ebZ33Qw1rJVdUoLMrViLz3whwf0PXTqdvYjwzh+Y/GZtv7xXxWjaJ8npZ3t4pzU1OGc
	ItHiOn3O3H/Nhek27c79H2DwGHFX6Zr8PQ+si9v4vMEBOttIQzCSN7Fg2hVj9U3TK9hNR2H/Pn8
	apmDJcbKNtqepbsQ5hjSrZ0VKfSAo7Pz+xb6njU/pJMXeE2iwNVcFY27FkvGfLq3Y+4OezDwla3
	cOm231TeyFJPI2paAUo59euzmIqMoj2OsDdF1+bpSVoGKv46KmezHsVqa2rYly95Wgxl6upW2Aj
	5RCDYIvaKZuQOMKSbS7PpKR5V85HLmEMPcEEozvjF5hruCiVu8b1w/eu8iunfr8HUH4OdCIfi3A
	JivW+j63mvgZNQhySDWKpU4mySL4T0Awye7mbVXfUsjKOwAhCMaquhegn4P03SfQwjdZfcJt
X-Received: by 2002:a05:690e:c45:b0:674:1b39:fe1 with SMTP id 956f58d0204a3-67a7bd6d393mr1148399d50.107.1793161923391;
        Tue, 27 Oct 2026 21:32:03 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a07daf6sm1114915d50.7.2026.10.27.21.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 21:32:02 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: yizhang089@gmail.com
Cc: linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	dave.hansen@linux.intel.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: do not advance i_size on a buffered write that copied nothing
Date: Wed, 28 Oct 2026 00:31:46 -0400
Message-ID: <20261028043146.771074-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <abcaabca-d99e-4bf2-b31b-5e96e7accd29@gmail.com>
References: <20261023172532.3271348-1-hengyul@cs.unc.edu> <abcaabca-d99e-4bf2-b31b-5e96e7accd29@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yi,

On 10/24/2026 3:12 PM, Zhang Yi wrote:
> I feel the last sentence isn't quite accurate. Dirty folio past
> EOF will be cleaned up during writeback. In mpage_process_page_bufs(),
> when lblk >= blocks, if 1) there are no blocks to map, it will
> directly call mpage_submit_folio(), which clears the dirty flag on
> the folio, and then mpage_submit_folio() will shorten the writeback
> length, so that ext4_bio_write_folio() will also clear the dirty
> flag on the corresponding bh; if 2) there are blocks to map, then
> after the required block allocation is done, it will likewise call
> mpage_submit_folio() and do similar cleanup. Am I missing something?

You are right when i_size is a multiple of the folio size. Otherwise
mpage_submit_folio() sets len = size & (len - 1), which is not 0 for a
folio that lies wholly beyond i_size. The first buffer of that folio
is still dirty and delayed, so ext4_bio_write_folio() redirties the
folio.

I checked this on the dev branch with only the copied checks of v2,
without the trim. After a failed 4 KiB write at 1 MiB into a 100-byte
file, the folio at 1 MiB was submitted with len 100 and redirtied on
every pass. It stayed dirty through three syncs, and umount printed
"data will be lost". With a 0- or 4096-byte file it was cleaned as you
describe, but the delayed block stayed reserved until eviction. I will
reword the sentence in v3.

>> +	if (!copied && pos + len > old_size)
>
> Why do you keep the '!copied' condition? AFAICT, if copied is non-zero
> but less than len, the excess delalloc extent allocate by
> ext4_da_write_begin() should still be cleaned up.

Agreed. In v2 those blocks are only dropped one step later:
generic_perform_write() retries at pos + copied, that copy fails, and
->write_end() runs with copied == 0. With short copies of 2000 and 500
bytes into an uptodate folio on 1k blocks, the end result was the same,
but nothing is dropped if the loop stops before the retry, e.g. when a
fatal signal is pending. v3 will drop '!copied' and compare pos + len
with i_size after the update, as ext4_write_end() does, so a write that
copies everything does not trim.

Thanks,
Hengyu
