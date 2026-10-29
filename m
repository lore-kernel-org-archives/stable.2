Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268592;
	b=qaKoxIle8jk3eez4qPqnMFGRy91cGPv8MnA/K1krwZZGikzEfb7FVbogOsD9/ZVDBPip
	 mRBZMNCgsyBmiBKmHUTacbCu+Cp3uk+hX9PRS3hVe1JrDz1ypFjduukVSb+kAJanyVUgf
	 lRSgODI2nJcRkxaMrl7lScM7T0nwvyctz4CdTrRqf3nxq7v6zLaDAcPnWgaEm4Fl9Rf/b
	 KpGof147ct1hYBKmGdMR1Z6PHYqdmMD3tnuHYpisxThnftY2bvOsClOKjxwIjbSc04L8X
	 ZC0YBc/nGQrhyB/wE49gNMhPzukueBQsjrfSXgx8E6xXS267SnIKMWF1s+1VTQKrgBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268592;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nxNqgHP3UUpuLSiMHFFX/1xCgm70UtF7AKQcrmX1fpY=;
	b=fYQJOV33VX3ex4gWJVhyzr3p+DWOAPou8KatYCIMZvTm8nlTUnPMvfBFKPb7htcVal+I
	 /w+kuQiVgEb2jnC9TrWAXX8a7PuqGOz+RTye9CC21WNrk5KBW8DbfDUMxml0CPje1Y8+p
	 jaP35RPnab5FJGMunaLkbXs73K1N3dno/Bmsl8T/uvj32CIflKYx5p0954eyPsYlVx3Bk
	 yxQzdcWOfHts3HNDLmttQknAl2Ehs0SirORozNb1EILR0NB+K1Mm8yHo+rBTGOump9kch
	 etJ6llEu3hk/onsP0su9rrlyRdrV51995Qvb9h3KnvESEg0Up7VoprfObtgeMDQ8KCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYL6nkR2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145B606A31D;
	Thu, 29 Oct 2026 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYL6nkR2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9FE1F01825;
	Thu, 29 Oct 2026 10:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793268591;
	bh=nxNqgHP3UUpuLSiMHFFX/1xCgm70UtF7AKQcrmX1fpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iYL6nkR2kGVEIZgKxnVxk5ATyNVQ/EsyrGT/YLsuiPCj7ieJ1g6uwzlIw9w6h0MtQ
	 AA9uYCTe55u5TNH0BxeybB+g65eDECrfucb0yJPxrCk47aBvU8lg/J7ZVtmVonG5MT
	 U8nQrXMxKhHKkYOYc30igEtNrBd/A2jeaDt4BWMPs7jkeFVSw1RHESPzlPpZZQYzJa
	 h9bl49LXKAmWEPMp54/0qG93a8AYxSXvG3Al7oRW85NUwqo2SBsvhfL1OWdheHt95Q
	 L5GQWys/h1iSPHd9BxZXkHgc4S7KvXUkaBzC05lcpI27nk7/zJ6Ty4OxTlAUnJESav
	 ia2qGR0SZ3GLA==
Date: Thu, 29 Oct 2026 10:09:47 +0000
From: Simon Horman <horms@kernel.org>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
	David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject: Re: [PATCH net 1/1] nfc: llcp: fix use-after-free when purging local
Message-ID: <20261029100947.GE257209@horms.kernel.org>
References: <cover.1791171477.git.xuyuqiabc@gmail.com>
 <1792999447.107874-1-xuyuqiabc@gmail.com>
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
In-Reply-To: <1792999447.107874-1-xuyuqiabc@gmail.com>

On Mon, Oct 26, 2026 at 03:24:07PM +0800, Yuqi Xu wrote:
> nfc_llcp_socket_purge() walks local->tx_queue with
> skb_queue_walk_safe() and unlinks matching skbs. The walk does not
> hold local->tx_queue.lock. tx_work, the LLCP send path, and other
> purge or dequeue sites mutate that queue under the lock, so the
> walker can follow an skb that another CPU has already freed. That
> is a use-after-free and can corrupt the list.
> 
> Hold the queue lock across the walk, unlink with __skb_unlink(), and
> free the detached skbs only after the lock is dropped.
> 
> Fixes: f31652a58bee ("NFC: Purge LLCP socket Tx queues when being disconnected")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <weir@nebusec.ai>

Reviewed-by: Simon Horman <horms@kernel.org>

