Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0973C456F
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957138; cv=none; b=L3Ng9bYLR8StRtLUtEe4NVncL17QQ0mxcOqOgH0L7c9NYzhIoUJYLBkgsQaT3x/i+mUHnlMIY1Jk31cFIs4dV/JoTyEkT9WXB3D69sVLkCgTO83pRZMn5NmbCSsUZM1ikwIdGe6qLSEqaE+bLb8f5XrFjd8RfwU/V3c8wx7nElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957138; c=relaxed/simple;
	bh=sqPOaOOnu50Yga2PJaMhvsEG+rlAbAKYj+pRZ2HVwm0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=m6bfWOw/7kz5ySi8CB6sLDWzc0VYTOLtOFIPDlIZAe95TrWC7sDdNM/syFdS9UdHKnmsB/Jmg8LQC2s7+eh+0KHctxyHDbySlwK2j7l4SrzZ0pW51avxwnsaPbH+Ekw/cCmSLiILlu9jeNf6LNK9peEn5AryetmihhRUGPCZDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Z8icqC7p; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Z8icqC7p"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id AEF1A240104
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1786957128;
	bh=sqPOaOOnu50Yga2PJaMhvsEG+rlAbAKYj+pRZ2HVwm0=;
	h=Date:Message-ID:From:To:Cc:Subject:From;
	b=Z8icqC7pZGMjDM9DKv3XYnoexWqYOaJQ7gwDiVPPX2seCJm47DvWGwoY7l2De9S3c
	 beZVJ2xoz2clLtnMtYhUSe6sCmP9FiVKqZWAtbpVfmozmcInt1YcpTay0dMSeWOeZf
	 rK6tl8Z35+WMfXrQUkdOXYhBIwwvO2hZ1OBoXbE3lhbDBdMnsS8n21RxDtsfD3GRmp
	 qPPVPK6JTe/NWCcbNg1nvHmqCGgF9yw+C3n6/5dTjHZEHv1TPkbRKlxOyL9C6902cr
	 I+pem62Ad4/YD0JDo8SCNlwI5AV6GvTBRxSOET6oM27oKi4Qn1J+2/twzQbV2+gcbo
	 Mn7M9qN15RnIA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hNmw80Bb1z6twj;
	Mon, 17 Aug 2026 10:58:48 +0200 (CEST)
Date: Mon, 17 Aug 2026 08:58:48 +0000
Message-ID: <1786957127.718071.28963@posteo.de>
From: Michael Diesen <michael.diesen@posteo.de>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org
Subject: Re: Please apply bed0c8084044 to 7.1.y and 6.18.y
In-Reply-To: <20260801154223.stable-0005@kernel.org>
References: <4391ca99e19df478490aacfcde6e5ca4@posteo.de>
	<20260801154223.stable-0005@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Sat, Aug 01, 2026 at 06:13:27PM -0400, Sasha Levin wrote:
> Queued for 7.1 and 6.18, thanks.
>
> 6.18 was missing the earlier 103c:8a06 Dragonfly Folio quirk that this
> entry sorts next to, so that one went in ahead of it.

Thanks - 7.1.y picked it up in 7.1.8.

For 6.18.y the prerequisite is in place now: 302eb8765132 ("ALSA:
hda/realtek: add quirk for HP Dragonfly Folio G3 2-in-1") went in with
6.18.44. The 8a05 entry itself does not appear to have followed it,
though - linux-6.18.y still carries only the 8a06 line in
sound/hda/codecs/realtek/alc269.c, and I do not see it in queue/6.18
either.

Could you queue bed0c8084044 ("ALSA: hda/realtek: Add quirk for HP
Dragonfly Folio G3 2-in-1 (103c:8a05)") for 6.18.y as well?

One note in case it is applied as a plain patch: the last context line
of the hunk is the 103c:8a1b entry, which 6.18 does not have, so git am
needs -3 there. The change itself is a single quirk table line directly
above the 8a06 entry.

Thanks,
Michael
