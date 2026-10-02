Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2223D7F4;
	Fri,  2 Oct 2026 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950803; cv=none; b=VXarOGP5AVLOhTWUkwli0MvXQWlffH22YA1ko0LpHUvMxhzSpuK5nC9epsfDWBoKQW0cU9mk0TbBB3JdxnU1G95M0KvRiieIYhVIxWzvknJSUB6DvMpNYciFTZaiSEK9NqKh+87haXprN5ndGf4JK1KthHBZi+Hg5+oBWlIq2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950803; c=relaxed/simple;
	bh=xwSlIsmagxpROOlAlpvjVXX9xGjVMJiW1orVSwO9TWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRaAuzKDBbvTvwyvqYW3O2TnXK/WSs7DBkHZKHwHgKOY5uAdgh+1VXFUPecsZewDv8dCQ7qBjF4KCAZz6XCT6CaTEM0HnJcGMRL+QLNI0GU9t9xhOyC0ycwTvEPFL+tT9WS3frADIRNx1LXsNLL+Mpymk1/wL3GKm780i4v7Jjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfDrSFPo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfDrSFPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FF61F000FF;
	Fri,  2 Oct 2026 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950801;
	bh=++ayWejJCHydCsGTwAXfufvMnK7GoM52apWkHn3jc74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YfDrSFPonQjrLg0cnICaEoRx7XZOmrZboqj2m2+DIU2CLXXwnotH9jkq4rSrfNe8I
	 4/rf/CawdvRX3rzlchRHnJdnDGfARiwffDDt28yb3sf7XQPaI5sTyYmy3hd5ur5a69
	 KQJvgDbJ4GEtp34OXii9g2F5mVznyHlr9VG3MX1rp/bT4lU1UYJnXrvGg1/A1vryUW
	 IONLmr8Cft4T09zZeLqCPRO9+sZ73ouBx/ZvJa4GuwxPH1LMfnKeXAJHKyLGMN9luo
	 mJZ5kGa3tciIzZiXjOK32voBnYhSMb6WNAUAm4TmDkgfYRY29EYDA7mOWDoVbxWaBQ
	 6/YhzRsa9kNnA==
From: Sasha Levin <sashal@kernel.org>
To: Faaris Ansari <faaris.ansari@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Faaris Ansari <faarisansari@googlemail.com>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
Date: Fri,  2 Oct 2026 10:19:45 -0400
Message-ID: <2026-10-01-1-daily-reply-0001-re-audient-evo4-fix-status@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87wls4yvv8.wl-tiwai@suse.de>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com> <2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org> <CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com> <2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org> <ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com> <2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org> <87tsn838gk.wl-tiwai@suse.de> <87mrt01bdg.wl-tiwai@suse.de> <87ecec19pa.wl-tiwai@suse.de> <0e1a1284-7069-4c46-9f35-57c10c129883@gmail.com> <87wls4yvv8.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Thanks for clarification.  Then we need a fix like mine in anyway.
> I'm going to submit the proper patch.

Thanks Takashi. a154f7b9f197 ("ALSA: usb-audio: Apply IGNORE_CTL_ERROR
quirk to all Audient devices") is in your for-linus branch, but it
isn't in Linus' tree yet.

87a6f2fa6e6c ("ALSA: usb-audio: Propagate write errors in generic mixer
put callbacks") is already in 7.2, 6.18 and 6.12, and it is in the
current 6.6, 6.1, 5.15 and 5.10 -rc1 releases. I'll queue the quirk
change for the stable trees as soon as it lands upstream.

-- 
Thanks,
Sasha
