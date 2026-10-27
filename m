Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139009;
	b=Oq9cMXv7a3oTzEIIbi+N6BD3l8FdKpbNpW4nmOG2bNipAyXcSNyqWUNyWiYDhImXEWUT
	 829JSJchalcnMC0aTUO2VMGmnxbXTgaO4tH9apzaaZ/ITcLKuAoDwEdHXoQT2ZnXtM2NY
	 Qied9ZOeY1WIBTLTrrqm3V5qU8MXtdNe6Fzv6z2L/NXvAyyuX8b8Fm3D1W/aO/xbSEPWT
	 tRDXf8gmIcs60Viq51yV6xXr3HivYwpI+chYJo1VP2j10IcxTP7eLgvG1qnAjkdL2UwrG
	 8re6LwMMiYKEhFYrbFjVZ+fUxjtUe4QdDWEAFSAg+TPE8imvfdoUj3XcyUN5so/y6Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fT+qwxtE+A6GcMts/RFwLqPXWbldRP/ojd/gLikqx/o=;
	b=dHXua+3ryiFMpHZf02ZwZdjJN3T5IH/ogtZ9UUMbG4JLBC1TxP1X9ruY/BLJc3i8yed8
	 L0e09f9sqQRUvU5Ngnqrc5I6L5fEVceeiz7kWom5Zr8f5a77JTYHxAnn/AIut1+j7VZP/
	 qacIPRmt8gCdsekCZbCKAYRaifUduhz/1B0TmXAgmpEp+7Mc6hfLnNsG7FZ8fdsHCbVF1
	 gTQT3K3DWIlwfC6pJVL9z2abZ1osng08Kt9W4wKw/DJRdWAPjF4A4O0kciNbymt8ldPZ8
	 SS4WQXtoWrWNpvqi7j00WlkPNtANxe/iOgwLabHpvPD92lHqJ+UPMM5kS953bBFl9zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eK1fsW+2;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F722606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 22:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F722606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eK1fsW+2
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so3529765e9.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793139007; x=1793743807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fT+qwxtE+A6GcMts/RFwLqPXWbldRP/ojd/gLikqx/o=;
        b=eK1fsW+2JB+u32dztweW6UknefzXls1ygcl5CLm71Z1p1xr/SQRcK5omOGQRHtcZJe
         AvVkVl/9LOOkxYmhd1abAw2Mm8vOOTgZ1UWGFMO1pLl/MMTaF3XSy260n4/HfsRGpiBy
         JIpLGwoHQExszH0S+epY/KMiGEzSp37mYCQBpt9wYUat2ouWFbcsd5vgCRBiXuhzzqBT
         biomUCwj+SKLC4EhQNWqweICVG5qf43GhQQux8yfd9xRoCGPP2Xr8toiG51npBY3etq+
         zio8FAXRXAeRCiTxpt8NE+qiM7HLaqPjKUhzzFd8rnjlQKjHX04C3xjFWXiBKXVIV8vN
         XQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139007; x=1793743807;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fT+qwxtE+A6GcMts/RFwLqPXWbldRP/ojd/gLikqx/o=;
        b=L27ZZpeJ++TRxjsWjOVS/7C92eNjsWS0XFnjB5lR9puL3+CuBzWorGdYvBZb+nYKB7
         TpCB17NDAtuZN+QIeJT2xFrx7lx6Jf82dsMuR7qAK8PliwiCCFSOwEVZwjj+bej6CkB2
         oKc0mvXPoPLklO4lHcli+8BARVoKRF8vRzbqHuv3wR//InnT4ALl+aJFc+E8ykWqJFUY
         DEtOVfrdKQYnhyRWwh2h/XOv7cwIJ3T0Q5wXafedYBiXoeaGn0rtGe65/lXwmFtNMdBl
         a0gbDKgi1MV8y2cog+czwFgscWtXlygqimCQspICAlcogZBF15foGAOJwTnu7CjHqv9h
         VQLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzurvezDmaoDe2rW757f/cDVpBVVqbtY+wssvIWKQHE8SkMGCkRFvhfu/T1vmndOR6m5Yr9RNM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPDgs+yvRBy55YT2ltJVgPmE6N96hfO4MN7YjPpEKeX/rnAxZC
	ZJ66DwRAwwWl46FpjRQugbM/sKCmrMbSKyz+Ce1edfjzAKdHCCYJXLLZ
X-Gm-Gg: AYBFou3pUjWGo6CSlJ0BOyjaLVreCTD0FzVpJT/3+Rmxn+ELBhFCu5FsZgc2Soa4w4l
	SGnAJfzElZPnzy/GhKXxDjmoD3Y/7qOcKkPfrgg3ytU6v60dcrugLJaGeXbHCfnRwDyHEHMV9An
	dc+NrL49+HHIv5eB1jPpkcALGQBuYmVaPh9QJA5tAFzXQrmUrL0PSbza5VaaCAoh7y1FSkBDOC/
	KoBemCzd5WyP6ljD767srPV9CbyGoKyDhIvf3qJQ9MCXe3JJs1d1zLJdClibDCeExcyY8k7lN/U
	46H/ZkKLQUz9d5PVTCofkaSoGwttc1p5FbDV73amUhAcbRepzZ7XfP+LI0XRANlWOruXqB/NCbH
	w6Rsc0gp72HuchPPhO1WrPP8tvwhrrTwxxHcPm/QiZOab1ONMGkrvJhdehHsoD+jIMbP2nRn5XX
	whg2I4nwrV9US/Wec40fueUPrw+CvnBsSvSIYEQiIttHAZynFLJxcLlEkMi5o7qjqDvYSaH/EgZ
	+Vvcar/aUeeAz/8LgX7ObuGQZ8Z8Q+hjq4AE/vrJKjDQiXRvIHA
X-Received: by 2002:a05:600c:8b05:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4a967202925mr5734215e9.19.1793139006789;
        Tue, 27 Oct 2026 15:10:06 -0700 (PDT)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3555sm24526363f8f.42.2026.10.27.15.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 15:10:05 -0700 (PDT)
Message-ID: <968e7fce-a027-4c4e-8a3f-79ddf0b2ba9d@gmail.com>
Date: Tue, 27 Oct 2026 23:10:04 +0100
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
Subject: Re: [PATCH v2] fs/proc/task_mmu: fix missed VMAs when reading
 /proc/PID/maps and friends
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Suren Baghdasaryan <surenb@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, SJ Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org,
 "David Hildenbrand (Arm)" <david@kernel.org>
References: <20261027-fix-proc-pid-maps-missing-vmas-v2-1-2791cc9fc95f@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261027-fix-proc-pid-maps-missing-vmas-v2-1-2791cc9fc95f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 3:08 PM, Lorenzo Stoakes (ARM) wrote:

[snip]

> +	if (from_addr < vma->vm_start &&
> +	    vma_rcu_iter_may_have_skipped(rvmi, from_addr, vma->vm_start - 1))
> +		goto fallback_unlock;

the helpers make this a lot easier to follow than v1 :)

I re-tested v2 on x86_64 in qemu with KASAN, as in v1. So, this LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
