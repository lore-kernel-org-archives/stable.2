Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4D3382C3
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579991; cv=none; b=PDufp6gmgUN33t4k+/O3IWEP1VvhM988bRXlWFcDVY1zQWiuLonY70S+bo13lNndK4hcq4THkWATIHfJQ0E2OvTxHMlXTKZQ4koqIIDdqU0lZ8j1Q8c6hlFBzR7XHSfrdGp6YV+HKFhKWArsTyas0Soeqby/WosbJkbfVUkBlXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579991; c=relaxed/simple;
	bh=e0PUo8fkABkwfo3rdO1IluywSZEkFXkYFS9PC+NfW60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gAaL3q4yWj7l0cm5o2FG4OmxbF2CzoMyX7mwblWG9mNcAZBzL7dzRWVQuePKS7eU3Bz6DZRQpF3A36QXiY527b5o+EmUGDh6k0oKAjPWyqYelmf+LZTN1huAjS0EN4T9vI6KbIqTZMzuKlT9mL+ifBFYTVQFVyUqFNn/1W67yws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hniihd0w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hniihd0w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FFD1F000E9;
	Thu,  9 Jul 2026 06:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783579990;
	bh=z05ytVQA+TaywaNzi9kCD/IAW6ociprds8p1fLLuodo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Hniihd0wBG99LMCQX/gInOOysYvPMVmZWJ3p1BhAsVwBp9XqfHNdGYB9b3eS52jrD
	 sa5MQnGMH1aHSzVlVrc435qEqMXenRpFQIJBAwZVOO/ugfexMyqU4iZanrYHa/wice
	 fK7no07D9Dk+baJo0kgJ2yLh8SJcHtjVhT/eaOUuNpfvIPL7pTbfLCStTeHn1G0SIM
	 +JUwe70QCJ6a//gzvT+wgtaeuO7BioHSdeb/8euW694/9vZsZSoo4mMEi9IM+K/ND3
	 V/Z+NMdT++HMVrGdpidcYc6UH+HGz8yUbgLbYpDIXWRPR+Atk5C4KUFzWJ6g/vMtYe
	 DgGgEqexrRDqA==
From: Thomas Gleixner <tglx@kernel.org>
To: Wu Frank <yifanwucs@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Keenan Dong <keenanat2000@gmail.com>, Yuan Tan
 <yuantan098@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>, Xin Liu
 <bird@lzu.edu.cn>, Sid Kumar <sidkumar1@gmail.com>
Subject: Re: [PATCH 5.15.y] rtmutex: Use waiter::task instead of current in
 remove_waiter()
In-Reply-To: <CAPw-QwdiQnbxiwrivx8HthquyQef4herojq15ozy2JgWa8sAAA@mail.gmail.com>
References: <20260708150527.3212183-1-sidkumar1@gmail.com>
 <20260708194323.agent5-0004@kernel.org>
 <CAPw-QwdiQnbxiwrivx8HthquyQef4herojq15ozy2JgWa8sAAA@mail.gmail.com>
Date: Thu, 09 Jul 2026 08:53:07 +0200
Message-ID: <87fr1sr6wc.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08 2026 at 18:53, Wu Frank wrote:
> On Wed, Jul 8, 2026 at 6:04=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>> Could you resend this as a two-patch series: this patch plus a 5.15.y
>> adaptation of 40a25d59e85b3c? Also worth considering as a third patch is
>> 74e144274af399 ("futex/requeue: Prevent NULL pointer dereference in
>> remove_waiter() on self-deadlock").
>
> For completeness, we also reviewed the related patches yesterday.
>
> Our understanding is that the correct backport set is this patch plus
> 40a25d59e85b3c. This patch fixes the original issue, while
> 40a25d59e85b3c fixes the NULL-pointer dereference. We also noticed
> that 40a25d59e85b3c appears to cover a separate
> use-before-initialization case, although that case is not relevant to
> this backport.
>
> I do not think 74e144274af399 should be included. It was later
> reverted by 39def6d250d3, and the revert changelog says that the issue
> was already handled by 40a25d59e85b3c. It also notes that
> 74e144274af399 introduced new problems.

Only 40a25d59e85b3c needs to be backported. 74e144274af399 is not
required and buggy and got reverted upstream.

Thanks,

        tglx
