Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220443CEE3;
	Fri,  2 Oct 2026 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975443; cv=none; b=eArb5JyvFPRRRkX1Nt+7VP08KcJ74IU9F2PupBHAKDRtKo4Bk+noC+rAkkwl8vr7UW78kriiHWPEocp3pteyxauNUkSYRz+PmOv7BJ8vYVpfmOLBlEYLo3jwjUAcbbEF5kTNNhODk2GX7Bu42wTd80HdhT0L6Riqtk7eE53ga90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975443; c=relaxed/simple;
	bh=D1kltrxfgf6d7VDUWLXnyJuBi+LjdSy9cpdgYbchaW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAZif36J8b0smwU9dLiRPy9p0RxxLPjdnWEObUPah71ZM47t58m/dG1iaMweBicegLCvD97/OMGI+TlmNUfVtBULpnXWHM2korshojFwyGgHjUU5hE2SfShb5P5Wk9Tz2EoZ4xUJ9WiYNSnzTUOvNivMZBFqBHW2mX9leOyJqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqfFQn9G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqfFQn9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299621F0089A;
	Fri,  2 Oct 2026 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975442;
	bh=zSU34lq95CGrbzCiIwW+lyfieZB6/ATWCv9nAtclaZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bqfFQn9GmhFp3VrAaD0gPxwS3RHUrvCFUbdjY+85O4PTQWhp1KlJPLKmiKyc/Onxt
	 upt4y81HNTMeqWAEEh+eR8nq7qC9JdD+Iuk8VLZ2H0j/WTGbFGMNW7rSC0la0IcJ0L
	 AcZ3Y+LvQVC0oQcIJ95Hu7qkLF9B5z+me1QFya+L0LarGraLxJRR7k9mfKRqLpR2+m
	 LSiSIt1IS6zOAX4Y6AHnyoTL6QyC9kNkjoqxvYqnbbQS3zYgIhPsod4GO+g+vob3XY
	 Byc5w4altFqkXnWn07sILsNpNWqCCQws90cfVChyas4S6ofjs2R7xzRmab+EdZh9Q7
	 ubdCUZxFyKcVw==
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
Date: Fri,  2 Oct 2026 17:10:29 -0400
Message-ID: <2026-10-02-1-daily-reply-0003-re-audient-evo4-quirk-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87fqyoyxrh.wl-tiwai@suse.de>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com> <2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org> <CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com> <2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org> <ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com> <2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org> <87tsn838gk.wl-tiwai@suse.de> <87mrt01bdg.wl-tiwai@suse.de> <87ecec19pa.wl-tiwai@suse.de> <0e1a1284-7069-4c46-9f35-57c10c129883@gmail.com> <87wls4yvv8.wl-tiwai@suse.de> <2026-10-01-1-daily-reply-0001-re-audient-evo4-fix-status@kernel.org> <87fqyoyxrh.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Yes, and I sent a PR right now to Linus, so hopefully included in
> 7.3-rc6.

Linus merged it, so I've queued it for 7.2, 6.18, 6.12, 6.6, 6.1 and
5.15, thanks. 5.10 doesn't have the quirk flags table, so this fix
doesn't apply there.

-- 
Thanks,
Sasha
