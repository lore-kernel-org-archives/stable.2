Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5130EF8F;
	Thu, 30 Jul 2026 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414722; cv=none; b=tVeHQ/ruKQm5n5fQpPddX92S8RRpuo5b9RR3Z/wZ4nS6EjQhCkZEhQVlEuPDsNa6OykIFlSDRdjt++BGfot4Gc1tnAVtBEC2MVyFf5GGEArZWZJ5UkZCloeihCBgnWthoVQ8GJeN+XYjLeiy4oErb7qDtW/ZJMQXdtLLCJ+zK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414722; c=relaxed/simple;
	bh=AT7LcTBqr+06X8iOSbtayNbvLdh9NEfPIl/wI93HtNI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/NNkY8nsyPHFJMd8my/wmXuMewgv390fnYFZLTXTKOzoW5tvatl90zw7PNQdJcVg6Uq94UlcWThneji5LkJ1x/Sz9qUk/hNyKhIvWEOKroB/rhzFoJEi+hqWSCYXlXHuiieQrqqL/SHuPJiOPhBIEShqBcVvFiw84xnCqkXyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dawidwrobel.com; spf=pass smtp.mailfrom=dawidwrobel.com; dkim=pass (2048-bit key) header.d=dawidwrobel.com header.i=@dawidwrobel.com header.b=LivXIVG3; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dawidwrobel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dawidwrobel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dawidwrobel.com header.i=@dawidwrobel.com header.b="LivXIVG3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dawidwrobel.com;
	s=protonmail2; t=1785414701; x=1785673901;
	bh=AT7LcTBqr+06X8iOSbtayNbvLdh9NEfPIl/wI93HtNI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LivXIVG3HuP1zvTiTLq9c6nCpllx4ou3Ryb9onDw6/a7sz5yzvYk7ZDPJikFw2D9y
	 Hsp97VfP1zwZLBY2RN0Urijp9vA49wYvFrFpnghM5PH5prnaZ1aXaqABrl1J7jfmLj
	 /dMUKteRv0lt0I2s7kZmjyI8YmlReR2bOAJaDVLI6abPXSFJNZpGNkth7f8IUrDVA+
	 WCPdLdCxNH3FpIE64ss7zJ6mCArAhbs7fNZgoJraQwsrgvFzpGleQiSB105lsZ5Ylj
	 YE4RLltCDeAfg+FINkpyMZgMjGFBbKVvsCkX8bRrMpAhbWSlybcRkpmK+USAUfmYUV
	 1mZ1EsJq5go6g==
Date: Thu, 30 Jul 2026 12:31:35 +0000
To: Mark Brown <broonie@kernel.org>
From: Dawid Wrobel <me@dawidwrobel.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses
Message-ID: <63381a62-771d-4a00-863f-bf18af8bcfc5@dawidwrobel.com>
In-Reply-To: <e9b81e2d-a140-452c-950e-2cf299d7aef7@sirena.org.uk>
References: <20260730-worktree-lpass-tx-macro-enum-fix-v2-0-6d091c736116@dawidwrobel.com> <20260730-worktree-lpass-tx-macro-enum-fix-v2-1-6d091c736116@dawidwrobel.com> <e9b81e2d-a140-452c-950e-2cf299d7aef7@sirena.org.uk>
Feedback-ID: 173987960:user:proton
X-Pm-Message-ID: 2c71c97e0a2e5fc37ef552db1ed9b33fa0e6c158
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.07.2026 13:56, Mark Brown wrote:

> You had tags for this and patch 2 on v1, what happened with them?

Srinivas's Reviewed-by was on patch 1 of v1, I dropped it when I rewrote
the commits for v2 and didn't follow with trailers -u. That's my bad,
it's my first time with b4 and the workflow.

Patch 2 had no tag; he asked for the rx_mux fix there instead, which v2
adds, so it needs a fresh review.

Happy to resend a v3 with the patch 1's tag collected if you'd prefer.

--=20
With Kind Regards,
Dawid Wrobel

