Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DF8003D;
	Thu, 15 Oct 2026 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071066; cv=none; b=sLe0pVtFn754UlHxeT0jL9JBdKw7uyX353fofoCmsayCP9ebhOA2nSBkLz+0jVUp1xrU4ou93HkQJSMLRhrKWm2G7q5yFOXkWxG7u/xPkMRZ7vDpmBfM5SkSMQJZau17SwHgPyxT8wnDVMceNRSz9QPAroy3aIo+l9/SVpsoeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071066; c=relaxed/simple;
	bh=qTODxqyJB391XQFDcDDrXjBsxFBg+VPofG4ByZjkVI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUNDq7kCg/P+ugPo7nRxs/00jQQveZeSRPisUIjTsYXjHwlp5okNz+1u5r1Dtr2/5b1aIVlxpWbUT3Fo2/gWZrBQRv0yZcwmH0SixL+dWXlgO88omjRm0lWD8/xviBtmV/IitAlM8YFiQjrLFoyfmKqczKJEWEK1dOW5GYj2o6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIu7lCqb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIu7lCqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E641F000C5;
	Thu, 15 Oct 2026 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071065;
	bh=qTODxqyJB391XQFDcDDrXjBsxFBg+VPofG4ByZjkVI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AIu7lCqbte4yAOTJtAyyzf9jx7S+b1okAaMb2fFVc8eXa0sGWzVOhvdVNu/8t8pvS
	 BycOMKkRi5Lbd44uOi2eeyDZ2RgkAPderosj8XB3JF07ow6wnfGgv7uGz3rntwSt11
	 4/TXioFDhaj9IVjK4qYN1CEjkM2zjm0ycvSQn3LoDTwWdUo4VP3XUR6g5PARxTDYTv
	 3MG2bCXwN265slDStPstAUuh/wDDwJDkClY2c++MQwVLpQQm3q7EI5foVun4507WzO
	 vrjhJR2AUsiwEzd9lsnKnMwYJ5IRy7pqm0Avh/WPcvJI8UDEvUSE3LJOJ4dg2u6WVp
	 XtkS7cF3cMb7w==
Date: Thu, 15 Oct 2026 15:31:01 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Birk Skyum <birk.skyum@pm.me>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Daniel J Blueman <daniel@quora.org>, 
	Sasha Levin <sashal@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL"
Message-ID: <atDVf3aEYgzO5rXQ@zenone.zhora.eu>
References: <20261014130805.48840-1-birk.skyum@pm.me>
 <atC-ZZLkXs3yM6l4@zenone.zhora.eu>
 <179206679156.49371.3533488984291951831@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179206679156.49371.3533488984291951831@pm.me>

Hi Birk,

On Thu, Oct 15, 2026 at 12:19:59PM +0000, Birk Skyum wrote:
> Thanks. I tested that fix on the Yoga Slim 7x with v7.3-rc7 and only
> i2c-qcom-geni.ko swapped. The keyboard and touchpad work, also at the
> disk passphrase prompt, and the I2C serial engines stay at 19.2 MHz. So
> the revert is not needed.

thanks a lot for testing! Appreciated!

Andi
