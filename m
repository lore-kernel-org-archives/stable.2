Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99934A64E4;
	Thu,  3 Sep 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439448; cv=none; b=rxDwn6A1wKZQnuDBpyqnwdXTQPi8p96d7hhbmuIyTwKO99Yq+uapLv73o50nYiP5/dKLesG/MiTDGeFWD8XbfiAqfv87Xw0h/a8dYmD+TDAjW5k0Vhwrs78Ayciqn5tjEAjSA/FTr0skRtXAedSxChHgXUULIPgp7xVeOpxFqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439448; c=relaxed/simple;
	bh=cgezBnVAdGNvF15YdIHB7Gnm9MrkiYXQWreUSZmMFHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHb5nIjZuyx9WQiGYYBs327ZjbALVM0aGDsVx/H3/Amd9X5GFdYoYMlOlKPVRjB/c3pW3ShHsAvUNCrcNAgklTOLwKfqXHxN3F32CasZ5nbg9BztbiWk6LFRqnR/tr4MWr8rmetwCN84a1ydotlCF1QtqmZmFMvAOREp59A4v6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfrF5wDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfrF5wDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4BB1F00A3A;
	Thu,  3 Sep 2026 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788439447;
	bh=jTSqFkEkk1q8IwdWmCwMO27IdBMn6LIcghxRPdcz8rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AfrF5wDTwpvROMIlgrvi8Uz/8ZcbQ7scGNLe28Ii00xQ3p1EGQmBjqyhxY1J8yKMD
	 irnVmLXmFPEuPE7FkE3MVwzmwdBJyL5fy5sce71QOA2BM+Coe4btMaCpV7vHqL4MS6
	 6gockvW8XPGvvetUG0ioTMpLutRHHxddbwrvmj3cs33UQTd+WAgsUdwUkCIf8ws7sT
	 7ABolApcFwKp6YyF9PCkbkiJXbfkPrE1qapChTV6PscCXt+nGVTcpVVoGe9o7yKipZ
	 CWbO/M+u/rURsJbheK80XqUPFpyM9kpR1RW/pWzKTJtYKMuqOzWFSFEwjsYO75MIXr
	 /t6fMy/HsVDgw==
Date: Thu, 3 Sep 2026 08:44:05 -0400
From: Sasha Levin <sashal@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers\
Message-ID: <aplrlQbTRxAxMsAF@laps>
References: <20260901123444.GA1350131@google.com>
 <20260902-daily-reply-0006-tracing-subbuf-resize-7-2@kernel.org>
 <apk_dQ4Q6msdw_Ub@google.com>
 <20260903123455.GS2133376@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260903123455.GS2133376@google.com>

On Thu, Sep 03, 2026 at 01:34:55PM +0100, Lee Jones wrote:
>On Thu, 03 Sep 2026, Vincent Donnefort wrote:
>
>> On Wed, Sep 02, 2026 at 06:14:05PM -0400, Sasha Levin wrote:
>> > > Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
>> > > uninitialized memory to userspace due to stale size values.
>> > >
>> > > Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
>> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>> > >
>> > > Not sure if this is the latest version or not?
>> > >
>> > > I see review comments, but no v6.  Anyway, no matter, it'll do.
>> >
>> > Queued for 7.2, thanks.
>> >
>> > --
>> > Thanks,
>> > Sasha
>>
>> This isn't the last version of this patch, I have just posted a v9 [1] and
>> Steven hasn't reviewed it yet.
>>
>> [1] https://lore.kernel.org/all/20260901155445.1475405-3-vdonnefort@google.com/
>
>The confusion  is mine to own.  I responded to the wrong patch mail, sorry!
>
>  `ring-buffer: Fix subbuf resize race with ring buffer readers`
>
>Which is in Mainline with the immutable SHA 8a5f63637890.  My assumption
>is that Sasha queued the correct commit or the tools would have
>complained loudly.

Indeed, sorry for the confusion! I've queued 8a5f63637890 ("ring-buffer: Fix
subbuf resize race with ring buffer readers") for 7.2.

-- 
Thanks,
Sasha
