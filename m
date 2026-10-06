Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2C3B5850
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791286375; cv=none; b=ppOofYoro+8MOVvLByU0nC/sQR5EKXyPo/+8mOgkTrSmg4iq7npStthHLqckQ6nECJrfUAFe0EZNj02+PqbwRZDe1XarcmT1dgYORGwOOTbmgaQdv0GIwFhUV9osdofWHuoFb7D8G2IziNejHWgu4Pz04kB4p09lmwPsPukhRkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791286375; c=relaxed/simple;
	bh=rJVQWVlBRPTsSgWg/9d5PnkDp77p5gzV4IdCIE71rko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDyWDiWoWfLRRnOyzx9+HRxKnxOCgAqmE25yKOjA0kYP8oeESPvCwELsOyFnpUdwT7D3cghSOqAPX7ENXS7qANkFmd4nmAS5ur8kQ9+I18MSMAjXxLLUH3XlEbP2HKifytxmcxPOnxgpROKNxCFWhVq6NB6IzlYdSsPEJWZodR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnmMhD3c; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnmMhD3c"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14129667240so276894c88.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791286373; x=1791891173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rJVQWVlBRPTsSgWg/9d5PnkDp77p5gzV4IdCIE71rko=;
        b=UnmMhD3c/DemDsW1kzUmTLCcHAhjLksBfrH49KWFTJRNAZV+0RmfqE7UDK3BYdKyPi
         TC30z8PS2AUSkcTV2FSnuFL0TRJa+Rl691xmJtEeAAjZMFhfKS9s9nNpUrwATIr5NIaF
         2edlrETUFRb1hb7iTkttTjS0xClllwb1GYCvt3kKWZawfGg7fptZ+/bnUCuX9BIE0/7l
         N6fImMW0Jf5gsAm7gSx4gaxTVCK9hL/bNTCF+oxcLTL4b8vLmdwcK3HC9pWZl9+1tR84
         137hB0uLjtFewk0LCubpHfbfkAPK4wJG4TwRr5/7MKi9e5tRfC7V1aXGsJ5XoXwNJKtP
         vCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286373; x=1791891173;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJVQWVlBRPTsSgWg/9d5PnkDp77p5gzV4IdCIE71rko=;
        b=LGrF7bOmLOMQasiKv3y3K3nq2xnbXntBF+CybftJ8ZkiYSibWf/vVtbTWlN+C9Aq53
         gsFn9Ib+pg+8zfyM9bKIc9gI+MkWeMLV0/MyoRrc5Wqzr7ujANNgzAigP//Tjn6Yn8+Y
         2JXSTBoVi/N9ZcYotPJyUzILBpVyp0ZiTz0I+eg2KPFKdCRaK9bptfM9PUDHLbK63wqi
         VT9Gs6wSR3XUwzdfA0cVe/H+nhFSnRzKudMVC6bKYm+YQxYacW6RJdIMbIJ2IOybT1Du
         nP8Yal+qOEXFRyjCjhrzHyjBjtokWri0BN1XD/ZVgW8JRYBafDNLnXL/N1un2k5c+D1J
         8glQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlXlIb3FGhJBm0niwGtrluloi4n1IwgJ3Yp0b2RNgqnROqruuaWZD3A3lKuPkxx5bnzT8i/lM=@vger.kernel.org
X-Gm-Message-State: AFuF++nj/wQSJzRRpHER7YjpO9Qzeg5+sgXqlcdF3aE+6quOeBGlCo/n
	d+xYxWnWS96/Etn0wrEctxGBLPg88Q+DgJpj6H10CAKax0mwIsDDYKmW
X-Gm-Gg: AYBFou3NTMWqFVtczKfhylU6Q3D06qWmYX3bQF/2aEQBxKjE9KKn+QOojtlj6dZCDzl
	xKWr74g0uqxEiFvxcvwtJPG2rpCXellQptQK0OAEgiMeSOJsolFMpNi3rCI/Cocv+F+/GMkBPGP
	dyk5RflQlNLdoT9rofuX2mgZUsicAAED/saxLz+gzX1RG7ms48fhlY71IuOobOyTt7j8xkjCbHg
	HXd5hgof8hH1ilGAXq8RuEmAeHvUzLfcpD7qpTcHpg4CjB7fWsf+A6c4Z99AB3/sxBhuKDAjB+I
	f+bdykAajKKeQgU+igTd16eEcm7Z6cEGZb4eb9DRlocOgH1NsnXMfspEP8XeWdbmQ20PJ8hS1lE
	/JuS7MMmghioe4IoztPT9z5pnkO096+DumoqBwZ6g1Xzv4tRsvcv8kPmVlLXtCCWMlKiYWQZe/f
	ENkYkizCIuBwDdslLi6W2VA/K/hE1obRmST2OsxnQjJe0ThMv17+CdGROGzdPcKblyqvWqKjpht
	9ghDwjqeHsYaTAza7aTvAw2OQCskuCsV/8f9BbGw66rYWcdb6OxtecDCqtfC6MlTbMgRr99buKH
	LuqSrGuDuUi1V05W
X-Received: by 2002:a05:7022:eb47:10b0:151:2e62:fe4b with SMTP id a92af1059eb24-15eca269596mr1503491c88.23.1791286373021;
        Tue, 06 Oct 2026 04:32:53 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-160677a08fcsm241105c88.3.2026.10.06.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:32:52 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Tue,  6 Oct 2026 08:32:35 -0300
Message-ID: <20261006113235.86144-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e9538164-3565-a702-c26b-bdc0b8cb1c6c@linux.intel.com>
References: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com> <20261005172538.398522-2-vinicius.eduardo.pedrosa@gmail.com> <e9538164-3565-a702-c26b-bdc0b8cb1c6c@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On Tue, 6 Oct 2026, Ilpo Järvinen wrote:
> It might be better to add __dw8250_set_divisor() to dwlib to keep the DLF
> setting code in one place.

[...]

> It might be safer approach to NULL check .set_divisor in dwlib before
> setting it as ordering requirements like this are easy to miss.

Agreed on both, I'll do it that way in v2. I reran patch 1 on its own
after the change and the console still survives the termios stress loop.

Thanks,
Vinicius
