Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569597;
	b=2cQdEQBImkwT/ws7NSPqhzaaQnZKQzNpVd1TPR3jr1Q+YWL0BjcOtnq7qPz3mOg4VI2+
	 na+bM0bX8efRQHerhsKdJbQXVCwQ9xuePnsf5BwpKudtiPUv/z+59TFMq/eMVVG1hNZJt
	 HznORbmvUWvfjywbBnlHIj/1eTJgFkF6Nda64kGcxJ9MCyFTYgylvzlzZrPMR7vv2Lp1J
	 S+I/4V1f71lFrtLulM6JADVhHweymhRlDfrdNZzuEoL5pBytcCHd3VaPtmJj0DGeP4cDh
	 /bhF9x/FbKISNcwKIym+GjECJ9fsMRwwjSCYuVW+lMs6jOSPJ2ueoBq/ggG+HSHlV8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569597;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=kWV/Rka7apALZ8FQuu0KZSYeIdyVG7amVJeeN+9yJFY=;
	b=cujlG4zhIXnvBgZakc8fbWL2EpPTrQ6O0I6kTTQCTBLQ4159ylksXhKxvIAsNct6U8ra
	 yBeTCNuj7/+9g/VjzZ06mZYxa08CoYMYm4J60xHtCjwV5n/+aIbVVCMqWNfWi0jMgRxvq
	 FhlEG7MeNIoDWLHi81/i4IbY9JLslNWXBWhLp7O6gaVZ/icXEAbjHBc2lMOA944aRGJjW
	 jiR6EAoeVE4YTiL1zVnys+2LrT80OA4vktUTPPDwG9zWT+ijzfTgRKvdieu8rzA9l11iJ
	 wTw2pgpIw7t6xNp5AHPkN4BXldziiCRW4qI6Yxe6LoX4RP7lWllbIdsrN44yfDlFQew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE9606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89EE9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b315dd057bso5501847b3.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569596; x=1795174396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kWV/Rka7apALZ8FQuu0KZSYeIdyVG7amVJeeN+9yJFY=;
        b=Ih4lqHEesefNyFYADo+dTCaMlKm1NcEY18N5CZ8Q6YqogCD7DT81gzyjEwagWVbJnN
         INblpmwvsUvoa5X6kGYwE/yElvrNsdsho0vs8VlT55PyLBFiBCEZUgicxeLnEPXPuPtw
         sAkLLFA0kvNQoXTgkV7VphcpKsYRSDmaJ+jCvj5QxSPeCt71rumwkW4yiShKmP8exKyY
         w1LXIDze7K6N1M05ZX1+kdjBC+ILI+GVcK7ClrmNj8gAMe+aWG1Nfp9PucUsiKQ/MsUK
         Ex90L1APit28SY6NkZgiox+kx8YCXrF8ZA1GIzQt4GYnICR46a8yoikXxWntnfAPfPAT
         lGpw==
X-Forwarded-Encrypted: i=1; AL+hErFvN/hB4l9HO9DL+o4m2l9Ginot5cq0tUndb9Q6mGnbN5dHrcerfpnDNNZdiuKUfSMsjP6Hsws=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AUXmPokP4hTu80yNrH1FeyZDdy2scYQvQGoqqfsVKtwdRtSjR
	EPHslNvbi9+o5AgiuCRwOEifiicVVs0ddWjBJoRit7DgeW2nVLxnBcKd
X-Gm-Gg: AYBFou1TCyQm+47XMHZUxLfuxTw5gxLtfftJJTMyEIF/Rml8zwzjJpiNTE5Jr1HkCWg
	7eruYaQSoaqg7/vTViURPqlmzqkqz5TEpyeLUj3SB1H39xJvvwnkwymUj/JFho7RqTCCeV3BHP9
	BespoEAjg93AX6zZl9ZUsikUdwRnO0LzPEcy8wh75AWrn4mQLUySCn6lTn8ouT5eYYqx04W4j9j
	z3NML+usbK89U5MZt1yTJ1t934LfmoUM6gdkArxYGEk8JwJqrnutV/Uyd5mrYQ2/sxxxnx1NDEg
	haFJZLItGoYwEihU6dVntKPPnG92n/7WthBss41RbOM97n9PAShowGHweehKNiXccGg/nmWNFID
	Y+zpWAVXe7wzutVIzhAU6/ALpMkQNBaxQAQJvwDE0+E+bcgzocj2Rm4ipND7S9hkVPh2WlC3zrb
	zr/Y5erifF3ubGu8/NFO3qiRNT7EjkfD4S+cfjjpXzy06jSzccOXQOrzAJ+a1H+odDIhoSOKY1r
	4rMle8L1XcCtlb01c0wS5uKAQKyYvco+U1JWNRaEYWf4ft9BfLD8xRmBfY27t2ZDCzvi4NFt/Dj
	uETLutLY7geTYvkHZ9E=
X-Received: by 2002:a05:690c:e3c3:b0:873:5c0f:27c with SMTP id 00721157ae682-8b4aa319951mr15044427b3.38.1794569596541;
        Fri, 13 Nov 2026 03:33:16 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa958d0asm17666217b3.22.2026.11.13.03.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:33:16 -0800 (PST)
Date: Fri, 13 Nov 2026 03:33:14 -0800
From: Breno Leitao <leitao@debian.org>
To: Yuichiro Goto <goto@k-tech.co.jp>
Cc: a.hindborg@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] configfs: wait for pending RCU callbacks on module exit
Message-ID: <avb1CyLqJGI_MtXv@gmail.com>
References: <20261113033833.124797-1-goto@k-tech.co.jp>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113033833.124797-1-goto@k-tech.co.jp>

On Fri, Nov 13, 2026 at 12:38:33PM +0900, Yuichiro Goto wrote:
> configfs inodes are freed from an RCU callback: destroy_inode() queues
> i_callback() with call_rcu(), and i_callback() then calls the
> ->free_inode() of the super block, configfs_free_inode(). Nothing in
> configfs_exit() waits for these callbacks, so the module can go away
> while some of them are still pending, and they later jump into freed
> module text.

Is this still the case on mainline? Since commit 3bc999d944b3 ("mm/slab:
introduce kfree_rcu_nolock()") in v7.3, kmem_cache_destroy() calls
rcu_barrier() unconditionally, and configfs_exit() already reaches it:

configfs_exit()
	kmem_cache_destroy(configfs_dir_cachep)
		kvfree_rcu_barrier_on_cache()
			rcu_barrier()

so the pending configfs_free_inode() calls finish before configfs_exit()
returns.
