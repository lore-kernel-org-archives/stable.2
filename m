Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A717244A3F2
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305281; cv=none; b=tFIVfxUqo436BDTwrc2ox5bft11ZUYGdNKBbis8x6NWhgS0Ozg/dA3zdurtc9So7QQn+r5oXOzZc9+5kuiZ5wRUgzHBpDRFGhJ0FFLjXf6pf94qgPQimvbCpyN+1LOvMRIQ19K/7rtOcIKvCQIsbIUF2UugvFnKHPGsXXd/70aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305281; c=relaxed/simple;
	bh=MDuA7Ky/0oeqZYNprkCuTnPM6OQk5mo/pbNCOuCI3Ao=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdYAjNztttd8aFUKUllPdBqYM/LWgpGAr6YD94b/EQkEbgzvb2Z8rT13RhTMHpH64uILdwAj2JCdgtdBPEUqw9U+g2iSmQmEZSfQz0P/54/XrP3PXwrvgy2SZB8BN9dfmA9ljoUMkPCLs2PLk7Ho3B6n2ZAVlbA+LOkvKmtpir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dcb3MIkd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dcb3MIkd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956242332dso6762295e9.2
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787305266; x=1787910066; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z2vT4G4w+FuGaSUg7rJCxX3eISYj4wJ+Berx4Gi99f8=;
        b=Dcb3MIkdjCrE0U/d3jV9oEkfke4NvwATPfkZVJWt9+h8alEE4C44wQ28PVks3t/13C
         R+C5raffKUA2E1qaWd6/0CJEG6kOBvewT+nfS6zxt7MmT+Km0SqbstDcH8rg1+tTBZGQ
         lj7ah1c+lAEEsIgQCy3ozvyMgRrML8eykopcNTFExH3S5ArR7SBifg5ZdBkQ9hIdihJa
         +BMcCENaYsJo15jCG5JmAqqBTa5j2GvTVSAKAp/P8ZLeOlkGvprWbL0dHDu20Rzhu8um
         o8/7aCEgzOeycrOGjnlq5FgwVJ1C7W9cN2kyYcwla81GPC5mZrMyEwAwxVzMLHXruWuu
         fZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305266; x=1787910066;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2vT4G4w+FuGaSUg7rJCxX3eISYj4wJ+Berx4Gi99f8=;
        b=eTwC2GiqR1OnroywEBvtCBeNW3BdwGkoqKlaBzqz+bPvBFkprZCkMzirw+Y1rvZl7j
         PM3wn4i5zCz+I6RKrso0aU+hxhztBqpGmgQULTD9/fLnWQRZ4a6y7NjaL25/W7gU/sdh
         G6oMmFyywdk06nxtSLIvcr9GLULYFO3xdYU5LL6mQtfC5rU7BZi2IEvTYxnGSDr9RUF/
         TQAdr9ahZDyvQV79SxDKWhnSJsMtDmc0eCMec0Ua2UD7iT/plQYcXc0YBROIMd/u9jlh
         X5RqZrhbpQ47Dx0nVwfpftysuNJYQMGU472Kq8JNj2IPL1tbIy3NqupuhouOA98osajz
         iHSw==
X-Forwarded-Encrypted: i=1; AHgh+Ros/BIyXA7fTqdB9wcX4REHnA6uBsuNlZ5CBMXRpMY1q/dgQDKPXBNgPuuR6oMjDlBrIN3ig74=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwlkn4PP1gVe1/6UmT0YXWd0iLE/JsZNOk1nBuP4WTQeEizTH/
	gHAZBoRwwoZ7LAqTuCEEwElCI01NhfuuSZXerj9SRl04/krlUoYFBejCq27d2EKH73w=
X-Gm-Gg: AR+sD11FBP3uk+pa8dPFHYYMhSOVr1B1yUmyUO4u5+yvTuKBxaK9hmvA9oyMp8Zluh0
	J4aMovAYEEaaDkCdPiX03han+KQq4eW4gDdt+Yl0NfaPXbMPlSeiu1kXc81NLWGa794hoYgsq5f
	y3Jrx2os1PpYz0XxpfofBioWB0Wfpr75q10GwpZ+BXI1dSorB6JabfECk8z6whCsv7Mo4BcHj54
	UifndX9522H/9To04TZImTqzh7VDiAtr5VyCNFMbygsnwS1b7XdrWO/p/BHfhrS3IpseMdQrPK4
	1kDKL8PRt2LkjigN9LG+bY+iA9+cwn14dcKxqgS1jcaDIhnRM3upTpqkE5HfCVzDlbPzaETHhfb
	nK1nDb6mliK19PRqWbQeBg3gkJP99pNvXAmd9ITJlecvDR9TOkMEkhTduA3bweTJfvpaEH6uAE1
	LgdYjxm35ExJ6YuFM4av5FbIwweUUqUS05//YS1rkLTFtquoaw/qwkNrDqicMKPJQTYa8H0mqOr
	FoUeDLq9uFrmEgAMR564HbZoVnkdcv8Pf7yA3wOEQ==
X-Received: by 2002:a05:600c:c493:b0:499:737c:8a8b with SMTP id 5b1f17b1804b1-499b847746fmr65154955e9.12.1787305266266;
        Fri, 21 Aug 2026 02:41:06 -0700 (PDT)
Received: from r1chard (61-231-75-38.dynamic-ip.hinet.net. [61.231.75.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c46ca8b6sm2643642a91.8.2026.08.21.02.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:41:05 -0700 (PDT)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Fri, 21 Aug 2026 17:40:59 +0800
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Fourier <fourier.thomas@gmail.com>, stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Fix barriers to prevent hwrng from activating
 during resume
Message-ID: <aogdHNl9HLMR89cW@r1chard>
References: <20260803092240.18348-2-fourier.thomas@gmail.com>
 <anpm2fdZEwOlnMwv@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <anpm2fdZEwOlnMwv@kernel.org>
User-Agent: Mutt/2.2.16 (2025-11-22)

>> memory reordering between the wake up and clearing the flag is allowed.

When exactly can this reordering happen?

>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 12b7394b34bd..7f500797b7a7 100644 --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c @@ -173,6 +173,9 @@ int
>> tpm_try_get_ops(struct tpm_chip *chip) if (chip->flags &
>> TPM_CHIP_FLAG_SUSPENDED) goto out_lock;
>>
>> +	/* Ensure that device is fully resumed */
>> +	rmb();
>> +
>>  	rc = tpm_chip_start(chip);
>>  	if (rc)
>>  		goto out_lock;

Where inside tpm_chip_start do we actually need to avoid loading a 
stale state or flag?

>> diff --git a/drivers/char/tpm/tpm-interface.c
>> b/drivers/char/tpm/tpm-interface.c index f745a098908b..2de12b02f62b 100644
>> --- a/drivers/char/tpm/tpm-interface.c +++
>> b/drivers/char/tpm/tpm-interface.c @@ -474,13 +474,12 @@ int
>> tpm_pm_resume(struct device *dev) if (chip == NULL) return -ENODEV;
>>
>> -	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>> -
>>  	/*
>>  	 * Guarantee that SUSPENDED is written last, so that hwrng does not
>>  	 * activate before the chip has been fully resumed.
>>  	 */
>>  	wmb();
>> +	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>
>Can you rationalize this change?

I agree the clearing of the flag should be moved after wmb() to guarantee 
that SUSPENDED is written last, the flag has to be cleared after the barrier.
That part makes sense.
  
My remaining question is whether we actually need the wmb() barrier here?
