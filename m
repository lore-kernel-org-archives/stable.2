Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308066;
	b=wwPMcVOzKyQLj9sfg123g/6uPgJ5U7QMlV/ZbB1sPgcnFt799EEUjK36R7N3HaUjq05z
	 SivoZG0WRXIwOUaspvIZVjOaDI9h9qn+f/aowcS/X/iGLWHlIs/uR0QmBtiaHAoQuEjjD
	 S/qa5cdzZc1IpfqgAPp0gTqQDLPuFiG+LV3RYxdKB8a6BkYNObrCsftDgtZeIo2JsBuA/
	 yIRzwwl7gsD3+GPBKNB5HKwO1g34Xs0OtgxqTct46GEZcsa1bUvHffc62/s9r10Ga05a7
	 5YMHR7r9bPynOzlkYmBUZcxzzcXippPYc+gCbosEmaTVd5ENjrsXHfucNhWVKJ8EM6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308066;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar;
	bh=j4KLqGxuWpXG9O78us8mIzIwRiygY7y78UqRO7IA57U=;
	b=yReE8lL5Ig+X056mKQz4vrW6WbTPkGqU1sExdp+XBm3+dGucUth9wTeMKICMId5XIm1h
	 Ac7fLBqXNLARPliK0q5X+b2WRTkAB7WpzCscsWcPpzyhhoQ2rqCm9QS8gYrI10K1dnsuj
	 Yb8FksPE1skePwcwn6a9ecw9V7Eppp1aLyiWpMASYvkCCIaPAS8B6p8XdCUkb3EYiznBz
	 vRp5tOeC5d8/4rgpHqXvqwI4O4s3VQ12Q4+pIS0LJUCnpB6Qycmu0PPzq0Ud7BAz4cD8a
	 cSBATe826VkSx4Wh56W9uSaucbP8D90lK8LJAtx8TPdEaT9+kpe6oAd/xZ774v3u6GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=BtOeV4R5;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08814606A325;
	Tue, 10 Nov 2026 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=BtOeV4R5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=j4KLqGxuWpXG9O78us8mIzIwRiygY7y78UqRO7IA57U=;
	t=1794308065; x=1795517665; b=BtOeV4R5zXkyFvUeQvqvVMbT3v2msjcPcEXWVx7aPulo7f/
	qShQIe2LzGE4Mp13mkE3h5KyTUSUpo5mcLHY1uV3TBWGChlLwkeVO5zcQZ9Q2YNxdkTE7d9zmSwJg
	ztVdtsC9qy4co2Wj0VThdjTLXtXpJKcYo91lGcYSg+Zjb7YSYrsPnbuCTy+d84AdUNwJ44tJ3K9v0
	Iu9WxGBT/XZSogVuP7gYVgfx3IpStlkqwmrgpvzIZ5eU3Nr/5S/c6jArspVSOTSjcxOf+f42mrNcZ
	UIxVtMHxEIez5tWm7RLFgRDAYO+gRb+5eO6r1ocAxiCJhJW50jhknYsgqIiOYnBw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xQjUc-00000001V8r-08yP;
	Tue, 10 Nov 2026 11:54:22 +0100
Message-ID: <76bc126fb977cac0f0a124fc80eae9fdb803264d.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: mac80211_hwsim: serialize radio removal with
 frame commands
From: Johannes Berg <johannes@sipsolutions.net>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: "John W. Linville" <linville@tuxdriver.com>, Javier Lopez
 <jlopex@gmail.com>,  Jukka Rissanen <jukka.rissanen@linux.intel.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 10 Nov 2026 11:54:21 +0100
In-Reply-To: <20261028141751.6728-3-enderaoelyther@gmail.com> (sfid-20261028_151822_083722_A5EF7A18)
References: <20261028141751.6728-1-enderaoelyther@gmail.com>
	 <20261028141751.6728-3-enderaoelyther@gmail.com>
	 (sfid-20261028_151822_083722_A5EF7A18)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2026-10-28 at 22:17 +0800, Zhao Li wrote:
> Destroying a radio while a frame, TX status, or PMSR command is in
> progress can make the command access the radio after it has been freed.
>=20
>  DEFINE_SPINLOCK(hwsim_radio_lock);
> +static DEFINE_MUTEX(hwsim_radio_mutex);

That, with significant work done under the mutex, seems like too big a
hammer, can't it really not be done in any other way?

johannes
