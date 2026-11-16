Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861053;
	b=jnPSGugwCk5CN7nDETE29dfmBHXEj+Bi8O88MT+r7WTgev+jezRfSm1kZoeqNC9eWhaA
	 wuqI5/MY6hgDuZUeOHw4wRATQhWWVxaG71uyLajkoRcNlMBHSgQdiIPjNqbUT/6kAmrZA
	 0bTi+8kQk5Gr7gluttHF4rkcImzIqyqsPvFvWwlaSZynNx85NEjweMK129VoyQS2bTAO0
	 OfHW1o/ReF4smxcPCwl7b1rYUay5d7CBN0pCmwTnvmVI9uegMRl5S/moGReYTTw1YxCIk
	 U/4D1nFVOy7j/X0OPc2A5uikJc3AushXlHQIevMQZ3FXGZ9XsyfegBim/b8TnDeLdDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861053;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KbVLOTOAwyVEgJglQgZP0YCYKtRe10ryHatLTgMjwnc=;
	b=c/a2Hz4nOzgQ7KNKQaWvzXUbVmK2ujupBEoEz3ceTXt0qYPsLw/vN7g0BTAY7oPuUXCI
	 QED6gqozUWQZR/Q61hJyYoaa7rq06IFIIRfTQ2/xETNUszz4drZlnTwxfyvhqVkH4y0vK
	 8TjDEfF9O9B9q1w+ErdAdtk18e5bdwkPkS+KKMhWn7UB5cdqfGjBIw+BmTjyYRaPm6eya
	 Y8DaCFKec+XtjPeyVpnAANe1t3gxwzbCxj/r9huTKqrkxQ+CEf6adZdxMDFLb4GokA5Ko
	 6jhDluygcsMaGxSH7fvs+QUFNOxhs5UgyCLow81z8TQGANI16lrSA58KokMi6ntub5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPL98qri;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E368606A31C;
	Mon, 16 Nov 2026 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPL98qri
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D191F000C4;
	Mon, 16 Nov 2026 20:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794861052;
	bh=KbVLOTOAwyVEgJglQgZP0YCYKtRe10ryHatLTgMjwnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VPL98qrikGSZadA9kcqfCXshBgd6m4reWvKK/d+QH8vxsgkmLL2R2t/p/Zgq2LUwG
	 BWUtnu6kPDhu+JPaI28Joru6bzMPuN43J7pa8Xl1WtRdG5hSz9J/MF8nRT5FzMwcEo
	 DtHpryiydSxJXw3i3hsPt6qGppndmznVabc5SvcjP/pY45pUhaiw8F9kimbYQ7xgSg
	 V646MFy0iZtgjtTK9SUI3ZlR/RmtMQ/rcMt1tkb4HQaluxTZ2RqVbt1TqUwE0JGxYG
	 sCUZ4SO8q/loiVtt4Cg749omf9z6+BgEyrKRWfbHs52aHK+TGrT4qUYIKq5wkKm29B
	 OxVPF72VS2msA==
Message-ID: <3fb242cb-d8a0-4dab-b495-9f5de7713f4d@kernel.org>
Date: Mon, 16 Nov 2026 12:30:41 -0800
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
Subject: Re: [PATCH] ata: libata-scsi: fix REQUESTED MAX LBA field for REMOVE
 ELEMENT AND TRUNCATE
To: Nick Spooner <nicholas.spooner@seagate.com>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org,
 hare@kernel.org, mkp@kernel.org
References: <f72e653e-2cef-4920-89c3-f32ebc68de95@kernel.org>
 <20261116164709.25064-1-nicholas.spooner@seagate.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261116164709.25064-1-nicholas.spooner@seagate.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 08:47, Nick Spooner wrote:
> On 11/15/26 01:58 UTC, Damien Le Moal wrote:
>> So we should not silently ignore the 1 case and fail it.
>> Can you send a v2 with that failure added?
> 
> The 1 case should already fail. The check was in the existing code just
> above where I patched, but the diff context cut it off:
> 
> 	req_capacity = get_unaligned_be64(&cdb[2]);
> 	if (req_capacity == 1) {
> 		ata_scsi_set_invalid_field(dev, scmd, 2, 0);
> 		return 1;
> 	}
> 
> 	if (req_capacity > 1)
> 		req_capacity--;
> 
> I believe that should cover all three cases in SAT-6.

Good. Thanks for checking!


-- 
Damien Le Moal
Western Digital Research
