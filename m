Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A9E3A6B65
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457503; cv=none; b=ReI6JA065dJhIvT1lcJS+OiAeW9G1RDHhSKnhlvjJS3l+yGr4efQHmQrMFVRb4iMSPWWOpF+fTk/ci2Jpcj1byAWNZqT/EA53s7fx57iM3td1q9tLTrp/I9FifF2HJ0MO99cg/EH6jDgRgKoYF5aFF49XcSAMWW6VJYT6phckrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457503; c=relaxed/simple;
	bh=u2JAMpv0fN0pDS3eIXOQxu16wC66haIbdk2P6M0kMlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Msuy6F6q1QbXf6Szrn+N6+Cc53JbOeskStsRYXo2h3DHqmPlV0BTnHbxpxYLbA74yszBgkqtO1FgPrGsMPaMJW3vTq0vFO4/gsB3stPwxP9yrEcBuA338POclAhYDB72MWxv9e90onGzQAO9ytogA7D57p7hRni9/Ap1qSSr8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VpxNeQ7i; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VpxNeQ7i"
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-66bd7857841so105214d50.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 10:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457501; x=1789062301;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HNBhRon5sjo6lLZgdhLNe/R/H9/qLezmR8661wU7Oeg=;
        b=kwvZFL4sv/ZIpWnoKZ1+tJUSKSceggCNTFMeDB+P1ZeqGf96hBWzk+eQtt5bxOPka2
         cu84l3FgkRktVr4bX5x3rQs1QznHVAVt35Y9sE5yIOU4Z9Q5uyAtmDkX0WbzNGUwvlOq
         OZeMt72iJKGP1ffqPMlnzbLJ26G8b3ddw+D6KdGNQPnfAFi8cKqtMyh/Wew9A9vZgpE3
         DiF7qfQVRIPh9OcULpWAeFRMqEJJ0DrgD2tD//104kKQHJ97BHmrPmrbZulFG2kWXNcg
         H++HHcEJKinG9XV+9QGwAzP59vCp1Em4+7LDmF820fv/3FLkj/16AX97DmPTR6jvTod8
         RB7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzQcZoT4zZ3oedDAlyYWQNQim3bdTbwNmxbJ6DY7rC0YvLpvEmOQ0W8iGePU3yqtPUJy8DjAjs=@vger.kernel.org
X-Gm-Message-State: AFuF++lR/aL8Ey/GlKwrGjyBng+/mwtD00d88HKlJiu7KxvKX5GCti6v
	v+wWL0vNbYbZl+jrOTA1YEczJcBb/VzzsPqlDO8DN2VCQiEPKxbmUwrv9Wbuc8WdKI9AvBPMekS
	tM6FizbG88PUo0tur020Ad66b8lcEO57M4BNKwnYCJGyzDnREOvqUEybE0j7Ofb4RbqyPIG0aLi
	dH32B1SqhUbGRroK4D2p9OdFzmqhqXo1IiRLi6MPIFidDin5pEZA7GgEJsAI26IgujToYYEdj9Y
	Nf9zcRcFuYYHWcd
X-Gm-Gg: AYBFou0WMjdtNnHgO6782ELoAyCX1d36ui5Ik3SoGsLKjX6TK+49Lz+33xtyv4cKtYI
	bKtRFUvr7rgrHd9Wp/Ek1rHnQE6hEBPJKH5dfGsYJ3LL2HzOJmG+1+aeEe1VJZdH6tdjndT3gfT
	pdptylRiHcQuNMXtCl75Glqfwo92NmPk5BbdTfyC3gEt7EDq4SOwofaDcs2W28q7R5OTtl7jIk7
	iUru8rAlDEmsGAPG86grfkvlq0L0wC9xPRIHN4iC3Kc+qvYw06HuFLwB150Zbux2R+JJqVZby/L
	T/phA7bnMxIAsbxGOYn8PnhbB7i5AKD+foIMGIwjiChtRo+lz8oSJ4NUUecwWjxHA3G25DT8djC
	JqhmgZQ3Jev/o/pof5BXKiA/5FMSisUXDKBYXqWbxPZZyYffy3+xlBLJpxOz+ATsvTHdKmnIABw
	5ry/WIpti70zOSh5uWtpZ09htNHAVc+NpCpbM0EAWh
X-Received: by 2002:a05:690e:1244:b0:66c:707b:60eb with SMTP id 956f58d0204a3-66fb5a149f7mr77721d50.23.1788457501230;
        Thu, 03 Sep 2026 10:45:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-66fb47c5198sm5428d50.3.2026.09.03.10.45.00
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 10:45:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso3938941cf.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 10:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788457500; x=1789062300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNBhRon5sjo6lLZgdhLNe/R/H9/qLezmR8661wU7Oeg=;
        b=VpxNeQ7iRlGxYlZEEqxL2sHGmLT/nTZqk/x79jHf3uvGFahhY+ASNKBUQnO/coJW3F
         hyBmoOOFPoCW4//ORBoMdm64mUzgtG4R/GzRx6VNtJRSxefeuSvAh3z3XtUyyFZRjNuS
         MF/qiGuK2bQ7FYu50ecA/rw32dUxMmUiNPbBY=
X-Forwarded-Encrypted: i=1; AKwUvBwYBM/Kiu3HPYPRX65WzQAqXIhjzfB0syEETJr7wAym/OFQ68rGCEqjY/cBUmsZ5EoWj1LCLv4=@vger.kernel.org
X-Received: by 2002:a05:622a:4d8f:b0:527:7027:cc1b with SMTP id d75a77b69052e-5305499cdddmr5585791cf.32.1788457500185;
        Thu, 03 Sep 2026 10:45:00 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8f:b0:527:7027:cc1b with SMTP id d75a77b69052e-5305499cdddmr5585141cf.32.1788457499534;
        Thu, 03 Sep 2026 10:44:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53054116466sm2033661cf.6.2026.09.03.10.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 10:44:58 -0700 (PDT)
Message-ID: <f13d81f7-5019-4376-a77a-67c2cecdc2cb@broadcom.com>
Date: Thu, 3 Sep 2026 10:44:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Backport fixes for CVE-2026-43198 into 6.12.x stable,
 CVE-2026-43198
To: Matthieu Baerts <matttbe@kernel.org>,
 "Atul Joshi (Nokia)" <atul.joshi@nokia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Joakim Tjernlund (Nokia)" <joakim.tjernlund@nokia.com>
References: <AS4PR07MB8827D3A807C2D7FEB3EDB06682B62@AS4PR07MB8827.eurprd07.prod.outlook.com>
 <f54728ae-c3ab-41b8-81f4-6bde4450ce8a@kernel.org>
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
In-Reply-To: <f54728ae-c3ab-41b8-81f4-6bde4450ce8a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/3/26 10:29, Matthieu Baerts wrote:
> Hello,
> 
> On 03/09/2026 17:29, Atul Joshi (Nokia) wrote:
> 
>> May we request to consider attached backport patch for CVE-2026-43198 to
>> be submitted to 6.12.x stable.
> FYI, Florian (in Cc) recently sent patches for kernels <= 6.6, but not
> 6.12, not sure if it was on purpose on not:
> 
> https://lore.kernel.org/20260903000029.3508006-1-florian.fainelli@broadcom.com

Not at all, I forgot to include 6.12 in the script. Now done:

https://lore.kernel.org/all/20260903174016.689839-1-florian.fainelli@broadcom.com/

Thanks Matthieu.
-- 
Florian
