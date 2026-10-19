Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444056;
	b=mvAGljrthZp31UjqEp9oUN7YLG+AeTNOqJkGTsch6kee1wxu+nsZfEtnEFQ6qSrWm3QG
	 yk46YBeF0aschT95eJmFn8L8WjEsYquSMRRxEwuRCNnS2PVaZ9hV1DjNaoopG+PbPkb1M
	 hiyprtc6YHDBuNz96OaK5gawzlZdhaj3iDBqSCSJxkfOfQQ083nxUjYSjX8odOjFjPTB2
	 RHAEA22ewvNAVblbhlsCgcCbPFPzioSXGEcz0TAFJEA6wetYbMJXRnxIE6LexsptboPkI
	 6yq8NdHk4a4jgozlA/1Wc1wc3Y4oSjzzIgYu2IrLRDjmFawElFpEbs7+GWo/PC2azrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444056;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3QZ9iUX9FEvs9UzUvz0pc3gaCcyQW6FB1eNnhaIOnkw=;
	b=jZ84j9U3xHmzknHpMi+uSmVQKbjMEsSvrq4kE59QbfAkhrXlP5ZHFAB6sDK3gn23JyDD
	 3OqZVBu4OwZXny/CGRgwJG2eAo8Jp/GLo5BUfQ306nslqMg25Py/omfL2Hx7ZwPGOKsXm
	 /l98+gvm7BmCKj2rhkVk472+QtQ7Gf7nYD4gLPx24FWsTXITA2Uhg62o184SUwwMQWjMr
	 2qNDyQ6WXfllTSxlSnHGpuogMPRpXR7bGE75s1PaidAa1+E5f+yueRoDy7mBnifoa2ASY
	 2B9zrivcYcYIeE1HaDtIv8W6M+rPS1n4jVMCRpuPw4BzvwGdJ2iaXExg6souwAUWCQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHQnRUUd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A02DD606A319;
	Mon, 19 Oct 2026 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHQnRUUd
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B344F1F000C4;
	Mon, 19 Oct 2026 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444056;
	bh=3QZ9iUX9FEvs9UzUvz0pc3gaCcyQW6FB1eNnhaIOnkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eHQnRUUduaYG2sO66ojBQpwD9Ynyfi2F2xq1bWeltzJ2r4P1gfWY6HiUWQKzz8TAP
	 hQBZyEwUkhJ69k9XiNW0sntIhtjUdhCM1yDnlAaDgT23pCUHK0vUV+EnCNM+8Pl5ZH
	 aODU1OosOpTEGt5IjoppCc4/kgxjsVCCvNK6a8cTq6IImpAljJcG2Hq6bWx0nuPVAh
	 ymRGX6WH2KU4EHeUPizKK/TgeLUJIfIxlomoA4+WJFFt4WjR11wbSzawSY0YOnMX82
	 v736VqlkOHBUS9WVU5lVW3e13kseo9WEKXv/T85BsyFZ8RO2vQGgTmlf9BJT0OgYCr
	 Yw0c8MyuA8aeg==
Date: Tue, 20 Oct 2026 00:07:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] KEYS: Reject @datalen values over INT_MAX
Message-ID: <ataGlDBhDaHsLT_q@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-6-jarkko@kernel.org>
 <20261019193148.GE65095@quark>
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
In-Reply-To: <20261019193148.GE65095@quark>

On Mon, Oct 19, 2026 at 12:31:48PM -0700, Eric Biggers wrote:
> On Mon, Oct 19, 2026 at 09:17:25PM +0300, Jarkko Sakkinen wrote:
> > Protect quota from overflowing by rejecting @datalen values that
> > surpass over INT_MAX.
> 
> Is there an example of how this can happen, and why the limit needs to
> still be so large?  add_key() for example limits the payload length to
> 1 MiB.

I did a bit scavenging, and to my knowleddge, no. So I would retain
this as safety measure but would not consider it as a bug fix.

> 
> - Eric

Br, Jarkko
