Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755051;
	b=kSVPoUnbIjW7P12lboZHT+C6y9i4/UVWt4CIZ3AnD09B8j6XIMS0Pq6FG4Zf9FjvNwD7
	 JVrniWhWuxqHvajpyz6YddXMwdbGzZRU/75qk01wQNTQ1lIQpcNXDM5BwwvC5Km/s6Ozc
	 ZcOddco/gK4eyE9l3kwgyb8oqJbL8lHmmcZqvzsfw6FYTSrfRRI1xSOlZORwOFmHPWMix
	 MtKmPQdnOhP3sHfAeI6cyCnu83j/TQtIRw3DwjD8+tg/3AEUlDxcGiR5EkBmTWhRzBcvV
	 hUdJEbiKQjIQPU7D3Jjqt8ut01TLwadMiUeZY/2a028aMAk3MKbQVEEa9ug/c1M7fCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cm1ZQLsGovKO+P8QmmyFaPVIQNh00JlvvBw/TqlEjIs=;
	b=2F7b7L9YO5p2GmlvaSew7NZhYJflcPU13KY1GxfagvHGj76oKX74t6UyuQtFXZytuvJy
	 CKYzwCoiqdChbFNDHWmu567lagLeFJOh9x6h3kL4GGQja/WadoK9QukDYGEZ5M8eMl5Tc
	 m2EdXY5PYMN9nw8ITUCEWRE5OfuopB4dEajb41ZHCJNiAznQ9dXtZnVdTBz6twEkj15vA
	 dKJ6lSTKEliYtNiSS8KCvRQ8KUm4eOlnhGnLnV9ezDzhLgmTwcMFUglcq/kxH3MCmQ5rG
	 ozIGkBpGH8IJf1B2XbeYfvr0bDSXI+iFdlO50AWbsQ8e5zqSOyOaWsZzqD+VdzE9llw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4+C74hN;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209F606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 01:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C209F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r4+C74hN
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9d7791b00so1184375ad.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 17:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755050; x=1794359850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cm1ZQLsGovKO+P8QmmyFaPVIQNh00JlvvBw/TqlEjIs=;
        b=r4+C74hNy2J107k8QWxXCv3v3lNRX1ZF7IkvLyMlO5Sw3gCYbneWz4mJmQDKQNGeYB
         216tGkq3KEO+o6nCrAW0KCFPNw9CXClLhlM/OwSGi4laDFWTkLR5G8KmagtrrAAAhu58
         1dM4r/hjrdrL0TE+sTf2XEODhKDlexutW2kYpIFp3ULoGQJzGShf87DihBIaApiRiAaX
         LgbLu8K8bxUAaIkZ7YPUmtTqn3egH+G06cvvg0O/JYUlF/vK2E5hLlXAiuZ0jIiRYEse
         j7y8SwgpMveSTsr5WIZEreyVwz2EG4V/yyZMRioc7oOFOzV2bhI6rCxcRymJp6FtQUYT
         Hq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755050; x=1794359850;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cm1ZQLsGovKO+P8QmmyFaPVIQNh00JlvvBw/TqlEjIs=;
        b=fkJydZDziOO8Wcq8HnzZj75Qlh4uu/m4kj5/6ESz+usHRVpUTdO0W+4c9G3XrXOYr7
         rQ5HDWh+lf4RJrbjAmaTdr3iSdsV4zTPWGJDFDe79gH5QoIkF6nHKpp12jIZFqD6NHfM
         L6aKimUnmWDVzAU3WvuuToBN5qDP7p0WjsHbJiElZvjmF8JcGbL/QU+SPMZ6H25kZc3R
         lN19BWSpMEA6neJNkIWkzOStmF710uX7yjmzz3erhVBJ/fHZl/nGkwefGys0YOiZTaOs
         hzLylmxjIciCrMCgeY5x0O9Xl7LSJo4gd9AscuzUTc0NZN1EUP+a4SS4HcLCWCZNJAle
         v7yQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbxzmu6FRPvmXgd4YhWNkdOrVYVpMLo0ruMoo4nK4ixAR8t9OMSLwzG+sEZo45hBJvBgRrTD8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0cG9GAp8Mxq0W5HJIkR4ezeYZ1ckOoY5F0/m1LQ340kRfu92/
	MZhnLTnC0oIjUTkCZfj8wv50WE0xYG+J2SQr1aNcOMZ9wx0wOPDXH29X
X-Gm-Gg: AYBFou0m6CO4hXBfZJ4hcrtcxLZo5qxH+P8wMW963sab7zK2XJ8bkxN7NqvtkwwBq+W
	IleBVVcTyWgCYUsuSFyXSVwf/HJIa8q7qk3j18GGR8BBfOHqcSA1Ur/3GaALKkVUhOQrIsPV0Jd
	sJrQH+vgf79Lv8jdEQclrJNA/GKiWGOVEQDFKT2atw43tkQ19/U0IIj3dent41ODgXUW/6c0tyV
	Ob/s5poLrDYNU1RcSPQhoO8XDZKKH9NsH5+zFndb6jr60CCGDb+umSszw4M1B7iaQrfAPf2gVc5
	vH0w4CQU8Sb+DGPn54rxC+0NpxSK5v04Emn3dgVX7zkzHyBy6uLdFZfAZdLCPLco857xr1+71ar
	JnMXOiL7rATVigzhjYbKcbk8sW8BbjD2ywUvEdwkmhF80q1GFCkHD+V65U1lnS7dgarJetoZbFC
	sLq+DguYSM9jx9fKCPjUcq5cX0cULUCGD3syt2xzHc9WqLcWPOVaQsyyjTBqKOQ90p0BJMSAIkc
	ailfAjhd8KFkCa4hnYutpHj1MZS5GTnnCv0Ful64l9a4y6URhSYWXNcOYdepPG1ff5itaJPlPea
	YfBMZlq8ISwd73GnE1uaOYixhzxZpDdYbpsA9VHkBXo=
X-Received: by 2002:a17:902:ec85:b0:2e9:6788:937e with SMTP id d9443c01a7336-2eb364d1716mr124879085ad.42.1793755049997;
        Tue, 03 Nov 2026 17:17:29 -0800 (PST)
Received: from [192.168.52.49] ([2406:da14:ac0:7d00:a5cf:b1b:97dc:3084])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed091ce09fsm741905ad.68.2026.11.03.17.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 17:17:29 -0800 (PST)
Message-ID: <9bb64032-09ce-4ddf-81cb-206bb85b9be3@gmail.com>
Date: Wed, 4 Nov 2026 09:17:24 +0800
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
Subject: Re: [PATCH] mm/damon/core: reject empty access pattern intervals on
 scheme commit
To: SJ Park <sj@kernel.org>, jm5905938@gmail.com
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 error27@gmail.com, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Liam R. Howlett" <liam@infradead.org>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@kernel.org>
References: <20261103145319.88120-1-sj@kernel.org>
From: Wang Xiaolei <xiaoleiwangxiaolei@gmail.com>
In-Reply-To: <20261103145319.88120-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi SeongJae and Aveline

  Thank you both for the careful review.

I appreciate the clarification that DAMON simply executes what

  the user configured, and that this is more of an input validation

improvement than a bug fix. Perhaps I was too aggressive in framing

it as a bug.

thanks

xiaolei

在 2026/11/3 22:53, SJ Park 写道:
> On Tue,  3 Nov 2026 18:54:18 +0800 "Xiaolei Wang (Kaihong)" <xiaoleiwangxiaolei@gmail.com> wrote:
>
>> DAMOS schemes accept access pattern bounds with min > max (e.g.
>> min_sz_region > max_sz_region).  No input path validates the bounds:
>> damon_new_scheme() stores the pattern as is, and the sysfs ul_range
>> stores are plain kstrtoul().
>>
>> At runtime __damos_valid_target() evaluates "min <= x <= max" for each
>> of the three pattern dimensions.  A reversed interval is an empty set,
>> so every region fails the check and the scheme silently never matches
>> anything: nr_tried stays zero forever while the kdamond keeps running
>> normally.
>>
>> With such a reversed interval, damo starts normally (rc=0, kdamond
>> state=on), but nr_tried and nr_applied stay zero forever and the target
>> RSS does not drop.
>>
>> The same holds for the watermarks thresholds, which must be monotonic
>> (low <= mid <= high).
>>
>> Validate the access pattern and watermarks at the beginning of
>> damos_commit(), through which both new schemes (damo start) and online
>> updates (damo tune) pass.
> The documentation is not explicitly mentioning about the inputs (min > max and
> non-monotonic watermarks).  But I was thinking it is not really difficult to
> infer this behavior based on the existing document.
>
> If my understanding of the documentation is not wrong, I find no problem at
> accepting the inputs and just behave as documented.  It might look silly, but
> who knows the users have a creative reason to do that?  As long as it is not
> causing a harm, just supporting it is better for both users and code
> maintainability, in my humble opinion.
>
> Pleae let me know if I am missing something.
>
>
> Thanks,
> SJ
>
> [...]
