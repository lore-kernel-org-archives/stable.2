Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697567;
	b=BOv86fCfTzsgIICLKVk/Eo6G2u0Zq5JDGmfKRNrER9dz9BliDbQ8EF+b85eNL54BBgxV
	 C13tNCPr1F/uATpP4zDU6j2Y+T49KcWNOjzlZ1ABOLDvq53E4mW7OwInZGyizGv/T3lVK
	 BeyWaqv4gSf0A/Xmji5+pD72DS/2azRj0RY0NRWd8mLDl9jxAy5hISjodThnecB2JrYCb
	 qkh60fIK9/O3s1BXM+hv1WtHe6MP0JAa4O7Eos9o0DkmGEkOXIFhR4CJ9nFR43yM8gDJe
	 Qv8cllGqUZg9hOFB7UEolYITo2eUVEIUC1iU5MHuByr1mv4JKoYUjQkn6afSs+wAOBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697567;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=PVa9ekImbNy0eUOCh+fU0MyKlDIldS/ykE7Tfd4W/ZI=;
	b=STVlgJftmrNyDdDzLWsfd/GfmJ+b8+Esqab+tknNAysv3VM21WS6QNFPA5gzrvl8YijT
	 usIcHSMK4INDAnHp5x5XelKdojjpdOwxkRCAf4pwE58r8jfPueDAs23XpyDRfrPWzPHwS
	 C+40m1ERVpC+CyJd+Hx5SAgf6cXXkGJifMeWCvZZnYe5fNTiL9qh6eFs51rLcMZoxKAAx
	 jXYgLizqnjQaMVeFMuoc9OdoxyIcBXPgbo7qpc0He4zxnRH81vTrY/47OIWDqel6igfg7
	 /H7+NVFM0xAhuFLBIoRmSMNRcEjwW2jnZb0clcX83veclQXQjjkNx+kNEYfZu/eesMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=C43ld5DV;
	arc=none smtp.remote-ip=209.85.222.225
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51C606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D51C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=C43ld5DV
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93f2049ea7aso494687685a.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795697566; x=1796302366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVa9ekImbNy0eUOCh+fU0MyKlDIldS/ykE7Tfd4W/ZI=;
        b=jmCvWImmzzn+jg0xMZqXn+VTIgCV9XBb52y+PT6jFThMUvm5pB8V1e7QOD4RwzTFKl
         4qlDcsgAaR7BXfF0JfBDSiwKaj4XuIFZ8g9zRzjU2Kz0487RQNNF2nQjsPITr0zfqBct
         WEYKcMFwJD/Yh65pn05KR9rK/f0eTVEmPd/ZqtKDuRYogFAgLqa2kkdMo4WxZ2VWm08j
         nwILDUsDezWTeK8UPu9m9oTnQ0cqBKOSse8/5dix8w0Osj8UCXbDf60TPWJS+z4/aHDL
         gfD5v0+pLBELID+ohxdka1u88tfOYRXTrsVnKtwPg39Q6FRcgDCk86NXfZWE27dkRMqh
         d8Pw==
X-Forwarded-Encrypted: i=1; AL+hErHdrIgOiGFbrGz03Uciupfdv931PKAJrRLpZJm+P7UPa6w+iw7+rGBz/Z2XUYT2yNb8EHC21HU=@vger.kernel.org
X-Gm-Message-State: APuU4Z86NB9kM5W47TC+jlbMr/9szqPLIlB/dNZiU5gxqT3qC2qygX/0
	BAVvZNY/732NDQUF1dGyaU1RcPvbysIlluys7wQ3fO3yYQukhLmUzTWHse38G7aM8YkPh8zRH6U
	pW7ZdCPXRDFSHgZhOpNO/eSuU2eWgJHXosNNcd9IutHhNjlD4FStCfABUKEDJUSyMcDYz7OFwjl
	D5MfnvRpwj2pb4vwlTh0c9nCzw3nOiZJf74AArT2ZtemiHiKhc+jjWlyQ24Erdz7mc/GSmcJ/pK
	px+LP3MDHfrigIqkQ==
X-Gm-Gg: AZFdTZcVRKuTtby+/M4pbk75cviTuLx+fEnAkD3YzBk/rOELrfLnKfr4jIYaiIFvUGj
	umII5YucD6orw8Xtq4YoH6M8bG+iME8hc74V3FeOdkhOwE9doGvI1tNN2XqEfYZFxXd49f6pALK
	voGATPScgGhhOYrKaMLb23xhzQPOipOFrDvTLNmzOGUqXPdNNPYuhrhsZ4Ga4pM+/S3zKHYtla8
	Czl7cMDIyPR+2YSFZSyGUYFBDQp1yCs6oQfE5oDFetILe6+MpA8Zaesz8gCI/sKj4LZYjtZIxN2
	vz7eaqksq+sBzxmS0Whs+SMT09shsdf2kTO7rDTQN3u/d8+k7HOgHeYohdVkTFnF6ANt6yvx2FI
	uGv9LIGxpqq5w5S0m9iKMP/BSN5vHjpjbHbTIixPW5R+f+c5WUZHkJPckWjV4wv9c8OLd73HoQr
	k651F3UVzv01KnHEzVFX79JxCe9cqR8faLOkJMO/U=
X-Received: by 2002:a05:620a:4688:b0:949:7c8c:54d1 with SMTP id af79cd13be357-949bab181d1mr3775304985a.52.1795697566167;
        Thu, 26 Nov 2026 04:52:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-949bb35c69bsm166263785a.9.2026.11.26.04.52.45
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Nov 2026 04:52:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-94970ad532bso508359985a.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795697565; x=1796302365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVa9ekImbNy0eUOCh+fU0MyKlDIldS/ykE7Tfd4W/ZI=;
        b=C43ld5DVjh0EFQDGc8CsBRsGWj+Xv+RtyfKrgD38ggGjJUJQDuXl3eMavsdm/O9LEU
         KCZAmMAOjlwiwmqhVWf0H1BOsGl1ZLiDYU+mhidoHBOhFqB4Ry++iMir6ZQRXCjNhh10
         bXi8aJYIOyBqHr4d7LZrEaYYI0yw0M14N1wSw=
X-Forwarded-Encrypted: i=1; AL+hErHjnuQN6vtJzfvVbMMMFgWC8PKD0cGNvTCZRu0+1foRfuJ/ugjmWo9LUJwyam7oZtfUJ2wjcR8=@vger.kernel.org
X-Received: by 2002:a05:620a:460d:b0:93f:4d4e:ff6b with SMTP id af79cd13be357-949ba81a543mr3602881985a.12.1795697565342;
        Thu, 26 Nov 2026 04:52:45 -0800 (PST)
X-Received: by 2002:a05:620a:460d:b0:93f:4d4e:ff6b with SMTP id af79cd13be357-949ba81a543mr3602878285a.12.1795697564924;
        Thu, 26 Nov 2026 04:52:44 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94a0c18267esm311983385a.4.2026.11.26.04.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:52:44 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	fariyaf@gmail.com,
	linville@tuxdriver.com,
	kvalo@kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless 1/2] wifi: brcmfmac: zero-pad SDIO write to 4-byte boundary
Date: Thu, 26 Nov 2026 13:52:40 +0100
Message-ID: <20261126125240.958940-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102122311.181075-2-tristmd@gmail.com>
References: <20261102122311.181075-2-tristmd@gmail.com>
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

On Mon, 2 Nov 2026 12:23:10 +0000, Tristan Madani <tristmd@gmail.com> wrote:
> brcmf_sdiod_skbuff_write() rounds skb->len up to the next 4-byte
> boundary and passes the larger size to sdio_memcpy_toio().  The 1-3
> extra bytes come from heap memory past skb->data, leaking stale kernel
> data to the wireless device.
>
> Zero-fill the padding before the SDIO write.
>
> Fixes: 8f13c87ccc49 ("brcmfmac: Split brcmf_sdiod_buffrw function up.")

[...]

> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 3 +++
>  1 file changed, 3 insertions(+)

[...]

> @@ -323,6 +323,9 @@ static int brcmf_sdiod_skbuff_write(struct brcmf_sdio_dev *sdiodev,
>  	req_sz = skb->len + 3;
>  	req_sz &= (uint)~3;
>  
> +	if (req_sz > skb->len)
> +		memset(skb->data + skb->len, 0, req_sz - skb->len);
> +
>  	err = sdio_memcpy_toio(func, addr, ((u8 *)(skb->data)), req_sz);
>  
>  	if (err == -ENOMEDIUM)

The padding lies beyond skb->len, so this memset is only safe when
skb_tailroom(skb) >= req_sz - skb->len, and nothing guarantees that for
the skbs reaching this function (e.g. a data skb in the non-glom path).
If the tailroom is short the memset overwrites skb_shared_info. Please
check the tailroom (brcmf_sdio_txpkt_prep_sg() does so before it adds
tail padding) and handle the short case, e.g. by expanding the tail.

Also, the 4-byte rounding of the length predates the commit in the
Fixes tag, which only split the function up. Please point the tag at
the commit that introduced the rounding. The SDPCM header carries the
unpadded frame length so the device should ignore the padding bytes; a
word on the actual impact and how this was tested would be good.

Regards,
Arend
