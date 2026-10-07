Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84274DD3BF
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401030; cv=none; b=Bqk+ntyJZD33qi6VmM23m1je8D3Q4eyVIPDZt0TCXGBtRxE2pxlNy06CCjah3ogSm+daMDpLeEHkUz6/Bg0NaseMATAIAJwp/BuaDh+EXqZjZUTvSaICpGeE/QurP5CpgfgdsARCQ4GVFMgyUoKR9a0cx8S+w8WvyEEDrvaa2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401030; c=relaxed/simple;
	bh=Y/YJ2pZCGx9u/s+xQBYfaDP04NWZxbzJF9hiZPjchc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DEqPAl1uW0HJfbPBsxV9qbLQ6ZEaM84oRKV6jdddTCyZ91P9AoXgt3mvI5cBMobp/kFhaUCUB73gT83vgicaXN+eTAS/ZF//Fi3km5iCwS5gqCmO0D7KdZV/SOXGeuM++HxEn4TPz5fbZCLCsYrYKzdsF1i8/S6cF/9jfBi+i9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=sFHJXTiN; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="sFHJXTiN"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-144f79153f5so1792230c88.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791401028; x=1792005828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RE39zueeiSHdMCMyMQenTlKwDLdMoj4zEmgv0Dvbh88=;
        b=sFHJXTiN2AxdD7md4ijrOGhq3aVkniAryea3gnvinLTq52Gb0XQzTcABk3VWNxRBZF
         BuXAuqt9Yv5NCbqjV8ERLvnXdCoukRtp4IFllksygayTw7YljuFjb9VUyQCrLbwf2X8H
         rwh1PRurhuyxIHoxnfuCCb5CJI8nsN+9rhpo4xXDUpUK83FS9VM2M+TagbXf5+cdbU6x
         eYOhZbneo8Jt09ufNfEhV94WHlmWQzV6SzdtglwuqoQiSqvvKLdQyAUOLXcVHZ73aGRI
         USbfmcJdpoq46E+wGLiO2YRnSbfBsGJleqkf7lsO39TPwNloXqy4DIsjN3CXJkr7oklN
         excA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791401028; x=1792005828;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RE39zueeiSHdMCMyMQenTlKwDLdMoj4zEmgv0Dvbh88=;
        b=BcVN9HMvnLVV3eV1ue5OYL2t8HwMJl7T5Ssa/svNlWaEn1hdUSM/LvyCqPn2azo9fD
         KQP/vmhRVd+8NfJhLRPZXh2tOEieRS5DNnU55IQUJ6XCQ6wyaIxKeha+YZL9t8e0Zv1z
         eiOGMOdY5sjOeA2mC94Jwd8KnRrnpqFV3P8KA0d/L8TduMhc8LPumUoXc1XKGom2tsC3
         IIN21xB2kJvDZF93+idyoE+SdNA/z1MtOo42p3LVx9lVJ/Mr66h2EarTmz4/5LyRL70U
         HAoSy+56EDkYYTyOlXNYNmf+1UGOE+dvWythwJh9qz20IcdomoL1BRMEJuy50LCeY+n4
         IOnw==
X-Forwarded-Encrypted: i=1; AKwUvBy/VxzAz4LFY8KWACkEgvqGuJAPIfYaoedWLgjqmg8EX3xZ1kNoqMFYzVUXMyLnhPncIs4cixk=@vger.kernel.org
X-Gm-Message-State: AFuF++nZUWtUZWQhZp6VewIHxH2s9sTxLCzbZKpoPTEbVw1lfxoW/Gi6
	E/rQgciCcQoe1OT9vhTmaJ9I8v+aczEkCyeZHIkMel6kb8Vuomfto6ckgmLqrocD1E0=
X-Gm-Gg: AYBFou3eDmr9AdiufGlRItc+lVtsJrea5cN8gAE3t2NcFxljXpqtJbwTEdK2B51vSEB
	7q26zIOwVyx40aIqplXcHRGFT53iD8G5XrjWiXK3sbiQwiP05B5jZTkBfZJq/3U6E1xY2pbKCXO
	xpFcZfS8et9Mk5+4oYSAYNnyh6M6yCkN21L7w7nXbWS4C7zRYMS6jilKZUqCC50KDe3K0kq4Vuu
	Yq0+6daURyfM+CaQhS51N1FnuYJ01KXgPhavKKL+O3ngtsCi90HRhg22NAu4mxRWblWby56Csai
	IjzV7kdw23f3s1P11xSfq/VuraciQVrr+OSd8t9EU/7sG6uqsrio3p4D9lo5C7QD0u09teMzWNX
	IwR0+irFL63Wk3/BTLocmZ/HRMNKSVv3bxj5kcH7nGbwoVAGPvZI03FLOtAxCmVPv+SZwnvUYG2
	Z/4aK/E1/t/qCNicNREAxR8zPf3x7xX1K7hR6FY2P7beXgJqXXLh5eK8XAe4fi0DpHi5JF+ICKE
	s6tYFhFQhWmM4fn4G44iw7IdA4gK3F7Byoof7kTGBcStPydth2kEva5RA==
X-Received: by 2002:a05:7022:150b:b0:151:7831:e403 with SMTP id a92af1059eb24-165a107a5e2mr204600c88.13.1791401027516;
        Wed, 07 Oct 2026 12:23:47 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16166216f39sm10538896c88.6.2026.10.07.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:23:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Justin Sanders <justin@coraid.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com>
References: <20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com>
Subject: Re: [PATCH] aoe: pull in the headers each received packet type
 reads
Message-Id: <179140102638.379040.10375002764067840013.b4-ty@b4>
Date: Wed, 07 Oct 2026 13:23:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 07 Oct 2026 17:52:29 +0000, Josef Bacik wrote:
> aoenet_rcv() only pulls the AoE and ATA headers into the skb head when
> the packet is long enough to hold both.  A shorter packet goes through
> unpulled, and aoenet_rcv() reads the AoE header from it anyway.  CFG
> responses go on to aoecmd_cfg_rsp(), which reads the config header
> after it, and ATA responses get queued for ktiocomplete(), which
> skb_pull()s both headers.  Ethernet pads frames to 60 bytes, so this
> mostly takes a virtual link, but nothing stops a short frame from
> getting here.
> 
> [...]

Applied, thanks!

[1/1] aoe: pull in the headers each received packet type reads
      commit: e1274a6bc40a4618f6fbaebbdc51cca865d51bed

Best regards,
-- 
Jens Axboe



