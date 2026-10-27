Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.141.101.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111287;
	b=eDPw3vAwEKlW6h5SSuzOtAAcQ8iWWGyJ4UlOvulMUJgBKWVItZAms2o73CXVge5o9iXl
	 wNJTQj1LuxWwyN7N7rem5tI+9aNmieLaTB4QySs7fY24zDeGi1ARlmpvqFGCnl+ZQf8kv
	 L7dZnLyA965rCWJ/QaCnNObU8/7TgHDMGKSCGVeUKC3KwfrSaJe9LnGgg6XrIjCx6Xsn5
	 Hg0VtV+Gi7JZpBey4fZ8dnmaVk43vOb0x6ffEQVW3aiRd/PwwdsNEdsUEGdD1T5375sp5
	 wd24WZDAbM394DBK4xh2x/nQdAm9j6KATuN4u+ielpHfUpJ3bVm9PB1Gnj8wLIbI2fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111287;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding;
	bh=4TLHcrtw6IrcEVxI9pF3mkOj/gMrMQ9fzPgGyEHLP0k=;
	b=RePmlYheDZI8nfG82MqPzAI8qR2eu2moxKivQWEMe1cUfg+D750VHKcPfoP9/I//mK5s
	 X4DJbs0w5g2KT8cWtCnpwiLqGR7ray0X/TOSWvrmjGQL2x0MAWx9dZwXsas/lwawHbHyT
	 KN00gQD9aQwgo5WwGYRfM17UQmdniFF7if7301I8vNFYisMcXFmSe3zkBryV5FvBRXWDs
	 aFaRhJh7U7Afo5ii0gs/Wq23tErO4MLIyNhzu20Jqm14yYUrE5LubM3uIDdpRGpJOlvN0
	 O+LrvxDuz3oH1s5EJvls9Qw8mvnfjIZPg58FaM6OW/QMLeDwr4BnAgEyKVVwOwooP+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trvn.ru;
	spf=pass smtp.mailfrom=trvn.ru;
	dkim=pass header.d=trvn.ru header.i=@trvn.ru header.a=rsa-sha256 header.s=mail header.b=qNqfC3hO;
	arc=none smtp.remote-ip=45.141.101.25
Received: from box.trvn.ru (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419D606A31B;
	Tue, 27 Oct 2026 14:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4419D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trvn.ru header.i=@trvn.ru header.a=rsa-sha256 header.s=mail header.b=qNqfC3hO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1793111277; bh=p1+ij2iMuXuasPgjVBkuIJvZLvt/mKAVeXHQ3uPoZLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qNqfC3hOsG4iEm6XhIFwEWEX05lu0cWhKAnDGXJC69izlWaGfZZwFASNIYdobchDU
	 OvHpg0GtrHABZkkdPS1Wl2zQNcLPN5wdLda/WAB2XT5JH3b6+PYtijnaDcP4FNdWM1
	 CoNgJVdez6vuNYkgbQaqnuxJYDFu0COiBEpqiJkqFLzLAMr1pmoVyCNYoTCQz8vqBN
	 CnIxDb7oaTnm6baJ3dy1u7vkfaAAUQny+9yCYouC4T4bw5u1OJ9nbR105d3ouRqoU9
	 P2Rgnq38AXrhmCWE0A5WRwQ41vYeiaTrrWJSDJW+WriODuscraJ7KNDJPioaEpN7Ih
	 bsOycjtE6F7nw==
Received: from authenticated-user (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 9176D22E58;
	Tue, 27 Oct 2026 19:27:57 +0500 (+05)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 27 Oct 2026 19:27:57 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Nikita Travkin <nikitos.tr@gmail.com>,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 04/21] leds: aw2013: Guard LED array index in
 aw2013_probe_dt()
In-Reply-To: <20261021123406.3163547-5-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
 <20261021123406.3163547-5-lee@kernel.org>
Message-ID: <b4af6497af108a46ea3ec8f9219ea81c@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lee Jones писал(а) 21.10.2026 17:32:
> aw2013_probe_dt() validates the initial child node count against
> AW2013_MAX_LEDS via of_get_available_child_count() before iterating over
> available child nodes with for_each_available_child_of_node_scoped().
> 
> Add an explicit bounds check on the loop index before indexing into
> chip->leds[] to ensure the statically sized array cannot be overrun if
> additional child nodes become available during iteration.
> 
> Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
> Closes: https://sashiko.dev/#/bug/linux-577a1fa0-4e80-42cc-8c7f-34c43c131d95
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Nikita Travkin <nikita@trvn.ru>

> ---
>  drivers/leds/leds-aw2013.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
> index 216755d6010f..dfeac8b2993f 100644
> --- a/drivers/leds/leds-aw2013.c
> +++ b/drivers/leds/leds-aw2013.c
> @@ -286,6 +286,9 @@ static int aw2013_probe_dt(struct aw2013 *chip)
>  			continue;
>  		}
>  
> +		if (i >= AW2013_MAX_LEDS)
> +			return -EINVAL;
> +
>  		led = &chip->leds[i];
>  		led->num = source;
>  		led->chip = chip;
