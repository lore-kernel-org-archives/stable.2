Received: from mta1.migadu.com (out-227.mta1.migadu.com [95.215.58.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA940415F39
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747065; cv=none; b=G/swBxIZltH/aQPaNqPwFu27MvuDtx/ZKoxnoorCtVfd30JnhVqhXGotlUAF/Gy+iCs3iAsVbkDSIg6nYpKktnArwRQCpNNgZgK+gxVujq8PMk1pxIdCidjO8+IH+R8r895HLq8rCLhrho25L1xzfkFEU//nVxMafg5MM4+EGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747065; c=relaxed/simple;
	bh=+Uh0HtyP1rf+sBtMlezUPUsG6Ast7DrhMsUoEv/PKHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6kQ98bJyTCe65cMEgFpdBVljHf3ifYKCNLZb6ZrWNreEjwgDm2hRffili99sxktwSJxPeoQUOJttrBm8GdxYoUxUA0/Kdu0RsHU4CjahWUFzudn+laZh6aflmTB10PE7ZohmvEdWeR4SG2BnXTVzWj92X8tsfRNlui/n5NbJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rDA4naUQ; arc=none smtp.client-ip=95.215.58.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rDA4naUQ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+Uh0HtyP1rf+sBtMlezUPUsG6Ast7DrhMsUoEv/PKHk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787747061; v=1; x=1788351861;
 b=rDA4naUQ2m42ml3EwhT0nEBC4RVaaMPBm2N2nqEWN2braVv/BM2M0NHHbgUMlu/J5ImoK5kZ
 8wmMu3xe20a01T19MnyHaplrahgHV3HxGdqG/8UBhwFbVRRa6vxGXeWHLOxG7IYpv8oP4CFbI7E
 fEzAFpISp/QNLJfuFKF8PFW0=
X-Envelope-To: stable@vger.kernel.org
Received: from [IPV6:2a03:83e0:111e:2:c6:2f62:38ca:59d8] (2620:10d:c092:500::4:fc9b)
	by smtp.migadu.com with ESMTPS id 4c8703f01af32397;
	Wed, 26 Aug 2026 12:24:21 +0000
X-Mizu-Trace-ID: 4c8703f01af32397
X-Migadu-Flow: FLOW_OUT
Message-ID: <e9c97286-d121-40ca-b6f1-4c63641e7283@linux.dev>
Date: Wed, 26 Aug 2026 13:24:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] ptp: fix NULL deref when adjtime/adjfine are
 missing
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, arnd@arndb.de,
 john.stultz@linaro.org, jacob.e.keller@intel.com,
 linux-kernel@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260826101004.100979-1-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260826101004.100979-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2026 11:10, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> ptp_clock_adjtime() invokes ->adjtime and ->adjfine unconditionally,
> but both callbacks are optional. 

Could you please link to the source of this statement?

clock_adjtime() with ADJ_SETOFFSET
> or ADJ_FREQUENCY therefore oopses on a PHC that implements neither.
> 
> iavf registers such a read-only clock: no adjtime/adjfine, and
> max_adj left at 0. ADJ_SETOFFSET hits the NULL ->adjtime after the
> offset is validated. ADJ_FREQUENCY with freq 0 converts to 0 ppb,
> passes the max_adj check, and hits the NULL ->adjfine.
> 
> Return -EOPNOTSUPP when the requested callback is missing, as the
> adjphase path already does, rather than adding driver stubs.

If PHC does not implement adjtime/adjfine/adjphase then it is a free-
running clock. ptp_clock_adjtime() has the check for such clocks.
To properly fix core part we have to extend ptp_clock and/or
ptp_clock_info to properly signal that registered clock is
free-running/read-only.
