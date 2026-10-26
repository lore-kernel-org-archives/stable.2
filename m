Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042216;
	b=DLyIjFMlYSzCtAeCyeFXEnRqgxlJP9bKydovYAYN8PL4EZ/84UkP4cTsPdQ8Q9n0q9zV
	 RjP4/wqlFTVfR0hBvLDWxXrOiSx4KWHaENHm+NG02sx/puQFpmSg29SvyxPMENpQMlgl7
	 +OO74dnMVEJ9zMeGs33zq7kpZNXCZ8651AeBYwZxzXEbZNV5dQXm4B4r3FryVnbtHWBva
	 8YdhBMR2dW/W6rBG2fx4oQvtHSlCaKfgL8/Nc+cvfRSz+SD/NtdJGwjBzcYNbgNbNdhKY
	 tMQ/3OAXHPPyfVpz+Jrl59EqestDJdCbfA+tG88jhTi0hZ5cHpf0g/Xf6AswSURMlHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042216;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lbh+GWV1kRut1smU6QRMLW5UrkQqcBFuFXEhFhwWQ/E=;
	b=LiCuF9MTCg9uk6znLFvgLRAw9zx75lhm15bg4uCFHDDZFJ9APh3oH2gSD/66IbZHdDOM
	 Jo2oAdLIHqnUU5fUIsE3vfnraeLwvw+bjFZSgTJWymGo+/AAkg2/xNhp6k44Mq7p9SWVe
	 F7zgQa5PmmB9WX85hcSLoHWlBBQMBLzuqZfpMC2G01IgTD4PIitddTuF6+Uo0MLnoGkQn
	 DCiIHatcItIaK5O6vkeqAFtw8yXZUAPDUeNOVqcbeVr4Outoy39OvvH0ZQirarqDMU+ZJ
	 +iIA+ieqgTSDejtZlXcL9tSYgV1nN2V0fEklrCWGRJuh+DW/Ir/C2q+2vXFa0gLOqVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoLgOwZU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E4E606A31D;
	Mon, 26 Oct 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoLgOwZU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55C61F01825;
	Mon, 26 Oct 2026 19:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793042216;
	bh=lbh+GWV1kRut1smU6QRMLW5UrkQqcBFuFXEhFhwWQ/E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZoLgOwZUl+H5XyIYOqUUEKzY8hYffRNF/LIUfA/4Bw4Dx0IYLznldK4rVgFa1sY6j
	 C0QCvSAYCwIv5SVXhmBRfUtePjH04Z0MbYGfuLvU3xYcl+n7u/wx7z23zZdTgOaum4
	 5TL0UuQbPMBe93p3i/cwbNOk8L4tZWAFJTXoHo9B+9tFgPal+sszQ4bH6LC85ZTyIs
	 zt1Kqp+/eZq2soRYJlog8z45BfVFbQz3T7VpaEyu88ndo7Rmn5dlHCJoUGwSC9nNCv
	 l0XUaFCKdeGAGRXJUd4rOp38xGzJemWtWRZ5sSbUZbGsSkFvp4fi8hXgNv/jrcSfDK
	 r8KjnE+W4SkSg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 148E81E90F09;
	Mon, 26 Oct 2026 19:16:40 +0000 (GMT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/4] ASoC: wm8994: drain all delayed works on component
 remove
From: Mark Brown <broonie@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
In-Reply-To: <20261026112212.2519775-5-tristmd@gmail.com>
References: <20261026112212.2519775-1-tristmd@gmail.com>
 <20261026112212.2519775-5-tristmd@gmail.com>
Date: Mon, 26 Oct 2026 19:16:35 +0000
Message-Id: <179304219595.199157.13551236801470913265.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LzONRaLFnhmRhp2UJKtSqTjqeEAEdCVQBTALcaDopC4=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLuLxdvfvi1O8Dp/Tsu6XtGEzX2c72dcorPSrVD6ey6Z
 o+6vaxpHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjI9i+MDAv6D2Toh7QULHzt
 WyHm0/to7pG1WzZ4WBtUvjs197bPfQ5GhksvZ28plqsJ26Yun7rKduGFku9vDE+3vNJgFrh15tQ
 pL3YA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> wm8994_component_remove() frees IRQs and firmware but does not cancel
> any of the delayed works that IRQ handlers and DAPM events schedule.
> jackdet_bootstrap can spawn mic_work (via wm1811_jackdet_irq), and
> wm8958_mic_irq can queue mic_complete_work, whose callback may in turn
> queue open_circuit_work.  If any of these works are pending when the
> component is unbound, they fire after DAPM widgets are freed.

> +	cancel_delayed_work_sync(&wm8994->jackdet_bootstrap);
> +	cancel_delayed_work_sync(&wm8994->mic_complete_work);
> +	cancel_delayed_work_sync(&wm8994->mic_work);

Same issue here for mic_work.

-- 
Mark Brown <broonie@kernel.org>
