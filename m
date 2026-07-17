Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0169443F0B5;
	Fri, 17 Jul 2026 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275600; cv=none; b=ENyudNhxEp8u5uYgs5RZy+Bhnjr1DI0aLz4G7xgqk5X9xpRMJpJBYMF9qcuY3CJjEXBkFvHS8Tji1HMgKXdv+O6vPJx7dXyskTr5E4OA3Hm3z7UEmQ/tb6onhZczImmD88phYfIXKSFQUidGwV1pRtj3PpsjucBWFPcOeREQk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275600; c=relaxed/simple;
	bh=15qUkPp5HQtWJu75/V5fmaYTxyKfq3G+IWIiQnmuMRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZI7pJQKy6KdXUE1XEYLYEQ/LZnAbSrlahYvOcMgThUax71ehBcxWR7iKv6G+BV+nhZFRIEkff0tbHNEwfBHt6tV9ADmaIg2PJAUuug39LGZefxe+n9ie6y8tHpWfYlbtyuc+SfEPZf3CllMsQHgTjeakQtNrcDIVbXdofpfARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HFtkzazX; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HFtkzazX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xxOMUzehe95KNEii0uEksq1dvZVX0jr/h3sQAwlrmbI=; b=HFtkzazXxq1N/WloVcJxpXwhZH
	EWr52p3vkewYnHnYpJmhT52jtoFjzOsLItNGLmqySQ+Cr/EZW5ZYRyIrRKua0ztWfmK9Y0Knvn9U+
	OzZza6xQY1S0dfn0BEYCtLEcwAJUDR6pnhYS9ZreUIwz8mKc35N6CsNRimAnqrAti1JAyOBRCU/gR
	oMbdHv98Qb3yiUEYLglklxhdPHuxagwxpAmL4djO8aBNdHtFtE71X4ZZRHQ6XQIB7Pq2VZLCGy5N2
	h32lMst17E2mifRKfxzENTrSUINntx99XDY0KrrkdsNvDuTO9ejuH7RtAsXernX6iSLGTQnEcJjdp
	wKy2APKg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkdad-004SE0-2T;
	Fri, 17 Jul 2026 08:06:36 +0000
Date: Fri, 17 Jul 2026 01:06:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org, 
	zdi-disclosures@trendmicro.com
Subject: Re: [PATCH v2 ipsec] xfrm: espintcp: fix UAF during close
Message-ID: <alnidhftTfUNqnlS@gmail.com>
References: <a62857f72af228a0781a5c0cc0f8d898d9e0d7be.1784234935.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a62857f72af228a0781a5c0cc0f8d898d9e0d7be.1784234935.git.sd@queasysnail.net>
X-Debian-User: leitao

On Thu, Jul 16, 2026 at 10:54:59PM +0200, Sabrina Dubroca wrote:
> ZDI reported and analyzed a race condition during close for espintcp
> sockets:
> 
>     espintcp_close() frees emsg->skb via kfree_skb() without holding
>     any socket lock. Concurrently, the xfrm_trans_reinject work queue
>     invokes esp_output_tcp_finish() -> espintcp_push_skb() ->
>     espintcp_push_msgs() -> skb_send_sock_locked(), which reads the
>     same skb as a data source.
> 
> Fix this by adding a synchronize_rcu() call after resetting sk_prot,
> since esp_output_tcp_finish() runs under RCU and won't use a socket
> with sk_prot == &tcp_prot.  Simply taking the socket lock in
> espintcp_close() could lead to leaks, if esp_output_tcp_finish()
> re-adds an skb in the slot we just freed. After this, the existing
> barrier() is no longer needed.
> 
> Cc: stable@vger.kernel.org
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Reported-by: zdi-disclosures@trendmicro.com
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Breno Leitao <leitao@debian.org>
