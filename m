Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705031;
	b=DkEfZ60nxsJXKe80r5hUFAbfp6KFqkK/ECxzJ6WTjtKFCIhMW6G+/IjnCGUrt5qVu+4u
	 32P77D2cob5+Zgfw5too8VmDwU1D0ijDF6623D3BA6D8jD+E53mgh5OCTv/V7+6ytyNEL
	 2e6Kic4lc+/OsBlFgt2kCCZAuw9yM8ImCyQ2M9HoHbGovBEuwDrasnmsA1dwSbOO8I1Pj
	 UkglADY3K4gh+6utQwbXHiTntJnnKy70BtMQCD2n+6s3ZlzW7biqouUyGdDwf1pyifQd7
	 eJv61BrizH9bMjv/7tPpqgKQGnRh04AFzBJ5YnJx7CcdASYvW8nlcHoJnysKK4Yh38Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705031;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=O0ydARdHpR5wmfKN3T0hTmGNcktwao6e7xy0q9wcayc=;
	b=gd1y1XF6gxrySXV6jlx0A0Un4gzPi3Ul2QncK5degqBq2zk9YQM5XTpzZMtj3U2eGU2l
	 bnkjFaxB+R2Zx5azWg+hUhPa47rLLPZCthsYn/6K1VlCUbS9o6JyRz47LSD7yJh999xHI
	 pG2MkcSuBFeVPCzydzPMtaHd0KuwM0qM2gAlYcIM99s0OUqVqsAd6fcj0bIz8GxSKB7IA
	 mx3PjLzf66O1GtHgHZXgbDQALZ5qLW5x/KVjMWrKrS+yAp8pTxLo1eVpYrRlz1ccdtGAn
	 GHnRIx2+rcm7ZB8eJa+pkKPTWlLRRsDYeypNsuRyl3CEZqEl4SRZS9Rv+hFFz5tD+Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hnXOwQSv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MgB2phEo;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807B606D83A
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1807B606D83A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hnXOwQSv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MgB2phEo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793705030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0ydARdHpR5wmfKN3T0hTmGNcktwao6e7xy0q9wcayc=;
	b=hnXOwQSvpTzlV+fVFxTqb/b1MyG3V1waxmxHdd5uG0YNs/zOj2VfZ/a2rp90WMU0b+suQM
	mzMIZdwM6/vHtClifgvi57NMDMRkwrZNlHPgPhuJdkcdpwBU8dx1SPlKsuBjr9Zu3COE7Q
	HDpAwe3Zg6JkTqexRoKs4Cu+kHjCqxA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-BE9D8bSwMe-KewevxWXsNQ-1; Tue, 03 Nov 2026 06:23:48 -0500
X-MC-Unique: BE9D8bSwMe-KewevxWXsNQ-1
X-Mimecast-MFC-AGG-ID: BE9D8bSwMe-KewevxWXsNQ_1793705027
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b01a74792so2737735f8f.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793705027; x=1794309827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0ydARdHpR5wmfKN3T0hTmGNcktwao6e7xy0q9wcayc=;
        b=MgB2phEokuXFg7w39ty1l9ZFsZTBAX8R+dWoG5gvy617XkU0uZHoqTBopqqt3lRTLq
         blzokt4rnI0jci/wON4rBAyz3ymSjDPuYYvvgpRB+Z6f3HwFauHAnvmtOxYHvnbXYfLf
         63WfSnjAjH7yfLGVEf+/wmywvob7lgH30PjRClaVPkZaB46WIwT3CspJunPJI+Ie4ngg
         K6R66kMp5AVblJATine/TOyg2tYrJJJ3m+CbKfdD21IM/V5rrYjJxFryidZmjMqHNLx9
         MZDTr9SF/hTW/t0eqEh5AA5KtmrVZ6dhEqr6dORytMqwjf1mVHryp3dvKiE/IpaNz3Ac
         aIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705027; x=1794309827;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O0ydARdHpR5wmfKN3T0hTmGNcktwao6e7xy0q9wcayc=;
        b=LbwA1zv7F2fPQowAte1QISkcgI1MfCbvujEauANJghZdst7ahFpxFeIGtHMjAwFt9n
         36rhlt0Q7PwUSkz0gGhvLmMO1JPMIfo+vqGIIdJdJSrC8Vzv3LAxiHG7dQnGB/NJ+K2F
         9ecEkNyc/mCg1f8qojz43e0HDNZE076+pK51ooqV5ofBenTm0KiGgIaeB086cNlMUKFI
         JXQZ5TQPiYH+Aqy6bHaah3pEJUMjPtM+AbTmsiurWB+t6vrIYn9yqXLW6SNaM/574ZWj
         tgykAxI02wV+UXNc8GQFERGmGnEyP68tzVVC41iLjP7KaOM71/R7hVcicPUhzWYPJf7P
         7YNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyqsWhN98wnneWN5faUrgnVPQV9uG0iWBwabI9+JWH+qjojevsY0YPnBm/CdYGu77b1w+NPVM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9c3vYOpYHaOl2nNk9cuHUlLvPkvb9AdS0M7VJp0UNn7wrOEIz+
	DUM3QZuGbiJxHhR0MENMT3bqTvUQYgNdV2C4XHZGysVsVzGybKjwphf9EOu9EyNo8+4sD7TluRQ
	2ahG1xpApTFrrO2WdE7S8sY17YeQ5eqD9QIf3O+qqBVojIu7QOVkP3fhBuQ==
X-Gm-Gg: AYBFou3sg6UklSDqgIZyHR7kvaw7QbEK+3NkSminP0dZe0Ow//pBjr0oyXeSAAAQh0u
	WEvczMY/yKlxnv+xUBZckSFU3a72DbSqpkbv16TbmKAiM5tyVl9laei7piDwL8eQCAR2eVEOK42
	WLG0XuES5aZ8xPEk+hmkuv/CmEaX1MN7rgJkwQj8Kj+2zOAwxDzQ3+NWEP0DDNFpPrsUUso6MNl
	KM//x38KCrC6fYLHQ7NS1oUzQFZ4UmGQj+0QHodv55fYiMGoBKAMRfr7A5RBkjOanLelHZ2K7Za
	2uMLcY8liMWAZQP0PD8TmgU90kiMIP6jm04+6kZ9yM5bezgoYtrI+VcLy/gE6SygT4lPuxELP4a
	Hvhgj5BR+PMxjTCVJiQ9GbFyDFduugpEczf/Tc7ZV6dRftuCkIyssIIYWvhkqwhVkiOSrw8Rj3n
	BsO6X3sfLamYWZCrJO8f9xi8HWUvNkz5o1GWDq2gnXU3Y=
X-Received: by 2002:a05:6000:1aca:b0:48e:932:aefa with SMTP id ffacd0b85a97d-48e6e2f66b5mr28935378f8f.26.1793705027379;
        Tue, 03 Nov 2026 03:23:47 -0800 (PST)
X-Received: by 2002:a05:6000:1aca:b0:48e:932:aefa with SMTP id ffacd0b85a97d-48e6e2f66b5mr28935346f8f.26.1793705026929;
        Tue, 03 Nov 2026 03:23:46 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78c10sm24129554f8f.25.2026.11.03.03.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:23:46 -0800 (PST)
Message-ID: <dd92fa56-7c57-4a6e-9598-20d4363d0a66@redhat.com>
Date: Tue, 3 Nov 2026 12:23:45 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ti: cpts: drop the refclk mux node
 reference
To: Wentao Liang <vulab@iscas.ac.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261103102858.1340800-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261103102858.1340800-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 11:28, Wentao Liang wrote:
> cpts_of_mux_clk_setup() obtains refclk_np with of_get_child_by_name()
> and only drops that reference on the error path.  of_clk_add_hw_provider()
> takes its own reference through of_node_get(), which
> of_clk_del_provider() releases later, so the reference taken by
> of_get_child_by_name() is leaked when the mux clock is registered
> successfully.
> 
> Drop the caller's reference once the provider has been registered and
> its devm cleanup action is in place.
> 
> Fixes: a3047a81ba13 ("net: ethernet: ti: cpts: add support for ext rftclk selection")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Please have a look at:

https://elixir.bootlin.com/linux/v7.3/source/Documentation/process/maintainer-netdev.rst#L386

also please note that such limit refers to related patches within the same
series. It's highly discouraged to have more than an handful of unrelated
patches in-flight.

TL;DT: please stops sending new patches. Likely a very limited number of the
one you already submitted will be processed; you will have to wait a significant
amount of time for any new contribution.

It's not the first time you have been asked to comply with sanity limits.
Please respect them, I really would not like to be forced to blacklist @iscas.ac.cn.

Paolo

