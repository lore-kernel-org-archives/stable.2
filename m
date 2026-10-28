Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178930;
	b=mP0HT7AlmUSL+x2ufXTVuEe92uyOrw2btVh99WZjtP497lMFzq5Gp9t+9MkSAzxUfubG
	 85lAV54ejxo0dTertpYFnR2Exx7h0SfUyKOb/U9q3ydm5KqLfTaS/Ys8WgnZu9DTCQHWS
	 49nKZSx8Ynhcl2zGZ9he2pB26vhsOBHUmhc+JX8f59wtQ2KRK0BaZ9T/IRq43+HbBmEZP
	 T9kqeHHaDatMcUFYnW7S6OEes/7rV72+LbUDoClRreVRbS3qFOmdTnkbXqAtRvonyj26v
	 G4hCWa0yHsSCgs+q7XEcBw2CR5p+oTycnBN06w2mAAqt5B2P+3olqIGAH9h6vkLimAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178930;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=1PN3XFQA8hmS+b9H5ZLf4bj/cunANQckoieL+vBmMEg=;
	b=QkXhaHaKB9Etl//wYaZBetme1wX6FjUiYJ7yMn5VmWM5WRLUhrGYI3v3OmnUu6xMYvjE
	 b92LBi32clDdlBVDnBBUsSouwOSYqt30LAyLPMSrRavNi7OWnKW00bGMyJetOXKkbaRsG
	 FWKcF2DYob8LL7635crKwaRqGa9f1p5hzWmzlOcXlK6vO2/4ZqwtkXwWm/w2VRvWGhT+v
	 XHlxtaX8TfJAYbAJAp+/JxFbzrZM1+Cts1+b9Ga05f2H2OBFd4G1gjlNv9bF2BEMpTvVj
	 Wq9xIaOOnbElypCXqyJKdCRnPxt1BIuJ3MgpG2nq4aZsTHX2FzOcTA8R3rEy6XuZ0ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	arc=none smtp.remote-ip=109.224.244.122
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A53606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 09:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18A53606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793178925; x=1793438125;
	bh=1PN3XFQA8hmS+b9H5ZLf4bj/cunANQckoieL+vBmMEg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qdf7NK3yWEY+tumIWnnZtkKag9R6cHp0wpcrD9+gA4gdoJ6znBeXKu9UkMN7IqV8o
	 arSoNhHmwFp0Kb3ZAcNOX3RmcqnebxUyUOCgBUI3hgVyj+sb5H0hsnUzXDlk2XE7P8
	 rdWmMFl0G5pwqbIAsHzi6tSqeUzIFTHSfxozem4+aqNTbFCpxjJVyLvx3fzguQVN2y
	 fSGXw1H9SU35PF84RXDJCvDqhCZYh5eFGuj+gqvENdFz0yZz5dcfqccXidkB+vM0ng
	 5fErZ5wjqAmni5uuGt54x6abEB2BUOdUyLwD59VE3rAsuM7D8V6se+CKdab79tMxGT
	 1HSju2+QPQ60w==
Date: Wed, 28 Oct 2026 09:15:22 +0000
To: Sasha Levin <sashal@kernel.org>
From: Mikkel Sejdelin <mikkel.sejdelin@proton.me>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>
Subject: Re: [REGRESSION] 6.18.57: resume from s2idle triggers poweroff and hangs when tiny_power_button is built as a module
Message-ID: <dyJyEj-TY1YtRVdDYPD4xnYF_aIP78z9wliSc3251tj6aZEZxux0c81AiZAFPpZvbg6rjgqivtHTFfY29YHTS9WZmw569IbyVF0NPVTxqrA=@proton.me>
In-Reply-To: <20261024-rc-reply-0001-tiny-power-button-s2idle@kernel.org>
References: <1kU98bgDqqEMGUcpGahaBYlaPiP2ssSCZj1uIKq1MEaGpNv2exGeJc3VWzXxB8-VJQ1Uk62W19oByt2KC-v1bSA4Sux9fBhnlA_IHWjV2Zw=@proton.me> <20261024-rc-reply-0001-tiny-power-button-s2idle@kernel.org>
Feedback-ID: 151291767:user:proton
X-Pm-Message-ID: 677249792e5eb5522e0e2f6eeff973e20bcae6dc
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 10:26:52 -0400, Sasha Levin wrote:
> I have dropped f4203ec64e11 ("ACPI: tiny-power-button: Convert the
> driver to a platform one") from the 6.18 queue. It cannot go out without
> ab06eb920401 ("ACPI: scan: Register platform devices for fixed event
> buttons")

Now that ab06eb920401 is queued for 6.18 again [1], could f4203ec64e11
be queued with it? ab06eb920401 alone does not fix this report: on my
machine (control-method power button, PNP0C0C) it changes nothing, and
tiny-power-button keeps binding next to button until it is a platform
driver too. 6.18.59 is still affected.

I tested v6.18.58 + ab06eb920401 (with Ting-Han's 2/3 and 3/3) +
f4203ec64e11 on this laptop: platform devices and bindings unchanged
from 6.18.57, acpi-button binds PNP0C0C:00, acpi-tiny-power-button
stays unbound, 3/3 s2idle resumes OK, no SIGRTMIN+4.

Tested-by: Mikkel Sejdelin <mikkel.sejdelin@proton.me>

Thorsten: regzbot has ab06eb920401 as the fix for this report, but it
needs f4203ec64e11 as well:

#regzbot fix: ACPI: tiny-power-button: Convert the driver to a platform one

[1] https://lore.kernel.org/all/20261024105710.593-2-ue081723@gmail.com/

Thanks,
Mikkel
