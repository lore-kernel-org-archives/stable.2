Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015811;
	b=UkbXuhuunHiJnCPFnLxOPop7K4URBT1x4T0LGUewjpLnRXuUp7Pltu3ejTtlTNt5coAF
	 QDMH7PsCJG9898MnZ22ADgHnIRm/fYp0Ep+coEOo5xfr7dUZ6i8d1ljWwqlOj9phxDd6t
	 XefY99A97lpPo+1jIVscatc8LQhPzo0VGJ03Hya034X8MgKysmXDvGig/pFmdA/hxImXw
	 Tf3cORLo7FwGj80kL0sPoJ5CXKGN5Kljoq3adb60j7L5JamsZ+izSJW9Ct0j8RPuWNvKm
	 /LSJQAyY8aa1YUFoes+53CJQ6dutqYUp9Jo5/AFBnaYIbfGopEIqSObmhiW3eBWE71A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015811;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pb2DkYgnWmb9+bw97jIJiTPdWJPNRHPP0cb+PUXqyRQ=;
	b=Cuswle3ojG8WOoDXIKBQM+ct682hynXz89fbUWocVCXHmnhB87nBBQjg/YNM+VP1LRrS
	 s1m0StGzAes1dnMdfH1VXKn8ZZTF29l71uo5BaZDJ0xmHpMarV9GGSlDyXw7Noux5pTE3
	 yKs994JkedJaHXyYX313LNb9uPbWBYqx3do4BxigbGKUGngQ9dJPP+47kWKcnADObobQ/
	 IBMHRP+QHGIIGcyfMhHspB7tqf+kOlDKgJQCtUDqMaA1L3qrjVbM0pnqts7tvF1hc8R1i
	 Jyu4zGdlnlvBxSHChaCSca2AOgxAzSo5SoAm+Y71JtatgPL3QLZWPXFsxB/O1f8M+9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BcWNdAZP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7E606A31C;
	Wed, 18 Nov 2026 15:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ED7E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BcWNdAZP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CF641477;
	Wed, 18 Nov 2026 07:30:07 -0800 (PST)
Received: from [10.2.213.11] (unknown [10.2.213.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2FB03F632;
	Wed, 18 Nov 2026 07:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795015810; bh=pe0bYMQLHpKIt4goswPEy6JNKEehOuA2ys1dJsrtcB4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=BcWNdAZPfIauVt3J95yHNQoW8WzeY7FQl0Rfy0Uzx7/YOqT2Fx2uKi70Mps5DtHbo
	 CKhVXiqqZfeCtl0LJfbCVuT3h2T8LErJ7edGpFIw4zyblTlMUKofqkahLtDrn+wcr8
	 No4tvr3RE7FbS+OwdcyDTJnmrR326HP4z1/xPvXM=
Message-ID: <2ce350f9-4dc4-480f-8a53-07ef9586d49b@arm.com>
Date: Wed, 18 Nov 2026 15:30:06 +0000
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
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: Re: [PATCH 3/3] arm64: head: set __entry_task along with task setup
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261117174814.95936-1-ada.coupriediaz@arm.com>
 <20261117174814.95936-4-ada.coupriediaz@arm.com>
 <f232d0ff-3286-4d85-b9e3-cad8c6bc7178@arm.com>
Content-Language: en-US, en-GB, fr
Organization: Arm Ltd.
In-Reply-To: <f232d0ff-3286-4d85-b9e3-cad8c6bc7178@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Resending for the lists, as I forgot to disable sending HTML,
  sorry for the noise !]

Hi Vladimir,

On 18/11/2026 11:01, Vladimir Murzin wrote:
> Hi Ada,
>
> On 11/17/26 17:48, Ada Couprie Diaz wrote:
>> `__entry_task` is only set after the first `switch_to()`, despite
>> a proper task being set up in SP_EL0 as soon as CPUs go through
>> `__{primary,secondary}_switched()`.
>>
>> As SDEI can interrupt execution at any time, it can interrupt before
>> the first `switch_to()` and use a null `__entry_task` to set
>> its current task.
>>
> TBH I do not know much about SDEI, but don't we need opt-in for
> SDEI before we can get any SDEI events? If so, can we really
> receive SDEI event before first switch_to()?
>
> Cheers
> Vladimir

I honestly do not know much either !
But, looking into the driver, we register the SDEI entrypoint
as part of the driver init in `arch_initcall`, with a few notifiers
(CPU hotplug among them).
If using SDEI NMI, we register an SDEI event callback within in this
driver init, in `device_initcall`.

Both of those are done in "late" in the boot process, in
	rest_init()
	-> kernel_init()
	   -> kernel_init_freeable()
	      -> do_basic_setup()

This is as part of the init task, before excve into userspace,
but after kthreadd is set up and has switched to the init task.

So, I think that it is not possible to be interrupted by SDEI
on the boot CPU before the first `switch_to`, as we would have
`switch_to()`'d the init task by immediately scheduling
from the idle task.

However, as far as I can tell this is not the case for secondaries :
their first task on boot is set to the idle task, which they go to
without switching until (and unless) something gets scheduled on the core.
This would be the same path taken for CPU hotplug.



Unless I am misunderstanding something, which would not surprise me
given the amount of things happening before getting to init, I think
that is is indeed impossible to get an SDEI interrupt before the first
`switch_to()` on the boot CPU, but that it is on secondaries
or after hotplug.


Hopefully this makes sense and, more importantly, is correct !
Thanks for bringing the question up.
Kind regards,
Ada

