Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389EB3546EB;
	Sat, 22 Aug 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787431444; cv=none; b=J63S/r1aEEfl4Dd1w3I34fa9vd94SVIGsIvoCK4fI9OQvsmNYmpI49enAcSnP+ZRopjzhAgYYcildhN2a33hRbVBegKszBznxJx77qq3Q14V62pCJO1FWPfiSVrP4Q5y+BRfFNtIrUSsTdwKR1TOXHwUk2AiSqhbDRTm/tOZvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787431444; c=relaxed/simple;
	bh=pE8em5ESimq7kEnbnIQn70TryphkT/GM8iNNxBxf+uo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Af4bfT2AgU8XiJYAk9QpAFFfepaIdiqsUuNrH0mOsT1LmjuUOt+iS0WfK781fpDp4R7i9br+hL2qrxg+TYFoqQHhNreeZFWAhADgowRoxDbbsS0nl2OA9ApuRMxwb7susj0jOVIAD9Khwot6rR50ucN6NkIc0E81SO3aiRfkEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCaghFYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCaghFYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6058A1F000E9;
	Sat, 22 Aug 2026 20:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787431442;
	bh=Vvmofg7n35kucFRZzzYsmckgLsmxC+unu3ShITZiohw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PCaghFYklys7Ri5/HUtvzxJYBjO1PheJgWcdUGbPI9dyq3L16RwV/PG1npbwL7DVN
	 +HB7pjJd3eAOtveNrsigEnvSVPyNpF51XWJARJFmwXVkyd56YyP0Sn7SJy8QPIDKcl
	 NSB6zLPQyZzYTMdkS6KouDpDiG2Tee0zrArxQdDzX0E37ABGBhl9m/FWHaWS0jqfHG
	 KdBoAIR6XNI52Mx5+3C0Vr3NYdGL0Av14rVWrVk9mGxYT0TFtHGcNOZ+4p8b3EGHFH
	 JdWS/iKgsXsKYWZCNFK2sCNLG4mPB+nzqncqfc2HuRIrMhb07bBG7oFTj+dVYIrRn5
	 Rr1Expq8ekHZQ==
Date: Sat, 22 Aug 2026 13:44:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai,
 "Victor Nogueira" <victor@mojatatu.com>
Subject: Re: [PATCH net 1/2] net/sched: pfifo_fast: cap ring size and
 account to memcg
Message-ID: <20260822134401.6545e4eb@kernel.org>
In-Reply-To: <20260820095742.68511-1-jhs@mojatatu.com>
References: <20260820095742.68511-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 05:57:41 -0400 Jamal Hadi Salim wrote:
> +	if (qlen > 65535) {
> +		pr_warn_ratelimited("pfifo_fast: capping ring size %u to 65535 for dev %s\n",
> +				    qlen, qdisc_dev(qdisc)->name);
> +		qlen = 65535;
> +	}

Why not a hard cap? We do that all over the place, once in a release we
pick a value too small and someone quickly sends us a fix up to bump
the number. No problem.
