Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6834B43F
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964653; cv=none; b=j67KpkKLZtbgAjZHcCH7zA8+519RPlbU/vlAbnn25aG392jK/QCxZZcy6P4KmmkyWy0FMuGRwa66dh2u7MsxP17dbxjGDUdVGM0lSDzD+S0N2V4f6qNrmAQnfkrMJUNvA3hMJIS+X284OptR8zaEaHCbL0PKzgsWz2T46uDrRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964653; c=relaxed/simple;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/jaxvd12WKpZI2wGuJ82Sw9ByijQD0z3mAwgSUpEhQ/9WqfyXmfbrJZjgaozf7W08hOEqKm4qJRTuC53ogFjvKeeFO9IENCY+0Qw3xPfb9eof9Z40Lu6tx1vDMh/igQDogU7TatzDY8x902t3J7mGxxmKTFdG1LQVlD2J8+owc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVQX6Csy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVQX6Csy"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce7d2adef4so638425ad.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783964652; x=1784569452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=YVQX6Csyxrsc4YDfTiO/wM2Xzc+sFs4Um+BKRypZBuETxe13r2I+w+qu8bXfrCdvJb
         x7pRrnz4RPPgnPb+LoKZ6qXW9w/4GcGtxoiCyhmEvaBbU7Hm5wNY5IXv48FIQrATJACp
         LMdBGAunfEtRZzhHUnh3LwOohpeAGkQtbWjuqz8cX4idECnkSlfwknUnptJ4htk+WVBt
         XwwPPJXS0PW+sQcxOJMhMy6bPJSUKR12jpNR2oKKZvnanGmS5W+GUcDCYtzRwiHyJXt0
         sncbXRrUfvqnvEGqARDM1LVqz4CdhbFm6lMI48/hgeeGlq365iSChbrpiYdzC8zWWARY
         wEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783964652; x=1784569452;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=ccgeMu4e1uvaLFiZnFusQeM0Q40ji0ylSZD4m23vSCHNHMmaoPxxB9lzhHWjd4HC2w
         j0wJN8wYkSPd/7WSOsjlEyXzm5Rj1PppeRWx1+hJ/DjlSoPXiTQHKJ1tCKcponWcMLBe
         /Fs/IaCisoco0ldIYJbJVnETVDvb+dQ0/lfM/Tmq3PtGb93FmDDNH0ee/VqBVSh4CYya
         tu8SVnpH7ePUMq5RaWAYrl39kP3P/QJoy23rjgcNRFnpZZoDK74rR3JgdL9ONXw6s763
         vPCynIHq3ErFH+3PCAfIPpxoLCxqNf1oSiTR0lvXoH02ADqyOlYkoQU8HENLZPcOH+IP
         pgfA==
X-Gm-Message-State: AOJu0YzxYj9fgJ0Hq6lsjDbZVhhYNxn2EoLf0XIP6qSJcUNaXaV4vOBC
	ladsCRaql+kjAo561I8zP+3u2cOztvLIrVzPjNjt5HTP3p7NUj0bQtIW
X-Gm-Gg: AfdE7ckHrJSbCaA0GLQbwBuaEE6yXalHbWKOefXwDbuGwr8i24b5Hd42E04ANI49Z98
	vkGEnEFlWc9sz7QKmd75hFzycJGyirHwMyd6im9qlxutArwapbNrniTnQGO6j1pK3gznJRK5M/L
	q1qPmswrbyFzIBpVvvOXwXm+Ad/APyRVsGRJ9p2DwvNgUY89H7oKpbEnzhM5MLdmj8YQ5sqXm2k
	q9F/jFeiP9Uron5Q/ca3lAXbrI4bepcSI+WqfFMB3L/eNE6kUR6EkXaFWYEXuVdhQw52qKmbKg2
	2qr1isgqqv2rginRa6wZTR8FVBdujZzlcDgLTaUcUqLu7vdOII4Lkir/W9Htl6iFu4CTB7/m3kq
	qNZ1SsAVDM+mYT/9GvNm9kPgGFsMNB4UAY1HznA4fVT8YijBX947B+tscdXmur/kjc5uOI/uCqY
	CihQCB0tIm4qzI5jVtbDRj35UgttYvFMcShqMRe0LCeHIXIeEC+RvrqtWFMZDw8/uR18U=
X-Received: by 2002:a05:6a21:890d:b0:3c3:2e2b:2a0c with SMTP id adf61e73a8af0-3c32e2b4e6amr4647038637.18.1783964651871;
        Mon, 13 Jul 2026 10:44:11 -0700 (PDT)
Received: from [10.69.74.200] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b84d6ce15sm32086520c88.5.2026.07.13.10.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 10:44:11 -0700 (PDT)
Message-ID: <ed34e55e-c391-40a6-b381-6898f53ea20a@gmail.com>
Date: Mon, 13 Jul 2026 10:43:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: base: Remove statistics group if encryption
 group not created
To: "Ewan D. Milne" <emilne@redhat.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, justin.tee@broadcom.com,
 sarah.catania@broadcom.com, "paul.ely@broadcom.com" <paul.ely@broadcom.com>
References: <20260713173318.3060047-1-emilne@redhat.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20260713173318.3060047-1-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin
