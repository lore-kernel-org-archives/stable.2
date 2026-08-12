Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E0421231
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552019; cv=none; b=AxubHggf3zAOrdPHPVjOGw5cCHxAvpIFPcneHZqZVS2Z0E4TcEw2gmwXQrpVT219M0Iq+OoKN+0+7NJHalIOiUeayC50j6PLAHUibxu1KH8J4PchEVaqgu5QUzSjvTt+OMF61Dg2AjpTKpFYZ9E7xrIrrPzg5gf47aXMh0WzRnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552019; c=relaxed/simple;
	bh=UxxvbeM3Yl9LL+8FtsTjzOF8RUmNXX26SkrueYlgyO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wxr1vXWqZfGAM8+lbkHIyAycp5MKCxJ+payR6XRWTBYdm6a2UVZCWhqmVBYkG6Cb1mOynenQ5tLhZBrJ5NBX84Ce/VfzKPQZxrPLh87V8ka8A9kdmMOXksmOkeBUwPnIeYVKMZXcT6OyTzSw2nMlVZmSw2Gs+i2YKsCh+EcHL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lg4WJPE/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lg4WJPE/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D401F000E9;
	Wed, 12 Aug 2026 16:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552018;
	bh=XhlnfOT+3oiZagSBA5VrZ4YFcsrGkXKZxgW/khC16sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lg4WJPE/X+BJHS4GW2WpnlBOk/PLQDojUqzRM0Ethcfws1ZA0JUdNMX03LcaBf76E
	 Wyi7Y7VE2k9fyLyktTLzyE9hD9hiRNS3WnkvXmLgqm5IiVm5Y6l9pg3dlpta0XKesl
	 pAnIA33Zw/zJdq6ugiC6U6xoCTSTQxc6LuP91gAQmDhR+iS+7bbnwENsRWodssT24g
	 HgD+TKO1itfZwCthDdp9D8yqcCjR0JORKjDFt5/6ZHrNMx8kI4gpULRq5CHjdK4zRu
	 NAHW443uJVI2WEdzHWlER8He6tw5BHIKRFwSj2czZBI3z52IPAfC8pf+/3mt86cq/r
	 wthlktBAuDk7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	pzqqt88198@gmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.10.y v2] ALSA: usb-audio: Evaluate packsize caps at the right place
Date: Wed, 12 Aug 2026 12:26:44 -0400
Message-ID: <20260812161500.10007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811145740.306-1-pzqqt88198@gmail.com>
References: <20260811145740.306-1-pzqqt88198@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Aug 11, 2026 at 10:57:40PM +0800, 王YP wrote:
> [王YP: Move the check to `snd_usb_pcm_prepare()`. For linux-5.10.y,
>        ep->maxframesize is calculated in `snd_usb_pcm_prepare()`.]

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
