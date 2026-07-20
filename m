Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4083214A619
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576951; cv=none; b=Wt3ucvWFal7RBDK46YSESgnEtRhtnb7WMu93/3zZmkAnogxClr2Tv7iPFVXQYrc9UKCp4S5i0Al6nELYOryAcolONF5j6Ref/4iQErHzIm+K0/IIGfBPzwSCbQSd1gw55i32NtIcswarEbxIkdsu1+AwJGR6EFtJPKUiYwASMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576951; c=relaxed/simple;
	bh=UgS0ACQKghCRnTSqEpsCpdjau8U0WER+rFa94nA8F50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDLl1eJZ0vBT7l9p+5FujhbZtwFAsFaiZ4N5+n7Mys1ezyir7FB1GIPitJlipHqUGMrjOQViRpOS8+DwlJNgwFdNPvfMbAnRqfFXFOo5WvEa49iA9hcrhj3xB4XT+OFLa3hPyyWbHmotSfdNPDccrHOKW2gWG0n5plmTw75ifZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PK6M1HqP; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PK6M1HqP"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2cace91f112so107566685ad.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576950; x=1785181750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myc/a7EGXCgUkCQNczBsGQYFLn7a2lftGxxjNjjCIDA=;
        b=APdLv57x6wuRRYPet8r2gMwevDB1FAVFwiaFTaXULUhTm/0USfckPpzHg9crOc0udn
         YZTdq0lE0DKWPldns59C0drHVIoi+MS4PUcSA3oP5v3C9e6TxzsGEToTh9jPSingU/Is
         9aAStOV7KhYbxOdCwwMnCRuoxuV0C4hXU+7EbUG5lUfUD1rdPZl1h7RX6pUXWcRR0kAq
         UmAcKriotafthWtH6d4r2HF1RZVAaWfs0nRoQGBaPe/wlMaKtqysWXURH+O/twkuShOp
         IYt3j+hWxw2csEHoGkAk+Df8nL5TJhCRHfDNFPNzkgx39HTDkNUUxN0WAGf98JqHAwTr
         esIg==
X-Forwarded-Encrypted: i=1; AHgh+RoxlueksbCa7efgvtxsREBPxv+TNB9w4jw+KuW+nITvuoQ4AfCeshSOFoTChqPaskDCqnRQHh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8xqeO1nIukcrimeaVH1acdiZt5mSf8A1JMu16kZz5X4iQ8cA
	xBA0gNr/rHTY2OhqE/enUpDTs8OE+n6+PZmiWUIND/VEA18pTmaJ0yO8fRvQ2MnSWvFCBy3n0WK
	SiDcAU8Ntl4ID2mb+82dchd1zKdDO3OImeo0WtpAxy8+mvesmcqnfrvESIXTBYvq6QoSIAtt2is
	I1P5TR4nBGMbfoczYqSTvOB+VUa+Lpui/Oh2j1OChlLD7P9hZSuSJI04T9SRt1muYd2bwUqg1Hp
	ymfiJ0tJ8V6uYnbxQ==
X-Gm-Gg: AR+sD13VN7Zpz7Vr2jNBhc1HRsK6luoax3U/9MFezeTzL5g2fXlMVAuTpKgYiNhoLrx
	1ADufeTv7Re24hTx8gh4bifXv3PHgqwWHErFA1XzdcQZZHW0GJHy3sTFCQWFyvloQXDbHLMKK/W
	NhM0aHb+du2WMW2xQhR6kfBZtKgtnbuzyUkUbNf72FlSQ5ESIieQk+/JoSTsVD7q2uuLDYL8/mL
	xOBFcElMSAPjV0PTRoTYoQc9fd1J3cQdPo0nyshjqdK+qXlGby7FgGERx48QocZSLZDNiwwgb6n
	hnNAGapmdbVfXex6hHMMP/UNzDNrGFW+jXBu/bekJTBRc050vDqfh9hiUzLxLiQ1iZHyyi+HKXI
	m13w1dg7WqmbvYM7DMMAD8lx421+0uvEih4cmkk/961ukc3K4923K5MN0Oa06FzEYpDMQIHspox
	xZlChrQ9eVLlxiW5FF6SpaUvUp4exnjGW357KDleU=
X-Received: by 2002:a17:903:3c44:b0:2ca:ed41:d331 with SMTP id d9443c01a7336-2cf34a3f5c3mr168888245ad.45.1784576949401;
        Mon, 20 Jul 2026 12:49:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2cf3446832dsm9721295ad.7.2026.07.20.12.49.08
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2026 12:49:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15f0aea084so767166766b.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784576947; x=1785181747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=myc/a7EGXCgUkCQNczBsGQYFLn7a2lftGxxjNjjCIDA=;
        b=PK6M1HqPeTX6W9nkHkHeOWH534CdhBwXK9Bv5JEeRDP9VYxVM9RWer2wMIPfPNvmN3
         NsskOjDwI7qQjSxFl0WiUK0zfGEI9D8qxreQID0VgP0V7uj3FQZdnhT+zuirTECOx7nT
         BguQ7kXwOQBN0Q6XyFLRt0jlzIpfJrN04bT7s=
X-Forwarded-Encrypted: i=1; AHgh+RocXUVg/PnPyUFfpTzdiLMMfS2S+p6qPOVyKhknNWaPbrBU3ikALSYzPh2jaVDBYEAs24//Hxk=@vger.kernel.org
X-Received: by 2002:a17:907:783:b0:c1b:1315:163e with SMTP id a640c23a62f3a-c1b13151cb9mr21284366b.29.1784576947355;
        Mon, 20 Jul 2026 12:49:07 -0700 (PDT)
X-Received: by 2002:a17:907:783:b0:c1b:1315:163e with SMTP id a640c23a62f3a-c1b13151cb9mr21281366b.29.1784576946853;
        Mon, 20 Jul 2026 12:49:06 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705912972sm506543066b.14.2026.07.20.12.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:49:05 -0700 (PDT)
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
Subject: Re: [PATCH v2 2/2] wifi: brcmfmac: drain bus_reset work on device removal
Date: Mon, 20 Jul 2026 21:48:59 +0200
Message-ID: <20260720194900.2356442-4-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718024353.3147201-3-fanwu01@zju.edu.cn>
References: <20260718024353.3147201-1-fanwu01@zju.edu.cn> <20260718024353.3147201-3-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Sat, 18 Jul 2026, Fan Wu wrote:

> [PATCH v2 2/2] wifi: brcmfmac: drain bus_reset work on device removal
>
> brcmf_fw_crashed() and the debugfs "reset" entry both schedule
> drvr->bus_reset, whose callback recovers drvr through container_of()
> and dereferences it.  The removal path frees drvr (brcmf_free ->
> wiphy_free) without draining the work ...
>
>  7 files changed, 77 insertions(+), 4 deletions(-)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
