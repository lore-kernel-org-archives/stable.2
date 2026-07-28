Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648CC37C0F3
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221440; cv=none; b=pKsk8gedDhsLaBh2m6wLbMb0yb1iRIyiGdMfArjGzqBXoIVHSoB9Al1em0HGvqFP8ocdAtBD9zoytzex+IGoxmuG/JPND+wTcMSN6d3VJ5zXTjJJr1pyKleDU05ygno33LHytTt/ad/k6E23nJTLRUPZUj2MX8t4RekapEWb6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221440; c=relaxed/simple;
	bh=5L0zKFrAkf8pmGjCwvUJFaZVrLTIBTFBT+2mzOyn/PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0aV3GC03HQnsFCsofnrgh0PUj3HP7OxF4u8DE2JRThY7qci3xQp06leNFqo7EfhRGC9CnmIIEM4JOYOuG7BDzbdQGzKiaZwPCpZM4LtM7rFy92JB24rAyTYvGg8F/G6cneh2qRJ263peis9b4Wk+QDC9iGvheR9w7JcW/Lm2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=obf60L/0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obf60L/0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so40903205ad.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785221439; x=1785826239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u0WpJIoshG3z5CwgpXaTZV+mQkF9k5x9f64UzMVLTGM=;
        b=obf60L/03gEbaZ5RooxzdxaeNrg5ry7Xu/jgbCt3VkOI63dtd9dL5jaKty2eIK3HL7
         EAVfa6e92trWu/9UcZ9sYi9qGPWYQiyx8Wixm5KZjI9hcGTTRvHsMR2SxiSG13nK8Ew8
         DbFlZwY3aJPgOxKqThwhl+PKipuMvV3/5AJ0QVQsisba+efvhq8IpxlQ3Q11eYM4I5G9
         24xIzFtPg4bLQ4ws5uCg5ofxv07Eh1+H0aUPdArCaXn0LV0lmtzmOjFHKAXUYL4wowVo
         KxO3Bg1TCjRvAs5XzrTsqhUbJz756+QwZynYKogonGNlKI5jBpWxIaoSTeeappMoWSUo
         aHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785221439; x=1785826239;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0WpJIoshG3z5CwgpXaTZV+mQkF9k5x9f64UzMVLTGM=;
        b=J+VeVT87KeDTGQNQ07LEkCfFYY2ql+ODZmRL2LHk4XhIVzJMoJBlyKfe81tijmMZBq
         FuN1utn8bb7vjHRp0J+5z6ecHeUYWsjJ/QRzAKBH4jvtVTMJIFWcrtNtFgWcCPv0yesa
         h/QBmmy8UAsyEvoi7uNYXmndSREBbb4Vv9LA858cavuGxV9mBlKMXwQ4uq34ESZxr0Aq
         oUZGIt7RkoYqxV6NKt/TY7yvQIHBx+ndobZ5RzJenEvQbMKmcS3LkhN6uYKwVH6s3yuE
         18GYVQByRbQgdLVdahsxzrMvZFyX/uz8a8bpdN40456x8PubeKfL9rdecdJd5z1na1We
         DG1g==
X-Forwarded-Encrypted: i=1; AHgh+RqBUEi1v1ncwab9b57IGVm9k8GROKP8YJK25Asy/eD6EiuGkjTIE9ORRodlBC71kDma8kmS2Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUowCvkvCP9pRGNCWnVQ5oGnVJGRmQcCWHEjIETlTMBUpBWNIJ
	V/9Ma0wraZlTViZkh4TuS3k385wHtc7m/FVUZXOHbQHD++heKQiCRK4X
X-Gm-Gg: AR+sD11NJV88zAVmCDSKt1NiLK1q78HFJWTBh0itukAN64oL8u7BD+3vMvwokgU0HNY
	bZgo0oSXM8bxSWCvlPlSajXPPDrNeNIUDPyfOwGwR4Fi5bndm/XZJgcNhqQmgCwQvdP2ov9+8xj
	DnEfS2iv+5+rsCAjBHF+8kIjSjs+Qoi3zayBZsQ/TseK4Iox2Xhx+HQtDD1C8j9xJhpGnJ3T99x
	iITXGvCMySnq2THKEtb2AjBbV8XvNWG77nT0KCkrQdxOOkfiSI9e0nVvTMInYWDzg3pnR22LYai
	xLLfOwtUvuYK8UlBJt7+YUmJwAl+KHW6UQNbCaHm4MsoFem1i3aRlwXiOdjchMAD8xKisADHrn9
	/GtMxrOB2/2UB+fWoD2Q0kSF6MGzVWQ5A4Pj8VxlOsX/7jJDRlOCOP3gSoSKOPdMuiPPRou7Ln+
	Ca+yvON+6IbyRhp3bU7cNm5FiuUomKsHX3PUzvCp86JgU=
X-Received: by 2002:a17:902:f789:b0:2c0:e5ee:f554 with SMTP id d9443c01a7336-2d015ac7080mr13757635ad.8.1785221438608;
        Mon, 27 Jul 2026 23:50:38 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7ee6b0sm46545865ad.63.2026.07.27.23.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 23:50:38 -0700 (PDT)
Message-ID: <b17cab0c-3804-4322-90f8-b163686f76cb@gmail.com>
Date: Tue, 28 Jul 2026 14:50:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xfs: fix exchange-range reflink flag clearing issue
 with INO1_WRITTEN
To: Christoph Hellwig <hch@infradead.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org, stable@vger.kernel.org,
 djwong@kernel.org, jiapenglin@tencent.com
References: <20260728022310.99955-1-jiapenglin@tencent.com>
 <amgekiNKKoAdACnc@infradead.org>
From: m00nb1rd lin <ljp1205831794@gmail.com>
In-Reply-To: <amgekiNKKoAdACnc@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/7/28 11:14, Christoph Hellwig 写道:
> On Tue, Jul 28, 2026 at 10:23:03AM +0800, Lin Jiapeng wrote:
>> When exchanging two full-file ranges, xmi_can_exchange_reflink_flags()
>> can move the reflink inode flag from the file that currently has it to
>> the other file, as long as exactly one side is marked.  This assumes
>> that the file contents, and therefore all shared extents, are exchanged.
>>
>> That assumption is not true when XFS_EXCHMAPS_INO1_WRITTEN is set.
>> xfs_exchmaps_can_skip_mapping() can skip hole and unwritten mappings
>> from file1, so an exchange can complete without moving every mapping
>> that the earlier flag-swap decision accounted for.  In that case the
>> post-operation cleanup can clear the reflink flag from an inode that
>> still owns shared written extents.  Later writes then take the
>> non-reflink write path and may update blocks that should still have
>> been protected by CoW, which shows up as data corruption between
>> reflink-related files.
>>
>> Fix this by disabling the reflink flag exchange whenever
>> XFS_EXCHMAPS_INO1_WRITTEN is requested.  The contents exchange can still
>> proceed; the conservative outcome is that both inodes keep the reflink
>> flag.  The regular reflink flag cleanup path can drop the extra flag
>> later once the inode no longer has shared extents.
> 
> The fix looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can you add a test case to fstests for this?
> 

Thanks for the review. Sure, I'll add an fstests regression test and 
send it separately.
