Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4737F727;
	Wed, 12 Aug 2026 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564515; cv=none; b=YPEs1pgE4/topKxq2nA9HPFHs82OgNOMTif1THfFFiYpp9vX2UtGBIDwpGH4/4mh/VQew79qFe0k4Vhnp09MshXw+MPGoC7hWCpFcbipZTCZeJOAk/TIkTLBKPyXwsu9BajZiLFV6yRh5nNM3ZpJexWnc45bnAhc6q4bymdTM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564515; c=relaxed/simple;
	bh=sSsjVgejOQ3vsOKImWO+P6Ro8o4Y80G6iYO0cH/fV+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZI4d5n53FOmRyzuavhqqIU/neP5lvm9Yf70cTbdKHDFqeT32+kVKWnVhlh+eiJFEByEFFy6eNCN4opS/1Viw3WMp4cGmMNjcGtOay3qKeKkqajLEXln1pk44WA/ucbqzsmaaXIe8lT76O2PdzgCjLr2vVSbcmZczKLID5ZmP6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/iQbQfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/iQbQfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FF21F00A3A;
	Wed, 12 Aug 2026 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564513;
	bh=6vEh9NqwDKBSnIi43Zm5xZUSnseA/QJF5Bdhw7NicVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z/iQbQfxLRZjAeqNOJaDJOFrGWjacxyqTMQQr/WWGUjEKejhXr0S/eAqdozl4+xTv
	 mAeY8UwCushSqDQgGdCbIr7Bzi9lP3I44JmflbZbe8T3YappqqGMkj+jTKD9Oc8mgw
	 LbJe/WntPnS07AdwlLTIMjLjA02jPod2Fn+qr+lSnKh3zJfcjOU7r15rsiRsVw3HIp
	 h3BniXSsgCHPXErNF8hjU5JBcwU0peVaqQ0cKlssbHr98KpO0XJyq5mUkQaNrwkIA5
	 2BqOQYU5zL/g7TIsSsHJLZvdDORF0PDZ0vcxMMVl1N8fR0HsfAexBjfhctW/B+N4D/
	 U7/J7Hz4/oAXg==
Message-ID: <068298b1-45bf-41ea-8be2-7a3e04f0a68a@kernel.org>
Date: Wed, 12 Aug 2026 14:55:11 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, Jammy Zhou <Jammy.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260808120934.2813010-1-lgs201920130244@gmail.com>
 <a5b4bb17-db2e-4bea-ae45-7bb3c5dfdf5a@kernel.org>
 <CADnq5_N0MVecwbKSJa9d4UFzagNzQJ4=qxGvVGFfvzDBOSMaMg@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CADnq5_N0MVecwbKSJa9d4UFzagNzQJ4=qxGvVGFfvzDBOSMaMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/26 14:41, Alex Deucher wrote:
> Did this ever land?  I don't see it in ASDN.
> 

It's on gerrit, but it seems stuck.  I'll ping you the link offline.

> Alex
> 
> On Mon, Aug 10, 2026 at 10:35 AM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 8/8/26 07:09, Guangshuo Li wrote:
>>> amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
>>> amdgpu_pci_remove() does not call the matching
>>> pm_runtime_dont_use_autosuspend().
>>>
>>> If the autosuspend delay is set to a negative value while autosuspend
>>> is enabled, the runtime PM core increments usage_count to prevent
>>> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
>>> during teardown, this reference is not dropped and usage_count remains
>>> unbalanced.
>>>
>>> The documentation for pm_runtime_use_autosuspend() also notes that it
>>> is important to undo it with pm_runtime_dont_use_autosuspend() at
>>> driver exit time, unless runtime PM was initially enabled with
>>> devm_pm_runtime_enable().
>>>
>>> Add the missing pm_runtime_dont_use_autosuspend() call to the remove
>>> path.
>>>
>>> This issue was found by manual code inspection.
>>>
>>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>>
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>
>> Also applied to amd-staging-drm-next.
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 1aed121f4ddb..e814701bc8fd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2548,6 +2548,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>>>        if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
>>>                pm_runtime_get_sync(dev->dev);
>>>                pm_runtime_forbid(dev->dev);
>>> +             pm_runtime_dont_use_autosuspend(dev->dev);
>>>        }
>>>
>>>        amdgpu_driver_unload_kms(dev);
>>

