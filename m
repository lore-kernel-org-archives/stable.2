Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014CE1FE471;
	Fri,  9 Oct 2026 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565824; cv=none; b=AF1eiR5UmS0BewN5+VBUkvrxLSf+9LL0Wo04fAq8jJlrFOTfIwPP6qGLlGKkq7iccXSwKqIUgT6qCM+mTyhbkqBKIHGcZzqKfpirnKo8LyiwuHlK6wfGWsGqjFI1GCkeLbfyoxDAO6yDSLWg0odRTBpK4TUl3M9IrZ5dnA1fzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565824; c=relaxed/simple;
	bh=vY6L4NTvm/on6IWMnloYlwQJX0aRNJuGQuYsvtVGC40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6Tu60vIkBYNzi/LfR7fVV6Hpp1ah8l/4Uk/O983WNyKmE8fx+ixLN9PQg+bY+baM1v1iLJNJ0fYIylIQI4FqFwyJvPoC6Lkts2L1g0V6M16m3E6hKlcaEAth+OoK8u+r7hSCfDfM/B79gYIg2MFePKuH2OIb5pvs63MhmXelMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YixGXwa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YixGXwa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4448F1F0089A;
	Fri,  9 Oct 2026 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565823;
	bh=dmxj2lj4Q4GvWHDzZDgnLPWqXygKdSJybIHJoEn8ViA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YixGXwa3MLom9Js4zQIUKVFQdomaKuo9cj7RvEu0/wb0JhokZZMOEaTvxvCCpjvKE
	 OPZi7RwFAxnMSyrVUQEF+ez1UumpLy+NM8vTQlpd7Znls15GLowiQYFfmI8DUTsSX7
	 N3UX30F/lGzfORtfhFMy6rfYAmXg5lH3p53zliBjjaHfO2Tt3gteffSCAZJMCpfFgV
	 5AO9iYgk0Rap9dp3jxVbL/nOq/cbqmCfdSXoQL8rE6gt4rMW3lz2eBzX3kc5mbHEuC
	 9msIKk6MfZFAFyEmVhr2cIw8bVkN9jenTDbtOz/htkGYjPUfpSPPbUR5KKOlvNtgYG
	 SbgHQ+LVYgWQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH 6.6.y 0/2] asoc: backport CVE-2025-21870
Date: Fri,  9 Oct 2026 13:09:44 -0400
Message-ID: <2026-10-09-1-daily-reply-0007-sof-alh-cve-2025-21870-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008190108.96660-1-artem@trailofbits.com>
References: <20261008190108.96660-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you please consider this series for 6.6.y?

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha
