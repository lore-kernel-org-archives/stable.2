Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5E58B6C5;
	Thu, 15 Oct 2026 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093004; cv=none; b=sYO0p6rlz+a3kLT17Y9t1PUC8fY65f2kny8AtszHXYN7qdcoDD8O7G1Bv/m7q4fYmyX3aqmpOvKIe6Mz2SuSxcjgJDIT7r+6xKtOlODin00kONGEGEGhQ5Gn5kgE8o6RiP8KfF7AL49PJuISrPWGoDXcx4+5htlYVh/1VyBeCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093004; c=relaxed/simple;
	bh=2hIv/hsso4q6cGZ/QZ0W+5ZyLJDHqT5DuLEH8zJZn4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7NsPhCydLUT9+HWqtajJFB62YB186hiJN+4vd//Am5AM4teVP8JGgAkAL8b9KbCv1mY57pOmD+AOxR33+yV6C/gua1ckypkKKYppmbzy3L82/pyGeROhvcFT9uHI+LLl7ZHKXFVIRdwyRvQbOSPKYpjXJf31btqp4fM5mV5hzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0vkI5b6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0vkI5b6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976481F000C9;
	Thu, 15 Oct 2026 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093003;
	bh=LaF8qOFdF4oevPgFiscu7vfYywbqRlUGm5vAQKPmSYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j0vkI5b6N7Co/8jH2+NMCnE3yjMSeZmpv3SB90t81t4GVidpl7Jp7Q7SKksgho7Ed
	 kCS0Gui4gKSSFFHkm8LxmwXTjEvIWQDxqpv0z9YUebAj4PiG/KS9c2atra2MetmXx7
	 BY15zHoqWx05C6Cu9q96ii+QhkMyu3MQKlLQR833KiOlXZ6nAu8YQJcjKzXzXqayv2
	 heM+mKw2GW3PF8KMG77T5Lijc2tSD+1Gf7HKWspT8RZ+oPWO3iApqYvqbIz5NfNGbf
	 2k32HY1o6j79rMaw0qoE0kCAMMV3TQYTG2xnoigL5y87bIXIY/gRxUW5VZDR2i6cPx
	 ZFkf3pU5/jenw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	broonie@kernel.org,
	daniel.baluta@nxp.com,
	kai.vehmanen@linux.intel.com,
	lgirdwood@gmail.com,
	liam.r.girdwood@intel.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	peter.ujfalusi@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	ranjani.sridharan@linux.intel.com,
	sound-open-firmware@alsa-project.org,
	tiwai@suse.com,
	vijendar.mukunda@amd.com,
	yung-chuan.liao@linux.intel.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y] ASoC: SOF: Intel: hda-dai: Ensure DAI widget is valid during params
Date: Thu, 15 Oct 2026 15:36:00 -0400
Message-ID: <2026-10-15-1-daily-reply-0017-asoc-sof-hda-dai-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014193751.25230-1-artem@trailofbits.com>
References: <20261014193751.25230-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Each cpu DAI should associate with a widget. However, the topology might
> not create the right number of DAI widgets for aggregated amps. And it

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
