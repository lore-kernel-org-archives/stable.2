Received: from mx.bauer-kirch.com (mx.bauer-kirch.com [217.11.56.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6E446859;
	Sat,  5 Sep 2026 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.56.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611432; cv=none; b=I4AywTkr9fif5nqs+wNBku0Hd02NQCc1eUg5UNgOM5AtHUuyTSn9ZcGQZxtlqCkHzt85aQDMWXi4wt7Kw2jvow/Pi7ZtQ/xu+MoO1S2OGsZhZkbm6RVL3kxBtPUzJWJgMPIDvan/TcXPxTYQu8qlxBM1rTQge+YAZx7yUR709CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611432; c=relaxed/simple;
	bh=bWy7GMIyL2IQUwXGeHbE3TO5SQZ99P/sX9mNj/HmZ5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Klv5UmnG0m8+4Mx3p82evLmabZONaZGLf6qbBt3yPLD8zc/FYBLob8OonT9VU+6t6vzUvH/7uxndbbdrX9HzmKFyFUrrr5a4Du0KLJkSnX3y7key26LiZ9zcbrqcQYx22wUftVkvJI+Yj03esmtWm9+Dw1ETVGpGMLgZZl999gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de; spf=pass smtp.mailfrom=noerenberg.de; dkim=pass (2048-bit key) header.d=noerenberg.de header.i=@noerenberg.de header.b=mjKywjxN; arc=none smtp.client-ip=217.11.56.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noerenberg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noerenberg.de header.i=@noerenberg.de header.b="mjKywjxN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=noerenberg.de; s=bauerkirch; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5ITPFuJqQ9bc1g+KLNA5tgoiip+tB0mLLOz4hIT1zRg=; b=mjKywjxNBq/hXSjMmfZ1vHDgpu
	14T+ZtKidPkVOpkXqf+CG3sEa6d4wcmL83UjOSP/WpsXxFcad3nDl2/9vb5tfZVz2FpP3Wr4C7pzK
	vIrLteaW3FNTox9RCyoFpA1a7yniPzb2hkHEn6daPXPmTRbI7+EPQei8CmVJLZOofATdIy045HCqN
	pkUSvjMRWtjSM/Ny1e7ruM0sHcVKJwwn9Ba6FHAScpumQf1J2/DZNZBftWmEuooBjeKXnobWjR7GW
	rMn+wJXjHvG+7GVsOUl8zAsKnynJAoxQpvhoMXt/h/QaaavJgxlKgae9j/XEwM1XYigyVuTl7Kxy0
	likD/Zog==;
Received: by mail.bauer-kirch.de with ESMTPSA id 1x2pXE-00000007tRb-1tZA
	authenticated id <420001312>
	(TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128);
	Sat, 05 Sep 2026 14:30:16 +0200
Message-ID: <1fed10ef-4a5d-4c49-bf23-34c4c30c5884@noerenberg.de>
Date: Sat, 5 Sep 2026 14:30:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: ahci: work around lost interrupts on Marvell
 88SE61xx
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 linux-ide@vger.kernel.org
Cc: Pali Rohar <pali@kernel.org>, stable@vger.kernel.org, risc4all@yahoo.com,
 linux-kernel@vger.kernel.org
References: <20260831124303.920391-1-hajo-linux-ide@noerenberg.de>
 <178818641418.216562.3155723702033731494.b4-ty@kernel.org>
 <aprZi3G9Yks1Gq9-@ryzen>
From: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
In-Reply-To: <aprZi3G9Yks1Gq9-@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.09.2026 at 16:45 Niklas Cassel wrote:
> On Mon, Aug 31, 2026 at 04:27:24PM +0200, Niklas Cassel wrote:
>> On Mon, 31 Aug 2026 14:43:03 +0200, Hajo Noerenberg wrote:
>>> ahci_single_level_irq_intr() services the ports first and clears the
>>> global HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section
>>> 10.6.2.  The Marvell 88SE6111/6121/6145 family stops reporting interrupts
>>> for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits:
>>> PxIS keeps its content, HOST_IRQ_STAT reads back as 0, the port is never
>>> looked at again, and the command in flight only ends in a timeout.
>>>
>>> [...]
>>
>> Applied to libata/linux.git (for-7.4), thanks!
>>
>> [1/1] ata: ahci: work around lost interrupts on Marvell 88SE61xx
>>       https://git.kernel.org/libata/linux/c/22f2ba34
> 
> Decided to send this for 7.3-rc2 instead:
> https://lore.kernel.org/linux-ide/20260904144228.1473602-1-cassel@kernel.org/T/#u
> 
Niklas,

thanks for moving it to 7.3-rc2.

I spent a lot of time on this bug, mostly because I did not know what I was
looking for.  Now that it has a name, searching for it actually works - and
out of idle curiosity I went looking a moment ago, only to find that FreeBSD
has been carrying the same workaround for years.

In FreeBSD's sys/dev/ahci/ahci_pci.c all four chips of the family are tagged
AHCI_Q_EDGEIS:

  {0x611111ab, ... "Marvell 88SE6111", ... AHCI_Q_1CH | AHCI_Q_EDGEIS},
  {0x612111ab, ... "Marvell 88SE6121", ... AHCI_Q_2CH | AHCI_Q_EDGEIS | ...},
  {0x614111ab, ... "Marvell 88SE6141", ... AHCI_Q_4CH | AHCI_Q_EDGEIS | ...},
  {0x614511ab, ... "Marvell 88SE6145", ... AHCI_Q_4CH | AHCI_Q_EDGEIS | ...},

and in ahci_intr() the quirk does precisely what this patch does:

  /* Some controllers have edge triggered IS. */
  if (ctlr->quirks & AHCI_Q_EDGEIS)
          ise |= is;
  if (ise != 0)
          ATA_OUTL(ctlr->r_mem, AHCI_IS, ise);
  for (...)
          ctlr->interrupt[unit].function(arg);
  /* AHCI declares level triggered IS. */
  if (!(ctlr->quirks & AHCI_Q_EDGEIS))
          ATA_OUTL(ctlr->r_mem, AHCI_IS, is);

That is an independent confirmation of both the diagnosis and the fix, by
people who knew nothing about this bug report.

It also suggests Linux covers less of the family than it could.  board_ahci_mv
lists 0x6121 and 0x6145 only, FreeBSD tags 0x6111 and 0x6141 as well, and
Marvell's own driver for these chips knows 6101, 6111, 6121, 6122, 6141 and
6145.  A 88SE6111 or 88SE6141 in AHCI mode therefore ends up on the generic
class entry and plain board_ahci - not only without the new handler, but also
without AHCI_HFLAG_NO_NCQ and AHCI_HFLAG_NO_PMP that the two listed siblings
get.  I have neither chip and no report of one failing, so this is a remark,
not a patch proposal.

FreeBSD does make a silicon revision distinction, but only for the 88SE912x:
1b4b:9123 gets AHCI_Q_EDGEIS below revision 0x11 and AHCI_Q_ALTSIG from 0x11
on, so Marvell appears to have fixed it there in later silicon.  Linux has no
special handling for either of those - 1b4b:9120 is not in ahci.c at all, and
1b4b:9123 gets board_ahci_yes_fbs.  I have none of that hardware either, so
again, an observation and nothing more.

For the 6111/6121/6141/6145 family there is no such silicon revision
distinction anywhere.  FreeBSD sets AHCI_Q_EDGEIS for every revision of all
four, and Marvell's own driver does the reordering unconditionally at all
three places it acknowledges interrupts, with no revision check near any of
them - the only revision-dependent branch in that whole driver is for an
unrelated chip.  Applying the fix unconditionally, as this patch does, is
therefore in line with both.

Unrelated to the interrupt problem: FreeBSD also tags these chips
AHCI_Q_NOCOUNT, which makes it ignore the command header's bytecount field
when computing the transfer residual.  I have seen no symptom of that on Linux
and have not checked whether libata uses that field at all; mentioning it for
completeness.

Thanks again,
Hajo

