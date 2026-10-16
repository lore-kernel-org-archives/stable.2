Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF1A377A81
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189172; cv=none; b=so0CDMKJWP2QwUV91f/yeiLqMoD3C5892Bzd6OeLB/Zz5TuLoTJecWYWdm7Cxvmx6pfbjYhkEk/PD9NTf9j+C6y6aZw+zssoPbIekuNvvb38cVvG1hhcLdse3KnYEj47zbYlEtLeoF6vBjoqQUk2zaaPaUwZcrsBbPX3Y8F+cnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189172; c=relaxed/simple;
	bh=CczPsXEzRRfqJ9GyVserx+qYU8CP5SVMLNDQ8x8WOsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbYjPlCXrZeUG8mvBWbyNhACAr9KyO8wT3LJ5up4BRBYuPa1y/U271bBlYgpJ7OLIngXnGGTrFFTkp3OVurhC4HGSi9hiioB4v3ZLlpJnjrN9baSiA2auAmUrZz7dKqIodJklmU0j4/6uHBpUm8CGpzS1UqmaoztNB6C3tvzKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZJ4gV2S; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZJ4gV2S"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b0584ad71so186709f8f.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792189169; x=1792793969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OhD9xLYcSH+hZ3LcnQSTj3wOScq4AWKpIi8HmoA4vQ=;
        b=IZJ4gV2SKYIpM+47r9EHL/k91zdJ0x0Mhkz1OxMeDhgt/jgsXghaJRErhKbcspzZ6G
         e9mlKjoCZGc3rg2fZQisDHbI0aW8MHFBjQJkJ+OolHPry09U5HMFIyT8zuwQDhgQoE81
         95F/IMO69lecscsMxeiq6zAKWT9WJE4UysZV8tKqZkbT6odrBkdCBenaP9+lTgsow//v
         rhDEKtdpjQlZiKMCBOgODq17rLKknBe8AwfPR+W0e4ZULdn14AhVDFXrGD9bqDymvLjs
         8S9Zc/9KymPiM2zoSl3ZomAyYp5QsUFWmNPbntFrhF9Gw34ewqoQTUjUfCoTP1lxvB54
         AnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792189169; x=1792793969;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OhD9xLYcSH+hZ3LcnQSTj3wOScq4AWKpIi8HmoA4vQ=;
        b=Usj6ZSmj67WaziqPB/t8AvmldRWX/NH7/0HR5/vRb9ADrlv0UKQrJvnh2NKAC7EGNp
         e5rYual+qkTidscW/6US3T0O7JmbtF3qtWbvKVVdHkpQ/GEZJ3XeB7+H/Y5aOC6Db5EY
         af8vMjdhJBIGiv+2HMqTY0mddNgF7JShBPM3t8kvbkd0Q9eVgHGZvA7Z6hEurD4A/vPO
         ThuZImlTByjFNi8CAy2VCYdFKW6hn//I92Rz349ibNtH/MR1a0Z/+W17BZJgbww1KqGf
         89IHtuyq0ih6J/86W2J4qQQktSsKu/Hn24Q5rbmEbF1VukRZDshzlmPJ4/xn6/1t3/Cj
         n7tg==
X-Forwarded-Encrypted: i=1; AKwUvBw0VRSPFqg3+D92q3zlXFL+pXxH2Sopi0JuCgFNZKvWL/24anFJqbfDImGnr31/ceDRMpelo/o=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkq2N7rljblWxjZKy8BAAsLxNr+5iPMOMnRYMhu+nv0SKPwQgX
	+Z63hJCH+C7z59rddtyoSCnAVJbynvI/CRFaV7kflYQdIH9NO98MJ3Dz
X-Gm-Gg: AYBFou2Q/EEXF0KWIcXqz4kMzs5rXn9zjiWGtcYCzUYEWjxjxPhWiD0xEvdWDmAlB1t
	pczN2CdNsUEKH/bVWGucnO/YtsaLBbmoTtQu5K8B20vhPr0FXTD0A7MEhTs1f9dXpWzA+gcjhRq
	2bU3jE8D/pLia1k6QqUtzMJXdz6jJtEki8aAb6kkOvr/ZjGN29HC+3eHWXuCHCnS++rQhvqiUBi
	wWsy61p4s93QuSgpYNoFqF7ws9gvc1Dc/fvlS702bE/vwilRb40q7cgXdupcxPbuP2ZQwpIPSM3
	RWXaWZ6DWGeDylrBNRpVyvma58hllxm+zBnF3lduYd6w2nARnY9LVjaugp9v1JLw6BcuBrfZC3u
	c0pER/k48plxupvrpTHsTf8xR26oHNa/9+flMjg71jxHEQmQul3c4KLGC7sgvtVb/Tr+J5yvAJf
	1PzQ7LIq8Q6+gPP2oADpxCrpcf0j9ZkkYxWlJPrjxGNuFlkow4tpM0Pg8XsMlsXtlngYytN1mx1
	pK/DA==
X-Received: by 2002:a05:6000:469b:b0:48d:efca:5f3d with SMTP id ffacd0b85a97d-48e07f9c439mr1254947f8f.30.1792189169148;
        Fri, 16 Oct 2026 15:19:29 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471877sm6416485f8f.1.2026.10.16.15.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 15:19:28 -0700 (PDT)
Message-ID: <637a1420-69bc-42bc-a1aa-df70faf769da@gmail.com>
Date: Sat, 17 Oct 2026 01:19:26 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
 from CPU state
To: Kim Wooseok <5mghybrid@khu.ac.kr>, linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261010-rtl8xxxu-usb-dma-v1-0-e670d9c08fdf@khu.ac.kr>
 <20261010-rtl8xxxu-usb-dma-v1-1-e670d9c08fdf@khu.ac.kr>
 <fd91ff33-d8a1-4ab0-83da-c15816c148cd@gmail.com>
 <CAH1Bc_w89ymu+E1Gx13M9JD7ZNmdQ3=y_zFwVvMkQMKk4m6NAA@mail.gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CAH1Bc_w89ymu+E1Gx13M9JD7ZNmdQ3=y_zFwVvMkQMKk4m6NAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2026 21:05, Kim Wooseok wrote:
> Hi Bitterblue,
> 
>> Perhaps it's a silly question, but doesn't this just move the problem
>> elsewhere? Or does kmalloc_obj() guarantee that nothing else will access
>> the memory near usb_buf?
> 
> With a separately allocated kmalloc buffer, the kernel ensures that
> CPU accesses to other objects do not corrupt the DMA data through
> cache-line sharing. It provides the required alignment or bounce
> buffering, and usb_control_msg() uses this DMA mapping path.
> 
> The patch turns usb_buf from an embedded member into a standalone
> kmalloc buffer so that this guarantee applies to the buffer itself.
> 

Okay, that's good then.

>> An allocation for every register access was not happening even before
>> this patch. I guess your LLM wrote this...
> 
> I did not state that the previous code allocated a buffer on every
> register access. That sentence describes the allocation strategy for
> the newly separate buffer: allocate it once in probe and reuse it.
> 
> If any part of the explanation is unclear, please point it out and I
> will clarify it. I don't think speculation about how the text was
> written is necessary.
> 
> Wooseok

