Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D23B52EE
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427643; cv=none; b=PDf7LcyUtQSCICxUqen0Al+MuK6P602nqL+ZcX6k8LUX13Ta2jktdoHhrT7UMjIGFcCGRdpqg96jAwdFknDOJWbnaXPnN960zCz04cKcxtOzkDwyd7WTtBOzBaJdeUsGDUkxSBGbpplPYcOjBf72KIwna5W9/6yWuULnrb9Dgww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427643; c=relaxed/simple;
	bh=x//P4tvS5EAcrgintiEui4XydbW05X6E4LcK0p36mKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXYpy0xUXzkk8xUqXEwNaP/4q6H0LMlD6UNdlutPm0lMdme9mhViM9xni78Csrv/ueAfGS/OudK190iOekRkDJH/r9MIEY6PpbFsLrSyNr11xZE/Q7JN4/G4Y0Mx/K/vI48a4aAMl0dy93T6cu12VU8muQJa7F297QsiBfSQtTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A765lhyz; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A765lhyz"
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-754ac74c495so8572137.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427641; x=1786032441;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M89kfycQcHjbtSp4KrMwssDD/glAdwj31Koyk+WC8Sk=;
        b=mKnuiQ8kwcDJ8tYQ2QqZYImvdiw+9rYYtQ1M1wnIe6D2itZN7z5T3cikU7xEDmLGUI
         aSjeW2Ru7Gxus4jMHBLCMt6qVYvba0zTbst9YCCp+jlOWdd/thqkxlurGEciDy/7TLO7
         Qpytfto+ciSXO+6Vx5dCaX/gXmC2QiCaH9a5fdJYYZr0SQYSQP5Wh/ZTGumbQuyBTAdq
         q7UlbkYInaMZQb2g53psDKKR61QSpObEhHhYNwhicWPoqSk2osnJ7SrgIHwD+lF+d1Qd
         SVmUFTkgOOu1rROwXqeddgqPdG6hk4K9/4l2jGPPnWycB6XnKlq331r6zG/irAy37iKX
         D/JA==
X-Gm-Message-State: AOJu0YxtP1duasi+iEm5faOxsk2GRBk7SKLp91G4HSxeVGLcHECMkTdh
	gn9kJcBLrO9i/i6M9LezYG7lFwk2YstX4VtTrrqPAvTdc4SqZeCd/Uq4cPsuZvCi/6GzwgNXQmN
	Lz0g3oDxb29jvmF6lkExdkYoudCEWhs5E77G3uWXa0mp7vWDap/rddh35VmpXpdYLiPcM5NJMuD
	Z/BrLOXiRuv2IbA6SOQJm5/PQ8RAccI6+9cqVYXFSIaVf40W0ekTAA9us5jOjaPdvfuJbzeexHT
	/EFbI7pALPMWb+s
X-Gm-Gg: AR+sD10vAZ91BZdWni7VvnA4HwCKW6LOi7pssaJIz8oyXVoSs+A1FChPRl+c0hCO4cc
	e6ZHsZPVTiZ2nbMHTQLvCRdDzirK6qPGJMcTbg9LStFaE4YxTKVO7WaO4TN6NIrHCi1FHLxrEMC
	TN3jPTP+JDGaI8GpRbHBys4w5Puruj1bqB/xL05Qgg78PnvN0803fQev+a4IKCMBappbMJkkQwP
	phQcoHKfSyVdHVDTqF28I//5htSqPXEHdaXiXGh3kN/2G7b4KtWnZG2OtisRv5czepDw58pElad
	4dYRBrOYTC64DlLCU8eWxxTztNmITV5ALH/VeWh9CDlZfojUIN2tpcK81NOmHiv54xPKN46krLw
	JbppOAfywqFlYlB5mAKgw7YKQrb2osqaB7mLyONptLfpigblCxC5w5qoOgR7/wvR2mSYLe3/TQc
	ywsYDAJiDHQAAHt88dOvhPF7xbfnwmGCfUNR23xBXU
X-Received: by 2002:a05:6102:6c1:b0:73e:605c:4078 with SMTP id ada2fe7eead31-7574f417318mr998952137.15.1785427640754;
        Thu, 30 Jul 2026 09:07:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-7575ba8dd47sm175588137.21.2026.07.30.09.07.20
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:07:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ee2847cbd4so339826d6.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785427640; x=1786032440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M89kfycQcHjbtSp4KrMwssDD/glAdwj31Koyk+WC8Sk=;
        b=A765lhyz5XoUYiKWmeTYLdzfgnG26ROhkVC4B8pphVvZZmzrhCV7Ck596zSRHlFws5
         HIYaRPF3PbUy99eLvrZ5fUrVWrZJPpV/B8tDKOMXn63fyY/K3p458jnPgwwqUTTBq+wf
         Njou3CpjA7LyM76WWeerVgIW2Sf7ApDUPmlqU=
X-Received: by 2002:ad4:5cc2:0:b0:907:40a4:e5e6 with SMTP id 6a1803df08f44-908348028b2mr31692296d6.52.1785427639802;
        Thu, 30 Jul 2026 09:07:19 -0700 (PDT)
X-Received: by 2002:ad4:5cc2:0:b0:907:40a4:e5e6 with SMTP id 6a1803df08f44-908348028b2mr31691236d6.52.1785427639004;
        Thu, 30 Jul 2026 09:07:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323e8b2csm20551916d6.23.2026.07.30.09.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:07:18 -0700 (PDT)
Message-ID: <15e85610-5596-43a1-8a88-9f9d74b9aaa5@broadcom.com>
Date: Thu, 30 Jul 2026 09:07:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12 0/9] Kunit backports for older systems
To: Greg KH <gregkh@linuxfoundation.org>
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
 <kunit-dev@googlegroups.com>, bcm-kernel-feedback-list@broadcom.com
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
 <2026073005-release-puzzling-8f07@gregkh>
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
In-Reply-To: <2026073005-release-puzzling-8f07@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 7/30/26 05:38, Greg KH wrote:
> On Fri, Jul 24, 2026 at 02:41:10PM -0700, Florian Fainelli wrote:
>> This patch series addresses an issue we encountered on older Ubuntu
>> 20.04.6 LTS servers whereby running Kunit would not return to a prompt
>> and it would not be possible to Ctrl-C the running session either.
>>
>> Benjamin Berg (2):
>>    um: Set parent death signal for winch thread/process
>>    um: Set parent death signal for userspace process
>>
>> David Gow (1):
>>    kunit: tool: Terminate kernel under test on SIGINT
>>
>> Shuvam Pandey (1):
>>    kunit: tool: skip stty when stdin is not a tty
>>
>> Tiwei Bie (5):
>>    um: Add os_set_pdeathsig helper function
>>    um: Use os_set_pdeathsig helper in winch thread/process
>>    um: Set parent-death signal for ubd io thread/process
>>    um: Set parent-death signal for write_sigio thread/process
>>    um: Preserve errno within signal handler
>>
>>   arch/um/drivers/chan_user.c            |  2 ++
>>   arch/um/drivers/ubd_kern.c             |  1 +
>>   arch/um/include/shared/os.h            |  2 ++
>>   arch/um/os-Linux/process.c             |  6 ++++
>>   arch/um/os-Linux/sigio.c               |  1 +
>>   arch/um/os-Linux/signal.c              |  3 ++
>>   arch/um/os-Linux/skas/process.c        |  3 ++
>>   tools/testing/kunit/kunit_kernel.py    | 39 +++++++++++++++++-------
>>   tools/testing/kunit/kunit_tool_test.py | 42 ++++++++++++++++++++++++++
>>   9 files changed, 88 insertions(+), 11 deletions(-)
>>
>> -- 
>> 2.34.1
>>
>>
> 
> Many of these are not in newer stable kernel versions.  So can you send
> patches for 6.12 and all newer branches (i.e. 6.18.y and 7.1.y) for the
> missing patches for them, and then resend this 6.12.y series and we will
> be glad to queue this up then.

Oh yes, sure thing, let me submit against 7.1 and 6.18 as well.
-- 
Florian
