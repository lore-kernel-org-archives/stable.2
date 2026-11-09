Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239644;
	b=Au1YtasKrfUmz3QEG9fN3Suee+nLUerPItj9AvbSV3vMLrrPHaOVIdg+TJ36A5OZOl5e
	 dLDQm4xoW7ZkwJD8gYWU7rz6MbdyjIbj606wPRZkNRaHGAy/LZntbxUJX3NZ0jcXpp+dM
	 EhtxL6v4FE1p/BJ3qgAY4SVayqqxyeFdismLSOpFXm3TfgqMxHiB43X+Q0OgDOYNwyBWk
	 tryh7DXIV2XyjRg11Kn+Znprxto7d1+8sHn09q94WAKo+vegs0sQF1wxr7BLv5CHOWPiZ
	 61J4MBP7WGvDG711/FxLZN4pkaGnLnT2ntxohUOuxJfdUFFm9NKZtVCylc22ZeJ/0mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239644;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BdOqqC5U+uZcc06IUzEeh0VywQwMVK3RAKt+MwEmFdo=;
	b=UZ8iaZpPXcf5MCVnhj2+EZi5jsES5mAn77cX5dUO3j/bbqyT7jI/4LtPja/maqKiXUE1
	 W8PwU9qrSj3fviDuOGlFfdUFmn9004CY7jA8SZ50Djn++RB5OqEcpiJ7JGgPeQ/O4Wjan
	 L8DnYam10LjuR87k9lx63BC1XzxYzOnZGZL1kqxkVbyh1+zxXTApsmIFTUqp33uGQL/5r
	 t0vs6FOkYP0T/Qml18XAtwZntYT4R5+4umC2ulbV6WzeB+UgCYqEDytA+CThuMpzwL8RW
	 dpqY1Qe7eH2TA4mp4c9SKiSDhNEGy4lNNQzKtTBf0cIVDxkESX6c14Gmy/4pwGSK0ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U54R1lZQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65E2606A31C;
	Mon,  9 Nov 2026 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U54R1lZQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D011F008A5;
	Mon,  9 Nov 2026 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239644;
	bh=BdOqqC5U+uZcc06IUzEeh0VywQwMVK3RAKt+MwEmFdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U54R1lZQeHNPbfINKaao2TRdBsSTs2dYJMAGRuQqOlbCYuBZ/q+bWcPT1sggigqBL
	 BZYa7UpptPAEKv4P3KEdjV+rriUJoMDKZuki5lgwACoV68++2OPG10qc1UNj0SZgyi
	 tVsXP/7rIZPXdMYF6guhUqkaWwn35YsmrUqFfTa3EaAPXJ0XDqqiEx2k2gn0WYTvFb
	 fLFtJNau+vJGQsxwtO7rEftIA86Io/3u7diEguaG+w0gE+0QpxR6GT54sHYGlpeSSO
	 qTI9OKzNUcRm3aONY6U5NP6ok+XIoXfjgRMofWN6EaUINe3Nkleo/mCyPImYkDvI0w
	 hjXNeVKCEIcxw==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [STABLE v6.1-v5.15] ALSA: usb-audio: Don't try to submit URBs after disconnection
Date: Mon,  9 Nov 2026 10:53:19 -0500
Message-ID: <2026-11-09-1-daily-reply-0037-alsa-urb-disconnect@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109090346.2098226-1-lee@kernel.org>
References: <20261109090346.2098226-1-lee@kernel.org>
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

> ALSA: usb-audio: Don't try to submit URBs after disconnection

Queued for 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
