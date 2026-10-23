Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720606;
	b=dXvKohXI9Y2k8aNymn+TY/DZsjlESUEYWp5EiS3y79Gr9BlgBlX2aMPZcCL8m+GnF7jG
	 IV78+U0d+/DyKlGVufa1Jg4acpkBIf2IW2MAzHKgjrk38LDuYeD6j+olaZZm6so1w794d
	 CFuVTx1da3CPVQ3VHZEE3fZef7zuoPUHPp3CJReQ6d/piEw++0s9ztby8pJAi7XhTW+H2
	 /eBBgmVJ6JQ6wEwE7RaT69Kz+BtSMEx/0wh3mPANojuJFrG86spLOPiFoCHcTBpTatKH1
	 KwTBmSB6O+s9O67WQY/3F7VX8taoO5mRpmTknsYq2VPTVxDLEx7pnIB71xzNsnFdvDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720606;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oJFZy9ViA1hdkCiyEzcB0JcdRGfXjVzuA0WGwLAmCs4=;
	b=YJ6iulpcCuyNJVTSJYsGkupIpF6K/hQQCr3SP8QfE2+84zZRdepuJvFoCxEz9iyMVDwA
	 Shq255kee++7cu9AHzX1x/L4Xk95zqXh91Y/MOw/9YxxTh2TSulUUKiD/OfxpbLm2Z2Oy
	 8R4Anl+tYQM1CZzi5kTU5SR4hoxIhqBCyrXYgMjpy7JmVC/WauRWn7lvm7QS2y27QFSOu
	 ocv2tG37egdyJyr/i8v2uRxBZ+HVwELbndx1m82bnFj9imjvEraQPFSDGpxa3++OWZ9/r
	 u+tlDfiV+frwS7GQiaOJvuAIlBtrkMcnV0ABLwkJIk+88IqMmcfOu0SHXTAZt7J02tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lFDEReVK;
	arc=none smtp.remote-ip=91.218.175.245
Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A579606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A579606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lFDEReVK
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uX9E3o73V748llMETRdDfpWjDG+k2zeZTW03xJwVkb0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792720603; v=1; x=1793325403;
 b=lFDEReVKixlCCV8aln0VUOKnuYSlp8pGFtrke7nXPTicTCunZ0H8IlsIY4l4xMkG6xCOdQub
 qnGxz1sHC4r301LLvNBrT/Au2ztMkB7/IAGCmIC3V7Ws1h61Pjg4urSiVsPv8Lf/Z/reEb56Vtk
 q48DpLvM5j1fEAqr7eg9wOq4=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1f1f20d373d9e1ae;
	Fri, 23 Oct 2026 01:56:43 +0000
X-Mizu-Trace-ID: 1f1f20d373d9e1ae
X-Migadu-Flow: FLOW_OUT
Date: Fri, 23 Oct 2026 09:56:32 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Xia Yan <yana06070@163.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	pabeni@redhat.com, shuah@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] veth: keep carrier off when resizing channels
 with a down peer
Message-ID: <atq-0HbV71AcQi5t@fedora>
References: <20261022085842.2527-1-yana06070@163.com>
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
In-Reply-To: <20261022085842.2527-1-yana06070@163.com>

On Thu, Oct 22, 2026 at 04:58:41PM +0800, Xia Yan wrote:
> veth_set_channels() temporarily turns carrier off while reconfiguring a
> running interface. It then turns carrier on for both ends without
> checking whether the peer is administratively up. If only one end is up,
> changing its channel counts therefore reports LOWER_UP even though the
> peer remains down.
> 
> For example, after creating a pair with two RX and TX queues per end:
> 
>   ip link set vca up
>   ethtool -L vca rx 1 tx 1
> 
> vca incorrectly reports LOWER_UP while vcb is still down.
> 
> Only restore carrier when the peer has IFF_UP, matching veth_open().
> The local interface is already known to be running at this point.
> 
> Found during LLM-assisted source review and reproduced with a veth pair
> in network namespaces, without kernel instrumentation or error injection.
> With the complete default veth.sh on x86_64 QEMU/KVM (three vCPUs), the
> four mixed up/down cases fail before the fix and all six carrier cases
> pass after it. All 55 existing checks pass on both kernels.
> 
> Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Xia Yan <yana06070@163.com>
> ---
> 
> Notes:
>     Changes in v3:
>     - Driver code is unchanged from v2.
>     - The companion selftest is now part of veth.sh.
> 
>     v2: https://lore.kernel.org/netdev/20261020135544.24441-1-yana06070@163.com/
> 
>     Testing on the v2 baseline 513444cc62e2:
>     - Complete default veth.sh on x86_64 QEMU/KVM, three vCPUs:
>       before: 57 checks pass, four mixed up/down carrier checks fail;
>       after: all 61 checks pass. The 55 existing checks pass on both.
>     - bash -n and git diff --check pass.
>     - If creating the veth pair fails, the case is skipped without
>       masking failures from earlier test cases.
> 
>     Both patches also apply to net/main ffdf678dd166
>     (application check only, checked on 2026-10-22).
> 
>     The QEMU guests failed to power off cleanly (initramfs issue) after
>     the tests completed; the exit codes above are the veth.sh results.
> 
> 
>  drivers/net/veth.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 643b97d..4e75830 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1372,9 +1372,10 @@ static int veth_set_channels(struct net_device *dev,
>  		 * to identify the range we have to disable
>  		 */
>  		veth_disable_range_safe(dev, new_rx_count, old_rx_count);
> -		netif_carrier_on(dev);
> -		if (peer)
> +		if (peer && (peer->flags & IFF_UP)) {
> +			netif_carrier_on(dev);
>  			netif_carrier_on(peer);
> +		}
>  	}
>  
>  	/* update XDP supported features */
> 
> base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f
> -- 
> 2.43.0
> 

This one looks good to me. I can reproduce the report issue.

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
