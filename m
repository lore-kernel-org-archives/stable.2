Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22081E98EF;
	Sat, 15 Aug 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786807620; cv=none; b=ZC7amm5QiSXi6R2hG+tVaNP3s3K5/aOw3djP3z8jUmuxjC/A7GW6qeD96DUczqvBcsqVjQ7SQ6J6B3BWDBG8n2AzhhKi4Bpy7m5N3EdV1uVlW3ewHoWpsWxnuwVaWhOjAmtGn+H2gtw2Pn0+L9NGqAygDuDoQswS/A1mFFMRbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786807620; c=relaxed/simple;
	bh=/ipIDQtHs0or90afAsvSz4gY3ygs+KcFRqPO6KwxsGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsAirktx+Tm/oCgvMRakZtik91bGRh71ptIT6qsynYgXfaL/tilBV4qDlQdvCywC4hCKAWi6v5gV7bjE10kyc7F4VPlkTBycoieNlL77+nWVTCJujaqJNxztbIRRgTyERmplc+vxZuCjyHBi4LDYbQeF7G/qOWfAIlEPF176eTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nEeEAp1j; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nEeEAp1j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=6jlcF5KGjKl83YjQHqgob4GJvHyxgBtZCHiFFYhBNHQ=; b=nEeEAp1jVo/nBFG5CYDyLq+CM+
	evlAjHNuc+YEr79Cwccmrq30Rn1whsHwk7I0u7kpjNAIo9EyPWQ+AJgwMApX5jrL3bUSrIz8j+CoU
	Xnu/AzJJcCGd3Nli+e+qEYyu7z8sAQ2OCN5+JCHiWsJEDc3Cc8QEIIgZiBQW8dcLhejc2e3IX3EkY
	UQwtsYloojxE8BNhMcI1/2XHSPKYC2uZ7aL1eXMndmMh3vq2tpXAW43ed2z8sNNhZqbJuFx1/2dOB
	kTHFfYIM3NfpxCVEeG2bm9YQOmvkZPiKwyW4MSnN9P1LJL5OYkEY6VCAnI1H7zu0WS7lRQ2HBDgf5
	/jexyPNA==;
Received: from [179.105.94.163] (helo=[192.168.0.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wvGHT-002cLJ-3k; Sat, 15 Aug 2026 17:26:43 +0200
Message-ID: <d3aaddb2-b7f7-459f-b80a-e2c4f7b3d87a@igalia.com>
Date: Sat, 15 Aug 2026 12:26:37 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Fix NULL pointer dereference in CPU job cleanup
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260815145914.84154-1-kmehltretter@gmail.com>
 <cdfaab3c-89b4-470b-aae4-d16f7aaf18ea@igalia.com>
 <aoCEGJXl5k6IrhT5@gmail.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <aoCEGJXl5k6IrhT5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/08/26 12:22, Karl Mehltretter wrote:
> On Sat, Aug 15, 2026 at 12:15:46PM +0100, Maíra Canal wrote:
>> Hi Karl,
>>
>> Thank you for your contribution! Unfortunately, this issue is already
>> addressed in drm-misc-next.
> 
> Great to hear this is addressed in drm-misc-next. Is a
> stable backport plannend for this ?

ATM, no, as the fix was part of a larger refactor in V3D's submission
code. Have you faced this issue in any real life scenarios? If so, I can
think of a way to backport it.

Best regards,
- Maíra

> 
> Thanks,
> Karl

