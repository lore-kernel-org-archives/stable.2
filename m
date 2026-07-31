Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06E3D565B
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785539771; cv=none; b=iDt2GuzfT63V6pTh3kR3bLur9BJqlv0+kKcj2WvdOt0HrPywvPNS71j7FcqEddbQS72eKJqkQ7JX985BcQfCXMzdtN0efXwvqXYwAWvxZvuoKoi7DxC08FpPRv4y1P/R8QxRyzzQmQWXBYUkeYTjHAssczNqui582kqo0LDgMRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785539771; c=relaxed/simple;
	bh=UhkbNNATlf7EoN+UKbHM+mV6TO/MAfeNM22oA+WBTDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUw/BXy3w2Ui3P/6TyhqDffwjPxa8jiAB3u08P8fddjQiYOjJu1ziSzDheEduggGXwzmoZR5M8+bZ56Cmttyf93v1CXLmB7S3GzQl+oxgoBfKjAhtRNxSIk2LktZ6g3ekm6d5WY0ApTeCDgqz9uFuaNZAoJ5BQZPVU3ctFVkAVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cs0Lrt42; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cs0Lrt42"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2cedda2ce6fso12729805ad.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785539769; x=1786144569;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=78eASuWYN+bdMC8EWrF3gOKxrSi6Ec2rxlN0ZtVlNR0=;
        b=jYvocI6Q7JY7Bo+fimw/W/FjByeR5j4X9WW4fCYur9hN36NxO9vSMvwefYkzs4Zo6d
         QH+DeL768kPfe7tJNYES5rY/n6jfS+YAFGlWBQ9hkN2olXOXJbTdJjwc0HAQJNhLngxQ
         7juYtBmQ7oRgypBbD4WsUwGrqMwbBOFu/o9nwGwCv1kqaLFT2blig2RQOysYWkjJRewD
         Gt8Sh6DckF3q9m/86GnBW1lZiBrynw6gMZWETn3lA9muxPIcDBJWVLXtepfx0sjtU4Ta
         ZXLsG+o3vcSl5I8eEPeFT2AYsQtMltIKLt7x2gnRmX14kY58ctJwqCIVnTNZaPsZdxC2
         EAWA==
X-Gm-Message-State: AOJu0YzpZslSCRotOY7jJWCT7wovhXcqOIyQgtX4hrbHHdmPrBoMb0zr
	5RnYfQw2MowX1OsC43cx2CnOSS+GDFqJM4xks4KzospgyCJ0VvNuW1rTa8D+hM9pMo71pUryeyq
	Y3z0xlzDXBYbp85BaRNb7beSObDMvm7TvEe6Hv8KPcb0egKNRav+gtlMqOD9KuRhurj0JYDqUht
	D8NNpMTUUikV8D5XNJYnOvmctPHNIlC8DidV5DmDYECTOP4rw5wgxJV3TzPn8B2cPtNQqP36Ni6
	d1Gc/B7nndc2WMW
X-Gm-Gg: AR+sD10TmFrCZ55nKKc6HrnmjfYdGA/RRfXHW3ncoLRaR8Snf8X+K1zRRyrYmFyWJDx
	war2idsOKfU8Ooz0mSpsOLtmGjeXixk+v5wOV8ATq6JNwr4ptUqPsue3T/dFQonWVwDTbzpUQMw
	ONysXm8a1RmkMBNVGpZIsLNt7podValq6LWcq4E2ZTgdyrQZGGmTeYi5uNwRAI8U6ka/uJTUX8u
	4oR6bJpf/sRpKp0hiCA9rNgzjKyRT/TO525B6rXgBYIoKjEJegsXNaqPidWzV41ulhYDUeUvOb1
	Cm64JfgkwzPDA9wM/q563c8ju+RZlmMo54JuZomUHBK7zuNb1bw6psxkATjZmNdSytPVwr6Ke42
	fP0SDuPwkvUkL4xJajI4tDzh0Wy0eyxIK55FIYZcGFbDJu2aTvJEv4prAlNTKehLocYcghhgjuO
	l1dHbWEkWWw4kC7Pcn381WPCyD8AS8epXXNiWIzshO
X-Received: by 2002:a17:903:2a8e:b0:2c9:9a2e:dab0 with SMTP id d9443c01a7336-2d0521e91ffmr16404715ad.3.1785539769250;
        Fri, 31 Jul 2026 16:16:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d04ae3f5d5sm2388535ad.11.2026.07.31.16.16.08
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 16:16:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so27317355ad.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785539767; x=1786144567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78eASuWYN+bdMC8EWrF3gOKxrSi6Ec2rxlN0ZtVlNR0=;
        b=Cs0Lrt42aP9e1MzzKRdbLlr8PkSl839yKbCaIS1bYUOcNo1nXdkJQXf7RAYK76h9r2
         myLMkG2oUS4+HzaHJK6ypPoitMacpz/hRgr9NRET1ms9wE5lSYnFHDhEhCPy/jSdTP6J
         dU5lfpGEG2l0D6WdsIK+6MYORxynqQYZOUUm8=
X-Received: by 2002:a05:6a21:3113:b0:3bf:b60b:da95 with SMTP id adf61e73a8af0-3c92a88f651mr1347629637.60.1785539767356;
        Fri, 31 Jul 2026 16:16:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:3113:b0:3bf:b60b:da95 with SMTP id adf61e73a8af0-3c92a88f651mr1347602637.60.1785539766919;
        Fri, 31 Jul 2026 16:16:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04506csm10341357eec.17.2026.07.31.16.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 16:16:05 -0700 (PDT)
Message-ID: <b8ec703e-145f-4466-8d4a-a67740098c15@broadcom.com>
Date: Fri, 31 Jul 2026 16:16:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12 0/9] Kunit backports for older systems
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>,
 Rae Moar <raemoar63@gmail.com>, Kees Cook <kees@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
 Tiwei Bie <tiwei.btw@antgroup.com>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)"
 <linux-kselftest@vger.kernel.org>,
 "open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)"
 <kunit-dev@googlegroups.com>, bcm-kernel-feedback-list@broadcom.com,
 Greg KH <gregkh@linuxfoundation.org>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
 <2026073005-release-puzzling-8f07@gregkh>
 <20260730203700.stable-0007@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260730203700.stable-0007@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 7/30/26 19:39, Sasha Levin wrote:
> On Thu, Jul 30, 2026 at 02:38:42PM +0200, Greg KH wrote:
>> Many of these are not in newer stable kernel versions.  So can you send
>> patches for 6.12 and all newer branches (i.e. 6.18.y and 7.1.y) for the
>> missing patches for them, and then resend this 6.12.y series and we will
>> be glad to queue this up then.
> 
> The gap is smaller than it looks: 7.1.y already carries all nine
> commits, and 6.18.y was missing only two of them, "kunit: tool: skip
> stty when stdin is not a tty" and "kunit: tool: Terminate kernel under
> test on SIGINT". Both cherry-pick to 6.18.y with no adaptation, so I
> picked them up there first rather than making Florian respin.

Thanks Sasha! Before seeing your email I had sent out the two missing 
6.18.y patches:

https://lore.kernel.org/all/20260730190329.3388222-1-florian.fainelli@broadcom.com/

> 
> With that done, queued the series for 6.12, thanks.
> 

Great, thanks!
-- 
Florian
