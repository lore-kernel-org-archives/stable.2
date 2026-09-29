Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BEB215161;
	Tue, 29 Sep 2026 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645727; cv=none; b=mrXOVvfJ17XclsBsJJp/HR3GXXr54K32mrEYF9VOPKLPXuHFi2TpvwdRf872wIPfHVlukuwDuQIuTwXiKrQnb8BQ+kVJsM8FN3HtJK6o1GQ2J7fLlp0cZEUnlT8RurtSD83ftSmlNRLiaYV57GRvCKfP8sNyzHrJHiTKW3z7uTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645727; c=relaxed/simple;
	bh=NJSyGXD2EwTKcLGu1HY9B7Os49k1NqxHt9x5UnhYyvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ydi7bYU7LIabNIIVYBrsA7Oj5EKyrj+L8d5+JW9VXx6XfXtoxpZI2sQw0DnUS9KByvTFe0wAWI9XdMjx2Ql9r4hxs3HPWdqZSAbrm3Tq32+Mt/EhNPBi6TJqxAWxcDQIz3I4mByzJ0ie9DcwOO/FPbpIpjwuSOYgQ4qV6p+zKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQYNSjdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQYNSjdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBD81F000FF;
	Tue, 29 Sep 2026 01:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790645725;
	bh=pCrG0k1yDWx7CtWGccoJCO4e36Yro3RuOIif7AX3wEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UQYNSjdV91mcpdlkgGvkQ4y5QAmUgy9+tHY9OM9D3LIMyRbXXwqyHL0Nv+G5z3OMB
	 iUXuME4c1lqq6K27hU3V1KdzE0NTuCCIWv6f4DaP8diB4ICG/e67QilwZTmp9cVE77
	 7CygRoj1DaN6lL67LpioKyx/V1nAnBeeAkbZaCY+j8G3xbzX23TDKpoygT8hvkAfkX
	 sL+ETpeDJf7i5huSAd93qFYfZ/hCQ7hC39IetjwccEiTIcqp7OVrqadD1rwY9Od4RQ
	 BPGXSCxZTZxbsNhUd+lPdi4gnUMeQRbAdK0/iN320AVfYxzO/Wpchik4XBS1R2dz6g
	 5rmqFBWYpL4gw==
Date: Mon, 28 Sep 2026 18:35:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: dhowells@redhat.com, netdev@vger.kernel.org, marc.dionne@auristor.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, qotmddnjs@ajou.ac.kr, stable@vger.kernel.org
Subject: Re: [PATCH net v11 08/17] rxrpc: Fix error handling in
 rxrpc_send_data()
Message-ID: <20260928183524.42b4bfc4@kernel.org>
In-Reply-To: <179052119212.2160803.8225282033493339825@kernel.org>
References: <20260923133706.1496540-9-dhowells@redhat.com>
	<179052119212.2160803.8225282033493339825@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 14:59:52 +0000 netdev-bot+sashiko@kernel.org wrote:
> - [High] The fix leaves the new -ESHUTDOWN contract incomplete, and this
>   breaks AFS abort handling.

This one looks like the main blocker for the series, right?
