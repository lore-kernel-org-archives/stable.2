Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0433CAA2F;
	Wed,  5 Aug 2026 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785972610; cv=none; b=D5QIrWUC+WbYvx1dgf2AAkVLWdfmwHePItfjgCnDVofxM8VOl12QnPbhrf+FmFFK9GDhCa2wQaSZxRGOxYvpf76B3TMnqno5N4O3OrvwwDAWu07l38A5n9Qey5O1B7J7eweGsRngusCIsni4lrHgcHKswU9+2LvWku1FBTUPZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785972610; c=relaxed/simple;
	bh=0SifzQTHOOehF4S/kzTpYZvq7Zhk6Cz7LbL2xIBuE30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckeVQ4k9IID9x41D6ap0onOkhZLZ/6QZzr74Tyox6P/ICrYXZn3cRVmLbaWwxGciRJJs5h7eP5ZX0p17rko2pFmDFj7rzGurwBW5mSxYD1uxulPScGjOcFPieCH53469MlLaQgEg8GUg0tY6f2jmRgA+heYT8U6/H+ckn/tThFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jei+ibwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jei+ibwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB12B1F000E9;
	Wed,  5 Aug 2026 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785972609;
	bh=0SifzQTHOOehF4S/kzTpYZvq7Zhk6Cz7LbL2xIBuE30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jei+ibwUbxw43WhI0yNZT5k6oVJ7NyUtIuDuC9d3ch99ebHyW2ELUEV5KP6UOP1qp
	 oRqTEWV/tfII8hVvdsWsuq+WwzauCHsIeiPrvIBBMcNH+q+bgvwEHJwyBSCY7Q+vnt
	 q8pvvfLEghXn+PIZCb/iayX8SwekBM0dP8EGP6VQ2/U3xfrh9w5tFQB3rxFVSF/eyZ
	 YufwGJU5cvQd2wsgzh5FKftaLlOvpqyHUkTJgf6oDtWW/k4y1sV2L8EfzXxdJQGTNZ
	 rldh21w7rRPFGUbhTYQ4CnME4v/QHK7FrHoAiPme8kdZ+iiRAUkTqTQDKilAi2y51Z
	 gdXgYZE8kWT0A==
Date: Wed, 5 Aug 2026 16:30:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund@ragnatech.se>
Cc: xuanqiang.luo@linux.dev, linux-renesas-soc@vger.kernel.org,
 netdev@vger.kernel.org, paul@pbarker.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 richardcochran@gmail.com, masaru.nagai.vx@renesas.com,
 sergei.shtylyov@cogentembedded.com, luoxuanqiang@kylinos.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: ravb: fix use-after-free in
 ravb_get_ts_info
Message-ID: <20260805163008.5ce3ec9b@kernel.org>
In-Reply-To: <20260805083652.GE346309@ragnatech.se>
References: <20260802090750.116215-1-xuanqiang.luo@linux.dev>
	<20260805010620.4093075-1-kuba@kernel.org>
	<20260805083652.GE346309@ragnatech.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Aug 2026 10:36:52 +0200 Niklas S=C3=B6derlund wrote:
> Some of the issues pointed out in this review are addressed in the RAVB=20
> PTP rework series [1]. I will respin it as soon as the PTP clock for=20
> R-Car Gen4 is merged [2].

Let's fix the bugs correctly and then worry about -next
I dropped the series you linked.
