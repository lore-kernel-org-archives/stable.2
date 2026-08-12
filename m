Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A9364940;
	Wed, 12 Aug 2026 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555155; cv=none; b=dkNpIjjrXmeM3LKoxR7E3v2Gs9D9ZXpbn07Ou3r46rUhkjaX8rTxGj/PNjMn5E6Y+J2wLOQeKcmS0tekJK62ZJOCilYl6jh+DGXAOX1/h1T/6UIKxCA+WR1KFpjz5cVtrazWXR8c6VZy51df/G7cGMabs0BZ6J3Qigg0+1KB7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555155; c=relaxed/simple;
	bh=3YS1ZusdevBjmCTpSmFn4Qq/Zn5sapQpJOUo4zcMDVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkmCLTuu5SDcDaf08lh777TgqCX9BkVcqDw6B7/hm19yL1eiknjK+oR0gvxVbb2VCJbYzdGH9UcEBdGQ6Df4j8qRkkDV6atdAkoq+ysr58vR+sIOumAmSNB6tlxbRJu3+B19amX6HIHdM49jYUbYKvNiliEj15BHfAg5kLEK0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvBtKAEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvBtKAEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E0B1F00AC4;
	Wed, 12 Aug 2026 17:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555153;
	bh=SYkgTe9U7PCuLNS4PkwHrQsA4Z2XjuKKYm5CMTD3rm4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bvBtKAEAR3yWpHNNLIBankIqN4lTkT2uVfTLmTQ73vTioXDqDexjXsycG03smGzTD
	 f6TnU7lzt4+0LI+FkLDe3CUqRUzBpRUOG8ysWqlji9J0oav+CWNe8Bt76gwz/esqsg
	 niNeY9jBTO/SsEy/lXLKfpsuTG3DgfLPNcsSaEWG6BWU5w4AxzDUJ7BTUF7kPVOkls
	 BG8/9q1ST5phMZQFaQ9+CTpLJksL+yHXVNA+F8X6L+fkvVqsdlpHKpe12RCzf2gBkJ
	 3elTbKsBLolYPnsR5VmGUI9YjCU8U7qeq2uu4zQPjYpu4bCdKvI7L2bTReKAZG9QZ+
	 LBsr+LmQr+ctg==
Message-ID: <1a936439-55e2-498d-96bb-d9c1a1083630@kernel.org>
Date: Wed, 12 Aug 2026 20:19:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] media: microchip-isc: take a reference on the
 parsed endpoints
To: Balakrishnan.S@microchip.com, mchehab@kernel.org
Cc: hverkuil@kernel.org, sakari.ailus@linux.intel.com,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260803-balki-isc-prefix-fixes-v1-v4-0-f625d6aa0ae1@microchip.com>
 <20260803-balki-isc-prefix-fixes-v1-v4-2-f625d6aa0ae1@microchip.com>
 <2b1b9e00-a65f-436f-8ee1-b48c69d24104@kernel.org>
 <9d873c6d-f556-4f1b-81f6-5034ff087c98@microchip.com>
From: Eugen Hristev <ehristev@kernel.org>
Content-Language: en-US
In-Reply-To: <9d873c6d-f556-4f1b-81f6-5034ff087c98@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 14:03, Balakrishnan.S@microchip.com wrote:
> Hi Eugen,
> 
> On 07/08/26 4:07 pm, Eugen Hristev wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 8/3/26 13:20, Balakrishnan Sambath wrote:
>>> for_each_endpoint_of_node() drops the reference on the current node as
>>> it advances. xisc_parse_dt() and isc_parse_dt() store the node in
>>> subdev_entity->epn and release it later with of_node_put(), but never
>>> took their own reference, so the stored pointer refers to an
>>> already-released node. This underflows the refcount and can
>>> use-after-free, reachable through the camera device tree overlay.
>>>
>>> Take a reference with of_node_get() when storing the node, and drop it
>>> in microchip_isc_subdev_cleanup() so the entities the bind loop never
>>> reaches on an early exit do not leak it.
>>>
>>> Fixes: c9aa973884a1 ("media: atmel: atmel-isc: add microchip-xisc driver")
>>> Fixes: d6701f13bd07 ("media: atmel: Use v4l2_async_notifier_add_fwnode_remote_subdev")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
>>> ---
>>>   drivers/media/platform/microchip/microchip-isc-base.c  |  6 ++++++
>>>   .../media/platform/microchip/microchip-sama5d2-isc.c   | 18 ++++++++++++------
>>>   .../media/platform/microchip/microchip-sama7g5-isc.c   | 18 ++++++++++++------
>>>   3 files changed, 30 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
>>> index eebbcb28a7ee..ca4f3b5f58aa 100644
>>> --- a/drivers/media/platform/microchip/microchip-isc-base.c
>>> +++ b/drivers/media/platform/microchip/microchip-isc-base.c
>>> @@ -1853,6 +1853,12 @@ void microchip_isc_subdev_cleanup(struct isc_device *isc)
>>>        list_for_each_entry(subdev_entity, &isc->subdev_entities, list) {
>>>                v4l2_async_nf_unregister(&subdev_entity->notifier);
>>>                v4l2_async_nf_cleanup(&subdev_entity->notifier);
>>> +             /*
>>> +              * Release the endpoint reference taken while parsing. It is
>>> +              * NULL for entities the bind loop already consumed, so this
>>> +              * only drops the ones left over on an early exit.
>>> +              */
>>> +             of_node_put(subdev_entity->epn);
>>>        }
>>>
>>>        INIT_LIST_HEAD(&isc->subdev_entities);
>>> diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
>>> index 25d241b4c66a..532f2b50e2ea 100644
>>> --- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
>>> +++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
>>> @@ -357,28 +357,28 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
>>>        struct device_node *epn;
>>>        struct isc_subdev_entity *subdev_entity;
>>>        unsigned int flags;
>>> +     int ret;
>>>
>>>        INIT_LIST_HEAD(&isc->subdev_entities);
>>>
>>>        for_each_endpoint_of_node(np, epn) {
>>>                struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
>>> -             int ret;
>>>
>>>                ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
>>>                                                 &v4l2_epn);
>>>                if (ret) {
>>> -                     of_node_put(epn);
>>>                        dev_err(dev, "Could not parse the endpoint\n");
>>> -                     return -EINVAL;
>>> +                     ret = -EINVAL;
>>> +                     goto err_put;
>>>                }
>>>
>>>                subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
>>>                                             GFP_KERNEL);
>>>                if (!subdev_entity) {
>>> -                     of_node_put(epn);
>>> -                     return -ENOMEM;
>>> +                     ret = -ENOMEM;
>>> +                     goto err_put;
>>>                }
>>> -             subdev_entity->epn = epn;
>>> +             subdev_entity->epn = of_node_get(epn);
>>>
>>>                flags = v4l2_epn.bus.parallel.flags;
>>>
>>> @@ -399,6 +399,12 @@ static int isc_parse_dt(struct device *dev, struct isc_device *isc)
>>>        }
>>>
>>>        return 0;
>>> +
>>> +err_put:
>>> +     of_node_put(epn);
>>> +     list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
>>> +             of_node_put(subdev_entity->epn);
>>> +     return ret;
>>>   }
>>>
>>>   static int microchip_isc_probe(struct platform_device *pdev)
>>> diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
>>> index 998146adabd8..0b72a61b51ee 100644
>>> --- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
>>> +++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
>>> @@ -341,6 +341,7 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
>>>        struct isc_subdev_entity *subdev_entity;
>>>        unsigned int flags;
>>>        bool mipi_mode;
>>> +     int ret;
>>>
>>>        INIT_LIST_HEAD(&isc->subdev_entities);
>>>
>>> @@ -348,23 +349,22 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
>>>
>>>        for_each_endpoint_of_node(np, epn) {
>>>                struct v4l2_fwnode_endpoint v4l2_epn = { .bus_type = 0 };
>>> -             int ret;
>>>
>>>                ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(epn),
>>>                                                 &v4l2_epn);
>>>                if (ret) {
>>> -                     of_node_put(epn);
>>>                        dev_err(dev, "Could not parse the endpoint\n");
>>> -                     return -EINVAL;
>>> +                     ret = -EINVAL;
>>> +                     goto err_put;
>>>                }
>>>
>>>                subdev_entity = devm_kzalloc(dev, sizeof(*subdev_entity),
>>>                                             GFP_KERNEL);
>>>                if (!subdev_entity) {
>>> -                     of_node_put(epn);
>>> -                     return -ENOMEM;
>>> +                     ret = -ENOMEM;
>>> +                     goto err_put;
>>>                }
>>> -             subdev_entity->epn = epn;
>>> +             subdev_entity->epn = of_node_get(epn);
>>>
>>>                flags = v4l2_epn.bus.parallel.flags;
>>>
>>> @@ -388,6 +388,12 @@ static int xisc_parse_dt(struct device *dev, struct isc_device *isc)
>>>        }
>>>
>>>        return 0;
>>> +
>>> +err_put:
>>> +     of_node_put(epn);
>>
>> epn is used for the iterator right ? Why calling put here outside of the
>> iterator ?
>> Even if the code is duplicated it makes more sense for me to cleanup
>> inside the iterator.
>> Outside the iterator the epn should be unused, at least my take on it.
> 
> Sure, let me move the put inside the loop at each failure site so epn is 
> not touched after it. My intention with the err_put label was only to 
> avoid repeating it.
>>
>>> +     list_for_each_entry(subdev_entity, &isc->subdev_entities, list)
>>> +             of_node_put(subdev_entity->epn);
>>
>> Does it make sense to remove the entities from the list as well , aka
>> cleanup the list ?
> 
> subdev_entity is devm_kzalloc'd and the list head lives in isc, so both 
> are freed when probe fails so I felt a list_del is not really needed 
> here. Happy to add it though if you prefer having it makes the unwind clean.
> 
> Please let me know your thoughts ?

I guess it's fine if you leave it like that. If others have any other
opinion, please shout.

Eugen

> 
> Thanks,
> Balakrishnan
>>
>>> +     return ret;
>>>   }
>>>
>>>   static int microchip_xisc_probe(struct platform_device *pdev)
>>>
>>
> 

