Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782670;
	b=HOl8QTwCpvXEF586qtOgega22H6Xpbdf3erfKd5bbpNlG+d4dKZsdNlcGwYCFoif3Wb4
	 mfhqARqXRVYPseSt4zVnKgyGMmpamCke3YYa+8Lw/XBN1yYiu7jxaBHC1S/3hItpyyct0
	 wYw2Asei67IuYaeSmpZydETE780f+/+MjdP4A0ijYo5Wxh3xBlrBgGz6taj9er7YtsFms
	 /Pz1UXyPZUvgKjb6PKyhQCmzhf92IG/x+CJ3wCjIIBzUd7L0erRnxNVkjjwhOGf2j4v+b
	 p2jcX8v9tpssDbBpo/s8I1Iz+cAvq2+e+mvuX+T0LH26+3GdhQjAQiT7Li6VEm1fEFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782670;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=XrZo1d0VK3d2S4vcBDTLf8La72OwD6eeG+6dxJojOjo=;
	b=4Ef63wvsS/uoAaq0A1zpcvxb3f14bvPyMh/6i/EqXVk/w3JIayzlxltC9JPLbhAY4zKt
	 y1tO0JLjOoN10lSuH0LcybUruq5tO0hPk/fU7TRPGJlayF2SzzLyYCd5OpIPUeuoI3ls6
	 mpLPkAInFDzoUs+pATNT9sWgIBR6myEAaCI5LuP1Bemd0RKx/5t0HfGx8HAIwEQUvODS/
	 DvGRGSlTt+4DWqReKdR9Vgz21tjJGn7gr2L8NZk3wjJNddhj66nN/A+pFmlwjxUBCsVlI
	 xTlV413l77r0M59P6JaqzRDu3HAGqq9+xhGWcMQ+cg/kRVTQhYwLv6yhbJNMRRUNWOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F8606A32D;
	Wed,  4 Nov 2026 08:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21BC1F00919;
	Wed,  4 Nov 2026 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793782669;
	bh=XrZo1d0VK3d2S4vcBDTLf8La72OwD6eeG+6dxJojOjo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=RGBeahcBoARoK21PSoLPjUX7rg1FCXcu7lcj+1caPPgrEqzURLA7z/mOPpVEfyj5w
	 MniBl2Lp1kMyVnNDbBdTWAfdXGXqWOMFFbuRrn3odE+DN9WahGMAw2PwLz8o/YYApu
	 m3hr0WVsyjQwmmKwPhhwi1z6NBu0QqK0QPSeLf8qXrXxlBjw9Y0p0atTdvr2iZff7K
	 0NXSy6+IQafNWXMwWTKUvWfbmhjX2mu4hi8128wPuNAGtvdb/S/jWJnbOcEPV3M5qR
	 iGcld4aGFbFYaDEez9eCGTCVbYiTF9qFnQpbcePtZCV0pVGRJSnWsVGbnk6GnHqm5n
	 RGbh1Q//86IlQ==
Date: Wed, 4 Nov 2026 01:57:47 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    zong.li@sifive.com, wangruikang@iscas.ac.cn, debug@rivosinc.com, 
    qirui.001@bytedance.com, guoziyi114@gmail.com, samuel.holland@sifive.com, 
    ben.dooks@codethink.co.uk, cyrilbur@tenstorrent.com, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix SR_SUM leakage across context switches
In-Reply-To: <20261022083212.84721-1-cuiyunhui@bytedance.com>
Message-ID: <c970ab41-a425-ce36-f801-cb6af00c7cc1@kernel.org>
References: <20261022083212.84721-1-cuiyunhui@bytedance.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Oct 2026, Yunhui Cui wrote:

> __switch_to() saves the sstatus value of prev and restores the SR_SUM bit
> of next with csrs. However, csrs only sets bits. If prev has SR_SUM set
> and next has SR_SUM clear in its saved state, the old SR_SUM bit remains
> set in sstatus.
> 
> This lets next run with user memory access enabled even though its saved
> SR_SUM state is clear.
> 
> Use csrrc to save the sstatus value of prev and clear SR_SUM from the
> live CSR before restoring the saved SR_SUM state of next. This keeps
> prev's SR_SUM state intact, while preventing it from leaking to next.
> 
> Fixes: 788aa64c01f1 ("riscv: save the SR_SUM status over switches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thanks, queued for v7.4-rc.


- Paul
