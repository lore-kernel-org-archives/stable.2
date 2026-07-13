Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B13E867F
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939908; cv=none; b=mlSoY8ae2X+w5a0nfLhw+JWPWFIwpadd+A+Tt0O/5NtkuGZoH1vXhaG18IHGuDHU8Ceqjh4u6PprCiFzzN6Dy1RUPCOyjAsg1yqkD/p2muYUdSASEjKhtetVNqqi0B5X0q+hayREfXzTNP+fqyN3jclvfKETkeAQ2HjZIzjsr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939908; c=relaxed/simple;
	bh=ztP+Lg5fklMhhuTpaIR9LJ0qNO0Jn8X8jfLGw8P7Y/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuLgKczDE4+0ynxWBbEfwk9bCe2ZbMkop9RN01TCtR4pLOI7+SunRoGBT1SOm7hYUBNlAkKuM86ONHSo1Es3//SCEKJHtTIWh36HXIH3pt9T4Gyo+R48ezRT7TvThsYa72qy/b1UoxwSCde1Z/clxlJlTzjlHJWqDf2os9ycQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qu3pxmok; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qu3pxmok"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-51c21495722so16804231cf.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 03:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939905; x=1784544705;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xAMD//Z3RnvPCQ/mYGTihmrUMMj+M8oLlYOH5HAiHag=;
        b=tZSq5eJpmUZKE4TquNyh21mmPVeVs+r6/ngNBvilk0mMgY3VBcVv4zPBrSi9M82wMb
         Id9sp5Hqcl12xi30EASNCVyBkbBONLjtlgOg9AO6O4zvfzTGeCEcSqMvdBgem3nWi4NJ
         pfAHWS6vvL/sRhvOf9b+LRwIOR0RzgMEAjYf/E6DD3lcWcedylR8zd2/KUiHbalwG2CP
         p10nAmUVSsYm18YQDxhrewWni/v0iNzsQG2JGlyZ2CJqwO0A/QyYgIgBtL5UTEEL1pDC
         vYmRvuVC5CwqbGLiuGT3SJpobX82ff0xSWH0oVXhXAf7noIFVz0He8B8VnNOZlbgxE/Y
         kJVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3i6UzUekzM2HwtTef5GrxRt1LeIMZVx5FMXglkCMHBgoaghHyevY+et/XFqXyVWhgOVcYn2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+c8+6P7h+73PTi4Y2WHP9lrW9NjjvvmMNK9WAbSEzLdF+68fz
	P0KcpPBCYygzUljRqlWomQI0HKqjkUjyLo0pI2B9ajgTFn6MTO0z86oDFQJxrJyBQo9PTvyOkK6
	JdeJym2iplUq3vJ3NEcEt91bkranaztASZAwfxSq1rffrDHVR2pCM/XeeM+WgbSsrUl8ApV730B
	bpqkxurQTSFduLfJdmjgZaOyY1gXzHJrKYHpZBltxv71k2JWdkWYBggd0W2TpRqvBJR8WmwZ5E7
	XMFo6+fnmqEDR9alA==
X-Gm-Gg: AfdE7ckot1kNIX6Oox5vOWm6djztqjF2QfpmkSiwE9r83LQz4qX+5Q4ncTDWKH051ca
	0ijzLN4ln750sspNcbzp/0V/AneKY1Ag8019ljkU7fqZwnaJgPKrKrM7HUObr3YGwIuXYjie1hw
	kd1XcbiKFocQLLzGPPR07CDyI0Q1Hi+56/hKWy7TLQBu0Sscxkx5Da3/ZlalOLR4qcZqgI5wpp9
	okIoKjIMzCOzIYjpcJgeg8hGusHvIrYHGLahQjL/CXvmxWxd8C5/1GUgM3oBavW5DqPgTuaOWJH
	sZmJBNGR2e9OBqagMP4YcDpdLqcBuC9lqassyz/qGGG7vcpJx9fUpQ7FWoLVHqcH9wu8YvIix2S
	Sazl/31ySdP8c0V3YL0vQbZAJiMiiLesKdvccMOvyn+qe4Mb95d4fqY+Nr3OEmPQkRizE9feUGD
	5QNeF5zjmXFBbEqCgjKPtU7uvyhWvjUjMBtLhfSaWWzx1Qc4E=
X-Received: by 2002:a05:622a:115:b0:51c:161e:25a9 with SMTP id d75a77b69052e-51cbf3053f1mr78255831cf.62.1783939905276;
        Mon, 13 Jul 2026 03:51:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-90745683c25sm87416d6.22.2026.07.13.03.51.44
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 03:51:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-904ee4473a8so25122516d6.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783939904; x=1784544704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAMD//Z3RnvPCQ/mYGTihmrUMMj+M8oLlYOH5HAiHag=;
        b=Qu3pxmokRpr0dUl75Pybfv4F386T9ikvdUa6cDG+5ZmSIJ/J+hV/oqxmpAFWCxmTbS
         i/1mI20PdWUWHtMV9Szt9UXqUfYxPtB6rPPesJkknaqbYrhRDMa7n7kGA1sVwOPCYKOp
         TNmEKpbVIHcInRyZ0Q34StMzSHY2vlckNmJHs=
X-Forwarded-Encrypted: i=1; AHgh+Rq5CeL8II4jbWhCIQImg+D6/vLtmNTHtvuvCQ7KXDyWg+ywP86GnoCzFa5p9J7RTIueUF1jTgE=@vger.kernel.org
X-Received: by 2002:a05:6214:238d:b0:8f2:67bb:a37d with SMTP id 6a1803df08f44-9040471eca3mr96339716d6.57.1783939904519;
        Mon, 13 Jul 2026 03:51:44 -0700 (PDT)
X-Received: by 2002:a05:6214:238d:b0:8f2:67bb:a37d with SMTP id 6a1803df08f44-9040471eca3mr96339506d6.57.1783939904024;
        Mon, 13 Jul 2026 03:51:44 -0700 (PDT)
Received: from [10.176.2.203] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d3acsm124246046d6.24.2026.07.13.03.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 03:51:43 -0700 (PDT)
Message-ID: <36f4388a-b856-438c-8ef4-795a7b1eda3e@broadcom.com>
Date: Mon, 13 Jul 2026 12:51:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
To: LiangCheng Wang <zaq14760@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Angus Ainslie <angus@akkea.ca>
Cc: Wig Cheng <onlywig@gmail.com>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260713-b43752-f2-blksz-v1-1-8697fcfeaef4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 13/07/2026 10:50, LiangCheng Wang wrote:
> The BCM43752 is not reliable with the default 512-byte SDIO function 2
> block size: on an i.MX8MP board with an AMPAK AP6275S module at
> SDR104 / 200 MHz, an iperf TX stress test kills WLAN within seconds:
> 
>    mmc_submit_one: CMD53 sg block write failed -84
>    brcmf_sdio_dpc: failed backplane access over SDIO, halting operation
> 
> Commit d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> set up the 43752 like the 4373 for the F2 watermark but missed the F2
> block size, which the 4373 limits to 256 bytes. The vendor driver
> (bcmdhd) also programs a 256-byte F2 block size for this chip and runs
> the same hardware without errors.
> 
> Group the 43752 with the 4373, matching the F2 watermark handling.
> With this change a 10-minute bidirectional iperf3 soak completes with
> zero SDIO errors at ~270 Mbit/s in each direction.
> 
> Fixes: d2587c57ffd8 ("brcmfmac: add 43752 SDIO ids and initialization")
> Cc: stable@vger.kernel.org # <= 6.16 needs the CYPRESS_43752 id name

Looks good to me but the stable instruction looks confusion. What do you 
mean. If there is no 43752 support there is no need for this patch, right?

Regards,
Arend

> Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
> ---
