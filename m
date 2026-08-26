Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73132B10B;
	Wed, 26 Aug 2026 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737579; cv=none; b=C0VIeBU8KQF67yyAXHJA8AfgXn8hT6xHoC9tWSxJMyD7jSWl54EXfiu/7X9oCzFCUs0eYilCEkRJGpoWaVSCcEJAOi65UUkDEexqF9kfSET/o5ulIXFi+0GOqX5EKown8pTHGBvQLqNn5cGWij0zVCobNxQ87FgUxm6oGQhAkUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737579; c=relaxed/simple;
	bh=+t2KcJ5tlM4+Pjs2MNqPtQte5b0m1yHKPB49s4VkRtI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H18CQbvlN4PwzH8V0v6Wm573lnEOK4emIXEMB1Fj6GRG8MMxEp+soV3djR+9IcMYkyXVE8mHd8RczlMUDoVV7Ls+USm40Vk68HJvO6B0bHXKoY3QJhkFNsjg0qQ5bOBGeNgK7q/v5Uhwuar9tv0ajX61+mUVcXq3CXUNUF00FdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ryNYs6k/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ryNYs6k/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=y/uf0Y1aBA/z9aveWUl9QUNJgPM8B4OYZLkqMImAs0A=; b=ryNYs6k/eiYAjrMc+IKVy9acY4
	wyEHIrnngXYa/3wKjYuv2yZY7sSzjIEfesk8Q5JR7DMW4/zjtpl8NYyoiljrhk4C9b64fEt/d8yZL
	8t3IBwm5L8BI/IyyofhH5fPnGaxdwKww8/e8mwyrLZt79XBpFS3YjbvCYvCLEOw9QPqbvEafVgTmx
	Dt633veWbH/kQm1XEcIzozlBoeWjtzP7WDKar2giLY1iXqa/XhwgjuZljDO9zB12nc8kE5jelEUQz
	XNGsrl66U+o5HycAq4eLo9TujqoWi4E4HAsZ++CBtvYvALKk/PNY1hIrqNNzLaRDY/BASbTA/+yw0
	HG3PPD1Q==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154] helo=[192.168.1.206])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wzACi-009SPr-Po; Wed, 26 Aug 2026 11:45:57 +0200
Message-ID: <9aa246b6-5538-46c7-9751-ad9732c561af@igalia.com>
Date: Wed, 26 Aug 2026 11:45:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Fix drm_crtc_commit leak if signaled when
 PAGE_FLIP_EVENT is used
From: Melissa Wen <mwen@igalia.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, stable@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com>
 <83e32ca0-56c9-4d3c-b337-a7c01199b4e1@igalia.com>
Content-Language: en-US
In-Reply-To: <83e32ca0-56c9-4d3c-b337-a7c01199b4e1@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/08/2026 12:27, Melissa Wen wrote:
>
>
> On 27/07/2026 22:45, Thadeu Lima de Souza Cascardo wrote:
>> Commit 1c6ceeee6ebb ("drm/atomic: Fix memleak on ERESTARTSYS during
>> non-blocking commits") fixed a very similar issue when the event was
>> allocated by drm_atomic_helper_setup_commit() itself.
>>
>> However, if the event is allocated in prepare_signaling(), it will 
>> also be
>> set to NULL in complete_signaling(), which prevents drm_crtc_commit from
>> being put in __drm_atomic_helper_crtc_destroy_state().
>>
>> Dropping the reference when the event is set to NULL at
>> complete_signaling() fixes the leak.
>>
>> The leak can be reproduced by sending a signal to the thread using
>> DRM_MODE_PAGE_FLIP_EVENT and using a sw_sync fence to cause the atomic
>> ioctl to block at drm_atomic_helper_wait_for_fences(). It happened both
>> with amdgpu and vkms.
>
> Nice catch!
>
> - Do you have a reproducer or is there an IGT test that triggers this 
> issue?
>
> - cc'ing Leo and Harry as well because they worked on the similar 
> issue and must be interested in it.
>
> - I think it should point to stable # v4.11+ as in commit 1c6ceeee6ebb
>
> Reviewed-by: Melissa Wen <mwen@igalia.com>

Applied to drm-misc-fixes.
commit: 4d4be202165e832d74849b4a68e289a2a377039c

Melissa

>
> Thanks!
>
>>
>> Fixes: 24835e442f28 ("drm: reference count event->completion")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>> ---
>>   drivers/gpu/drm/drm_atomic_uapi.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c 
>> b/drivers/gpu/drm/drm_atomic_uapi.c
>> index e997917819e8..7b951af5ab32 100644
>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>> @@ -1563,6 +1563,8 @@ static void complete_signaling(struct 
>> drm_device *dev,
>>            * to prevent a double free in drm_atomic_commit_clear.
>>            */
>>           if (event && (event->base.fence || event->base.file_priv)) {
>> +            if (crtc_state->commit && 
>> crtc_state->commit->abort_completion)
>> +                drm_crtc_commit_put(crtc_state->commit);
>>               drm_event_cancel_free(dev, &event->base);
>>               crtc_state->event = NULL;
>>           }
>>
>> ---
>> base-commit: d5efb1e1b1d7cd27c642654042f80d19a7ba3caf
>> change-id: 20260727-drm_crtc_atomic_commit_leak-4de5e75162b3
>>
>> Best regards,
>> -- 
>> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>>
>

