Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEA353A9C;
	Thu,  2 Jul 2026 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005210; cv=none; b=hQfwF22jAyDOCrrDvairD1kzoD+IHjtpeoqojHbLkUv6oQPipw36useClXWCrXai9bATbFus8zbTNIr+jdIr+4DHONwSCD/Z08MNhQVswLLZZAqY82SoxL6Ue0KGJkTOXmnTvWpI3pIc7pr3PUh17S6+kPF1FvaOgKFNSGrWgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005210; c=relaxed/simple;
	bh=FnnujX+GuZN/6NgfgJ67ufbF+v7lYEOPne1aPft7qGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SAUBjI3WbOaOt+Sqjw0nTULjzgT+EHvSuZLfytzjVvW+gHsJrmTIkAl8aCUhtvzZ8HR/DfS6Z4vMrvIsZmUjAnMAQ9Tan6dDJrKkyQx/jCdPac6to14rbIJ4hWTkLzjWi3T8n1W5RtgP3+VZllPcqWavqV65S/2umgW2H7WgDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN2SdiRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN2SdiRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978F81F00A3A;
	Thu,  2 Jul 2026 15:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005209;
	bh=v/2lAloUxNkyUNTQVRqjrzrN3TnrTeD5XrpCGs1lgZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EN2SdiREAz1ok0NPvBjkDF0HuLa0AU/nOMLBgyunSJGfd2BW7LIzDbnytNnya2Wow
	 M4eGqbopfqhp6luTj8CaXF4zEjq4TV4x6Pf8ZJ52FTOLyUqqQx2Zf+KmHkhGN8dcD+
	 JF2yZ12lhDJIUCSgHb6McnGJSLUaHxejbiW2gnAZPG/2E0RLFSVOk0k7YgzmE0oym2
	 JSRAiU7RF87EncgDYC031O5EpLXxy4luB8jRyn9G2MPfiHzxMJDn6ZijN+oWA7BZdO
	 z2bzVjrUdRIDKQdKKDnRRCl/3ZnEJzjka+QpygLxMbXocGfbxmL3a/206JZAVfvRK9
	 YZJzn40lfCkOA==
From: Thomas Gleixner <tglx@kernel.org>
To: Bjoern Doebel <doebel@amazon.de>, stable@vger.kernel.org, Marc Zyngier
 <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>, Ali
 Saidi <alisaidi@amazon.com>, David Arinzon <darinzon@amazon.com>, Zeev
 Zilberman <zeev@amazon.com>
Cc: Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH] irqchip/gic-v3-its: Reconfigure ITS from software state
 on resume
In-Reply-To: <akZPM6SeJiM8th0N@amazon.de>
References: <20260507183102.1897629-1-doebel@amazon.de>
 <akZPM6SeJiM8th0N@amazon.de>
Date: Thu, 02 Jul 2026 17:13:26 +0200
Message-ID: <87y0fto25l.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 02 2026 at 11:57, Bjoern Doebel wrote:

> Hi all,
>
> gentle ping on this one.

Marc?

> Since the original posting I've re-validated the fix against current
> mainline:
>
>   - It still applies cleanly to v7.2-rc1 (and to v7.1.0).
>
>   - I reproduced the original failure on *stock* v7.2-rc1. On EC2
>     Graviton instances, hibernation resume fails 100% of the time: the
>     ITS comes back reset, MAPD/MAPTI are never replayed, and the ENA
>     NIC silently loses its LPIs:
>
>       ena 0000:00:05.0: ... didn't receive a MSI-X interrupt (cmd 3)
>       ena 0000:00:05.0: Failed to create IO CQ. error: -62
>
>     The instance then has no networking after resume.
>
>   - With this patch applied, the same kernel survives hibernate/resume
>     cleanly: 9/9 cycles with zero failures, across all three Graviton
>     generations (Graviton 2/3/4, i.e. Neoverse N1/V1/V2), networking
>     fully restored on every resume.
>
> As described in the previous message, this is the fallout from 713335b6ee29
> ("irqchip/gic-v3-its: Implement .msi_teardown() callback"): device
> teardown no longer happens across a suspend/resume that keeps the MSI
> domain, so the ITS is never reprogrammed and drops interrupts after the
> hardware has been reset.
>
> Could you take a look when you get a chance?
>
> Thanks,
> Bjoern
>
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
