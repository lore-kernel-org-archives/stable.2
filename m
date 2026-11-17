Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794931980;
	b=2C6/hpiDRaQaSYFFSpdylwOSrRprWgXvlktUdJRTGISuBxfPP5Bk+FBngYM0sxnlmjK5
	 efnRp1mhIQHnQp8ETR/UMt7/5/FkKr6bFen+YHH6pbDGEH89VbhVohgTGD78DTg0X21US
	 joUuCbpueN/U/d8v6WS2k5lz4mtcpJlOIWM1zdewxjGfi2LLHVxWf7mCUa0aBQzaN3VKJ
	 ZUco0SvkLGFpBC8WKz+oq5xTiM0hFWc4vlkm3mCGQqdwS7PDk+WKxgNStSXdSiOB96L7r
	 ht8QWG+53nW6v8rkvhAPXn2IJVNXD8PEmKsZYc/BwpT9YwjYM8AJgDwQdWVPhLc5wCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931980;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ZohoMailClient;
	bh=BytRtfaLGfvvVXgsafcGA/NpSLeZVUmNdMkFX+1ckpo=;
	b=GtngPoPtkWlhAIxVn0ja4pg1F+SpbK6xya+YWhP7UCbjlEVCsRJDRjYhjODJby3MLPzs
	 cROvHnMR8JQTNkfjCKt5qyp/0Oej4k/MJh3SW5eiFd/Em9VRcvEfbZEARhqcbOb/RxvQ0
	 dNZRpectRFflPHl51DZ5W+RglfZegTb8O1SPCaUM0XwaNpnWCp37mjJT1nttx8Gbl5MVS
	 H1A5Vu2tKJdPuW90pIxpZeitM39YpRO079NMGf5BQJi4bYuq4mC4GQnqy/vqsrIfI31zF
	 3/JwrW/A6gHKn+JA8bc8AGZVT04prJSys1URsJkgoap1czxDLke8FVRTCbcv1f+71iQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=KEiFQFik;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C508606A31C;
	Tue, 17 Nov 2026 16:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C508606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=KEiFQFik
ARC-Seal: i=1; a=rsa-sha256; t=1794931963; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MgOHWAj5XE8K0ZM4dpF5XMNexXAnmpIJ22CkRU12AZeaADrNwrf8OuiBkMan97v+4uLxTDfvqT6rnk/gbSImUycf8qN1CEj58Te1Vg07vKVkf//wG3p1blxQMTYZtHG38XhdMHQ+LC00sc/Dmf/cLeyh3mR/nmYY64N9aEVv2So=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794931963; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BytRtfaLGfvvVXgsafcGA/NpSLeZVUmNdMkFX+1ckpo=; 
	b=PXEqmBBfDhf1y20KZ3gHWk099aQV7Ep39Dz+i1nsayC2euMeIn+J38/3wj9CjOixOs6JxeJ1hAoFAAvNMZAoVlskrtpinLSlfNXvrdj4N5REr/uELqCcBBm0TzKbSwA8ftJXP9oDu8vpzoBXQUSsoTpGp4HgdU/UTBpBtA3qAmk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=michael.riesch@collabora.com;
	dmarc=pass header.from=<michael.riesch@collabora.com>
DKIM-Signature: a=rsa-sha256; b=KEiFQFikCfWia1pepdG0mMUms+RTrMzQX4TKoDM56XmjS0YO7p7BWj4r1QpnapnWZkmFfesqh60i0aDy/sy82KlTjfXJ2F/B7sCGIpjjNKmuPWcd464PqsItpwS+KTtYWs6wWZZNAXkdcqQpP8U3zLmbdWP7L7nVQztmoU4TQz8=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=BytRtfaLGfvvVXgsafcGA/NpSLeZVUmNdMkFX+1ckpo=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794931960251635.8971346252681;
	Tue, 17 Nov 2026 08:12:40 -0800 (PST)
Message-ID: <55886a47-47a5-4f52-97d8-69b5142ecb28@collabora.com>
Date: Tue, 17 Nov 2026 17:12:36 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] media: rockchip: rkcif: Don't reset the hardware
 in runtime suspend
To: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: linux-media@vger.kernel.org, paul.elder@ideasonboard.com,
 daniel@makrotopia.org, linux-rockchip@lists.infradead.org,
 stable@vger.kernel.org
References: <20261112183208.2688580-1-mehdi.djait@linux.intel.com>
 <20261112183208.2688580-2-mehdi.djait@linux.intel.com>
 <df61d7d2-7ad8-4b68-b3a0-7a03513ab5b7@collabora.com>
 <avsBed-E2RPJnZ6k@mdjait-mobl> <avwZpcF8fti2vVI9@mdjait-mobl>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <avwZpcF8fti2vVI9@mdjait-mobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Mehdi,

On 11/17/26 10:09, Mehdi Djait wrote:
> On Mon, Nov 16, 2026 at 03:30:33PM +0100, Mehdi Djait wrote:
>> Hi Michael,
>>
>> On Mon, Nov 16, 2026 at 11:58:35AM +0100, Michael Riesch wrote:
>>> Hi Mehdi,
>>>
>>> On 11/12/26 19:32, Mehdi Djait wrote:
>>>> The reset in the runtime suspend also resets the VICAP IOMMU.
>>>>
>>>> When the IOMMU driver accesses the IOMMU registers inside the delay window
>>>> between the assert and deassert, e.g. in rk_iommu_zap_lines() to shootdown
>>>> IOTLB entries, the system hangs.
>>>>
>>>> Drop the reset and the now unused reset control.
>>>
>>> I agree that the current situation is nothing more than a crude hack
>>> that happened to work in most cases. But I doubt simply removing the
>>> reset is the correct solution. Recently, I saw some downstream patch
>>> that makes the reset a shared one, which seems like the right thing to
>>> do here. What would you think about that?
>>
>> Do you have a link for these patches ?

Unfortunately they are not yet public, but I presume I have to address
that issue anyway soon. May I ask you for a bit of patience?

>> I also agree that this patch will not be the solution that will go in
>> but the situation needs to change.
>>
>> The VICAP_GLB_CTRL register does expose this:
>> reset the VICAP(except MMU/AXI MASTER/REG FILE)
>>
>> The Rockchip-bsp kernel exports the disable and enable functions of the
>> iommu driver and calls them in the rkcif driver, see:
>> https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/media/platform/rockchip/cif/capture.c#L7269
>>
> 
> I mean, I of course don't think this is a solution to be considered, but
> this is what I found for now..

Yeah I wouldn't really like to go in *that* direction unless it is
absolutely necessary...

Best regards,
Michael

> 
> --
> Kind regards
> Mehdi Djait

