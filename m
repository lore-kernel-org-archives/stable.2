Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE93C1086
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538223; cv=none; b=RcLKcUL8DeAb5GTrWUcU5DXuy9jneZftj9HXMpR72lKsa3/1ozaCgHtllrkOsKquP3yP6lfzP+DmznSofE1kyB1SlB7Z7p2RjxX/1TxCu6KEO6k5cqaNMRDumY/Y3+1S5w/8qVFn2CCIjBeUcT0lH0kFY2C20AdaiDuPSOT36nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538223; c=relaxed/simple;
	bh=vDfrPOwWEchegSl2fXTFH6NLC2+0Iy7qk1OaiikMJxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgngUvzriUM/8hfzRq0LONjOskmDah7ZJ9hABQ/1PraYAzHWcI5a3SCiLrjMe0all7D5jroXCku6PuqMjaNLeO7BoN4mipn1kzaSRTsqHehgROt4EsSvNUfzcTrtHyY/2pyuY7B6ivhYM/G99FnoRLSp0/+FMH5s/llSGSnMOZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cDtCUJhk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cDtCUJhk"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a601ba6870so1954873a12.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788538219; x=1789143019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e1Eo3Xs09Cv3zHO+VFGveYQjtgcEc68O1MBEL+U3hM0=;
        b=cDtCUJhk/k0/HUjHFDUhAECM3lwqvVRejuZzX3ZCPL2YXReb6TMHgf/DpdP5bPeKCX
         c7tSmJwUNvm3Takfu67jXHghTWTFzNW0jheW7gcOJgiuJ1snm7ZCa/7mSsuiV5XTHw75
         PUq7590agvanyM6EkKUsb03pYwM6XLNVxsNdwWrkICmdOOhP8yrDUYFtaxgbyMQSpfrC
         3VDCYQCPCZ6tqgx9nGmAhF1qnoi8GNpody0rOKewWWvCrbyWKMn23lrFjOhqkZyntyjt
         ChJrre44Rkmp6nNjLwRMUjoVM6Oy6XzT/O5soX4QWEwimT3LpaE6an4pFx9MVoNxnG7b
         aC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538219; x=1789143019;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e1Eo3Xs09Cv3zHO+VFGveYQjtgcEc68O1MBEL+U3hM0=;
        b=Z+mQyPoQHU/20RWVolvjtS3IJxaUaY+6xJK6cOded6DCe0HszHh49igevm46IuUn80
         UpC8HUkyNZPhKtnjy2fsoy0BDJIecNE5zHRWq+PVmpkPzANsrOPYZ/n7rx6eoALJ5u+l
         F6PxXwuIYpC8xChc/L3YLyAA6zldhcBkM/CxfFcoVo02oJn2L9eTcERSagx7W0MhyF4M
         6Ry+05aOW/dsCRit8MJw7tJZPHgDOUXn1raDsFfYFUzulxdkD9qOWYlflDINX9JnWDtc
         5qcB4BrwtdkF0/HP6sGNKvFoIrOVTpNqVJ3E8MIDIX7/MhUKo3aOfWFr9dJTHSC+g4a1
         T/8w==
X-Forwarded-Encrypted: i=1; AKwUvBwlhkZyQO5ENxooH31UtegI7EpJf0+8eM1376wPUHHz0g3TeBh5rsmUUq6jWWRk9pHEOqljniw=@vger.kernel.org
X-Gm-Message-State: AFuF++lniKdcaYilsQqsfiYfCD/Ep0LIVSuJ6GFqnHuVYtQ9HSINSg+4
	QhR25jPwxYF2KNuoDdpHEoKGU47qXTAMwQCfNhJqzS7b8Py4RB8pK+I+E2xZQDB54M4=
X-Gm-Gg: AYBFou3bSzzGyKRM7ikhUC7bsJ6QpYGZ8ZsEYQu2K4+7Ys1zr2x734kcg7kBnBDKOGt
	kACnJFRoCwpZm+kXhU6LBKnuMBt80kNY+OQ24TvERHKswg8BIuXo/0PDloEBTP2ZOYCfFXd0Tsy
	Oc+fFWaAbbmdtHrWF9FFWNXht9WOtb07EFf8gpmsUoqdA61Ab2WcMsryQw76OlughDv9NxqFxE1
	Cz5TNWNrUfkDd/DiiEClFo4BfsAJdGGvLF0BkEtOQ31VqhlohU5tO6uQGk6u1tBYi35EwpBU10C
	Y//7SZSjbNUxIoqNmqvvqcSXahW2Fihg/4E9wcw7smCUUw18X+n0zrQlPOJ3KCkujeAqV9jb4Bq
	Ipz3EeZVafogO1uNibbWkBn9woizLcOA2v6qUKd3eA2I6TtSaIBhNdHA4u64jumHQNQtrZLcO/Z
	WJl41sn6ibC83+O3/L+tQ0uBq8kci1oCGBKv9U08WaLbJPT9wEeTO4kNpQXrt6kGNxel66ilfVb
	wVS9jflvhi5uivpq0MIE/1y
X-Received: by 2002:a17:907:c00e:b0:c25:254:292e with SMTP id a640c23a62f3a-c260c401012mr368173466b.0.1788538218984;
        Fri, 04 Sep 2026 09:10:18 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d53e0b1sm126030366b.33.2026.09.04.09.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 09:10:18 -0700 (PDT)
Message-ID: <d2159a62-d64b-4e47-9e5b-9c409ae4de9b@suse.com>
Date: Fri, 4 Sep 2026 18:10:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] module: introduce SH_ENTSIZE_STANDALONE for
 separately allocated sections
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260902081802.146145-1-hao.ge@linux.dev>
 <20260902081802.146145-3-hao.ge@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260902081802.146145-3-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 10:18 AM, Hao Ge wrote:
> SHF_ALLOC means, per the ELF spec, that a section occupies memory
> during process execution. Some module sections occupy memory
> outside the regular module layout, for example the percpu section
> with its per-CPU allocations. The loader currently excludes such
> a section from the layout by clearing its SHF_ALLOC, which
> overloads the flag with a loader-internal meaning.
> apply_relocations() needs a special case for the section, and
> find_sec(".data..percpu") returns different results before and
> after layout_and_allocate().
> 
> Introduce SH_ENTSIZE_STANDALONE to mark sections with a separate
> allocation. The percpu section is its first user. layout_sections()
> and move_module() skip marked sections, and apply_relocations() goes
> back to testing only SHF_ALLOC.
> 
> No functional change intended.
> 
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Based-on-a-patch-by: Petr Pavlu <petr.pavlu@suse.com>
> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
> [...]
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c32f1d370b73..078dae188aba 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1618,14 +1618,8 @@ static int apply_relocations(struct module *mod, const struct load_info *info)
>  		if (infosec >= info->hdr->e_shnum)
>  			continue;
>  
> -		/*
> -		 * Don't bother with non-allocated sections.
> -		 * An exception is the percpu section, which has separate allocations
> -		 * for individual CPUs. We relocate the percpu section in the initial
> -		 * ELF template and subsequently copy it to the per-CPU destinations.
> -		 */
> -		if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
> -		    (!infosec || infosec != info->index.pcpu))
> +		/* Don't bother with non-allocated sections. */
> +		if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC))
>  			continue;
>  
>  		if (info->sechdrs[i].sh_flags & SHF_RELA_LIVEPATCH)

Please keep a comment about how .data..percpu is handled. This is not
obvious and should be described explicitly.

Something like the following:

		/*
		 * Don't bother with non-allocated sections.
		 *
		 * Note that .data..percpu has separate allocations for
		 * individual CPUs. We relocate the section in the
		 * initial ELF template and subsequently copy it to the
		 * per-CPU destinations.
		 */

-- 
Thanks,
Petr
