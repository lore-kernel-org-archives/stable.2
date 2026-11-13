Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537229;
	b=nbw9vOIMKC/9RRSp2ExDnxBPf4CUOh7WTOo0dPAAmB0LFuYNSiw/IRdf1k8bACH4wvfd
	 E/42xOAQfrnFBdBtJv/mHpzyBvePw7rx7A03c+Jk0CPLDc9tvgmcQLQGlHt6gOcsdeWuf
	 c6fbpPWiWqnaPEmnywsxVg5rBR+LlOYxhP55GZXlydOosJCoRT5e8v/HvYLWZfZM9kVBx
	 GYEYM2sCfX9jbIEG8S59q/dFk+rhbB3UeVTVvcupCjQ6J2pe7DL34QdN47uv+qsyMvJ9f
	 vChZT/R1TDIg5DAYhqhyxOZjJqqCjTll8ddCFVrTxQYPg4SCETiLk1GE1+bm6TgjbhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8yNaL1Ds4jqJnc35H72MqYm7Qrv9lxSIrL/fpuBv0nM=;
	b=0rofPOfIKEiVkv/KHLbRS0xhCCu/1eFmD7Fst0VWxDFJtWTecID7xX0XVPXN/5VsT595
	 nrBYF30j3NgGK9NlaN1A52Lz+cI0N5mkg1KCdqY4vpnJC9PnxOjZPelOYnTvQ2LwssClR
	 /guAlYbI23CLUyi5YxFFv1ZzX/CUrT6iwuztUUDZ1Ss1YmmH3r5BZpa5u0UEizQLYqdx+
	 5K7CGVIOTRM63ZszY2E/tMdbQM9phnHyIcbYTbG13i6tuKtRUbAh7DzTgt35T3OzDQ44y
	 J0Sl8Pd77U6PLMeFdTgnyMEKLtkqlN0TFvXD8BwFXUED6OY8DyRcDqWIX0rz9lW2x6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMZFV2xS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85325606A335
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMZFV2xS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888B11F000C7;
	Fri, 13 Nov 2026 02:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537229;
	bh=8yNaL1Ds4jqJnc35H72MqYm7Qrv9lxSIrL/fpuBv0nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YMZFV2xSSA81WDE/ZsgqRBQx22sUJWh7DxssTmHibUeIkKDt3wh/DPxUM8hTBoWts
	 XoC8I5A6OWr8s7vDNqEGf/Q0Ou2o8zRfYsIW4QhGhfcHxPhT4UWZTVES7jOop5WCzv
	 AmZ+qN9Qv8whPRX9oHWjgW5vaz8A7zYxyu9Yz+MuvvVO6eNulktX1VrrwLPWOUu8Cr
	 gRTicSrvtMU5Gw8+WS0r+CZ8vMiZq7gEZj1s+w+BEmas6Q1DsOdTMr6KvBMzr2mupJ
	 ZJhn53uKB/uwXZDs5ZwzSVbWLbBSmFOuRxT4g9vN8v2DCnlpVdXhEwPFi+Xp8Hdt2Y
	 Qd1rRuQurJehg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amir73il@gmail.com,
	mason@kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: Re: [PATCH 6.18.y v2] ovl: fail the mount if the casefold flag has changed
Date: Thu, 12 Nov 2026 21:33:28 -0500
Message-ID: <daily-reply-2026-11-12-66403086@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112122500.6344-1-dennylin0707@gmail.com>
References: <20261112122500.6344-1-dennylin0707@gmail.com>
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

On 2026-11-12, Hungyu Lin wrote:
> [PATCH 6.18.y v2] ovl: fail the mount if the casefold flag has changed
> An unprivileged user in a user namespace can repeatedly trigger a kernel
> warning with their own overlay mounts. They do so by changing the
> casefold flag of the topmost layer's empty root, the top directory of

Queued for 6.18, thanks.


-- 
Thanks,
Sasha
