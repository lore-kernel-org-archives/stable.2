Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D43469EE;
	Thu, 24 Sep 2026 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241914; cv=none; b=kGi/b0OePXWkKeragMCStIOYLfFGbhZ5FeL+USPVA74JkhegI56l4BLSFoHoTcCanfEmQvr4MHLke9KRM7kQrDYGcHZYPKsiMwnGivVZHAmZcTsn0UCUtyWYwDFD7en1sAEeILAnHEBZEjJYh0LvkS67OURGtRzwhaXyRIaJoBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241914; c=relaxed/simple;
	bh=YG9Or2cWieQA8Z2xaUG8nSqZOaMSVhxwsGfFjHLgMHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk/W9WkJRv8OY2bcVgW8exkDnjMpkBr4QS4q4jSUKi3ew3xVdbQ6uq3jeJxv6rQX1Qc0FY5/MqCGaU6Ema33Bi6Ca6J48VKK069d3Nd31jCi5gsFrzc3ICC/lkYAa0Ithl102qfCrRb/cSD9vhPVfy8oSkw6mA/jCiXpuOrG6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=aHAzpVVI; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="aHAzpVVI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qhGO0GNlUx56r0CFNnFpjUZBWNI+C0LfiEFJMbP2LVI=; b=aHAzpVVIrSGLYpsWCpgv4QH6Vt
	97Ft56cXbIIIfM9i9aiIGPP30npmCYnvhf2+8pYSySIEdBXobJam2CMEF5Rb3HN1sRo21O82Ki+nO
	o2/v3OqMvV1kZkC7mPq9Nwc7KSRjF0O4PsCrGdzqRKopLx8Z2JhXCS41xpVU1riF75e6fUMY7DTP7
	sTgHhfZOSZAhiFjT6Dm6uYajU6J03I+wsqmGrqunXSkEuJhqXlJOGjHCa2upZknUTBWqq2nsXknfx
	kermblX8xd5nCOzeX5qCkYwyvp0LbaU/6orvOPU3btwtLzV9T36uAwPI6kET9rxhqzqXGwZawr+q/
	69DHsP8A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x9fhG-004Qb1-0T;
	Thu, 24 Sep 2026 09:24:54 +0000
Date: Thu, 24 Sep 2026 02:24:48 -0700
From: Breno Leitao <leitao@debian.org>
To: Hui Peng <benquike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, andrea.mayer@uniroma2.it, 
	hangbin.liu@linux.dev
Subject: Re: [PATCH net v3] ipv6: sr: enforce exact attribute length for
 SEG6_ATTR_DST
Message-ID: <arTr4ppezl2BD68S@gmail.com>
References: <20260924075143.2839886-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924075143.2839886-1-benquike@gmail.com>
X-Debian-User: leitao

On Thu, Sep 24, 2026 at 07:51:43AM +0000, Hui Peng wrote:
> In seg6_genl_policy, SEG6_ATTR_DST is defined with .type = NLA_BINARY and
> .len = sizeof(struct in6_addr). For NLA_BINARY, .len only enforces the
> maximum payload length and permits shorter payloads (e.g., 0 bytes).
> When seg6_genl_set_tunsrc() copies sizeof(struct in6_addr) bytes via
> kmemdup(val, sizeof(*val), GFP_KERNEL), a short SEG6_ATTR_DST attribute
> triggers a 16-byte out-of-bounds read past skb->tail into uninitialized
> skb->head memory, which is stored in sdata->tun_src and leaked back to
> userspace via SEG6_CMD_GET_TUNSRC.
> 
> Switch SEG6_ATTR_DST in seg6_genl_policy to
> NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)) so that generic netlink
> validation rejects any attribute whose length is not exactly
> sizeof(struct in6_addr) with -ERANGE.
> 
> Tested in QEMU against Linux 7.3.0-rc3 by sending a SEG6_CMD_SET_TUNSRC
> Generic Netlink message with a 0-byte SEG6_ATTR_DST attribute followed
> by SEG6_CMD_GET_TUNSRC. On the unfixed kernel, SEG6_CMD_SET_TUNSRC
> succeeds (err = 0) and SEG6_CMD_GET_TUNSRC leaks 16 bytes of
> uninitialized kernel heap memory (tun_src =
> 836a61ecc4d25a1042a8d60411cfb378); with this patch applied,

rhis value here seems unnecessary. Maybe the commit message can be
improved?

> SEG6_CMD_SET_TUNSRC is rejected by netlink policy validation with
> -ERANGE (-34) and tun_src remains zeroed.
> 
> Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
> Cc: stable@vger.kernel.org
> Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Reviewed-by: Hangbin Liu <hangbin.liu@linux.dev>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
