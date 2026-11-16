Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832490;
	b=wFcG6qPfWt0KX8mE+mPwyuTFH72BRkkdZd3cZ7d7i9tUV80r1vTgT1wNVLmtxwS6c+so
	 PQkUyysgeDtFgBPUGqTLt16qywRIUJvQueRsLLfnKJfKaKAT+cVwJT6rNtB9TGtOq+dyc
	 l0N/ntyfv1qKld2l2PB7Kdcmsyljs4Vlf68rjaAmkkJkqQpY6R3t+gjxzDRRipEnfJH9J
	 fElNTGb8K/tSaKUvVd5OO+glfNNpRJHGzG3QWM0CQpGC1TeqarEB+D80E6RttHn01po2O
	 IFMmieX91FUxnxL5zlGtXKFZaGE6c2lIbJR5G6gsl0Rsmfg4fE8UfXonGGepgMOvulw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rmFZBU+djXC1DwS5T84xaTgNqzLLRJFK2oNrTGLRxSY=;
	b=mweF45zztjhSUqLnM0+jrJoy0Y2IDfEwombxh+WGr8iPXjKvs9pwSNiETahKKkGvZDE1
	 Rn+cB8zSnFJ9fKmKlYZhKFH9GvT6e2jcbc5fx1f2I7f65zy9bg7Vw6N+qzFCkhTKhNCYW
	 zER+twveO1v60IOxw6VzGr3lfSRtA7siddrVWc08tq4loQ6zeWZ2Ai5IR51HpMmJ4UhbH
	 nMRSiniWgJsFle2soFkQAQrTb4SlsQwuB7MItlZGW2RNjRnlGfa2n2NzCZvWhk1NULwsm
	 TMVH32Ho65Ku1CnxzVKY0xMH4eLT/fHy/ywaBRNay7LwNn9nzFkGyivgE5/zHa+mBCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcHftABx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3A606A31C;
	Mon, 16 Nov 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcHftABx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84131F000C4;
	Mon, 16 Nov 2026 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794832489;
	bh=rmFZBU+djXC1DwS5T84xaTgNqzLLRJFK2oNrTGLRxSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jcHftABxu0aBGnDyc9/O4/25ziNGWdLHxVYaObnXFZ/zOLWSv10rN9tLoqksB0YoV
	 jAjs7e2PrPrlvW6VT5aWVFBwgW+ea9mFlSjf4H0r3hsSw6Go4U3rUyEpQl728vVw7I
	 MXG8Xv6VSbwkpAUVzVaGcQIQ8z1czhbFoKWgHJyuCRfYCIyRfA6rvUKMIAQ28cYPT1
	 3MYt5J/zs7toNcWHzNavjfhlb5nIB+BLYC9rTg9RSD9j49yI0pJIb68fj5JyTN+ato
	 ZpfFCqR8lOCAtX6eMqixu54p8+l3rDfYDAgDEGtA+LhyAFrlgqQBVAWPxnazG2jWIw
	 uUuEPjDfVJc5Q==
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
	william <assassinshalo29@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	tiwai@suse.de,
	evgeny@devduty.com,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-sound@vger.kernel.org
Subject: Re: [REGRESSION] ALSA: hda/realtek: no speaker sound on Lenovo Legion 16IRX9H since f2293e7b2ddd (PCI SSID 17aa:3842 shared with ThinkBook X G2 IAH)
Date: Mon, 16 Nov 2026 07:34:45 -0500
Message-ID: <20261116123446.2789283-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <380ce8f7-1d88-4d5c-bf3d-108be7055ec9@leemhuis.info>
References: <CAFjFWEjt+DPJ_gM1uTBZ_NoV6-3mi57ArjZ_Qdah2DqY-GCD1w@mail.gmail.com> <380ce8f7-1d88-4d5c-bf3d-108be7055ec9@leemhuis.info>
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

On Mon, Nov 16, 2026 at 09:29:45AM +0100, Thorsten Leemhuis wrote:
> Greg, Sasha, that change made it to 7.3.y already, but is in the current
> 6.18.y-rc afaics -- so might be something to drop until this is sorted out.

Thanks for the report, William and Thorsten. I've dropped f2293e7b2ddd ("ALSA:
hda/realtek: Enable all four speaker amps on Lenovo ThinkBook X G2 IAH") from
the 6.18 queue, so it will not be in 6.18.64.

It already shipped in 7.3.4, so 7.3.y will need an upstream fix (for example a
codec-SSID quirk for the Legion) that we can then backport.

-- 
Thanks,
Sasha
