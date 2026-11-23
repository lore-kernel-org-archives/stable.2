Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438388;
	b=udDWMCFyi+BmIvkiV0sp1lB4U2CziD6KdMQf3aysHaU7MlkCauSMUgimvC0XwOWWdoIR
	 q6cs6pEcpmd+bn70H9CIkELca6EDRVtUSRg7J8j9OdmfXxNQlAjsseDukoDJiyMpz0gPW
	 C9brJpI32qPib8bm24gQ8QS8bi7NQ982LYCDDYRcmgA9TgV/L+MruS3GvpeIRF2ILW4p0
	 m1eQpn1rPqbH756yNzu43FyVA/rwK4HUvL1tEcjcGGY7JR4C/ZET1ODNPpMY9QQGWaeWY
	 Xai5HJb7CcW5O8T8GOJEkoGEq6MroYcHd32AIGY/Kd4Y3x9xY80WLLjlYBaOu+uqPeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438388;
	h=Received:DKIM-Signature:Message-ID:Date:From:To:Subject:In-Reply-To:
	 References:Cc:Content-Transfer-Encoding;
	bh=4/O70bfoOli5WnslzwPrt7cL+seY/RWkEkFVtKOsYPE=;
	b=NSXFQQcb58enEOuyRzv2pht4NyJU5pBxOphac7soeOGm+43JhJ2I7E42XgVIzIx+JS1c
	 fgqdFSKe7QQJYum68F0R/a8geCao86h4T0ylZi7iHog1Fg3Qidzn1VOrM54pVlEtwpo/g
	 /Q/MyN1iMl67dCEVVCe46S0dUCf3A1YiGEB0sCguy4Jo+GKr3oMAz4pOimq6OJ7s2A4pJ
	 IPuTPrH6c0B/vEnQBBN8/8KrprTOOlQyGG9VoJEFHsVw1nOdowqz9sqL80W0LQV76Zbco
	 BGmZd+kJa5qPoavO7HPt89SnkQTyECKV1wt0pAxb3UfT876VVGLHupR9hXG3O7qOvxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtMHDWY4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB8606A32C;
	Mon, 23 Nov 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtMHDWY4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8201F000C4;
	Mon, 23 Nov 2026 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438387;
	bh=4/O70bfoOli5WnslzwPrt7cL+seY/RWkEkFVtKOsYPE=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=WtMHDWY4UnlBp3mPIB10WxJdpT8OUb9P4rmFrwoEWje7bUdbQZV6vbjAX1xXmrUqh
	 7AqC/nx18ZRZ01iAhT5YfuAwvNAH7CS7MVQX1oSY3EGCSTjx77asXhaJNv+g23539n
	 28nmY1YtcmEvy4QDd7bebJFB6lzsDgpDAwN9MCfrXJ+vtnchMcln38xNZ2czBskEye
	 5qTeVgkQnF9aMoqSKtY+X75BP2QgGmQYJon9LVjWT28i+lcrc4NVVp/+re8D8wBOeb
	 A6g/jAGocqab2B5kiBBT2TujnQCzstdBItVecrdYOMEqHCK9KyJJgVCWxMqa6mQ+SG
	 XWTfY6QHu83aQ==
Message-ID: <fd4a16ac9439834f998735819be6ba9e@kernel.org>
Date: Mon, 23 Nov 2026 12:53:04 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 01/25] video/hdmi: Copy SPD vendor/product with
 strtomem_pad()
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-1-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-1-20e8a33a2286@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "David
 Airlie" <airlied@gmail.com>, "Hans Verkuil" <hverkuil@kernel.org>, "Helge
 Deller" <deller@gmx.de>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Martin
 Bugge" <marbugge@cisco.com>, "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Maxime
 Ripard" <mripard@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thierry
 Reding" <treding@nvidia.com>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

On Sat, 14 Nov 2026 20:03:25 +0200, Cristian Ciocaltea wrote:
> The HDMI specification defines the SPD InfoFrame Vendor Name and Product
> Description as fixed-size fields, padded with zeros and left without any
> trailing NUL when a name spans the whole field.
> 
> Mark the fields as non-strings, so that the copies can be handed over to
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
