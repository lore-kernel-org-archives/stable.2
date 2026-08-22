Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF08355F57;
	Sat, 22 Aug 2026 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435116; cv=none; b=UJAqWl1oCsr4cFfBUPTx2gByssucaYjbnkSvXrHR9GfcXRcaCK4CtXzHlvwxd35xIO0Oaje+1wXUeNybiFYcoqiKrcKLwq+ZZWoc88dD3EAraHOMrCbbufkSXIYzbk8Lt5ZVAwUB/j5MmL8zNAGHFAQbs2v/X7gDpmCtsMpMJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435116; c=relaxed/simple;
	bh=k7Zpof6h9WUghRySCG8oO/6HIOjE3Odp9G6NzBkNCz0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Lv1+IcvbOVlVlb7l2+Nvn/sJ7C0DhrTzFbgoUYk8zvYA9VKYNlq4N96tNCGebtqxPUMx3J1YBRXavOuLp73FRoHnCkV9JZp7SNrKS3fuc7BeeTDFofIymj2PXREs53DOFnkds4FgM7biBfMTbsnHL1ED9Q5gR+l3t7mf7L9YtIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=bR4OGgq0; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="bR4OGgq0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a6yB+qzAG/fefKb5xEioOXx7BujJfnt8y4wf/YqoL6s=; b=bR4OGgq0nlQCiOglFm1QMCpvir
	Q91FI5EgnseTCk4WtNMXB61n8sgDRkGhrQ6EXNI+Mnl4/RMI7IxmkT98VJ8FdCeOsdzu7x1nKFMss
	a8Wj5uG/ayJke4ULp0C4/gi0kdka24/TSeE7sePHbRZu82EjpTPGtB4jhNGyNTVOdWv+FFrnHJJ7s
	7SvWXRVKzomOfSsNQEYjVCPbHc/D1Vtr4MS/P8xegwk6r8O1pkXllTVDwYIjOWvC3NIQonIROq2Qb
	VVz8qYuf3u4PVbgBEL5G2vdSetNXN3LMhH6UiNrIXLjwh5qzzUT5hJv+K+2kXv0YenGbShyGNhDY/
	PkykvK1A==;
Received: from [::1] (port=35504 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.99.5)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1wxtWc-00000002qTp-0EFF;
	Sat, 22 Aug 2026 23:45:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 22 Aug 2026 23:45:12 +0200
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
In-Reply-To: <20260822174053.26aa2f56@fedora>
References: <20260822195321.962383-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <4E2240F5-1211-47CE-AF04-24E1F0BC4707@grrlz.net>
 <20260822170928.1acba2cc@fedora>
 <603183e5d6abcae2229c61b8e266e60c@oss.cyber.gouv.fr>
 <20260822174053.26aa2f56@fedora>
User-Agent: Roundcube Webmail/1.6.18
Message-ID: <795312df1b22220991e828497b56cf3f@oss.cyber.gouv.fr>
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

On 2026-08-22 23:40, Steven Rostedt wrote:
> On Sat, 22 Aug 2026 23:12:35 +0200
> Jérémy Jean <jeremy.jean@oss.cyber.gouv.fr> wrote:
> 
>> Oops, I did not know that, sorry.
>> Do you want me to resend once more, or that's okay?
> 
> No need. It's in patchwork and I'll manually add Bradley's R-B tag and
> start testing it.

Noted, thanks Steve.

Regards,
Jérémy
