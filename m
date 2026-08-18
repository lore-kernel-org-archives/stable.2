Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664A3D6CD7;
	Tue, 18 Aug 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048405; cv=none; b=Dw+wSI6DsX8UZPZ9MBWiyDPrTtum5sL3Y92080sWTpOBsA5hnQW9vPQRE28dB1FIVb7Nx4hLXmhe/WVBBzoYOX78cuDd8AItGS9h6PZkFIMWAXgwtoOvTtj3Dn/xnU/svE9h4e4YxLgcXNg5iGzn1zFn0/2McFQjY9CGw1uYf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048405; c=relaxed/simple;
	bh=LO/vjHWEeIFquQ2yaka3bi1+63f1VE1Th7TivCU3WUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwCAyQINynorOna8r/TNYgoUtH1AL0197q3BgHY4URgKp3Rle0glVYxQ0ziCnx6Xa7d/h49tzc+iEExOWf3oPkLHr23dubNne0Yk1Mt4TQ5kvAXCJUVO7E0oS1kKO634areIGDzb2Y7FVM9lXYXS5jpCVEUPb5aY8IrNWh84fO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2od12Ku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2od12Ku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E233E1F000E9;
	Tue, 18 Aug 2026 10:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787048403;
	bh=pUoqNHNkbMwIt4lSmK+pizoz/9tA8lUOAD1i6UjZcAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H2od12KuDIjVp9DagsaTOf7qFMvI8Mp9Ppe0jpKnqUt17/ujdMPy9TDHOI0nYAN8q
	 GIz7+xtWzsSfckfSbWWGVy/71v4mjzhCkH4AZlrKbFSMeuvs+b6lPVusaypkWser9v
	 R6BpH26kzAE2+UrY6bgy7Te3GVRssQ1lfk47yEjdZEXBHbw7HXKTYb94/E22z69z3F
	 BVsaSxaCM4M86yKKRNPEdlM3/KycDe9IZVB/Pewl8eho2e04LcK20AfNZcGsqFl+vt
	 w/9VtMaENtixAXyhPRrAAvwpgzsw90rxjr1EchDc+1A1dZ4/vOIGTxyWKLchkCLXKJ
	 SSPRZIrCRP6Gw==
Message-ID: <6fb5d4f4-572f-482c-8557-0698bed264c4@kernel.org>
Date: Tue, 18 Aug 2026 11:19:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: iris: Fix iova allocation from restrict region
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com>
 <WFnfS9Cjn6u6hhciGaVoM5f_ssrc1F4IRkW-0oBrKVPm8EfjxIdzHF8jZPg0bliX1uwWBWcm4XF0d6KObL_A6w==@protonmail.internalid>
 <20260812-reserve_iova_in_driver-v1-1-ed62f801275c@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20260812-reserve_iova_in_driver-v1-1-ed62f801275c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2026 11:55, Vishnu Reddy wrote:
> The VPU issues DMA through several SMMU streams, and the hardware does
> not give every stream the same addressable range. The non-pixel stream
> cannot address the low 600MB of IOVA space, while the pixel stream can
> address the full range:
>      +-----------------------------------------------------------+
>      | non-pixel stream addressable range (600 MB - 3.5 GB)      |
>      | 0x25800000 - 0xe0000000                                   |
>      +-----------------------------------------------------------+
>      | pixel stream addressable range (0 - 3.5 GB)               |
>      | 0x00000000 - 0xe0000000                                   |
>      +-----------------------------------------------------------+
> A single "iommus" property on the video-codec node puts every stream
> in one IOMMU domain sharing one IOVA allocator, so nothing restricts a
> non-pixel buffer to avoid 0 to 600MB. Once an allocation lands below that
> boundary the hardware faults, which shows up as unhandled SMMU page
> faults and spontaneous reboots.
> https://gitlab.freedesktop.org/drm/msm/-/work_items/100
> 
> A series to reserve the 0-600MB IOVA range via "iommu-addresses" was
> already posted here:
> https://lore.kernel.org/all/20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com

Something for a cover letter not a commit log - ongoing debates about 
how to change the behaviour will be irrelevant in 15 years after this 
stuff has landed.

The commit log should

- State the problem
- State the fix

Additional narrative about other series is for the series overview not 
the commit log.

> Those changes involve DT binding and DT node changes, and discussion is
> still ongoing on how to handle those for stable and for the upcoming
> sub-node design, with no conclusion reached yet. Thereby a critical reset
> issue is still open.

Drop.

> This is an alternate solution to fix the unhandled SMMU page fault

Kill this "alternative solution" stuff - if this lands in mainline then 
this _is_ the solution unless/until it is superseded.

> by restricting the IOVA range in the video driver, which also makes it
> easier and faster to land on mainline and stable kernels. At the same
> time the patch only reserves in the IOVA space without allocating
> any physical memory.

You should specify how you are making that restriction in the commit log.

Reading code...

OK you reserve below the boundary. Please add that to the commit log, 
its the salient piece of information.
> 
> Currently sub-nodes are not yet present, and only a single device is
> available, so the restriction is applied to both non-pixel and pixel
> stream IDs. This makes the solution unoptimal while fixing the issue
> considering all scenarios.
> Once sub-nodes for non-pixel, pixel, and secure streams become available,
> the restriction can be made stream specific.

Yeah all good information for the overview but if someone lands from 
Trantor in 10,000 years to pick through the detritus of our civilisation 
finding an old computer with kernel version 55.20 running on it and no 
sign of venus sub-nodes they might march off to the next planet to try 
to find them.

Drop the sub-nodes discussion from your commit log. Clearly state the 
problem and its remediation in your log, no need to reference ongoing 
bikeshedding elsewhere.

> 
> Fixes: d7378f84e94e ("media: iris: introduce iris core state management with shared queues")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_core.h  |  6 +++
>   drivers/media/platform/qcom/iris/iris_probe.c | 69 ++++++++++++++++++++++++++-
>   2 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
> index 24da60448cf2..79bc342a25a2 100644
> --- a/drivers/media/platform/qcom/iris/iris_core.h
> +++ b/drivers/media/platform/qcom/iris/iris_core.h
> @@ -7,6 +7,7 @@
>   #define __IRIS_CORE_H__
> 
>   #include <linux/types.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/pm_domain.h>
>   #include <media/v4l2-device.h>
> 
> @@ -25,6 +26,9 @@ struct icc_info {
>   #define IRIS_FW_VERSION_LENGTH		128
>   #define IFACEQ_CORE_PKT_SIZE		(1024 * 4)
> 
> +#define IRIS_NP_RESERVE_IOVA_START	0x0
> +#define IRIS_NP_RESERVE_IOVA_SIZE	0x25800000
> +
>   enum domain_type {
>   	ENCODER	= BIT(0),
>   	DECODER	= BIT(1),
> @@ -77,6 +81,7 @@ struct qcom_ubwc_cfg_data;
>    * @instances: a list_head of all instances
>    * @inst_fw_caps_dec: an array of supported instance capabilities by decoder
>    * @inst_fw_caps_enc: an array of supported instance capabilities by encoder
> + * @iova_state: an array of dma_iova_state entries reserved for the restricted IOVA region
>    */
> 
>   struct iris_core {
> @@ -123,6 +128,7 @@ struct iris_core {
>   	/* encoder and decoder have overlapping caps, so two different arrays are required */
>   	struct platform_inst_fw_cap		inst_fw_caps_dec[INST_FW_CAP_MAX];
>   	struct platform_inst_fw_cap		inst_fw_caps_enc[INST_FW_CAP_MAX];
> +	struct dma_iova_state			*iova_state;
>   };
> 
>   int iris_core_init(struct iris_core *core);
> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
> index e4acf4a74f94..f44305ee81b6 100644
> --- a/drivers/media/platform/qcom/iris/iris_probe.c
> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
> @@ -150,6 +150,64 @@ static int iris_init_resources(struct iris_core *core)
>   	return iris_init_resets(core);
>   }
> 
> +static int iris_reserve_iova_region(struct device *dev, struct dma_iova_state **iova_state,
> +				    unsigned long start, unsigned long size)
> +{
> +	unsigned long mask = dma_get_mask(dev);
> +	unsigned long end, rem, chunk;
> +	struct dma_iova_state *state;
> +	unsigned int count = 0;
> +	int ret;
> +
> +	state = kcalloc(BITS_PER_TYPE(dma_addr_t) + 1, sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return -ENOMEM;

devm_kcalloc() is less work.

> +
> +	end = start + size;
> +	rem = end - max(start, PAGE_SIZE);
> +
> +	ret = dma_set_mask_and_coherent(dev, end - 1);
> +	if (ret)
> +		goto err_free_mem;


I believe you should set dev->bus_dma_limit instead so drop this mask 
operation.

drivers/ata/ahci.c:	* bogus, platform code should use dev->bus_dma_limit 
instead..

=>

dev->bus_dma_limit = IRIS_NP_RESERVE_IOVA_SIZE -1;

> +
> +	while (rem) {
> +		chunk = min(end & -end, (u64)1 << (fls64(rem) - 1));

> +		if (!dma_iova_try_alloc(dev, &state[count], 0, chunk)) {
> +			ret = -ENOMEM;
> +			goto err_free_iova;
> +		}
> +

check that state[count].addr == end - chunk
error out if it does not.

> +		rem -= chunk;
> +		end -= chunk;
> +		count++;
> +	}
> +
> +	*iova_state = state;
> +	dma_set_mask_and_coherent(dev, mask);
> +
> +	return 0;
> +
> +err_free_iova:
> +	while (count--)
> +		dma_iova_free(dev, &state[count]);
> +	dma_set_mask_and_coherent(dev, mask);
\n> +err_free_mem:
> +	kfree(state);
> +
> +	return ret;


> +}
> +
> +static void iris_unreserve_iova_region(struct device *dev, struct dma_iova_state *iova_state)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; dma_iova_size(&iova_state[i]); i++)
> +		dma_iova_free(dev, &iova_state[i]);
> +
> +	kfree(iova_state);
> +}
> +
>   static int iris_register_video_device(struct iris_core *core, enum domain_type type)
>   {
>   	struct video_device *vdev;
> @@ -207,6 +265,8 @@ static void iris_remove(struct platform_device *pdev)
> 
>   	v4l2_device_unregister(&core->v4l2_dev);
> 
> +	iris_unreserve_iova_region(core->dev, core->iova_state);
> +
>   	mutex_destroy(&core->lock);
>   }
> 
> @@ -292,14 +352,21 @@ static int iris_probe(struct platform_device *pdev)
>   	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
>   	dma_set_seg_boundary(&pdev->dev, DMA_BIT_MASK(32));
> 
> +	ret = iris_reserve_iova_region(dev, &core->iova_state, IRIS_NP_RESERVE_IOVA_START,
> +				       IRIS_NP_RESERVE_IOVA_SIZE);
> +	if (ret)
> +		goto err_vdev_unreg_enc;
> +

This reservation should come before video_register_device() since its 
possible for user-space to race this otherwise.

Should come pretty much up the top

>   	pm_runtime_set_autosuspend_delay(core->dev, AUTOSUSPEND_DELAY_VALUE);
>   	pm_runtime_use_autosuspend(core->dev);
>   	ret = devm_pm_runtime_enable(core->dev);
>   	if (ret)
> -		goto err_vdev_unreg_enc;
> +		goto err_unresv_iova_region;
> 
>   	return 0;
> 
> +err_unresv_iova_region:
> +	iris_unreserve_iova_region(dev, core->iova_state);
>   err_vdev_unreg_enc:
>   	video_unregister_device(core->vdev_enc);
>   err_vdev_unreg_dec:
> 
> --
> 2.34.1
> 

---
bod
