Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E791DB95E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772535; cv=none; b=mB8Vg+3dYAnJ14uallqs6vxCyjgzUnJex8FwPU+7UzYs8RhmhMKxdUe0TZrmRa9BuhgIXnnrNRA6FKTz3UhDyg+4WBfxlcTRpvRvug2BT1foHA9fg/IEsDygDE0cBEDsBWES2tuUq2I5Iu4stoH3iQNrG/CLYEQqFsCAdnaPRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772535; c=relaxed/simple;
	bh=PoZ+z8P/Re+NlT4D+YmbbUbhcfBRKFIXe5/qVN1RLM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjMupmrBDAVp0Y01YlNHDbB3a3fHn7z3h3HmhZU5+LtlYeOuWWU3vBLhg5EkWPWtoaQGqDdg89kYnbF7cYRof96pVN6TMTzOjFeHsAczJnB0kvNf2j6cAMtci+PuMnou2gYeEEAfTs2Efybu7EzkJj3zdJGZrjUxwLndrwaDUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=HNvvUGO2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="HNvvUGO2"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so362743166b.2
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1788772531; x=1789377331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xBgijUTK0RaiV4bs4COhasChcigDnWDkUPfx1dw6myY=;
        b=HNvvUGO2QnrtHG6pTPuROEhsrc+QgrYc1Db+v9A9wVIbhCbdjBptgrsqVj+poHFX5G
         TPWie/uG6066SfHVtoR4R9iP+VOwnlvbsZB4BhVXwFjm5//lyv/RkPtfpPmTvibAEERD
         2IMa5risWX+T2uvRC4AidoFbM2sJBMgwJbPCUab/1/sLDsBFrrNKapkZR0DzoOryw3ix
         ahjs6pFx2S+pq7WWLfJNzSfhQX/F5PQr4TaF/HibxogBHD5Ik0eitOqh9EGhzNfSkdFB
         f5jaQJBq074CcDfonmWjJfIY2jzydpT/IAvLrO6eykc+UJKG49fk39nyfvZOt+0HIS2Q
         Fyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788772531; x=1789377331;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xBgijUTK0RaiV4bs4COhasChcigDnWDkUPfx1dw6myY=;
        b=SaZmX/a17Z6c1DIS5eI36MtDVprZosslqhAl0os+RrT3E1m8RnZfLVpRwVaMu4q0r9
         vwjKMTNVvz+g2O9lNBvGHswVbfWzVX/f/b6+kB6lJqLzOCwFNELluyfNz/TKsuTbu4KH
         lsDq8lgQ7jCWA6Wspqv+2DGXLHe2XLYqrL8z/NizGZFpp8fCCbeZTf5iavJSpuSpL7k8
         uYT2YaOGYjCVP60BwOknCc8ItOoAe9n56stZAPptH+7KneNcbhwNLi3qCDsAyvvUW0p8
         KIWGRxXFBiPr9KT7x74tHd8JAo6wVrvSdwm51uxKTihuNDnMu+U7hGlc/Z7ZNn9JElfV
         djwQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4JrsDwOrQQgwF4ghKK/YB96K7Qy9vcAkVXusHHvFaZ1+33pPXPE0H3WLfu4Sds+5Ywbs8o6c=@vger.kernel.org
X-Gm-Message-State: AFuF++kR+kSvWBVf+PWua0qiHhbjKdQvpSvBUhIxA7PIxryq8x/Tlizz
	bUEM4EF0XuehppHfskNqPzuDNaBw4Rg1X1Ko/wd6xFMBAs3AZ5UKzMZvZniQiTx4avI=
X-Gm-Gg: AYBFou0MWHm6t7G6FrKjnyWiZ7jRmjKAlzfJTiaoshpxiolIFIC79iTCql7GHq78tmj
	wPxjEaS/WNAVRciLiDxxpLTb0K/AlNEUmAuqVfpUSZaMFcomwdchwj+Os61zd5m9ACcnju6jn8K
	FrXWqmuQjMg5b0pnWxmUQuT/83fwjxpIcXngEp2/CQtAcCI/5apx6qn0AwxlG8nLOGjeZQf4QQ0
	YyqNgnSjWGNG4+FIc9YHDAQWEk4L3AKSzUCDvLxEM0kQYbBdah5eVdYdaJND3f74zXOp/7tGlYW
	QwJ5omQFuYJAriZ99knJCOCQpqeYq6UGJgsRiC89Ymkzauj8TaZnlAHEIGvD36NmGTss+KCoRi2
	br8gV18mbZsMZ4Ojx9aRJPtjFNjjL4ldojPArSUqHE8DJlo4T74kfJlWmUfNesXQARCiIO3Tyu8
	ylXY5CSeeq+XnJioEZzy4ewFeC+OeUJzUGGmO44Qx2JFY+KVyCwEeUsijb3jOrs4OB/O3w//ULs
	YpC
X-Received: by 2002:a17:907:d18:b0:c26:19e3:e98c with SMTP id a640c23a62f3a-c2619e3f016mr677971266b.44.1788772531387;
        Mon, 07 Sep 2026 02:15:31 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5b371esm443215066b.54.2026.09.07.02.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 02:15:30 -0700 (PDT)
Message-ID: <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
Date: Mon, 7 Sep 2026 10:15:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2026 20:06, Philipp Stanner wrote:

8><

> If you can think of a stupid and simple solution, shoot. The only thing
> I can think of is moving the string into the dma_fence, as a hard copy
> :)
> 
> 
> In the mean time, my proposal is to keep aiming for removing
> sched_fence->ops->release and fixing pvr and amdgpu.

Fixing the drivers sounds like an obvious thing to try indeed. Along the 
same lines as it was done for xe and panthor. It is an already 
established and well understood approach so shouldn't be controversial. 
After that we can discuss in leisurely pace if something better is 
possible in the scheduler core.

I understand its amdxdna, nouveau, and msm. Was it attempted so far? Is 
it significantly more complicated than it was for panthor and xe?

As for regarding the 035219a760ed ("dma-buf: dma-fence: Fix potential 
NULL pointer dereference") sub-thread - I did not manage to penetrate 
the consensus there - whether it was established that it needs adding 
the is signaled check back (with additional memory barriers, like v1 of 
that patch) or not? Regardless of fixing the drivers or what?

Regards,

Tvrtko

