Received: from mail-oa1-f66.google.com (mail-oa1-f66.google.com [209.85.160.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D033FE0A
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789249494; cv=none; b=BdUGXhjebTZnM8MlW/tWhkz4XRJ6lYtFG0cA+R6nq+XRcyzVxi7zq1YUnmcfRu3Gl4xrpilwbxWErQ5J9UhY9nmXcWUCZvPSaDJJ9Wd0AEsf1MEqohXvTg6QVotIqjbRQtKFD92oWxonUs/h4igmJuDWm6GfbSYOVTD6udSRqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789249494; c=relaxed/simple;
	bh=kecUb0pDwLA3hY9/mqgnFWz1AIwI3Kabqzm0uxvNC3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAgUemQhdONtIVkbsx83tAy8DWJqVgldR557CfirNguueMN++2V3bQHvpxr9o+pajjxQvokhEZgSDg1YwOnXGUYS1Fil972lJEgwqDkAPbemIBzJGF39yiwheqIKMT6MOE/L292ibwP+Pc4Lnh5G8oqV4D22aV6EtDBrJRY8nYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT/ehlUK; arc=none smtp.client-ip=209.85.160.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT/ehlUK"
Received: by mail-oa1-f66.google.com with SMTP id 586e51a60fabf-46ac530b9ebso1602505fac.0
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789249491; x=1789854291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HhWhTVqsOkpUdCAWPzbi+pVqLfh+oq55gUD464xfMJg=;
        b=UT/ehlUKiXKL0Z1mhtYHh9tv3SrIK488nAFPWA4XusbWDpLxUAqAu62tLcKcAP4sjM
         rfJNefj7Lh49C3Tk9HWCm+fHL3rJMfU8sPY+FMlKx8Zjg1YX7f4Jz4JDKoWa5v/UoVeV
         P5luHM4ER618xOSMHGDWqEDzzFaXlq7k459EE/Q9ZgEsGZyaDN4KH89g8/MqaMuZP5si
         lGLfV8p8pvX+Qxyc8QZf4hnH41Darn8ogmTalIjdLmdPr3smcOr2uFw53wUQP3iuRsQa
         48jWCAsgXMWgnMWKl7QNZNdz+D6Q92y3RyjWNFhi0d83ECDYxbyTGZCp3JofxDkWs8tb
         ZE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789249491; x=1789854291;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhWhTVqsOkpUdCAWPzbi+pVqLfh+oq55gUD464xfMJg=;
        b=qWF8cLOyFM8+ZT8tz5uN+jwPtWEJRtgPR205AHcMt0TTrYLeRHUHaiB8WmQBU3UFGo
         znKJNRUcySClJVOcw4hE0F1CjBHgzs/rNQ88NgkLcfxr/D9PVv8gX2tdLW4ApTQqe4LI
         7yKEwO2IUMZ9RMiVgNG0tkMs4IVa1exZ0iYBQ5IPk+VlSFatsA49zoHfajjiRcuyGb3w
         uH/z1Mtb6F+Ijego2C5KaMCnZhnd3tAieKf8mKlISirwsZvqRbPNmG6wqauY2Gt87PGj
         DecKd1X8o5uX4GcO+5u2bL/R1EjLLlJ3z2P5TeEUELHlkGZIneFH1yz3TbM5XXxpbzvq
         WW6w==
X-Forwarded-Encrypted: i=1; AKwUvBzDZqo6nkrlcFKbxmkX2BMd8cFj92To6XZA2zHgYfkVpWcXvv9s8VXDzyO4tLilbb3UMLl9Nt4=@vger.kernel.org
X-Gm-Message-State: AFuF++m7Rr6G0Wz1p9UvOFD1A52AzAFYJDLui0ECgMWuGclYF7ghO6Si
	wA0x4vLshqZvpIN+r5ZDgAKWVK0+CrmsnNxDpxJMnb4a1rTmDY+vZya9
X-Gm-Gg: AYBFou0Z194nzFRw4WrOOJmG8amL+bOssV/xVRxAhx3A6VC+mv9qZscpZ5yUxiVpJ5O
	oDnfP2lQYMlr2D/c2cKMpbmboqCLjh9sP3J8pICBQj/+Yz/4RJyzE3YIBtcsPLPxa9svoL9tFqz
	76/nAZTIrH4/8fK2YrK1ibWBQcGxmcr/ijuP/8LRT/yyULoueINbF05vBWlH9DDXj3swTEROkPa
	W49v2RI+GQFxJf+E0PpP68MJX2MgZ4jfgu3mzsFkj11EmNzFM9nqr3aj8WOgYiyFadDVlzL712u
	ziKKd1z+6BNqXjjcb0Qy2bv4NsWueI32zJA0tyaHlN7mkGtvmtpchf8Ju3qktGcMpOBsbu63nP9
	prJSym4nn0ymoW82bZhaykCP7HbkGtKxbZKopDjiIhgocevdDoWe/n3EENWqFspTIml1ZuMhaV9
	h0W0eJ1phGWdfKpj78Lz0Gv3YRW9cszKcgUlgxpYPOmqZv5G+e/kkCXutZOUDDcgvKWX6kRWWhD
	0gZyk4kEQZpPZwHO5AjFiiXKcQ=
X-Received: by 2002:a05:6870:e89:b0:469:fb8a:b5b0 with SMTP id 586e51a60fabf-47c978e0ae3mr8164063fac.9.1789249491570;
        Sat, 12 Sep 2026 14:44:51 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::c389? ([2600:8804:5716:d800::c389])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df42b4699sm6246514fac.0.2026.09.12.14.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 14:44:50 -0700 (PDT)
Message-ID: <688b15d1-a85b-492e-ba1e-b4da548ebd06@gmail.com>
Date: Sat, 12 Sep 2026 16:44:48 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pci: Add broken-GPE quirk for Lenovo Legion 16APH8 and
 16AHP9 Nvidia GPUs
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Timur Tabi <ttabi@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, stable@vger.kernel.org
References: <20260821200607.621341-1-lyude@redhat.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260821200607.621341-1-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/26 3:04 PM, Lyude Paul wrote:
> On the Lenovo Legion Slim 5 16APH8 and 16AHP9, the firmware appears to enjoy
> firing a GPE on the parent PCIe port of the nvidia GPU very shortly after the
> GPU enters D3Cold. This means that every time the GPU is runtime suspended,
> ACPI firmware immediately wakes up its parent PCIe port, which then wakes up
> the GPU. Once it falls asleep again, the cycle repeats.
>
> See: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
>
> Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
> nova as well, and it even seems possible for this to happen without any
> driver loaded.
>
> This seems to simply be a bug. Luckily, there is nothing that we actually
> need ACPI wakeup events for on the GPU. Events such as display connector
> hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
> affected by this quirk.
>
> Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Co-authored-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
>
> ---
> V2:
> * Don't forget to actually use parent_adev with acpi_remove_pm_notifier()
> * Check if parent_adev is NULL (could happen if booted with acpi=off), just
>    consider it a no-op if it is.
> * Base the patch off Linux master instead, I based it off drm-misc-next by
>    mistake because I'm too used to working on DRM drivers :).
>
>   drivers/pci/quirks.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
FWIW, this has been tested by me, with positive results, on my Lenovo 
Legion Slim 5 16APH8. Not sure if this warrants a Tested-by trailer 
since I'm a co-author, but just in case.

In the thread [1], we have had another user report positive results on 
their 16AHP9 (note that Lenovo seems to have switched the P and the H 
around for the laptop one generation up for some reason). Said user 
tested on both OpenRM and nouveau on top of kernel 7.1.10.

This means we have tested 16APH8 on nouveau, and 16AHP9 on both OpenRM 
and nouveau.

[1] 
https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905#issuecomment-5444071160 

