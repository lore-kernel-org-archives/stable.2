Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF836C5BB;
	Wed,  2 Sep 2026 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387278; cv=none; b=fG/7Akc0I34FmVHYwDWFYKzTSpPmOJGid0HOWuAbTwi5756V+gCZADUvTTxf0b5KrsazcNXFz3XbPnC/yIoadyQVHMfuR3rdQ2SjA8lvTYKULUgYni9dIn+UBEvFthZL0ENlhwzoAS4WNEoVDtbrmegrlwgThW2MweT44+CVYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387278; c=relaxed/simple;
	bh=FPfZvOGFtpBuQTFJdKv/XQsh3qCEsjzocZqPAv8YOr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvb6IbfVMVgltVrXJch+klXQVXZF2ytXcH2ex+GaGnpewoi4ZnIGOukchFRdmMs53XS562xXnti6j/N5Ix+E0NzjMnK71E15tcTU9UDyahM1KYewaVkiwCMwC4vpvLUeQ12+AcztP/IBlpkinI90llM0hUjCLK3loeO22vzhJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9Yni1SN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9Yni1SN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36011F000E9;
	Wed,  2 Sep 2026 22:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788387271;
	bh=LElBelHWJFi4myMfOZBWusPXXcCOWVtvjgM7B1jP4hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e9Yni1SN2SHWCI6laaP2QjvEo/uhgeaZBtS84RDHul6zGCfZEyJbWC5tCr8+luw9k
	 4kKDKEGgM2UNAZ/4v9/4mLncaxh6MS8y6Nl8Lal4c3iTNVQBN87CUF3mQMRtPmUJdf
	 SSDyk0QSchzcIsA8lmB/LpCa1ItVbqpi6GPfSRGLmBrABSmrlwuH7+5XONqjgDC5QF
	 Mwr8Yso6VDqpK2wh5j1fcX+ooDsXo1Bw6WoodwzaRqi+Mw7bHPWBQXmkq1kkfzQhIN
	 NB7VCivqFe7E/NUyTfkxyJ77IR3xld2qTfGK0Sbi2ZsYlLO5b0rprJ0kyJSWJXRaDG
	 g171w6fl57KYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5f8f3acdee1ec7a7ef7b@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.15.y] ALSA: aloop: Fix racy access at PCM trigger
Date: Wed,  2 Sep 2026 18:14:09 -0400
Message-ID: <20260902-daily-reply-0010-aloop-racy-access-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901101041.82052-1-kmehltretter@gmail.com>
References: <20260901101041.82052-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Takashi Iwai <tiwai@suse.de>
>
> [ Upstream commit 826af7fa62e347464b1b4e0ba2fe19a92438084f ]
>
> The PCM trigger callback of aloop driver tries to check the PCM state
> and stop the stream of the tied substream in the corresponding cable.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
