Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607365;
	b=JDuNOm6pfrHBBI2NbkckFwFnGny2ow/+32QKQ+TyrYyR1tLhzCrrnBlDlNeIlDsTaOWk
	 MKEI4FllbsHRYhzDGbOuHePUX5prp4MxmPJHdlFiGSlTNXoRp1jWQdNf0tEKJSv48kN5+
	 hU0TVCJ1jdBP/cYm/66qQrRarv1AvFaVOjpCHd8wIZC1q4y8XljHrMVvptReuYLENAMko
	 TXOBeBGjJSD+sAzGRPsRVgrFmgRYElTYX0LPUD0NN44IOhF2+go5xVHbpFMESZG10tMIa
	 Hir+iy8Hlnqu3z+at4bXSAnT5jhnFq/3q7UUyyCLnBUla/+44XcNaRP47WVf4ErZ2dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=hLTZgrPRMvXWTx2mlzS40LX99kos2rQ4Fybij+QpVFY=;
	b=FV0vErbJjg+sjV6krSe+0Nmli5trSH3TDYYr0eXTzQIH6bFS4U782qQWoeW/vc7YvQW3
	 esph2a7UC0me09WP1t29+9pIml5zBaHvvu7ySE845IcZ0u6qhyKFELRoJjeKuRICcsgH6
	 529NgPvI+Wq2nVbj3f09E9yDr/P65Cc5LK73oBRClizy7cL/D1CtNEP2qV4+hC+rfz55U
	 Z4Gl1c4fKocSeQliRDNsj4gc0yxMBuVG00uK/eYz3LytXRCCjUHs4sCdo1IeeFU/T9/xF
	 6BPHdSNGfVxOWVtDapxxQr5NiLEH9b7pPdqgiy4adFUpEXa7jSGJPap4oNLeoDPvpCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MxhT712Z;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0519606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0519606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MxhT712Z
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-37000e7234bso2282105eec.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794607363; x=1795212163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hLTZgrPRMvXWTx2mlzS40LX99kos2rQ4Fybij+QpVFY=;
        b=MxhT712ZOs+9JNd48QhgsCPVX4B2Me3T9nNcqh3+3RQIFoeMHmW6Wl+WlG2eszHG7G
         W4bGVTq7kOwx0uGrHE749/Tzt6Y9ubwt7FDE57ZwQZaq+3mRm8NYBnSD32+sxDnpYi1J
         dgcSCrMRfotrVHqI5i3Kbi+QCZDRMIolbVs9aA+B1iC+BwuNhGViHLF3pMd8wHVK40kr
         JLrUUdyWvqq0c1RzBf2T6Dv00FUD++njrC800eHkQB4c5nh437/q9qqnhrvfqYN5tBqG
         O8kvLa0TcHNt6kJys2AnCLSbPPfn/+e8mL6WHWyTzfXZXIDcVL1HTOm9QCxHfoUZRXn9
         yLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794607363; x=1795212163;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLTZgrPRMvXWTx2mlzS40LX99kos2rQ4Fybij+QpVFY=;
        b=27sHCr9ltX5pzj6oYiyt9xDMB9aBsbXU9deVQGPVnztd2XkNyCEvDBriSOKEsQM7I+
         XhQDbN4ldkgVnfccUelXaICo7YZr1e1bk1jdm4ZQ2K5F8UQvligZegpvqyEQ7LkyXvWd
         Jvu0/+twgnE2CKI+aWWUzpYqitlg8Q3eNCCaW2cgY5oLxbpEbN0orQFkJuz/k5oJTO5H
         bqGu19mQLAIKMQVJBrdoi23HzJMJ4c+CoTj2ELhbpz/EF9+u0EPAxcZWGoug58bd+IHg
         +cpCxyhYH6LoNkAgS3CoBzGeNTa9jKsO9mHTcXdYvWZZdox9xe1d4m8fjSyLsh2t4L//
         DXlw==
X-Forwarded-Encrypted: i=1; AL+hErGMeMTUyh7Ln3Sxg3dwJX6IUvVXn/dDuBh5iX88yrJtFVtAJr/Rl0+g8mh9TiHa1i+PZ4gwPOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vElmXs8ho/W66wjzf1BL9F9LYVRx3P+zYgY/Ppweb3XVtnzvd
	7/N6B4hsdjuPcYKCKYJzI67nJrSPJIb2ye7N/m7I/AHe3xnDUH3D4IiVXDy/uLOeFzA=
X-Gm-Gg: AYBFou1L+opFQ8FYor47qQ0QdS70uzt2OYHRzrWbdUVOZw3CebTMkr2Yq2odfyoScCG
	EffXnLdeD+f0JxhstaKgto13n7caqGbmQSWPTAQcdrxx8aS3xmgmx4YZeBhDpYzsy9fizr9FYyR
	aW58QAmG09o4Thuer7YgvKV9/8fK93M96C7uv/K5HUqijcPH3hW50iVHy0LPIcmPhl9JfqKxGPj
	RNmbmbzQ2M4xX0N19OphCKFXoA2ZX7HxI2QtsGyOrAFKmsHM/O/43Or+LWLkl1Qv7kyGZvHOzVv
	/542BCi17Sl9q70OfZbgfTqxeGmuOwduKpeScGIfczvRkIkBtAgtMZs5v/m0LvD0ZmBEtbcctMk
	BcfQgfZExSY6moI8FAzpN+6Mvp6R+IpcUm82LAFrvhrCbHIP4ECy+wl9d/K7Ak3PIcEMlpkMshd
	laEmOt7Z8RiZ5gF1Qe16NA8x0eMm0u+sJhyJAFepTu0MJVUYPQCurfRhj+7N/M1yODH4BvG0tuj
	CBP3BysaSvNqFmzGiDwAp6aw7SUYfgDmUrrXLoqD7/d45OBVZsTDb5sbmGYQPaWxcmBB7AtyBXg
	MtaTS0MHtUPkziXb88WsClv02NeDlcbGaqCFsFNISbRR9IzeYbL7/Gm18cNe7tPVLMDgkCBkxk/
	gHZN9YWFw14FwMNFHU40lYlfyW6Y3HEQHWg==
X-Received: by 2002:a05:7301:db11:b0:369:fe4c:b48f with SMTP id 5a478bee46e88-3796047be6bmr3147605eec.0.1794607362850;
        Fri, 13 Nov 2026 14:02:42 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm16981662eec.21.2026.11.13.14.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:02:42 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Tejun Heo <tj@kernel.org>, Alex Kazinsky <a.kazinsky@ideco.ru>
Cc: Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org, stable@vger.kernel.org
In-Reply-To: <20261113110842.4189035-1-a.kazinsky@ideco.ru>
References: <20261113110842.4189035-1-a.kazinsky@ideco.ru>
Subject: Re: [PATCH] blk-iocost: Fix overflow in donation weight
 calculation
Message-Id: <179460736165.18529.16250644917025390352.b4-ty@b4>
Date: Fri, 13 Nov 2026 15:02:41 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 13 Nov 2026 15:08:40 +0400, Alex Kazinsky wrote:
> hweight_after_donation() receives usage as u32, clamped to the range
> [1, WEIGHT_ONE]. Since WEIGHT_ONE is 1 << 16, multiplying it by usage
> equal to WEIGHT_ONE wraps the 32-bit unsigned result to zero before
> it is passed to div64_s64().
> 
> This makes new_hwi zero, which is then clamped to 1, incorrectly
> reducing the cgroup's in-use weight to the minimum.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: Fix overflow in donation weight calculation
      commit: a56d5a485be4a9d52f0d7b3ed0dc3521367cb986

Best regards,
-- 
Jens Axboe



