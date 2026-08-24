Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DC409121;
	Mon, 24 Aug 2026 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569578; cv=none; b=YHohmUuhUWmLT49XKbIxpxW8TmEe3ZDz2go82O/YlUOFL/EHsPeVC6uFniR7qzSw9qd8HcgQzq2KEPkf/aFal/+rs4qBHGaprAf0ujwVOloUjfK991LWTF+iRFA/IaWxjIh9QTBMR0o4DviiRxiUkI/k6vt8sR/GrMP5VR98Uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569578; c=relaxed/simple;
	bh=cdNbg7ierzQ4SVqvczdngiZomV/AJvrAnFnUZFFGlVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYWwI/q6vKfxK0YYdVfoUBtElWNCX34X0y/FydCTm0CKbq0EHEu71HnVvielM0hdxhv8fulox5HsLeWl1BjsfsOKPvHqR/1gvI71VnC8sWgiHFQGHi2GK7lOpHo0jPnbW8B4VIfRTayZjqRxhPnMmPdeAxSjkucadtU7AfRy+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwV/J4Aq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwV/J4Aq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7E31F00A3A;
	Mon, 24 Aug 2026 11:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787569576;
	bh=YIW9cDWMhEnjUil/FTCyHPfyEMgCmBZe7DzJHN1+g9o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mwV/J4AqfZ7bGlyOcS6CjfOdHCZbZ/smQgCVNwcxgZ2Fiwpw+3OLWD4gtk83e4QId
	 FsQtS9OgtXG4SNhznzIcdn03DWmVHKukB/+b3voqdEmy+ZBbfPA0cWJHmPg1o7a9Ht
	 r8P5o8EDYBd5jCg8ekXEA5qfXdNHotU7jgAlyuL19WSVINyrD07U/5IwkQnpahL4wc
	 EoQ7MG+B+M+SVlCKDHuYIqnlDUOMBgI5SocFD2lH6YOE6luEIPi/MIYsv3m2k8ttvm
	 e0yHx9CfLAfYWc7H26T/B2HmE58wk7jCKW8G29sQA2JNw60tjsFIl6EoMi9kYbWmsH
	 osuWyKCA34UiQ==
Message-ID: <295cce78-47d2-4a6e-af90-696edb60a05d@kernel.org>
Date: Mon, 24 Aug 2026 13:06:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] thunderbolt: Hold a router reference for each path
 hop
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>,
 asahi@lists.linux.dev, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
 <20260823-b4-tbt-fixes-v2-1-26a18a426c9f@kernel.org>
 <20260824104237.GF893316@black.igk.intel.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260824104237.GF893316@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


On 8/24/26 12:42, Mika Westerberg wrote:
> Hi,
>
> On Sun, Aug 23, 2026 at 06:09:14PM +0200, Sven Peter wrote:
>> tb_stop drops the reference to all DP tunnels but does not deactivate
>> them, thus nothing cancels a dprx_work still in flight (which holds its
>> own tunnel reference) and the tunnel can outlive tb_switch_remove. The
>> HopID releases in tb_path_free then operate on freed IDAs and trigger
>> warnings like
>>
>>    ida_free called for id=8 which is not allocated.
>>
>> This can be triggered by unbinding the driver while a DP tunnel is still
>> waiting for the DPRX capabilities read to finish. On the Apple NHI
>> unplugging the cable runs into just that reliably because the read can
>> never finish right now and because the unplug powers down the
>> entire USB4 complex and removes the NHI device.
> Thanks for adding this.
>
> Is this behaviour due to something missing still on PM side or this is how
> it is designed to work on Apple silicon? This resembles the early PC way
> where ACPI dealt with all the hotplug PCIe stuff and the host router was
> only present when a cable was connected. I would kind of expect that Apple
> did this using "RTD3" way so keeping the host router present and the OS
> then deals with putting it into D3 and back.

So unfortunately the entire USB hardware is best described as horribly 
broken :(
For USB2 already we only ever receive a single hotplug interrupt in 
dwc3. If the first device is unplugged and another one plugged in 
nothing happens. The only way around that is to tear down dwc3/xhci and 
the PHY completely, assert all external reset lines and then bring them 
up again.
Upstream drivers/usb/dwc3/dwc3-apple.c contains more details in the very 
first comment at the top.

With USB4 this gets a bit worse: There's a block called "ACIO" (Apple 
Converged I/O) which can only be brought up correctly after the PHY has 
been switched to Thunderbolt/USB4 mode. This block has a co-processor 
which then exposes the host router, NHI, IOMMU, etc. to our address space.
We then have to write cable information into a vendor-specific 
capabilities register and only then do we get the hotplug event and the 
link comes up. This register appears to be effectively write-once after 
each boot of the co-processor. If I try to write 0 that still works but 
trying to write the value for the next connection then crashes the 
co-processor with a very helpful message along the lines of "assert 4357 
violated".
So there's no way around first tearing everything down, then shutting 
down the co-processor and the entire ACIO block and then finally 
bringing it all up again after the next cable is connected. I've tried 
to find ways around this but didn't succeed without documentation and 
could only reproduce what XNU does.


>
>> Take or release a reference for both ports of each hop whenever the
>> HopIDs are allocated or released to ensure they have the same lifetime.
>>
>> The KUnit tests allocate their switches without ever registering them so
>> initialize the embedded struct device there as well to make these
>> references work.
>>
>> Fixes: d6d458d42e1e ("thunderbolt: Handle DisplayPort tunnel activation asynchronously")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sven Peter <sven@kernel.org>
>> ---
>>   drivers/thunderbolt/path.c | 21 +++++++++++++++++++++
>>   drivers/thunderbolt/test.c | 12 ++++++++++++
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
>> index b2c322e76b8a..02c5e7a2101e 100644
>> --- a/drivers/thunderbolt/path.c
>> +++ b/drivers/thunderbolt/path.c
>> @@ -196,6 +196,12 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
>>   		path->hops[i].out_port = out_port;
>>   		path->hops[i].next_hop_index = next_hop;
>>   
>> +		/* Keep the ports alive, see tb_path_free() */
>> +		if (alloc_hopid) {
>> +			tb_switch_get(path->hops[i].in_port->sw);
>> +			tb_switch_get(path->hops[i].out_port->sw);
>> +		}
> I wonder if we can put this in tb_port_alloc_in/out_hopid() instead? That
> would be more "natural" IMHO.

Sure, I'll give it a try.
>
>> +
>>   		tb_dump_hop(&path->hops[i], &hop);
>>   
>>   		h = next_hop;
>> @@ -323,6 +329,10 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
>>   		path->hops[i].out_port = out_port;
>>   		path->hops[i].next_hop_index = out_hopid;
>>   
>> +		/* Keep the ports alive, see tb_path_free() */
>> +		tb_switch_get(path->hops[i].in_port->sw);
>> +		tb_switch_get(path->hops[i].out_port->sw);
>> +
>>   		in_hopid = out_hopid;
>>   	}
>>   
>> @@ -356,6 +366,17 @@ void tb_path_free(struct tb_path *path)
>>   			if (hop->out_port)
>>   				tb_port_release_out_hopid(hop->out_port,
>>   							  hop->next_hop_index);
>> +			/*
>> +			 * Only drop the switch references after both HopIDs
> Let's use "router" universally.

Sure!

>
>> +			 * have been released: the path may be freed after the
>> +			 * switch was already removed (e.g. asynchronous DP
>> +			 * tunnel teardown) and these references are what
>> +			 * keeps the ports and their HopID IDAs alive.
>> +			 */
>> +			if (hop->in_port)
>> +				tb_switch_put(hop->in_port->sw);
>> +			if (hop->out_port)
>> +				tb_switch_put(hop->out_port->sw);
>>   		}
>>   	}
>>   
>> diff --git a/drivers/thunderbolt/test.c b/drivers/thunderbolt/test.c
>> index 05652ee82fbf..034c56845380 100644
>> --- a/drivers/thunderbolt/test.c
>> +++ b/drivers/thunderbolt/test.c
>> @@ -33,6 +33,11 @@ static void kunit_ida_init(struct kunit *test, struct ida *ida)
>>   	kunit_alloc_resource(test, __ida_init, __ida_destroy, GFP_KERNEL, ida);
>>   }
>>   
>> +static void tb_test_switch_release(struct device *dev)
>> +{
>> +	/* The memory is owned by KUnit, nothing to do here */
>> +}
>> +
>>   static struct tb_switch *alloc_switch(struct kunit *test, u64 route,
>>   				      u8 upstream_port, u8 max_port_number)
>>   {
>> @@ -44,6 +49,13 @@ static struct tb_switch *alloc_switch(struct kunit *test, u64 route,
>>   	if (!sw)
>>   		return NULL;
>>   
>> +	/*
>> +	 * The paths take a reference to their switches and those devices
>> +	 * have to be initialized for that to work.
>> +	 */
>> +	sw->dev.release = tb_test_switch_release;
>> +	device_initialize(&sw->dev);
> The idea was that we don't use this as real device but if we go this route
> then I think we should call put_device() to release it and check for any
> subtleties device_initialize() possibly does.

Ack.


Best,


Sven

