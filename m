Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2503BED61
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488864; cv=none; b=VTADrTj0mL9Elr2w2/mC5hSykxhnZrm0XpCYwMq1huSql2goECsKRG6k6NHHGObgPZzLxKfmqSyEEiE8sqFvlO7SvNq3Ktj+cxkrPjbOqXwIGxlIAypBTeQjO1DZFhuVbFPxwsltA3XuDUQcLVbHxr3Xtt6AgiDfy5gFk0nPtjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488864; c=relaxed/simple;
	bh=sRRFrsFKA9RH+qVEe4sLf3Bn4Hv1AAnFFhCAQPy8oPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=coUljE+pdyu/r1sia8KwYvZBMVMMn00SK0URws8zvfkpnk571vhPl0iSrkOJEyO1wZ/zmuTNb5nlegPpPQyJWB4246IQXo5X/xOkx3/O+qlLp/veJjZODv+VIQVC0ScBQyUlcGVP4daiPqzg0uhiXdSOaqMwscDUHlc/d6TK0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhAaO71n; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhAaO71n"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b966dd74so647235e9.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 22:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783488861; x=1784093661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsXMeAJTPhvKWhSIBAKvzZLZgQxiBrV7ka/qY9S1tuo=;
        b=fhAaO71niMbyEfIV1r7/kJW+9a3f+dm3rAjUzH5oLirYeekoYeSfnQ17j2ATgK1XEO
         tJLYdSWK7nQAMDz9Ro2dbPbf6QqTk/tE2KwzH9acWx7qSoygRlqZdSh5VJAnsiLxJ9dG
         taI861G/K6R/VFa8PuIYfHi/5IqQHIrCZ8eVs9UbXQoA9ybvdNhuXDTxtfr6lz+/Fhw7
         N45ics/ySzew9sf7piAYoKfxE5TWRxy8Oc6EAJ6hqAAJltBhi7lST3cu25s6qt20MR+V
         1eYY8OlksMnlWXe9FNgnr35v3qSU7e4wIr6nRub4R7DFtRrE8HZiPGhNdodYySeyzF1w
         bezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783488861; x=1784093661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsXMeAJTPhvKWhSIBAKvzZLZgQxiBrV7ka/qY9S1tuo=;
        b=mhxU+JlpzmgEzsp0S/qrCSxMGRtq+JXw/Ihy9OW2Zy/FQ4WiO14Y6kil1Z21Z5eAbL
         ZGx32HxpbBX0mB1eVVn4eUj7mU2zO3qYXcgzXNR/wyf81KV+sF/rO9XE6ucEW/FMjkkK
         FYMlSxgrwGJs9ik4Z8NeGN6CoZfGqXh7rC7ibc+R3uV+zRUG91iXmZ3jCGJqx54zOwTB
         6ewvwysLNPfpLpfYc+ZPpqIXcOQ3HrrjCTvIkKUGr4r4wxvh83ywxiKzSJixRnMW7e9V
         WwqP78NRySNP9ECLZZcVbrZXw8zahXrVd7czeoUVMG47LeruFlWXpHF/VZcB9v3LJ5I3
         mlMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJY0Uc3nixGuAkufBnmlWXEnBQh+F70hPMYJs3S7LeAznM9geqFixyAUFzUX9ZxIZkGJCO31A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/nDG336KaWHUJna6C2VoJysRF2kUbsoMBORhqYbYHsU/WMnxQ
	ykw64tpTjObSCUpOizOIuCWLB0bcrbK7brfm641miWx8kVR3T3h3UjWK
X-Gm-Gg: AfdE7clb7Ge7AucItOjt7v3kHQysWmkcfYx5vb/G6cmYzoenlv7gAd8gGpnxoXs4CIz
	zi3t0duXkRL+P+ExrX12EtvOp0PpN1Wh+7UYeBGdvzZMhi7fbvaEUKW51B+/DBUudt7SF/piD2K
	X41yYWMwuS6ses/Cx47kg3tMETicq+fhOiaQjAxHoOm553+JiBNIvW8+GUBJcuXr701ECCqkkQu
	SiKnfnqerEn+bvqzwOM5miBr4w9CkR6N2i94FAzSlXZj30Vzvo3opyR3PV+PB9iI8PSKJ4rtGOH
	Cg1idAW7YcRLSzTTHEOxnZPppomNYLKt2XNLU9qonN35SO7ss7zhoiAvJxoHn659QOf2mJw+dBQ
	IAtaMTawsQWVyh01HqhHJgkton/n/1p4+A8AUXU3XbXKmTGYV9/2KtjvVvC0dJzOog+ocz6hlHg
	FoNUZtwl3QvtDBlko4U6k+pviuozzPsq9BLrvDSlo6IwZyn02kzGkS02ZAZ3U872OPyGxUoGBx8
	Rnt6d4WtyWJNN2s7qnwb/3CIIMPjskEZAHeYeRSuQDuu26mtZVQfx1jrGhSM+j+Q4jlEFC+G5AM
	1ajA8pH4iKH0PjRfTMTkqYXjfvQdxGM0a7b3hsVOga25hao28svHOg==
X-Received: by 2002:a05:600c:6612:b0:493:b771:ddf9 with SMTP id 5b1f17b1804b1-493e68317cemr7675405e9.1.1783488861356;
        Tue, 07 Jul 2026 22:34:21 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e544837dsm35528415e9.0.2026.07.07.22.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:34:21 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 08 Jul 2026 07:34:13 +0200
Subject: [PATCH 2/3] iio: adc: max34408: add missing 'select REGMAP_I2C' to
 Kconfig
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-add-missing-regmap-v1-2-6d424322e3d4@gmail.com>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
In-Reply-To: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Stefan Popa <stefan.popa@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>, 
 Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783488858; l=814;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=sRRFrsFKA9RH+qVEe4sLf3Bn4Hv1AAnFFhCAQPy8oPQ=;
 b=rXzGTVA/DNt7Sz7ocfflBURTicKigCDwLN2u/1HoajTHSCOLgZXjz9zgInWuwzrSIwdI8FZNL
 Q8bgyri3DlkA48zumqv6DjmNMSkt8Iz5JHbWvImSV4S7ggn5cJWWvGa
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Kconfig entry for the MAX34408 is missing a 'select REGMAP_I2C',
causing build failures.

Fixes: cf27775838c5 ("iio: adc: Add driver support for MAX34408/9")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6d1170bc4c7c..01e48d6701ee 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1085,6 +1085,7 @@ config MAX14001
 config MAX34408
 	tristate "Maxim max34408/max344089 ADC driver"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say yes here to build support for Maxim max34408/max34409 current sense
 	  monitor with 8-bits ADC interface with overcurrent delay/threshold and

-- 
2.54.0

