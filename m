Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130456;
	b=lF7Z7RW7Q+WnKE/jJNXJIZ/gRBVo+fMdvt1b+3BnRtD6cDAWAISzPoDzXj/TA7pfqHO0
	 w4g0M0fsRhBKfQHY6MjJ+8BK4XscNI7WChWFVhWA3IjVueq6+I53JNstQOSkCXNhOPLYU
	 uUcMTr1EPYjCHdDqApYW5h0LBDCIGRF49myxJzLsRTI+SNUeBeZImYt6lL7gbYqUi9E4A
	 aQnD0YHe9Qc2r05JDl2SK8vY8mGQAnpMSnhNokt9IreWd8XpapklC3eyBjuJX/v16NEWg
	 e5UJoHe9X7+OOg5nBQpmdnSxp3cGhledk319N0lgyNqOTNL0nY2qd2xVnU+hWSuo7kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130456;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xr5y2HrJ4TdM8R0sbSoyLZirPhsEM1UUu96wLJAFCyk=;
	b=Amt6pXGPPrdOh9FQoNLh9XK6Z24NZSzXhThk/ix7khrrIozJ1b+s28T6i1MT5BqujinC
	 PkbwrVxXjTyBsd2Ve0dRUGFtowZpXJAMb+J6E2HCwc+2/HrdAjI/blwUF+xJLadOERi+4
	 q399offAevr8pNE84KHOWKm1sX28MijN4tw5nyJppbdDhpYl1ZvgQe0srUG5Gnt/h0A4w
	 vKV6YaNYlaxv+FgZ7GN3YjpeZG1va0V2POCBuDwSiPMi7ciyHa5qPqLM8wbUkvnh4tOle
	 qbTk0Y5srsCJAlgDNo+Ax+cRUaQSsQaEFxt+/0Ods+0bdHt6JdTVKXVwb96gcheMHMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FQdS/ZB/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF3606A325;
	Thu, 19 Nov 2026 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQdS/ZB/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FBB1F000CF;
	Thu, 19 Nov 2026 23:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795130456;
	bh=xr5y2HrJ4TdM8R0sbSoyLZirPhsEM1UUu96wLJAFCyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FQdS/ZB/n3kVaRc6Uoq4w46I7PdeouA3kgT2u5+IFKhtr4bDGVNcmysKTZBhTspiv
	 z9Il2siQEAgIWIbXC5nh72w//2LH6/OUXhCZW3BHCUaBzdiBzi34pG3K1k7Ym8zVK8
	 cfdz066DcVMMSe5ge5J0Ua5pyNvo+OocbabTfBwGQa72KL+qFJ92ngYVuMu6ecH0uG
	 Mo6npIvXn1W/nuWhpcxywfqIO4SKtCwxy75n0GZU7x5MvWang3Sc98kl6ax6jsay/1
	 cetTpRZjU+9fVZg2Uvife+M3JxFMWiEP+pSqTxbGLfHKBNnhEDjwuo/98+CWCuct6w
	 LgN1Kf0YTp7Qg==
Date: Thu, 19 Nov 2026 15:20:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bryon Fryer <bryon@fryer.io>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 horms@kernel.org, jasowangio@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org,
 stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net 1/2] udp: restore outer transport header after
 tunnel GRO
Message-ID: <20261119152055.415dc942@kernel.org>
In-Reply-To: <20261112030708.1915665-2-bryon@fryer.io>
References: <20261112030708.1915665-1-bryon@fryer.io>
	<20261112030708.1915665-2-bryon@fryer.io>
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

On Wed, 11 Nov 2026 22:07:07 -0500 Bryon Fryer wrote:
> @@ -948,6 +948,8 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
>  		skb->encapsulation = 1;
>  		err = udp_sk(sk)->gro_complete(sk, skb,
>  				nhoff + sizeof(struct udphdr));
> +		if (!err)
> +			skb_set_transport_header(skb, nhoff);

IIUC only UDP bothers us because that's what virtio/tun supports but
isn't the header stale for every tunnel (eg GRE?) Should we not reset
this back in inet_gro_complete()/ipv6_gro_complete() ?

Maybe GRO experts prefer it here, dunno. An ACK from someone who
understands this code better than me would be good.
