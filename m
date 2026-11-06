Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966036;
	b=Bsd6O7TsW/K2Z8E+9I5I25wx2xx7Rzu77yo59FoEr58fdW7ofVEmSLkEUdcefg0Cf23H
	 QG7ht5ZAwyFcfuGSeZK0dQSFW6GAoprOCADcRDPsndoq1Rtzxi4nzY/fiCE4j5x7/Sv/A
	 I2pvwrHqRNyihKpneHRmMPB9zqSFbBGtyZTXlyd4NvABwqsVg6mG9aFx05vpzZfA/QiNe
	 D/2A6ed3bRp8kE85V44KNGTvSCVwWKA5PNQEVju91PY1YXyuGV/SvmkUMOe0hVHxEWLqo
	 w8yhwnd2QLOy6BnWXmtc+fI/sSYDI2qJM3oJNk9bwKlNTd+e25a9gXYpcpyRNiIDNLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966036;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=L2x+FqwNN2SjKcTzPIIXmSlScBdMJ5xQvJIpzaDWbMI=;
	b=yHlZlFIE+MtX94Xs4MiEnbhrqz6VhhKfeLY6CTTDn5bs4W5sQ3VHpqXJC2XAYFgxO5gV
	 i/MUGsZ5cUdbd8YmUVgf7NSk5iDA8HlcXAMozoNu04lswjPbZjADD/UF/ngenHbfqRMGP
	 qTH/zGFruVVTqvX5gxYQPsoTv3mFRsFms4gtWESpvU0j43c4VmwRuDri0wyUoAjSE8y2z
	 PBldQwqBD/IqaunYpcs/rLe9ZXNG0S49LOTCtSjpdxVw+cq9mmfi037nR1nV00pa0QheX
	 +rYvcsvWbVwCWQGtOxYEtfucUogsQJpej9Dyk1X3EA0Tas8cQynDKEc+Yhfc+NfoTqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=AwukKVVr;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F50606A336;
	Fri,  6 Nov 2026 11:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F50606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=AwukKVVr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L2x+FqwNN2SjKcTzPIIXmSlScBdMJ5xQvJIpzaDWbMI=; b=AwukKVVr54QxOzzZVEdehAsFBE
	6MnontVg6GSYdkC22unJinnfGQ56l6xMbjwVpJCbWVfEkB8pbWdbkZChK7Whp1NJXMqrUWr+pRLOD
	dXlapB1c+oZaT6eFow5GN+K0WzGA2jmOUylhnA+2PL3phwI0oiZxvEpaguNb8SxCg4EMZjd45grKM
	d32HPtAWx4hxKP4mVjDhOQAPGWFtIAZqwli7NNi8kfKPQ5VT0RDHiWKwBu5cNaBAtEkUt1d4Y0H7e
	wHOnJ5cthoRLrrvIrr2BB69SV24mmWtM+8CF1DbmL5eeR9wUFB6MnrVRoBvTIHWWxqSOTa3K4fAYw
	7snhfS6w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xPIVK-009GNp-3B;
	Fri, 06 Nov 2026 11:53:11 +0000
Date: Fri, 6 Nov 2026 03:53:04 -0800
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	James Morse <james.morse@arm.com>, Usama Arif <usama.arif@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Ada Couprie Diaz <ada.coupriediaz@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, 
	Linus Walleij <linusw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Huth <thuth@redhat.com>, Dawei Li <dawei.li@linux.dev>, 
	mrigendrachaubey <mrigendra.chaubey@gmail.com>, kernel-team@meta.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: sdei: Preserve the interrupted context's
 exception registers
Message-ID: <au2_ZaHK0gpqPIFR@gmail.com>
References: <20261105120835.3321912-1-kirill@shutemov.name>
 <20261105120835.3321912-3-kirill@shutemov.name>
 <auyjSmtuqkXCqMvl@gmail.com>
 <au27CSJbg2Wdqh42@thinkstation>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au27CSJbg2Wdqh42@thinkstation>
X-Debian-User: leitao

On Fri, Nov 06, 2026 at 11:34:19AM +0000, Kiryl Shutsemau wrote:
> On Thu, Nov 05, 2026 at 07:41:12AM -0800, Breno Leitao wrote:
> > On Thu, Nov 05, 2026 at 12:08:34PM +0000, Kiryl Shutsemau wrote:
> > Tested-by: Breno Leitao <leitao@debian.org>
> > 
> > Tested on NVIDIA Grace (firmware SDEI) with next-20261104, KASAN + lockdep,
> > ARM_SDEI_NMI=y: sysrq-l under stress-ng, with a kprobe on show_regs() and
> > eprobes on irq_disable/irq_enable that fault on purpose.
> > 
> > Without the series the box crashed (a task interrupted in el0t_64_sync
> > got the handler's BRK, then lockdep/KASAN fallout and a hard lockup)
> > 
> > With it, KPTI off and kpti=1, ~4000 kprobe hits and ~5500 faults in
> > irqentry_nmi_enter()/exit() produced no warnings or stalls.
> 
> Thanks for testing!
> 
> Just to clarify, does your Tested-by apply for whole series, right?

Right. I was planning to do it in the cover letter, but, there was no
tags there (such as Signed-off-by:) so, I did it on the second one.
