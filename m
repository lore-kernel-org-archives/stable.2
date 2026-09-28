Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ABA48E0E5;
	Mon, 28 Sep 2026 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588683; cv=none; b=FfefQnLyzX71eCN6DJ8rLIgp4rNkUUUVCuGp3Zicpd6fUmfa+b6UE7Cs5JhIAVqaxs6HLX9lIQembKdmy+rWJiJOZekGVZoTfRglEAg+Mt/reE/ptwoksr0eRsRPe3Fga6xZLFrC1u5mKxl+OelAU4c9Yf929UECIR545CX4uqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588683; c=relaxed/simple;
	bh=B80cfQtZsYFy+aWvfBgvTKX1wndMaRUPLxucWQyAa84=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kIBfVDzVpNTX8GBlH4r1X7LjyKN2X8IiR9WGQywUf8YP/hrcECrAEj7M/ri6ERGFwYL9vZ8Tf4jMmJX6FxZ8DFC3ylmqg2zYs0c0VSmH5d8F8E875s0bqIXP8EOuTWLjB4poXY/DBv6+ASu7DXA0yMeYZGaYH08Ab+szo0JLYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf4ZEz5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf4ZEz5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4222E1F000FF;
	Mon, 28 Sep 2026 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588681;
	bh=cLESQF3rjMUCtRBzlz6Cq4XFs/FDXdnSpGyicIDHRLI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Nf4ZEz5jJHFycOt0zJmIyJtGCfQWiTZ/f3kQmyh1zW3HScauz4OgPJEgd6yLKRpCu
	 xQ0X6UCrPJorR9tVuiwJfGjs0dGuZOf2w5+33HbExtmZ8JLAlnJThITDOoDXCYuLUx
	 ZjmY8tazDoo32Zb1GC9t6VYtnVaUzN1thM0z8D6jG9lgP/FUSjT7DbrKEedtAfu8wx
	 ooHYq6l3GQhyJ9MnNrOzjUAZqeeIeJWjWzudldZTjcJEM31ST4MtL+3MufQWPBsuGi
	 akPfc3IzAua6U9ZABLvhW6cdjbPvftfT/3j73iRTD+ZYUtmQArLZfj9nqdHE8kHAvo
	 lvBxlC+qgRiGQ==
Date: Mon, 28 Sep 2026 11:43:38 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
    "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
Subject: Re: [PATCH] sparc32: don't clear the nocache pool through the PROM
 mappings
In-Reply-To: <CA+=Fv5SEwB2b2On=2kEWq2hWMKVauDZ7wqa6+6xPD5nmBgGASw@mail.gmail.com>
Message-ID: <5fa4f6a8-062b-44b0-b426-67298acad4b6@kernel.org>
References: <20260927005801.8338-1-kaloz@kernel.org> <CA+=Fv5SEwB2b2On=2kEWq2hWMKVauDZ7wqa6+6xPD5nmBgGASw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-329603338-1790588622=:2446"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-329603338-1790588622=:2446
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Magnus,

On Sun, 27 Sep 2026, Magnus Lindholm wrote:

> On Sun, Sep 27, 2026 at 2:59 AM Imre Kaloz <kaloz@kernel.org> wrote:
>>
>> srmmu_nocache_init() runs before the switch to srmmu_swapper_pg_dir, so
>> lowmem is still reached through the PROM mappings the head code inherits
>> for KERNBASE, which end at 10MB on a SPARCstation 20. The pool, up to
>> 5MB and allocated right above the kernel, was cleared there twice, by
>> memblock_alloc() and by the memset(). Once the kernel image ends above
>> 5MB the clear runs past the PROM's window, faults, and the boot CPU
>> enters error mode.
>>
>> Every user of the pool clears what it allocates, so allocate the pool
>> with memblock_alloc_raw(), after the bitmap so the bitmap lands below it.
>>
>> This has been broken since 2.4.0-test2pre2.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
>
>
> Very nice work, this makes a lot of sense.
>
> For the record, an unpatched kernel
> (carrying only the patch series needed to boot:)
> https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.com/T/#t
>
> boots fine here: SS-20, PROM 2.25R, 512MB, 6MB kernel image, nocache
> pool at its 1280-page cap. So the PROM window is not always small enough for
> this to bite. Happy to dig into what this machine actually maps and report back.
>

Thanks and looking forward to it :) I suspect your ROSS PROM behaves 
differently than my standard 2.25 here.


Best,
Imre
--8323329-329603338-1790588622=:2446--
