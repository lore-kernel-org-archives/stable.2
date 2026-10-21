Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597071;
	b=ZWU8+i+kC2qa1Wz9VseCPZLNAKpiur2syzrp/DQdnfl1e9JsSRtwWb5xIHKrxQiD+xR6
	 tgup60ijcoIu6buH0Pkcu5l9cBfT0qjQR/n7lZE8/0QMjq+Q6nlKx78gPpuAG5/mJXiz8
	 3fYrRkgSR7ikpQpXCW6QAyVPqyKa911q7/gBSj0if8faeENV5p/cvtWz7APlQbGSsFocl
	 waHgNNkmchNDomCNAgb2D08bsF0YAumjXggKRyAMRBtex7mU4CjhnSbbyssmMO8XRvOu/
	 FJkcfZcJj5VYQlLkdwVC0UKB11G2afHJYk5bDnugDViZxqhmUzxeIUzkalr8/6EpNHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pcUJNAa1d5gYFOvrKvELkQqk+wRTOdmweUM3ujZu374=;
	b=yS65GdgGlWWqmpSIXu0lJKUA+ZWpjht0DHR7dsjlj+NxuHPRg9RClJwNe/1exyrpxOsd
	 3tNRL/4qJ0AK0lY9bGhP/rZ9Kc/Qg2vIlK5t2e7RZWxiHo31U+0bqVgK0fqeWbAALMqGa
	 rdlXHRswLzSCWmjer8G7L9cmX/00+UeGSi4MLj/Sm0OWfJZObBUs0fn4sdACCBTCbTi59
	 rvH9YLDhWDYO2Jm1t5kK6riMRbJZamqEiVSdypWhyo21hc1BjRx8Kmuz9bA0PGyRde14o
	 x6BW/yydEljstlyaXTXG1Ye4plxWPdh/t0zheTP9b13IWyBxoPN8eFTnafWZTt4I/Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U8WOfcfn;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB67E606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB67E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U8WOfcfn
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eae12762c9so388616e0c.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792597070; x=1793201870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pcUJNAa1d5gYFOvrKvELkQqk+wRTOdmweUM3ujZu374=;
        b=U8WOfcfnMnpm6svYe5iJa9/W46YR4FzI8Nlj+7unkM7m0rftH2FoogDPMK26ILs3tw
         ms9az8/IEBxBnq5+p+y8QpOkfxpbjyjMZpObKISMc1AlVpCtroY8L7HpWqaN9LJp7Av/
         ikv7zKxySdsv74p2R/3OFIolqJNaymhzG9OFqPY65WDonlV5Pgagk71+wfZENoBDReGO
         0Wi0rN+Y+MtHE2ZtMEgL2lJ1kLk0G8GP+JFXuGcKj/x824ojcSSn035B408ME33gWqMJ
         ZSHXqIvQVikv3S5cRgsmonWb7b9tVLhoIH2cIzqoy0U/9rhbqQ6VhgYDS/9NOK7jFZHM
         qLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792597070; x=1793201870;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcUJNAa1d5gYFOvrKvELkQqk+wRTOdmweUM3ujZu374=;
        b=AdGp46KO0EWAOSXmUYbgdz6uxF0uUBVtIJAdMrfRhU8vR9VQSz2eKy3TGRMC1osgFM
         OsA1sTaHdaWbBFBQKIyhVvh54s0LknyBKIi5tgBW9mYpausMmON3jpkMtkXx8f6CgGNC
         bS4UKw61UpKC9mwgV9Asgy8McU/9nZay/Kaz+cUi9UwQqnfAvtYnibX8+7RHXPXQAdYS
         s+is1HxPaBK1H99WIjwgQ9LgY7jFc3o07BjORVWC7qoaHUS7EpHm1JypANNWWnutn+D9
         r1nGgpqRW94kwv10zn1Gs/m8CFAyXxkZQUUCBahiZf6gk4HOtCriWK0DipClCX7QshLk
         nwlg==
X-Forwarded-Encrypted: i=1; AKwUvBw6mDYwGdm4R2s6NM4xNhTQXS6q+Ak4Uh5OmSgkyFWpC98c9HFSz2vfYgOc1gsstoqPS2dBEiQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnA8UPmpf2Ulp8aag2cT/mvIWLjw0mIVdMBxNYl+smYUs5aO5G
	2DRSYM2LA3ds8Nud1WFB/ai8qZvdyT7KTXZaMcR4F0Lm6HW9riaxrFRE
X-Gm-Gg: AYBFou1aLcSo11bU/mWuiTEnGnvGaL6F30rdmB32r5yaDmAFgvSeaY6L8UIN8/0YyPO
	FUUKys3Sgb+VEwe0V2CN8UV2ZdqI714HkZIGrz/4JMlihS23rrPunpITkF+2Q1ODvBi6p2F4ewT
	Vo+ktb1yNMZpBkMoWjeSpih3n988MNgGk0aULAYVpsnBjORrsCAqNWFY4cSjjQ+thw6zK7F4J9m
	5Gri0ebR2qITfRcYVtP8Ip1tzARP4WOoPu2MEcr+lBvRznYGwZxeXOdjT/dkjoREIOx7aEiWIc5
	0bA+vei4V8VSRtyPR69WlHXsodDcwGaW6sONl22ng+dFJQpPLHdgonpZ1iv3U8ZPLra1QGkBQbT
	Mzpks6RQoEV7DNw8xI7cgaryzqMmHx+vY2syooUBqmNjnF8rYMkX3JaAWZLvrD43J6YaLjgdt3Z
	wHyAeIlhfHi+KdpvL618O9FQe5OVgO8+c7YBMPZ7JyYYVhRCpiuD15cUd5qX4kWfpgIqczbXmvA
	o+LGtRJdEDa35480h8XiZo08Jdr86E5xbhnBUQrirp75CcSyzUYNLItk03a1R5wamSeBO7w5Ngm
	AYLINas+T+Bw7djUc4Cyb0QDEUNvfrIqS3YHtHfvf8SdBYgTMiZYla2UtNBZBBE=
X-Received: by 2002:a05:6122:3122:b0:5ea:db3c:4a3f with SMTP id 71dfb90a1353d-5eaebc14cdemr1063889e0c.2.1792597069786;
        Wed, 21 Oct 2026 08:37:49 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97f0a94sm3505688e0c.11.2026.10.21.08.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:37:49 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Wed, 21 Oct 2026 12:37:32 -0300
Message-ID: <20261021153732.1978410-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atjB-BnXclL3FcUm@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com> <athe0QikG2mzCAtd@ashevche-desk.local> <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com> <atjB-BnXclL3FcUm@ashevche-desk.local>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On Wed, 21 Oct 2026, Andy Shevchenko wrote:

> Ah, dw8250_idle_*() are already BUSY-functionality aware. So, what we need
> is to provide dw8250_idlej_*() callbacks via struct dw8250_port_data and
> make current 8250_dw::dw8250_set_divisor() to be part of dwlib.
>
> Patch 1 (dwlib): Add callback definitions for dw8250_idle_*() to struct dw8250_port_data
> Patch 2 (dw): Assign new callbacks and use them in dw8250_set_divisor()
> Patch 3 (lpss): Introduce stubs and assign new callbacks to them
> Patch 4 (dwlib): Use dw8250_idle_*() in dw8250_set_divisor()
> Patch 5 (dw): Kill now duplicate code pieces
>
> Would it work?

Yes, I think the approach works. Two details from checking the call
paths.

dw8250_setup_port() is skipped for Octeon (skip_autocfg), so 8250_dw
would still have to install the setter from probe.

For LPSS, I wonder if the idle callbacks could simply be optional.
8250_dw would provide them and LPSS could leave them NULL, avoiding
stubs and a separate LPSS patch. The common setter in dwlib would use
them when present.

I'd still prefer to keep patch 1 as the small fix with the stable tag
and do the refactoring as a separate follow-up series. Would that work
for you?

I don't have LPSS hardware, but I can build-test the LPSS side.

Thanks,
Vinicius
