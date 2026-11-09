Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184495;
	b=vKPVht8eHGbUQe/sOd1bJbjvtCGJCdYLLz2ta1ldulMS5vladOBRSdgLd9gvnFtaZgFH
	 HDpMuvAqOLHBdneReFnjGBRHTsjpXvJvi/W92u+k/kT3Un7fqiI7pzozYTknOgK+sZRcf
	 rZhL07aHluAhtrcWcTRx3nNfyDzn3WncfBli/nzjIWYlbsy/i338FonweLqep908+EQlq
	 BAsgaC4T/+MPMH9oStNLTBPLL+zyYe3ooS5hskp5nUfC2KOV1t1rOQQIGztOAO4+07TYd
	 LWts/CF9y2CSNB2kCWQcO9S3rH7/fzFc+fXIZvPXfZsCBfWLeqgzKYzOQNLc+eQOZ+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Fzi1sBVhAZ2SvyIrd2jzBsCWolwB251QpONkbZrY9JA=;
	b=BgCBDOP2IzEIQuXRxQHIdDTA4ucR4pjlZ2QqHUV3kCS4HXZM9ny79sCqhvzGi8DEvgHy
	 znL6VGiROEUCXhWVnJv5eQsb/f9E1I81CLk9+uckKasxRlVRD63y1jWc2AplryqU3qCKP
	 dgqymzh8CjTVNcy3TGaiij1on0Y4oUGTmZAK/YnWs8DMKwmpRdlX43Ux1qmUSx+ybswdo
	 O3o0Mb2j8SpCxpvJqnIToBr59rOKPNbAt0EiuOWcwGeuRxlBXaDMChJ/UA/je22GeuHFd
	 dSp81xUX9oDyzme2YN+G+H9+qa6ZvMAOqFnQ3J0gvS+VQQl3uvK6sEK6dgRz77Pm57g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCZ8e7ii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22C60A383B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCZ8e7ii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4215E1F00929;
	Mon,  9 Nov 2026 00:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184494;
	bh=Fzi1sBVhAZ2SvyIrd2jzBsCWolwB251QpONkbZrY9JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WCZ8e7iilc3nB9tst8NHiOXuMldMopBjaEGZyvvuy702m7eSy0DQFph8VnbsINP1n
	 FF5hjvvdOhCWRYQAV6utF/gknhbkSstcY0+z/ou/lNK/4HjDW8jkfNU60zy38aT/TK
	 5SXKJ8TvipQ6gtGBY+fOuftolkRN1aAmSebSoKVhqm1IL30rhzoJxSFBVyMsBaxNXA
	 Vwe1RXI0yCUjLxGAdRqJELSLy7J61R/Fk1Fh2Weouc4lOxipDs/OmKTr5rHDz45GYM
	 CodYVnZpGQRHsubOeu+rQ6IDsSAShgt96cEH6mLaa5MhMlQ3yNcRYqlEd/jk2STDNj
	 S/vpM0YmFVdqg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	jeff.johnson@oss.qualcomm.com,
	toke@toke.dk,
	stable@vger.kernel.org,
	Rosen Penev <rosenp@gmail.com>
Subject: Re: FAILED: patch "[PATCH] wifi: ath9k: delete channel-context timers on deinit" failed to apply to 5.10-stable tree
Date: Sun,  8 Nov 2026 19:34:40 -0500
Message-ID: <2026-11-08-1-daily-reply-0012-ath9k-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKxU2N8QChO59Z=ncdNfvq-hNZp5Q2UsGFcovqn52G5mQso6hg@mail.gmail.com>
References: <CAKxU2N8QChO59Z=ncdNfvq-hNZp5Q2UsGFcovqn52G5mQso6hg@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> git cherry-pick -x 81394dfb9a7905472957628b560ae894eae3a30f
>
> works locally. No idea what the issue is here.

The cherry-pick applies, but 5.10 has no timer_shutdown_sync() (added in 6.2),
so 81394dfb9a79 ("wifi: ath9k: delete channel-context timers on deinit")
doesn't build there. A 5.10.y patch using del_timer_sync() is welcome.

-- 
Thanks,
Sasha
