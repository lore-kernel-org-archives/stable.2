Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94847D926;
	Tue, 11 Aug 2026 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485410; cv=none; b=kmNiaYm7nP6KkzzClSy1kw9hJk0Ba4Dt6hZPbQOMoXWGp0XJ77OWpchtQvdOZxASNdEYogf0nU0CL1dhN0hstCy3hcsdVSQ1Keej8piCFeUCEJQK08lH4+kj5BYmaujlNkOJAQKl7UoiGrCweI7wJF6hdmYLIR8jhKJc86DTkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485410; c=relaxed/simple;
	bh=vY0g5e1m0AO9C0tJA8CR8vrstspIV9xuMuEB28K7TGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsU2TDFHMv3SWOlnKc6B2Vh1GtKugtBYjQ9Z+2dy2uHlhhp5ti2qR7QilcrS7Oli2zhWBsdBafbaDDMTPJmC3aXeSRb+qj802QoquA5JpL5kAFEf26ORaNTr5qVo8t68G3dRlSGLBYbDlbNxKC3xzZslQQUxmTreJhqJRKEUToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh/8LrQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh/8LrQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763D51F000E9;
	Tue, 11 Aug 2026 21:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786485408;
	bh=hFIbzakitGwSk8y+vFk/wcfsQZafYclSWvL8Py7Ikak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hh/8LrQo0BGFiDXXgS7tf/9i81S+NcOBCaTdtJ5IrIYCyZmmkb63g7n3dMyKX5H6+
	 PZ9xRSNDYRqpI/IY9LYk791rhtp8inqiWdawWV9HACNpVCHDY81KOzgKPSalEVghX7
	 eQ/kpsMuraps8+FIOjcrZUQ4DXcxE5fAwTt4afHkKI+j4+kwVd4dBCT2Di+QJFcfMD
	 0nq7XfmqcjTMVIyK33y/HIhX5jhM+s5hZUYptQ9Euhq8xq2yDQola/8k7Bido0j6Gd
	 6St9rEb0SxYMCXJ8UGjdd8nASJtwt9UHHfouV7lunZbkbVf3qGzA3Pzhd4KgYu3s4L
	 1HL36w7aahBUg==
Date: Tue, 11 Aug 2026 14:56:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 sven@narfation.org, Kyle Zeng <kylebot@openai.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, Dominik
 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] batman-adv: reject unrepresentable multicast
 TVLV offsets
Message-ID: <20260811145647.34a190e5@kernel.org>
In-Reply-To: <20260810145754.828936-1-david.lee@trailofbits.com>
References: <20260810145754.828936-1-david.lee@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 14:57:51 +0000 David Lee wrote:
> +	long transport_offset = skb->data - skb->head + offset;
> +
> +	if (unlikely(transport_offset !=
> +		     (typeof(skb->transport_header))transport_offset))
> +		return false;
> +
> +	if (unlikely(transport_offset ==
> +		     (typeof(skb->transport_header))~0U))
> +		return false;
> +
> +	skb->transport_header = transport_offset;
> +	return true;

Find a better name for the variable instead of wrapping the lines.
