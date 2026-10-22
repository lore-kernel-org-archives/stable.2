Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670825;
	b=1qgeSUq7noYKJKyJq0dNdLsdGr1qL5/M+5/VaVY2ydC6AbnFkPJ7d8PFzsw1MO+7yJfT
	 JYd3gszdnEproeTXe1JWW/OvlKXSg5xDsn+WM7jiOrsZwEKLZ2jhdjwCdUP8s7K1XhTRe
	 Efdw8yKIsr79yPZt8OHuLIcMcWxg96/5JHOmBu7RJV4r8MmxhqmyKslnlYuuygnpmW9kc
	 s8z4wo4rQhMbfWAW97qSd/hJreW5CBlMsSq+69D9XZMi7x57ebOGhGAdVDR6kAkoGyWz9
	 m9dg96yK4d/zCcK5K59Z1jd3uUXheOzRyuFqqKPGz1j4DwQrgA1KMqk1yPlSoQHS74Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f4Pj7b5+BCbfAUSTsrmqLzkuYkoyWrTz+YeW1iMb6p8=;
	b=rzgeEOoUh5m+TAuJbmFb81AQptUc/f7tBd/f43WN6CLMxRu4B//Oy4BbJFF3dmEaEu9g
	 ZasFz+u4G23lTag9zoBioQ/cDrhELGvXzkTKYZNxTaD6cMBPymeaKHDO3bnhGwcW2jQkF
	 uT2ga5vXpWoOhLKUgB9RQDCYLUeipOiBq3o2BAx0QNMLHu+cFWezeTlrFx+KkNELiaNae
	 uHc6EfZWJaA1LcGmGoutDwFOnpCx+nEi8ChquFY5NX1HVkZhGBWjsp++jkXp1q4gTDLGo
	 EvB2sd5lGYWBB1nVuO6Enrl4ig+X9DfPUDKGbfUAUXsU72r5o6DhxxGGtsXQcbauGBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=DCho+HQ0;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF4606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CDF4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=DCho+HQ0
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ab43af5e97so9051257b3.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792670824; x=1793275624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4Pj7b5+BCbfAUSTsrmqLzkuYkoyWrTz+YeW1iMb6p8=;
        b=DCho+HQ0HUQRh5vJ4m/7U8EaK1YUKYd0HqPcqV483E8mA8fjn+MUsZLKDRZAc54V2o
         dq4aMXrXJqsfG0nTL8vatAr/OVoProMCvuAiOrYBGwToottVPhQ+JkGsA+pqysFAdqVU
         WD2Tg54uWt6n1l51HQsRTxWtYDzUjdmgf1pSV6V2Eb9EHa1Wpo5jt9bSpqBEJY+DJsoR
         owpIrpLxe1pfrNEaXNsZax7LCA+iPdJgPosYvSJ4YRVBHCCtDkm0Q7gbTwMCl5nAa3bL
         Vppa5iAczQkqskWc/lpfDtHIuLdFFBMUcFsbFnPA/EttqYE0WiOBydE3whHqwbUFRdiH
         BS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670824; x=1793275624;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4Pj7b5+BCbfAUSTsrmqLzkuYkoyWrTz+YeW1iMb6p8=;
        b=zHSjIW360h2YPP4a1Ku3hjPaPjIEaWFgCL4dbe4DbNv+piYogCdu0EOjsPgIDiXAS7
         HizV8EYEU/O4+vxaPNkb16qkVB9SzWGtOG0z3oGrQTHLPUPRg0xljKAz/4cuQHylXY6U
         mmt3qlYAX+azbVV+0LoOU2lJ1PvUKtM6vOKoKfIUoIuyrPZWraB2TA1vBXW0Oe6Tysn3
         Gz+xZni0q3cxS6MXp2T2gSSuuawzJWxN6qQbKVHZqDMAKMdyreLTuCHZ3jwfNCYo0b9E
         CbKdPFIVT09ejFJILTCZQ++TNIeVujCwBZHbW2SkIYVQUZoK8AvqKeehsBUB+qlsD0Mz
         pSaA==
X-Forwarded-Encrypted: i=1; AKwUvBxXe4+T3KynEaEy65aoB7knhbxpzID89/6Blgjwdh/sVniKuiSq3j4lTe7TsuYwIr/qtVsRqp4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeCtM0KbNLeiaErwTLVLt9weDkayHfUOAuFNR6MSRfduwsySa0
	8J1J1G7ILu7nt8NTYubyyqzTtb1A/Mv44Y39cvKsxUKXnWtbI1S0Yodnf83XQCrJAQ==
X-Gm-Gg: AYBFou23p/irA4jCCDDzRzU+Y+N3uGvlYp8VU48wUsfOWwTvu2tagbRxJq+c2NcqcJZ
	BTFo5+14hErAdBzhrE3H5O4ocvOe6iqfUYEccyPuyomjCjmhW3lrRhV6neLKubDuaKaPnz8NilB
	LYAddolieMpenSeoP0am6lAgi3+Qf/foOiI+IoYysH9S1KxUUpmQCpNlRE65RY/F5+YEEjyZurg
	sXC174/yDBRxcN8zPwEEEx1Lk8H5tFUeW4eXKuoH+R5LT9vGZEkmhsU74WaFqVowJfisC8Y/SnB
	8RjIpsPoVES8gX8zC21ItUZ1hRA6nmYjQWgtHdTozmCltIcNko3gVXttqT1C7SnxLwfKXWTBFF+
	cgN6HUokg5/4ZmobMofw1FaEXrRvuOZCasnE1Q7wYPYDR7gV2IWwiwcosA4mEB5hkRpkfGQ+9T5
	uocBzmVVylj5lcNvY9SgJ6Malq2oMtMP0zW61ZuLj9C+HA3zRKwDVIQ0LlP3n0DJVEPvrmAkT35
	lBfDqZh534EWRHQy1lH0BPBn70lxh+FGpvi9DzQbSsOkYbUKTP1AZW9uj9QT/Uc7jC917eGZh0k
	1U1n
X-Received: by 2002:a05:690c:39a:b0:8b0:a171:65f7 with SMTP id 00721157ae682-8b145716d60mr15017307b3.19.1792670823891;
        Thu, 22 Oct 2026 05:07:03 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300ae236sm25232857b3.20.2026.10.22.05.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:07:03 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
Date: Thu, 22 Oct 2026 08:06:57 -0400
Message-ID: <20261022120658.1328124-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu> <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com> <20261021153141.311425-1-hengyul@cs.unc.edu> <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com>
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

Hi Slava,

On Wed, Oct 21, 2026 at 03:26:10PM -0700, Viacheslav Dubeyko wrote:
> I think I see your point. So, I think that fix is much simpler. We need
> to add the thread records processing here [1]:
[...]
> The current logic simply misses the HFS_CDR_THD and HFS_CDR_FTH cases
> processing.

Thanks. I tried this in KVM on a804c5742bff. It fixes the example from
my last mail only in part, for two reasons.

First, a thread record's own CNID is in its key. rec.thread.ParID is
the CNID of the parent. In the example, a's thread is (17, "") with
ParID 2, so taking rec.thread.ParID sets next_id to 16, and the next
create fails with -EEXIST on z. Taking the CNID from the key gives 18,
which is right.

Second, even with the key, the scan still stops at the first record it
finds, and the last record need not hold the largest CNID:

    operation    allocated CNID
    create a          16
    mkdir y           17
    create b          18
    mv a y/
    rm b

The last records are now (17, "") for y's thread and (17, "a") for a's
file record, with CNID 16. The scan stops at (17, "a") and sets next_id
to 17, which y still uses, so the next create fails with -EEXIST.

File threads are also optional (HFS_FIL_THD; hfs_cat_move() already
handles files without one). If a (CNID 17) in the example has no
thread, the next create gets CNID 17 as well, without an error, because
hfs_cat_create() only checks for an existing thread.

Result of creating the next file in each case:

                        unpatched   thread ParID   thread key   patch
    example (z, a, b)   -EEXIST     -EEXIST        18           18
    mv a into y         -EEXIST     -EEXIST        -EEXIST      18
    a without thread    17 (dup)    -EEXIST        17 (dup)     18

So the scan needs the largest CNID over all records, not the first one
it finds. This is what the patch does; the cnid - 1 lookup only avoids
the full scan in the common case.

If this looks right to you, I will send v2 without the != change.

Thanks,
Hengyu
