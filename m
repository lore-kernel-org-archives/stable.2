Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793464147;
	b=zEO4+F1ebakgoO8StymGeLJT8HmIis2V/WzWvVmPx5NFm9jGeyy9NeO6ri/8Wv2U4+hR
	 prrVNGCeOXCrqMw58a2c8hoYBj57v1Z4aQrglVbYgFnGZqHWg6gFRFMqmG59i/2Y01hdO
	 dW5kpp5iZcrUI+Fi25kkYJsKTlyTM87k848T8byw9Rc8XsH6NwItyGB1H2fVpYZ3MpBha
	 95d1/7kOJbUZ7phKVCMaQBKl151T2B9wf7RW73dMn4Ln6x+WSYxOVvXgLSFI1htrjCqhI
	 9CyqOznR4HQnjrZ76uhoXkpQ0JwO4CFbqX3SLhGzCPWnSMSkZ+VAXuuBJTuPctIQxBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793464147;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=oBQyf3LnZsTBEP9KDYlRdvFMh74zWPl/J2LK0/JvVx4=;
	b=jmcBU3uRn8jZq+xeCMpD57x/LUHIdK8Z81Tm+S+wwm0ZvCSE9IC12vpX2fVCB6OeuhgE
	 0XYIkEIJSt/apWkmgqL94IbyDng+iILoxCUYBUhNTTKgeuA8JNO83fivfPCs1bKRnsNx0
	 fuZQKSNjzWvD+tJ92C2cdbVFASDlR7OkbhEk6sUTlvEuDjh6qJCOovSTkxM+UoodbWG6v
	 eOs8bgds89+4MeHDL2Hb84qLonJAvnGfdhbAZv5ASC3gcWxA0QonDCIlewfMDnZwiLQO5
	 Q4xfgH4KsKXJX9OLYLpv3QNFudBsYg6kmaKADn8xE8HP5sWvBI2bH+KwDrKqv2/4Ueg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCWGkDPH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F1606A31A;
	Sat, 31 Oct 2026 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCWGkDPH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01971F000C1;
	Sat, 31 Oct 2026 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793464146;
	bh=oBQyf3LnZsTBEP9KDYlRdvFMh74zWPl/J2LK0/JvVx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VCWGkDPHHBokzqBmrPfqJHBQKb1NtIuK+WlYZeUn1oA9VArN1IXm4floJ0MVoK9Pq
	 jOux7Bxy4+hPEt2L0qqDNYn6ZbymwG9V9M+Y89BFlvq8b9VaoWu3a0GdjNnauoNAR+
	 OlMFYsK5FEgOmoZKtBoW9kx/lz2YRyzEOi/788X9+VIb0ys0yYGqYNYC5Ux++Uf0cp
	 Lh8Ca2hkZkLdt43geKPe8y+AQLd7EPh+Dn3SFl1aN1DkBir3VMFQEJFVyR1UjZ89NP
	 Dak7ctA1P6bqhzkdZeyGhSqyvHbyKcV7dBctRqCT4uot911BGrWaB5im2/DC5MYiv8
	 u0Ye31woJ9S6w==
From: William Breathitt Gray <wbg@kernel.org>
To: Li Youhong <dayou5941@163.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	biju.das.jz@bp.renesas.com,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cosmin-gabriel.tanislav.xa@renesas.com,
	Li Youhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] counter: rz-mtu3-cnt: put runtime PM ref if counter init fails
Date: Sat, 31 Oct 2026 12:28:49 -0400
Message-ID: <20261031162853.3635249-1-wbg@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031142813.2522444-1-dayou5941@163.com>
References: <20261031142813.2522444-1-dayou5941@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=wbg@kernel.org; h=from:subject; bh=ojrAAUCAhsERcK/RsagjgBNQlTeYOB/egHHvD3QPR3Y=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFnPxCXe3LvNvSdZ+k7vl07pbRZ3nWRup66Ps36mUhn65 psxy9LujlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiPS8YGQ44WW75lZnkbbxz jnfs5QSxkmlpuTsXzZvyyjysL+nFUQWGf/ZHn+sdLu+NLdP6Lh6v/aT8354Jn4+Z/quYz+PfsPF 2Lj8A
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sat, Oct 31, 2026 at 10:28:13PM +0800, Li Youhong wrote:
> From: Li Youhong <liyouhong@kylinos.cn>
> 
> Counter enable takes a runtime PM reference before initialization but
> only puts it on disable. Drop the reference if initialization fails.
> 
> Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
> v2:
> - Add Cc: stable@vger.kernel.org.
> - v1: https://lore.kernel.org/all/20261008020506.211566-1-dayou5941@163.com/
> 
>  drivers/counter/rz-mtu3-cnt.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
> index 7bfb6979193c..61fbeb122851 100644
> --- a/drivers/counter/rz-mtu3-cnt.c
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -506,8 +506,11 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
>  	if (enable) {
>  		pm_runtime_get_sync(counter->parent);
>  		ret = rz_mtu3_initialize_counter(counter, count->id);
> -		if (ret == 0)
> -			priv->count_is_enabled[count->id] = true;
> +		if (ret < 0) {
> +			pm_runtime_put(counter->parent);
> +			goto exit;
> +		}
> +		priv->count_is_enabled[count->id] = true;
>  	} else {
>  		rz_mtu3_terminate_counter(counter, count->id);
>  		priv->count_is_enabled[count->id] = false;
> --
> 2.25.1
> 

This patch seems similar to another we're considering for ti-eqep.[^1]
In that patch, runtime PM is managed via devm which allows us to remove
the explicit PM unwind on failures and have them implicitly handled when
the device resource is released. Should we use the same approach for
rz-mtu-cnt?

William Breathitt Gray

[^1]: https://lore.kernel.org/all/20260529095834.2561-1-sozdayvek@gmail.com/
