Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576203;
	b=qcHfV5smb1EddOHbhL49rDIDGlNxJVaRvsdmyJJhHfXBe7AytOMjCnuKNTM3UYtK1+96
	 aTrdkls5rBxsRy9+f7uC8ZZNbqxtsj6AahthtXmoRD2S9Z99ssAGeJo8GgtFmezTBGpe5
	 GE7rCm9uUpTuibKMUBIFuSVxeYckvNh7p+J72WAYIZY6ncIYPOBfRswBpCSTeYWQ88z1X
	 g8UrScPUO+n99SlORKVG211VxYLpJgNGlW5Q6y7b8T20u7RtiH7LhzB1+6GwzKcHFy1R/
	 NhvcG3NGdEqrmXBgsOjt6ESBZOTTrcPD8/G3RMSQQWVVYulfyCs3vw3Mv6qgqCMgTMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576203;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=G53IIIXhDfjfjxT9ZDHI2vAikXwb38otkA5QxpRYrN8=;
	b=T8uxsgD1VZiVk1jo4W7PpXa82T+n0umwYe+hhwp1gD8ZHI9Nttyflyr3O4wIGN9Y6qyR
	 AbtyL2OHk+rEuOGEozJHQX2xzkf6AyI1YJREqSl+lOf5iCsxvw9x6ZbxvBMT+RmRAxaYT
	 3r6vOynUh2CH0oR65pQ2ZFIHVpuS721tOZ0wGn83NnIDURFY1SIZ2wwiWlaqLklMlpW3S
	 krzEDFLw6ohnWIC/M6ak5KKzvoHh1PdGRwhSQOxVryQ5dY6QnK96XRgVZBO6eHLP/ImvZ
	 0oZ+cdVOr/wwvPN+IEE+CPVKIlubrDtA8t3wbjARiHTUrTrxpwSDzTvQju97F6YMNBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HhledqBj;
	arc=none smtp.remote-ip=95.215.58.194
Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46738606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 09:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46738606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HhledqBj
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VR9I6eMpxuCj5V9ollyYvyPkLG3wtvmTCmYpBpxiZ2o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792576200; v=1; x=1793181000;
 b=HhledqBjzKKur4GB7XnhRqxlnismylTJ8jxijNG+tr+PiZQp4dR7vte5aP1DJJr0sA58plYC
 fEiUbQHlfeMJ0k7QO6LY0whr+P/ngEVJ4X014VCRQp9ybqIf7vLTK9enKYJDeFO9Luht01YROek
 8wZvAIMyHaV9l4hZbijp1OZw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 83e3e21a2d7caf67;
	Wed, 21 Oct 2026 09:50:00 +0000
X-Mizu-Trace-ID: 83e3e21a2d7caf67
X-Migadu-Flow: FLOW_OUT
Message-ID: <2329ee64-f9be-4826-a496-65344e9a9c18@linux.dev>
Date: Wed, 21 Oct 2026 17:49:51 +0800
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
Subject: Re: [PATCH v2] mm/ksm: keep soft-dirty and uffd-wp when merging a
 page
To: Kiryl Shutsemau <kas@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: samarth.colleges@gmail.com, akpm@linux-foundation.org, xu.xin@linux.dev,
 chengming.zhou@linux.dev, peterx@redhat.com, rppt@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <efa6a28c-f0f9-4d1e-9cce-fec2c08e7d9f@kernel.org>
 <20261020055518.36087-1-lance.yang@linux.dev>
 <3da45e6d-2b46-4fff-9ff3-241f70d68296@kernel.org>
 <f6bdf823-be42-4184-87d2-fc7c128f4786@linux.dev>
 <68f17ee7-d272-4475-8a59-645442e2c210@kernel.org>
 <ath8JTlITYcXsyLg@thinkstation>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <ath8JTlITYcXsyLg@thinkstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/21 16:55, Kiryl Shutsemau wrote:
> On Wed, Oct 21, 2026 at 10:21:53AM +0200, David Hildenbrand (Arm) wrote:
>>> +1. Did it ever actually work there :) Why not just skip them and
>>> call it a day :D
>>
>> I think QEMU just always sets MADV_MERGABLE and later activates uffd. So that
>> needs some care to not disable them. So let's rather try to get it fixed properly.
>>
>> Can you send out proper patches? Thanks!

Thanks David! Will take it over next week and get proper patches out :)

> 
> +1.
> 
> Lance's direction is right. Unsharing is not an access: do_wp_page()
> already skips the uffd-wp fault on FAULT_FLAG_UNSHARE, and RWP should do
> the same.

Thanks Kiryl! Will take a close look at that :)

Cheers, Lance

