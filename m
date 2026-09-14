Received: from mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464BD1A9F8C
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354834; cv=none; b=QIinUhKyRCOKyvNc4qpYyqFGUo3gsL+LDHWLaI4eY7qsBtcjdWQUwdjJZFL1CTc4uQBqmfpzP7e4NtsxNd1dziIrSRUBVwWEjnImONL76ewkQk3Nb8kT3+mjkLRXJCfjdsguHFcEOcHWaB3qF9c/NG/Fvb85hrLcSGtWTupRE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354834; c=relaxed/simple;
	bh=38utzkszNAIbnFH8LOYtxKvWmuM2m8bbkylT9qzwrcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghQuYp2cqV3G8G8k+uh1QqqWRC/TOnqLtnw+CDZ+/1iZyFhfUii6MjdeZeohOQBx8Ry/Il3XXJoFeVv93nHuSrlVZiBp/J4qHfkolGxX48X30pZFcax3t3Tv63D2DyV4UFM5lPGdHVrQGv3ZLG8IqBfcvMt0N3aum1T/1qxTGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EzYO7CAN; arc=none smtp.client-ip=91.218.175.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EzYO7CAN"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=38utzkszNAIbnFH8LOYtxKvWmuM2m8bbkylT9qzwrcA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789354830; v=1; x=1789959630;
 b=EzYO7CANUBUUn6xZSahP37q7gZNQICRx5OkyPBCBNY3kwHK/Z093dtD8cNZOw1ls2xShyWge
 UE32N9OjdBUmuaWuIRn5DPTvmXq1nkstmXssycT6fRGvfOBsDbUXA2+kHp1zzwpjSyvazlJx36D
 LKXb2sh89AQtFV3DM2DUzQUY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d8104f31d56843eb;
	Mon, 14 Sep 2026 03:00:30 +0000
X-Mizu-Trace-ID: d8104f31d56843eb
X-Migadu-Flow: FLOW_OUT
Date: Mon, 14 Sep 2026 11:00:27 +0800
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: Mark Amirkan <markdamirkan@gmail.com>
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: lan743x: fix RX checksum use-after-free
Message-ID: <20260914030027.GA92852@pc>
References: <20260913-b4-send-lan743x-uaf-v1-1-73d563d08ba9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913-b4-send-lan743x-uaf-v1-1-73d563d08ba9@gmail.com>

On Sun, Sep 13, 2026 at 05:14:09PM -0700, Mark Amirkan wrote:
> lan743x_rx_process_buffer() adds each non-first receive buffer to the
> head skb's frag_list.  On the last descriptor, lan743x_rx_trim_skb()
> linearizes the head and frees the fragment skb metadata.
> 
> The checksum-success path then writes ip_summed through the local skb
> pointer, which still points to the final fragment.  This causes a
> use-after-free write when a packet spans more than one receive buffer.
> 
> Set ip_summed on the surviving head skb instead.  Multi-buffer receive
> can occur after a live MTU increase because existing ring entries keep
> their old buffer size until they are replenished.
> 
> A KUnit test invoking lan743x_rx_process_buffer() with a two-buffer
> packet produced a one-byte KASAN use-after-free write before this change.
> The same test passed after the change.  The driver object also builds
> with W=1.  This was not tested on physical LAN743x hardware.
> 
> Fixes: cd6910501cfd ("net: lan743x: Add support for Rx IP & TCP checksum offload")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM Symbolic
> Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 24ae56a3c9ed7..82d3ec20ba259 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -2604,7 +2604,7 @@ static int lan743x_rx_process_buffer(struct lan743x_rx *rx)
>  							rx->adapter->netdev);
>  		if (rx->adapter->netdev->features & NETIF_F_RXCSUM) {
>  			if (!is_ice && !is_tce && !is_icsm)
> -				skb->ip_summed = CHECKSUM_UNNECESSARY;
> +				rx->skb_head->ip_summed = CHECKSUM_UNNECESSARY;
>  		}
>  		netdev_dbg(netdev, "sending %d byte frame to OS",
>  			   rx->skb_head->len);
> 
> ---
> base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
> change-id: 20260913-b4-send-lan743x-uaf-9d770ad5c929
> 
> Best regards,
> --  
> Mark Amirkan <markdamirkan@gmail.com>
> 
Reviewed-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Chenguang
Thanks
