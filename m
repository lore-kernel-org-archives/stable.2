Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493921;
	b=wLBI0724XCIWXU4EHtieGvMQjoPYwH7HCN1orY//eIap/hZdWmxdrl30/OaCJ28lyi4q
	 8QQ4pk8VLkbE+xWCHDgWbt4sNmT1W9G75DmEROSB3El0JhkOylLRwC6ZjAGjufOVqwYnl
	 +wM3jSJDKU4V7eeWBYmTwZWwygYUzHNLqkKLK3af2xi7/aPtcfgpu9WFSzH22/irRar1S
	 G6RhEEJr0lbI1LZzfqmz73Qc0V0/x0ow2afuaUVEgHKCIoO/XMtP1cy4Ww1WlG89hHH+m
	 A9JYIliIzjXQEQ6BcnCUzvYfmLJ3Tm0GJsl/1cQ9X7JiEa2cU0Q7Ac3P9UX8+Hh6W4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493921;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1jFt5YFldzGGLz0MFAETG7hojRbmHr0n1t9QhabZ5Bs=;
	b=ulfPXRz1vOuJDiNcDIoRLgdFEtEPj1bp9+szzFC5cQAp/X6ca/+kCpmL5OVffjs2RbqK
	 D+lB7cWQSZikFneR5rYTy39MWDr2w/NX8ztsvgmhWPD3NMdvgaAt+x/zOUKbSSGzJFWV0
	 bnLM3X7wiaQ0v+aBbVw4PmdlnPlAzwpQtHg6VrVslTo4gkJa14RLLQ0AGoi1dKKFuuaZ/
	 lUyncJCHOqzm1lcanTOZtcEBLHsd9/biGW+Izz4tch4r17m3eXjHNdY14nfBEgd58u4Qs
	 DTNVeZpOyz0yi6e1UwA82DS0/J0zXgi7j3eDQYM/9Xx+mfBEWkrDk4HWrDCUkaBD4AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=queasysnail.net;
	spf=pass smtp.mailfrom=queasysnail.net;
	dkim=pass header.d=queasysnail.net header.i=@queasysnail.net header.a=rsa-sha256 header.s=fm3 header.b=QHcDcOVG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E98saQ7+;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AAE606A339
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4AAE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=queasysnail.net header.i=@queasysnail.net header.a=rsa-sha256 header.s=fm3 header.b=QHcDcOVG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E98saQ7+
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F4DCEC0170
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:58:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 20 Oct 2026 06:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1792493907; x=
	1792580307; bh=1jFt5YFldzGGLz0MFAETG7hojRbmHr0n1t9QhabZ5Bs=; b=Q
	HcDcOVGmaz6vX+UIYmgkLsrzVMPSNy29esctGtRl3AKaDDuO2jWaN4nnjLwD9ay5
	DfB/4MxiX3xFvmlG+D254eyO99egOP+cfTKFWg/5ULUWQuuX+HeHZrSdLPoJycQM
	eFXrJlm6cPD+iOCyAii+AA9/353pbq/Pch1JqDCrj7jNfFJePnnCozCpEm8r77PE
	q8mG/DRxJyFnLq6Lgtxq4jsVul1yVVAxk0Qe5FDYKt3c7F1hTt+vngxlBNDTKQtZ
	zGYHJCb6vExqwzkl2OiFj9LIFFg4m2Ra0w3TUZ7xvrpH/92M2ErI2VxCLr1I/pIO
	MnxXo8YbXOrtu4c59TTqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792493907; x=1792580307; bh=1jFt5YFldzGGLz0MFAETG7hojRbmHr0n1t9
	QhabZ5Bs=; b=E98saQ7+fZAH8jJlZl9BcYICKjf8kdPdj5jUeUx7fyXEVuYuh8G
	fhZUl2EGRFRp/CDiD0T45axIiuQzsqvdspkG6opC9F6Lu/LNERX7y/vYQ/H9ITxs
	wwnr6bI/Sd8iLtpDVy1SFyLMFVzcrCo1g/zVQa16juskBs9zquVPD6urjAB/gCKV
	T9914tdsX+2F9rEdA0dXtWf2VF1KQTx6IycAbCfBQKwlBoBHBedeAhw9AyeMWUh9
	Mer2pLTbxoI7cRa1CgoR0y1xOnf23sllzwEQtNFesx7qzxMiVtOUOmb/l6xhuYEX
	Lk/UAszSiV6OUv30FqQpytcbbcb5FaOoyIA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=queasysnail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792493907; d=queasysnail.net;
	mf=PHNkQHF1ZWFzeXNuYWlsLm5ldD4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:UTBQWByvVsioA5lIj3Wo0JcJzEICDlvecRzqEYhiAw+xhpl
	n8su276T+ICFkKTv0wzy5ZhJKeR0mFOpvbRmKEbr6j+zdygKnX3E6uh8s7ATJOtT
	OdgT1BdufGbmENJWRO+/fy5NLCSsO2ppjNAS3nFeFonUz5qfNi+pg3todYgCbJlI
	tFLSasEkN8cdVtOYOtYDdKNIa/zr5olRgASNVNy8GEyCmxIQM7R2azQwyGU5rBNc
	zf/gjr9DmoBONy/RCzO5CGYgVslFPHdmjJtIIJ/YI1Ge/r30hQlrzJ4EjHHOljBO
	6tbiPuS+XrT5MdnT2Si7OhSAe0Ka2cyNBlUDnGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tANeBEaU9fAbLL8ASsdV+u1DOi7myWZzyDgqpLt22vI=:XWTAZfIddkwVPW+CPsWGSvyj4ac/JppaA8LmC6xSMFY=;
X-ME-Sender: <xms:U0nXapRWPRUSDpDbowHlGwai-6V0MMIPraotzcSy9aeKpMyy4Riwjg>
    <xme:U0nXaq6mVXpJf6-Ke_Aze0jMDT8T07XGviSTZjUYxGKRP1pt95_ngVrOedhtPXaaq
    uvJZwY-GTX_CD-x8YQ9VGfTWro5Xb-qnBopvXrOZCZ7FsrCugT9_sI0>
X-ME-Received: <xmr:U0nXauVZOWDP6mF_50OfI2GjrkxX0KLR8A2hcaNWtGYP6bCrggA2mueHDM8>
X-ME-Proxy-Cause: dmFkZTFXEQN/Xxf/lgfRpKYRYGZEymmhlBHtyrIXr2Z1miJzA+kYdEmNb1kRpKSNZTtE/C
    BQSg16Jh9mnkyfKJ4EBCN3d827zkOejqoLctJnrTGE9/xtf+CrJdPpjktqHbho7FZXcQIj
    fmpuiwCaJQYh9Yt8YLA2tTsW1WO5raYx8WlxiVlUTqCqQtohLa4hvBP7odHQJJWcUPAGyj
    CLOPP/PZbxehPqu9NHQQ/T1fAI67GvTZhjCZRMzSjkHPpJ1jVbFN4VHFK5SFq+uw22nIEg
    SwCfl34WmjPwwlHTR3aXhGT40Jrz7J+Mdrr7zwD7dJwbBjiSiNJggDpKTYKdwVcjP7ugWP
    3H0HP/dYMfp5E76ATFY9r6seTZOmSCIujcgqvJmJKTAgkmA470shzNtlJi/RwnwQxLFpPl
    3OH3/EKqvyBMJ8W6t/2kHaeq/C18Jj220746Tki/1DqTDRieyubVVsoR8uMTena6huD7CR
    V1HwvjrhObXM8iXTVEQH4z+SfH2tUJD31JVJAtllyS9itLkqC+MfcV9XMHjPJgMa8sdY8b
    FRxt3gg283JMxOnn9a+kWO8KEbqhsq9pInsyUJtvQgh0c7MoSh3LQprqpgYle/WYhmpUvX
    ZFNXv2R9MQZU03Hnd2VV+N3vjQK/v1u/TaM4X4Xjk0gXenh/pX0cMG8nluuA
X-ME-Proxy: <xmx:U0nXag-DtUZIhPGhuYHnh_5fuK08SljIqQVPIIm9qs8lPeu4ShAT9w>
    <xmx:U0nXaupozH_5fdrs_UV8GvFBGihwM3htrzlM_HohHnBQaHtAPJvhrg>
    <xmx:U0nXajKHcBnQn6FOCIVnaSZ3QEh0hc2jfwhIx17mOozdzIn41uHyHg>
    <xmx:U0nXahOHYoWbNlvRpS4p0cd5U86RY8-NgkK3GtGa1UReFaBho9rlOQ>
    <xmx:U0nXah2RlhgqG3oDML7_Sm2UFU69iDtaXEolobHIssChVeozJUmTE16c>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 06:58:26 -0400 (EDT)
Date: Tue, 20 Oct 2026 12:58:24 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, john.fastabend@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, wilfred.mallawa@wdc.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] tls: check the right open record in
 TLS_TX_MAX_PAYLOAD_LEN
Message-ID: <atdJUP6Jb0jODBYE@krikkit>
References: <20261019222626.745408-1-rjethwani@purestorage.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019222626.745408-1-rjethwani@purestorage.com>

2026-10-19, 16:26:25 -0600, Rishikesh Jethwani wrote:
> do_tls_setsockopt_tx_payload_len() refuses to change the record size
> limit while a record is open, because both TX paths size the record they
> are filling against tx_max_payload_len. It looks for the open record
> through tls_sw_ctx_tx(), a plain cast of priv_ctx_tx to
> struct tls_sw_context_tx.

There was already a patch for this
https://lore.kernel.org/all/20260901072927.128688-1-jiayuan.chen@linux.dev/
with extra locking to address sashiko comments.

Jiayuan, were you going to send a v3 to address Paolo's comment? Or
maybe resend your v2, since it got marked as "changes requested" in
patchwork?

-- 
Sabrina
