Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016619;
	b=g1ZJthp0nIW6QSfkpmCv2EtJQYvEH5F5A4b6PE4JyyNUwlkKfcryve05rqUAAjNLljfb
	 e3KzFtU7MJ4rbRuC9nGQtem9e9LyFqT+x/588Idn+nJZ13sM6qnGGxlNTdTBUJxqcECRm
	 y1V2b6zQqMu5hPHZj+5xXlT3jYmbwUfe86/SZoSxW34hrxCgIHS1Si2w2obGGUMxvOfHn
	 ioShQxtiJY52wIYcdqGsjRJEon7x1sIt85u1rixbhff33oHnMQa1ZYcNPJB+lO0dZAqfS
	 E/Zgq+WpurCY/Y7uwDLEBsr1BtDNc9xQ8IEfLxeYumIAgLzEfmhOImvGTt+trAT4Dew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016619;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rTWxd+TS4ly6rOYqNqxpzFbo7LihUChogpGzZ95RqUM=;
	b=RGdrp3+wsfnC7NQILnu0mXz1tuZS+a8rgrPoD9w1RBG7s94qJcV56vaU9yuqD6E7Eq2k
	 w+vXY55HjzgEJvTLNMIpM4l98Do1KCrXCUxSqKdGobz2UTByocwp4FeDtlnmwgz/CQAoU
	 A7KkLfDxSqNq5UIVxdDI76Obg50rjlz930wRzO16/A0NtyNX1MRV6uG3KGfNI44fauHqI
	 fr+OL+QvCNv2Z35OfuTyK5rVwNnBcze9ho94RkW6GSAYj9rQ3IL0JzHzJZcQb62lBuHGm
	 0J+AaiuT97kbCPvatvCjIF/6N3+7pNUakbpnkFttMmLmEb+NEAOS8083EkN8OpwvxDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AY961Grj;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A77606A33A;
	Wed, 18 Nov 2026 15:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A77606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AY961Grj
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2714B339;
	Wed, 18 Nov 2026 07:43:35 -0800 (PST)
Received: from [10.2.213.11] (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F4AD3F632;
	Wed, 18 Nov 2026 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795016618; bh=rTWxd+TS4ly6rOYqNqxpzFbo7LihUChogpGzZ95RqUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AY961GrjxVInsjIcP+G2smTYjeTeREZ6UIg2fO6tKabgjt5V7KOWtZZhTpJ8grCFh
	 y6oE38jOUvE03V8mbnvKAO0UiJZlaWWOBKdPN82bVDGeT4jKFbXHbdP/YBr70eEcXf
	 8GeNkmHR1NWoyzUbaRAXtEqDVQIhP9xqpNiQMMhg=
Message-ID: <dddc12e4-bb27-4a55-98fb-de5c3d56e726@arm.com>
Date: Wed, 18 Nov 2026 15:43:33 +0000
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
Subject: Re: [PATCH 2/3] arm64: entry: sdei: save and restore PMR for
 pseudo-NMI
To: Vladimir Murzin <vladimir.murzin@arm.com>,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
 Breno Leitao <leitao@debian.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Doug Anderson <dianders@chromium.org>, Linus Walleij <linusw@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Huth <thuth@redhat.com>,
 Dawei Li <dawei.li@linux.dev>, mrigendrachaubey
 <mrigendra.chaubey@gmail.com>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20261117174814.95936-1-ada.coupriediaz@arm.com>
 <20261117174814.95936-3-ada.coupriediaz@arm.com>
 <628b2774-30bc-4399-98c3-2d99ad5090b6@arm.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US, en-GB, fr
Organization: Arm Ltd.
In-Reply-To: <628b2774-30bc-4399-98c3-2d99ad5090b6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vladimir,

On 18/11/2026 09:58, Vladimir Murzin wrote:
> Hi Ada,
>
> On 11/17/26 17:48, Ada Couprie Diaz wrote:
>> If using pseudo-NMI, PMR must be saved and restored on exception
>> entry/exit. We do so, and set it to a known value reflecting that DAIF
>> is masking all interrupts, in the regular entry path.
>>
>> Do the same for SDEI, as it can interrupt the kernel at any point
>> and does not mandate firmware to touch PMR, but does mandate masking DAIF.
>> This avoids potentially returning with a different PMR than interrupted,
>> and SDEI having the DAIF/PMR pair in a unexpected state compared to
>> the rest of the kernel.
>>
> I think we need to save/restore PMR into/from pt_regs similarly to regular
> entry path, otherwise regs_irqs_disabled() is still broken, like it was
> pointed in the thread [1] (and Sashiko has raised the same concern on
> FEAT_NMI series)
>
> Cheers
> Vladimir
>
> [1] https://lore.kernel.org/all/auzM-l40BLsT3clg@arm.com/

Thanks for checking, that's definitely what should be done, I was
a bit hasty...
Given it's a very simple code change (I rewrote the commit message
accordingly) I sent the proper fix as a reply to the patch directly.
Happy to send a full v2 if that would be better !

Kind regards,
Ada

