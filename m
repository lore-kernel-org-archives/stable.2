Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326AD3DDDDB
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139169; cv=none; b=bVig+vJywvLcPjDD/ONIIFKCSspRJiN/533mtx5YJHMkEzI0hFTzFCHdy85uTZeZb0Neglib2zpSaUSN2KgStL/iHwUlkDpD+Dk37Ea38/x8Zr91y157SvZIdbcKq03tqPdmIIwqMe8CuOADGJqzyaUPgNyTfdkofRH9RHbcdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139169; c=relaxed/simple;
	bh=yTyTGQUZcmxCjb2rA3dC2hsvuA/zoefJKEwfFDiI964=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alCwLIDtinz8n6ajECrx/gqa9/2jUAHQtyKiZK164VcnsOubE2DfkjjMzSiuYwDWx6+tnBwZg8zzBAoLgh8xYkdWF/zAR81ZyWMOQuhaUnV/CYJEUf9hXpfXprfS/RemBbl6BY64bai93kzBih6kVDedy0JkPKZZ3oY+qaywdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TKsMVqKM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKsMVqKM"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69ff40d9cbcso989138a12.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785139166; x=1785743966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e8T21aJoofkItxRugQyBz5A/faj7Zac2nTUnWe+9Fc4=;
        b=TKsMVqKMagIKF0wdJ5FULsG8hd00glnhdbeDmAy9QKZGyn/fMZfaSqiccgEQAp5Kde
         0irMC11d16xt/IRwyA7LXwO4Il99xWoWgXQAamUGzZsl/nEzkFWPHfz8w4EI4wqbX+Fx
         KbAY+sCUXsOFqjoSCq0mosTUzd8/40W6aYnScFqO6+zIBROx0DkvFlqOc5Y/KuRb/obF
         CpPz1UiCB9/zmFndW1gc4o8Ma6rZKXGkyNG/6q5c52+BhK5pUFVIlzTtu3/uND3HSAuS
         qAScKAs/PUBodapWNujKdC2jpmNxV++5JTTLv+r/ICzTrE+VZfJU7pPSY1QSWHa0RAnf
         aIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785139166; x=1785743966;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8T21aJoofkItxRugQyBz5A/faj7Zac2nTUnWe+9Fc4=;
        b=V71nSxLz665zQdD7WrnXm1hUe1Mjquvy5ejhEiPOsrVyqIayuJCIo32KGaC0cw1Tl8
         i8khMbQzJw1XTfowSfcm4K2ED/HjaHv92S6ns8bMpOv9e26YANrlvhI5qdIO/iC2Os0T
         ku9pMR1shWc/9Bpxp89z7pw3/Mh5Gpys3uwfY3nILmkI/d8WerXzS9ThfBVhdgkCGEEl
         c5F2b/TVHqksv96BKhPd0X/NE+QP3P08JVHRaA1sy4gwlz6X++I0DJjAk6iplqAmaAHQ
         8FpjHeDFTwQum+tgqPcBLkaJ3I9Aitgoh74Q4aWhEuX2qwvM7a1nW7PRsazhnCGKU1Mx
         Ms2w==
X-Forwarded-Encrypted: i=1; AHgh+RqPnvSLWkMLBi9pWwWn8QOh5blo70VRNMgjv9uOKT3eegJEepGD5JZbYrYKfvv3ed+cL9MnMWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ssy2GDQFeQ1+pLqJ5/saLl85L0Lci1FXzI1Re4MekSqMuPJs
	RwQ4E8/r7m+5dMJGjdtdVASVXm7/9ainXKPyRgwOzdqvBaScjwfcgVZg6bBKeQYup60=
X-Gm-Gg: AR+sD11V1n71QUuH8DI2jhhPSzdiY9sN59U3KowxVPgODiAxs45ZzbHQuvQeoewuxvu
	nPFBmRviSzrl38V4ONMvAKTcMEeeilsywNCPvwFQazzbxBfR4VcLXNDvcGvrJAG/JIZtl8jSqGC
	ZG35FI1RKMRGA8Mp8E2/tDoqhb0nFOTLERfvZEbRLiww4ZMvHDBAEY7t6R/oFTFo5qQDp6/tkTF
	adBZ0r1wVxTPB803YnRc6wD6WdbKNbvyixwT4QEw+tn8++EncW6PaFzazCeyqF6m6U2Q4J8oLgq
	JGAST0wcefxtQ2RWiuSlYv6LzvzSY9x+jGMYaKyNl+CbeVpr3S6yChqJcWXI8yPMz/himnCEw1+
	1h/N8JjVXXfweziBcCtvnLAJsIhr/ks9UhWJrkjJNy9+rn7jb6zFgF573eL+1+W4KBhYlk2BSYF
	j8Ii/fVmgHF9H8k20=
X-Received: by 2002:a05:6402:5253:b0:68b:31c5:86f7 with SMTP id 4fb4d7f45d1cf-69fc1005b98mr2845690a12.16.1785139166427;
        Mon, 27 Jul 2026 00:59:26 -0700 (PDT)
Received: from [192.168.0.101] ([109.77.105.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb5543370sm2173807a12.15.2026.07.27.00.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 00:59:25 -0700 (PDT)
Message-ID: <8e61e152-5cb9-4227-ac88-045317cad356@linaro.org>
Date: Mon, 27 Jul 2026 08:59:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] media: i2c: ov8856 : remove ACPI node bypass
 mechanism
To: Serin Yeh <serin.yeh@intel.com>, linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com, jimmy.su@intel.com, sarang.sapre@intel.com,
 kieran.bingham@ideasonboard.com, stable@vger.kernel.org
References: <r5b1FOGJuzth4pPRU-BrT3hB8Ak2yCg8-NXDGrUupUhjpvg5G3x5OZWb4q2K2MtOQykyEnNrIKX3WTIqR6Eiyg==@protonmail.internalid>
 <20260723074036.369363-1-serin.yeh@intel.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20260723074036.369363-1-serin.yeh@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/07/2026 08:40, Serin Yeh wrote:
> The driver currently skips power-on and power-off sequences when
> running with ACPI devices by checking is_acpi_node(). This results in
> all power configuration steps (GPIO, and regulators) being bypassed.
> 
> Remove the is_acpi_node() checks to ensure that the full power
> sequence is always executed regardless of the firmware interface.
> 
> With these changes, the driver behaves consistently across DT and ACPI
> platforms and ensures correct hardware initialization.
I think your description in the cover letter should be incoporated into 
your commit log

"- Background: power resources on Intel ACPI platforms :
On Intel platforms the sensor is enumerated via ACPI, and an INT3472
"discrete" companion device (the power-logic-control driver under
drivers/platform/x86/intel/int3472) registers the sensor's reset/powerdown
GPIOs and the regulator supply.
These resources are therefore discoverable and usable through the
standard gpiod/regulator lookups at probe time.

- Current symptom :
Previously the driver guarded both the GPIO/regulator acquisition in
ov8856_get_hwcfg() and the whole power on/off sequence with 
is_acpi_node() and
skipped them on ACPI. As a result the sensor was never powered or reset 
by the
driver and probe failed when reading the chip ID in 
ov8856_identify_module().
Removing those checks makes the ACPI path behave like DT.

- Validation :
Tested on Intel platforms with kernel 6.17 and 7.0."

Then:

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
