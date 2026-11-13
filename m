Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537216;
	b=J5amJ4ucQsYLE4mMLF8qdwULkf4TSw0BN1k0Vzh0ca6KfwZR/RFT64fyyFg+8tJyxbAi
	 6kheGhskw+yUbzzQnlnsSMjxT3TQ3AcpYlMBHHOGlW3wFO0f+25q0qgqbq4VzOGPHjHX1
	 /pUPxCocW/39h87sqp0EBOI3hIG7EdZJtZDxG7Z7xXK3CVxZXKwdcHA9yez5gGIi4+sAu
	 jcAFL0Az3ppKIvPkgS7diieZXOxWWvf0FkFbTlvQjrdApTKWpdNuh5KKATcyDL49T3DEb
	 4wAMgqeIACUb1apvgz4obv+o1a0anGcrwLkAJPfTC5oSxWO4qUsV31c4UmU1aT4zl7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537216;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6D33yOtbOLNSF5H062ClkgQHsU3264MrorE4Gy8IuH0=;
	b=odLNziWenoEnjU5uZYHSdnxdvsMzE/st6lSydC5AoEqYKAq2fWeGExfj1+Cp9BUsE09U
	 /ZwXBTLRR5M/M9arp5SfE6+HchuSqkJJBIbiVcgKPvV7e//7tlnUugkKvCqw+yK9mem8X
	 HwRMPeEv1bP0uSrBnG+EUPUbpSqoexFh4MsDxFQn9SWhO0xl7Rv4P9jBOLifTCvDuYI5m
	 sBdo0bmOIKU85l5JS5y3Ig8BxDnQ2MuRDQuHeD8NPR7EfhDKyQ54ogoJJijGcQ7LjQIZX
	 4L+dlN9VZVnkx9i6EbpBONirzERrUxGinL3Yj1x0Lo1nSYMWnzz1XIckq+WnYocL25g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJggTztF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA95606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJggTztF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7849D1F000CD;
	Fri, 13 Nov 2026 02:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537215;
	bh=6D33yOtbOLNSF5H062ClkgQHsU3264MrorE4Gy8IuH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RJggTztF9xKOTj8InF3h1KRJ+B2pK2uMazI0SckjCCCIrL5QBKTl+evcEamv6I5V6
	 1k1S8MzUJ4x4HbPWUAKCojglkK2Ya1FHJVei790YaTFpUEwkIOZ7eh9Ff/QXlvS7xx
	 k5DCjgqa10G1w0/43VH5EzT/0vPuAzG9+YYhowuK76PakyBAu2MH79UoeHiN9UMofn
	 zyeVpGCIHKTYtn9svQIINrDy0lAXDmbQS+/2L4Bm6jJAKvpWEFAMYObeI18lV6Nluj
	 KcQtKX7No0xgBs4e/NjXRoq4j2tckAysYGQTeKUxUsYYnAhrZtM8OLTcD2mQLAsK5v
	 BuW32Gy14+NmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: Re: [PATCH 5.15.y v2] ALSA: hwdep: Serialize DSP load requests
Date: Thu, 12 Nov 2026 21:33:15 -0500
Message-ID: <daily-reply-2026-11-12-5937566686@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112013952.8019-1-25031212351@stu.xidian.edu.cn>
References: <20261112013952.8019-1-25031212351@stu.xidian.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-12, YuanZhe Liu wrote:
> [PATCH 5.15.y v2] ALSA: hwdep: Serialize DSP load requests
> The check of the loaded DSP indices and the call of the driver's
> dsp_load callback in snd_hwdep_dsp_load() are not serialized.  A hwdep
> file descriptor can be shared among threads, or inherited across fork,

Queued for 5.15 and 5.10, thanks.


-- 
Thanks,
Sasha
