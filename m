Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422617;
	b=0Ax9X1FAbEwTxYSr2qZmc2H2rGmnieyBPANboY1gQpq3foPd44NrQ22YR7UQ6sQKG2QE
	 5Tw9o66QqIjkix4LONONpKgb1VdLVcjsuKMF+wiL1GrQQTgAQG8j3MxGDZZtMUTQM/KD9
	 Excr0SWKKPzRtynPriPhGtUqMu6wSJ/gGTF0m83KOYFYmjLpdKtWfU1/qzIR8/i/vTuLq
	 9wca74FwFdgy+GHQDK7x5kJZ3wpBXnlvqDqfMLGnPNwM4rXtmCSeFT7gDqb1tmF9MVEAd
	 6hiv9enInl3Ltnm8UGQs0wU80IFGhd81zDrQKS04/W96do0ZyOzBOtKS8DtZ59b+0dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=HF0ZaQFZtpES7I3ketM+dRHHQj/moZ8rhgorfDfzl0M=;
	b=SdTkjVejui0yCi3heMJEC+Bm+mJeDiKfH87K3xyfA4mD/fA0/lzZOmOeGvXz9kx2hq7u
	 h9EdtDSf3+wKwF3h1BFxs54Q5LtGXZlPzIkM4jQE7CHxbYyuR5KaveBxRi9zYmVVRDJLl
	 VYxklOOdLrYpBZMp56nLG3t/zIXc7N/KM9xgqNZfQE9Dg3BZ/XiZRJ0hzTM9cJqqDlqt5
	 IXF+cZ7Q2yPwByeFcZ53h1f/K1FYi+tNhuVFEOuj+1uAdFAaFyj8yVL7wSjG9Xga6Zz8g
	 zHyKkI8gEqGUhBD4jRDLpGyrxNMIVKzMBnkcvxL/8YpLxbexaofWFF/LRxLg9cbzjug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VknPuHZe;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AC606A336
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 000AC606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VknPuHZe
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f0414c1062so15686535ad.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795422616; x=1796027416; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HF0ZaQFZtpES7I3ketM+dRHHQj/moZ8rhgorfDfzl0M=;
        b=VknPuHZeBan9vuXv4QoNpnRq12ONg1CjthfuSnY/LaF/GKDSUEkAtbpucunqBxlrKg
         HvBQJvJjkQtl26WUyvC/HmkROnpBsHSyRt5y7XZM8NYNxbF9pxsIHTN2JAoYzsidzXTX
         TfAhg5woEmBVSZ0PO+BIAGOvohMOlo9BJAnPr7BjUzyWRb7dmNorvfkNC58cGG697G5u
         MdhCbhO1Yz8GsLQ26CIoWhlKga3cqjevvJOgntVzNFd/wWhH4vihEU/ruAXVS1WKxUrq
         9kME4c7E3g6/U3lrqxt3DGHnshmtFKj05lAPJ6Mki3gD/Ho1QJIo11Iwb212DuytIeFI
         YiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795422616; x=1796027416;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HF0ZaQFZtpES7I3ketM+dRHHQj/moZ8rhgorfDfzl0M=;
        b=OlTNoJKszq5L768M8RWL+8x8wz1tSWyPCiwNjLPtQZR6W7ZTs1LpP29kcA0txPuTS4
         T+TyaOlgmf67QgkWPcKTKCB2A1c/7sgvkO9GDs+PdqwKgPqSaB7WVsG2jlSUr1hloYTJ
         b3SX1ey/D89XkMQIaIwAtLH+ea0DaHjgsTf3lr1QbximO6oE6PyfWuiS8+wG4cBrWjnN
         8YWiBbxr7tyFq0Gkl5zcxgV9DN7hOWJRjTNisvAcjZs06v80vTGBQWfj2XZG6or7xeBg
         56wcHWhNVjw1bUVkzaGDajsf34fvQDo9sZME5E84NQ8k6ytxwWG4l8bO5vIzmNZLpz1R
         otXA==
X-Forwarded-Encrypted: i=1; AL+hErGU7mj8AR11s7BpLVoGGSwPmOY1IKVKWqaBiWzb8/S6vqR2ETt7NVMnVAadO0DKNuLEhKVY4GQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HbH7ZVh39IpzSmhDbrdbhYR4Zklu415zTsrz4Awo1A6djJgYW
	6VFFs0gBXdG2hEx/vzdMlEgF5mrlDnljXmHybrNUxwIHFaS5BggS/pdVNSqDp294
X-Gm-Gg: AZFdTZfulvJ1oZwWSmy6Yw85X2hs4eF7WeOGThExNGCAxj7/S2y5w3S6Hy5h50m0T4Y
	GonoI2v9RSjg6s0soy8m4Rh9JkJPJw0seP3t8mRZDdNMxHHKCOzhHWhvF9EkLoltBTDn/eXdgfO
	WTy32+wDJa5ImREcyoszEasgQHnh+s6djnY3FVtHReKg+KfdxCfGBs4jUnoY6ShW1IwI3Rs7fMA
	XrBTL8tTe2ZMMCDTcbB9rY9wl01q4e+BQtha7vMrboM+qlKpU65qofAE+YdIxwfbHZT7ySbQe1e
	uz5gJNqGfx1qJc+ayB9dqe5j6M7KV/Gli89a9Lcghd43FrXuxoOcABmEJ5clYXXP1Jl+pdOFmZm
	yNQGL6KMbf7AsYr6cr+L848idn+qpCXOegXxk+Vf3E/fE1rNCm4KH3UGXdaLv+iLfbFZVfjowfm
	rt+nF7I3hhY9ribNscwtJjqn2qw84G3CqwU3FGBSIA178y/1Kaw6wLrsn2aJvZvJMBKHXZg25b/
	xWjBKgDneu7WoUN8/arUxvC4UK5gnetdTYLijixmCxsD25vUsv/4nlCBNWXmjMqIaRZyN5e0IWv
	7qbD2rt1Ys5qz1jQSgsUsNHSfJDPS+IXx+ctWcV03Je/WrN6x9M7pTgHJ0P/
X-Received: by 2002:a17:902:f544:b0:2f0:8fee:c878 with SMTP id d9443c01a7336-2f08feec93bmr28221845ad.8.1795422616276;
        Mon, 23 Nov 2026 00:30:16 -0800 (PST)
Received: from localhost (211-23-53-87.hinet-ip.hinet.net. [211.23.53.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f08164dacbsm19643025ad.68.2026.11.23.00.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:30:15 -0800 (PST)
From: Yu-Hsiang Tseng <asas1asas200@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Cristian-Marian Fotache <cristianmarianfotache@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, perex@perex.cz, linux-sound@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] ALSA: hda/realtek: Higole F9B fixup breaks speakers
 on unrelated Apollo Lake laptop (10ec:111e)
Date: Mon, 23 Nov 2026 16:30:13 +0800
Message-ID: <179542261324.542908.13953751300676446171@gmail.com>
In-Reply-To: <87pkvx5625.wl-tiwai@suse.de>
References:
 <CACGjpbf73XdwrG34ffjmYU3ZYuStPpFNXf9w+AGYcTmLyHCN_w@mail.gmail.com>
 <87cxrx70qe.wl-tiwai@suse.de> <87pkvx5625.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, 22 Nov 2026 14:50:10 +0100, Takashi Iwai wrote:
> > Yu-Hsiang, could you check whether the quirk can be replaced with
> > HDA_QUIRK_ENTRY() with the codec ID instead?
>
> Correction: here I meant "codec SSID", of course.

Sorry for the breakage. The codec SSID doesn't help, unfortunately:
it is 0x10ec111e on both machines. Cristian's codec dumps show
"Subsystem Id: 0x10ec111e", the same as on the F9B, so an
HDA_CODEC_QUIRK() entry would still match his laptop.

Please go ahead with the revert.

The commit is in 7.3 and was backported to 6.1.y, 6.6.y, 6.12.y,
6.18.y and 7.2.y, so the revert will need Cc: stable.

For the record, this is how the fixup silences his speakers. His BIOS
declares two internal speaker pins, 0x1a and 0x14, besides the
headphone on 0x15. Without the fixup, the headphone gets DAC 0x02 and
both speaker pins get DAC 0x03. With it, 0x14 can only use mixer 0x0c,
so it shares DAC 0x02 with the headphone. That DAC holds "Headphone
Playback Volume", and PipeWire turns it all the way down while the
speaker is the active output.

Also, pin 0x14 on his laptop follows its connection select, which is
not what I saw on the F9B. I'll re-check the F9B before proposing a
narrower match, and I'll Cc Cristian so he can test it.

Cristian, thanks for the report and the dumps.

Thanks,
Yu-Hsiang
