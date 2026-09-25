Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164C445ACE;
	Fri, 25 Sep 2026 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327069; cv=none; b=n743/U0f2BDZ/avzRfEQV/tFtX2HUB3xDRL8VStdEkwo8cJNK4jsaHeimbcOGrY5dddmIhRPsdLQeoSFWC4HB8SGOQQI0JLgrDTjLgbxGALnGLcoGUIUpo3r/mNb8eTAsZtjpIl5p7vLKBYiXNZwt8WHeARRqVyAbJynh9kNNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327069; c=relaxed/simple;
	bh=O/1Hp5SfGXg6AlinpEDgLJGWyCdzxj1JHxR09/jDS8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYedFsmtlzl3euXm25IlolDMxuE7jab7qGWQ1I1bzTUzivdZ9imGhcMSDelC2EBm6vR9L9V4NTHbSnX+i2732kGo1yVXafxaUO9Fppv3Trolqyk94IenWCSgf9SLUXrCRrFc1MaG+Hsook8SXFIhnND+OIx/PzgEg4r+4FCCwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwNeb3yZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwNeb3yZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED401F000FF;
	Fri, 25 Sep 2026 09:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790327068;
	bh=E1aAdlePJGtJE2B/B5CnwjGEy8FWgzy/hnBRYYo53uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IwNeb3yZeaGsMwajxduralc04z65qptcNFIL0WbPwzIQvoZ2fFSfkZYB5jBrPAQ/Z
	 VfGLFQJBuJLvUk43v2ADcQQ+0GqF1xk4RY2N2KdMplIE3OUBsnRov/co9IAmp/zJhd
	 CO57ftVBGw0uFKqXcjDjkmtYvxfPuJ4W3Y/Nr4bo51qt7WKa6F/jFS+rxxJQyYtoqT
	 66Z0lZDYdIHCf/GeRnnJf8wWLlfo6r7775sWZciUWKFFxBfj/TdkHYO1ePbefL9gJw
	 7vaPwus4QDdYaxX047DpQCY1j+049L7p/9DAnsXDthy2fV/pz4KI48WhYIq75ZB3fr
	 YBDPXR2t/Vclg==
Date: Fri, 25 Sep 2026 10:04:23 +0100
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: vulab@iscas.ac.cn, davem@davemloft.net, david+nfc@ixit.cz,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
	pabeni@redhat.com, sameo@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: Fix socket reference leak in
 nfc_llcp_recv_ui()
Message-ID: <20260925090423.GG13925@horms.kernel.org>
References: <20260916073424.1971784-1-vulab@iscas.ac.cn>
 <178989049996.2160803.13194045712273112388@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178989049996.2160803.13194045712273112388@kernel.org>

On Sun, Sep 20, 2026 at 07:48:19AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 (1) · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] Incomplete fix: the identical nfc_llcp_sock_get() reference leak
>   remains at the sibling call site in nfc_llcp_recv_connect()…

This concern matches my analysis.
I would suggest an updated patch that fixes both functions.

> 
> Pre-existing issues:
> - [Critical] Post-handoff SKB access / use-after-free race in
>   nfc_llcp_recv_ui() (net/nfc/llcp_core.c:902-907): the extra SKB…

...
