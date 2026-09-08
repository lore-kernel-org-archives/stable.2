Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4290256E06C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884403; cv=none; b=cYm5D1nXh3oDUNdyWxBj9YG5gwLV2b+WJaEgiw6HsH6mWAjjj1wu6BVTzSApiah1QtS6jz2Xc0eCVLfiP/tBnr8e4F6DqszgBjhqRrty3A7JU6UiaSt41ASVp5k2FTh/N5AROcTm25/zx2w+Gzr0Le6X/3ybKTXIDFCC2lTGL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884403; c=relaxed/simple;
	bh=X/OoX1LRDdQm45XJJkw0SdbbigCXkL5MiOCHI3Hx2vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buaxTySkf/+73yzNNdVEm4S6fr3C2EvGOivgrzK7iKq0wDCp4dVsFkCVbnzblpyEzyaRIxPXeYjaWTM/fVS7mCgZNGlj1S9A9AF6Pb02e6IHm6gMGmVI40O8KnGCszBkXyveLU7ab2MIzI+zIauAXJFtMxPz9SAJf9g/VJQ/ZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koq7Qrxw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koq7Qrxw"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso3550354a91.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788884400; x=1789489200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sVQ0vLo+31t/EjL9dyStMFp5X3Ak22HAxZtAG3z1aAs=;
        b=koq7Qrxw2sz3KopT6/poVVEGqjidokbNC2fZOnsgwrz4PlTOHXrn5Pzia9nnKZb0JU
         PUO3YxXDiLPLjUjByOq4gr0h23LWFbp2s494bW/rfwL2DjIiQFZtmmbHGwSDmoGfH3mY
         r754oJai3HFyKZ48bhQrlm9c60fx2r5ddXJfJbAzEuovM2xLp6jB/cT/qdKoVt/u2FGU
         ffLxKCB7eFv+6DSJDFg7kcsw9EYnjGsT+9S9j+d0UfpKZxFBSIzUBsfi12EuG2lbFNvD
         UmiU5cBn5O4FzNWp2F9f/0x6YuIVMu9JedllgAlQ8ixrV/tp7rgSBT4ojCVwniugf+B7
         wYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788884400; x=1789489200;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sVQ0vLo+31t/EjL9dyStMFp5X3Ak22HAxZtAG3z1aAs=;
        b=AlVDiPoLbVt//Okei/oKMH5t2JeiVURVUMXHzJrR5aCAzYH8mBXS1KwRKTXuAeEnI1
         e7VA4A3TFP1VJzyqEY0VxW3eTWV0yhJsXTIQUZqyYer3ObtVcLy/CeSDPn6OH+sST7No
         EkKWL1Fw8RT4jg41VSWU7et6IXFj/p0NVvm/76SEijiPPcSZRZfhrla0P6C/ATr9zCBc
         O84F1s+D3/cXiv/1M2haOsd1j6CFDUj27I20xAdbrJHVQQpBqvUCEvcCGmg3zwzqEk23
         25H8r6s+jDbFP0ZF0cHtN73+HRmTN79YxUUqEnpO0LHp1cg4L5/mIw64hdlpkeSrprs9
         gKkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHvHmjf8Wk3/1q92iZ+gwejlrrXaoOzzRt6RIsOspxLy87tSUpSKHWOri1jI+Axy19LbynogA=@vger.kernel.org
X-Gm-Message-State: AFuF++mB/GSnSDCViKRp029fIF/3D7Q4Galdcd3r3rnxflfHHagnDRky
	bLbgByZJRDKHPqKZzNaPYp+hL4iNHAC8mfIjvcJ8VGdCx3WaRk4y4nUxDX53Ng==
X-Gm-Gg: AYBFou1pFuAqTua3t82UeLO/fHfgfWvVltwvIHZ6ZWFZZcoVqqbX0Y7E/YZ/FHf2BwW
	bGbXSNTH8r6Dz8h28c2BgQyWvdo/sqHNLQC/pAHKvzEk0U1e0yaaF1E4H+Pb2rzL80kMtsxXiPU
	6C2EfOw1ynIXn4MzfW/VEgqt8n9vyguevZ3tu1eNNsa+GK4Gl3YjXUAR4CA7G7iN4uZ3GAGFX00
	9Ap8NiFibJRxoKUGmR3N+9fMrP43kf7mGIBCaN8Mcwmom7FL3Cv1oHnMHp6DZiL5tQ6akpTP4dM
	WCR6d/0p985NZtSyiw2blUozdtT683DTouDoawonet4V4hHtK1Vtf8STQLgUQj2anEEDYpampzF
	NJO9ztLXjdvstRVUFjCQbWP86pP9N7BYY8/0u+47/VyEsFYbLu5CB0eC7krRUhiFvcjQUT3TXll
	pJQ9iXuF7KVpWg6fzt4IyFOEgZCMueuz3moSmI54J0uTjVtZv+JFkeBj05VD4NQE/hpOUPxuPjB
	w==
X-Received: by 2002:a17:90b:33c1:b0:398:9bd1:3214 with SMTP id 98e67ed59e1d1-39b262dfa81mr41629884a91.21.1788884400221;
        Tue, 08 Sep 2026 09:20:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b07b197a9sm32856991a91.0.2026.09.08.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:19:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 8 Sep 2026 09:19:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arie Miller <renari@arimil.com>
Cc: Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (asus_rog_ryujin) Synchronize HID command and
 report handling
Message-ID: <5476a2a7-77f6-42d4-a276-89f60841d9bf@roeck-us.net>
References: <20260904022129.97896-1-renari@arimil.com>
 <20260904022129.97896-3-renari@arimil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904022129.97896-3-renari@arimil.com>

On Thu, Sep 03, 2026 at 10:21:29PM -0400, Arie Miller wrote:
> rog_ryujin_execute_cmd() holds status_report_request_lock while
> reinitializing a completion, intending to exclude raw-event handling.
> However, rog_ryujin_raw_event() does not acquire the lock when it updates
> the completion. A response can therefore race with reinit_completion() and
> be lost, leaving the command to time out.
> 
> Hold the lock while parsing reports and updating their completions. Use the
> irqsave variants in both paths because raw-event handling may run in
> interrupt context.
> 
> Fixes: ed3e03790c5c ("hwmon: Add driver for ASUS ROG RYUJIN II 360 AIO cooler")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-hwmon/20260812104617.858D01F000E9@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol sparse
> Signed-off-by: Arie Miller <renari@arimil.com>

Applied.

Thanks,
Guenter
