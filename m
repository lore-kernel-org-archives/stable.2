Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DC17260F
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782171923; cv=none; b=rmstTNH50jiKXlJ4yiK5P02NUPgHEvTPMrR29fXbXNG19iuET8OwRnSvG1MHfVgOwEtOGU811STlJFtqH9s78kPf4F2MOElf0qdxo0e+wXfzG2uf8eN6eOw85Q68DJVkELHzpFTd2nfxFdp8OzzaLGIv4f0lq5eg2GkgX/EaEWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782171923; c=relaxed/simple;
	bh=J+2kftuOdC/Mvf2hM+A9T1xf1SRv9jCakY5GvO7YLS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMdHAZRuNFydO2KjkvfTTyivEoXaww/Zj5kK13vgr5ydh7LtzkEOKHYnVmKLwwrJ+J+oeoRvmg9wY8FaX8rFMfBIm9WePxQD0nX9BRmZF/wIZr2bPe/WUz0n2p+p5BKMjtAO+NDXUGv8kcy63lOYbh8hinJH1AvboLjjglrevto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1ytCcfT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1ytCcfT"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c0868ca8738so578512566b.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782171920; x=1782776720; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqciz2qlJ5KO2k38VZg83p2ecH48DGVORpzo6dgPKlM=;
        b=n1ytCcfTygDga4B9/Q+Dns9omZKDweYaz8N4aL6TYjqtfp9zqlV8FuvG9WVCIspo6I
         2N6T8US5krP2Avt+G4JwrskevjAT/xq6Ae+KoD8cI3gvaqrkCis0paCRLXEq//EW4ePk
         JsGmtaUjxUPNI0/5JWdp5qVi4eZbZIWbk/p0uZ3LPwVT/yuSJc2NREEEoBCShZ6kO3ot
         Ytn0u/V6DPysoYCL5YMgVCSOtTM08JK6GBFQSu5bOQ8CuO9njWE5OExYGMj1+ma/BwGY
         JJ3xeJNFPAZf78KOi8ZRkQmNVV/wzQVMebG7G/UVJDfqOgrc9mMGwegeiGymMhFA2hph
         xY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782171920; x=1782776720;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqciz2qlJ5KO2k38VZg83p2ecH48DGVORpzo6dgPKlM=;
        b=jbPmOgSv9yZlH4NoBj4b9gEAyjzMigk88W387Eo0mfMpy8cALRBpUQ33qYOrOY9hp+
         f3IUIDjrK0n/Y5blTsUqDbmiAO3PeZRBE/v7pZYoH6oaDSs+6F/+MOSmDE7O8e593oxM
         djndGEulbCkTeQDtdrx0zGCo8R3vEXCqxmy+mphyuxqF9Nrv3zDiqb7TfvWVj+eboxS0
         fRm8x03cl+EOGh8pj7ux+TmnwSlS12RcV4v2GGRFXbuL7h/UJHTaV4p/d9xDuOkrSKGZ
         1qMfXdSFgYCB9ypGiNFSUIWw2jXKQ7UjUuTVUO5NDl3GpwB4tAmnM47Me2IcZk1OWPNN
         AODA==
X-Forwarded-Encrypted: i=1; AFNElJ9IeAHgi1BRtG22s8Xf8CfKdaicL6RAw1Ac9/FZG3SJKWT+Zabm0awYd0NbPxHlWj9pvCTa3lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztkMej2o8nO9XYVeKD9IUcEArGXR+SKUCVu+tFiTDsgsWKL/h4
	cPSITx3pzEBzDcJSVxC+7418X50/mIlWEeZiAv4vfoyVgUuGJYe5nI1n
X-Gm-Gg: AfdE7cnwWx5FtiNu5az4tkdqK/TMrt+EMp4vvuiRz8bAQoi2lO03WT84xH6HHafrdlY
	7B8avdO8lXBL9Y6O7IuphtJ1ZwgHhBN/K6/sOdTaH+12N/N0f07k7RwLJ7MFxBTufhC0DTIZxiV
	xWR35k1QmHE8ygAvurokb6G1TqUgZimfd8q2K16IC0/GeCfibitq6Z8PBGBFPZG+gARrDZHsXLh
	bbwzw2iJtV7iGyXzoFwhcoA7EI2F6M9kYl8c8gyDEevhRDI5iMvrMLkZQBF7pzkaZIpjHxzyGII
	RgkrFQBFzFmj9gbdjEutnp4nJcR0YZqk9E/XPTKd5bjGnRDLL8af+N0TpDlTUwwxDAUrplYXwbA
	QpUuvB0/20z6nffKbjjxx9NCEb1e8bNY6H7t+lobPaWT0x5e+Lu9FHAW6CFBHKm6ovPFEEoEymy
	s03f77E5Y/lRI=
X-Received: by 2002:a17:906:eec1:b0:bfe:ed06:5a16 with SMTP id a640c23a62f3a-c108f60a8f7mr5710866b.52.1782171919729;
        Mon, 22 Jun 2026 16:45:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e998decsm422908266b.22.2026.06.22.16.45.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2026 16:45:19 -0700 (PDT)
Date: Mon, 22 Jun 2026 23:45:18 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	sj@kernel.org, ziy@nvidia.com, balbirs@nvidia.com,
	linux-mm@kvack.org, stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260622234518.nnx3r7ckphlxn5vm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260622130651.23359-1-richard.weiyang@gmail.com>
 <ajk0N3Aekapljaoh@lucifer>
 <20260622142102.pcmr5pftshj5lvju@master>
 <ajld6RKK02Vi-LxM@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajld6RKK02Vi-LxM@lucifer>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jun 22, 2026 at 05:11:02PM +0100, Lorenzo Stoakes wrote:
>On Mon, Jun 22, 2026 at 02:21:02PM +0000, Wei Yang wrote:
>> On Mon, Jun 22, 2026 at 02:46:40PM +0100, Lorenzo Stoakes wrote:
>> >+cc Lance, linux-kernel
>> >
>> >Your subject line is 83 characters long and is way too detailed how about 'fix
>> >device-private PMD handling'?
>> >
>>
>> Got it.
>>
>> >You forgot to include linux-kernel@vger.kernel.org on the mail, lore seems to be
>> >a bit broken atm but in general it's helpful to include that.
>>
>> Got it.
>>
>> So usually we send a patch to both linux-mm and linux-kernel? If so, I
>> remember is later actions.
>
>Yeah it's better for dealing with kvack going wrong etc. :)
>
>>
>> >
>> >Also is useful to make this [PATCH mm-hotfixes] to make it really clear it's
>> >intended as a hotfix.
>> >
>>
>> Got it.
>>
>> >Some commit msg language nits:
>> >
>> >On Mon, Jun 22, 2026 at 01:06:51PM +0000, Wei Yang wrote:
>> >> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
>> >> before return the pmd entry:
>> >
>> >Sounds better as:
>> >
>> >	For PMD entries that satisfy pmd_trans_huge() or pmd_is_migration_entry(), we
>> >	perform the following actions:
>> >
>>
>> Sure.
>>
>> >>
>> >>   * re-validate pmd entry after PTL
>> >>   * check PVMW_MIGRATION
>> >>   * check_pmd()
>> >>   * handle on pte level if split under us
>> >>
>> >> But for device-private pmd, we just return after pmd_lock().
>> >
>> >->
>> >
>> >	However, for device-private PMD entries, we simply acquire the PMD lock
>> >	and return.
>> >
>>
>> Sure.
>>
>> >Also can you please give some justification here as to why all this also applies
>> >to device-private PMD? Right now it sounds hand wavey.
>> >
>>
>> I thought below paragraph explain it. Not sure what justification is preferred.
>
>Something about device private PMDs splitting the same way THP ones do, in the
>pmd_is_device_private_entry() branch of __split_huge_pmd_locked().
>

Hi, Lorenzo

Thanks for your detailed suggestions.

I tried to add the justification here, and the following is the commit log
after consolidate your suggestions.

    For PMD entries that satisfy pmd_trans_huge() or
    pmd_is_migration_entry(), we perform the following actions:
    
      * re-validate pmd entry after PTL
      * check PVMW_MIGRATION
      * check_pmd()
      * handle on pte level if split under us
    
    However, for device-private PMD entries, we simply acquire the PMD lock
    and return. This is not enough, as __split_huge_pmd_locked() would split
    a pmd device-private PMD under us just as it does for THP PMD.
    
    This is particularly problematic when PVMW_MIGRATION is set (meaning a
    migration entry is sought), as it causes a device-private PMD entry to
    be returned with a different data layout, causing memory corruption.

Just feel this is not that smooth. Would you mind taking another look to see
if I get your point correctly?

-- 
Wei Yang
Help you, Help me
