Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9C924B28;
	Sat, 22 Aug 2026 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787433159; cv=none; b=XPF9DLf3IAb91aumI9/Y/yCK7E9SShOhAzZ33DI68tea+W1JG2DznEnXxqm6G5eAUsZJEZJLe0TkLCXXal0+sa0n5vWPGXddpToFnJorT/xgLuPpa5Ey68IVNGpg4TQDxgVYDUyQ8ZXqBnnkuiLDy0nJfrIPjGjQuKzDOIt/PEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787433159; c=relaxed/simple;
	bh=9QYWIqbTu1dcQD0acjj01rMgeuCSPJVSX0yfQq67Shs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cc9QWESxzjpPEh6UyvseNCUxJdWvEd8WSUSEuLRuZUdK3MLaZgDFJJGTlKJffyygW0maMxYQ6vEkDIpomdQU1NAWuKvnJhSbt0JO9LEYjY+PMntPTUyIKyM/jw/6DWRP1LEzm9Iq5SsgvlLB40qHb0+ksHeTiyJHrtkDX5qlfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=MJCA233n; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="MJCA233n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vLWB0kaCt/rmAupaJgQeIGSyRveCIi1ZrRRpZelNVsE=; b=MJCA233nf7bagc8MB28UdRMUZz
	jXPB1QKyIBBI4tYgULKa7xvZaaHA1OeDOAwUn3mJXGohl5LzK4RwOLGPpXnk+hsjq7twciiVQLtkk
	U/2/aBvLyC3cymvNXY3uTFmRcuwKT8o3jdG6mwFY5Mv80PmlUU/9k1xJi6T+yhR1c1vA5xVSmZ5Wp
	qWwqkohXj3FjLjRROy/qlNVyC055lngTCGEMl8pOu9ibLIYZoyd0THHYsOROCOUqSERcQOnQnEgZA
	FfciWAxsEPpjiB1RnBYYWBtc5BxE4yr3zfQAic4WsuIct8N9uogocJuDtdqlkOd+AEQo1BY+7n0uG
	7t5XHoDg==;
Received: from [::1] (port=55848 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.99.5)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1wxt13-00000002Q8Z-02qL;
	Sat, 22 Aug 2026 23:12:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 22 Aug 2026 23:12:35 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bradley Morgan <include@grrlz.net>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 mgorman@suse.de, bsegall@google.com, dietmar.eggemann@arm.com,
 kees@kernel.org, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, vschneid@redhat.com, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] fork: initialize function graph state before
 copy_exec_state()
In-Reply-To: <20260822170928.1acba2cc@fedora>
References: <20260822195321.962383-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <4E2240F5-1211-47CE-AF04-24E1F0BC4707@grrlz.net>
 <20260822170928.1acba2cc@fedora>
User-Agent: Roundcube Webmail/1.6.18
Message-ID: <603183e5d6abcae2229c61b8e266e60c@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-08-22 23:09, Steven Rostedt wrote:
> On Sat, 22 Aug 2026 20:58:15 +0100
> Bradley Morgan <include@grrlz.net> wrote:
> 
>> >Fixes: 6b1c66c9cca9 ("exec_state: relocate dumpable information")
>> >Cc: stable@vger.kernel.org
>> >Assisted-by: Codex:gpt-5
>> 
>> Where's my R-B, nothing changed also, it's V3!!!!
> 
> No need to get so excited ;-)
> 
> Anyway, as there was no change, it should have included your
> Reviewed-by tag, as it will not be automatically added from the
> previous thread.
> 
>> 
>> >Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> >---
>> >Resending v2
>> 
>> (no! V3!!)
> 
> Right, when resending, it is best to add "[RESEND]" to the subject:
> 
>    [RESEND][PATCH v2] fork: initialize function graph state before 
> copy_exec_state()
> 
> And below the '---' have:
> 
> - Resend to include linux-trace-kernel mailing list.
>   Previous sent patch: 
> https://lore.kernel.org/all/20260822195321.962383-2-Jeremy.Jean@oss.cyber.gouv.fr/
> 
> -- Steve

Oops, I did not know that, sorry.
Do you want me to resend once more, or that's okay?

Jérémy
