Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EF429CEC
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323744; cv=none; b=iDRIaJp1yRaAVsJSATCVgvc1VC59fFgsxpIcCiouIJi8XCFTVtO5djZswCeju2iAZew+ZeF+PtFcX/obCm9nxyE95yqACRhaO6Jq2MvPCzY8N0FRB0xydOcOCsomCGL8D4NS07z0oBb7ckK3Jp+NIAEYv02ill4Ure/Qg+gh0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323744; c=relaxed/simple;
	bh=INT1Vtti3BreOEpeqwcIP3LbJxbbfHxuT+kCBc19nBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ei2NBuzUqAvrqgOp3P/I/aYAqsDSFGnkMi2U2d6bVT6SSbQVDsZgxx9mfxtxP6sID+n5Neb8Jn+DTIa/rsvSGXzSWA89rb2RBsRGEpJ4PB2FaSJtldtMGSDyD0tuqSC1z62P/4h8jmzdw2hw2/LaM7gEQyc2v+7FzEVlLuFHOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd1mxG0E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd1mxG0E"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso7447485e9.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787323741; x=1787928541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RySDzNgFwOZt+mpqx8aHwP46Unuo6yoVJSd8AB2W69Q=;
        b=Jd1mxG0EQoCfxnqNlou3th/dzKvBYDx2vwi359akBmUsvv7n4AQhNUWVdVdcAmu4Kr
         iDRyfuAj89Xsx6BZzdcl+wbI4eSIWMaBaLSd60xCLD7XxR/F3kWNvSYZLM9wO6Yhfq99
         e784neFqjrQXrArk68fvn1OYJqmB/PCgxC3bsD484uzxStibLwbxhX5NUMq+gwd5ckUO
         QjiDOMRZGFB47NgQBSsGQLppQ3XHKnLZ/AaDnMrynEULs6VwQ+U+HvKzisSXCj9NoOHE
         jG8d5+RXDx1cN8jBci7SxiU5GImFvdfD/tbCiYlQ9h9zUYR6Wnt4izHEHOhw2u7xGfWB
         3FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787323741; x=1787928541;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RySDzNgFwOZt+mpqx8aHwP46Unuo6yoVJSd8AB2W69Q=;
        b=o/9gZmPi1J3ptZ7uxCVpmxuHl5yJsNqXo2LBDcpYWVli/+c8v/RZ7jh44gg3w61J75
         7mTcBZOz6gNFfqio4mh5yYgN4fSet08uZLk5xN5kq68RHJjOmlQKc9xYa7YTdmp/FLuI
         F3KwqnYkk5IGr5V+odjC09w0gqjLA4wz8oQbmmN9+65DZRj85xg0YACg/A7Sn6pwwluE
         901/NR8dLqZBoOQ1/VSYj23h07zJ7Fi0t4vJMONEZWYPRZLt5NVk7xpAqfA0uDnld07D
         QWQWuzlUHrDDQz83+p1JsP1D8KxntXAsT1CDod8gSBAFR6mnpA9ApPTzGOKQv29QcHNl
         SH2w==
X-Forwarded-Encrypted: i=1; AHgh+RrdYhmkp/9WNYNJylX3fxbPjSHlmtOAUCaias2h0QA4Z7MWn5C8wHRzDZpyySaKfo5n8V42Co8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLb27atA81hyHPTR0/CaePmiWk/s5v7N6sdAA/lfHpOH8BVLMK
	RGlhPNyLo3/s/fHvGL3cW0ZOkAbHSJFX5dks86PpdF+sOMjPyPfe2ks/
X-Gm-Gg: AR+sD13xjUCstilHObDd2AacFbBC9gR/my2cwBXx2TfEKE3ZeGuUYQDPwkPfDTtjJ2D
	UUdCpdJTgbjq4uKwfpJDcyt+dWa5WGk22bUuOSDDg5Zqd/pF5YbX2e9OysjzQgYw0sW6Yt3JqpV
	X+s6O0ajydG3zrgaVQSkf0zCChZWciT/ObqhA+e9Maj5PvroISEpinXJNIkG+3yK5TPi+pNzWZq
	7YVpa/JwZW6CwNwTXxZHPP0AjUglSKrQPX9e6RDsX8UBA8BTAo9yKu6rIyDTntJix5cJ5FBMX0M
	WY5XMy4xu8nva9nyxQ9zTTVUwgRjdbjeRmgBwbhE4YDfXK9C9ouItTkAoTCudK8j7hIwu3J1xp5
	3iZ7pX5x3zd/8t2IY1Z4p2OX9vZcv4kyy2c99R57mgduPM2ZZGKUcp/Fj4FOhji2gHeuzhT2MgR
	J4M3h8AhdQ7qAbKQp2QD7dk0rqYppuKngvzrMAyUU22ToOugiE13TDAgpF8SSMFeyrrq+yPAsWZ
	O/lMfSOosaf9zIl474HgILDdA==
X-Received: by 2002:a05:600c:4f87:b0:499:5a50:b022 with SMTP id 5b1f17b1804b1-499b830d220mr94399405e9.3.1787323740952;
        Fri, 21 Aug 2026 07:49:00 -0700 (PDT)
Received: from [192.168.1.10] (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499be3a3e2esm10640175e9.1.2026.08.21.07.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 07:49:00 -0700 (PDT)
Message-ID: <3b85e6e2-29d0-43ea-abe2-246f1148939a@gmail.com>
Date: Fri, 21 Aug 2026 16:48:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Memory leak error in qxl unbind
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
References: <20260809165326.164763-1-megia.oscar@gmail.com>
 <2026080941-edge-lurk-2146@gregkh>
Content-Language: en-US, es-ES
From: =?UTF-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
In-Reply-To: <2026080941-edge-lurk-2146@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/9/26 20:19, Greg KH wrote:
> On Sun, Aug 09, 2026 at 06:53:14PM +0200, Óscar Megía López wrote:
>> I discovered an OOM after run the script below
>> (I updated it and added a sleep to allow enough time for the cache to
>> recover):
>>
>> while [ 1 -eq 1 ]; do\
>>    i=$((i+1)); echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/unbind;\
>>    if (($i%1000==0)); then\
>>      echo i=$i; free;\
>>      grep nr_free_pages /proc/vmstat;\
>>      grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
>>      sync; echo 3 > /proc/sys/vm/drop_caches;\
>>      echo 1 > /proc/sys/vm/compact_memory;\
>>      sleep 10s;\
>>      free;\
>>      grep nr_free_pages /proc/vmstat;\
>>      grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
>>      uptime;\
>>    fi;\
>>    echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/bind;\
>>   done
>>
>> The OOM isn't just a simple leak; it's a refcount corruption which renders
>> the list_lru fix dead code after the first mid-init failure.
>>
>> Here's the chain:
>>
>> Bug 1: ttm_pool_type_init() does not check return from list_lru_init().
>>
>> Fix: Check the return value from list_lru_init() and propagate the error.
>>
>> Bug 2: ttm_pool_fini() does not destroy list lru with list_lru_destroy().
>>
>> Fix: Add list_lru_destroy() after ttm_pool_type_fini().
>>
>> Bug 3: ttm_pool_mgr_init() does not check ttm_pool_type_init() return
>> and does not free pool if returns error.
>>
>> Fix: Move up shrinker_alloc(), check ttm_pool_type_init() return and free
>> pool types and shrinker if non-zero and return error.
>>
>> Bug 4: ttm_pool_mgr_fini() does not destroy the list_lru.
>>
>> Fix: Add list_lru_destroy() after ttm_pool_type_fini().
>>
>> Fixed check for an empty shrinker_list.
> Why is this not 4 different patches as part of a series?
>
>> This patch depends on patch ("[PATCH v3] drm/qxl: fix use-after-free in
>> qxl_irq_handler on PCI"), link [1] below.
> That's not going to age well in a changelog text :(
I'm a newbie. What's the best way to add a patch it depends on?
>
> thanks,
>
> greg k-h
