Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787FE4E9C1D;
	Mon, 28 Sep 2026 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635157; cv=none; b=HtolqklrQMxeroNzNj0M8bQKNAn11gQEb6fVFHLwsTMAKdESjPIJNKZ6Blwd4db0cHYY81zcjmkxmQIdqBM6HK8pyK0MfonqSTcJFKI2hF6CK93QTu5nGOKsl+zS6oWuO/QfONTYhlB520cKwSTMeftJqcEShxyD0BgsDb/LsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635157; c=relaxed/simple;
	bh=WIwq0JA2u8qNAT+x0huCsG+f3KB56pHyf87TC1r1K+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2y6pBfHw/GltOGSExa/pD40PFx6ka+aDQtsBg06n3T6BiCIcdVON03Op5SjlvocyBPxt+1mr6D9fiQtiLQ0TwP419YqnUPrBvYTeu1DDuZbxM3vCSYtsi91ItcgPBBS+SoYdnKCccGS79iAaCSYfO41cbF6FhQiulc/iFEE8hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktr3tcQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktr3tcQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346171F000FF;
	Mon, 28 Sep 2026 22:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635156;
	bh=nd73M5rbd/ggg8sAERH5RDHjE9OX7J/RfeI85mgNUCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ktr3tcQbBsM6kgvg0UxMIOGIyhZKxyWfIFMo+WiBxad2o344fpthuqfKCxt9tAuqg
	 /EcbeKLUzQGNzpTThTzQhG+gYv/SnLwbi6ARAleCr/BhSK9bFt5Gem8GA3a84bdr5D
	 2QQU+4wynD1Vc5TJ1hZG3TKneT3/OMEVqB4xDHsLleIqxFr21SYwHxVCh7voBo2yMq
	 Z3+PEnutQJDaLCz3hGicq7Dg9vtCcX7GhweTaX+oTi+F6DzX1FkcpiXnqicEYqW4CJ
	 LW1IounKRG+byLCekOGBa5T8E5K3ye3gJKFAZJ5G61J9aV+IGbIjqIl3TVajT/tQUE
	 /fhNfhk8A2bVg==
From: Sasha Levin <sashal@kernel.org>
To: Faaris Ansari <faarisansari@googlemail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Faaris Ansari <faaris.ansari@gmail.com>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
Date: Mon, 28 Sep 2026 18:39:05 -0400
Message-ID: <2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com> <2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org> <CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com> <2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org> <ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [   80.940668] usb 3-1: cannot set ctl value: req = 0x1, wValue = 0x203,
> wIndex = 0xa00, type = 4, data = 0x0/0x81
[...]
> numid=4,iface=MIXER,name='EVO4  Playback Volume'
>    ; type=INTEGER,access=rw---R--,values=4,min=0,max=254,step=0
>    : values=182,182,0,0

Thanks, that narrows it down.

Every failure is SET_CUR of the Volume control on feature unit 10, channel 3
(wValue 0x0203, wIndex 0x0a00). That unit is 'EVO4  Playback Volume' and
advertises read/write volume on all four channels. mixer_ctl_feature_put()
writes channels 1 and 2, then returns the channel 3 error, so the hardware
volume changes while userspace is told the write failed and adds software
attenuation on top. Faaris sees the same on 7.3-rc5, so this is a mainline
regression from 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write errors in
generic mixer put callbacks").

-- 
Thanks,
Sasha
