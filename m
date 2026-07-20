Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3643859F5
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576950; cv=none; b=Wk8VBe4y9Wv3lbvy3ZOI/TAlK2r+dTuaz3rf7HOrikCte81cn/YgfIGw1bi4wVH9T53bq5FqplQhuq2NX46i17KQEkfmQhNp83THuN5qTKLdd/aN4PoHC6o4T3SAICC85UUXIMAE/NHoz8RHnhM3sqoWkgkrT6X07GftiPivT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576950; c=relaxed/simple;
	bh=ztxmNjXfgKgZkt7b+JrhvxBJmCCQaF0BuoffXtWBugA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V97jkVE6zSO+JXliPnw68xwXlfRdVHMKxOGTnZeCNBY90j1x3yYwgMsfhNdkX9N3Sx8mBTyV6sTjmEM+eyi8LKYrShKLGDaaMhxUK6v3ekLS2UpRt5K+F0iqHMI6GU/kioisEhD33nWocPxGhTFGeiapQEHlXNTkvOhdTSA/AmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XDsXVmbN; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XDsXVmbN"
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-81eaf3709b4so83055987b3.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576947; x=1785181747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoyrZqE1Bvx1hfQa+4u0/DLW7aA7wFVgfenpGZVSMXQ=;
        b=Il0FhwRyjemflV6eJ29guTxwQyKMln8tYgXFWnDw1ol7AWrkOiaPLd3mn2Lud8lRlt
         nJrEj53ua50OCf3eLdZ3UthKl9LoAjKxMG4ya3pcPvrTGO16Z4Lv2XxjITQHngmvAZCP
         f8TQmEl2shv7mb/KHeY6LD7Oog2yrvLRGufNuXk1OHTtFx6hI2XmTPOMZ4oaXwBjKb2P
         suGD/sf9prGsYikJUrLhy4Rn0B05mgNCt7+oMCnD3y5JOaWioCKK3rV1VQgvJdbOvemy
         eqXlTFH1fmA2XzqAe9H4+TweyQsM1RwRZDnyRvlKMblEnUJCmAY765TFJ8FOdc4rNtVr
         tROA==
X-Forwarded-Encrypted: i=1; AHgh+RqVZ+NORzOuRJnWHJVplr8RfI8THHTecidSZ8RcEGNcix0HZ8Tam+INTn0/dCEnbZboCtGP758=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLiGK5yf/w6+bWf5n0eVYOHwF6gohIvCgokFj/L2vWhqW5C9uc
	TTmUU2Ke/7kPS93BrLOEKWnfUuMTJ2qVS3x9T6IJO2Unf2bzQKYEUT4xHMnSooePwjoO3IiswbP
	noQzz96ZD1jSbG7ZJkGYfvbUNbO2s3/K/pEEPIKLPkGdRpe8ei6uDy6OPMbguG+9lJZaHLz0Tb8
	olLvODSkgoq+cHek8UC9fP6rj0H18v1ZsgkWWr1mBmciY5F36M9lQhBWFMfC0UJ5eO3GRQP+5dC
	XyGSYDejclSkueEKg==
X-Gm-Gg: AR+sD11ARovBXS7GmcuwE0J8iZZcQBbHogs3sSpmCVKH3wC8riz/kSW14JcCqKen9B7
	CVMDFj44fZPL8azPgHYl7xR+CSvDuLAHb4iYUgbARDpDeZG+KFvwIo3YlN85QG6/gUQbUCSwDr1
	IAU1Citn8ZeoyBWjwo0+DLTrT9rAObNBHLEiJlT265Bf2ogU3KwIiAvY0C/Czkp5+EA5zxYcvS3
	pjfU6QBukfayaA7IW1lRsYzDfH9Qc1/cmV+Vl8r0H7wEDrhLrxx+xW4YnZJbN4TVprxfbb2Gaam
	IuU9pDPhcinvh5ix42mxUEge2Bkmh807VMFqAIBca9mpLCayyp8FJiSQCFkCchfA3aFBRkdo9aZ
	Xz0/eNpnZ0XgmSeGR6FQjGzTax0sivigQUFmToV710vkKTuxZp1XgaaVRm4W2j7oAUR2qfMQg0p
	YTXh2cuaP/bQaj0r1U1+fmryqVtFQ0N2AkAcgeb1I=
X-Received: by 2002:a05:690e:488e:10b0:664:e4b2:4e66 with SMTP id 956f58d0204a3-6683bb03711mr3047763d50.7.1784576947430;
        Mon, 20 Jul 2026 12:49:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6683b8478c9sm826279d50.26.2026.07.20.12.49.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2026 12:49:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15fed5653eso11988366b.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784576946; x=1785181746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hoyrZqE1Bvx1hfQa+4u0/DLW7aA7wFVgfenpGZVSMXQ=;
        b=XDsXVmbNt7a2UamVc7fgjextEme4o+w9le6DrJroBgDFc9TKaz1N3OfPgNwshcHW55
         j3p1OBVc7T9ZvUHjf8aTyRbOPyzEeXejxc9TcB3axKlhhDVtK1kwTgeu70EcJ4dQ1pQz
         /gMWCxeyr/Drsn0EkMmJCnNZtEtttFwDNFj58=
X-Forwarded-Encrypted: i=1; AHgh+RroBiURiRnTmu8tKKvX6CaXgwVF8FtNFNRB4akWoyfTWBOYu2Tb5DLIJ7/7zqseDQ0jqr/Xoow=@vger.kernel.org
X-Received: by 2002:a17:907:3d45:b0:c16:5fc9:e832 with SMTP id a640c23a62f3a-c16b48807c8mr666146866b.50.1784576945869;
        Mon, 20 Jul 2026 12:49:05 -0700 (PDT)
X-Received: by 2002:a17:907:3d45:b0:c16:5fc9:e832 with SMTP id a640c23a62f3a-c16b48807c8mr666144866b.50.1784576945111;
        Mon, 20 Jul 2026 12:49:05 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705912972sm506543066b.14.2026.07.20.12.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:49:03 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kvalo@kernel.org,
	eddiephillips@google.com,
	franky.lin@broadcom.com,
	hante.meuleman@broadcom.com,
	wright.feng@infineon.com,
	SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH v2 1/2] wifi: brcmfmac: make release_scratchbuffers idempotent
Date: Mon, 20 Jul 2026 21:48:58 +0200
Message-ID: <20260720194900.2356442-3-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718024353.3147201-2-fanwu01@zju.edu.cn>
References: <20260718024353.3147201-1-fanwu01@zju.edu.cn> <20260718024353.3147201-2-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Sat, 18 Jul 2026, Fan Wu wrote:

> [PATCH v2 1/2] wifi: brcmfmac: make release_scratchbuffers idempotent
>
> brcmf_pcie_release_scratchbuffers() frees the shared.scratch and
> shared.ringupd DMA buffers with dma_free_coherent() but does not clear
> the pointers afterwards ...
>
>  1 file changed, 6 insertions(+), 2 deletions(-)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
