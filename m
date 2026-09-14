Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D1418A4F;
	Mon, 14 Sep 2026 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385773; cv=none; b=spVBYhul66B6OFa40VkMYvezmGx87wPKQ5euAXYqec44Qok07Aqxj1GCMsZekOeR6/BTMifzoYm7pesUeWbDZWcqHKCTn1iqBtNrWJ/UIBOCLehqXDuaLsWlfLCOMLcI0fe4BCkjyEklO2ETks3NNV6AS8SfzvJ5+zzFpPGAc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385773; c=relaxed/simple;
	bh=3V7vuCO0Iy3ZQkxwjy0KSdrPmQOlNiRCNybe1aLA7lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E2xL9Z2IIsH4+fGX7Rz/ZUpuIMkF6zwLc7UEM0J1QQS4gqq1VozKl4BgMvTUIQiFK1wzjQodqTdNb6M2vz9J/N0JjVSV2Y1JPuciXMqokFkcjhp/eXufgAiz4aMfuRgp7HYMi2WhfdvNmyC+Lg7ByLwMOAJojpc0wYYWPv5jW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, stable@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, Vega <vega@nebusec.ai>
Subject: Re: [PATCH net repost 1/2] net/sched: codel: bound the dropping
 loop per dequeue call
In-Reply-To: <QDISC-1L5H.v1.20260912080102@mojatatu.com>
References: <QDISC-1L5H.v1.20260912080102@mojatatu.com>
Date: Mon, 14 Sep 2026 13:36:01 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ld94ukta.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> The CoDel control law schedules the next drop one interval/sqrt(count)
> after the previous drop, using the configured interval
> (codel_params.interval). For very small intervals the scheduled step
> rounds down to zero, so the dropping loop in codel_dequeue() never
> advances and drains the entire backlog under the qdisc lock in one
> call - an unprivileged user can trigger a soft lockup this way.
>
> Fix in the shared codel code used by both codel and fq_codel:
>
> 1. Make the control-law step at least 1 tick so the dropping loop
>    always moves forward.
>
> 2. Cap the dropping loop at CODEL_MAX_DROPS_PER_DEQUEUE (256) drops
>    per codel_dequeue() call, resyncing drop_next to now when the cap
>    is hit: the catch-up owed to the loop grows with the idle gap and
>    the backlog, which no interval threshold can bound. This is a
>    deliberate behaviour change after long idle gaps.

Both of these seem reasonable!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
