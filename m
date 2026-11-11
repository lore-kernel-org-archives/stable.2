Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379829;
	b=oy20z1/DKiIZHrxM37qvjifgyw7GDzgWWBgzY3liIMOSta4TSbJM3rD63HhPKlNyKu0E
	 kw/qXnf8PvJhb/lVqI3UeH7woy9Le6W9X+WAhQEnRVlTA88XPkixoIyWFTheOE0neAaXr
	 oEhDHebS+HMbFvTZC3o8CdlFiPY5Lgo88312R07YmiRo6hTgrpOAHH6kF+0rgiISDY80+
	 QS9A4+v1a3A0dczkMG/yG2HcYl8ani3CDTqumr30Ffh7jbiox7HQhdlwCDV/mLhCbjwb8
	 2k4hUZb9JFJ6Wd7T8aw61XiBb+oFM7GHTDvTyi5qBaam7cGsIVA4E+/4bLhz4sdx07g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379829;
	h=DMARC-Filter:DKIM-Signature:Content-Transfer-Encoding:Content-Type:
	 X-Lms-Return-Path:To:From:Subject:Date:X-Original-From:User-Agent:
	 In-Reply-To:Cc:Message-Id:Mime-Version:References;
	bh=Kj1qT7xH8KbzLy1DvoEj1CIR3+rqk8hL80hQOakjzyQ=;
	b=j646bDEFeRdSQ+1f0r8a259DoYTWGvyD87TLG6cvfJOuH0J4w3gIRUIEetNN/S7lv1yc
	 61UcW5eXgP+V/DYLL3jRP+7baLmGonwzvnfUxzg4kBzGo8pEoUgF3fRHFVjZ397vjXBzF
	 sHdQMKULT7m/I7E9I0roNWr95LPzAQzeOQ/uV4wJyeltrbS0Uru/cski02IEh6ZkkQ5WU
	 Com8CytloiVOdoec3rZ6m2aG4YzQTI8rQr0witMJLX8JIUwUQytKBFfLHRLlj3AqU6ErS
	 zK9YwQLK6M0WJarakTDC/wVp2SmADz+VQpqjxVcUYIh3exlo7vgDttTGrmgOfJjyM0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=lVgzjNlx;
	arc=none smtp.remote-ip=209.127.230.114
Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D65606A33A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D65606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=lVgzjNlx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794379823; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Kj1qT7xH8KbzLy1DvoEj1CIR3+rqk8hL80hQOakjzyQ=;
 b=lVgzjNlxC0tldr/JJeoiDkcEdSM7j8o/kzT08ZaQaxf2ITVnQqFJPBMrY+A9JVC65x4FTm
 e3d2ctbXKPjwv+pf0YVgtmOmJXR3gzQBKtBTnLeZHf47UeiNR2s8ZFjWaO8o48jTohxV9M
 36F+9Lryoq+GrfR+ZYvKz6CddNzh9nKUrojdUJMAg/p6hePxL6R2SwANeJ9Qf2WqcUZ0ck
 c2im54Pkj0kEhQ3DM01/3R8I1AbSsDPGYwnxP7vK+Kn9DnfgIDlLG3OcEAZhlfLdacTU+k
 TptAhgVAkcn/BpGO6/1ESxOaWf7BXokH0yyiMb/R7IoWzNYA1c1CWl3U+3tn4w==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26af4102d+3975ae+vger.kernel.org+qirui.001@bytedance.com>
To: "Catalin Marinas" <catalin.marinas@arm.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: Re: [PATCH 3/3] arm64: module: Use text-poke for late PLT/veneer emission
Date: Wed, 11 Nov 2026 14:50:05 +0800
X-Original-From: Rui Qi <qirui.001@bytedance.com>
User-Agent: Mozilla Thunderbird
In-Reply-To: <auoXmvKObg3IWWTD@arm.com>
Cc: <will@kernel.org>, <mark.rutland@arm.com>, <ardb@kernel.org>, 
	<song@kernel.org>, <dylanbhatch@google.com>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
Message-Id: <f1f27a57-70e8-452a-9528-0af9b4247514@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261010084721.2197683-1-qirui.001@bytedance.com> <20261010085055.2200241-1-qirui.001@bytedance.com> <20261010085055.2200241-2-qirui.001@bytedance.com> <auoXmvKObg3IWWTD@arm.com>

On 11/4/26 1:19 AM, Catalin Marinas wrote:
> On Sat, Oct 10, 2026 at 04:50:55PM +0800, Rui Qi wrote:
>> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
>> index 7afd370da9f4..fa89ed014bd1 100644
>> --- a/arch/arm64/kernel/module-plts.c
>> +++ b/arch/arm64/kernel/module-plts.c
>> @@ -9,6 +9,29 @@
>>  #include <linux/module.h>
>>  #include <linux/moduleloader.h>
>>  #include <linux/sort.h>
>> +#include <linux/text-patching.h>
>> +
>> +/*
>> + * The .plt section is marked ROX once the module is fully formed, so
>> + * late (livepatch) relocations that emit PLT entries cannot use direct
>> + * assignment.  Mirror WRITE_PLACE() and route the write through the
>> + * text-poke API when the module is already loaded.
>> + *
>> + * Return: 0 on success, -EINVAL if the text-poke write failed.
>> + */
>> +static int plt_entry_write(struct plt_entry *plt,
>> +			   struct plt_entry *entry, struct module *mod)
>> +{
>> +	if (mod->state == MODULE_STATE_UNFORMED) {
>> +		*plt = *entry;
>> +		return 0;
>> +	}
>> +
>> +	if (!aarch64_insn_copy(plt, entry, sizeof(*plt)))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
> 
> As your comment says, this is fairly similar to WRITE_PLACE(). Can we
> have a single macro that's used in both places (and maybe give it an
> arm64 specific name if it ends up in a header)?
> 
> Also do we need the !NULL check? plt and entry should be 4-byte aligned
> already, so it's an unnecessary check. WRITE_PLACE() doesn't do this
> either.
> 

Hi Catalin,
Agreed on both points, and they interact nicely -- unifying the two
removes the redundant NULL check as a side effect.
On the NULL check: aarch64_insn_copy() returns NULL only when its dst
is not 4-byte aligned -- that alignment check is the sole failure path,
since __text_poke() always returns addr. &plt[i] is a struct plt_entry
made of __le32 fields in the .plt array, so it is always 4-byte aligned
and the check guards a condition that cannot occur. WRITE_PLACE() omits
the check for the same reason.
On unification: I moved WRITE_PLACE() into a shared header (asm/module.h,
where struct plt_entry already lives), gave it a module_-prefixed name,
and have module-plts.c use it directly. That drops the plt_entry_write()
helper and its error-return path entirely.
Addressed in v2.
