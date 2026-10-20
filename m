Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792463743;
	b=bQuxc1iLFDXs4jRjZcNSnCklkpMoUAXOGOyjzewYCMPRtTWKum0ZK8nn6pd/wLI7Cv5m
	 vbtGOJ0bzu1/Zq9yHu4TPpVFdTmRzP9ZlZfAj5pC5fFT2HsmeVkL+ymM7rl2tuRNakkaE
	 cLN1pqmNEXF0/FUMANK9hq9OFhejfORCGlvXZQWt9mYHfuaxUop5dcjothH8V2n+zb1It
	 R2dlAlrM+y+7EV6agNNqxykxy/gyyAW57otLGjoTHM1gNzrEO4aXTapur7dIUsZHZ4srU
	 Z+dGVK70jBGF/qJMMrHfBMUWx3EL1aPXZ3tPru4zvytucnOwmdhuSBaz/MJAFNXMITQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463743;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=Oshdmag92sYPa4AKVOD9e8ufzckyZrK4kOUMn0bjT54=;
	b=h2b+lh0yKhMI0de0WWbzOHWoussBfF849u3VujMUY8t1V82xFxMqgxhabYrWYUXjVmbL
	 Wm+j0Oqf+fz6i5yxfD9Ttpk7HSvX7CyId3dwZg0x2c8qdFYpIOUuIA0HV34wEbLFcD5AC
	 MBD+rw3s11crSf1pD5TaNQNLIoW/2FenHEN+DiuQ9Arne2BT4DjHtwY2X9FjwNCE5/Jdc
	 fnMy8hz8wDe8yqcxsnXcm++7wJDUGAbTbP6nj5tF7TXnMsolu01WicUjaGVZn867F9u9X
	 X2k9LR1VSjfD04sY4g8dOskccDrDJV1bFMLhevwvNy0X7Ywn7gdm5XnMrW02QVW8gZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=YOizeYqK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7B606A319;
	Tue, 20 Oct 2026 02:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7C7B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=YOizeYqK
ARC-Seal: i=1; a=rsa-sha256; t=1792463730; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Bus5DKuSyjkOpB4sqTsSW3sDJ8eIJvtd2TBemq+FOikWerhd2vpljXgWf6V+HefHB6T2MS/qLWSOMNZTqmV90VU3VBca70FuPuOrfgcUNpjYGaXvSo+j2rYbTCX7Z1Oho66GbG1O8xuy+labeLwS2koVR6Shs8/M/5210TbQ7/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792463730; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Oshdmag92sYPa4AKVOD9e8ufzckyZrK4kOUMn0bjT54=; 
	b=EHXqWCLJfwcDAo4xrILyi9TWhkk4MIp1XzIyQbnsunUDrW0fKdG9PIAnXGYpe1wVc40fyDxR7w8Kn8Uv06XDekoNfZtBLvZN8ssEivhp7TttWi3MeuiPmydasjoqk072x8VaCI3RkTLZw2M5MAt7DG2BmSTVgLPFE8qceOn78RM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792463730;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Oshdmag92sYPa4AKVOD9e8ufzckyZrK4kOUMn0bjT54=;
	b=YOizeYqKrCcNrP4+GlWqNuebU1DTg12219dtEeyrFGoGog/yKJhuPbgxUqcwSZlm
	VqwzoSWsJJSot8TgVJSAg+AJnAFd1qCAfJ6iGKjkL4wnuLGxyVks4KCyCdfqaireDaW
	2Gc4EWDyfObhnQfKR1A9mDhUsU7ZiY3rJADr/YJI=
Received: by smtp.zohomail.com with SMTPS id 1792463728202780.2472059512872;
	Mon, 19 Oct 2026 19:35:28 -0700 (PDT)
Message-ID: <ada418ab-e8a6-46f1-8640-f33a7dac3028@zohomail.com>
Date: Tue, 20 Oct 2026 10:35:23 +0800
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
Subject: Re: [PATCH 3/4] cxl/mbox: Treat unknown device return codes as errors
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org, Gaobin Huang <huanggaobin23@semi.ac.cn>,
 stable@vger.kernel.org
References: <cover.1791949910.git.alison.schofield@intel.com>
 <3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com>
 <4bcc00ea-1586-471e-a51e-01a0d3f762df@zohomail.com>
 <ataFNPeoHJjiHj3V@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <ataFNPeoHJjiHj3V@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227c76c875fbc25410f2197970700005ac268b6dc53f1f67be34437c6994ea861c35ef39a09b7aa37:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/20 05:01, Alison Schofield 写道:
> On Thu, Oct 15, 2026 at 05:22:02PM +0800, Li Ming wrote:
>> 在 2026/10/14 12:17, Alison Schofield 写道:
>>> From: Gaobin Huang <huanggaobin23@semi.ac.cn>
>>>
>>> cxl_mbox_cmd_rc2errno() and cxl_mbox_cmd_rc2str() use the device's 16-bit
>>> return code to index cxl_mbox_cmd_rctable[]. A return code outside the
>>> table's range causes an out-of-bounds read, potentially allowing a failed
>>> command to be reported as successful.
>>>
>>> Check the return code against the table size. Report unknown codes as
>>> -ENXIO, the errno used for most device-reported errors, and describe them
>>> as "unknown return code".
>>>
>>> Found with a QEMU Type-3 device returning codes 001Fh and 0020h, which are defined in CXL 4.0 but not yet recognized by Linux [1].
>>>
>>> [1] https://lore.kernel.org/linux-cxl/20260929060747.3550005-1-huanggaobin23@semi.ac.cn/
>>>
>>> Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
>>> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
>>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>>
>>
>> The issue is not related this patch, but I found it during reviewing this
>> patchset.
>>
>> I noticed that the default errno of CXL_MBOX_CMD_RC_BACKGROUND is -ENXIO,
>> but description is "background cmd started successfully", I checked no any
>> driver code checks/uses this CXL_MBOX_CMD_RC_BACKGROUND's errno, maybe we
>> should set to 0 like CXL_MBOX_CMD_RC_SUCCESS?
>>
> Hi Ming,
>
> Agree. Fixing it to 0 seems like a separate cleanup, not for this
> series. Can you send a separate patch for that?

Sure, Will do.


Ming

> -- Alison
>
>
>   > ---
>>> This patch is independently applicable and backportable. It is
>>> intentionally introduced here as a lead in to the kunit patch
>>> that backstops this fix.
>>>
>>>
>>>    drivers/cxl/cxlmem.h | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index c401e3a1af06..357d0d873e87 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -6,6 +6,7 @@
>>>    #include <linux/pci.h>
>>>    #include <linux/cdev.h>
>>>    #include <linux/uuid.h>
>>> +#include <linux/array_size.h>
>>>    #include <linux/node.h>
>>>    #include <cxl/event.h>
>>>    #include <cxl/mailbox.h>
>>> @@ -205,13 +206,18 @@ static const
>>>    struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
>>>    #undef C
>>> +/* The return code comes from the device and may be one this table lacks */
>>>    static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
>>>    {
>>> +	if (mbox_cmd->return_code >= ARRAY_SIZE(cxl_mbox_cmd_rctable))
>>> +		return "unknown return code";
>>>    	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
>>>    }
>>>    static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
>>>    {
>>> +	if (mbox_cmd->return_code >= ARRAY_SIZE(cxl_mbox_cmd_rctable))
>>> +		return -ENXIO;
>>>    	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
>>>    }
