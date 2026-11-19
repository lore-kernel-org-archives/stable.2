Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059638;
	b=tEYPUUKSt58aIt/S8vrXMVTRv3XLSodVmPBydECvuIZSl7W4NXZP0vNbX1ZynFoQO0BQ
	 ylvu+Imk0MtxG7rDkc7h136nzYoU7w6GNZqQ0Yhy7kNNz3GwW4/H2tfCEm0Mm7M+5BZTx
	 ZMtUhWC6qJtEAzFqUOtd6eZSmE2+jiSLdCZlhtXsr2FIOWAOPHjvh/R19UMkU/LqGrK7m
	 pvSkAyKp99XTc8Fwvm8awTalt6fUJ+NSnPL8wR2qr/2VlrD6PaDZPlksyH3yuBelZpMV+
	 BQeIFeOXTisgEbV2mDwCY0wdgXU2+PUDA0hPpyUNr60hT453knS8qT+TqwLQWBmWV8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=c+7vBVE35eU7OvcQRlXaK7erubNGtvgQAaBs8IXCypg=;
	b=Z3ANUaRCflIQqGj2yrd5PajQMaQui92mj5lprG3h3EmsEi3vgX1NshQtzRPTsqOy8nJ7
	 Z5illabnuUAUa2YqgnspBw9FozOz5hy59wto5iGkQZvZdMpOOT8wvFQ1p5LIQqvfxhE1i
	 DWa93jATYyUOhCS2Vp/fugqeeH5VAz88UnHbiYkUXn41GOg/IxxJlYI+icYRnyFuttG4v
	 fAJyHVD3PxVmPfGckKGFUW1WMUT2F/hBFrAaO8QRpKrUSfVtpWgCRNb2PbneOQH2HD8RY
	 LQ8tv3lyo8d34nwYkyyWMem9F09FcUuuM2Dc34+t3amdjy2BPm3Zh0wr/cG5FTb0EPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P9nAT9wR;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1F60A3812
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91A1F60A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P9nAT9wR
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e95bd1c14cso14837165ad.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059638; x=1795664438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c+7vBVE35eU7OvcQRlXaK7erubNGtvgQAaBs8IXCypg=;
        b=P9nAT9wR/BxrSHFD0rc86O6tPp9oJPwSNHtCDIP49VsyeibeusvaAfn48WqF/RglWj
         H3JMuEh0bFpaHNQAml1uewIK/XABMlPBWHyxyXg9wgEzu/ASbM7aG7mA6hlR4RIMYA63
         x68LfDa1iXT/0CFIP7V6TsEz6Cg6ahqT5XXBrjPNwrEC8XyY3+DfmxpxU29GgAyt3uhI
         iYqMUEutqpOeXhPsGce0xTkE/CS/SPk8rHPfrJ6V84plqOIiHqfYNyG3nvfZM0YMQise
         Xzo7GobJsXAtaHNTQmnGz7R6L6G/avbpQTKAJ5YM1Ix/X4aL0G47Bl622024nWwBZFrx
         qZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059638; x=1795664438;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+7vBVE35eU7OvcQRlXaK7erubNGtvgQAaBs8IXCypg=;
        b=XAehoFBr3HIQtnaapZNpqf40rzoKGIXgvcr6Bgm7LqlJ13Hq7yKVsk6GpLpzWRWyjI
         jANxIrwMm4ce5/cgI8VYFbczpOfBngqsv33XKnzW5Mm7K7PHA4WbCk+l73lTqLW3rAZ2
         qjMcos0MOWf7nbtdyBngTTn5sgSYE0uRCan5XMgjmwHtitC7OcFONMErq9CZ6hBtPDaC
         x5R5TB3573gjYwGlvtf6D3irQkRR/Ofl42T0g1OwY2emp4RHmeYuwDv6hmVJnfh0/bls
         t1npm4wQNoWNzZ332IvB9zTyWrtsZYOypoFQcNNL8079Gj1omGmKSSw4TCY/Q/Wj2gN0
         CoOw==
X-Forwarded-Encrypted: i=1; AL+hErHfhRoP6Z7SfbA/UUAAkzl5l6vg/j1tTG1MLuqm1tLFZAYW6hUQ78jDZ/LpiNxFz1n7CPE11Y0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4LnQrTsd0u3cRzpTzVszEBRjekH7mM4aYkYtSj3SU8V0QCpuR
	/LbxcY01mBecwwHLRK2F+yFJ+c2Tpn/vkkQb4tMXuvXgcHoG4LsnWD6X
X-Gm-Gg: AZFdTZf8Xbs+fVbG2P0YBduaq3DC4b5cRItJIKrfrZ2zP7Eu/655Uadf96d44w8YPGe
	9hGV0jhwza4H0+To7ghEwOGL3ClPos7kshHsuFe6yqqoSP822Jbik/GrGStksHBokqKF6MoBTHs
	Yn+/cIMp2VquGXWAFd7SMYerFU6Lno+1cQgtU1ERgQFs0aCVDwJ6pCiBnQ04sqjsqZhyX7+SyzC
	NXpttwaB8wjSAMrybp8CeUvVIojdZnjGHX0iSGZdGfYV3aFerLAGfCbpcfTYgDkEBW5EmPryaJs
	VyY1pZl0uelypma4WeeJAyyQCGhWwew4RkKk+R4QOaXHR1vD7zRXxfQZOhErvqPDqzWl2F1pgSH
	peM0nRb4clWwsUpxG9p/5nOiV7eyCEXGA284/QG2J15wXnnPIHF+ZXhQzlQp+nk8yg64ykNK0YF
	w7eBFx7Kv/ZPO/FR2hmmd1CcUayg9kazghHnhDXquNKdhk3//NLPtJ99V7HOZsW6Vw0Ye5nAE3O
	zTyANkMuImdUgYRgehO9QK3r5+7rmzIA0tITikzqkzUTW6Z/OC7ljbaWsTOEoIKHHLIYtLnIAA+
	XEK6KFYy01qk4N7R
X-Received: by 2002:a17:903:18b:b0:2ed:130f:869d with SMTP id d9443c01a7336-2eff753bb92mr47715105ad.43.1795059637889;
        Wed, 18 Nov 2026 19:40:37 -0800 (PST)
Received: from x1.hs.local ([2601:600:a482:7d70::5e59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62897d0sm22109355ad.64.2026.11.18.19.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:37 -0800 (PST)
From: David Westen <davidlwesten@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	m.chetan.kumar@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mail@maciej.szmigiero.name,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: wwan: iosm: fix S3 resume by re-binding the driver around it
Date: Wed, 18 Nov 2026 19:40:23 -0800
Message-ID: <20261119034025.480656-1-davidlwesten@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <179501477167.3136.5713040375169842773@kernel.org>
References: <179501477167.3136.5713040375169842773@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> - [Medium] pm_notify() in drivers/net/wwan/iosm/iosm_ipc_pcie.c decides
>   whether to unbind the driver on PM_SUSPEND_PREPARE by checking…
> - [Medium] The changelog limits the problem to "platforms where S3 cuts
>   power to the WWAN card".
>
> Pre-existing issues:
> - [High] ipc_imem_cleanup()
>   (drivers/net/wwan/iosm/iosm_ipc_imem.c:1231-1266) cancels…

Thanks for the review, these were good points. I tried the suggestions
and will send a v2; details below.

> Could this be gated on ipc_pcie->d3l2_support or a platform check? And
> since the patch is tagged Cc: stable, could the changelog mention this
> change in behaviour?

I looked at gating on d3l2_support first, but it doesn't match the
power behavior here: the X1 Carbon 6th gen reports D0L12 and the modem
still loses power in S3.

So I tried checking the hardware instead: on resume, read the exec
stage before touching the modem, and only re-bind the driver from
PM_POST_SUSPEND if it no longer reads RUN. That covered every sleep
state and left platforms that keep the modem powered alone, and it
worked in most runs. The catch is that the re-bind then tears down a
modem that has already booted again. When a port was still open at
that point, port close sent PIPE_CLOSE messages to the new firmware,
they timed out, and the modem crashed:

  iosm 0000:03:00.0: modem lost power while suspended (stage 0xfeedb007), probing it again
  iosm 0000:03:00.0: msg timeout
  iosm 0000:03:00.0: msg timeout
  (exec stage now 0xbadc0ded, the probe then fails)

Making the teardown safe against that would mean changing every path
that talks to the modem during removal, which seemed like a lot of
change for a stable fix. Unbinding before S3 tears the driver down
while the modem still answers and has worked reliably, so v2 keeps it.
The trade-off is that on platforms that keep the slot powered in S3,
the modem is probed again on resume, which drops data sessions and
recreates the ports. As you suggested, the changelog will spell that
out.

If you'd rather see the resume-time check, I'm happy to work on that
instead.

> Can pm_suspend_default_s2idle() tell S3 apart from s2idle here? It only
> reports which state the "mem" label maps to:

Good catch, it's the default mode, not the target state. The target
isn't known yet when PM_SUSPEND_PREPARE is sent, and
pm_suspend_via_firmware() is only set later, in platform_suspend_begin(),
so I didn't find a better signal for the notifier. In the cases you
list the patch either probes the modem again when it didn't need to, or
behaves as before. I'll describe those limits in the changelog and
correct the suspend-to-idle sentence.

> Should ipc_imem_cleanup() call hrtimer_cancel(&ipc_imem->adb_timer) along
> with the other timers before this path runs on every S3?

Yes, thanks for spotting it. v2 adds a patch for that ahead of this
one. I could only build-test it, since the XMM7360 doesn't use UL
aggregation.

pw-bot: cr
