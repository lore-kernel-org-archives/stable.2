Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157D4F4741
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954458; cv=none; b=GEAdLBOZqX+21ZJmaIzjrLouwAUfx1f27qy3WcKwNPm/jt3xAXXHs0oLuGojnmxBkmzGcDZyHA4EM3hGJMU86NSSul/EPGj2GBaXXJriXyLbqFrnjjCyuXWnjc4Slowc2jS1eBewMdKNh8+xeYqPVPvacKowin1YFjVsJCLwsR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954458; c=relaxed/simple;
	bh=9H9sRGfp1ZaqJ3S1urVyd0m8mUDJ79HN5v6laHL1394=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pc1YVXM2DH92ldGi58Np+WlUSQtb+IQIi5H5BqH9m6l9Riz+BcAWCQRet7HB92eWFJ0wENOV9/pNNasa2/vRLfJKcfSgUk2t7HkpfEwhzdlSA8WPJ3wazxQAAbcTWTK03cWeuSmxgAgy/8CjwF1kUKHeKWb6ET6A+8OGSvvAe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O4pxxQMO; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O4pxxQMO"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso1416725e9.2
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788954454; x=1789559254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TIfeIpZ4OJ7Fe6X5EWfuqkVso3+rNzjQrB57cPZXMxU=;
        b=O4pxxQMO41+iz3VtN/jJVBbJttTgikeiSsv4Ggre72YYrMJ/tDXZ7mOeUN6dOkq6/E
         E7K0POFY+g45BGV0o17tEoN6NdZr10gTj6YAMXZIuOIPudeASHrRG+J16oT9fCt53AcH
         gzUqXV4qixX9YI8unNjt9tgolDR5HE8ZvF9XlGYcReqGQQRNMp9DS+Kre8P60QrAnSWE
         PnauPaWZ9WjN+FEHpxU5nlP4rx3EqBNsD26OKsTY4dJ4fpwMWRI0VflSIbEdmqLEgJge
         ycZ4y7DuqRIty1H8x1gArtr5vLmagNSOvd+HWjf0sykbdAw9LWjGMbySmEfvU/QWZof2
         ff6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788954454; x=1789559254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TIfeIpZ4OJ7Fe6X5EWfuqkVso3+rNzjQrB57cPZXMxU=;
        b=Py7gmW64Oa/uwYbJRw0s3hFu3Czms42E6RnBdvc3GMjA3+LLQg9q+kVu6iDwba2QzE
         mOY95PIkrJncBOD2x4A761K3U44lrDxs8h77xUidsfF9o8LOZCgDxRj0dv08u/h0uaPO
         Vvo7sC9n1+hR/KjLyhVNDe1CdmAhL+1bqylZQn8qsk+RJNaU9ee2IsnkbSGOM7i3QjNl
         jnZ1dFfZDGaoNOgHebavxj2t4XChkMlrDYzWdOxdWRGybVyWtq6cmcFOsust1DA0agSe
         E6FmltCLTj8QYhZMQeOPxeRuyfSrb2aJNXX5vDr0+lnSou+m0dGIJTERLeaMn2aLlhxn
         2m8w==
X-Forwarded-Encrypted: i=1; AKwUvBzwIL499Ycrl2bSNM9IZzw6x+C4nsVQsQOxgj+dzuty0JmZ4bWrDdFAJyFNhXlr6qGNrI+t8e0=@vger.kernel.org
X-Gm-Message-State: AFuF++ki2zD4XueFhHeHt6pMho2XLTDbFw849f5f26rUKjcEzfjRbn1b
	WCErU6ej/UYsI4faea++XYrt0mUA0LdeqNdt2p/mTpzsKNikn3eAblUd9U1bAunyHmU=
X-Gm-Gg: AYBFou1MPNeFpmwPpZ9zSp2ySjSVgs5CSPmowrgW793WFO+hTUP1tMMi0DWwc++Pssh
	iqX4UutcM3u2UoDFJF2Q+IUN4oHwQFQMlkF3pc9PRk29yYPtYPqI3Tv4R0h3fW+a+BLM5qL/hml
	V2I3kpG5jlgiaPMzDt2q1X8PA6RiM7u0NpdFJotQ/jAAs4DuWUQCabkSSNK+NbwVXJApEXq9Cz3
	PH1xGoTv743CPgv7hdxtdRtI16dJnYQ3OVtYUQI8WOhRNB0bPUIxln9cDeEaJr7uOB8YM1mHk+W
	tly/hf3vXpUE8/8GNTzcCc03J2WC+QSJVM27yihBcRs4eGWNHtdcfxz3cwQ5JLfmIibAtTmiLQa
	kddv6euS4RTsZ0S03FO/H7wEOUA8r108nDFy1o2SOicNEuUtxFqr5OBtUesP67cWdEFlMEIndxQ
	jTSB2g57+n6WVQ+bD8zSaG+e9TzbWP20V8/80Fyn0Ax257cJHvSrTRgUrcFSvsB/5SjdZWIXwQ3
	6tcd3UAfgYv2icaYKOmLO8dDEBstBMhLBA=
X-Received: by 2002:a05:600c:5307:b0:49c:f617:7cf with SMTP id 5b1f17b1804b1-49d25871d73mr12852825e9.0.1788954454028;
        Wed, 09 Sep 2026 04:47:34 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm1017732865e9.15.2026.09.09.04.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:47:33 -0700 (PDT)
Message-ID: <eef32841-26f1-4ea3-9915-67a60ec2752c@suse.com>
Date: Wed, 9 Sep 2026 13:47:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] module: allocate codetag sections before the
 regular module layout
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260908092412.115953-1-hao.ge@linux.dev>
 <20260908092412.115953-5-hao.ge@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260908092412.115953-5-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 11:24 AM, Hao Ge wrote:
> Whether a codetag section goes to the codetag region is decided by
> layout_sections() and asked again in move_module(). A concurrent
> load can shut profiling down in between, and move_module() then
> copies the section to offset 0 of its regular destination,
> overwriting whatever is there.
> 
> Decide and allocate in one pass, before the layout. Allocation
> errors fail the load. On a tag area overflow profiling is already
> disabled, so -EAGAIN makes the section fall back to regular module
> data and the module still loads. The reservation is released and
> module_tags.size rolled back, so a concurrent load which already
> passed needs_section_mem() does not skip vm_module_tags_populate()
> 
> An SHT_NOBITS codetag section is zeroed explicitly, the tag area
> pages are not zeroed on allocation.
> 
> When profiling was toggled off the overflow check did not run, a
> module could load with more tags than the page flags can address,
> and re-enabling profiling then silently corrupted /proc/allocinfo.
> The check no longer depends on mem_alloc_profiling_enabled().
> 
> Based on a patch by Petr Pavlu [1].
> 
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/ [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

This looks ok to me from the module loader's perspective.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
