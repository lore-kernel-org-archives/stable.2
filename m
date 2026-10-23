Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789429;
	b=cTFJf2xgpws/2TQ7iJyNXbO7FTYSQL8Pf7/W4HcKBY5jtmFQr9vyWxQ8fg95XvYFYc14
	 WiJgMh5fmuWB0ztuufmJ38KVwJ6f2NlPbEp60TO87+bTdl5LObAhvXkWYHngdnzjzCQgR
	 G/qX5515VaT5UApiuldATByqdGhxFrD5JXHg4RxpD3IebXY/ekI/xFU0KQAqQInw7Ztlq
	 Yls0Z5uXIUSOtrwS6blMvk47vndBPAR8AFWLwDTzUSkwlc/fxbtpXjzkhCQ6HK8xFBF/e
	 DRSkr9xnisZmoxYUfzGuS7e7Awz9G9wvSSFymKdTNw2SAz4vDzmg36CrV+OXrNXzn3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789429;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bTClk+FyBl2Z6T04cipQH6V1AiGgc6/ZuHebpAXvrJE=;
	b=qfOPMB3GdJAkzqc7UowZDwL6LGSzLAVvXt0pZkjoS7gR4A62baWdch0B14KQjPp588TN
	 YzMpcCpM4J0yP5bU6TSajzLuPtH1iIGlsW0p+L7Yhbz4r9V7JDygobnJeljXVj1AqlJSS
	 QALktfHOxA2fynRHNd89++76Lu8ikogxlNAnMUIew8apFUOMnMXvHgxI2WEc5ZoQ3eiKa
	 lLvBNerft+c00hHRKCk6MiOHoXEe9HXzT4wKHVjSgExFWFj4fELXwvZjvAvmca5E0ZuED
	 P5M0ds466hORIB6/QAhKrQCTGTvVd9ApG/z/bI8yPJnBohH8tITWfbXUGT8/e/z6vAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZyl77KH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599C606A31A;
	Fri, 23 Oct 2026 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZyl77KH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D50B1F01825;
	Fri, 23 Oct 2026 21:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789428;
	bh=bTClk+FyBl2Z6T04cipQH6V1AiGgc6/ZuHebpAXvrJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NZyl77KHeaX6sy3jgoOF9efhtsGxMjHxlBcoag9zA0fIUcMGzFraKZl125DqQp2aB
	 M/uZgF48GED70AZEW0Jpd2OAljm/yc/p67i/dZVVlxoMozyX6TH6TCQYcI9b0sn1gi
	 7/rCYSxPTXZ8MIbV9pvtULMBZe8hcWPmecXZRvZ2EEvUWnLpp78wI+BCzumYRDmVNh
	 wUP/Fm1r1E7xyTWlkZy4o3+OzGGZbmxpC/sLBqv7x+oxBl5l9vJXiD5gn1U7jNCoHX
	 TZveh/s52bacP9dpKYezzKJ0j0QkFqf73ariobD2rRINzpKDDjP8RvU3TW6UUFRt1N
	 1nw4TKgwbdr3Q==
Date: Fri, 23 Oct 2026 14:03:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, ae878000@gmail.com, daniel.machon@microchip.com
Subject: Re: [PATCH net v3 0/2] net: nixge: fix tasklet and DMA teardown
Message-ID: <20261023140347.095c1e70@kernel.org>
In-Reply-To: <20261018020840.3851552-1-mhun512@gmail.com>
References: <20261018020840.3851552-1-mhun512@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 22:08:38 -0400 Myeonghun Pak wrote:
> Separate the IRQ/tasklet ordering fix and the DMA shutdown fix from
> v2, as requested by Daniel Machon.
> 
> Patch 1 releases both IRQ handlers before draining dma_err_tasklet.
> Patch 2 masks channel interrupts after recovery has stopped and waits
> for DMA reset completion before releasing the buffers. On reset timeout,
> it retains those buffers and prevents a later open from replacing them.

AFAICT these patches don't fix the problem 100% of the time, and are
fully LLM generated, no tested on real HW.

This driver is not maintained, let's not mess with its error paths
because LLM says so.
-- 
pw-bot: reject
