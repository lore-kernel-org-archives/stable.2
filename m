Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C58432300;
	Wed,  5 Aug 2026 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929365; cv=none; b=A41YATOHdGvSw9gnPIYPweJ4Vketc9XBt7HW/ia/VRAYBcTaN1Y1vaEgmwIbKUdvDOWDlZaHqSU3RdjAlIE/K15vQnvlT5ubQr4qEemHrlcvjsUwpmtc1NmuTw7dOUBpviStNQ0j6tF5Af1B1V6y0f/1fo6GR3zGdwe/SXuU8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929365; c=relaxed/simple;
	bh=7zPJ+iNuuRxIoAC6tHTfftFQHJu36EbUBFdWCcT5Bn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC3fRRyk/Yz2KpqazmHJ+1jN+O7sPh9A3Oqs8n4gCxW7RixWdbWewKAWTQEIcSnxB5WAbT70EzTQE6c4su6ew3S8gVcI7487L412fBvPc8C8vgg24SVeOKQpIff90YhCS86BwjvVHRajCD99XY8vYnne3scdsA+NSB4q+OT+BrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHG/5bYh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHG/5bYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EBF1F000E9;
	Wed,  5 Aug 2026 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785929363;
	bh=1lTZbFX+1dzzmPCzEBJh+41sPCJYIbOFiDnmwBevWg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hHG/5bYhQ63iutwTmecNjtPMxdPp1ryvJFyD19fgTqSNjiLZvkjDzBX/NpPUkfc5m
	 Y+/rnxOJb7u1HYOLgDLCAH9j7+ftlCj2xEVDt2CC/eZUoi3eYmIWtRll+tTuv043tf
	 SHnqnEZrLr8/scMHySDD9diPZhem+7udUBXUCgNDCvsr5g6l8AyOhQnvlxVbbL1/ZI
	 KjaQiVqhK33pU2wMUiq9qgc9fA8dNHlZRyKmmdYy2AYOPO3k7PMJRD5hlDOCW53jQ2
	 e4QhviZ/79/jyrMgRz/a5sy7B46EsV3zmc3pukXxntPKy1B8dARV/OfYL69tVS/E7K
	 TEJ4Yt7qTmknA==
Message-ID: <0b48cefe-7f05-481c-a827-4c1ffbc94598@kernel.org>
Date: Wed, 5 Aug 2026 13:29:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2 0/8] mptcp: misc fixes for v7.2-rc6
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Davide Caratti <dcaratti@redhat.com>, Florian Westphal <fw@strlen.de>,
 Christoph Paasch <cpaasch@openai.com>, Qing Luo <luoqing@kylinos.cn>,
 Gang Yan <yangang@kylinos.cn>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org,
 Shardul Bankar <shardul.b@mpiricsoftware.com>,
 Kishen Maloor <kishen.maloor@intel.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yuan Tan <yuantan098@gmail.com>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Zhengchuan Liang <zcliangcn@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, Dmytro Shytyi <dmytro@shytyi.net>
References: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Regarding the "funny" Clashiko's (long) comments [1]:

TL;DR: I think this series can be applied as it is.

On 03/08/2026 18:16, Matthieu Baerts (NGI0) wrote:
> Here are various unrelated fixes:
> 
> - Patches 1-3: harden incoming MPTCP suboptions parsing by rejecting
>   non-combinable ones. Patch 3 removes unreachable code after patch 2
>   added here for consistency, and to reduce comments from AI reviews.
>   Fixes for v5.6.

- Patch 1: indeed, there is another existing issue to fix. This will be
done in a follow-up patch.

- Patch 2:
 - Yes, combining some options is wrong, even if the RFC doesn't
explicitly mention that, and if there is space. As I explained in the
commit message when this happens, it is likely a buggy or bad behaviour
from the other peer, no need to try to get things working in this case.
 - No I'm not going to mention all possible wrong combinations, it is
enough to explain the pattern and give the list of allowed combined options.
 - Also, no need to insist about the same existing issue...

- Patch 3: wow, no comments :-O

> - Patch 4: fix a data race in the ADD_ADDR timer callback. A fix for
>   v5.13.

- An existing issue to fix, this will be done in a follow-up patch.

> - Patch 5: correctly catch data corruption during the MPTCP join
>   selftest by marking tests as failed, instead of only printing a
>   warning. A fix for v5.18.
> 
> - Patch 6: fix a leak with the userspace ADD_ADDR list in case of race
>   condition during teardown. A fix for v5.19.

I don't think the mentioned existing race is possible: I would need a
reproducer. Also, I don't think the commit message needs to be even
longer, and no need to change the error for the userspace daemon: it
will get the notification about the close, and it depends on how the
userspace daemon handle that, possibly in an async way, so no need to
get something better for this race case on the close side.

Also, no need to add a BUILD_BUG_ON(). This can be dealt next time a
flag is added (or on next).

> - Patch 7: deal with MPTFO with a valid token, but no data in the SYN. A
>   fix for v6.2.

Same answer as on v1 (despite the new comment in the commit message):
getting a more precise comment there doesn't have a lot of value: "doing
TFO" means having data in the SYN there. If the comment is modified,
that will certainly cause troubles during the backports.

> - Patch 8: reclaim forward-allocated memory in case of error on the
>   receive side. A fix for v6.19.
Existing issue that will be addressed by the "mptcp: out-of-order queue
pruning" series.

[1]
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

