Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288118FC97
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306913; cv=none; b=qLpbzx3sVSsDWzZUcaqf2PlhXF0c74h+TVgN27B84DjtnwYeCiLVi1fnCvSZTCU+oxBy3ZSJHIp6Rl/HXrMnaHnn458mZqx2Ymti3p8oFrd3ncJC9+OEdAnJjDJVjwWC+B5VXtClFPORXiuONecpGV1Odog+mbjoFNlN5SClE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306913; c=relaxed/simple;
	bh=M0afn7yk3q3IP37rKqnNbVxopkaMvCGehO/GCuNGtbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcY5F9krrBiKD4jnWNR23ktD4Y/JsadOSRTNAGNZoDjoFYZUM3P5tzeXP+Yz/qpXgSd/QG3K5nvnaEHDNzFdJC1pj3TP4rBFepTUB3FO142V60bdqRNIPfuav1ys6e+qe4mASXEWn7rW+ZK7hza3SotvA4M1F6fbg9jJRyFjqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA5wPr46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA5wPr46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B3E1F00893;
	Mon,  1 Jun 2026 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780306912;
	bh=j2ClisWBsJN6oKxDvmkUZLOrb+GmAmbBsM5VjRJdbOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SA5wPr46OGRYVU+kDH9qwBFg/rH4gpCroiTWSeihbgTsuiEU4R0aTcKGgJb2UxR71
	 RRTZ96wWYy9zCNz0SMguYXIk0LmUcLFe1Am1SF4rLSyLgcRCbyAxod/GRglg/U/Ob7
	 W8CrpfR0jZbavsbOPYvjRMqWiDCdPbOgXntIsRDmF1fzGBX8ASon3dbvd7AEaf2P3i
	 X/b8IHYaMBfxN0cawKhFmOhOfdoFP8OdjO98cKzLuW6zU63M3UMyIyaGJurgctSlpR
	 R+pcucpFws+jFAOxlhV/3E0BTULsjQtSpaLW3GdTm1+uJ5CuI3Hudcsli3dzr5Et/g
	 J4OlVt091aVpg==
Date: Mon, 1 Jun 2026 10:41:49 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Gyokhan Kochmarla <gyokhan@amazon.de>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
	Sudeep Holla <sudeep.holla@kernel.org>, sebastianene@google.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: firmware: arm_ffa: Align RxTx buffer size before mapping
Message-ID: <20260601-spicy-weightless-chachalaca-a2aceb@sudeepholla>
References: <20260601092918.11031-1-gyokhan@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601092918.11031-1-gyokhan@amazon.de>

On Mon, Jun 01, 2026 at 09:29:18AM +0000, Gyokhan Kochmarla wrote:
> From: Sudeep Holla <sudeep.holla@kernel.org>
> 
> commit 0399e3f872ca3d78044bb715a73ea645806d2c7b upstream.
> 
> Commit 83210251fd70 ("firmware: arm_ffa: Use the correct buffer size during
> RXTX_MAP") advertises PAGE_ALIGN(rxtx_bufsz) to firmware when mapping the
> buffers but the driver continues to stores the minimum FF-A buffer size
> in drv_info->rxtx_bufsz which is used elsewhere in the driver.
> 
> Align the size before storing it so that the allocation, validation and
> FFA_RXTX_MAP all use the same buffer size.
> 
> Fixes: 83210251fd70 ("firmware: arm_ffa: Use the correct buffer size during RXTX_MAP")

Because of the fixes tag, it was already backported/queued to v7.0, v6.18
and v6.12. May I ask what was the intention of posting ?

-- 
Regards,
Sudeep
