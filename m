Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723774;
	b=C0nO78v6zGbcoGZdChdFED4H60iIOim7hqUp4FjDi2tK83tfdMKj5xGmI2NjikX4ZuLJ
	 1nXEUV/QHE5Uq0SncxPBBT6Ybg5ZdR502/LIzAJf0bxlpIZenaXjaLNbVD+X36K93S8AH
	 /e5Cj5MaFxJTOVZXpAf1MNf6E7JA2VQp/MOwaysDNyl2jA00aQDRvsLCMrF0KXRLG0zSL
	 sumAx+Er3pb7dodGZgUk6OrvjcxZiFTFFCv66d+7AKSs0DGxh92l6j6EdYBTz4Rs9oG+d
	 n46Exsl1y3AF4kuldwll508/SvRfljmXnIxsWe1XSsuTTacb2orgYzd89Hph3O4v0Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=rQNexLOofyPVI2iEZAOEtUHF70C4HnplLayh5YE847k=;
	b=ITimE5BdwRhAH/ZIkbGIQSU07ZHUOcuuWMmKFvxGjC3gZnHrJP9u/2z0cguYuA6U8uQT
	 PMKWPOM46o+hy8ZCrbhIYOqq62waNIg1kdN+S/9nHTbtwAwG2E3ThuqnuDIYN3KkV/znz
	 SeW1e5UB0gB9fZ3D68c7fzD3l3wXUiAw/jURMIcPjNIyjYD1mjUGfxWc69sRtAneFqsVS
	 HLHMXz0ldzfoINYSXtrBiS6oC5bQk6geGLzCVMDLftEL2gCVSlZuI5aUU6vDz4JhdnqrR
	 xGSMuudlOFCei5xWKOZwoKqAelyGDwzGB1m/FK5pFfW5hRdyXKXm8fCDFfYphSUPSgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tuxon.dev;
	spf=pass smtp.mailfrom=tuxon.dev;
	dkim=pass header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=YmYHWArQ;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB8606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8BB8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=YmYHWArQ
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4ac08f4a0b2so5270091f8f.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1795723772; x=1796328572; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rQNexLOofyPVI2iEZAOEtUHF70C4HnplLayh5YE847k=;
        b=YmYHWArQjy2xW/ipJocO0S42T3Ww9dE7Q8m7l+xiJCVlRk8VnH460h7OVp3zN0zZs3
         5uj6BYeuKmt5FVz82LSmlGC3H8hau2OCJ7QOBSHOeNQERs/HQtw/gbH2zFwhCICjvpl7
         KDGOEQZRmz+3sotgSyNjYp69aStWUPuM86Cv6iuYX31eYPZvuJEJEvx0dExCwNwqgP+M
         AxtAXJhleaL8TTrXpfhpeDfWvPDW1lQnKzcsoKPJTGv3Zed/wJJDBo8m9mEM82LlJV57
         BeOc7goW7OkPFyGNzQxGy8OBwsrlh/FfjivJN8WC7I5BF35eSsF56GC4pQGMCFyFa6b7
         ZbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723772; x=1796328572;
        h=content-transfer-encoding:content-type:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQNexLOofyPVI2iEZAOEtUHF70C4HnplLayh5YE847k=;
        b=LcYirHx6i3shk5fgsRfdA2c2bnfgtCiCNYd68W1a1Lh16+HV6gNz0rWEkP8M3vs9Cb
         KOFCP3GZFSnSDZMUw24D42qYOTlnIuAlYLQ2C5DgUCIRtZKaX8BuaSNTQ28hsrlbqskt
         IEqZSG9R4F7lWYvOs/X2gPfnU4FXEC/HOionEKgbkq/tI6JW2PFYdnI39M8zqWNJwpYH
         wojuQkMrCpcUK+muxjR98P+/mkNdqinI0pWjD7Z+CYBH6VkzBOyM6ejQs1V3Tk2PjIgt
         xrBYQN+RaTJFZ0lEbCuGxU5FjIBkFBBZ2OOPnBfsrIpqTMJ1NMswly/BdxzCMsC0I4/M
         BD1w==
X-Gm-Message-State: APuU4Z+WmDTUvKmDD7xAOLuliTAFZgpBbgQkl0nhCDyxnZHMk5IHhDG/
	bMcZWHFpXR684cDpQfhm3ITervdX1edZsR4TqiH4FiuSSaoF1umNrJEYzNIOO7BoMi37zg/PuLG
	Bp21T
X-Gm-Gg: AZFdTZfBQTA3bcaReIa0t/yHsWAH+p9uxzmTuCKZ7G9SpXEMIQpnJ5x0urKCRcd0r/A
	hFVfYysjiCEpnjZILYHoCXL/R1SrhGIRH8XOwHJAYMzJLKvWzOuObqvmOXQbPrw9pQPdFEnzYRV
	590zEv6/zwhtdjDInNXx3ccJFJFe4wCC0DJLzDY4A6NAEEm8st5jdfuuO3S79iJlCMtmI17+7Yt
	LZmUWsiy3tcStmCywQBRyAAVpfN0wE/dK1An3K5QNcZ3h/eCpCTmhhlse5KbdgWfB4RlDJ4nBku
	xUbaFekaaG0+HYCxtoetd9wFC3ZW2bItW/WXnnAxqXiJre9tzd5DJiBcbaN6EeHNP8lM+qn+ve1
	N+dFmqH5ddkv1bVtpgltieh5W3HXsZK4NMWRg4s7q7z3e/AKuffLebX+hH40IXesp2OH44W1ai6
	jUh8p5ZciTBpvLWVyv/mtea/YBawn/41ZCaSDjfQoJ0uggPrP/BOGPctebUIYAEUVpTxcEvdQVD
	RifmHX+MXgchbmKR5852b4m3N9EnwG9683ZH+9iHoXmkTpBot9dKT/0zlYQKH4Hrr/wNRN6BWts
	HF5hTHWPtWJAtp3smf7MSfgyZaa/D/AZE+ToHuxcW/86liX7Miol6ynQ3w==
X-Received: by 2002:adf:e19e:0:b0:4a2:dae8:ca5f with SMTP id ffacd0b85a97d-4abb2ece9cbmr43118458f8f.36.1795723771629;
        Thu, 26 Nov 2026 12:09:31 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm45815303f8f.59.2026.11.26.12.09.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:09:31 -0800 (PST)
Message-ID: <aab6f82a-2dcb-448b-bebd-ce5376280de7@tuxon.dev>
Date: Thu, 26 Nov 2026 22:09:30 +0200
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
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Backport commit c3ca8a0aac83 ("serial: sh-sci: Check that the DMA
 cookie is valid")
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, stable team,

Please backport commit c3ca8a0aac83 ("serial: sh-sci: Check that the DMA
cookie is valid") to the 5.10, 5.15, 6.1 and 6.6 stable trees. It fixes an
issue where serial devices on Renesas SoCs become unresponsive when they
are opened for configuration before any TX activity.

The commit applies cleanly to all of the above mentioned stable trees.

Thank you,
Claudiu
