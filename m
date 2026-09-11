Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD02F2619;
	Fri, 11 Sep 2026 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789087959; cv=none; b=MfPEEnuBAYxvrPvjhj31U2u3RCYrTqPSIjVY4pvr7JPNzq9ysTcrlRz9zsLmq161c8seUAfjhHD1WX+9khaH+7tw7O6gaF8lSqw6c6j8248hwDLxWjomHLC5YiQAuerf23px83e8xMID9X+FnzwMVSD3t3jcttzfjO7oAdtBrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789087959; c=relaxed/simple;
	bh=tj3r5ZOsxyy7KTiKPONNnN85KVrg8CCR13C0cOlXPcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r379qWMOLF+uY+WV/6HHjs5UHECUE3mQyPZTyMUe2rcSH0whjW98xRvcon49Dit0QLc7h8+mf3khHy7bJxm1Qw5hgelKqI5icHHLFW9O82w3DTq9HwoDxe4wfwEodHZS1b37Q7fWWJvSk20GBfeRhPdbyVF6YHiMSyv+X5v1lyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNyspEpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNyspEpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617BB1F00893;
	Fri, 11 Sep 2026 00:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789087957;
	bh=mO2epwjxSSdZ6lSIhwsGxey8ONDy6qE+WzF6Mo7qh28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PNyspEpM40cFhx6A7PBYvHqWRAe+UX3pFHbVtKmkCy31P6+y0Ol6+5cWDlZVYyQUT
	 ARUEphc+U/5qBVpPtOIAo80dh9gvOTlXU5HMvqYC1u0T83axGqu6oyn4vOsbTVnjO6
	 RfH1COMHQXxkcBFqOCjoRjOM/5OEoOCTsmYI+SX/fjKoMYje3Ur1sBblgojcPt4iXB
	 Vca7cJNKUjfgAHUCA7tgbU763n9ZL19SdbV/nC3g/si6uWU+47O9QcfVlgM3Nprbg3
	 kX2JcsgDLc1o1poK4sPEzOezZalqnn/vrxksffVRJS75EvdA9tlIgpCCOOnru9uPeO
	 ckoCuhkqoYpfg==
Date: Thu, 10 Sep 2026 17:52:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: elb12345@hotmail.co.uk, sd@queasysnail.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] macsec: require CAP_NET_ADMIN in the device netns
 for changelink
Message-ID: <20260910175236.3ef872ec@kernel.org>
In-Reply-To: <178904284935.219967.10266742419018601309@kernel.org>
References: <178904284935.219967.10266742419018601309@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 12:20:49 +0000 netdev-bot+sashiko@kernel.org wrote:
> >     An unconditional gate also denies the third case, which is a needless
> >     uAPI change; hence the narrower condition.  
> 
> Does the narrower condition still deny that same class of purely local
> request?  Would comparing nla_get_u8(data[IFLA_MACSEC_OFFLOAD]) against
> macsec->offload, so the gate fires only on an actual transition, keep that
> case working?

Sounds reasonable. Let's factor the checks out to a separate helper
function to avoid building very complex conditions in place.
-- 
pw-bot: cr
