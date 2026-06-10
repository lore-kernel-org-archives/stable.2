Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EF1429827;
	Wed, 10 Jun 2026 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107257; cv=none; b=sbMaE+wd3WogRUj9U8azmQHUZPuhG5dMGombqUMkzaTZRmIAoLGV3IhbonYrBNsO9Et+Ujk0gUztxMVIPTSznblw9VK0/u16/m1fTmscpQwJ4PUzLN8B+IMDPQs12KOHFzJhjIH5jx3kqhC6Sl/JNAfEAZog++H1vaLMofNG8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107257; c=relaxed/simple;
	bh=yygwYe7ShSyUHaZhEeUMjmed3v11V4TuHwXMVMS5XAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cq86y6QpHk0LcWbLcmUtZGIyIkodjIQfUNorTKT6IZVIU+1qAmnkhwjyu3rKzNxlcsjauBvkKM2sbbvxA0v1FTbkjJoO+sgyFujjoEi0odtstfdmYZJdm8gfs75b/oxDmUKZxU8iALub6FgOllgnJWBH3RaqIyx9TeWC6StW6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCHesFF8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCHesFF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC231F00893;
	Wed, 10 Jun 2026 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781107256;
	bh=yygwYe7ShSyUHaZhEeUMjmed3v11V4TuHwXMVMS5XAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=OCHesFF8//A0zaC61op3thmafZuokfM0wtk/nGR7unwxA6rAoQyBfDdNAja9hHcQm
	 63kdmOZXk9Xh7vQBQCm6+8Y6Gtt01PVDdrkYEYbDSgKpGrsIItxyQMzDHCKFaP6965
	 ZbKaf/LU4f59jQDD0vErq6gZzwGVlmNWtpMYBwx93bFUnWBvHWwlhfRY/p4QX8oApc
	 nFAecEk/dDfyLFdmUHUwo1PYgx2WjkL/r3jTwNpprMMCg+hs313gh/Mmz7EaYLzvCT
	 aih3q50WkLu+GzTRY1VgHueBVKeLTzf2UkmjfdamM1T0vHg8G6E/5X06pm/EgXSum2
	 yV02N2ttD+XPg==
Date: Wed, 10 Jun 2026 18:00:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Oleg Makarenko <oleg@makarenk.ooo>
cc: bentiss@kernel.org, stable@vger.kernel.org, 
    Oliver Roundtree <oroundtree1@gmail.com>, 
    =?ISO-8859-15?Q?Ryno_Kotz=E9?= <lemon.xah@gmail.com>, 
    =?ISO-8859-2?Q?Tomasz_Paku=B3a?= <tomasz.pakula.oficjalny@gmail.com>, 
    Anssi Hannula <anssi.hannula@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, 
    linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: pidff: Use correct effect type in effect update
In-Reply-To: <20260609160031.493353-1-oleg@makarenk.ooo>
Message-ID: <r9903509-5s4n-o1qs-7798-sn361qqp0282@xreary.bet>
References: <20260609160031.493353-1-oleg@makarenk.ooo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 9 Jun 2026, Oleg Makarenko wrote:

> When updating an existing effect, the effect type from the last created
> effect was sent to the device instead of the updated one.
> This caused incorrect reports when a game creates multiple different
> effects and updates only one that is not the last created.
>=20
> Fixes FFB in multiple games that create multiple simultaneous effects
> (Forza Horizon 5/6).
>=20
> Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
> Cc: <stable@vger.kernel.org>
> Tested-by: Oliver Roundtree <oroundtree1@gmail.com>
> Co-developed-by: Ryno Kotz=E9 <lemon.xah@gmail.com>
> Signed-off-by: Ryno Kotz=E9 <lemon.xah@gmail.com>
> Signed-off-by: Oleg Makarenko <oleg@makarenk.ooo>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

