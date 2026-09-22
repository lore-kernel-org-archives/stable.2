Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650A5505C1;
	Tue, 22 Sep 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091547; cv=none; b=ANgbvd52s2gybtOVlngZuuImfKL7U8v8bXjhv2MqJkvGXwKcD6P7FMKyDA0R9ZemVx3D7amO5OqW86DRdhhT0+/qDiMpxC0+chVMeiCmnmT9nYWBnFBfbSU/TlYv0oC0RwZwj0PL57CvtnfRvOy1y2/prsAMefIpmLZ9UkAgobM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091547; c=relaxed/simple;
	bh=e9064dmLtXPIpbPgq0vdAhBqiEsQjb5F3krx6zq2ao0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOznx8EqNnJf6uOBVrY2aWDBO40IeIH7V6jPzABMpAwYOXf262UF5uziPl9v6A61Zj3NaGmAKrTfKJhL4xw/gYqRD+XtG+UGpUPRup2AS+5KpXhViRr9tuQcTmyjndX+QA9CMZfHA2wyW0LVFtpaFAoW17sGF4S5F2JoSE6FyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkVHTBEQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkVHTBEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117121F0089B;
	Tue, 22 Sep 2026 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091545;
	bh=jJ2dYp/XvskeEdM3P1iMUDkwcj/bYfhcJRRNYEn6Lus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SkVHTBEQaV4x4VLWjobsyTzLYeXPqxZCtoxW7HSaNThPHfWNrYWehqZXkAcxiiTjx
	 mKmLpAEoA37n/6R53/8F/7yjaXCF5eUDeO+2Knu6LKdsC5sJTyzr7DtSotc/3WF9VK
	 5E4+8se4hj8kY39Vxh/hAgvWzHgtrySgfOw1x+hlg05cJMmUk86nSZbKuNr4BFlPpm
	 rkbpipdpUjs1+xDFHJ0s+NQKtqwEhKq16xnUjPCvta7JoEj/W0x6wN38lJn7vkDsIx
	 jOV2MqGoQUU+lTtbfVPi3dbFX2bWVLHU2ohUP+wa11r7JgEbMpmDr6Hk4+VoOSG3Qc
	 eXRfAPcTrsXCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH 6.1.y 0/2] ASoC: SOF: backport CVE-2023-54233 to 6.1.y
Date: Tue, 22 Sep 2026 11:38:55 -0400
Message-ID: <2026-09-22-daily-reply-0002-re-asoc-sof-cve-2023-54233-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921193750.82134-1-artem@trailofbits.com>
References: <20260921193750.82134-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The stable tag on patch 1 says 6.2+, but the same unsafe dereference is in
> 6.1.y. I kept the pair together and did not bring in the later topology
> refactors.
>
> Could you please queue this series for 6.1.y?

Queued the series for 6.1, thanks. Keeping the pair together was the
right call.

-- 
Thanks,
Sasha
