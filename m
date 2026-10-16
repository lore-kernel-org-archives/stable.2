Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAA443E4D;
	Fri, 16 Oct 2026 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143016; cv=none; b=DVQTcrfLzymHECwjTyhdNT66AKx3TVwYRCwlwkXdOwL2GcSt5csPf2L/hcPn7BBPiI+o9hMTCw951bxKYm9d5YiwDhwQYfMx8J2Nn7vtvkaPUdqXTeDkU6Lka4D5UaeSjVeMgdBWkOV6yqIUmWiDmJNRXID1UkVOb4O+hKI9ZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143016; c=relaxed/simple;
	bh=58a1SVAwb6Pj+SSeSiRP5qR15p1liFYrokie5kI4VPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=otBM5Tf0N214JZY/QYeqRrSQS8iIC6mn74jNLPgs7VwoohCWbR/jjlDNclvC7gNbz2Bia4bc3xlePwRmBhQyeRtgKe1gmSRh79ZsSQSV7FmnPA47cbokUDDBxrgvPclxBzX9GglAkyq4aT27UXhMddtL6dwepe7WSljzhpa/Llo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rZwrePGy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gjcgG819; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZwrePGy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gjcgG819"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792143013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=58a1SVAwb6Pj+SSeSiRP5qR15p1liFYrokie5kI4VPs=;
	b=rZwrePGyswMD9tY34Kh0mBH8vg20fnmJgu4FZ0AlmMP+LDIELMiT/YadGuaKeULK9eutEr
	k0tMCw9TEboVpc3H/B9ziUpZTzRSD5pp52NtRA87kv0/K7hz+5QhctjmR4UNl15TwvIFsX
	dK2stsjsw3tPtESHj0oKb4/gUtuBAHclST9PVVCo184B6YZn8VsCqsbnraEYj0wuR2asyT
	LY+fnDlMs4KEIQGnDOZgwc3CquwTP8AcVaE1TtG9kiv+4TzUWPPXlWFhnlAhGdue9xBz2t
	lol/yISODlnKo6ts9ImsSfdOSUfFaOQ7kcqhpOke4rhdIbwgE4hHTnH5kq3Wnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792143013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=58a1SVAwb6Pj+SSeSiRP5qR15p1liFYrokie5kI4VPs=;
	b=gjcgG819aKj3P1V1XBqVLm/IG9C4YmY9s5i0AQADRpK6m1PQOZP/IfXpIGD/cDkQrY7lak
	GSlr3sN0WN0cWsBA==
To: WeitaoWang-oc <weitaowang-oc@zhaoxin.com>, Koichiro Den <den@valinux.co.jp>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 WeitaoWang@zhaoxin.com, wwt8723@163.com, CobeChen@zhaoxin.com,
 stable@vger.kernel.org
Subject: Re: =?utf-8?B?W+atpOS4uuWklumDqOmCruS7tiDosKjpmLLpo47pmald?= Re:
 [PATCH] x86/apic/msi: Fix MSI interrupt
 affinity configuration
In-Reply-To: <316900d3-2ce8-4391-ad8f-556bb5540c2a@zhaoxin.com>
References: <20260928164839.6381-1-WeitaoWang-oc@zhaoxin.com>
 <6mg2eqdehsmb5fh6hf7icsha2547xfdfvulnycawiit2czhhmh@6bbmicaoz2zd>
 <87jynid352.ffs@fw13> <316900d3-2ce8-4391-ad8f-556bb5540c2a@zhaoxin.com>
Date: Fri, 16 Oct 2026 11:30:12 +0200
Message-ID: <87bj8uc7rv.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 16 2026 at 11:36, WeitaoWang-oc wrote:
> On 10/16/26 06:12, Thomas Gleixner wrote:
>> On Wed, Sep 30 2026 at 01:29, Koichiro Den wrote:
>>> On Tue, Sep 29, 2026 at 12:48:39AM +0800, WeitaoWang-oc wrote:
>>>> commit b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI
>>>> quirk") try to fix the issue of misconfigured non-maskable MSI quirk.
>>>> For non-maskable MSI interrupts, use the slow path to fix the MSI affinity
>>>> race. Maskable MSI interrupts use the direct path to update configuration
>>>> info. However, the current code logic is the opposite as only maskable
>>>> MSI interrupts will enable reservation mode.
> Thank you for the suggestions. I realize the problem description in my
> previous patch needed to be more precise. Before posting v3, I have
> updated the change log as shown below. Could you please take a look?
> If this looks good to you, I will send out the next version.

Looks good

