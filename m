Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585657;
	b=Wv8ocs0DI4A8AzDPLTsmMbDS4J4YY9pY9GI5rQ+JWP9LeIGBGbhwmUbc8NgY9TIvW3mn
	 svKRMutlSNXgrf92uIgh5yroR89iS1lAIUXd9RSHcHUar0DzxfS7Jbh3JHwgwOCaFRRXU
	 jTdB/UCYDnbQCO8ItqOv1ZPI4c3EqX5QtmEu6yjqDKtTEKV5WmSxlJ8tGdJNG9bTRaAs6
	 o94NXh05AlrKZCTsHEprZlBDN7Mkf7zIO5n6Nx6FQPrdKDs7hvmVWwwOiPFiDwBXipL7s
	 cV5eLr9Ty/r1WSFtIucSiobyeGEJlOQ/3XRnnF5S3UuaLBzboKNSfOsXPcgsFvYiLcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=76hK192hwNNcxMcbm0UzywzzRTcZcsnY/gd0BW0R8wc=;
	b=hVpoz+uhAb5ux+0Sj6aEaW4EGM0ZSEoQNop3QlpUSRhI6TkYcUgwB+lZofmF4EDMg1TL
	 NSoUOiwn+PgAeBE5tYOKTDWsLnVCcip1OxrVeedO4zZXACIlGZWP2JwgS97TRd6fHnLpE
	 HM5bQ/VO+XVuf3i7TJjwiMBpw1LE7EyBeyIpH+wKXyneQycdM1MBGed8mFp4yZUktLjg5
	 iCsNxDCQ8WjnW0yCVPGdMWRAjAG+b+Xu52GQRw/eyJMz1ux2ldm88iKfUQ81mWyUG8/df
	 0h3DD9rubEGrP8+rpGT4sMm3jqpXST4fyEDRt5pKEQ1UEid6a/rNcbseGK3O3c26dfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNkjY8c5;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D750606B2D4
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D750606B2D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNkjY8c5
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37986eb6fa2so2719349eec.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794585656; x=1795190456; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=76hK192hwNNcxMcbm0UzywzzRTcZcsnY/gd0BW0R8wc=;
        b=FNkjY8c5qVoxECoy9cH5IqZVYrIDNUHHh+EI386wFkJOvTo8i7gMp6DoGZKImma+8a
         4xHxER0iCZjoiQFZLsWK4msE8tgrpKQPrqPc6h5XkCBmfK6NvlQAVvavnjIsy2WPIV0y
         +WHgWAkOUdJF4X++yHTft5Pypxk7CHTT8+Yba/4SSsBXJvqU6phdQhBIJd/g7ExMEg+i
         OgowQyD9OfSJli99pOCQoJOvLIA9W5SKPuZlnDX2Lne8OmuFhhaKvg7/hb9DVyFoBORa
         Vpqi7lWnfhJWev1FfnVNfJMP8Dk97aPGObaWfT3OgXLc5CuZzKmIhpszV2ildSXt3Nw5
         jdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585656; x=1795190456;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=76hK192hwNNcxMcbm0UzywzzRTcZcsnY/gd0BW0R8wc=;
        b=c9RLaTI0L8FOHEvqawNx7usPjWNZPL8tv00ioZnQpBduKz7HRpRhT1sOavoPnQ48O7
         e9MGI1W0HnleSsWiI9GeUjEsZVaIefdbApyfNHd0aNZDV2MOxvlfaM3dQ9a0ce2IqFA9
         0c5lrIp4jzeBvavVf8IoJ9KJBGBEqWybsDCXjfzhrpOsUdAE8rssaIofyj1JBxm6/XJI
         2rWk4VYLEsg/wVzuEB+q7+aqlxG9VKSYOSF0b5OwYXUH4YBhesJiVYumvfGiuayEFe5J
         9+6414u6mh1petYVLQwRQy9EiLNpRdpw5QXXe9Ee1MjLtIA2t+xFlxFKQfeakwmgLpFQ
         Kv8g==
X-Forwarded-Encrypted: i=1; AL+hErGA7NY5xzZVnhuJAQ9NWFbNFGpwqxVVBvwsRHzW1fjAKTChdcl5ZQ6Tl0pQNvgvSZ5/7KEjRCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8z9gXSY/IRPD74rVQyFK45h7eaqOIG+mX6NNcvGNWJQtn/fnDx
	AFoUSMGlroHODTsmmlYshkdKfhBmqA9Ybi0ghxvncy8y9bNQ1YeVdK/fKKXw3w==
X-Gm-Gg: AYBFou2EaldWOgWFUZpIqih9hJr66IYtqw3BrtIPUn8E4lHGKmnmG2p6WIM0iaMtaqo
	NnAOD8JEOoOEcV9FHgVAdFX1n2rpFWVC1GpmluPKV5PHsy0ywv6Rt0CN+5rFanI/DZbcf3j3CFs
	VRYQQ9JsOr5elxn9WX1e9ZYa1I+VcluwX++h+8rMA7pIFkF49WFnf6gZCu7BDReWEt+LjoOZUhI
	ENuLxcVGtA+UsmMNLcoL90MHbKXIvfP98AzboZFHLRMQsbpWFTDQN77vsxRksgqeqekbweROmnp
	4DuCYGg74ppEGeExwo+m1XDW4T51HrbquoxGCF+upwQQaBBvclaKKzwUdO53yc+ab3IZclNQZys
	KLF5AH1UjULNl8Ogxuct9W/EMQ5x0yvEnn+cyqbHnGXXD/RRQef6fXLlCgakUUuQPMs4gxLxvos
	VPRZ4k2AgQmDAelGfGDGllhRDAfT5SYnbR5zEF22poEyfBoJ5dF/L+bRQZJgGN9xDjvstYKkh63
	sKNGJD7rW61QwBYuilLTJU8uAeID5Y0a1yde6RXs7ShgbckkWLXyb/2CRIvopiGkENSBR6CDHuL
	0VEHEG4P9KYHW7/OOt0JuxOYOgUciWYnIPinO+ieYaBGFD3knYL/xzsR8kR7BR3lE3H1Dg==
X-Received: by 2002:a05:693c:8312:b0:374:ea35:9069 with SMTP id 5a478bee46e88-379681cdd7amr2329847eec.39.1794585655380;
        Fri, 13 Nov 2026 08:00:55 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:48f1:7a0b:9bfb:4205])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379508762a5sm8587820eec.0.2026.11.13.08.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:00:54 -0800 (PST)
Date: Fri, 13 Nov 2026 08:00:53 -0800
Message-ID: <9594e8428a3fbc94e515c9dad2268009@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Vishal Tyagi <vishalxtyagi.oss@gmail.com>
Cc: Markus Rathgeb <maggu2810@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "Input: synaptics - enable SMBus for HP Elitebook 850 G1"
In-Reply-To: <179399405216.85438.8327280593401118083@gmail.com>
References: <179399405216.85438.8327280593401118083@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Vishal,

On Sat, Nov 07, 2026 at 01:10:52AM +0530, Vishal Tyagi wrote:
> Commit f04f03d3e99b ("Input: synaptics - enable SMBus for HP Elitebook 850 G1")
> added PNP ID "SYN3003" to smbus_pnp_ids[] to enable SMBus/InterTouch mode.
>
> However, on Haswell-generation HP EliteBooks sharing this touchpad controller
> (including HP EliteBook 840 G1 and HP EliteBook 850 G1), the touchpad fails
> to resume after ACPI S3 suspend:
>
>   rmi4_smbus 0-002c: failed to get SMBus version number!
>   rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
>   rmi4_physical: Failed to resume rmi4-00: -6

Could you please try the patch recently posted by Markus Rathgeb (CCed)
that retries reading the SMBus version on -ENXIO during resume, and see
if it resolves the S3 resume issue on your EliteBook without reverting
SMBus support:

https://lore.kernel.org/linux-input/20261105204953.69572-1-maggu2810@mailbox.org/

Thanks.

-- 
Dmitry
