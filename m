Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602257;
	b=rLtUaMuZYCne+aQiPTIOPf8WpZuG/NlJPRd1zYLi+B+VsbqCw094sYwYk4AC0/X4ffI1
	 JKgAGDnBwzXIVH3P3dBaIL81ZfuEdiQSuY4MFEfS/m169QUlxL2hj46GGOtaSVhALmeYQ
	 DFLKuXlVRdVT9VlTRiuCP2jLwfWkYO7fxbzdbfnIC+RdJn65+LYVZKHpIss6wzCf9/aLM
	 Y988nZmO0VWgT0zNOK0+codE47lh2P5Ga4BZgbxQtB6EgYfsEJCYtNB+D2kXZnZzEjAI/
	 WYdthtIUE1wvNS1f/9vLRBOSE5Do6pkIQftjg8GLj47gy5XxNLjWwTfh7XaTrO3ExYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Jz1PsVKfLByVoOLZveZuQnHIhjOghHzTozlXRwWyQFY=;
	b=SsHp/J+WvfGzTe/LfPBZvqJrYIAksFKpbE2mtHXNEE17TImXVQBJg0Hr1UGqeufIVhAM
	 bm94cbSPTPVY8yE9alAYR/Nz8f3FANQVd+Fh0N3MpUY93cASyaw8+TLeaFiYzLe+lAuRo
	 Sr1neohdzderg+p8qH9Zf9fs/NmYgN7bH3N5JSitEcRlsEepfP/xb5AYt/+hBd7Sa5Pnu
	 wuzM/tSEwH0VbbEH/TfGQc8Jqmpe3iEUkRAGwghlhrccWHuDGAcCrpnoULtuS7bmtNCbn
	 8ZaY481hfGkrrsRQn/y5taeNQJ2e4RKN1BHiTwta9nGcETwQZ4sQ6P5JdFrY0Q3tdhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XhTlCR7v;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21D606A321
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E21D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XhTlCR7v
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eabf243d05so382252e0c.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602256; x=1793207056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jz1PsVKfLByVoOLZveZuQnHIhjOghHzTozlXRwWyQFY=;
        b=XhTlCR7vSdYc6xYIXY+4YWo5PctxS/eg+nF0tTI68R0wVdyxDVGBrzKBf/vP34pSvJ
         XAznc7rukb2wtB1NqGIS5vQeaCB9MBnXyvKRfs83ldM1IPeXlB79qnKE6vXs3lHq95u+
         ogvPuri41Rl7agULw8/F7KE8DKjinlMy2SkfjdDfTwRNcxWRaoptKoTfhw692uooupYf
         HyD6hwViiseOQyCZWc8633SnsTVBIYggx/vZpkyCnhr6pmhXkmCNT85aqgpnLHEz6cRZ
         Q8nKtiMcg7X/Eu9Xtswr36jVhpGiPY3wkZz7dmRtvVd/clbcMzf2UcmXk+ZgzlfO2ekM
         ucAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602256; x=1793207056;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jz1PsVKfLByVoOLZveZuQnHIhjOghHzTozlXRwWyQFY=;
        b=ekWb30m4WN7sRIkdAIXsUgU9r6d/1CgkzOU4COLbF1wBuACPM50HWsC+/d4ng+KXMQ
         t76GqeovMQ9So/snrhcTipOnK1f1lB/eLrAR47FsEoLjnQ2CpFaY+q0zgBn9A1myC7IP
         9j1Q6XovTrzGclTJXpcPi9Gv1eRxyVreIBcah3ZimIr1zvwwboIKXKGDDbD/hHo1wuLY
         2u4Zdx12OnnMMyDamgLE644F9sMIqJZi/1XNACL14j1m3Rt7R7PcrHI4CowzvAacGAhC
         gyqdRZXWgLwKKqh9fDXJ0W5RjqoNDwMi+x0L9vPDUKi2exBpPnqixQ1y3GjKNK+GrL4c
         4AGQ==
X-Forwarded-Encrypted: i=1; AKwUvBw90hBiSCnM4xAiUZbffKmwUpL8y2PXibgLzm2clQ9Hp11RsIik9LGWnLI/rm18uzABbtAJp+s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxtEU9KpVtlavbi3sMDJcFm9wQuiUKl+BNvPN6ZODXx5Eo29Kt
	ljkWLHdMn0q4MfPvGodnexs08xZ88CgSZR378BvYy6e8a8nIr+/6P2w8
X-Gm-Gg: AYBFou2oELu2eB132Trcb35c/xldIP0L9WWt9urBEFJp75h7ZqYVojpsSdOX18IAtYv
	eq0XAHclp5cVsl9BrVGh1JZWd85YIROSjM2GAxdolHO8f+XyJNZQ7ChAJTyNCr8JgQ7gAPQ48iF
	nYIqz/bdMozmSP3hrUxNxQ6Ylfotry71s6UZ91W/DQp5dG2HlI2mH8/VcAwgUEmLqhvejO+Ztj5
	jwgvkMe0Ud5ewwY+LwAcZEVwpqTWfmJbMBgsQZNWwIeGHQyettVWF/TiE0fdTz07XvCaB9qtDln
	FewHC0HKSsAftUi3YsJ/Fway/zFc6iUohFb4CA5WrTAeD3AI1qTFeihc/EUYMZan/BNWuXVjXaB
	+Jl0ZIKRVQGLdgHGJ7HRtlx7DyneBcazaWCS2Hc/Y96btGeTXzoYNjKEERKeKHhdSNTJ8ucJ//F
	vWipXMZ4bA3ENs2DjkQv7Zg05ahB9DrPYmThHWj4votPoJSmIJ2q+6H606LC4KmvXCw+wvZUdvD
	XqTIL2Tv+7aOaMDKH6IfL/r0gPXDBre77dKLdBK/YebGVnim+UYvDK22hyp3ukj30hVvICeH5fw
	3mu+bJ/mohENf7FAQOMBq2zKdlIg3o8RWpkKwA+eDFWeTJ5yTlk85zVXeGK0umI=
X-Received: by 2002:a05:6102:149e:b0:7cc:9d46:f091 with SMTP id ada2fe7eead31-7cc9d470bbamr602076137.24.1792602256305;
        Wed, 21 Oct 2026 10:04:16 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc924348c4sm3367159137.11.2026.10.21.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:04:15 -0700 (PDT)
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
Date: Wed, 21 Oct 2026 14:04:03 -0300
Message-ID: <20261021170403.2052449-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atjqZPuAbHDdaexv@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com> <athe0QikG2mzCAtd@ashevche-desk.local> <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com> <atjB-BnXclL3FcUm@ashevche-desk.local> <20261021153732.1978410-1-vinicius.eduardo.pedrosa@gmail.com> <atjqZPuAbHDdaexv@ashevche-desk.local>
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

> No, just pass that as a 'bool autoconf' to it, and assign those callbacks
> there, while calling dw8250_setup_port() unconditionally from _probe().

I think the autoconf approach works for Octeon as long as everything
dw8250_setup_port() probes today stays under it, including the RS485
detection and UART_CAP_NOTEMT, not just DLF/CPR. With autoconf=false it
would only install the common divisor setter.

> I think it would be less flexible, also it will add an additional branch
> (actually two) each time the set_divisor is called (not that it's critical
> but just wanted to mentioned that).

The idle callbacks have to come from the drivers, since the
dw8250_idle_*() functions are static in 8250_dw.c. Stubs for LPSS are
fine with me.

> I dunno, I prefer just a longer solution, but I don't know how big this issue
> is that we need to backport in that way (and not taking the whole series as a
> fix).

On the severity: the IER restore comes from a7b9ce39fbe4. On the A733 I
saw hardware IER left at 0 and the console stop taking TX/RX
interrupts. I haven't tested this on hardware with a real DLF.

Given that, how about keeping the small fix as patch 1 with the stable
tag, and putting the refactoring after it in the same series? That would
keep the fix independently backportable if needed, while mainline would
still end up with the structure you proposed.

> I have Intel Galileo board that uses 8250_lpss.

The Galileo should be useful for checking the LPSS path.

Thanks,
Vinicius
