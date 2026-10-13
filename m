Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57334D1789
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884418; cv=none; b=dvJuMaMR1Oaz65Dv6kBfrnGCS2060fqfTusQD0OWuzulRiWjsM/JH+FF0P/E1JEIEb64bAhVdeL21woujNgcIMYNAibfQn4EI/03uxbRLOp4pVz4Cm+tH2szcDZ4d2g2o0ck0LxpSICw7pdYGDO7DxeiaaGxvkeKqe9v9z3NDAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884418; c=relaxed/simple;
	bh=oAFpMpQGn8mIHdC5lAwJE9nDrXyRnLuGZtUhqHxKjlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwcEW7r90RhWw6A64BNpjx5MbWFOm6TdiTwzM6CivRuaYMFDJfwsPWll64JgMIjvCzlLtqE9N/i4w/6sAVeW/oBygGrsSqUUyFClt7GbJY/pTWV7/cLB1pxz1aZHhvRzWoAydVg28Of1Qx6w6bqdoiXtHgQOuiJO/c54fHBDI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+XTnh2v; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+XTnh2v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791884417; x=1823420417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oAFpMpQGn8mIHdC5lAwJE9nDrXyRnLuGZtUhqHxKjlc=;
  b=Y+XTnh2vzoTDeW0DYWxcyx3I2JHHYVipoAFBd55sz9xhrAhpI8jsk3mJ
   CB2qrQkceDcU0jZy2AKUnWIJEWA7zup5O7/aHscVww92chOg7rjZh2pW1
   5aMIG7cNiiKbeA3gSol9ADvnUbrxE/42GAufgKQrIISiRFbkSdXutFR07
   iU7BuIOfSnO27OhGynXZ7iYU7Sz1akV+pWBVzYTaeUgxHzlb5IkLHEvwu
   6Aj3ay5BC0CEJlRzAmaDuId8WIIh/ilEOoL3vW1fvmicmsL6YxChwPIbM
   wlGVKKA8FutBckwS9UgMxo4sbmjTYMp3BDpXrmlAXV2gX2y5Xrsq8tk7q
   g==;
X-CSE-ConnectionGUID: gAz3DBrqSY+Cz8bdQIlu9Q==
X-CSE-MsgGUID: hZMcyimUQ3uHumkEi6gkfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="612715"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="612715"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:40:16 -0700
X-CSE-ConnectionGUID: B52BTN7MT32w2yshYLmNzw==
X-CSE-MsgGUID: tsXfLehTQwGOiQocOszodQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1444431"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.245.122]) ([10.245.245.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:40:15 -0700
Message-ID: <eaa812b3-d576-4d63-a9cb-c7c0ec24f19f@intel.com>
Date: Tue, 13 Oct 2026 10:40:12 +0100
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
 <16cfde6b-8881-4ffe-8068-9530286da72a@intel.com>
 <1a852df2-c2a4-48bb-84de-cdd4b98b95bb@amd.com>
 <d493d4d1-96d5-4194-bbae-5c1e5d54d91a@intel.com>
 <5545db90-3365-4d75-9fc0-77dda42b7000@intel.com>
 <2fcd10d5-c1f9-47be-9a68-422f9bbd6837@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <2fcd10d5-c1f9-47be-9a68-422f9bbd6837@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/10/2026 10:10, Christian König wrote:
> On 10/13/26 10:51, Matthew Auld wrote:
>> On 09/10/2026 14:02, Matthew Auld wrote:
>>> On 09/10/2026 12:38, Christian König wrote:
>>>> On 10/9/26 12:29, Matthew Auld wrote:
>>>>> On 09/10/2026 10:26, Christian König wrote:
>>>>>> On 10/9/26 11:16, Matthew Auld wrote:
>>>>>>> On 08/10/2026 12:17, Matthew Auld wrote:
>>>>>>>> On 08/10/2026 10:55, Christian König wrote:
>>>>>>>>> On 10/8/26 11:46, Matthew Auld wrote:
>>>>>>>>>> On 07/10/2026 19:11, Thomas Hellström wrote:
>>>>>>>>>>> On Wed, 2026-10-07 at 16:36 +0100, Matthew Auld wrote:
> ....
>>>>>>>>>> Perhaps Intel Mesa side should use tt-only for this type buffer (?), but since this is a kernel regression I was hoping we could fix this on the kernel side.
>>>>>>>>>>
>>>>>>>>>> Some questions:
>>>>>>>>>>
>>>>>>>>>> 1. Do you know what is the general story with p2p between igpu and dgpu? Is this a legit thing? For igpus/APUs, advertising p2p can't be dropped? It clearly seems to work though.
>>>>>>>>>>
>>>>>>>>>> 2. If this is legit, do you guys then also prevent p2p with display buffers? Are you just doing that at the Mesa level, or is there some magic in the kernel also?
>>>>>>>>>
>>>>>>>>> If I understand that correctly that the igpu is the importer and the dgpu is the exporter then yeah Thomas is right that definately needs to be fixed on the importer side.
>>>>>>>>
>>>>>>>> Ideas on how do that? Could we do something like allow_peer2peer = false in amdgpu_gem_prime_import() if this is an APU device, or further check if the exporter side is not amdgpu, like APU + Xe?
>>>>>>>
>>>>>>> For example: https://gitlab.freedesktop.org/mwa/kernel/-/ commit/7ec86c68b42655b4bb85ee90af434a617e7bec8c
>>>>>>>
>>>>>>> Is that something you would accept?
>>>>>>
>>>>>> No, you misunderstood me. Enabling P2P is perfectly fine for APUs and mandatory for a couple of customer projects.
>>>>>>
>>>>>> The buffer should just be rejected from scanout in the display code and on the AMDGPU side we already do that if I'm not completely mistaken.
>>>>>
>>>>> Reporter confirmed seeing the issue in windowed mode also. So I don't think it's just a case of rejecting from scanout?
>>>>
>>>> Then I don't understand what the problem is.
>>>>
>>>> When the dGPU renders and the iGPU displays you have only two possibilities, either the dGPU pushes the frames over the bus or the iGPU pulls the frames over the bus. Both should be equaly slow or fast, so what exactly is the expectation here?
>>>
>>> I assume the AMD APU/iGPU is sampling/reading from the p2p window buffer every frame.
> 
> That is not possible. The HW can't do this and because of this we should have a check for that in the DAL/DC code.

Yeah, I don't doubt it, but this was also without full-screen, so 
scanout buffer will be native on amdgpu AFAIK. I assume here mutter or 
so samples the window/texture from a shader over pcie.

> 
> It could be that this check doesn't work and because of low resolution and/or not busy PCIe it somehow works, but that would then clearly not be intended behavior.
> 
> What could also be is that the frame is pulled over the PCIe bus using the SDMA multiple times, but that would then be a bug in userspace somewhere.
> 
>>> Expectation is that buffer rather gets moved from VRAM to system memory when mapping the buffer with dma-buf, where it stays, and never negotiated to use p2p in the first place. I don't think p2p is really valid here.
> 
> No, that is incorrect. When P2P is available it should be used, it's just that AMDs APUs can't scanout over P2P.
> 
>>> What happened is that user updated their kernel and due to the MOVE_NOTIFY config getting removed and enabled by default on newer kernels this suddenly started negotiating p2p for things like the window buffer AFAICT, instead of moving it to system memory and keeping it there. On previous kernel versions the buffer would just get moved and pinned in system memory. From user pov this is a kernel regression, given the perf they are now getting.
>>>
>>> On AMD CPUs you allow p2p for everything. On Intel iGPUs we currently ban p2p. Maybe there is bigger question here for what is the story for p2p and iGPU? Should it really be blanket allowed like this? Should it not be opt-in with some userspace hints or something?
> 
> Again no, P2P is mandatory for APUs. We have basically tons of customers using that with AMD dGPU and AMD iGPU and that works fine.
> 
>>>
>>> The other important part is that even when you move to system memory, it's no longer pinned (MOVE_NOTIFY) so can you now can also get violent ping-ponging, which is addressed in the first patch in this series.
> 
> Yeah that is something which we have seen before as well. That should definately be prevented by the kernel.
> 
> Does that patch help with the performance?

Mostly it's p2p that is the big killer. Series gives much as 10x FPS 
jump, if we stop negotiating p2p for the window buffer and prevent 
ping-ponging.

For example, in GravityMark,  we go from ~18 FPS -> ~180 FPS, which 
matches the previous performance the user was getting. The ping-ponging 
hurts, but from the reports it looked like it was only in some games and 
not as severe as p2p. User confirmed this with CONFIG_PCI_P2PDMA=n, and 
that fixed most of the workloads. Adding the ping-pong fix then fixes 
everything.

> 
>>>
>>>>
>>>> The only thing you need to avoid is that the iGPU starts to scan out over the PCIe bus directly, cause then the frame is pulled over the bus multiple times (if that actually works correctly).
>>>>
>>>> Do you have a link to the original bug report? I was only added later to the discussion so I don't have that.
>>>
>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
>>
>> Christian, did you get a chance to look at this? Any further thoughts?
> 
> Sorry for the delay, I'm quite busy at the moment with AMD internal things and preparing a presentation for FOSDEM.

No worries.

> 
> Regards,
> Christian.
> 
>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>>>
>>>>>> Userspace has fallback path that when a DRM atomic requests fails for an imported buffer it falls back to copying the buffer first.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> At least for AMD APUs we clearly support P2P both as exporter and importer, but what isn't supported is to scan out over P2P. We explicitely reject that inside DC/DAL.
>>>>>>>>>
>>>>>>>>> And I'm pretty sure that you should do that as well. I'm actually really suprised that this works technically and doesn't cause corruption or anything.
>>>>>>>>
>>>>>>>> AFAICT on Intel iGPUs it will currently always end up with peer2peer = false on attach. Not 100% sure if direct scanout was happening on the p2p buffer itself, for the user report.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> Thomas
>>>>>>>>>>>
>>>>>>>>>>>> Assisted-by: LLM
>>>>>>>>>>>> Closes:
>>>>>>>>>>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
>>>>>>>>>>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>>>>>>>>>>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
>>>>>>>>>>>> GPUs")
>>>>>>>>>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>>>>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>>>>> Cc: <stable@vger.kernel.org> # v6.12
>>>>>>>>>>>> ---
>>>>>>>>>>>>       drivers/gpu/drm/xe/xe_bo.c      |  3 +-
>>>>>>>>>>>>       drivers/gpu/drm/xe/xe_bo.h      |  1 +
>>>>>>>>>>>>       drivers/gpu/drm/xe/xe_dma_buf.c | 63 ++++++++++++++++++++ ++++ +------
>>>>>>>>>>>> -- 
>>>>>>>>>>>>       3 files changed, 51 insertions(+), 16 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/ xe_bo.c
>>>>>>>>>>>> index 5065a7bac39c..e63437a261cb 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>>>>>>>>>>>> @@ -3658,7 +3658,7 @@ int xe_gem_create_ioctl(struct drm_device *dev,
>>>>>>>>>>>> void *data,
>>>>>>>>>>>>            * Display scanout is always non-coherent with the CPU
>>>>>>>>>>>> cache.
>>>>>>>>>>>>            */
>>>>>>>>>>>>           if (args->flags & DRM_XE_GEM_CREATE_FLAG_SCANOUT)
>>>>>>>>>>>> -        bo_flags |= XE_BO_FLAG_FORCE_WC;
>>>>>>>>>>>> +        bo_flags |= XE_BO_FLAG_FORCE_WC |
>>>>>>>>>>>> XE_BO_FLAG_SCANOUT;
>>>>>>>>>>>>             if (args->flags & DRM_XE_GEM_CREATE_FLAG_NO_COMPRESSION) {
>>>>>>>>>>>>               if (XE_IOCTL_DBG(xe, GRAPHICS_VER(xe) < 20))
>>>>>>>>>>>> @@ -4228,6 +4228,7 @@ int xe_bo_dumb_create(struct drm_file
>>>>>>>>>>>> *file_priv,
>>>>>>>>>>>>                          DRM_XE_GEM_CPU_CACHING_WC,
>>>>>>>>>>>> XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
>>>>>>>>>>>>                          XE_BO_FLAG_FORCE_WC |
>>>>>>>>>>>> +                   XE_BO_FLAG_SCANOUT |
>>>>>>>>>>>>                          XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
>>>>>>>>>>>>           if (IS_ERR(bo))
>>>>>>>>>>>>               return PTR_ERR(bo);
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/ xe_bo.h
>>>>>>>>>>>> index 1ddf3b6d4a9e..6965c2655731 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.h
>>>>>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.h
>>>>>>>>>>>> @@ -56,6 +56,7 @@
>>>>>>>>>>>>       #define XE_BO_FLAG_FORCE_USER_VRAM    BIT(25)
>>>>>>>>>>>>       #define XE_BO_FLAG_NO_COMPRESSION    BIT(26)
>>>>>>>>>>>>       #define XE_BO_FLAG_NEEDS_1G        BIT(27)
>>>>>>>>>>>> +#define XE_BO_FLAG_SCANOUT        BIT(28)
>>>>>>>>>>>>         /* this one is trigger internally only */
>>>>>>>>>>>>       #define XE_BO_FLAG_INTERNAL_TEST    BIT(30)
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>>>>> b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>>>>> index b973579a69b8..0a347f09cee4 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>>>>> @@ -36,10 +36,40 @@ static void xe_ddebug_flip_bool(const struct
>>>>>>>>>>>> _ddebug *desc, bool *flag)
>>>>>>>>>>>>       #define xe_dma_buf_p2p_debug_flip(flag) do { } while (0)
>>>>>>>>>>>>       #endif
>>>>>>>>>>>>       +static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>>>>>>>>>>> *attach)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    struct drm_gem_object *obj = attach->importer_priv;
>>>>>>>>>>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>>>>>>> +    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    XE_WARN_ON(xe_bo_evict(bo, exec));
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>> +static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>>>>>>>>>>> +    .allow_peer2peer = true,
>>>>>>>>>>>> +    .invalidate_mappings = xe_dma_buf_move_notify
>>>>>>>>>>>> +};
>>>>>>>>>>>> +
>>>>>>>>>>>> +static struct pci_dev *xe_find_parent_pci_dev(struct device *dev)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    while (dev) {
>>>>>>>>>>>> +        if (dev_is_pci(dev))
>>>>>>>>>>>> +            return to_pci_dev(dev);
>>>>>>>>>>>> +        dev = dev->parent;
>>>>>>>>>>>> +    }
>>>>>>>>>>>> +    return NULL;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>> +static bool xe_dma_buf_attach_is_xe_device(struct dma_buf_attachment
>>>>>>>>>>>> *attach)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    return attach->importer_ops == &xe_dma_buf_attach_ops;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>>       static int xe_dma_buf_attach(struct dma_buf *dmabuf,
>>>>>>>>>>>>                        struct dma_buf_attachment *attach)
>>>>>>>>>>>>       {
>>>>>>>>>>>>           struct drm_gem_object *obj = attach->dmabuf->priv;
>>>>>>>>>>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>>>>>>>           bool verbose_p2p_dist = drm_debug_enabled(DRM_UT_DRIVER);
>>>>>>>>>>>>             xe_dma_buf_p2p_debug_flip(&verbose_p2p_dist);
>>>>>>>>>>>> @@ -48,7 +78,24 @@ static int xe_dma_buf_attach(struct dma_buf
>>>>>>>>>>>> *dmabuf,
>>>>>>>>>>>>               pci_p2pdma_distance(to_pci_dev(obj->dev->dev), attach-
>>>>>>>>>>>>> dev, verbose_p2p_dist) < 0)
>>>>>>>>>>>>               attach->peer2peer = false;
>>>>>>>>>>>>       -    if (!attach->peer2peer &&
>>>>>>>>>>>> !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
>>>>>>>>>>>> +    if (attach->peer2peer && xe_bo_can_migrate(bo, XE_PL_TT)) {
>>>>>>>>>>>> +        struct pci_dev *client =
>>>>>>>>>>>> xe_find_parent_pci_dev(attach->dev);
>>>>>>>>>>>> +
>>>>>>>>>>>> +        /*
>>>>>>>>>>>> +         * There are perf issues with using p2p with display
>>>>>>>>>>>> buffers,
>>>>>>>>>>>> +         * like with igpu (compositor) <-> dgpu (exported
>>>>>>>>>>>> p2p window
>>>>>>>>>>>> +         * buffer). Probably we need some actual userspace
>>>>>>>>>>>> hints. We
>>>>>>>>>>>> +         * shouldn't really assume anything. Also, note that
>>>>>>>>>>>> some of
>>>>>>>>>>>> +         * these buffers are not always tagged with SCANOUT.
>>>>>>>>>>>> +         */
>>>>>>>>>>>> +        if (bo->flags & XE_BO_FLAG_SCANOUT)
>>>>>>>>>>>> +            attach->peer2peer = false;
>>>>>>>>>>>> +        else if (client && pci_is_display(client) &&
>>>>>>>>>>>> +             !xe_dma_buf_attach_is_xe_device(attach))
>>>>>>>>>>>> +            attach->peer2peer = false;
>>>>>>>>>>>> +    }
>>>>>>>>>>>> +
>>>>>>>>>>>> +    if (!attach->peer2peer && !xe_bo_can_migrate(bo, XE_PL_TT))
>>>>>>>>>>>>               return -EOPNOTSUPP;
>>>>>>>>>>>>             xe_pm_runtime_get(to_xe_device(obj->dev));
>>>>>>>>>>>> @@ -349,20 +396,6 @@ xe_dma_buf_create_obj(struct drm_device *dev,
>>>>>>>>>>>> struct dma_buf *dma_buf)
>>>>>>>>>>>>           return ret ? ERR_PTR(ret) : &bo->ttm.base;
>>>>>>>>>>>>       }
>>>>>>>>>>>>       -static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>>>>>>>>>>> *attach)
>>>>>>>>>>>> -{
>>>>>>>>>>>> -    struct drm_gem_object *obj = attach->importer_priv;
>>>>>>>>>>>> -    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>>>>>>> -    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>>>>>>>>>>> -
>>>>>>>>>>>> -    XE_WARN_ON(xe_bo_evict(bo, exec));
>>>>>>>>>>>> -}
>>>>>>>>>>>> -
>>>>>>>>>>>> -static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>>>>>>>>>>> -    .allow_peer2peer = true,
>>>>>>>>>>>> -    .invalidate_mappings = xe_dma_buf_move_notify
>>>>>>>>>>>> -};
>>>>>>>>>>>> -
>>>>>>>>>>>>       #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
>>>>>>>>>>>>         struct dma_buf_test_params {
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

