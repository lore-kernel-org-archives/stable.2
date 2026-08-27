Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7996239EF2C
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817057; cv=none; b=OgZwklg9CkoRVYOfc7baqcj8InsuGfulhbVSxZ7NCs2rjv38Gjzm7PMss2UHSOeAIvbSnnbmYperhCy4rFfASwZyJIncWbKk2nnNoXIXVJnvV2tb7rOSb9h+fDnvVQWZEC11XItsznY1cQevgEnzcS0DNX86ml2zpfYpQl5tX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817057; c=relaxed/simple;
	bh=o9SfOayrWajRW/+NG/zMKHW/ffcQ2S0g3uodt2BKZtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jntgumfBT6gw3UnD4W9aAZDtQ4i7JEqGFcFf4rl0An3XIB3o2N4btFYecyt6/c5Qr06JAYI/ovSUl3YaWqDd1a5dkMC9Cw7YSX/OYAllhG7Hha2kw6c2nZ8L8NkjGorIWbwXe+tt2FGDNHCGp4F6ykoc/oYSzM9un9hy1bUwQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20251104.gappssmtp.com header.i=@monstr-eu.20251104.gappssmtp.com header.b=Us1jmtvQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20251104.gappssmtp.com header.i=@monstr-eu.20251104.gappssmtp.com header.b="Us1jmtvQ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c250f28f1cdso311438766b.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20251104.gappssmtp.com; s=20251104; t=1787817051; x=1788421851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TC/uq2OAWBJlRWDS0+FgLZUaW3+hNg8rcbu4E+WX7w=;
        b=Us1jmtvQ5pmBNvHxw8AS0DXXd2Q63sIGJuBeYkO4Qz3HOZFdHzVohMwPxz9Y0xhPQx
         FXcGbF2HavRovHFtKDHIMgYQY1qzvIzhf/6NuYLMuZdg4neRhdtKMV/Q56FtL1h85Vcu
         g/ID7qaw6izcA8x/+7gLznEmxsDrwSj5Ng8P7knMZu51YjVizOTwQDkRumMP9uOXYRfd
         dyQKdLLfSvUVs52Xb4a9hu4li/+HWs/YmhagFrWH+bY1L9u0SRSYK9n0ResDrDPU53r3
         3nz0B59yvpWSlt5OBbTU3m0QDvhx2sbDwfRmahfUaEPncykrolIpuUG0Ayc/EPZlNDUM
         kscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787817051; x=1788421851;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3TC/uq2OAWBJlRWDS0+FgLZUaW3+hNg8rcbu4E+WX7w=;
        b=mp19RRNVu/rYG65NsL5VxjYnHUXjNfhaymQ8HiI1bGac4wZHsrCmCVhdEMzcjDmdUG
         IZXkfm2jLB9Z03aduL5nOzE8DdBRgxGH53ZUXDQExlLcBPInM4rJAhrT5inRxkHW7/O8
         K0vgZlK0yZLBDDcJsZw9KG/yJiXDJG4VVed9EbilupgrPm1i6vQYzLKY5dfieH2Fivdz
         KPLysSsfItAsB3fUgP46ca8V3+K8p/DMHXTLwTP7iigktAhGT7N8QkOeSHZtxLMcyGZS
         ZSQKZbgD46ovuWDAXcw1LQZE/6kLh8r5UXj8AA5owcHhfPRTsNHfze1vPMyODhhsOj63
         4/YA==
X-Forwarded-Encrypted: i=1; AHgh+RqwfiFXPZlGeG7BGthkoaD0ASV4E8LLmgu/L6scRXEUMOmnHOQ0QH56Z4yw4w/vv2QjgjjTSpM=@vger.kernel.org
X-Gm-Message-State: AFuF++npeTMPKUImvRwoafqLA7h8RMz8K3HjmGXh/dOjHhOi/RevUY1j
	V+bgJ2OduuHr5mTQQo08RChTl2Odagh8rizzx+hyM5RmEYSdHEom6KYDN8qdZ1DbPg==
X-Gm-Gg: AR+sD13Z5mQZCW5TZZ2V2QfQ8x+/f/2Vz8vQ84kwtZ4tdtnLf57CL2xxDA2kdAFtQ7i
	qlRAHr38U9XqX9wxI8XbUejr70gx46iDtyJfZUtsmJ5cGc/GtuN3diB4IkEsPLufqmsvTdZEWTw
	G3QKwF0W45oNYg2pJAexjfSHP2VeLAdQThrap+pU2D+vXGBDsBQFUKPUd+Tn6GTZToI/RIUuytb
	DtANsHFS/WlkByun5pWUJrhou5X/yS+5FbWhGEK5dDf30TNMcMDzAchGl/+iQK5ZpgE0RjujT1T
	KXmxlfV4r8BqJ31Z7djFuSKU1N9OOuXmcuQIrlm9okHemWRVJBcfS4x54naqF1DdfGZ0SeCsJTz
	6s1O8pUluycG8NGVVSkABdoxhKfyK3KH071Z6Dv+4iQ7cAXplUkiNUzTOG0soRviYCLNElwS5Hg
	5crjFfWoeUw9NRNha+k4enMg1N3LjW/jMab+vYx8dUlElqoy5Ar6MgWYQZTIX7hZFytw8yrNXnt
	qHXwr+MWaT8PtRDmUPG5Q==
X-Received: by 2002:a17:907:930b:b0:c24:680b:3944 with SMTP id a640c23a62f3a-c250c330febmr1350343566b.13.1787817050958;
        Thu, 27 Aug 2026 00:50:50 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a722400sm652641166b.23.2026.08.27.00.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 00:50:50 -0700 (PDT)
Message-ID: <702a199e-6439-4890-9dbf-0111aa76aee1@monstr.eu>
Date: Thu, 27 Aug 2026 09:50:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] microblaze: Fix MB_MANAGER build with older binutils
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>,
 kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260813024026.5402-1-kmehltretter@gmail.com>
 <ao-3jrT0aP0_fSBA@gmail.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <ao-3jrT0aP0_fSBA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/26 06:06, Karl Mehltretter wrote:
> On Thu, Aug 13, 2026 at 04:40:26AM +0100, Karl Mehltretter wrote:
>> The suspend mnemonic is an alias for mbar 24, and both encode as
>> 0xbb020004. Use the underlying instruction, which GNU as 2.30 already
>> supports.
>>
>> Fixes: 88707ebe77e2 ("microblaze: Add custom break vector handler for mb manager")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202310310151.UhB396Qs-lkp@intel.com/
>> Suggested-by: Michal Simek <monstr@monstr.eu>
>> Cc: stable@vger.kernel.org
>> Assisted-by: Codex:gpt-5.6-sol
>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> Just a friendly ping in case this got missed.

will look at it after rc1.

M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

