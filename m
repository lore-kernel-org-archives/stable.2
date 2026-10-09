Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD045C71D
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541791; cv=none; b=LtHR7OCNqYvk4yki8BYZo6NuZqByh+GxFZ1stf0MhZPv9zLS/8cSSchfO/YeAkmCbQkgyeWz+Dsg01Bhf8rONonW94kyrlfF0x0PxBaFijZnKnqpBsiNSr7XpoJbvzEY9SQRHIegpn1VBdUecR2lRFRbtlEHHf8rwBLegcczVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541791; c=relaxed/simple;
	bh=4fb9uay90Z854uVuu55ZT4U02v9KnZLToT6YXaAWwe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufxCV2vWfz9n1gfJuB88412vr9TJKTnPFOPuznMVJoNPH4KQDHEwv43KZwJzGjLEMGlCjFOIQnCKN219tR+SrPVlYRwHCFa9Pmx9AwEc3encx47MTXwtv0mZlZGu72vWbAY76vLSRZQPiIPCo7dEjaycUKnJc8b/Kzv9zFf2QJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmsO43QJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmsO43QJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791541788; x=1823077788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4fb9uay90Z854uVuu55ZT4U02v9KnZLToT6YXaAWwe8=;
  b=fmsO43QJW9N1rFJ/Delsv82MhSyhvxRM49sENjSD0OipH+dSKOH84N4i
   n5wvie6i7R0/ZWRr4wOty07/SoefrtZtAYXe7Yfw0MU7UrzGNm4lo3I/L
   loR25A60/rj+RUkjDsTqYr6L/Fl7b2fglhRViioktv6xa2RTtA0MnygHm
   DSr0Pi4u7DsZgEQ2XR9S1T5cqh8wruhYCnbsnDtBu3RCgNypIT0iGnvqi
   ynkG8ANBOaDcSsDdS3Nmum0+YRCMhtEdvYF7pfn9Y+I6xraKdFT/M+BJh
   JPt+N/GSE8WP4CB+jSy7qpfyfDxBQRyinnwu1B8ZCgWlW1V0Z+SGv7+Vw
   w==;
X-CSE-ConnectionGUID: Sl6mRtCPQoCsIqX8PQyLbw==
X-CSE-MsgGUID: 5RXf9xA4R9KQUMXx2IFBiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="223439"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="223439"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:29:48 -0700
X-CSE-ConnectionGUID: 7o14ESivQb283islza/y1A==
X-CSE-MsgGUID: xBa0Mr+4RZS+cQDUUR+Q/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="244709"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.244.25]) ([10.245.244.25])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:29:46 -0700
Message-ID: <16cfde6b-8881-4ffe-8068-9530286da72a@intel.com>
Date: Fri, 9 Oct 2026 11:29:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/xe: skip p2p for suspected display buffers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20261007153605.1743626-5-matthew.auld@intel.com>
 <20261007153605.1743626-8-matthew.auld@intel.com>
 <2c6a97ac21c5ef161dbac279f9b971f383b6b944.camel@linux.intel.com>
 <dbabed4e-468d-4ecf-b295-f5d8c9c4b263@intel.com>
 <bc2f4d82-5a8e-4d1b-a921-ee819ca5cac2@amd.com>
 <992d57f0-7327-4c36-adf7-6dd72137fe73@intel.com>
 <31f7eb68-6dfa-4ea7-93a4-d4897fbe6a74@intel.com>
 <3579864a-0283-4f92-b895-5cf399c2ee69@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <3579864a-0283-4f92-b895-5cf399c2ee69@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/10/2026 10:26, Christian König wrote:
> On 10/9/26 11:16, Matthew Auld wrote:
>> On 08/10/2026 12:17, Matthew Auld wrote:
>>> On 08/10/2026 10:55, Christian König wrote:
>>>> On 10/8/26 11:46, Matthew Auld wrote:
>>>>> On 07/10/2026 19:11, Thomas Hellström wrote:
>>>>>> On Wed, 2026-10-07 at 16:36 +0100, Matthew Auld wrote:
>>>>>>> If p2p is allowed on the CPU (like on AMD), we currently permit p2p
>>>>>>> for
>>>>>>> all exported VRAM buffers. However, in some multi-GPU setups, like
>>>>>>> with
>>>>>>> prime rendering on a dgpu and scanout/compositor using the igpu, it
>>>>>>> looks like the exported dma-buf window buffer can in some cases end
>>>>>>> up
>>>>>>> using p2p.
>>>>>>>
>>>>>>> However, user is reporting a kernel regression where performance here
>>>>>>> massively tanks across many games/workloads, where it looks like on
>>>>>>> each
>>>>>>> frame, the igpu is reading/sampling from VRAM over pcie for the
>>>>>>> window
>>>>>>> buffer, since it uses p2p. p2p is currently more intended for dgpu <-
>>>>>>>>
>>>>>>> dgpu, and not so much display buffers with igpu <-> dgpu, at least
>>>>>>> for
>>>>>>> now.
>>>>>>>
>>>>>>> We don't currently have any hints to say "please use p2p for this
>>>>>>> buffer, or please don't", however we can use some heuristics to try
>>>>>>> to
>>>>>>> determine if this is likely a display buffer being exported to an
>>>>>>> igpu,
>>>>>>> which probably never intended for p2p:
>>>>>>>
>>>>>>>     1. FLAG_SCANOUT being set on the buffer. Window buffers usually get
>>>>>>>        tagged with this, but not always.
>>>>>>>
>>>>>>>     2. Importer being a PCI device with display, which is not xe driver.
>>>>>>>
>>>>>>> We also rely on the existing p2p Intel CPU whitelist to stop this
>>>>>>> happening on xe igpu. Currently p2p is only enabled for server CPUs,
>>>>>>> on
>>>>>>> Intel. We also limit the above to dual placement buffers.
>>>>>>>
>>>>>>> The original regression was bisected to commit 609fc8766d68 ("dma-
>>>>>>> buf:
>>>>>>> Always build with DMABUF_MOVE_NOTIFY"), however the behaviour was
>>>>>>> already present when enabling that knob, so this goes back even
>>>>>>> further.
>>>>>>>
>>>>>>> User has confirmed that along with the sticky dma-buf TT placement
>>>>>>> fix,
>>>>>>> to prevent ping-ponging, the performance is back to normal.
>>>>>>>
>>>>>>
>>>>>> Actually, I think this needs to be fixed on the importer side. Until we
>>>>>> have some some user-space hints, I don't think the exporter should
>>>>>> second-guess. Most sane solution IMO is if igfx importers could just
>>>>>> not advertise pcie p2p support?
>>>>>
>>>>> Yeah, not sure tbh. I'm not a huge fan of this patch either. But you could argue that the SCANOUT flag is already a good implicit hint/ signal on the exporter side, but unfortunately there were some games where this did not reliably work. The other implicit hint/signal is perhaps the dual placement angle. For example, in compute-runtime, it might be that they use VRAM-only if they want p2p? AFAICT mesa for us always uses a dual placement or just system memory for these types of buffers.
>>>>>
>>>>> Christian, do you have any thoughts here? We have a kernel perf regression after DMABUF_MOVE_NOTIFY was made the default after updating to a new kernel. The gist is that this then turned on the p2p paths, with a multi-GPU setup with an AMD igpu/APU and Xe dgpu doing prime rendering. From the user bug report it sounds like the dgpu linear window buffer exported to the compositor (igpu) is dual placement VRAM + TT, and so this now attempts to keep that memory in VRAM instead of moving it. Compositor then uses p2p to access it. It works but performance falls off a massive cliff here.
>>>>>
>>>>> Perhaps Intel Mesa side should use tt-only for this type buffer (?), but since this is a kernel regression I was hoping we could fix this on the kernel side.
>>>>>
>>>>> Some questions:
>>>>>
>>>>> 1. Do you know what is the general story with p2p between igpu and dgpu? Is this a legit thing? For igpus/APUs, advertising p2p can't be dropped? It clearly seems to work though.
>>>>>
>>>>> 2. If this is legit, do you guys then also prevent p2p with display buffers? Are you just doing that at the Mesa level, or is there some magic in the kernel also?
>>>>
>>>> If I understand that correctly that the igpu is the importer and the dgpu is the exporter then yeah Thomas is right that definately needs to be fixed on the importer side.
>>>
>>> Ideas on how do that? Could we do something like allow_peer2peer = false in amdgpu_gem_prime_import() if this is an APU device, or further check if the exporter side is not amdgpu, like APU + Xe?
>>
>> For example: https://gitlab.freedesktop.org/mwa/kernel/-/commit/7ec86c68b42655b4bb85ee90af434a617e7bec8c
>>
>> Is that something you would accept?
> 
> No, you misunderstood me. Enabling P2P is perfectly fine for APUs and mandatory for a couple of customer projects.
> 
> The buffer should just be rejected from scanout in the display code and on the AMDGPU side we already do that if I'm not completely mistaken.

Reporter confirmed seeing the issue in windowed mode also. So I don't 
think it's just a case of rejecting from scanout?

> 
> Userspace has fallback path that when a DRM atomic requests fails for an imported buffer it falls back to copying the buffer first.
> 
> Regards,
> Christian.
>>>
>>>>
>>>> At least for AMD APUs we clearly support P2P both as exporter and importer, but what isn't supported is to scan out over P2P. We explicitely reject that inside DC/DAL.
>>>>
>>>> And I'm pretty sure that you should do that as well. I'm actually really suprised that this works technically and doesn't cause corruption or anything.
>>>
>>> AFAICT on Intel iGPUs it will currently always end up with peer2peer = false on attach. Not 100% sure if direct scanout was happening on the p2p buffer itself, for the user report.
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Thomas
>>>>>>
>>>>>>> Assisted-by: LLM
>>>>>>> Closes:
>>>>>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
>>>>>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>>>>>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
>>>>>>> GPUs")
>>>>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>> Cc: <stable@vger.kernel.org> # v6.12
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/xe/xe_bo.c      |  3 +-
>>>>>>>     drivers/gpu/drm/xe/xe_bo.h      |  1 +
>>>>>>>     drivers/gpu/drm/xe/xe_dma_buf.c | 63 ++++++++++++++++++++++++ +------
>>>>>>> -- 
>>>>>>>     3 files changed, 51 insertions(+), 16 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>>>>>>> index 5065a7bac39c..e63437a261cb 100644
>>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.c
>>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>>>>>>> @@ -3658,7 +3658,7 @@ int xe_gem_create_ioctl(struct drm_device *dev,
>>>>>>> void *data,
>>>>>>>          * Display scanout is always non-coherent with the CPU
>>>>>>> cache.
>>>>>>>          */
>>>>>>>         if (args->flags & DRM_XE_GEM_CREATE_FLAG_SCANOUT)
>>>>>>> -        bo_flags |= XE_BO_FLAG_FORCE_WC;
>>>>>>> +        bo_flags |= XE_BO_FLAG_FORCE_WC |
>>>>>>> XE_BO_FLAG_SCANOUT;
>>>>>>>           if (args->flags & DRM_XE_GEM_CREATE_FLAG_NO_COMPRESSION) {
>>>>>>>             if (XE_IOCTL_DBG(xe, GRAPHICS_VER(xe) < 20))
>>>>>>> @@ -4228,6 +4228,7 @@ int xe_bo_dumb_create(struct drm_file
>>>>>>> *file_priv,
>>>>>>>                        DRM_XE_GEM_CPU_CACHING_WC,
>>>>>>> XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
>>>>>>>                        XE_BO_FLAG_FORCE_WC |
>>>>>>> +                   XE_BO_FLAG_SCANOUT |
>>>>>>>                        XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
>>>>>>>         if (IS_ERR(bo))
>>>>>>>             return PTR_ERR(bo);
>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
>>>>>>> index 1ddf3b6d4a9e..6965c2655731 100644
>>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.h
>>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.h
>>>>>>> @@ -56,6 +56,7 @@
>>>>>>>     #define XE_BO_FLAG_FORCE_USER_VRAM    BIT(25)
>>>>>>>     #define XE_BO_FLAG_NO_COMPRESSION    BIT(26)
>>>>>>>     #define XE_BO_FLAG_NEEDS_1G        BIT(27)
>>>>>>> +#define XE_BO_FLAG_SCANOUT        BIT(28)
>>>>>>>       /* this one is trigger internally only */
>>>>>>>     #define XE_BO_FLAG_INTERNAL_TEST    BIT(30)
>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>> b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>> index b973579a69b8..0a347f09cee4 100644
>>>>>>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>> @@ -36,10 +36,40 @@ static void xe_ddebug_flip_bool(const struct
>>>>>>> _ddebug *desc, bool *flag)
>>>>>>>     #define xe_dma_buf_p2p_debug_flip(flag) do { } while (0)
>>>>>>>     #endif
>>>>>>>     +static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>>>>>> *attach)
>>>>>>> +{
>>>>>>> +    struct drm_gem_object *obj = attach->importer_priv;
>>>>>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>> +    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>>>>>> +
>>>>>>> +    XE_WARN_ON(xe_bo_evict(bo, exec));
>>>>>>> +}
>>>>>>> +
>>>>>>> +static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>>>>>> +    .allow_peer2peer = true,
>>>>>>> +    .invalidate_mappings = xe_dma_buf_move_notify
>>>>>>> +};
>>>>>>> +
>>>>>>> +static struct pci_dev *xe_find_parent_pci_dev(struct device *dev)
>>>>>>> +{
>>>>>>> +    while (dev) {
>>>>>>> +        if (dev_is_pci(dev))
>>>>>>> +            return to_pci_dev(dev);
>>>>>>> +        dev = dev->parent;
>>>>>>> +    }
>>>>>>> +    return NULL;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static bool xe_dma_buf_attach_is_xe_device(struct dma_buf_attachment
>>>>>>> *attach)
>>>>>>> +{
>>>>>>> +    return attach->importer_ops == &xe_dma_buf_attach_ops;
>>>>>>> +}
>>>>>>> +
>>>>>>>     static int xe_dma_buf_attach(struct dma_buf *dmabuf,
>>>>>>>                      struct dma_buf_attachment *attach)
>>>>>>>     {
>>>>>>>         struct drm_gem_object *obj = attach->dmabuf->priv;
>>>>>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>>         bool verbose_p2p_dist = drm_debug_enabled(DRM_UT_DRIVER);
>>>>>>>           xe_dma_buf_p2p_debug_flip(&verbose_p2p_dist);
>>>>>>> @@ -48,7 +78,24 @@ static int xe_dma_buf_attach(struct dma_buf
>>>>>>> *dmabuf,
>>>>>>>             pci_p2pdma_distance(to_pci_dev(obj->dev->dev), attach-
>>>>>>>> dev, verbose_p2p_dist) < 0)
>>>>>>>             attach->peer2peer = false;
>>>>>>>     -    if (!attach->peer2peer &&
>>>>>>> !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
>>>>>>> +    if (attach->peer2peer && xe_bo_can_migrate(bo, XE_PL_TT)) {
>>>>>>> +        struct pci_dev *client =
>>>>>>> xe_find_parent_pci_dev(attach->dev);
>>>>>>> +
>>>>>>> +        /*
>>>>>>> +         * There are perf issues with using p2p with display
>>>>>>> buffers,
>>>>>>> +         * like with igpu (compositor) <-> dgpu (exported
>>>>>>> p2p window
>>>>>>> +         * buffer). Probably we need some actual userspace
>>>>>>> hints. We
>>>>>>> +         * shouldn't really assume anything. Also, note that
>>>>>>> some of
>>>>>>> +         * these buffers are not always tagged with SCANOUT.
>>>>>>> +         */
>>>>>>> +        if (bo->flags & XE_BO_FLAG_SCANOUT)
>>>>>>> +            attach->peer2peer = false;
>>>>>>> +        else if (client && pci_is_display(client) &&
>>>>>>> +             !xe_dma_buf_attach_is_xe_device(attach))
>>>>>>> +            attach->peer2peer = false;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if (!attach->peer2peer && !xe_bo_can_migrate(bo, XE_PL_TT))
>>>>>>>             return -EOPNOTSUPP;
>>>>>>>           xe_pm_runtime_get(to_xe_device(obj->dev));
>>>>>>> @@ -349,20 +396,6 @@ xe_dma_buf_create_obj(struct drm_device *dev,
>>>>>>> struct dma_buf *dma_buf)
>>>>>>>         return ret ? ERR_PTR(ret) : &bo->ttm.base;
>>>>>>>     }
>>>>>>>     -static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>>>>>> *attach)
>>>>>>> -{
>>>>>>> -    struct drm_gem_object *obj = attach->importer_priv;
>>>>>>> -    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>> -    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>>>>>> -
>>>>>>> -    XE_WARN_ON(xe_bo_evict(bo, exec));
>>>>>>> -}
>>>>>>> -
>>>>>>> -static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>>>>>> -    .allow_peer2peer = true,
>>>>>>> -    .invalidate_mappings = xe_dma_buf_move_notify
>>>>>>> -};
>>>>>>> -
>>>>>>>     #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
>>>>>>>       struct dma_buf_test_params {
>>>>>
>>>>
>>>
>>
> 

