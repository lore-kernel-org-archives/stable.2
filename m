Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.245.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489668;
	b=RV9GGx7E50ZfOr9NC5Lv+kzy64sD6alZhs+nTceauuoCAKC8RIQ+W3+m8BNv63yQ05Aq
	 0I3OR//ESi78/RUN71JMfc3SIrbePcwlvnYACR0ACuP4Amw8YDvXJbLfSEnCXejBAxCmP
	 LC7875ffjk7RTLwxqDinZ/7rApS7OSOwni5jvsYVlZhubrsSCGdxbmW6VhS0F9+kaR8Sm
	 iX/bGYz8R5jN4gWTlcEiHH39XhBhFWgiHl0YAuaPcbbTCsbZavk1t1sw2rvLxiMr6jj5M
	 w1hgr6MzNvJa2Jio5nwK2ZmGtKdbwrdqy3GU8vKoeQn0E3XADDuT72Fvru5sONuye5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489668;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=R3hdk29zJfSKaQC7f5o/MlPMpOfwLVhFpVG8+0Hp5xU=;
	b=nI+xg+akdreo2mQGEvMFTSFMM0sfG6877s64fiw+nserxHU0QyoobN+kp5AFrAoegHz5
	 HCX6CjFV1wE/dg7GLNEJ3y2IMubkXMon41SljpH17S3kRxxC9A8RDjm6gwIHfQpqNILxq
	 t2UfYkZd9Z/+K83JU0Iq28gpIzuTLWUMSRCYUV6Sq1frNkdwhSD5HthXbNRyi1fv3NZs3
	 Q8TX+FnkWztjHfSEGa+4tFvSXiZTKIMcYama3tdIJJk3LnvuPYJF2DkEG0TGuKeJGkC2m
	 Mqe1WwiM7SsThi3poz6OUTPCRTM2CMbbwH/frob9KIUfL1JizAIMP0TKbubX7TIwKyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=strlen.de;
	spf=pass smtp.mailfrom=strlen.de;
	arc=none smtp.remote-ip=91.216.245.30
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597F606A330;
	Thu, 12 Nov 2026 13:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A597F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1D025602AB; Thu, 12 Nov 2026 14:21:05 +0100 (CET)
Date: Thu, 12 Nov 2026 14:20:58 +0100
From: Florian Westphal <fw@strlen.de>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] xfrm: fix selector matching for IPv6 atomic
 fragments
Message-ID: <avW9OrfvkAF99uP_@strlen.de>
References: <20261109213803.1785516-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261109213803.1785516-6-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109213803.1785516-6-Jeremy.Jean@oss.cyber.gouv.fr>

Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
> +		if ((flkeys.control.flags & FLOW_DIS_IS_FRAGMENT) &&
> +		    ipv6_find_hdr(skb, &offset, -1, NULL, &fh_flags) >= 0 &&
> +		    (fh_flags & IP6_FH_F_FRAG) &&
> +		    !(fh_flags & IP6_FH_F_NON_ATOMIC)) {

Since you need to send a new version anyway, maybe avoid
double-neg, i.e.: (fh_flags & IP6_FH_F_ATOMIC) ?
