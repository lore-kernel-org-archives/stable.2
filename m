Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EACA43CECA
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020153; cv=none; b=fnsAgEMMHcqMr8ZWYpgSTgzZEzdMPVCgBWUSNxWCRXETYAKcNyOhv8jNvVXbrH50VApmxD4HbQKjcyLWIj0XScDGrFyaksTdPWqAB4eaCqY/TXWQGj5aqWoj91OxzyvHZReETxvKNCM1XYo5XPKZ2iwN5Kbe9nLD3ft/2wgjLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020153; c=relaxed/simple;
	bh=ZvlQ1OcN/73ADfk9UgQRlKT2NlZTfJ21cSPlVtwgSoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEiPMTuqNvz9rpAwEP2KI2x8KySLGZrqbHGrDfjfGPi/6lXPISNKc1TliflO62AfTUhIU/DVvZuAOKPW43sQXFB5ZKOcVvANlnXr6lkwQwjZNIZ4UWD8t6aeWFExKyn1wl8q7hO7S1Q2ZOFOo+ftQimEkdlE6HY6s96gzqaFzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V34uMCAX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V34uMCAX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 272E12B;
	Tue, 14 Jul 2026 02:09:06 -0700 (PDT)
Received: from [10.1.34.162] (e121487-lin.cambridge.arm.com [10.1.34.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EB23F93E;
	Tue, 14 Jul 2026 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784020149; bh=ZvlQ1OcN/73ADfk9UgQRlKT2NlZTfJ21cSPlVtwgSoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V34uMCAX6GLDE6QDDVGNjNtSJFA4PZmBPtw1V/yMOp2eNmIN7rtTusZWX8m4uJHMJ
	 C35UC/WkBozRqbJyk2fa+k5E3oNqatu8duMS1kzQoyTsSjKp2tIM2AIYqJV+xA/1P3
	 XEZd9wqXoIgg2jN/vvOWiekbYnox+SJw8mjbjQtg=
Message-ID: <bdb0ee39-7175-46fa-ac0d-8eff2ffbc616@arm.com>
Date: Tue, 14 Jul 2026 10:09:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/36] arm64: hibernate: mask DAIF before restoring
 hibernated kernel
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, maz@kernel.org, will@kernel.org,
 catalin.marinas@arm.com, Ada Couprie Diaz <ada.coupriediaz@arm.com>,
 stable@vger.kernel.org
References: <20260709121333.23507-1-vladimir.murzin@arm.com>
 <20260709121333.23507-4-vladimir.murzin@arm.com>
 <cd801ce1-7326-49c2-a6d2-218f9e3bd670@huawei.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <cd801ce1-7326-49c2-a6d2-218f9e3bd670@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 14:19, Jinjie Ruan wrote:
> 
> On 7/9/2026 8:13 PM, Vladimir Murzin wrote:
>> From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
>>
>> The arm64 hibernate code manages the exception masking in an unsound
>> way, leading to potential crashes and/or warnings during resume.
>>
>> When a hibernation image is saved in `swsusp_arch_suspend()`, all DAIF
>> exceptions are masked (by virtue of `local_daif_save()`), and the
>> suspended image is saved assuming that all DAIF exceptions will remain
>> masked when the image is restored.
>>
>> When a hibernation image is resumed by `swsusp_arch_resume()`, only
>> interrupts are masked (by virtue of `local_irq_save()` in
> local_irq_disable()?

Sorry, yes it should be local_irq_disable(). I'll fix that in next iteration.

Cheers
Vladimir
