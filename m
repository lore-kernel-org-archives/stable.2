Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1892EAB6F
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787438933; cv=none; b=Cghfpk+nZ5NG+CH8hfxiC9tdaBbcoDC+pq7lPkCHZxoObbXLqs9TitXl8QBttd66oStGEJWcjMRrY13vRqlmVnbyO8svsbUVTm2H6ar/aHsz8EMaXbCWDRkY4sB1FHTrlNxRss57AgjMYQPrf0+S2ZyOINazdE5lwIGb6L1PSEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787438933; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7YERRMfiV83wxq49WsuMripbQsXrFrgpxTTrRQpvlfcB6x47F4GeVYnwaWwrQjI6VoRWbDOZDyir1xerCoul7ukHI+k9qnuj0zUtIM14OoNSvqUtrLGdCLYBBIB+49jqRHHKmkdnDl6W5LxTKnU0UPhUKGJf01Rfr/zNJfpozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso3930631a12.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 15:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787438930; x=1788043730;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=rj1Vj9vQwDcKudnaAMCUMY8Z732o5bt+/qRhmcTvfUur+gRL1hxOBh4LU1XUbuIdjt
         uwkncH3zI1NLReV/xg17OQj7kbSTXSxu6P86CePMSDhg6cOgEJUiZAec0oCDbHb3dSbN
         H14f9rzQ22b0xAhS6TJuhiLYSaVtsSxa2LlRfg+mciooqLOwttuz1n4yiIdOLYDJE2wf
         BD2TTcKHddivSwa+bdvmNovmafEh1/kSHvNL3guvY/NkNx4Lkt7fkjLLn5zUze9v6UDg
         +JsSMXv2NyrT5VOul4zi2nwvBIoRSVE22aJs/+6FkVOtK4kNqT4nGH+XmMnQOq1wJZHg
         Wu5A==
X-Forwarded-Encrypted: i=1; AHgh+RpNrLg8TcEbxBUamUABK55IPDy3AGpi9MkUMh4/B8n3fpeZ8PFBRMwaxnykaFstddbGQNzGMg4=@vger.kernel.org
X-Gm-Message-State: AFuF++lbopO8s3Pol4OSphT+AURbgrZnj4NOg7OrOz7w7Wl5rUGul3p+
	j3Vs8IwHeSMCzuq/sD2PJDBzJPcrphcIwYKkIVwhbF3M9cocNaVpNZjR
X-Gm-Gg: AR+sD13aBcM/qrPBGzDlhP+x7LqlPhmpGAkHExEesYoU1sOQHp23d9QxBPURr8zXh4/
	YOjuXu4iwmrCQK8q/VpNcVKg1WEb6JgswJMImSVPpfQjjY+OSMOlwtT4cyDD3UwBj4lpVchOYGL
	YPHXCp5eDnerf3WBh/Xujx6DIlx1f3kxCtlHNOBVHHXhn3+xBKvJFbH95JJEzN23VdO/GusU6vG
	vuqmYANl2TWlXYLBeUv1MfZR6TvzCpf3QnLpLsM1np5pCo4NfSacuB6FfAr0XaiifxHdiRjK+IG
	UOVVGzMKHDR7yU481T7G/T3MM+XEh3RyCocqa3Z5hMAm9VdPHiDyCgQVCwp2Mjog4iegjjoVBbq
	MuLLZim/digS3Y7AxO8Iak4s3C50ZsySuOnqKf9terp5FIFSiOQjqxqBmi/lVsPqt1YHFGX1yRs
	noPzDk7aY7VHzRKEr3z9tspqjjd5e4Seqg48sanU842C6A1ijJyqSj6dPxD7xhh2IzaYzEC2euy
	dUnIqVrjgF7Bg/ahmCBdvw=
X-Received: by 2002:a05:6402:434a:b0:6a3:691a:9d82 with SMTP id 4fb4d7f45d1cf-6a582af951cmr9902892a12.3.1787438930544;
        Sat, 22 Aug 2026 15:48:50 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e025609sm76519a12.12.2026.08.22.15.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:48:50 -0700 (PDT)
Message-ID: <11176b67-6924-468e-b384-4702959e2c71@grimberg.me>
Date: Sun, 23 Aug 2026 01:48:48 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: fix out-of-bounds write when receiving an
 over-long PDU
To: Shivam Kumar <kumar.shivam43666@gmail.com>, Greg KH <greg@kroah.com>
Cc: security@kernel.org, hch@lst.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
References: <2026081459-handoff-wildly-eeb5@gregkh>
 <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
