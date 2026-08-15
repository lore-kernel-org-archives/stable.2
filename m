Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC535E944
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786807376; cv=none; b=LxCgAlSjg0C96t4uB6CTrZ6gC6xnG5DIDehX7xC/qEcUiRL9q43dZDgbnlfUmElicMe5uCc89dqHgeGdOzNetULYA37hYEpbM7zlBDitIDXME7Ij1uuYA1IqUM3DbFuvi0xZaDkkxOTCpA1DwFst7IkZbgLhxSmDsQCfR3yWmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786807376; c=relaxed/simple;
	bh=lvitTuLtgEEsksn5WwjYncAy64+0deXKerZUzQSy7lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXEtT9JRVuCOKW2DhWBI83zMW15RyGWBWYvW19Kiafrx+gAu/29zpID1ruNe+AZgxtULi4jPYU02cjfdqYbleYfKd79b2Mj0A4AbXlhzb6TrB2Jbvzh+3ppIS9eLpgKCCx+QbTxVV7OG3jpph8SulfmbHAVUb0P2V6hqRhwwaBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2jSCjz1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2jSCjz1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so21409075e9.2
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786807374; x=1787412174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ySDGKiW6KAfDEAKyZ+TvFma+gFzvsqvzjDXe1UcSZNs=;
        b=C2jSCjz1aLrjDx2nOp2eYkvFnE79A5WvE0WMFl9F1LyqLrjZ7DNe5v33ExbJ5HegcV
         pan4A08uDFDQOJ8ZZRAD0FP8yqJwpkWVEmA2ZsoPraGo89RnuoqJJuuLOrogUXxrRd/+
         eTnMnzsgCh2C2iprC5xN3PrcCA1RtAM9KvwuOs4nEEV9qumSEnu1C7ayADPgkmbB1boG
         9d82CEg23Bp7lIFhiK3FVqMwOQFZU+H4x6EVYChtcHY9q+gPspxRExFZy6gSJy5qEH0D
         9dL7BiODypT0OGeZSmNE34MWaUzsmuZRywHLyK9IvciVSIsC1jz/+ubb0DeTChGbbKUp
         VEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786807374; x=1787412174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ySDGKiW6KAfDEAKyZ+TvFma+gFzvsqvzjDXe1UcSZNs=;
        b=doZhnrQbsni24d5BU4LqHf/71hjb5nmJWFLswZOVTX6vvT7vTiFUHuaaO/qsw4UbC0
         WiH7hH9CA/UudT0A13bzIzsHsxqWXWUW8NZ3NPN5PfPIgO7wB9Hp3YOPT9PMvfBZEYw8
         mGTIjnA2Kubi3uzu5V3sWLzyUTNG9chlfsK3rcP9UZkpn/1O7lyvaH4yTcelcsxZjaOb
         ueO9uW6cIShINyJwgeUotvG0xJXcpakPxJRbg8hD+l5u+CUgLKq3EpGFudCezBhsNbC9
         xLB25BVueav8dhir1WWjkq1fA5y4RGxXeM2VXJaxJmz3GN1Dt3uuGgZz26qsyAyei4Ag
         E4vg==
X-Forwarded-Encrypted: i=1; AHgh+RpVLvuy4qWqAPLL6KXhg2ioo/MOSh2yL/mLZaLwCQdKjVeasT7g+Ly2bUJP/wX5VdLXkpOs6Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57Yc8RGan7pPW3mrGZsMhmcUHqyYnY1sPrBDlhH/LkSOzIZDD
	t18ykIhwEE6M8adq9z7S7Wcrqc1kFc1hn67xHwpaB3NoDJiP2q29GSq8rasZ1hkJ
X-Gm-Gg: AR+sD122mRvVN+7CCyUfakZg3JHX2XWEvc6WjthDIL6PFtEfdT01z/E6TGuYbihGylo
	7+W+hOF2Lgv5ELvAut2tla+K46k1yqZG5c00rRrsrQhiGEIsliOG67scvCxzKrMOm9t5CpsUaV6
	FQtzJXrcN6JDgNGam91gaWfxjU4sRuxq3Tv16WyW09VnO/+XRlY5WAGmFkdPF2WrpG2JfV9zbmq
	pPfKYVKFJvxPjvPT7Ztj6Q0RAimVeXudb4ugSTyt4UFrD9MatKjM139Xm63D5KnMC+Tu5VDAjYd
	0ym0agngY36+KslRmPK0s4bd8y9mfUztxCZy0i3mIi+o9IlR70V3NF2B72yn7AoGwbzL2iIAsl9
	OQdBXTSyzGJXkebSFqJG5FA/HKg8cT6MBAxjlwp6+MTty1ljPQPotNYte5XVENvRSDphD583/Qv
	+KedYMBYqiz/tRmqHPUAFEvV52rJl34LXCyNCTMgM7SeS+Kdzjfzz7Coy5yjjzJofJ9kDaU99dW
	MHLHALDktadgwbQqeXs/Ij3UnPEu422cqf6Xr49CHT1jvPs1vAAP7GOcx0I6odCGfSQpiJ47shv
	dqCmlPACYMj1IhO/oqvPc+RT7QCmbMxROBfMwwv7gzEZKtKzttnGFj3cb6FPlM03IA==
X-Received: by 2002:a05:600c:37ca:b0:499:858e:de42 with SMTP id 5b1f17b1804b1-49987935039mr195889625e9.6.1786807373788;
        Sat, 15 Aug 2026 08:22:53 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-aecb-d601-fc34-eb31-14a1-3704.310.pool.telefonica.de. [2a02:3100:aecb:d601:fc34:eb31:14a1:3704])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988af1068sm161216485e9.8.2026.08.15.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 08:22:53 -0700 (PDT)
Date: Sat, 15 Aug 2026 17:22:51 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/v3d: Fix NULL pointer dereference in CPU job cleanup
Message-ID: <aoCEGJXl5k6IrhT5@gmail.com>
References: <20260815145914.84154-1-kmehltretter@gmail.com>
 <cdfaab3c-89b4-470b-aae4-d16f7aaf18ea@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdfaab3c-89b4-470b-aae4-d16f7aaf18ea@igalia.com>

On Sat, Aug 15, 2026 at 12:15:46PM +0100, Maíra Canal wrote:
> Hi Karl,
> 
> Thank you for your contribution! Unfortunately, this issue is already
> addressed in drm-misc-next.

Great to hear this is addressed in drm-misc-next. Is a
stable backport plannend for this ?

Thanks,
Karl
