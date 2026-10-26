Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042513;
	b=oHFqIppPDbhsfrG7D4CEDzycudLNKE4mvq9PW1odgcGQ2K8nVtgNpE2WgnTRB95FlPIk
	 kv4vqwZmXEqbMEg2yAvS9vLG/+QMpVAUTzLSe1YW9tqIN4toKzs7Jad6rZ5KqI7WRjhdr
	 Z9AHOUTWY/4SZcsDTGswlbtTMsJxcXGqJiGkz5EDcuwNFP/TgD+blH0SgdpLCwHbatLcN
	 +DI7VgjG/m1OZWqdTL94sIGepLJVb7+MjUGZDI7P2aE6wEqhqHmXIfIxdSFmWBxZi1bmw
	 9w7WlQDRQ0juZJcfyz4SJ1ThU1eyh6bqdlCXEsgCoOL96wJhEshhJ0C6yTLHx/xwMWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042513;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WmoeuFsXA31M2EznPFG8U9N8nAidKihMFBHKRe4hX7I=;
	b=sSypOvDjgZKPXtGTLkrOXpFSCNd7NvWPuWqZouS869mggiy5O7IxAwz1TE+Bzq4ZdfHm
	 ucU0xuGGiHTWhkhTUK7ofLcwCHDnmqqNPYGO9eHj/cNZDwEQubtdai6/kmcVAycCJO5KU
	 QvhNFLAatvHZDka847YbFV+XeKjWkPtrShvwYH7x4fmU8IDS1bzwIa+ueiWx9vRWBqkHU
	 exRjwNT0z8M959f7HPEFyt2orKwbAUXuF2L/fHvaTe9slrSyHRrVZg57mc361hLE2zXAv
	 0ReLd45esBUgPlb/b05temF35s8XCxKAHCM25i7zVYlMrXiyk/lT8tmS/xKpFq/a7rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1yaiL34;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C4606A31A;
	Mon, 26 Oct 2026 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S1yaiL34
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226491F01825;
	Mon, 26 Oct 2026 19:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793042512;
	bh=WmoeuFsXA31M2EznPFG8U9N8nAidKihMFBHKRe4hX7I=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=S1yaiL34A9dkXcqw366OFdsrlW954k35TohnMw1DYGx07CxZGjlErf7gfkmxdMKz5
	 gQkcyQJUE7xxNl+FgJDmWp5SfnWQoa9Guc6ldPk3iYtYvs4A9Co3rGSgv48hbEHLSr
	 9CNLQnzvhpLkn338FYeRmWt+O8pyxtqtwov/scjsMzk6OCTPWh76+nIezRzX+wGIfy
	 fzZmMR6jw1hJHVQi9FqqICgzI7MW6XoX+i9neTK1KXYTkxRak1FveOwKN9y2G9FvOC
	 SQ0VBxqAUWnTg4ZL9Dny2RJctLRHaTwyTOJJE/IaY0WT/y52kLq/haNuVnfnTPnlvh
	 TMzO1fEBpmvbA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id E51361E90F86;
	Mon, 26 Oct 2026 19:21:38 +0000 (GMT)
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
Subject: Re: [PATCH v4] ASoC: wm8962: Stop IRQ from requeuing mic_work on
 remove
From: Mark Brown <broonie@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, stable@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261018021817.3859256-1-mhun512@gmail.com>
References: <20261018021817.3859256-1-mhun512@gmail.com>
Date: Mon, 26 Oct 2026 19:21:37 +0000
Message-Id: <179304249765.199157.777814695167017971.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5pKCCttCUtEYyeoktnWE3/k4cIw7ak0FrJlN4YB/jH0=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLur3D6+ez/i6DsIxGLNx63z1LRenE5dN0VyWfyrKf7n
 musniXC21HKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJfK1m+Kd8sok/sc1urfdi
 4/XJEV9vrl4V8uzEVq63u5669bSv8d3I8E+7e1dV8c1/CvYHrNsdmDwFfv7aLOTzX9Fkx2e21NS
 v3VwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The WM8962 IRQ remains registered to the I2C device when an ASoC card is
> unbound. wm8962_remove() cancels mic_work, but a MICD or MICSCD interrupt
> can queue it again before the component is destroyed. The work then
> accesses the component and reports to the old jack.

> @@ -3230,22 +3230,30 @@ int wm8962_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *
>  {

> +	snd_soc_component_update_bits(component, WM8962_ADDITIONAL_CONTROL_4,
> +				      WM8962_MICDET_ENA, 0);

This register is (sadly) volatile so we can't write to it while the
CODEC is runtime suspended.

>  static void wm8962_remove(struct snd_soc_component *component)
>  {
> -	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
> -
> -	cancel_delayed_work_sync(&wm8962->mic_work);
> +	wm8962_mic_detect(component, NULL);

This means that if we didn't enable mic detection and the CODEC has
runtime suspended on remove this will now fail to write to the device
and generate warnings.  Making the cleanup conditional on having
enabed mic detection would avoid that.

-- 
Mark Brown <broonie@kernel.org>
