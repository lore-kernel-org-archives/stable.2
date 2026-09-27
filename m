Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D23F23B5;
	Sun, 27 Sep 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790519225; cv=none; b=Ig8OJ3NfyDNcBFVj9cFkQgs5mukjXe/NwPRxlyrPehjmAZFDkjxYjIk5XitbhGkOQRfWsU8idPUW3stkTtNYjfJbWD9GlC7oS4T79x6cu8Dr5M+WD8MKHRJ7UWp9dk4Sftm/4SmzkrtGXI7YUd83qhA8FWd8v978ENIahmWBFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790519225; c=relaxed/simple;
	bh=rFX+rRMPeLiE/DGCCg7dOcgZAY5QQ7Bpa6LuddfFyrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFZqLolAi2+7UZslNjXP0Dqi95ZQhnCTA7qFp7/Owbw9i1BniQLbj2z/RZAh+eIDDt511qyUmG/QX8w4tfNMlp7+eJXGQeQFM+a3sl2Fp5WhTPvBFwPedK0mMWxKMlxX2Y+Sf9rseykbDS85ve4Q+sdfK9Bw/aa9F017vqWB1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk5TZUvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk5TZUvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4941F000FF;
	Sun, 27 Sep 2026 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790519223;
	bh=cqGmgP7NufmJ/ktboJDXDW5qnWwG5i1YxzK7VM/Ztyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xk5TZUvj4GW/URyvtHsmy4ZcWevaGVfWAZNVhS4rP/BwPK6ud2YOt95BFXzoRQ18q
	 MYsdqIGkUiP8tQYaC8Uky5tgKppFkLm8aPMQ1K6nEYFt1NM8aiusC5eROBOIUm7w4z
	 RUYy6XavliC+e9ZkpIKn+lHkVtwhRozAKsWgtZ2K81jeAMSxg0p05E+bEOoBL8FCX6
	 shGIV7wFXgbiPG1GFFljHwpUbofGO+QidCMf3nras8hIBVXZGP0Hh8mLxSC+w1KkIb
	 fGgBpI/5GgA+Z8dw7rVwg48AQkGI2xjE79kXg7QBsWjWhJJEegmMILAmhLQe6k+VPf
	 Qk6PFnodHQ67w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Faaris Ansari <faarisansari@googlemail.com>,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
Date: Sun, 27 Sep 2026 10:26:59 -0400
Message-ID: <2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I was able to work around the issue by adding extra modprobe config to
> my system, specifically the below:
>
> options snd_usb_audio quirk_flags=2708:0006:ignore_ctl_error
>
> Does this quirk need to be added to the snd_usb_audio module or is
> there an underlying fix somewhere else?

The likely cause is 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write errors
in generic mixer put callbacks"). It is in 7.2 and was backported to 6.18.53
and 6.12.111. Before it, a failed SET_CUR in the mixer put callbacks was
ignored and userspace saw success. Now the error is returned unless
ignore_ctl_error is set, which is exactly what your workaround does. It is
the only functional change to sound/usb/mixer.c between 7.1.13 and 7.2.5.

Could you confirm by reverting just that commit on 7.2.y or 6.18.y and
testing without the quirk_flags option?

-- 
Thanks,
Sasha
