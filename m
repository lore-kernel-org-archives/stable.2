Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B83264CC;
	Mon,  5 Oct 2026 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228002; cv=none; b=YMkoY1cQDq3IIhcNX7hgIEz/Yrou0doV1YodvxSl+KOszfjLeC/oL386y4zrilWiUbYb18WpqtXklFojN8zb+XPBkKEuIyGzqHg0AMQJua6lMIMT7njFh/eFFX/gCO3rXlAZppDOeklNtlMeAnISurCy1CRmxcC/jOmDONuHU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228002; c=relaxed/simple;
	bh=KNZMnt9O9Y/VSXc2y3uWP6nlNU77j3GEuU34n1NPT50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd83AXFiIORazQpGFu9OAAcwb7coMAF2RXlCFkY/xWyilktbSuFpPLctz3DrljxLiIwrKncHpjprPdHSbmy2nnIjx1Rv3fW6nV5yRjh2OuMbi9jLOpawgxXfsCNU9gtSIJ7lcKh57i/tsnso7CTVC33HhgAr6WXsPjwTuL4c9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGXhOxFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGXhOxFq"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BAC211F000FF;
	Mon,  5 Oct 2026 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791228001;
	bh=poz2do/LGppvKRbWIc373ATvQ1pRicG6op/w5cF/aD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lGXhOxFqF5R3f63h53AnGuCcyfhAlkXm0eWaLJ5JCbqp94iz2JYBrNXELK0P/+aHe
	 a6oztQbG7CKK6iuO3fC8/SLAVoyPBUxRvNBVJUOdqA3KXNiJDEHpBPR0cK37u4RY7Y
	 7lhgzlAlJbNN93OBCQ9lHdAUOnhI5S6WjkCnjCJdiJx+3+C7fEogKugE7fCI2S6rTu
	 dG1aKRryZeiJ8TLfRWrODmpcQ3NPHKw5VO2Utq3ywG5a589a8+n9Wx+oB50d2AyoN/
	 6KeCx0ZCRLJfTF0xypIlnosGn7ier0E5vPYDjoieAx1xA2ndxthaXJOnAyYyeQbF6K
	 DvnpWRaJUgXyw==
Date: Mon, 5 Oct 2026 22:19:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan McDowell <noodles@meta.com>,
	Justinien Bouron <jbouron@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] tpm: fix off-by-four bounds check in
 tpm2_get_random()
Message-ID: <asP4XGM3P1Fdj5Ko@kernel.org>
References: <20261005075934.151106-1-jarkko@kernel.org>
 <2026-10-05-1-daily-reply-0006-tpm-get-random-6.12@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026-10-05-1-daily-reply-0006-tpm-get-random-6.12@kernel.org>

On Mon, Oct 05, 2026 at 09:50:27AM -0400, Sasha Levin wrote:
> > Fix this by checking the response length against 'offset', which
> > already includes the skipped parameter size field.
> 
> Queued for 6.12, thanks.
> 
> -- 
> Thanks,
> Sasha

Phew, good to hear, thank you!

There might be for some time more than usual merge conflicts in TPM
driver given making tpm_buf memory layout flat for the sake of being
able to use __free for of its allocations, and thus completely 
prevent any possible memory leaks from transient buffers.

Right, and also merge conflicts could happen also in trusted keys.

They are cheap to fix and I'll monitor this situation proactively,
and try to react fast.

Br, Jarkko
