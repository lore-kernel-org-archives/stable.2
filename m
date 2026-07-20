Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34E2641CA;
	Mon, 20 Jul 2026 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578066; cv=none; b=vAqfeGdfcAHnxzpvv3eh7gEsKK/eYp5GBJQ7gYpQo97bMy4LzDWVnyLhkzKn3/BNhhKNpQCE3stGd/7mGXMR3mYM0WOA2kSiWLmEyaMjsiOPYyKv/iMp4GM2+5nmYtEERsFxSXWMe0e/YAuOLWealgtQ31HyOFIXLx4Vtntx5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578066; c=relaxed/simple;
	bh=Jy1+Wm9Vy6BteYPlPzfj8ZNVn+e4W/J3qes0hb9vnhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnGTaCwMeqXwldlG7Jj/fOFCXaspMhtSwIhoIBoK8SH8G1J0vWlG1kghx7ZnZYQRG3PfDLK6sKhbt4tyRZ2F8dIt91lDgTPFFdUrX+Z5XcKNDTLlGbHbEeOR4KTtrhN7UFwO2CCphEozPyrm7jJCFwBvMsuzT1U8JQ3PPmwR0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CwVmJZ/x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CwVmJZ/x"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id CF38A20B7169; Mon, 20 Jul 2026 13:07:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF38A20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784578052;
	bh=JY4lTYxbNAjs31iCIWh2OWIe8kSCIzV3Kr9v5xirdFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwVmJZ/xNjzx8AmFJoh/Pbxr1d1EOEeSEY3AWsCJIFfUJ6lTfNULIIEObSlpXy765
	 rwGBUKiFM+cds/ezbJarTqY7AFQqXoepuF0U8erzprqG+g75M9rgQdsL3K9XAOpket
	 HVxflh2qpUiZx68a0A08ov3iaSZt3PoUHjX9huPU=
Date: Mon, 20 Jul 2026 13:07:32 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: mana: cap HWC init max message size to
 HW_CHANNEL_MAX_REQUEST_SIZE
Message-ID: <al6ABAMHeE76yldL@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260711150628.2914205-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711150628.2914205-1-michael.bommarito@gmail.com>

On Sat, Jul 11, 2026 at 11:06:28AM -0400, Michael Bommarito wrote:
> mana_hwc_init_event_handler() in hw_channel.c stores device-advertised
> HWC_INIT_DATA_MAX_REQUEST and HWC_INIT_DATA_MAX_RESPONSE values
> without bounds checking. mana_hwc_alloc_dma_buf() later computes the
> DMA buffer size as MANA_PAGE_ALIGN(q_depth * max_msg_size) in 32-bit
> arithmetic. A malicious device returning a large max_msg_size causes
> the product to wrap, allocating a small buffer while laying out
> q_depth request slots at the unwrapped stride, placing slots outside
> the allocation.

I don't think the described data flow actually
exists in the current tree, so the security framing looks inaccurate.
Please check the comment below.
> 
> Impact: a compromised hypervisor device model or malicious MANA PCI
> device can cause out-of-bounds DMA buffer writes during HWC channel
> initialization. A reproducer is available on request.
> 
> Clamp both values to HW_CHANNEL_MAX_REQUEST_SIZE (4096), consistent
> with the cap already applied at the channel-create callsite.
> 
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  drivers/net/ethernet/microsoft/mana/hw_channel.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> index 48a9acea4ab6c..a0916b50cffce 100644
> --- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
> +++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
> @@ -152,10 +152,14 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
>  			break;
>  
>  		case HWC_INIT_DATA_MAX_REQUEST:
> +			if (val == 0 || val > HW_CHANNEL_MAX_REQUEST_SIZE)
> +				val = HW_CHANNEL_MAX_REQUEST_SIZE;
>  			hwc->hwc_init_max_req_msg_size = val;
>  			break;
>  
>  		case HWC_INIT_DATA_MAX_RESPONSE:
> +			if (val == 0 || val > HW_CHANNEL_MAX_REQUEST_SIZE)
> +				val = HW_CHANNEL_MAX_REQUEST_SIZE;
>  			hwc->hwc_init_max_resp_msg_size = val;
>  			break;
>  

The clamp is applied to hwc->hwc_init_max_req_msg_size and
hwc->hwc_init_max_resp_msg_size. Tracing where those two fields are
consumed:

  mana_hwc_init_event_handler()
	|
  mana_hwc_establish_channel() // copies them out to *max_req_msg_size
        |                          and *max_resp_msg_size
  mana_hwc_create_channel()    // passes those locals only to
        |                          mana_hwc_test_channel()
  mana_hwc_test_channel()      // passed as parameters but never
                                   used them

The DMA buffers that alloc_dma_buf() sizes are created from
mana_hwc_init_queues(), which is called with the compile-time constants:

    err = mana_hwc_init_queues(hwc, HW_CHANNEL_VF_BOOTSTRAP_QUEUE_DEPTH,
                   HW_CHANNEL_MAX_REQUEST_SIZE,
                   HW_CHANNEL_MAX_RESPONSE_SIZE);

Therefore, q_depth * max_msg_size cannot wrap from a device-controlled
value here.

Thanks,
Vennela
> -- 
> 2.53.0
> 

> 
