Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792962347;
	b=fwb0q8junOUrz61U1i3VpjlsA+iThlxHgl+7xXpd5mR23FulrAUR9CTDha0rixaXSLv6
	 9lvmNthmPonVuJjSn/UE90jam8DSgmxt7g1z8ezgrBtPcOINS1qmRd+OZs9d7u5tT4qQr
	 PUJ90LrqGzacm5HO0tmYJe8WsfazE6dITAVGgUcjqIP0xtPqf/KrLnEsEzS8WBOhXxlif
	 Eaf7gHgUrjN0dpfzUikUPvpwqdezCdhdwpsM35dcV+wUgjiLI+bRPzXY/VH26yxRVtLO9
	 yPxsXPb+YgQLyD317hZuVaB9Mye/ZLgrioIqKKNc9o2c0UCkzkqYfj3S9re1W71vqug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792962347;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=UYSVCCwpGMVlxwgQTNnUSrtNluOWB/Wh78j6BJd+JRKcVw60lDcanvvQLsu7yOyagLCE
	 p+hq+BTS79c1vDklSEGolJKjY9veYUMaOsxschwYLjyA5erZdHegHXuvD+SNs1TYjWKPP
	 ZzwzBIUeymLGG/0CHt+BM34FEPCO3ERt0LEsIGCMrAgmvTvhivVIpeeH0SdeEb7XAnCCj
	 G0f5PSEUpYVzYT7ahg5F+/+x5I2LK7BKpzNTE3dDleJNEbOpdgM48jK2gdcltRZKrNsdw
	 ng390WvVC/AuQPU5p0DZPVRT5GAPvzkqwKm9KhR+OqhLAYI9iRAs3Q7vPdYMyHugT1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPoOnc76;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7B606A31A;
	Sun, 25 Oct 2026 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPoOnc76
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E111F01825;
	Sun, 25 Oct 2026 21:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792962346;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kPoOnc76cvq3C/i3vPaV25to9xF+hqINoWaGoA23DHf67zjSbZMqyGofrjnHtgW0d
	 2vykR2HS4zO0ZkhmLmkSwQeHYiOHPzWVEzLN0X/eLI+psTA55qU4s7plYrAVJgDSWz
	 veVPrkDo8aKxoRKydO+l8b/FPP7kFASbgtquuQE2UJA6GwV6Z221nfnhBZb0LFfie0
	 6bnH40WVRIP2SE2+JN1Xsf0aMsFXJz3TkqXx/F5TEYGeX4k3ckc7r82A0+qZ9u6azF
	 bVjkfhBGI2ps1oy5uzsjZxPuDsn2IT7aOFlDWMFNeCISfb0hYMWAdtTGYPdMzZi7k/
	 oGqFO1mB1zLOw==
From: netdev-bot+sinfo@kernel.org
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, mkl@pengutronix.de,
 socketcan@hartkopp.net, s.grosjean@peak-system.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 net] can: peak_usb: fix use-after-free on PCAN-USB
 disconnect and init failure
Date: Sun, 25 Oct 2026 21:05:45 +0000
Message-ID: <179296234587.3327.17827320411071304419@kernel.org>
In-Reply-To: <20261025210256.629830-1-tristan@talencesecurity.com>
References: <20261023195400.3531721-1-tristan@talencesecurity.com>
 <20261025210256.629830-1-tristan@talencesecurity.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
