Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D549DBA8;
	Thu, 15 Oct 2026 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792102367; cv=none; b=Ab2wjr8LAPF8ffiXvNlttxeGFtbJVrplfWCO2VkhcQOGwCtBsrdZr43lSl/4cN/80p23e/JDu1EnVqnmuMwq4ALtKxPeA2uRKo39+p/VODZ+xL0xQaXj5jbIR7SCM9/TZ8tTs//I3gRbWPnWga433T7h/tuIIJIMEAPz+eQsVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792102367; c=relaxed/simple;
	bh=KwhzzEMkuLBeAKhai04Zik5QWjQVv0gnGiO9DNfQxrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=apyWv2twViqxp1zPrLGhJWJrIDA7eVEzayYUe+cYFfs3IOJarRNC13eRc1IucQmgKYl1l5XPjgDQm22gh54Ns0Rl+vRblHApc9ia8MpexcSmh3XvLVkb+vAzOU/XXfYFscRaHN0p1Y58XXiT7KRXveBflXHsq2cTMWOieVvPDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s+dFI/m6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bD5UWpdG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s+dFI/m6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bD5UWpdG"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792102361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCQiXcwagl43OEWiORSs16kaBC+Da36kWfM0/gujHO0=;
	b=s+dFI/m69xfZYZ6NFHe2h81rK1p+3V/t723Id5UdIQe5y8v1nQ/S8JtXf2aDmyS/hseGhx
	vdvETDP97XGxcr0UPEw6aXcLN2LuhNm9vq1ZARXoxnkWwEQQfwMfi/JpRfdVwKU9dGkrr+
	BQk3voE1l2wO5fWqq5/UPBLEoP9Q3sblf2K2RDsvyORuA7NOlD0lMb8jF9IYEeDLLnRuza
	sia/D8GBhYDOm/AP1BeTZxItTJfbU8kztbPU86o45j8ZItvAzV2N3O1NovC2s+j+Jrm3qy
	n4MaKBH74nk0YRU50v12xjTft62WNj3x6qj0IwQmZvIbsBNozIXO8UAwKtLi9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792102361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCQiXcwagl43OEWiORSs16kaBC+Da36kWfM0/gujHO0=;
	b=bD5UWpdGnmyp5BhTyJlyARy6hy6Y9i2D7G0ymSiIL2BuqRQb2rWgwv218SUEy6vvw8EX45
	0qurYfZ3rcL/VqBg==
To: Koichiro Den <den@valinux.co.jp>, WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 WeitaoWang@zhaoxin.com, wwt8723@163.com, CobeChen@zhaoxin.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] x86/apic/msi: Fix MSI interrupt affinity configuration
In-Reply-To: <6mg2eqdehsmb5fh6hf7icsha2547xfdfvulnycawiit2czhhmh@6bbmicaoz2zd>
References: <20260928164839.6381-1-WeitaoWang-oc@zhaoxin.com>
 <6mg2eqdehsmb5fh6hf7icsha2547xfdfvulnycawiit2czhhmh@6bbmicaoz2zd>
Date: Fri, 16 Oct 2026 00:12:41 +0200
Message-ID: <87jynid352.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 30 2026 at 01:29, Koichiro Den wrote:
> On Tue, Sep 29, 2026 at 12:48:39AM +0800, WeitaoWang-oc wrote:
>> commit b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI
>> quirk") try to fix the issue of misconfigured non-maskable MSI quirk.
>> For non-maskable MSI interrupts, use the slow path to fix the MSI affinity
>> race. Maskable MSI interrupts use the direct path to update configuration
>> info. However, the current code logic is the opposite as only maskable
>> MSI interrupts will enable reservation mode.

Please read:

  https://docs.kernel.org/process/maintainer-tip.html#changelog

and restructure and reword the changelog accordingly. The above is
incomprehensible word salad.

>> Fixes: ef8dd01538ea ("genirq/msi: Make interrupt allocation less convoluted")
>
> I'd rather (or also) add:
>
>   Fixes: b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI quirk")

That's the correct Fixes tag.

> As I recall, I started out trying to fix the issue, but then got too focused on
> removing the flag. I missed that the check needed to be inverted.

I missed it too :)

>> @@ -62,7 +62,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
>>  	 * - The interrupt is not yet started up
>>  	 * - The new destination CPU is the same as the old destination CPU
>>  	 */
>> -	if (!irqd_can_reserve(irqd) ||
>> +	if (irqd_can_reserve(irqd) ||

Amazing that this went unnoticed so long ...

>>  	    cfg->vector == old_cfg.vector ||
>>  	    old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
>>  	    !irqd_is_started(irqd) ||
>> -- 
>> 2.32.0
>> 
