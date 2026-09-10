Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446B3C0630
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035662; cv=none; b=PNY3yihFMnNx//YsJ1RcXW+mgxdVlIo6ceEihlfN7S3Rmp2ect8sb4rw4qutn9W7FfRByMw+QTFaLWBYYRD7vN6iiWArleOsnXwG8Nb1izlooT9d/tcQamcnxevaBsltQPdet73oDNsW2Gy40pVQPtZ/17efGrk0NRdRpSPMZY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035662; c=relaxed/simple;
	bh=XvLaVKEoEiuoftEQ3u/itWXtrp5NqUqZCnejfVwupUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHfmhNaZmdjdyIdscuqbrw/5+jw65RhcSg0laxSqKsgE08ZjSswMtpELZBXD7spdCjCk6EOwU/B8J0pouOeBLkxLx+xT7wBVAd6I67WX2wbsj0/vf/N6Zb7xSSXFZDaA5bfwCXiRzBEpE5MfvDUpkZOraWif8C/0ZmIH+YDday0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpdC0MEF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXVuXqwo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpdC0MEF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXVuXqwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789035657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XcK7bdMEB7RxLdgX72LvmZFPR4qNMWQ0hW33mihZm2g=;
	b=YpdC0MEFS8L9M2hIVLMXHaJlYKMWW+kyuNOQ/D4fQ6BiDbvTMCZEHb56g1XWQPtvynzXAX
	fT+/eeZz70kzQHGzL/S+ER6INU9UywjJ8P2MjrMt/zbO849Pd06RC6V+/L0ZFY39hJrs5F
	K3B/dinNzhlUJtR8V9rmsq/s/z8yRog=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-Hwp2xFaMNAS4vqHo6slkrQ-1; Thu, 10 Sep 2026 06:20:55 -0400
X-MC-Unique: Hwp2xFaMNAS4vqHo6slkrQ-1
X-Mimecast-MFC-AGG-ID: Hwp2xFaMNAS4vqHo6slkrQ_1789035654
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c293a2f7617so43343266b.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789035654; x=1789640454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XcK7bdMEB7RxLdgX72LvmZFPR4qNMWQ0hW33mihZm2g=;
        b=IXVuXqwoFkdu+ERs8Ho6fDjjMBeUxqUS45YeywH7n6Ln912vwHjA9OUHTHZqDUvd22
         LXvJDwO2sjIuoSLdfLWyRjZnFymxB1/hjY+aUA4kyvV/L6v6Rzysl9tUEBb9TdnvbrKg
         oklifL6zM5doeIU82R1twZ1As7ArQjpJSVstl/cIW7lNPfjU2/Htzv0iP0IT2SKusXR8
         12TPa5BtZn1Nbg8u9kW6Q2s+qDd/c/JY3DCPimQa2rF7UkQ7CF1sUk94h0xMVR8nd1xd
         eJm1rhuCdp9nVEzKCWhIlIFJu7dcPiSsreH5LqY2x+fSRck4/YwYY2eDj70STthKEi8x
         ZasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789035654; x=1789640454;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XcK7bdMEB7RxLdgX72LvmZFPR4qNMWQ0hW33mihZm2g=;
        b=hz3EOTfRi0oGa3vZAw05lma/SxqLr+zJyePAAH5z2whah1cW71TQPa+pCXX4dhISrH
         uc5f2r0DAGcBuuLXUdlQIM4kYLzUk+ziKSk0nD6DPASs0iCTfiqmHOZXTI3Loestgxhc
         s9TDb4ESmJExmBF/FL1YY8Ddtw/TlpkNrkL+oZwHZWx3SAydDLrldZBOisfFH4HBS5wv
         +O2a6QANww4kk4u66QvNJXzFJicos3dQKUDxbna0o/+Qe14VRIsJLpNEo8fEbIMjnK5Z
         CCAWRy9Edw/AeY4cq/BOr1ylxtAMUt/dX/mYl9VAH8Hg8pukpmfT/Pw7/akut6z/Qs7y
         arRg==
X-Forwarded-Encrypted: i=1; AKwUvBw2OR488UCGXgRYD69Mqefm10c9ZfYu9BB0z0D4900rLehf7iysXySy5RPkThlQXHPEKnrgtFc=@vger.kernel.org
X-Gm-Message-State: AFuF++ndQ/lVqaHuwgcP4tGbzt6JvZ8PedrHrBCbQR75F9HXwLAwOCcG
	gmbeZE9kyNIFcygAnFJkxhLWRgxk53Sdd/Z17QeiAoHPiKY6ZhPFkrSnqBVskLcT/iq3DFem/Qz
	forCjKhM+4v0FkKykl7+J64LPPoy15GxLhf0htWBYdhiPa4WdU2nwOA8CFg==
X-Gm-Gg: AYBFou1JgEVTLNGw1EKkwrf8RyV6qiG/1d6xvwboV6+04rKEwMHBTpoGr2VDgtXCu4a
	rVBH+fFnRIHLK5qWB83JTj34DHeAjO+armadeosfSbV/Pdx2fPsnOnlQs3fsrtJqESK9XdCpL28
	NrWqDa4HTXOUS7ukuuvRnjRYxUpxqJcxj8kq3OhJO1jdLjbM2/NVZuToif1E302x7sRacSdWgXg
	eI1vK06fIWwXL+4an2EtHLnPJklMD3MUrWHSIaSo7mkiitRnHT10GBl63V1mv8O/efqhTVm7ajd
	y1W6wnoRZFdw1tY2FK9vupC9/QPrQGwQYv9bhHYh4odH/ZNd7zL087sBnvhFfs/d06JBJTjkLwv
	IXYaivWQhjLNXktMGCUwwYC9Ea9c7UldUncI1xMRU98MtQFYsKdIjjxOVbtPa+9tGSBovUsfn9w
	==
X-Received: by 2002:a17:907:d8d:b0:c25:c54d:d1a2 with SMTP id a640c23a62f3a-c260c9e92e0mr1540664766b.18.1789035654259;
        Thu, 10 Sep 2026 03:20:54 -0700 (PDT)
X-Received: by 2002:a17:907:d8d:b0:c25:c54d:d1a2 with SMTP id a640c23a62f3a-c260c9e92e0mr1540660866b.18.1789035653563;
        Thu, 10 Sep 2026 03:20:53 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d55b306sm896263266b.36.2026.09.10.03.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 03:20:53 -0700 (PDT)
Message-ID: <30dc9ad2-0ff7-4d97-8b01-ab2267fb56b8@redhat.com>
Date: Thu, 10 Sep 2026 12:20:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] net: wwan: qcom_bam_dmux: fix TX DMA channel
 use-after-free
To: Hongyan Xu <getshell@seu.edu.cn>, Stephan Gerhold <stephan@gerhold.net>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20260903180057.1437-1-getshell@seu.edu.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260903180057.1437-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 8:00 PM, Hongyan Xu wrote:
> The modem power-control interrupt can release dmux->tx while the command,
> netdev transmit, or deferred wakeup paths are preparing and submitting
> DMA descriptors. A runtime PM reference alone does not order those paths
> against the modem-driven interrupt.
> 
> The pc and pc-ack IRQ actions do not encode the modem protocol order. A
> pc=false edge raised before a new host power vote is acknowledged can
> therefore be handled after runtime resume observes the acknowledgment and
> starts using TX. On the other hand, acknowledging a new pc=false transition
> while the host vote remains active lets the modem power down the DMA engine
> underneath the driver.
> 
> Serialize power-control state with a mutex. Before publishing a host-vote
> acknowledgment, sample the actual pc line and process any delayed
> transition.
> When pc goes low while the host vote is active and the TX channel is
> allocated, defer the transition without acknowledging it. Repeated pc=false
> interrupts remain deferred and cannot release the channel. If pc returns
> high, cancel the deferred transition.
> 
> Runtime suspend drops the host vote under the same lock. If a pc=false
> transition was deferred, it then terminates and releases the DMA channels
> before acknowledging the transition. If runtime suspend wins the race with
> the pc interrupt, the interrupt observes the inactive host vote and can
> safely perform the same shutdown. This orders channel release after the
> last runtime PM user without relying on whether the modem acknowledges
> the host vote before or after asserting pc.
> 
> Keep both state IRQs disabled until the initial probe state is committed,
> and disable both before final remove cleanup. Use a device-managed mutex
> and scoped guards for the serialized paths.
> 
> This issue was found by the author's in-house static analysis tool.
> The patch was reviewed by the author.
> 
> Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> 
> ---
> Changes in v5:
> - Drop the vote-ack state; PC-down safety does not depend on ACK ordering.
> - Keep repeated PC-low interrupts deferred while TX can still be in use.
> - Complete a deferred PC-down directly from runtime suspend after dropping
>   the host vote.
> - Move TX channel acquisition into a scoped helper and retain early returns.
> 
> Link: https://lore.kernel.org/netdev/20260822085308.1089-1-getshell@seu.edu.cn/
> 
> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index cc6ace8..429d34a 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> @@ -6,12 +6,14 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/completion.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/if_arp.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/netdevice.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -64,15 +66,23 @@ struct bam_dmux_skb_dma {
>  	dma_addr_t addr;
>  };
>  
> +enum bam_dmux_pc_vote {
> +	BAM_DMUX_PC_VOTE_INACTIVE, /* pc_vote = false */
> +	BAM_DMUX_PC_VOTE_ACTIVE, /* pc_vote = true */
> +	BAM_DMUX_PC_VOTE_DOWN_PENDING, /* pc = false while host vote active */
> +};
> +
>  struct bam_dmux {
>  	struct device *dev;
>  
> -	int pc_irq;
> +	int pc_irq, pc_ack_irq;
>  	bool pc_state, pc_ack_state;
>  	struct qcom_smem_state *pc, *pc_ack;
>  	u32 pc_mask, pc_ack_mask;
>  	wait_queue_head_t pc_wait;
>  	struct completion pc_ack_completion;
> +	struct mutex power_lock; /* Protect power-control state */
> +	enum bam_dmux_pc_vote pc_vote;
>  
>  	struct dma_chan *rx, *tx;
>  	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
> @@ -99,6 +109,24 @@ static void bam_dmux_pc_vote(struct bam_dmux *dmux, bool enable)
>  				    enable ? dmux->pc_mask : 0);
>  }
>  
> +static void bam_dmux_pc_vote_locked(struct bam_dmux *dmux, bool enable)
> +{
> +	lockdep_assert_held(&dmux->power_lock);
> +
> +	if (enable)
> +		dmux->pc_vote = BAM_DMUX_PC_VOTE_ACTIVE;
> +	else if (dmux->pc_vote != BAM_DMUX_PC_VOTE_DOWN_PENDING)
> +		dmux->pc_vote = BAM_DMUX_PC_VOTE_INACTIVE;
> +	bam_dmux_pc_vote(dmux, enable);
> +}
> +
> +static void bam_dmux_pc_vote_protected(struct bam_dmux *dmux, bool enable)
> +{
> +	mutex_lock(&dmux->power_lock);
> +	bam_dmux_pc_vote_locked(dmux, enable);
> +	mutex_unlock(&dmux->power_lock);
> +}
> +
>  static void bam_dmux_pc_ack(struct bam_dmux *dmux)
>  {
>  	qcom_smem_state_update_bits(dmux->pc_ack, dmux->pc_ack_mask,
> @@ -655,6 +683,8 @@ static void bam_dmux_free_skbs(struct bam_dmux_skb_dma skbs[],
>  
>  static void bam_dmux_power_off(struct bam_dmux *dmux)
>  {
> +	lockdep_assert_held(&dmux->power_lock);
> +
>  	if (dmux->tx) {
>  		dmaengine_terminate_sync(dmux->tx);
>  		dma_release_channel(dmux->tx);
> @@ -670,10 +700,24 @@ static void bam_dmux_power_off(struct bam_dmux *dmux)
>  	bam_dmux_free_skbs(dmux->rx_skbs, DMA_FROM_DEVICE);
>  }
>  
> -static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
> +static void bam_dmux_complete_pc_down(struct bam_dmux *dmux)
>  {
> -	struct bam_dmux *dmux = data;
> -	bool new_state = !dmux->pc_state;
> +	lockdep_assert_held(&dmux->power_lock);
> +
> +	bam_dmux_power_off(dmux);
> +	bam_dmux_pc_ack(dmux);
> +	WRITE_ONCE(dmux->pc_state, false);
> +}
> +
> +static bool bam_dmux_handle_pc(struct bam_dmux *dmux, bool new_state)
> +{
> +	lockdep_assert_held(&dmux->power_lock);
> +
> +	if (new_state == dmux->pc_state) {
> +		if (new_state && dmux->pc_vote == BAM_DMUX_PC_VOTE_DOWN_PENDING)
> +			dmux->pc_vote = BAM_DMUX_PC_VOTE_ACTIVE;
> +		return false;
> +	}
>  
>  	dev_dbg(dmux->dev, "pc: %u\n", new_state);
>  
> @@ -682,13 +726,40 @@ static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
>  			bam_dmux_pc_ack(dmux);
>  		else
>  			bam_dmux_power_off(dmux);
> +	} else if (dmux->tx && dmux->pc_vote != BAM_DMUX_PC_VOTE_INACTIVE) {
> +		/* The modem must keep the DMA engine on until pc is acked. */
> +		dmux->pc_vote = BAM_DMUX_PC_VOTE_DOWN_PENDING;
> +		dev_err_ratelimited(dmux->dev,
> +				    "refusing pc down while host vote is active\n");
> +		return false;
>  	} else {
> -		bam_dmux_power_off(dmux);
> -		bam_dmux_pc_ack(dmux);
> +		bam_dmux_complete_pc_down(dmux);
>  	}
>  
> -	dmux->pc_state = new_state;
> -	wake_up_all(&dmux->pc_wait);
> +	if (new_state)
> +		WRITE_ONCE(dmux->pc_state, true);
> +	return true;
> +}
> +
> +static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
> +{
> +	struct bam_dmux *dmux = data;
> +	bool new_state, wake;
> +	int ret;
> +
> +	mutex_lock(&dmux->power_lock);
> +	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
> +				    &new_state);
> +	if (ret) {
> +		mutex_unlock(&dmux->power_lock);
> +		dev_err_ratelimited(dmux->dev, "failed to read pc state: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	wake = bam_dmux_handle_pc(dmux, new_state);
> +	mutex_unlock(&dmux->power_lock);
> +	if (wake)
> +		wake_up_all(&dmux->pc_wait);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -696,9 +767,27 @@ static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
>  static irqreturn_t bam_dmux_pc_ack_irq(int irq, void *data)
>  {
>  	struct bam_dmux *dmux = data;
> +	bool new_state, wake = false;
> +	int ret;
>  
>  	dev_dbg(dmux->dev, "pc ack\n");
> +
> +	/* Process an earlier pc edge before publishing the host-vote ack. */
> +	synchronize_irq(dmux->pc_irq);
> +	mutex_lock(&dmux->power_lock);
> +	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
> +				    &new_state);
> +	if (ret) {
> +		mutex_unlock(&dmux->power_lock);
> +		dev_err_ratelimited(dmux->dev, "failed to read pc state: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	wake = bam_dmux_handle_pc(dmux, new_state);
>  	complete_all(&dmux->pc_ack_completion);
> +	mutex_unlock(&dmux->power_lock);
> +	if (wake)
> +		wake_up_all(&dmux->pc_wait);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -706,9 +795,47 @@ static irqreturn_t bam_dmux_pc_ack_irq(int irq, void *data)
>  static int bam_dmux_runtime_suspend(struct device *dev)
>  {
>  	struct bam_dmux *dmux = dev_get_drvdata(dev);
> +	bool wake = false;
>  
>  	dev_dbg(dev, "runtime suspend\n");
> -	bam_dmux_pc_vote(dmux, false);
> +
> +	scoped_guard(mutex, &dmux->power_lock) {
> +		bam_dmux_pc_vote_locked(dmux, false);
> +		if (dmux->pc_vote == BAM_DMUX_PC_VOTE_DOWN_PENDING) {
> +			dmux->pc_vote = BAM_DMUX_PC_VOTE_INACTIVE;
> +			bam_dmux_complete_pc_down(dmux);
> +			wake = true;
> +		} else if (!dmux->pc_state) {
> +			bam_dmux_power_off(dmux);
> +		}
> +	}
> +	if (wake)
> +		wake_up_all(&dmux->pc_wait);
> +
> +	return 0;
> +}
> +
> +static int bam_dmux_request_tx(struct bam_dmux *dmux)
> +{
> +	struct device *dev = dmux->dev;
> +
> +	scoped_guard(mutex, &dmux->power_lock) {
> +		/* Ensure that we actually initialized successfully */
> +		if (!dmux->rx)
> +			return -ENXIO;
> +
> +		/* Request TX channel if necessary */
> +		if (dmux->tx)
> +			return 0;
> +
> +		dmux->tx = dma_request_chan(dev, "tx");
> +		if (IS_ERR(dmux->tx)) {
> +			dev_err(dev, "Failed to request TX DMA channel: %pe\n",
> +				dmux->tx);
> +			dmux->tx = NULL;
> +			return -ENXIO;
> +		}
> +	}
>  
>  	return 0;
>  }
> @@ -716,6 +843,7 @@ static int bam_dmux_runtime_suspend(struct device *dev)
>  static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
>  {
>  	struct bam_dmux *dmux = dev_get_drvdata(dev);
> +	int ret;
>  
>  	dev_dbg(dev, "runtime resume\n");
>  
> @@ -724,50 +852,41 @@ static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
>  					 BAM_DMUX_REMOTE_TIMEOUT))
>  		return -ETIMEDOUT;
>  
> +	synchronize_irq(dmux->pc_irq);
> +
>  	/* Vote for power state */
> -	bam_dmux_pc_vote(dmux, true);
> +	bam_dmux_pc_vote_protected(dmux, true);
>  
>  	/* Wait for ack */
>  	if (!wait_for_completion_timeout(&dmux->pc_ack_completion,
>  					 BAM_DMUX_REMOTE_TIMEOUT)) {
> -		bam_dmux_pc_vote(dmux, false);
> +		bam_dmux_runtime_suspend(dev);
>  		return -ETIMEDOUT;
>  	}
>  
> +	synchronize_irq(dmux->pc_irq);
> +
>  	/* Wait until we're up */
> -	if (!wait_event_timeout(dmux->pc_wait, dmux->pc_state,
> +	if (!wait_event_timeout(dmux->pc_wait, READ_ONCE(dmux->pc_state),
>  				BAM_DMUX_REMOTE_TIMEOUT)) {
> -		bam_dmux_pc_vote(dmux, false);
> +		bam_dmux_runtime_suspend(dev);
>  		return -ETIMEDOUT;
>  	}
>  
> -	/* Ensure that we actually initialized successfully */
> -	if (!dmux->rx) {
> -		bam_dmux_pc_vote(dmux, false);
> -		return -ENXIO;
> -	}
> -
> -	/* Request TX channel if necessary */
> -	if (dmux->tx)
> -		return 0;
> -
> -	dmux->tx = dma_request_chan(dev, "tx");
> -	if (IS_ERR(dmux->tx)) {
> -		dev_err(dev, "Failed to request TX DMA channel: %pe\n", dmux->tx);
> -		dmux->tx = NULL;
> +	ret = bam_dmux_request_tx(dmux);
> +	if (ret)
>  		bam_dmux_runtime_suspend(dev);
> -		return -ENXIO;
> -	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int bam_dmux_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct bam_dmux *dmux;
> -	int ret, pc_ack_irq, i;
>  	unsigned int bit;
> +	bool pc_state;
> +	int ret, i;
>  
>  	dmux = devm_kzalloc(dev, sizeof(*dmux), GFP_KERNEL);
>  	if (!dmux)
> @@ -780,9 +899,9 @@ static int bam_dmux_probe(struct platform_device *pdev)
>  	if (dmux->pc_irq < 0)
>  		return dmux->pc_irq;
>  
> -	pc_ack_irq = platform_get_irq_byname(pdev, "pc-ack");
> -	if (pc_ack_irq < 0)
> -		return pc_ack_irq;
> +	dmux->pc_ack_irq = platform_get_irq_byname(pdev, "pc-ack");
> +	if (dmux->pc_ack_irq < 0)
> +		return dmux->pc_ack_irq;
>  
>  	dmux->pc = devm_qcom_smem_state_get(dev, "pc", &bit);
>  	if (IS_ERR(dmux->pc))
> @@ -799,6 +918,9 @@ static int bam_dmux_probe(struct platform_device *pdev)
>  	init_waitqueue_head(&dmux->pc_wait);
>  	init_completion(&dmux->pc_ack_completion);
>  	complete_all(&dmux->pc_ack_completion);
> +	ret = devm_mutex_init(dev, &dmux->power_lock);
> +	if (ret)
> +		return ret;
>  
>  	spin_lock_init(&dmux->tx_lock);
>  	INIT_WORK(&dmux->tx_wakeup_work, bam_dmux_tx_wakeup_work);
> @@ -817,31 +939,40 @@ static int bam_dmux_probe(struct platform_device *pdev)
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_enable(dev);
>  
> -	ret = devm_request_threaded_irq(dev, pc_ack_irq, NULL, bam_dmux_pc_ack_irq,
> -					IRQF_ONESHOT, NULL, dmux);
> +	ret = devm_request_threaded_irq(dev, dmux->pc_ack_irq, NULL,
> +					bam_dmux_pc_ack_irq,
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					NULL, dmux);
>  	if (ret)
>  		goto err_disable_pm;
>  
>  	ret = devm_request_threaded_irq(dev, dmux->pc_irq, NULL, bam_dmux_pc_irq,
> -					IRQF_ONESHOT, NULL, dmux);
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN, NULL, dmux);
>  	if (ret)
> -		goto err_disable_pm;
> +		goto err_power_off;
>  
> +	mutex_lock(&dmux->power_lock);
>  	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
> -				    &dmux->pc_state);
> -	if (ret)
> -		goto err_disable_pm;
> +				    &pc_state);
> +	if (ret) {
> +		mutex_unlock(&dmux->power_lock);
> +		goto err_power_off;
> +	}
>  
>  	/* Check if remote finished initialization before us */
> -	if (dmux->pc_state) {
> -		if (bam_dmux_power_on(dmux))
> -			bam_dmux_pc_ack(dmux);
> -		else
> -			bam_dmux_power_off(dmux);
> -	}
> +	bam_dmux_handle_pc(dmux, pc_state);
> +	mutex_unlock(&dmux->power_lock);
> +
> +	/* Start handling state changes after the initial state is processed. */
> +	enable_irq(dmux->pc_ack_irq);
> +	enable_irq(dmux->pc_irq);
>  
>  	return 0;
>  
> +err_power_off:
> +	mutex_lock(&dmux->power_lock);
> +	bam_dmux_power_off(dmux);
> +	mutex_unlock(&dmux->power_lock);
>  err_disable_pm:
>  	pm_runtime_disable(dev);
>  	pm_runtime_dont_use_autosuspend(dev);
> @@ -872,12 +1003,16 @@ static void bam_dmux_remove(struct platform_device *pdev)
>  	pm_runtime_set_suspended(dev);
>  
>  	/* Try to wait for remote side to drop power vote */
> -	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
> +	if (!wait_event_timeout(dmux->pc_wait, !READ_ONCE(dmux->rx),
> +				BAM_DMUX_REMOTE_TIMEOUT))
>  		dev_err(dev, "Timed out waiting for remote side to suspend\n");
>  
>  	/* Make sure everything is cleaned up before we return */
> +	disable_irq(dmux->pc_ack_irq);

Beyond all the sashiko comments, this patch is quite big and should
be split in smaller chunck to help reviewers.

I.e. the above line looks like a separate fix, deserving
it's own patch.

/P

