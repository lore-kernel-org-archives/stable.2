Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32326059D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434662; cv=none; b=d9KmiDoAyRY8tfO8pjIpk7/EV3QJuavQKRAUCDYzUMcbyJLYWHXlgaFYsViEjuBv5KWTFuuRuIWJplKC/Ypw9ozwjaHt0eZ3AMJZ03LD9x74SvAq2uFHBl6Gv6kcyeYuxLhgBFUO3reXJWdAXj4h9U4+qrMKrsOGlRgACBaXzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434662; c=relaxed/simple;
	bh=iYlZ02g8BbrotBk0oVebMSyfQzLL2wzGu1p0fE+TqoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKirFWv78mBDdQ67u5xF/btz5U6lKF++M015G93wo7S0xGDtlT6hQ7HjFazwC7veEerPpc3bi3nkyGG5hCuVMGHNyG6C7oqJqbqmk4naD9wzsQoNZoiCqULh6ecZ/qZ+R60ykaz9tbfnfP2TGGYLcUr9QHfxiR6hPxeTb1ThTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4ZlWQmP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4ZlWQmP"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c0115a3794bso69552366b.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782434660; x=1783039460; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIoxXZTpiyNd5JYFa4lQt0gUtbR9irnlA4zKsBOidWE=;
        b=i4ZlWQmPA/otLIeIGbrI8jAKT0ViZ/QbxoZHDei2LFOgkQN29+HHoye0Q17FVyL65V
         kkoujfTnVJ6omNfOdauqyP1aImxZa3s7Iyvv1B2wKZOh4wD4IWd7hnxFROYa+O4Ycsm/
         WwlQ/obvct927ss+Qy/cFk8IWnFJTg+P7bl3IYqkhI2IziY+D1oEq/sSaOTJbQk3dvzh
         aSygtcYFPpB6gQVOd1MFUaLe7VsPeQvUi+48Q06LUFDqPUrVHPZ8jVJ/BgvjNju2+l6Y
         wNbC85FAbi0VTaKJis9IhIQfmVYdQnkU02XHbH/HVQKFKJK+L3A9DcAEHIszaUMJJ/ek
         HaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782434660; x=1783039460;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIoxXZTpiyNd5JYFa4lQt0gUtbR9irnlA4zKsBOidWE=;
        b=lPrMMG/nWS791o3Ph6GER55Uty5I3e1cTSfF2A2ijvoPKvP7P1Ve0+iIiXC7bAxTSd
         0Iw0XHg+29bU+4J0rzpF/Kf0f/e07Avhj/PoLKcYPsZRYMrPpISXXdiTxvWGeDqXE6Pt
         dRtCl3200xjJiFDKCc51VfzlLWpBXziDYNlzagt9CdE8x6dxQmCu+7aDsLIgyZASerXJ
         fPyNaERiyvVjfKm8lxOvQmwV5BamMr7/mTiUBJKPeJJdl5cXs3+6n9MZZjRd4ic+advz
         9T+d17YolfbYUR2l17H9wSnpOdGf/JI1bELMSUrRnAOce1QtTGAtz9XNP13GThTs3JXj
         pTAA==
X-Forwarded-Encrypted: i=1; AHgh+RpuyOmpgKal6HodvRPZrGLz7QLOL9fHr8QvPREyK1bWIxLQljx35aXwENI+AaRruqpcPfHPkmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxYUsRSEhl9+fAof+inI+v1woQdtkjPFE9ajmTY4Z52kiWPD5
	3ya48TxbN+6XFkhy6SCjVqYycPmP59XWVuwwIQUqmBCf9pa8HdlKMoH4
X-Gm-Gg: AfdE7ckxsqB2uVCKe3IpN/pjOnxod6K0qRWAIXpq90/C1k7CAy1rN0H7AfylJBCD0H7
	E3B4Xn9vWRSLUQZK/EcFTQIzPUIx491zUGFqaxZxzZUeUND80Ms+TkDpJmZYqyBa3YxE3lsNIMb
	DOA5bM2gc6Li93b4pr4ABUFI4LjnJSqvUrzJmvN7cfW+nmV2ZUS8BZtf9aobFaPQ/p8xu6BPvUI
	3cutn3Zzz++saq81nBjN2xjGHk8obJGQ1OtQXmkKU6TCUC6DxO6gWMqKiPJ5KeLoJHh7TO80QyI
	5EBoTpYeHeBGvVwATf/7g4wF8vvssO81VbEIZLb2IeQ1sWnvFcw0zsrOZWGyKSXOyInOouSdoli
	BRTyvjQs504QfvqjlR80G3GRLQL0zE8Pgn2j6kO8MF9Q6Pa23Vt7JepSnmCVENT+bSBBf3eI3Rd
	AXhkHKlfiNl/7IxjKEXeuOqQ==
X-Received: by 2002:a17:906:2081:b0:c12:20b0:d8eb with SMTP id a640c23a62f3a-c1220b0ea52mr34718366b.7.1782434659530;
        Thu, 25 Jun 2026 17:44:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe06543sm261224666b.29.2026.06.25.17.44.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jun 2026 17:44:18 -0700 (PDT)
Date: Fri, 26 Jun 2026 00:44:16 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, riel@surriel.com,
	liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
	jannh@google.com, ziy@nvidia.com, sj@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-ID: <20260626004416.vm4funxhn42hbi3c@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
 <38410976-ddac-4848-a4ff-e6a9f7d9c828@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38410976-ddac-4848-a4ff-e6a9f7d9c828@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jun 25, 2026 at 09:12:23PM +1000, Balbir Singh wrote:
>On 6/24/26 16:53, Wei Yang wrote:
>> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>> device-private entries") introduced the concept of device-private
>> PMD entries, but did not correctly update the rmap walk code to
>> account for them.
>> 
>> As a result, when page_vma_mapped_walk() encounters device-private
>> PMD entries, it takes no action other than to acquire the PMD lock
>> and exit.
>> 
>> However this is highly problematic for two reasons - firstly,
>> device private entries possess a PFN so check_pmd() needs to be
>> called to ensure an overlapping PFN range.
>> 
>> Secondly, and more importantly, if PVMW_MIGRATION is set the
>> caller assumes the returned entry is a migration entry, resulting
>> in memory corruption when the caller tries to interpret the device
>> private entry as such.
>> 
>> In addition, commit 146287290023 ("mm/huge_memory: implement
>> device-private THP splitting") allowed device private PMDs to be
>> split like THP mappings, but again did not update this code path.
>> 
>> As a result, we might race a PMD split prior to acquiring the PMD
>> lock.
>> 
>> This patch addresses all of these issues by invoking check_pmd(),
>> ensuring PMVW_MIGRATION is not set and checks whether a split raced
>> us we do for PMD THP and migration entries.
>
>Should be PVMW_MIGRATION and "us we do" -> "as we do"
>

Hi, Balbir

Sorry for missing your comment.

Hmm... looks you are right.

Andrew,

Would you mind handling it or prefer a v2?

-- 
Wei Yang
Help you, Help me
