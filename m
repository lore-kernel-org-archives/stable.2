Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078289;
	b=1Vc3kPo+X1e8RiAbEHtlZLuKOqPWekX5CE2iERbj8EFQ43h4Kzq3h5V+Spm2J7zuWvnN
	 JtevSb5tUxopp4HPNJjOzeHZG4++IqAf+UprW1Xw67Bs1o9zhliCHNYuny5UZCCwClOiw
	 8A7TeOAQrQEgj/8uCSTL1OKnGBBoBTZjnAtS8Tz1HStfRoGiIOwO2PaGLsXoBF8U3bZm0
	 5nnl/HraMCAAKa6ZlaZyKjUWhEeS5EFzz4eo+ZIUHEtlNSwRa/cuY/QMDOTLkgifje6JC
	 TSVH7DW+35GNqPuGME5xrQkjnb97/Ijlvg+7V4CagZVLGFOSbZEUptzigaU6vAFOPGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078289;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9Eu8l/Z/fuLDQv8ybN5sEHnZjuFP5Zkq9QaBEt3hkvo=;
	b=xS3wfaLvBlCYemrouIQpIjVfOIs0rfrfp8Hff0krX9PyFsuoaMnew8MZq9tNu5lW8f+e
	 wlEQYwamYg/Cs2KJ0AeyP87K1A+MOUlzRYlffV9CNaWb9Rs9eWKHXywGD2ojxFnoJ5kTn
	 TmJh0sHhQg9EvP9cNZOlKtMq3+uJOB0GhKpRxGM0b47//YPiBP3NhiX1TcxzSo0jINxOr
	 HfwqV09zsAKb1rDqjgryJJqKShqVPqy0Yg0k8xfzw32O+5iOenKXsjKPTtDJ54iC/z4A9
	 g2QD/6RWl4xQWx93VfcRmbnEkduVkbpNMVhne1xFkgzuuhSFlgysux3DRg7BAylKm8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOdE8Ddg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOdE8Ddg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210C71F0089F;
	Sat,  7 Nov 2026 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794078289;
	bh=9Eu8l/Z/fuLDQv8ybN5sEHnZjuFP5Zkq9QaBEt3hkvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kOdE8DdgZwzsmjjcLf+LCWR2gZteKrGKJx8HE/k10rwdxSsXnuWqNJ9dc5aaEoqu2
	 s7cnDCaeElyUtAwLA2kGQA8pc3eSx9Hwpk//iSQ+znqTh9rpHpwXK5IO23OPTCgT/b
	 h2RHl7k7ntu+f3Tluc13em4JOw03KhIoYCK1BSpPNMxCEkZnXSim7YHVVAy4Nzovld
	 WxqLOvbf620WG2WqNNoylkPrv+Pa2P+uuh0oe75igYYtwuoNNMLIpVnZO8SIghAJJC
	 jdInTmVrk5h1lWDWUTRgMQhRSp+rGGWBVeJg0KeucZd2LIRutlvZ4l90X8R6BiUo06
	 0F5myvj5DyApA==
Date: Sat, 7 Nov 2026 11:04:47 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: aalbersh@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] fsverity: Explicitly require FMODE_READ
 to retrieve hashes" failed to apply to 6.18-stable tree
Message-ID: <20261107190447.GA6049@quark>
References: <20261107051544-failed-6.18-1acb4fd2d011@kernel.org>
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
In-Reply-To: <20261107051544-failed-6.18-1acb4fd2d011@kernel.org>

On Sat, Nov 07, 2026 at 05:15:44AM -0500, Sasha Levin wrote:
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1acb4fd2d011c4bd6cc961095ae17361c71ff61a
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051544-failed-6.18-1acb4fd2d011@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'
> 
> Thanks,
> Sasha
> 

Actually a clean cherry-pick, and failed to Cc the fsverity mailing
list.

- Eric
