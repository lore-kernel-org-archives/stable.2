Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D24481FDF;
	Tue,  4 Aug 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866455; cv=none; b=TodLYNO5QA5b/jYyH+ZK1e9jcdqz60hQGAuVjgIFbBqm3a+2R/TFMLZJaemfrGBa0nMoJL3MLdwAzPVG5a3+DS7IO4nscsAQGMT0MB/ldue+fXCJcLqJ4Zpe+pWR+VmrmQjCzQZMfYef4yytdtKaMn3+MhH9pVWNvfjlKqkErSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866455; c=relaxed/simple;
	bh=iYbz8ptwNvphLEpaCX5NMpJJCU8tvPOhVm0UJfyvN1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOEcOTf03p04szUFsLKDhqoFJo57qiCyB3DqEIclm+1Qp8ck4jkHJL6gVSAz5f36LD+Bbyp062bdZJNp2itveJ2lKRDRCfJ7xIwUjNezCVyzGRepvF5p81VynUrdWbUId7/MXhobRJefk0uYszYOmXHKuobyDgZPNYHWwb3qPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH2Q/ph9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH2Q/ph9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F6A1F000E9;
	Tue,  4 Aug 2026 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785866453;
	bh=Ol4u73S6iewdfvEZtCXNgbQ1k86m1sgo4EC26jm0nDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lH2Q/ph9dte98Ehh3x/G9+ZuCkl9gy7qofZqnmouUTacoGXpTDkAJ06Wrpp5/PzRF
	 5amPgP7rnoYCm30u45mG8J7HEyiLUkTnzKkNDOxaxBsXG+5xbzB0W41er6rkvG7i8W
	 JBQOnms5HzDkBdRtij1ILtJNNnzf5jHCT27rvTXgaA/jWuRHeXA3CjBbneYp7WNoIh
	 taLVGOoBhR8TjXUn3xxyVoMlqpaWZP0Z5CRgQwnP9Fhw/mNO63vruTWi52wMU25HNx
	 Jsn+buyNdmKCKk2dt1jnr3VX7KcRVfsXhTG3pfrBurvr1wVPpHl6f+5VlgWHziUB2x
	 qB/r6ihDMk8Xw==
Message-ID: <ec043cd9-ffc5-4a16-a80e-b736ea50bf3f@kernel.org>
Date: Tue, 4 Aug 2026 20:00:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] mptcp: hold msk reference when cloning request
 sockets
Content-Language: fr
To: David Lee <david.lee@trailofbits.com>, Kyle Zeng <kylebot@openai.com>
Cc: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 geliang@kernel.org, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ren Wei <n05ec@lzu.edu.cn>, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 caoruide123@gmail.com, enjou1224z@gmail.com, Ren Wei <n05ec@lzu.edu.cn>,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, caoruide123@gmail.com, enjou1224z@gmail.com,
 Vega <vega@nebusec.ai>, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com
References: <20260804095051.715355-1-david.lee@trailofbits.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260804095051.715355-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David, Kyle,

(+cc Vega's people)

On 04/08/2026 11:50, David Lee wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> An MP_JOIN request owns the reference stored in subflow_req->msk.
> inet_reqsk_clone() byte-copies that pointer when migrating a request,
> but does not acquire a reference for the clone.  The original and cloned
> request destructors can consequently drop the same reference, leaving
> one request with a dangling msk pointer.
> 
> Let cloned MPTCP requests take their own msk reference.  The source
> request still owns its reference while it is being cloned, so sock_hold()
> is safe.  The clone's normal destructor balances the new reference on
> both successful and failed migration paths.
> 
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")

Thank you for this patch. It looks like it is similar to this one sent a
few months ago, but where changes have been requested:

  https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com

Do you mind checking what they did, and explaining the different approach, please?

It seems there are two issues the Vega's team tried to solve: one with
MP_JOIN requests (what you are trying to fix here) and with MP_CAPABLE.
For me, it is fine to split that in two patches. I also don't mind who
is writing the final patch(es), as long as credits are given. If you,
David/Kyle, are doing that, it might be OK to add a:

  Reported-by: Vega <vega@nebusec.ai>
  Closes: https://lore.kernel.org/40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com

@Vega's team: OK with that? Or are you actively working on a v3?

One last thing: it looks like your patch is conflicting with this one:

  https://lore.kernel.org/netdev/20260803061739.134737-1-jiayuan.chen@linux.dev/

> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Co-developed-by: David Lee <david.lee@trailofbits.com>
> Signed-off-by: David Lee <david.lee@trailofbits.com>
> ---
> Bug found and triaged by OpenAI Security Research and
> validated by Trail of Bits.
> 
> Trail of Bits has a reproducer for this bug that triggers a
> KASAN use-after-free and can share if needed.

I think it would be good to include the (decoded) KASAN warning in the
commit message. Regarding the reproducer, if it is with packetdrill, I
think it is always useful to share it. For others, don't hesitate to
share it to the same people: it can help better understanding the issue.
Maybe remove the mailing list when doing that if it is security related?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

