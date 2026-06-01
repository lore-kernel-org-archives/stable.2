Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB45823DE
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275039; cv=none; b=m+kpcAvkCd//2EWXIAgUD3z6ODebkWIkDcHtxSqhH+tgfbAtRiDavLiJQT47BlXu8hMBiYFrvdmy+/f2dTbqHSV1ZPZ/yz1KChGKbRx3v3mEx7lgruegCKfQQNZnFJe78phQt33VgT+UkM6l8WStDURP6ulYspkaIjhPQOGEgKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275039; c=relaxed/simple;
	bh=ALab0YfEDuB+7HmfWwC6YGIS3uf5Xr3n8uaQy4Ys1hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnzE5SAfhKhZgpZmMHfALqFStXlW4qCwlqeBqbNn9wboqMg7EDRVXl8TdLsbGozTMDFqPp/miWytL1WS1yxvQ8Lxrok6L6LALEDdjAWR848JnWAN5dmyRQg+BMCEyWLksEopKkAAvD1zoYMBCyWA56jhlB6/ndDuHPsBhz6BEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMjZScGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMjZScGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC381F00893;
	Mon,  1 Jun 2026 00:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780275038;
	bh=JociplAlb0brmADuK6eAzOunhaiDYOcLqW2/nxIZUGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GMjZScGDyj3haL7ksPp8Xkh+FGxUzBb59CEplRbRqlHrXJoLBjx68TQHq9+yoEADJ
	 FY5uiJKwlzQ76PulNLOqPq59ptUXwzK22XfbQ9RhAvGVtxAGK6rGaxzc3tMOReXepV
	 85tbgW2IsN0JkJjIAJLhg9wr4SvjJYlgyuijzLb1tXsEexoXZsaA1cume1fBAnDpTa
	 WVXHC9zzqlHxlG+t1LpDgbS/nnym+jG2XrG6ibWujd/0sNtmKsW66u5VnMJFNGV/rj
	 qjjnXXf50O2RF21yksFEND/S56s1q4FKKhN8XJBdv5kGlptd5vffZoSUiCCsi8SAQI
	 NI+WmxD46DS6g==
Message-ID: <bd2ea2a2-5ec9-49f2-90e1-5551c4f5c3e2@kernel.org>
Date: Mon, 1 Jun 2026 10:50:33 +1000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 7.0.y] mptcp: update window_clamp on subflows when
 SO_RCVBUF is set
Content-Language: fr
To: Sasha Levin <sashal@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, Paolo Abeni <pabeni@redhat.com>,
 stable@vger.kernel.org
References: <2026052819-liberty-cramp-97fe@gregkh>
 <20260601003905.84041-1-sashal@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260601003905.84041-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 01/06/2026 10:39, Sasha Levin wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> [ Upstream commit 3a543ae0e2092d5c2085d5f21f7a7dbafdffea3c ]
> 
> Add __mptcp_subflow_set_rcvbuf() helper to write the subflow sk_rcvbuf,
> but also to call the recently added tcp_set_rcvbuf() helper to update
> window_clamp. This is needed because the window clap is updated when
> scaling_ratio changes, in tcp_measure_rcv_mss(). Until scaling_ratio
> changes, the subflow is stuck with the old window clamp which may be
> based on a small initial buffer.
> 
> Use this new helper in both mptcp_sol_socket_sync_intval() (setsockopt
> path) and sync_socket_options() (new subflow creation path).
> 
> Note that this patch depends on commit b025461303d8 ("tcp: update
> window_clamp when SO_RCVBUF is set"): it fixes the issue on TCP side,
> but the same fix is needed on MPTCP side as well.
Thank you for the backport. I guess there is a conflict, because commit
b025461303d8 ("tcp: update window_clamp when SO_RCVBUF is set") has not
been backported to 7.0 (nor 6.18, 6.12 and 6.6). See the note above for
more details.

In other words, MPTCP is imitating TCP's behaviour. So no need to
backport this patch if the fix on TCP side is not backported either.

I think it would be better to take both the TCP fix (b025461303d8), and
this one (3a543ae0e209). But maybe the TCP fix has not been backported
on purpose?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

