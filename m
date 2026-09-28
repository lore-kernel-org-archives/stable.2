Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4EC4E36E2;
	Mon, 28 Sep 2026 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613977; cv=none; b=N8KE7FyAK5NBpPf1u6t1dr1NszPuaa7/A0wE+iSjmHkScqhFfEf0BJjVOIwxvP6gvTJqmz6Kjv7qo/xt9Vi9JfAClyp8HPsJkLmXVy5fCKDkYd1bcsmzC+tIDqiMl+Jg9qGMppCV0Uu58+0s/g7ss0Yi1HzFdeto/xDwfNiULeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613977; c=relaxed/simple;
	bh=L5qVzKMFtLUnejDaRyNVCt/v0qMEgkFPgYgVoTkTzhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DohkFkkbrGh1uSMmZzFjct/7ModceUCIxeVP9U38frCN3W1ogyIplFp9S1bOj8XlN85VwlCtiI0/IXt6v16I8eZ3Y8ry+INPiXsqMzzPbtkO8doXASPGJboWYiLRNHRV1yK1E1tWKcW7tvtq63Pjp5Xwrla+L8F1ZyX4uNMWbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzIAVYT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzIAVYT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893F01F000FF;
	Mon, 28 Sep 2026 16:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613976;
	bh=u25m0beaQQpd+KWWZhn/6kfGaoXM00MWHK5+qBjKQiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SzIAVYT275w/gNqMqHBugFLgv+RTqpov9+ZrcUCcVIa7sSeQvMlsfbBcKnozAVYhG
	 9GjkUY8HGe8M3RlZqUWWz53QAebKK1aNHzMTErUxlJbJM0GyMf8UPVaJf5gVqPbQp9
	 CFPTn0IYv3gh5zRZXG/Wvsi2dK9sn+wwSHtV3HZVRkkrW/V+Q6EQDq5Qdpxt9fK+Oi
	 MRdZ+huPMFzGsxs0QHKnN+x+l7/j/Kdf4F8FqQ92S/n5hSi+0NY2VoJ9huFK1vIHPa
	 Up/P3+LRx/xrFkiv6xndpb6P/SypM8P1D7RxLN/bpfyEfft500FjIn2sFgAxdhIrH1
	 fDue8UQB7hqKg==
From: Sasha Levin <sashal@kernel.org>
To: Faaris Ansari <faarisansari@googlemail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
Date: Mon, 28 Sep 2026 12:46:00 -0400
Message-ID: <2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com> <2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org> <CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> It seems you're right. Reverting that change has fixed the volume
> control with my interface - I made sure to remove the quirk flags
> whilst testing.
>
> What are the next steps here? Is there a problem with that patch, or
> do we need to add a quirk for the EVO4 in the kernel?

Thanks for testing.

Takashi, Cássio: before 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write
errors in generic mixer put callbacks"), a failed SET_CUR in the mixer
put callbacks was ignored. Now it is returned to userspace, and on the
EVO4 (2708:0006) that breaks hardware volume control. Would you prefer a
QUIRK_FLAG_IGNORE_CTL_ERROR entry for 2708:0006, or a revert or rework
of that commit? Any other device that rejects SET_CUR on a single
control or channel will regress the same way.

Faaris, to help with that decision, could you send:

  1. dmesg with snd_usb_audio debug output enabled while you change the
     volume without the quirk, using
     echo 'module snd_usb_audio +p' > /sys/kernel/debug/dynamic_debug/control
     (the "cannot set ctl value" lines are the useful ones)
  2. lsusb -v -d 2708:0006
  3. amixer -c <card> contents

-- 
Thanks,
Sasha
