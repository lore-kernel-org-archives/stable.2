Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861112;
	b=lQs/DEqxX8/syP2GijVRYTM4eg2BTdomWDUj4wYyGpg4qxCn/DmoAOiHJivmlfI3zgRl
	 4YQup3+WjBdevp37/QPju8cyLkYoG0MDTIeO7BS1urXQtHlRaB3MgMAp9zsWzsna7p7x/
	 2ujvRkON3Th+iTN630xEUMOA88Ohyqy84+a0/Zkdix4Wbv4vAc7gJpTsJ5joWTA3B8hBT
	 4mpRzZ4AQJeW9uSXUGFdjcpReW5VgjQUuOo4Hu+V2di8k+yxg1xipYVFIYfHewdfAcI0O
	 S35iITO4Nj+8gZOHEYus881da63N1D3MWByrZCwuL9ZYTY+Ex5b508SdiKn/zNHX/aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861112;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xpiZT1UZHJ/M9AD9WPXX5moRlAuqlmGP0e5Y1uerVZs=;
	b=0pzoNUFrKHxb6UK87B8RonUTfTz0oa7vIb/Bwk1NsN/PyF4NfH/w4SWMMmjeiAzeb2Jl
	 W5em9yPCP1ygwNWYZ8cF6xJf605d8xr/oI1L8zRZinQ9Kh7SgPnPvGdjQU2ugc9L+AXXN
	 nKaCA43pfxqlzfpYO1mRzY/EwnO7iTGuUEEvbDzdYhh9Q71PyouWe0PWpQhUB7v1m2//w
	 z854kL/mBFr7ruU8yUow1kbtSKOwjzDzt4kuajUcKEH2OzBqDVkM44ys/5XGLscZ9KrF2
	 DAyJfUSK6bYJptU/HYtGyGfzhaoinEmU8y/sy7VLZcUsaeth0aeOZsTUMBwTKyQ/bew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gm/ogb7j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6901606A329;
	Mon, 16 Nov 2026 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gm/ogb7j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F121F000C4;
	Mon, 16 Nov 2026 20:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794861112;
	bh=xpiZT1UZHJ/M9AD9WPXX5moRlAuqlmGP0e5Y1uerVZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Gm/ogb7ji4y6gdYYpjEXnWm/6jjmQJrExbYbtQ7NHwutbpRQ7rpc4JmIHw8VrwJO2
	 limWJuuOTjrmUh3Lg2MmfGVEToR2BWvttIfXa+ssEr42LQ1bsv6S6WN8gGCD8XpOOz
	 zmv3mu9B5/hl9dKBcqV/oJkNAX+tXqGDyRw86sWBXM/C2x/i49CS/nAor1vFP/HWem
	 cDwXDmJkX3sStVSdIZRahd4Y1WzDqb2OorIbAlFGqEsncV26rAA2eRG5aSkDwkCaQJ
	 aNHR24T10iZA1dxZFEy4yTM68h6SmINcuJOgTven9GPa8tfxdGnBTKXDFoH4bVTo0j
	 Z6IBRbD0muFkg==
Message-ID: <730904a8-a650-4271-96da-68a9c8e55b88@kernel.org>
Date: Mon, 16 Nov 2026 12:31:51 -0800
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
Subject: Re: [PATCH v4 1/4] ata: libata-scsi: reject reserved bits in 32-byte
 passthru
To: Niklas Cassel <cassel@kernel.org>
Cc: shao.mingyin@zte.com.cn, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261114014801031Y999WJfhmUrM7FRlZ-2Qf@zte.com.cn>
 <40839783-b23d-41df-8c71-19fdcca00323@kernel.org> <avs8VMjIphKkvc9S@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <avs8VMjIphKkvc9S@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 09:24, Niklas Cassel wrote:
> Hello Damien,
> 
> On Sun, Nov 15, 2026 at 11:01:10AM +0900, Damien Le Moal wrote:
>> On 11/14/26 02:48, shao.mingyin@zte.com.cn wrote:
>>> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>>>
>>> ATA PASS-THROUGH(32) has no MULTIPLE_COUNT field. Byte 1 is CONTROL,
>>> including vendor-specific bits 7:6, but libata interprets bits 7:5 as
>>> MULTIPLE_COUNT. This rejects non-multiple commands with those bits set
>>> and can print spurious count mismatch warnings for multiple commands.
>>> The reserved bits 7:5 of byte 10 are not checked.
>>>
>>> Reject nonzero reserved bits in byte 10 with field pointer 10. Skip
>>> the MULTIPLE_COUNT checks for the 32-byte form while retaining the
>>> device multiple-mode check for READ/WRITE MULTIPLE commands. Also point
>>> to byte 10 for invalid PROTOCOL. Keep the 12- and 16-byte count checks
>>> unchanged.
>>>
>>> Fixes: b1ffbf854e08 ("libata: Support for an ATA PASS-THROUGH(32) command.")
>>> Suggested-by: Niklas Cassel <cassel@kernel.org>
>>> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
>>
>> Reviewed-by: Damien Le Moal <dlemoal@wdc.com>
> > I replaced this with your @kernel.org email.

Arg... -ETOOMUCHJETLAG :)
Thanks.

-- 
Damien Le Moal
Western Digital Research
