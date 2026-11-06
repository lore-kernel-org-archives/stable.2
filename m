Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988192;
	b=KQudUdOnYVY5JNkUCpG0EK7OzodFSAPbDWzCGlg+5ANlcVM43pGBnHqcN8n3+lgKRKR7
	 cQZjj1P3CGDzDCEPKALX1HpPefTeyekhy4cCyB9ZEa/YT00BDggXUA0HJJ99PiWXQ6IoG
	 /R/o0Rq+8TBoX9MiBVZHJbOTNp/8+2BzBATzQNftR09+Zy6GLLlF+7Rwx7cYAccSEAfy+
	 vQgKnoJFy0PWGvYqx1Ye7uo6MiJFEfcIkTKPfY1g0hAlNri3SppFlgWQnyl0LlrrhsfiE
	 jYQce3QXrSFmxuvcuzRqCIRC9e9HxfC9i9ejO0jEHF/cHQDjVlLSO3LbXEmJiaLOaBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988192;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fMvbHjbrounMEsK+KmbC2zRyu4VI/xkNIv3ppg5CuXo=;
	b=qsgTarAXGHW2HaFLkZMKriq/ozKQw8z87+g/ebcAUdbUMDS92VdUiT8rsIJ5/kznB46E
	 vr+gE7fDFjA7a75+KGXK9PfhQFZAM3IIUgeMcwCjHKJWgZHyUoDhXH1u7eV21NCBfiy8o
	 eJdeOr9gK4WkwRC6fvqnMHnM/b/VCZF9uVBpP6hvH6isZRW28OSt8dW+FAaXY7JTAW5JS
	 79yUmRnggoq4SLUZsvAuzf0eKkcDz6zFNyKqwD9mKacb0VZRWucRy/HhHDlRAOz74wNn5
	 mH3AXIt6eAJxCOE2alO4DA/1fYA2i7lU3Uczvam5SOYIh6EKRg3L17wQ9yMN3c+KjSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiKo5cHp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8A606A326;
	Fri,  6 Nov 2026 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiKo5cHp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B221F0089F;
	Fri,  6 Nov 2026 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793988191;
	bh=fMvbHjbrounMEsK+KmbC2zRyu4VI/xkNIv3ppg5CuXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XiKo5cHpbKZRStKZLZ5RDNPvlZ1KS+/a0PFXfAy657J8U/ouykOZ1vPm99/l6QZG+
	 ouMl40K/lth5kyNbqL2HzwbBBIKNhrKZxxB2CdrDoW19kBLo0P7sLAaGFD1jpPeRXB
	 YNJQ4cqUusHfN3xyMC8jHAk43RXIvoicDGKkZ2wDNGYkwkImA+PEAeWNyDKDP21tsp
	 sgMVi+PqaepvrDCtw/96PH+ImdvjQNw4vcZ+HMlpr2fpZNpcsL3cMvJikhjUjI+ho3
	 iMI2EivXzGg24NJR5lEtmhtiy9lSt4nVDQxXF9iGhEjuvSl2TJh0GEvZoreTUGXun+
	 ZN320n9FQ57zw==
Date: Fri, 6 Nov 2026 18:03:07 +0000
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: hns3: destroy the page pool if RX buffer allocation
 fails
Message-ID: <20261106180307.GM865646@horms.kernel.org>
References: <20261103100533.1310018-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100533.1310018-1-vulab@iscas.ac.cn>

On Tue, Nov 03, 2026 at 10:05:33AM +0000, Wentao Liang wrote:
> hns3_alloc_ring_memory() creates the page pool and then fills the RX
> ring with buffers from it. If filling the ring fails, the error path
> only frees the descriptors and the descriptor callbacks, so the page
> pool created a moment earlier is leaked.
> 
> The page pool is normally destroyed by hns3_fini_ring(), but
> hns3_init_all_ring() only cleans up the rings that were set up before
> the failing one, so the pool of the failing ring is never released.
> 
> Destroy the page pool on the buffer allocation failure path too.
> 
> Fixes: 93188e9642c3 ("net: hns3: support skb's frag page recycling based on page pool")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 47788be64be6..fe339ddc6379 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -5073,6 +5073,10 @@ static int hns3_alloc_ring_memory(struct hns3_enet_ring *ring)
>  
>  out_with_desc:
>  	hns3_free_desc(ring);
> +	if (ring->page_pool) {
> +		page_pool_destroy(ring->page_pool);
> +		ring->page_pool = NULL;
> +	}

The condition is not necessary as as page_pool_destroy is a no-op when
passed NULL. Please remove it to simplify the code-flow.

>  out_with_desc_cb:
>  	devm_kfree(ring_to_dev(ring), ring->desc_cb);
>  	ring->desc_cb = NULL;
> -- 
> 2.34.1

You will also need to answer the questions about providence posed by the
bot. Ideally in the patch description if you post a v2.

-- 
pw-bot: changes-requested
