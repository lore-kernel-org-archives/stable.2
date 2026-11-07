Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081823;
	b=jx3WXSXmpHezftyaeKRDpf+Xl1cflDLqQq2XMRzG5k29zZsbAJEn/VtBIwgLYxdTBaMe
	 mcxQmoIYhjMo4ihgnxDfgnNRpS7fjaxtrr7OrTasB/u2T7HujlHmsERdsBjtMI7T9Vr1R
	 CLwZUQ4uu8QCsp2HDaAhRwjhO6OHcNP3cuTTouVvwg+oghmleYEfFmZUBtILrBxLV20pE
	 rR8gkQXtU3yh1OADPh4gN80RABJUTa30EYFYHIiiVjr4NeybD9dYWhl/0bHl46dXZEPMd
	 JKHcNAR2RbPWmifg5PWppGDs17mEgD2dm4/9tOhFzVLHIJxXrhVWuNorNLwR3veiSVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081823;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GwjMrd9pg5hodrzwM1CFV92DWe1JCQgYZ27OIOvfBO0=;
	b=yvf9YtvUi3avJ7BTa/bJvcSfeX72IlDag3vL29kXP0XDcjaxwyhP5rizr7DV1jWRkrym
	 x5VA+L/2WrkDoFXC96/IcO8eySvN3tyMO25nLg0JabntwtAPCwVPPirEJfXuBCQ1/JcEM
	 XzE1Bax3GxP4vwXjHynJkBBZZPQHHM2ABEfvkoqaJlh22hWkWPgXWXFSM2vfotgyqQX0J
	 xLt9cq4/uh+wKy3tWjpsiD04lhf5ttzwrl48V1ddota+We66gJJdIsjJOwr4t0Z2W1HZb
	 PiGaEYCglwu8AdUlim7deWQWDxqdFcTDJWqz/QiV1bWIlzOg/SmeIIwy7AWQrK3W1Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dg6G81yr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dg6G81yr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377271F0089F;
	Sat,  7 Nov 2026 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081822;
	bh=GwjMrd9pg5hodrzwM1CFV92DWe1JCQgYZ27OIOvfBO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dg6G81yrhhNlZogUcEx4rNBM2M8BY8DgKZgV9YRulw7k7PnYLtsHDQ7+VAiDGBnO3
	 Yo7z1vTHB5ZVyiUc6qg3xp+TKABIzW2a9ChdbPFwFtURobzmpEdh2o3ODnhPPWJwG8
	 qYYyZzYha3zjggi9BmZKZ6q9+H3PIf3XffjIjgpwO8Fw/V9drIuvhA3duo5fB/YM/A
	 rbFYW3Zq75P/P8Ahr2QCDXgx62FSKT6M5JxRPNvBu8zX2MPXbMoO6QwglWkTU+acs3
	 BljannKNLvtnA5wohEi3Hf8fODu1zE3iIXhzhunNL2R7BJ27zANu01e1Ul1LLM6CCP
	 /MYvrjNowYnZg==
Date: Sat, 7 Nov 2026 12:03:40 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: akpm@linux-foundation.org, hch@lst.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] raid6: add missing vzeroupper to AVX-512
 code" failed to apply to 6.18-stable tree
Message-ID: <20261107200340.GE6049@quark>
References: <20261107050912-failed-6.18-b82cf9e49c1b@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107050912-failed-6.18-b82cf9e49c1b@kernel.org>

On Sat, Nov 07, 2026 at 05:09:12AM -0500, Sasha Levin wrote:
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x b82cf9e49c1be7cf1fd8e1bd806b0cdd25ab8127
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050912-failed-6.18-b82cf9e49c1b@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'
> 
> Thanks,
> Sasha

Actually a clean cherry-pick, and failed to Cc the raid mailing list.

- Eric
