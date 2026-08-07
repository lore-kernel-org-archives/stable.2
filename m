Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96734E74D;
	Fri,  7 Aug 2026 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138687; cv=none; b=H+/kNXCN2pUe5Scse5vnDf3hN4QdLSbsM07I80p1PkaUcru9HQPUpppZN24oBH+kDXWqPFnacAcUvvvQoeRFvZpC6rn79O35I9bEOttn9VSN5XrK4E/2RjdvDyIkZ4sFzh01KKYgYDatwVVqyyMaXKPHi3m5KKzrkfzvYcnMHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138687; c=relaxed/simple;
	bh=pqI1jjKmq/0BSp+yS62skKHcyoraKkPSxHlfbmP4id0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B5oTWblHg6N6lbVxNj357bNs/GItHMUAEb2y79+DbYoGx2geHol0l2kDBgzUAvdWe8iV05bb9RN46Yhp7nbGPhRwnFPl+fixc41wGWXy2QmBt8+2CNGWCfSGF2e1YpUjpupTuw1iHudpx5qDCDoD+3Mbx7+2owl0rTiwLHDXczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fhtnW4u/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fhtnW4u/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E641F000E9;
	Fri,  7 Aug 2026 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786138685;
	bh=elZQKeikZzxWpyEMzJPkFz75IkgIrejtRCC8CUUdJfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fhtnW4u/UudPVV1QEdxmYzO3L3c6AyO1BChlBF42VEEm2BX114jT6VD/r/sYmJZWU
	 Oz2r/nIYV+HHHfV6HEUSTkM2+APMxr11seWvxJo3p+LPiEK1Z1YTE4KEaSWIW4zACG
	 CnuUaUh97dZrli8bxsybAZslGsEhZh1ws4vVC7Ng=
Date: Fri, 7 Aug 2026 14:38:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hui Su <sh_def@163.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, qiang1.zhang@intel.com,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kasan: fix cache shrink race with CPU hotplug
Message-Id: <20260807143804.24cfd5710208d9a421b0e0e1@linux-foundation.org>
In-Reply-To: <20260807065038.2600949-1-sh_def@163.com>
References: <20260806121006.1642946-1-sh_def@163.com>
	<20260806135125.a444f867993cb3cd3122551e@linux-foundation.org>
	<20260807065038.2600949-1-sh_def@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 14:50:31 +0800 Hui Su <sh_def@163.com> wrote:

> > Especially when proposing a backport.  At present we've provided our
> > -stable recipients no reason to accept the patch.
> > 
> > Documentation/process/stable-kernel-rules.rst says "it must fix a real
> > bug that bothers people".
> > 
> 
> Yes, I agree. I did not include the real bug dmesg in the original
> changelog, which made the stable rationale unclear.
> 
> The 9p case above shows that this is a real bug: a userspace-triggered
> teardown path can leave objects in the 9p fcall cache and report the slab
> shutdown warning after umount.

OK, thanks.

> Should I keep Cc: stable in PATCH v2 with this dmesg and
> userspace-visible effect added to the changelog?

Yes please!
