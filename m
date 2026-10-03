Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4104436F438;
	Sat,  3 Oct 2026 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991035; cv=none; b=VouQ1FiTftcChYNgKGJZijZm2TMESqvufO2J0UAx9/2LdDpTLYCI3wOE86Jle5t3O4QZCtLWbfD/guynPTbPEMwE/PXMV7y/yfA3kO99/g/DdfW/KT03tFh9iblFipDmcw/nuvltgc9OJXIYMRtfwCTNu08QGUu4RXEzFLnRSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991035; c=relaxed/simple;
	bh=PCQeCrtqquuxM6BUduJZYPtOFAirPLh++2tyFXHN0GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgKflEC4G47AlcQeSFlPbRsyK9okvNAPmOHAlkz5giO6j36REua6Rbv3mVQ6CUQPtupKyngl6xyjW9fp+sDIt/UypDVE92QeFWnIKAv56pFQx/KPk8Gk5mtEQyLzFaaueJy5FI2FYstgMIWDSDwHKkoKclDTfB4P8Y0HYXhJ0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j879Jf3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j879Jf3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24371F00899;
	Sat,  3 Oct 2026 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991033;
	bh=49D028DpCJqCf0AAEqEuXw6ionQAMrqtAVTu9Jv+MrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j879Jf3ofEdQScfrfFOUr93WzStGWOPsSpJJ/s3Im2karQ3yNFvnqMLIALjh9/PT7
	 6sIo0CkGlYyLPT0DxUwtooiNDmjQM1IwZFT0FR26Fn/SJH+VkR6deIDuYLRkIk7vxo
	 xlPDsJzGHRIbyFiFR62hJX+iR8B8f7YFDSzx3NQ1Mb74C/EekOIC0+/MBfyUom4bXR
	 0EPsSQibxekoWui5x1qu5D1dhqNcl6aUrVY5lpTCnGiIEF+RUIjbiAhJ3FOkSC66En
	 6MLSO9DZhyk2/JpiXMGraH2MLDZdjSTAVszZIG04BQlTQ/2vbg6aE+3xfOa9vH9i6q
	 Zj5n2nYtdUonw==
From: Sasha Levin <sashal@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sasha Levin <sashal@kernel.org>,
	Faaris Ansari <faaris.ansari@gmail.com>,
	Faaris Ansari <faarisansari@googlemail.com>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
Date: Fri,  2 Oct 2026 21:30:24 -0400
Message-ID: <2026-10-02-rc-reply-0004-re-audient-evo4-5-10-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026-10-02-1-daily-reply-0003-re-audient-evo4-quirk-queued@kernel.org>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com> <2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org> <CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com> <2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org> <ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com> <2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org> <87tsn838gk.wl-tiwai@suse.de> <87mrt01bdg.wl-tiwai@suse.de> <87ecec19pa.wl-tiwai@suse.de> <0e1a1284-7069-4c46-9f35-57c10c129883@gmail.com> <87wls4yvv8.wl-tiwai@suse.de> <2026-10-01-1-daily-reply-0001-re-audient-evo4-fix-status@kernel.org> <87fqyoyxrh.wl-tiwai@suse.de> <2026-10-02-1-daily-reply-0003-re-audient-evo4-quirk-queued@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Linus merged it, so I've queued it for 7.2, 6.18, 6.12, 6.6, 6.1 and
> 5.15, thanks. 5.10 doesn't have the quirk flags table, so this fix
> doesn't apply there.

A follow-up on the older trees: since a154f7b9f197 ("ALSA: usb-audio:
Apply IGNORE_CTL_ERROR quirk to all Audient devices") can't go into
5.10, I've dropped 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write
errors in generic mixer put callbacks") from the 5.10 queue instead,
so 5.10 doesn't pick up the regression at all.

On 6.6, 6.1 and 5.15, 87a6f2fa6e6c is in the releases now under
review, and a154f7b9f197 (now in mainline) follows in the next
release.

-- 
Thanks,
Sasha
