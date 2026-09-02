Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4653DFC6D
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373502; cv=none; b=nt7yPcbaazo4FFTBGRAzC0AXjtGswS7CcK5pLhPr7MnlGuESpreYV07prZ6JnMyXj+L6lN4fzq4R+tfYmJPGyvt5065dMzfcM9l098y4iSZPnGwT3zSv0pC9hwnVEUaELD3+UPx7iOO9oZFRyHSm8EleyS0OFV4HUjRgg2tfeJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373502; c=relaxed/simple;
	bh=p/6yUzCKEtVGyy055GJhu+RlWZbn06/dnB/smFduD2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTUfstfjR+y9ZRr6sqFn+QbYI8txTX/I8nA4PyTGGmg50lwPSbcr1bDxfc8igKm94ZzUYpecqelyN9ujBLAjkic6IkUA/6MZ0OT6w9640wSof8Au05COqwPF7M8Rw9dVcrGlz8LBYpX75E2PwAqYH99AmOt7Gpximir+SPaXfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVZanuvs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVZanuvs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso11199185e9.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373499; x=1788978299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0SoYnuZTO0Mbw7rkNxqV575PNl6Qkl58Vf5hOHuv7jo=;
        b=CVZanuvs1Ls+w0+KNaTcUUi3JL7gS8W2UjVP3OSpAIOOY84M3VjTa2miGhBKYd37Xu
         5iV+ospZQ/5xxM8iNBzvMkj8PpVEa4wOKZGS07Fw4KSxLFNflqwtIBCuwLhAt+XOIuSz
         +z1BADVkuUmplvJGtLDHwQcyXkIzBeZwKqRCljHEIOhQo2PSlSGL2W0bScsqIT8oT+c/
         aCTiv566FH7da3wBWgaDu8r9JLI9bX9XU+BhWaS8/TbkEhmiBdRk1SStrI8fgV2gG2Vm
         Ox/Mfw/EVw10dReXF0wn3OsGj65j+GxQWefXD+6VIdlQYmrjHILjcA3tKSKVuiAFxcwJ
         +aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373499; x=1788978299;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SoYnuZTO0Mbw7rkNxqV575PNl6Qkl58Vf5hOHuv7jo=;
        b=g+8/T3BYThvw6gUIF7vGIazA5tvcdQzqyKNHjtzplRzaDoTlwlGzjRfQDOyshMFqiS
         hwtAGNniKkdu4ReF7v4Suj2dijAl4299y1GQ6HGxah+B/kLTPGHtiY1SDFHE+opUZgpw
         aUA7rLVXlk2EIh/UpgjFn4oQwMKnLO2ia5OFrPJy5GE5yn8aFXge0I6GwHgEcn6J2ybI
         syIj9VwMXEVKv5/JTz5iGWPnFMUQHn7Y8rwWSNtRrtbtrXlTO8N5uJZkzNFTD6ziRJ0E
         wQRkkFk9GVkjgQLR1hpDsjLdSGhR5vQxd4eHsQqGQ3id2WfMz+KsXv+7j+RNTUZStxAf
         M25w==
X-Forwarded-Encrypted: i=1; AKwUvBzeOgesamB2VxKLWgdnCARoYNFmElHzEXxDxCg4i4T+aL6DOSsx6KcpwDHJwtyO9AuxaNwwVGM=@vger.kernel.org
X-Gm-Message-State: AFuF++md7Ie190vWHv25q39lvEVhpQWfz2yg9QA79aiwHBNcX973Srhh
	uIV/vHNwQqpmHkwHRBWUsifpnfUmKJtH36xHwFgoT6PnhwvSuF7nUE6n
X-Gm-Gg: AYBFou2sAF/P4firNrmMsogkzkQus47lk7jqdozrq9zNrpNGuxDsj5T9E0OHjydG3Bu
	HQIrIUvIbh5LvX/Nwc9fJJZY9TGc+w7x6qMmVrgTOdJLbTHVR28PFlbewdeCtLt5Q+cEfn4GHD0
	LVcyTSypFblQmZ+Ok3ebLC7h2aGrMEk3+1G4phL/aVY7EHTVqEatVeSbTOJTPLzvm7ZiC7Usgbx
	jnFlZQ4YdqMG5A3LUCuthjMYzCcQRPjjvilSIFePmbZVv+hoiPXuXnhJ3Vv2ERTCgFM1Q7POyFP
	STuv4VB14S2tHM1HjuVoIeEU1A3h0PS6Ez3yU1kERuYUM6dACRxIpQbRzIXxVKIyeXFIa3/qTwu
	FDRhPgfzoLgWtlzV0pWajGJA01y/Uzbv6JgsCy4hSizeEO+Nxa9vvJaJR4pm2NemEtLFwM9FVUy
	b33JGXhEoHUA1N3xWcEAqGxIKims7543WKqlXXmlVnp15ySes61K7tNXOhe9A8y/EsSJ2jdeOMn
	5n7u+KLBeUMIc2zWCo/s64/Xnw=
X-Received: by 2002:a05:600c:c4a6:b0:498:952:e276 with SMTP id 5b1f17b1804b1-49ce581142cmr134091165e9.8.1788373498864;
        Wed, 02 Sep 2026 11:24:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d1fa6sm10798085e9.1.2026.09.02.11.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:24:58 -0700 (PDT)
Date: Wed, 2 Sep 2026 19:24:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Usama Anjum <usama.anjum@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, vladimir.murzin@arm.com,
 ryan.roberts@arm.com, peterz@infradead.org, catalin.marinas@arm.com,
 stable@vger.kernel.org, ruanjinjie@huawei.com, james.morse@arm.com,
 yang@os.amperecomputing.com, cl@gentwo.org, maz@kernel.org,
 david@kernel.org, ljs@kernel.org, will@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v2 00/20] arm64: Preemptible this_cpu_*() operations
Message-ID: <20260902192457.127f5747@pumpkin>
In-Reply-To: <20260902164250.40852ba7@pumpkin>
References: <20260804170503.3513916-1-mark.rutland@arm.com>
	<9789fd67-205a-412f-90d6-42c401d3babe@arm.com>
	<20260902164250.40852ba7@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 16:42:50 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Wed, 2 Sep 2026 12:55:12 +0100
> Usama Anjum <usama.anjum@arm.com> wrote:
> 
> > On 04/08/2026 6:04 pm, Mark Rutland wrote:  
> > > This series reworks arm64's this_cpu_*() operations such that they do
> > > not need to disable preemption, avoiding related overhead in the fast
> > > paths. Instead, the ops begin/end a "PCPU GPR" critical section using
> > > unconditional/posted stores, which should be very cheap on any
> > > reasonable micro-architecture. During a critical section, should a
> > > (preemptible) exception be taken, the entry code will apply a fixup to
> > > the GPRs containing the percpu offset and the generated percpu address.  
> ...
> > tl;dr
> > Comparing this series with the page-table series [a] gives 8 improvements and 3
> > regressions.
> > 
> > Fastpath is a Linux kernel performance benchmarking service. The table
> > compares the both patched kernels: positive values are faster, negative
> > values are slower, and (I)/(R) indicate statistically significant
> > improvements/regressions. Unmarked differences are not significant after
> > accounting for confidence and noise thresholds.
> > 
> > +---------------------------------+--------------------+-----------------+-----------------------+
> > | Benchmark                       | percpu-pgtable [2] |   gpr-fixup [3] |         gpr-fixup [3] |
> > |                                 |    vs baseline [1] | vs baseline [1] | vs percpu-pgtable [2] |
> > +=================================+====================+=================+=======================+  
> ...
> > | perf/futex                      |              0.55% |      (R) -2.80% |            (R) -3.34% |
> > | perf/sched                      |          (I) 1.61% |          -0.39% |            (R) -1.97% |  
> 
> Might be worth investigating those two.
> Something odd is probably happening.

Answering myself :-)
Do I remember something about the code being locally faster actually
causing a slow down because it changed the paths the other cpu used?

> 
> David
> 

