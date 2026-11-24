Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526708;
	b=U1oTw5fXrhPoetx4id6+wTC7lN/qWEOx7MeL4Lel0K7cTm40DtZJFXGzk47yyaTWQ/Rn
	 eKS28AFROG2ZLDtLULWEzW0yEC+3o2Saw3uMOxDtCdT4i5d5adoKMM2CHfnaT/cDHzD0B
	 r6U5xeqCiD5fdoTk09z3H+e0U2alFVZUNu97qqcrRfYgfIlEGx+ek4VKy0P8/O4CZsKa+
	 MSuUcUKKKaS4T9/xdAp12x8FPjggsGUaNwlvRUs8uW6DLh0JchuL7TZxunDkkXPk20Fyh
	 1trU588ImIfQBS+CV0/3g5lpaZxxPhNyFmWjgT2K9ceFvnj666q6HM7nPXkzcc2oYaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+RtgrQ36JHyvhHGZvGGPZkAXfWTlvQfOhrnt2cyvwVs=;
	b=igLRAgAYFu30Rdskv0MuKZCX25hFON8upUnId+qpgV3fkCdE9lPqF4Po76FUNWo5uYQI
	 agJ13zJfsnncVX0xmaYo0lOmzWKOHVnCG5kiycq95xOHTF+CghmgHHLbEpyfVYI2CNDHZ
	 NhGuvphewYW+QrEAYGaiauMQNlKKU4ksPJjIywxHf7rRGYneyzREN0R+RGEg9+01AVaYB
	 +yDfn5N9/NZh7rDI0mGRuRk9+LF+ptBrTsbj38zHx66q0YMKMKxgogQp0swELatnKM2qL
	 wPfYw3IRkY4ulPfq1vrA3YBRCAICZUlcHd5N6N50qfuFs7FagItpU4pMMYL4MrGaBEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=zBRyiUY3;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5A606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E5A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=zBRyiUY3
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38190551625so9138724eec.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795526706; x=1796131506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+RtgrQ36JHyvhHGZvGGPZkAXfWTlvQfOhrnt2cyvwVs=;
        b=zBRyiUY3rhQ831i6K0Q80YRK53wy/s16sGtc8qaWE3XszoZ/667xPbc9pI/ly+th+y
         8C2crYafo+omUFFfwd0UArRoD4oPLMKu/J8MG2sDRlOrYbFMSqp0jqTqbGwPF6W1jYoK
         ZLBbBElM6smNmHeMvleKKZGm7Dwid+s++sfKwP78RBkYAGwOEB/K/tklvROiYourIZ/d
         VUIIe9gEdRb8Lds2LRmJ7KfMvlKptgGrtq76GeM+WG+WT34I8h1f6m8GrOU6umx1Fu8z
         mKBkCtSPmPAWXBoBSUHJpRUiQsSyflZInH4weSkhX4KdhUiZl+VzcdBs9Bt+CVTVyNwY
         YT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526706; x=1796131506;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+RtgrQ36JHyvhHGZvGGPZkAXfWTlvQfOhrnt2cyvwVs=;
        b=lcbwfx3a68fH3m1veA+UmJd/eS+ixJ6wrqgyE3zZhGEOaqNdWQ3kkP6NfLb1Po4PqC
         ntTz/DK51kjKGye2LGx8npYvVsk7BJ2/aKqHRgJanWdLg3NLzAPT69JPHWqROGo2Y0ek
         S6KDcWuEfMyGSUn03jm2+86Ue9z+vHbDU/UC5RTQRCVOz+UlP3UU9mPxRVLudkIrvZpx
         xqUcI2zJqh8ks/kbMTaVmxQQWp3vtFTIt5g8ynWp0omPLdCAE1Vff0qeQ32h9B/PerIa
         5ipb7mpJiDeJWPvqUOMmtBGwX82NCzbaP7HkBxd+m6bzgrDZYqXr5y/A07gw2llOXh4w
         ELfg==
X-Forwarded-Encrypted: i=1; AL+hErGzFXtQ+hzsXirvEi6a8SpBG7tT+IuyBPVDpi0a3pbH8cI9JLk3jQvUG07rl88YtwvLm+pBXsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4eCy6AT/b1S0vbZUsb1eoPkNpHWR9alM09V1wtKieHinPud2b
	b0k5i6BBHvfjyUdW+PhuV4tCtwwDHsgYvaHk8yJij+QpSScz7MF91WRb/f6giF34k/I=
X-Gm-Gg: AZFdTZfgBREfFpsX+ML95kUIsPMYP/JTnjHxFQplRVGLhMQd2t/bRgJJn+Hqu7zqkzF
	aF/zKZGMpmPMz6j6TBaH5vzcjJu+uXJRNhpfRQfa7Qp4pp/ETpoPdAOUQ92rZkyTpIaPcifDItj
	ArYWc/L+QgCbGKJo/Uf497movpUES243pQoHHmhTOtw3hORiM4s3kpm5PHkuU8dfJYhmPGE+0Fh
	SIsZtAJjdn0lJ65p7h2l7KJSIQFMNYVSvvS51ZbKtyDVSNxmHCwr9Sbrw5AFlNKo3MSu6sWrlc2
	jS/ftF4g7IwO1Z3ForF0t28UFNd3MimwC54d6X8cpCxFkpasAIUfuqT7fHvpfiiQe6UIp0dmp8F
	aFcZN7o9KOH1J7GJEEJYK24pmYVVBkH7TLLFFdUz1bh48709iUCHufrIegGl4sZ9WLiKrnY1bu1
	qnp454hW4in0q2KKaNRWEHcBJ26onE7VT+vnpnQ3x2D1bVY9S84sBSNeIMMHpW6ehcE2H9FVrwy
	LQjldEahrPunHxlDE8BbwLv+Iz6EPiLGR64buabZl1JBaaFL2e+8AvcLmNfO9QD2h1g1Uvgvrs4
	WgUYaebpsbmoKikFJVkTzeU249aREqy7VdeU/1vGH9OMBYoSanrpOA8eaHGDIkYdurk+m/87CRN
	a6GFEQDAEniREE+Ssc9PhbukLmA/8bkt8ujvCX9LggKgvYPYQFZZrbpT5dmRNC4ryhUPpZg==
X-Received: by 2002:a05:693c:8209:b0:383:e7af:c28d with SMTP id 5a478bee46e88-3856f14d5b2mr15436134eec.9.1795526706150;
        Tue, 24 Nov 2026 05:25:06 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm42793514eec.7.2026.11.24.05.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 05:25:05 -0800 (PST)
Message-ID: <f43872eb-6549-4087-a6b0-d49d877e867f@kernel.dk>
Date: Tue, 24 Nov 2026 06:25:04 -0700
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
Subject: Re: [PATCH 5.10/5.15/6.1/6.6] io_uring/io-wq: save worker type before
 dropping its reference
To: Alexander Martyniuk <alexevgmart@gmail.com>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Kyle Zeng <kylebot@openai.com>
References: <20261124103600.39642-1-alexevgmart@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261124103600.39642-1-alexevgmart@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 3:35 AM, Alexander Martyniuk wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> commit 37e425460b7c41687e51e3254b1eb1d799da9614 upstream.

Not sure why you're sending this, it's already in stable?
-- 
Jens Axboe

