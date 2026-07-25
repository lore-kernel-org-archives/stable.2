Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC03BED31;
	Sat, 25 Jul 2026 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784977421; cv=none; b=NWOdavXfV3NSUj6Rb4W2mTV+dNc7Q83oqBv/a0JKC8nA1tGW7GWyFEl7u7qNvNNSBJHyT7xRa7c4M6RZC6YEx96CoRuYRq/34pkwDjwl6Tx0bE8RM+Mt1QX4TRjFA/q1us8zL4Y0PVM5a71Ru04Y23z7tcxj3YS25ZlVg82nNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784977421; c=relaxed/simple;
	bh=OdrVapjpsWfSkF0vczvwCUZFH4/Io+91ZHepDLP68wc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrH/dkn25zNWHtmOSt6FOpUxreefinqtktccTUUW5PERva59ylAcp4w75fSj6dwj+ekDo5WEXPaE3S7SvSX60TMmOowXU1A1HtOkemzBv/ytFoC5dhW7yifHVhphxqwOZzRXHJHwLYlL6GUFXQzGIn5DJgwpUmFqnriI2/0vhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1tqX2Oc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1tqX2Oc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72311F000E9;
	Sat, 25 Jul 2026 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784977420;
	bh=OdrVapjpsWfSkF0vczvwCUZFH4/Io+91ZHepDLP68wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M1tqX2OcwHdHhnI3HUNuL6hEeNK2IZx8jr7vZeYrMMLKNeN2E4BulAxX1oJ5RrNVW
	 2kK0ofrHJNbsXcv+OtobayC2s6idamfOOH4Soq0mtYbgRLi7JwiLASdvmw8SjpPZkv
	 yrC/QSnScHFvAN9A9mrELY63k0e/ggC4d/mUPlkf1P6uc8rX2L/YPcWo23vKmx0bMi
	 o0YoJghYIxJ+lOuJvrSzarK0HRSp4vfWIu2KGgSNAbxZXKIzrWHPSGuz3sSrz6E7II
	 Y94/GtDvkFcgDi6Dy1r7W9CdwXOXlPPjCovvykJV93JlgCs+SiG3I9Gz8hsprBZp3Q
	 l8b63Oyc5SDHA==
Date: Sat, 25 Jul 2026 07:04:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, stable@vger.kernel.org, Fuad Tabba
 <fuad.tabba@linux.dev>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [for-linus][PATCH 1/9] tracing/remotes: Fix page_va[] access
 before counter update in trace_remote_alloc_buffer()
Message-ID: <20260725070200.1cf133fa@gandalf.local.home>
In-Reply-To: <20260725110012.2962b76c@pumpkin>
References: <20260724231840.483353969@kernel.org>
	<20260724231855.591578614@kernel.org>
	<20260725110012.2962b76c@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Jul 2026 11:00:12 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> Uggg...
> Shouldn't the __counted_by() field be the size of the array itself, not the
> number of valid items?

Not always. It's simply a way to tell the compiler which field holds the
number of elements for a dynamic array. Sometimes that field is used to
create the array itself, but like in this case, that field is used to
compare with another value that holds the size that happens not to be part
of the structure.

-- Steve
