Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621067;
	b=n4/YLUzK414nVdpHiO4PN3r3/mKbFFQz+DE/Ey6Gzl7f1lFkKiUObwavJ3uhd4Dx/q5X
	 Lb5tdcRFLGTwt89eIfQ4eKTi2jEFKh6pR0zcxzm4DGb6iYUgcsJZDdzS1ePHdf0Hjm5ds
	 IjPZdx44f/qjMGrbq+POZ/k/erIC14MG0HdehVb0+8/4EiBxg8ISASHdTQgiPgvloTvoO
	 779ZmnyMYNozidA6nb6t1PzajbNMCSa4w3cpVuA0mgTgfT6vxEviEWnEs8QEtGMnvmZxn
	 gT7NvXYBoK8VgiCWAzyfYlQrO6xiyW8sF21K6yeGwgPzNIkAEgKX+gyxYnPbgPP4Aog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Sender:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 From:To:Subject:Cc:Date:In-Reply-To:References;
	bh=88Dl4t5L6yCj3fxEn5euT9WgmB3orlJaSIq1frk/2Ek=;
	b=hMfrwNWbTHOSxBz+FawEZCO9Q46BTaWMaWexfHKrqqpsqOJUvQG7wwuCfNo0dDCmkyBC
	 Jse+CpcgINdp0riJLQhMMWjty5A071wUR2nfotEkQ08R5iaFPz1vmWKFsnlt3FvCkcLyk
	 ke8Qu58cSHefHMAWkfAw/ZEtfLhYAVuCIWu7cEpUgvhoe5ljYSkrohQ13GwYRHLfgBu3H
	 2isSL1wns0ZZ01r8ERCicd/29UU/c2rwVqoeqYb4nuSNKw1o3jdb0tMc+vxmZ5XclIYMW
	 EZH9oB60SQVBcETntVynJxdk/IzGg8mi4z1cEJnsOaEzWMq0wOO4fsbncELkJ8YhkJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="kF/zcEji";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F9606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C77F9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kF/zcEji
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4be28b82so3061364f8f.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 04:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793621065; x=1794225865; darn=vger.kernel.org;
        h=references:in-reply-to:date:cc:subject:to:from
         :content-transfer-encoding:mime-version:content-type:sender
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=88Dl4t5L6yCj3fxEn5euT9WgmB3orlJaSIq1frk/2Ek=;
        b=kF/zcEjiXU0bl6M+mG5q3Guxol9SiRnCzjKGlPF5/EMhrEKtCpGYJy3DDLwqP6U0D4
         M0JTm9LBC+8O91qSbYzYkwIRhdiI5U+dJ2WzUo/oCWRoB4DEVYFvuVHuTojtV1+6WYCa
         5cLSbCASfhse4FF/wuBuW502RmBfY1VY05aDMLV2F5T4Dt+UUWLBpIECGb/yUiXZV7E9
         y0eA+ZoBSuP4SzQhTksf4qHfi+9Bw058vXliyOGoebupWrHwxFW3w37cNwk0hksLOHzH
         gjMaP6Dc8PcEJ9Y3dJkcm1HBt6fy6YF7zPvpggAw93vF7k/uxJUYMFmeQ68MV5HHWPVN
         uXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621065; x=1794225865;
        h=references:in-reply-to:date:cc:subject:to:from
         :content-transfer-encoding:mime-version:content-type:sender
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88Dl4t5L6yCj3fxEn5euT9WgmB3orlJaSIq1frk/2Ek=;
        b=FSQ9Zdf/yjB20QbdsVCaxXz9naNJWaIKo4X9e3Dt/htIVpS4zP8c+BrXNnkQuIKQ4b
         4GX0RgUSJK3ktMuERh8HT11HGnyPqqUz6kYmSv306cGbF9yyXVIIVFOQbuvpzAniPpD9
         BwA35ZFAfc2JjBsGJGh9jTT8StuLhXjT+78sVBcgwBHx3mn00hV2RkB8qMFifAFDCm6Y
         agzEXhVsvowBKGnPFg8UGtFuvlVSMxc+lRnPpVAPDvrV20T0Y1sf75dTCxD3twI65Ot2
         sey6eL3V1NCqK0joWWysWBpLZgJAcfAV5qeIOberC+DX30/ciIMchMZR+nlNoEfYxPd2
         nelg==
X-Forwarded-Encrypted: i=1; AKwUvByzK/VKMi+aByS2IqvoERllWKWvRaFk/T9xmJEPDtUIUwVbctR0E5j7au8NZAajvh04xTMRsiI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9PZ/z6bKQsinMHvMrnaRY2Ss6L/2ucg8+IMKGc4ug8SDNdUq1
	yIa+J17Geis+rZ5atQo9I8sl0bSr56MaeiziXUQUXtqt0dEzSuDUFjM0
X-Gm-Gg: AYBFou3U4Mcba9InYhjoiXCY6zUI1IZaiUi5Tx1bdwZQx42uRQlW/0RbGrZC8Glv9K7
	wJdHRNBDRy0vSRAk7ceAXTWnOPibX6HBbUIhmXE/y9L6dNuE9SZdDLJjoa+BXrfn7R29vYs0ZrK
	8x6QF4qejyrTaqY86wj+AHpJ93DTjmziZ3JBdG5p8YLoa4OcKGTSQWJjBkJKNoS5TQ6pkoIQTs0
	GIEktHQC/KuQCPlI0M003qPPTePcvNPsCS4XI+xYzrGDBcES8aoRi/E6WzLopAp/frA+BbMUiZT
	hNLd0wHKD0xQKVnHthcPGSXt+T000y44Dt5U4dShcSjQ9qcF7o+obGQ51cDRnbxHkIq2Wmb+yq3
	Jcliu72b0S7Jic430Ict16Bbcrx7gNSbNJB7jpttE9Rwj1ITGe6MjCpiNK8UtnHpquwhxQ6W1yy
	V1kKEenoIFcD4TibwE0QEWfNyzaW9xUBRBbXMHWDQZnA4xf3yj3HaYYVkULgsGwM7zu9rtZucs8
	kqAfGE6F6voVuzrSZVB3WbY3elQrdPLCrRFtrH4cs/RBRU0Qeo1wsd2r+z/zpnp5h+2jvCy30HL
	cRyMHqp88ksVJMIAYSz8bt84G4n7k35832BIk8ikB4O263wnoy3EGEjevSI9v9qWYiUDnH2HM/G
	LVd6fjr+oSgPuiiVd20vSbeZGYLEk6pBaJKBt/XzcgF+o45UEzqG/hE9ylwMO6Ksnl2CFMzDMID
	88GQYXgpBCDcQWrR4YSS+5BdKvFLutcNFWuKFmZpb/JudlqyQ=
X-Received: by 2002:a05:6000:2387:b0:48e:20f9:8d75 with SMTP id ffacd0b85a97d-48e6e50b79cmr22620613f8f.48.1793621064763;
        Mon, 02 Nov 2026 04:04:24 -0800 (PST)
Received: from [127.0.1.1] (88-170-213-78.subs.proxad.net. [88.170.213.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d425sm20184761f8f.1.2026.11.02.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:04:24 -0800 (PST)
Message-ID: <6ae87c48.eabad26b.28ae48.d5ab@mx.google.com>
Sender: Tristan Madani <tristan.madani@gmail.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Tristan Madani <tristmd@gmail.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v4 4/4] ASoC: wm8994: drain delayed works on remove and probe error
Cc: Mark Brown <broonie@kernel.org>,Oder Chiou <oder_chiou@realtek.com>,Liam Girdwood <lgirdwood@gmail.com>,Jaroslav Kysela <perex@perex.cz>,Takashi Iwai <tiwai@suse.com>,Bard Liao <bardliao@realtek.com>,Misael Lopez Cruz <misael.lopez@ti.com>,patches@opensource.cirrus.com,linux-sound@vger.kernel.org,stable@vger.kernel.org
Date: Mon, 02 Nov 2026 13:04:24 +0100
In-Reply-To: <auhdJGbYnY95tJBS@opensource.cirrus.com>
References: <20261030170416.1839402-5-tristmd@gmail.com> <auhdJGbYnY95tJBS@opensource.cirrus.com>

On Mon, 2 Nov 2026 at 09:51:32 +0000, Charles Keepax wrote:
> Both paths appears to cancel the mic_work twice?

Yes, intentional.  wm1811_mic_work() can re-arm jackdet_bootstrap
through the DAPM power-up chain (force-enabling MICBIAS2 triggers
clk_sys_event which queues jackdet_bootstrap), and
wm1811_jackdet_bootstrap() ultimately queues mic_work back.

So the sequence is:

  1. cancel mic_work           -- drain whatever is pending
  2. cancel jackdet_bootstrap  -- drain; if its handler was in flight
                                  during (1) it may have re-queued
                                  mic_work
  3. cancel mic_work           -- catch that re-arm

Without the second mic_work cancel, a jackdet_bootstrap handler
running concurrently with step 1 can slip a mic_work re-queue in
between steps 1 and 2, and that work fires after resources are freed.

Thanks,
Tristan
