Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AA1898FB
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 02:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256488; cv=none; b=Jh+BcgMNWch4tYEZnHZZMF7GdVICRXq0N4BUnwJjf7A72XqHYGeXYNI67/stEdhu3M95WJuvD/YNat3Hnf3my/IMi9eljhz5mQvY4lEl4tTDADMMhRjPMU4CJlvMHtoeRgSgD/l/qdW8oaohrymtbGRlF9bTtDr2svRz9+TqTuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256488; c=relaxed/simple;
	bh=8bqTUKjuttzn17QkNnTKXMAPLtx7G5+VdMTgk/QC/vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPuZsZYl8O5c4RwRqoEbVr2GvtzdBue/8Z04WZI+PDmgDgMuTNlzqeVgqhvFK/4mvZExaN3NW34UcKcsUXofvWyeXyEO852T02fjn6UaKcgWxWlDO8uNaVD0U8O3c/wQRedAvFDB8WS0ZjNjHvD7guKb3J6KiDs6KvoUNYTnpFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dk+PIrkZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk+PIrkZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so7194793a91.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 19:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784256486; x=1784861286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=30fhBagBzn4vtwaoRNpF/L3n1Myt6V2L2ZrYJGpcEAQ=;
        b=dk+PIrkZFEjuFOhZOy1j8mV2SfknmN1V3a9hsj5mgusqOCzVXPtyBX381LwtPJHCQU
         AisSfEsJRoAx//MLxubfAY8hLw2HkFtxbYIwj57ouhJ2zpeBMV7ze5L4SMMHAW3DRduK
         HpP7ucgKNv+8wCg2COJvIc1QUw4ms0cyJypiS1VJnUqeSSzLFYXa3h/km0H36pqUaw9Y
         VXv24jY7niUiPLblSXDcekOJw2kQOxTIAVu5h5yBPuWCOCkeld6zGUcGMxAiZ7F7OfeZ
         m0dayG2is9Spxll57L20WZZRtoRWS32LYQ2Fxy99XWWRTPpzO/a3TFXyefJzFqPCOX+4
         AW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784256486; x=1784861286;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=30fhBagBzn4vtwaoRNpF/L3n1Myt6V2L2ZrYJGpcEAQ=;
        b=Ihm9GIqQWJbdrb8f7fcR8zu2RF2Y6/+IILwC0zAXSrM+zvUZWJ5pjK5RPMyWoaEo6j
         zmVfsvtYPGDe3NculSWe3dUFkh56KB8Sa9YVwz3S/rRu1EoKlwhEm2IgKuZhN00eQHOe
         dR62E8HFACKSv6D1IcPaJeV749nE/ltq5q4NtkwU/G/VBZM3YQRQrbL/7gkye2iyj6M7
         9daH9yehaUVjzhY1wIcCcx9XuZbA27Oobpi3lAkgjaOtg30L7Fuj3OsV9OaTmjekvQFp
         4EUyA4p8PKkpM17AZoLJZ1mOrdQc9dl5achFBsrokxpWvEQrDdSZboAAX/nvzoPVX/3J
         M4mw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2pjMamwK+zDncCArM4Tc6Zqhw9WpTmgm/OHv1QlAGyUdQwLK2ERwOPlwgCgh2/2gJY+YiMMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjSk7AOZSmG7uYpIxtt0UHC/ptFRk4hcTOBDnakxGjR7i3xkh
	24QWj7U9CS/CdlyE76zwSCIoK8h8LT6wRoxR4HtuyQTsRUK377JL48+rGIhrZsveUm7iB8Hn
X-Gm-Gg: AfdE7cmVrugjwrxXCl9eZIAyF+A1x1kBzFe5y09vaV23Ooyo5wFHkatyxw3CiEJcIrc
	rwHPYAWPfts/0x0m7aQl42eylZOfcupPJDzZ5VR00esAXcruhpeH3hQMyydxeD4uehy2CdcXERX
	fKUERqEpOZbOybabnLSbuwTVz1PTNiRxJxkj9nQqAdu5pAmMQMk1gu/Le5VQp3RKLv75KiFsPS2
	xSz6i/mIACbbWOwhGTgET/NdgtxNSvjPwPFQ/kTnhiTcympF3I4qfD9zDNmOCWSfdIuV6n2bDGU
	ThieoYTfHaBGNP6qFe+gjIZlIKxRQAQAkNanKigIB8WxjNeqDlXGx+TLG8NMmBc9FdzBU5Jwjiz
	cem3/89znTwjPVbzoxyBxMz370XCGT3nw6pDZAnKAkfQS2+2LZ1hW40mZTZzKoLRSorqDRI0EcK
	Ws5wQwWA==
X-Received: by 2002:a17:90a:e7c1:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-38e4b53444amr628615a91.21.1784256486422;
        Thu, 16 Jul 2026 19:48:06 -0700 (PDT)
Received: from [198.18.0.1] ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm1223274eec.30.2026.07.16.19.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 19:48:06 -0700 (PDT)
Message-ID: <d7834d9a-c1a6-4376-84eb-2a9cfbbed0d5@gmail.com>
Date: Thu, 16 Jul 2026 22:47:59 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: dummy_hcd: prevent fifo_req reuse during
 giveback
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 bigeasy@linutronix.de, eeodqql09@gmail.com, kees@kernel.org,
 surban@surban.net, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, stable@vger.kernel.org
References: <20260714064829.172098-1-wangjinchao600@gmail.com>
 <c7de3923-1f68-46f9-986e-33899dce112c@rowland.harvard.edu>
 <15e5b802-b43a-44c5-97b6-a599f28bdee4@gmail.com>
 <a1953c08-7050-4288-b92e-ba4f76ccff39@rowland.harvard.edu>
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <a1953c08-7050-4288-b92e-ba4f76ccff39@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/2026 10:40 PM, Alan Stern wrote:
> On Wed, Jul 15, 2026 at 01:34:13AM -0400, Jinchao Wang wrote:
>>> Wow!  I'm impressed.  How did you figure this out?
>>
>> With a hardware watchpoint: I armed one on the victim field
>> (req->complete, at arg2+56 of usb_gadget_giveback_request) only while
>> usb_gadget_giveback_request() was running, and it caught the writing
>> memcpy with a full stack - usb_ep_queue <- raw_process_ep_io <-
>> raw_ioctl - on the same request that crashed an instant later.
>>
>> The watchpoint setup came from a small tool I am working on; I posted
>> it as an RFC in case it is useful to others:
>>
>> https://lore.kernel.org/all/20260714182243.10687-1-wangjinchao600@gmail.com/
> 
> That tool looks really nice.  I'm glad to see hardware breakpoints 
> becoming easier to use, because I wrote a large part of the initial 
> implementation -- see for example commit 0067f1297241 ("hw-breakpoints: 
> x86 architecture implementation of Hardware Breakpoint interfaces").
> 
> Alan Stern

Thank you! KWatch builds directly on that work - the perf hw_breakpoint
layer does all the heavy lifting, and KWatch only adds a small
"reinstall" operation on top, plus the windowing logic around it.

I am preparing a v2 of the RFC based on the review so far; if you don't
mind, I will Cc you on it.

Thanks,
Jinchao
