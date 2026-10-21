Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606047;
	b=bpwM7YXa9oBxgUustl4Ubt83h/AtcRVF0BRwLcvzKv+OBYiMju3HAnBI1H/hIsvubCdn
	 EnynBF4jZ/ruhselSsdGmxiQvowEm1o5qrCKa+O2J/K29/be1OrI7TSjZTfgfXJyWgcQo
	 x9MRBRBFvT4arXmOGBAyueSlFdfO6l52GOCs+ghx4SlvxidcWi4zotFBQi7R4RdgvcyVT
	 lTUST2vg2NCI+KldZc3nJs8idwvsyMdWQHKXozW5MwDe8vZrQQAqF0uAxIFaKfMuzSOLI
	 beIvX5h8xjxEUt00LIvfdjZSEGnphsjjXaf0u0iQF9kJtEvgu1w4qTII2iZnmba+F6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BD3PH8sn/SG/F7DO7wxZvYQbvmrfrsBI3sjtEwqgqnY=;
	b=zth2wtVdJX8VqNCSJhqh2Oxvd/9IGIGBvFoXgZ3EWua3NWYWe0ejI1rKEc2a31tbxvc1
	 pr2bFQiR7sWE/eytJJbdHx4w6HiaWaMFJYd6GYqGA4m893F0Be6577UPMKKponb1TbcVJ
	 wcRvJnQBmvG58OC1p+o9cmu7lFgdwhseGwWyez31aOKKGtKND/to9ejcmaLuKDVrV9saY
	 8ZndKa84zvUkFjPqji1Q/J8rhDxeZklwQ+wgT20TlUvTP5X3RZ57V6ygBlZ6/uuvDiLav
	 rQyc4PfF5VyNt6rmvyrfJ9dPPdpqeAqV/IjYtJU6E2hnEXHfVZtq6Wy8f5ET+CXquzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmPuaxZx;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562BB606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562BB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmPuaxZx
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ead4026fe6so402637e0c.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792606046; x=1793210846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BD3PH8sn/SG/F7DO7wxZvYQbvmrfrsBI3sjtEwqgqnY=;
        b=jmPuaxZxGSuX2iUAkX5etUFc8l3rPMvgto8XSo5wtZwb/bT/7hXZd5zXz76Q3zTryw
         AHoQ+fHEfCnELueNC6j6PX5Fnc4K2VpLXakAFunBe+Mpc3uphKEEaJacETiZEaTxZZy+
         e2sKCGJviofNwT48s5JFb8OqqmXNunlx7Ty0tftUlJMIVauQaexhNpF67R8w8uEvVXIx
         N8dG1+T2D4Bp0ksb5ZmHMTflDJg4/I5YuUcP/iAGYZeZ0fdISC0jX82sJbCMoU0xlxhZ
         OqdwJicC/jegzyXcMpNBV17k1XuIQq3PE6tqJCnMnD1ulnQ7w0qBvYPGCkJ9hV+PjTge
         loxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792606046; x=1793210846;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BD3PH8sn/SG/F7DO7wxZvYQbvmrfrsBI3sjtEwqgqnY=;
        b=0IUfcZcW0ldBr5TpGK4TDZgg2Q4aLKtIWlMbu2DcrRH/89036Wex8eoc8ouDt3HFDE
         XLHwuklZeF6eOkG37ltvBYMAiVEpBMjQy7MTbIqPTgEs9rUDym9aeW8SEvcVZJ+u7mQa
         f98FTHMmf8U4oaxZYSktflxjPgAYK3gTZNQ86/yCcK+vkH0mHF5qqxex1Vkp1MOEhNv2
         gAjgzHkEsij2xUf5Ucau548QJg2c5nrkIhkff13wk+Xzl7qobaQk8IwQONpf0HpDcCP4
         cvEGr9TiiXWsMZRbzZIRMNFSPpvU1D4R01qLqOmIl74i5MqDEVEF8vAZFtw2+Mzzc6E/
         55Lg==
X-Forwarded-Encrypted: i=1; AKwUvByHa7tW0KczZ4nINUQXlCnQ9j6x6n+yFHtUzCRw+eCw4CyrnkNK8X57hVrhIZPLQpTSld4zY2A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnCGEs1sR5wuca0Vqv9i1TkBeTQ89isErz6mrbivVElmuzGOkk
	N2tO2ZkIxYyJ2NAvkTsEoeVJKUeW9HKcA3Ueb6netpZ50rPn6VtZg8i/
X-Gm-Gg: AYBFou2sStCOhFuK5J/wQTo/6pVOWnZALUNLFr+2rYv6gR7M9YCZ6C4CbWjnEKJGEoz
	Lya7VvCQ2uOCOWnyuI4vCopAe6sy+LFPAQygPFdXBG9o9UmlxtZ7yzMHLGHu9uCMl9zSPWnBLet
	+kpgnOOIRW7Yn8wIdvqkHw5MeNopqMQAFAOwq9vME+o0xuqV84CRRb2+K5IZNRgsQ16dvAi14kd
	M2lfrtebu8az2yzo4QvWvafCOgFmwKINE704/fUxtCw4WFCThcYGfyk6JPmlNRxUt55BblV9twt
	cBvdIwfTehWwxQxcAf46vH9Uk7HZNdkpe4w6k+glFxfhAZCW8zpOY2A/FFPatNWJwtYZ30OXO69
	lo7m1jUn6bzwn/bu+EjPO92LoDg755eGdqI8F3clutOayGjJSzBvb2eQQ7yhksA3Zs/56u3E2mL
	AE93uZ50cnKXCwJbF3j3ozv1bDwzjLCtk+axBSGzxtbHTTa6OfRQAU5EgWMazorO21eA5rNy6E1
	rJXQbZgnRHvRiaGPDJqjiSrUIKeWxwQVTOSJnMLLbPQa9Lk/aR4V59jbXzxiqWV/Xy9PdfqxfsG
	L8s02TTit6bjzFkx3sQwNLF6wDtVgYjNG+BOlv2NVoPnHycUq/2+w4M2a7p75FJF
X-Received: by 2002:a05:6123:6d:b0:5d2:4a4c:ad83 with SMTP id 71dfb90a1353d-5eaebefa0bemr1334431e0c.23.1792606046270;
        Wed, 21 Oct 2026 11:07:26 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae9697814sm4054490e0c.1.2026.10.21.11.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:07:25 -0700 (PDT)
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
Date: Wed, 21 Oct 2026 15:07:14 -0300
Message-ID: <20261021180714.473749-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atj0iRFTxHKmhxVG@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com> <athe0QikG2mzCAtd@ashevche-desk.local> <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com> <atjB-BnXclL3FcUm@ashevche-desk.local> <20261021153732.1978410-1-vinicius.eduardo.pedrosa@gmail.com> <atjqZPuAbHDdaexv@ashevche-desk.local> <20261021170403.2052449-1-vinicius.eduardo.pedrosa@gmail.com> <atj0iRFTxHKmhxVG@ashevche-desk.local>
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

> Yes. but is it only a single device/platform affected or a big class of the
> devices? I assume only narrow part of them which unfortunately use DFL register
> offset for something else in their RTL.

The A733 is the only case I've seen, and the false DLF is what exposed
it. But I don't think the BUSY problem depends on the DLF offset being
reused: with a real DLF on a UART that isn't 16550-compatible,
dw8250_setup_port() also replaces the BUSY-safe setter with the dwlib
one, so the same path exists. I haven't confirmed that on hardware.

With patch 2 the A733 no longer takes that path.

> It all depends on the outcome of the above discussion. Maybe others can share
> their opinions, but I lean towards a series-as-a-fix rather than a bit ugly fix
> + proper refactoring on top.

I'm fine with a series-as-a-fix, and with deferring the deduplication
patch.

Thanks,
Vinicius
