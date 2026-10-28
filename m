Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207019;
	b=La1w0mxwxCBMfB/oi6uIHg4A2SiUxMDuOcNPKs7D5oKE1Yak4+TCxMpS2kj6Mf8CBsz1
	 z0tvLCwHN3goIw/kvAgwRMjoL4CfAWHK3N9WF2aNxdkzNrKoTJcdHT9dbt9MkMXj/Dr0e
	 qZtE6FmgqN4+DG4SPpYGMk5uMhtLhkCLvv/9WoTiUfgaR9bxOZuEjzynjeIG2P5pZdvi2
	 G3gFudcoCc8l9Gb+D80bft7QH60Mhw3Wz+YdKFvNYcDL/8jWhyjtfqLwiy4zghkLYJIR3
	 X9xmZcY9M8QMq1eOt4JppbE8tuq+rHNHQkwGWAspx0k0UGSjBtgzo1r7tuifxIeyGpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DO/5rN8t06lVCuIKT6Pz+YWotCVnUOjfp0iAhj+HMRg=;
	b=rbLdJQxMTzS3Ozl0wvNpf9wKm5Jzgh6WYnj/uECAL+vLXiL94w/IfepvuowESgRAnWbZ
	 hO+ij3UKf5hauYCdygEldcfsRlbd8hMcBVjQWKDDchXu2uDZj4JIQdK/kheo6NEZ9HdUp
	 aaVEe7dPR9qjDbcXx8kI8MTPuzjrJMIngZXW4jGdGN170HTn/nWGOWRqKibGSNp4qkT9D
	 Bv5ctuynV69EEQH+5pXoY11kVoH61z/qdR/sFdOSkRgngw0ZaYsG+jdLaWYdJqaxmoHzc
	 5/JzAFak+qoKpJf8zFuJ9yunnM5O8p11IjCPj7yoNsCv/naImzbEnjg8XmzAfEDQ9JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wh63upBh;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A7606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C9A7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wh63upBh
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4395d31228so189323466b.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793207017; x=1793811817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DO/5rN8t06lVCuIKT6Pz+YWotCVnUOjfp0iAhj+HMRg=;
        b=Wh63upBhKqln1Dt0rWPscluGhXAz6aZc8Mlo6+SFGXkxnjnAB+dDcYrmn4lRueuAJz
         QgQXJ5TznTgLv696roqARD6qiqrA9WOvsRldSZ1Nl8K3vW7z9nVrd+vg9J5d8I8NX5De
         LlzM0Jzk9R+NDW9gEs1pqwPpMw7RmJmK0rbYrpjAhUWwghUEbbUvY9LeBmfEVUeqwiTX
         4i/NAPLA66XFMzLOs8cph87ZNs65VLLFZfXaFQyy5O5vvJItM/+dfcmgFDRsryQmkPh9
         SdrPkNM7z+/o3nlE8wfm+G9JVu9Wste7YWFinxPsXiDrPO4RCJTKkoT/kEWixB/TMUjM
         IddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207017; x=1793811817;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DO/5rN8t06lVCuIKT6Pz+YWotCVnUOjfp0iAhj+HMRg=;
        b=zSnZwGyvzScbopgq2G71EAsIj0KGrT/J4leEP/UhHgNWkGNe167hNyEg9nglHPzkhf
         5IBfdUZYOwlTO3oJZixi6ogNSY8As1SCDFmFBXaigvDmJc3e1l3FYN1ZxLFr5RLnoloO
         2gu3LAjnHTWvs4tTHLE/MkVFvZJVMNVh8eN22DAnzmXaCpe8fOBqWNfEJyTtHRaBvqX9
         pXCAtBGqyQxWk6TdKKoQFHi2NcFQhaehjvRNfMjeU2dWee3ttvt8F+Nnv0/Ske1rvt+k
         7xxudKBLPDkZF3yzY8qZMVC6sHt/IEIPG9k8W5crMAFJrpPyp5bVh5gRTeT4W4RMo5F/
         H3yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwijNjIRBAGFtzJtRjK23U7KvJIum7MnRskUrQ2yZXORvcY+1GSXxtzDdeRNwRE2jMAf4Bp8gg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLndi8v7gtg0PbG5tx0WHwD6THnGf3EripYlz6DSvyTA+Yf/AxM
	4hKry9/lLxpCaS18GRqMImyWNdy57e5DPa8Ow7t+JhZ/nElgO4si3jo1
X-Gm-Gg: AYBFou0vXwLzCopIoPAEbEzsIeBUn58d82OcCoqMHvXGxXXCEp7pgV6KCcS9FXbStwZ
	M+mBkz6Y5imQUKUo6W3pSwUhSXWCcYJYKMp/RQ0ui/238BNqZ00FQPOmfokhr05wDM/B2ZfyGuK
	a891TNvTf7L5ZMnaRUefnECob34+4qItKYOQ4MhEFHpkWcFeGYKZyO+9xb0zit4CMsv0uhOMB81
	8fuA2cLTfqS2sUnnxhJJrPGeXCvzWMhaOSbd3JfY+CNwwXf3TlI9AbzQe+tH8eDpgjygk62z0Qh
	wgkZJLZfgWlY9qklFiVXAXedBETPzRy4HO655VnAa5d/5QUBJ/5P2eURm1zPK9MfagZFVBePviB
	aDgQKDc7KWNpyU6opwLKQEQoA2XkI96Tl3ZEXNEhWtx9VrmU9yJeotABX/sRctqHiWo0UTuYv0s
	csknP5VXsx1yxORLLrC1GcEsXvywbUVz/J/XNPgsEdnbM5dS5o+Bs2c/IylTG8y6M5e90CsM7FQ
	+/CtjaThuVLgxHtXOLZGm3t/985As4ieY0bHjporadxEvHkhgEeOzWXcu3njFKyVSUAIzg3v55C
	dZaEECZRhdjLBc/kiTB0e4cyULMj1p5X987eau+GkQ==
X-Received: by 2002:a17:907:fd18:b0:c29:659e:2fd6 with SMTP id a640c23a62f3a-c49bdf2ba80mr270930466b.10.1793207017356;
        Wed, 28 Oct 2026 10:03:37 -0700 (PDT)
Received: from [192.168.0.24] ([195.136.82.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd77e1e9sm635884766b.67.2026.10.28.10.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:03:36 -0700 (PDT)
Message-ID: <af0c6729-6859-40e7-bb55-33fe67fb5c1a@gmail.com>
Date: Wed, 28 Oct 2026 18:03:33 +0100
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
Subject: Re: [PATCH] dmaengine: pl330: drop only the runtime PM reference a
 channel holds
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261028-pl330-runtime-pm-v1-1-f0fb5c34a7c4@gmail.com>
 <auIIIC6ATpcJgDTM@SMW015318>
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Soko=C5=82owski?= <krzysiek.sokolowski@gmail.com>
In-Reply-To: <auIIIC6ATpcJgDTM@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


W dniu 28.10.2026 o 15:35, Frank Li pisze:
> On Wed, Oct 28, 2026 at 12:28:11PM +0100, Krzysztof Sokołowski via B4 Relay wrote:
>> [You don't often get email from devnull+krzysiek.sokolowski.gmail.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> From: Krzysztof Sokołowski <krzysiek.sokolowski@gmail.com>
>>
>> pl330_tasklet() drops a runtime PM reference when the channel's work
>> list is empty, without checking that the channel still holds one.
>> pl330_terminate_all() drops that reference too (power_down =
>> pch->active) and clears pch->active. If a completion schedules the
>> tasklet and a client terminates the channel before the tasklet runs, the
>> tasklet finds an empty work list and drops the reference a second time:
>>
>>    Runtime PM usage count underflow!
>>
>> after which the controller can be runtime suspended while still in use.
>>
>> Seen on an RK3128 board (dw_mmc using the PL330 for SD transfers) under
>> combined SD and USB load, where the dw_mmc error path terminates the
>> channel; the underflow was followed by "pl330_update:1678 Unexpected!"
>> and a failure to request the DMA channel again.
>>
>> Take power_down from pch->active in the tasklet, as pl330_terminate_all()
>> does, so the reference taken in pl330_issue_pending() is dropped once.
>>
>> Fixes: 5c9e6c2b2ba3 ("dmaengine: pl330: Fix runtime PM support for terminated transfers")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Krzysztof Sokołowski <krzysiek.sokolowski@gmail.com>
>> ---
> The same patch at
> https://patchwork.kernel.org/project/linux-dmaengine/patch/20261015-review-pl330-pm-original-v3-v3-1-5be09f37df77@crepuse.com/
>
> Frank
>>   drivers/dma/pl330.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>> index c2d0b47..b0eced8 100644
>> --- a/drivers/dma/pl330.c
>> +++ b/drivers/dma/pl330.c
>> @@ -2090,7 +2090,12 @@ static void pl330_tasklet(struct tasklet_struct *t)
>>                  spin_lock(&pch->thread->dmac->lock);
>>                  _stop(pch->thread);
>>                  spin_unlock(&pch->thread->dmac->lock);
>> -               power_down = true;
>> +               /*
>> +                * Drop the runtime PM reference only if this channel still
>> +                * holds it: pl330_terminate_all() may already have dropped it
>> +                * while this tasklet was scheduled.
>> +                */
>> +               power_down = pch->active;
>>                  pch->active = false;
>>          } else {
>>                  /* Make sure the PL330 Channel thread is active */
>>
>> ---
>> base-commit: aff5e6a77fc69a7c490246465940d18422d7c631
>> change-id: 20261028-pl330-runtime-pm-b5a30050b2f5
>>
>> Best regards,
>> --
>> Krzysztof Sokołowski <krzysiek.sokolowski@gmail.com>
>>
>>
Hello.

It is very interesting, but I have it for last month only in my private 
repo, that has now public facing side to upstream fixes I have made .

My public repo: https://github.com/ksokolowski/rocknix-distribution/

Set of patches including this one are here:

https://github.com/ksokolowski/rocknix-distribution/commit/dd3923788d94588b8d5fdb602808b13370ab4208#diff-27b400675ba20f118e98f9a25b963ece2a2336d9ef1fc9416c273f507e24c271

Anyway, I can confirm it works fine on real hardware for last month. So 
you can drop my patch and merge previous one as tested and confirmed to 
work.

Krzysztof

