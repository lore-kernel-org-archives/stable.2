Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703382;
	b=BRYhSvtzftTNJTLljYHZL/5EYchwoF+UChdOJnW5MNLn6EqrU0trzmxhBoSdUPh6mEks
	 mYsAT7Zh+qzSy/RuvicUX8Wx+xP4qyj1vZx94ZKiXFCvw2DEtIF+9obo9Jhn+SpF0JQCj
	 5QcIhxUim5M5tIPIsaHurvk5TwNOdF+uJpP0N1Ue6tr3WFAyhdhoaTF8L2h+P7vyQXuhn
	 EUP4xyJE9W3wKfsDGMqYPguh7bXZV/94gY1xeSEu4i3cHia3zhZde4X9/jrjv3BH32z2l
	 g1wLWhfTCnvEdxe/LQcJxTw3ASNvEiXgni2xbn0AqOQvhVljEsqq+7AJpgigeQ6Wf5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703382;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=SBkxFfdI6OFdLjN6um8D4P6aW28HTQiU9au3tlLimmQ=;
	b=ogkD4LBjk9vHiwUrdzwkp8vEgx7vvN9FTFvcPX6rkmqg1sjJfOB34QBG5rtZSPeDeXn0
	 s9bb7xA2L+73qcKTTbAxFNQan5fbDWnkvBEMOKns/WATioFkYUUpSrKmuXsLgatUJEwYj
	 fZjleH/mmitdk8M1RMUdimGkdZ4oM4FEhLl3X8uUnE3Z4RcO6cnzk0IJ8lkxE/0D0T/y/
	 fdb+2opOm24cAEwwwAWzDm058FcyFOn7Bh6ACts8KvC1xZ24sCq9u3U0J0SbRJBGN4AEh
	 QmTRWxW2z38H3NmEdCflywdDtjrawPvPjr4TdPt2U4T4ojdatb1vEmYOfrcLQrW1Eqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fWKjGQQO;
	arc=none smtp.remote-ip=209.85.222.228
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0254A606A332
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0254A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fWKjGQQO
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-943e8d35f74so692499585a.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795703381; x=1796308181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SBkxFfdI6OFdLjN6um8D4P6aW28HTQiU9au3tlLimmQ=;
        b=abRe0/O3fINy+G4ND5EKT9ciObmhMmIMPviUJ/HjKn2Umwq07WwKhhJ+spYkfAh4X/
         Xutstn2Fm4/0gg/MzGKf9Re5WlgmLiQD/XDSIe0CjlEvV2Rqvq4Ik8S/1Mv/C4ioXMhy
         7OvAUs06VV8Sib9EjLE5euYyGH4naG8QNDjodPsPGCIyVURQ/+SDG3sBanNAyplhCGWX
         uW9lhm2xRkFxlF4EvSiqdEoZfFFK/DQ7TpA/dX2GU5YmbogTXVyAtG/hRWza9sl8K9Al
         UHRZo5jcs+TsxULGXoQX38v6t2Rn+c8TZyBWy0lHQzuTjqgHFdrl+CxdapYI9CPlfrvh
         OOeQ==
X-Forwarded-Encrypted: i=1; AL+hErFATBhv5OfjnkNUMmfM3UcHQvwvpurwUTU13HYJHcwNeZW4AWTrJvenrDBMJLbpj+MzeXTj76U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oGFp9bQaNrkFB8t8qv86+SSFtejf2UX2hSaTBW6SsXYqo7U+w
	Lj6gKK7l7Mc7p+cZ4OTIwizrwkvnJwvzOrJ4oiT+lJE32fxPVYrrmkWqn7lRTQbfW9BoP1bU1lk
	kOpTxL4J+9+C5qj4r4YCivQ345/Pqd7ePhkhTs8oS924hrtqZhIiCwx5CUILXSDdDFEXaq0ePTA
	59GC74Tx49MDWoKHDoDNwUde/0zqcHMyY3jfLQIp9Wt4Gd3eCY0O+BMRu7xItZwU6m6XpOjN5So
	tNqo9apUeGTY0RXOA==
X-Gm-Gg: AZFdTZffl4i5uHkFC9e+J4bpapZeIo7pIi9NrNNRTqyhcTvLmi1eOI78qPrvsdjmZiZ
	tcAc3JIofdZ2szKwCFfw4/OWBJrpUGpNTyBZg3ANQ3AiBNu2Y5HCOyXSSaDLeFvkF4mzG0AbtEq
	2nnnCBa2mIr07o38fFfcO2joa6gQA+4U1ekMQjY1Ot0DwvnzRFPPlW2HxiguoEXf0nTRijBZqXj
	p4LQgyBXLjGf69RqrbKg7UTB51illbKLo+XbcrT2dqht3Y6Xf1QVhWc+D0ra3NKQj708pbSoTEX
	wDmCdreFon7nDH146TZ1CnIvCzE3Je/k0OTMnsjb4vNN1khbm3tBQ2hMHe8VlLnm7/f7Gzk0m3Z
	ykpdZvi8m/9sSrs+o2SdNit1NKFWy7Ug1iAXDZ9TrE6+ex5y8yaflIjZFYWB7Q/wjTieoI0GQe+
	i7YwaHcphpDD9A5j2dvBd1nbO+A0FyEUxAREhD0batCA==
X-Received: by 2002:a05:620a:27d5:b0:949:7502:697 with SMTP id af79cd13be357-949baa12773mr3485343685a.63.1795703380572;
        Thu, 26 Nov 2026 06:29:40 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-949bb34ee75sm176496585a.8.2026.11.26.06.29.39
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Nov 2026 06:29:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-92126ecb4b8so117033396d6.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795703379; x=1796308179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBkxFfdI6OFdLjN6um8D4P6aW28HTQiU9au3tlLimmQ=;
        b=fWKjGQQOEPE5bGh67ewNe96AjBjVdhKYORex7yBzbCAOToFNX+UYppeDlgbdNw9Du1
         5k8zVEYUjd2kLmffFvD3B0a4C1AtCuUngZngrw+jQJOeESYBaj/Nfaph6XgKTsFWj3Ku
         67eJGXsP90OVnhjI4MDYtvTKIs61CxVJXgYos=
X-Forwarded-Encrypted: i=1; AL+hErH81CAa4bd4v4ubqm9gzpVPSXfSM+8jd1ra6JHSI1iygV+wqzFCG6kQRvRbh82y4uz7UdGtXRU=@vger.kernel.org
X-Received: by 2002:a05:6214:318b:b0:921:1042:c46e with SMTP id 6a1803df08f44-92134b32b0cmr388369926d6.33.1795703379011;
        Thu, 26 Nov 2026 06:29:39 -0800 (PST)
X-Received: by 2002:a05:6214:318b:b0:921:1042:c46e with SMTP id 6a1803df08f44-92134b32b0cmr388369366d6.33.1795703378380;
        Thu, 26 Nov 2026 06:29:38 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921347a0b6bsm187895256d6.1.2026.11.26.06.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:29:37 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Soeren Coremans <sorencoremans@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	arend.vanspriel@broadcom.com,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless-next 1/3] wifi: brcmfmac: pcie: stop console read on invalid write index
Date: Thu, 26 Nov 2026 15:29:31 +0100
Message-ID: <20261126142933.875175-2-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105215954.184290-2-sorencoremans@gmail.com>
References: <20261105215954.184290-2-sorencoremans@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Thu,  5 Nov 2026 22:59:52 +0100, Soeren Coremans <sorencoremans@gmail.com> wrote:
> When the device drops off the bus, MMIO reads return all ones. The
> console write index then never matches read_idx, which wraps at
> bufsize, so brcmf_pcie_bus_console_read() loops forever and floods the
> kernel log with 0xff characters at several thousand lines per second.
>
> Seen on a BCM4366 after a firmware trap followed by a fatal PCIe error
> (FCP): the reset path and the failed dongle setup both entered the loop
> and never reached device_release_driver().
>
> Return early when the write index lies outside the console buffer.
>
> Found and written with the help of an AI coding assistant (Claude Opus
> 5.5); the cover letter describes how.
>
> Fixes: 9e37f045d5e7 ("brcmfmac: Adding PCIe bus layer support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Soeren Coremans <sorencoremans@gmail.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

You may add my acknowledgement in v2.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
