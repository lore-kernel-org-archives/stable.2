Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793966474;
	b=G7pz1ruPCvWQWJ9Xr85EM32ReeT7G1mg07L/l0IYCiXPp31/IpGwQ8CA4zk12mcBZ/zk
	 RywNFK6/J9sq6DRWknmdrac0eRdiV5X84UGARXsNByngu6X5MYpvmjI/NHMo6++SUbVsx
	 P/rX5ONxc1UZf69a2rVIhIWjqNiLLMNjQIUteJoK+Ze+gvbyqYJuoPWQtTHK1IUx2Oh4t
	 B0y0zUUSyDjAEufcgu79AgOZz+xnD29vLH4tjR87NudTFZ/ZijdRD2DmYssWDFSmLRc2V
	 kMYBSu8XcbM2II3Udxk1Ewdk8TfGFO9MJcUignmh0o7G3m13ujU8JMFeMPa4RA+PnPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=7Atkv8Av9+Ao+eHQuMY+XWjPUUdTG2IMTe5rVcJzpas=;
	b=EU/e7NbRghuBKjF8QqRmK9Kx12SPe7BpajWHcQV02P9eeAkqL6QL5W+oGuHMm4cemmFG
	 s7BPZ2xnMqBah/jEIVJFxK/cUbtxrBWx/2/SbEVwUS8H2/lJ16IaOxyyP0bvmTinU7Oq7
	 hZ9G4fwTyDB+95FHAoVY0s2aa2AioaBsIT5iOS9U/OG9Y4SzTXSoQ/bgyj+9MgPrVu+8B
	 HPkbuquYSbiXWGWr62GMWYtNY8W0Vz1zw7SR13hEOfqNkI+yOd3V9P6XsDICXhAAsc78u
	 FLLHn38F/wmIjG54zN/Onnn4nz8x7Q6Rtn7SNDeq4qRosnKLsmNwlGEAZqVaVIIhDsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=janfabian.cz;
	spf=none smtp.mailfrom=janfabian.cz;
	dkim=pass header.d=janfabian-cz.20260707.gappssmtp.com header.i=@janfabian-cz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m9WyR+EH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CAF606A33A
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30CAF606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=janfabian.cz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=janfabian.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=janfabian-cz.20260707.gappssmtp.com header.i=@janfabian-cz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m9WyR+EH
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9441591aa5cso209206485a.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 04:01:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793966473; cv=none;
        d=google.com; s=arc-20260327;
        b=RhMiNZ6SGKztkbztoUBW0dPWwmp1mE1BtLWbrG/6YKUjl0MKv8pAY3697VTj9Tq5GC
         7OnfvBOfNAgE/EDppO/Ga2rXs8ZTzjqWwd+oqMgWA4+XptMECqiCcApqM5xTC212eCqZ
         fx73bgpRpH2l3KAN6S3H6+2YuSF8Usg0o5Y9LMlja3AMbSmuzYQys2CYiz+4IR11zHQG
         d+ROQocOOS10JNEMzckB22OynBMCqy5+VHNCk0BI0kOyRlqxk02p2j4/bnPWHGvG2UNs
         bk7mNHRpxQiErlRoZJPv7VQ6RF/ejym4P/UocNm1c5LVFpsTl6jskm8DukzgtnTmUPGU
         /VYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7Atkv8Av9+Ao+eHQuMY+XWjPUUdTG2IMTe5rVcJzpas=;
        fh=aOQjPGjSMmBOfjzZUVNliYWm4pI/dUuUoe20DNcB7UU=;
        b=D4PwBPN/E54I+nhvnriwbItW2rX/GpvXzLi+p6eBrxKZ5OYqAkOUqQVfieqofENGd7
         r8wqW97H89+ZyAQQf4tlCOiN/V4RPPLUSf1z2nwSV8J6SoEdACUysITsgHCdPnliZkiX
         n1UlUd/yXTAaPsPwBfBu9/It6KR0O0VVBXl7BAa+wMkJD9P7wSQAf1sP2NPWS0LUApSO
         MIfa0x1brgGjFD1e4/I1MNKcIr1EWr/Ao3a4GetqjDNIWACQ/u/RxEW+8D+fAfQGlnz/
         g56lRQs3svKGCYq2bhSx49hm2nXW3ZWVHlBgEZec1dM9nK0/m9lXpv/W/lmuCK+NIKjf
         UBgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=janfabian-cz.20260707.gappssmtp.com; s=20260707; t=1793966473; x=1794571273; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Atkv8Av9+Ao+eHQuMY+XWjPUUdTG2IMTe5rVcJzpas=;
        b=m9WyR+EHYRDo2JoRU0miwDWW4tloiONj6mV5//vpPrT13wUC2RC07ROw+sj0IXP/kZ
         gWf70A8DRbiIQgR/LedqAaAD47/bn6N88fwuARqVz1U0dy29akqg9a/IMvPuvo+Wr7hs
         7VWaEpODH6rzz7ycrPVG7h62avoXiUDejWV4L+uc2LA1BRgoTxmcvChcxGDoIJdaVLNA
         wIJiXevH9Q9dpwJsQ5h6quAobXG+KKWQUSbVPtCgOucYZpUdT5vV7Uxaaw2/SCIgSu1f
         u4/tNWB13GzmBY7MUy/Fp2/Q0iI5YQkJvBogtjjrM7i7FK/6UbIlXVBB2OAwwvt7nABT
         yKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793966473; x=1794571273;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7Atkv8Av9+Ao+eHQuMY+XWjPUUdTG2IMTe5rVcJzpas=;
        b=uUaMsXdxEBkMnEkMYYF5g8GFsrAweldfGl8kcEwgEeXixFLn8LX+qF7RMPAKfNU38W
         bQSFy9Xi4gwAgS4JVD29GnwDJx5LR3YnDurHr54iD4cfblTmNgbUnrBXWQonYGgMh500
         Tnrpn5IsH0huRvVg4kT2Bc1p3bFikpB+VX0g43oWbm4lbbCdquLe4SA0tLic/PTuQGdX
         TrVQr8ssGVN/CHxcjS5MnkQItDFLV15hwnPGgmvOh0j0TxDW4dJBZDuTKYbP1PJtytNM
         mq3d5sMdi2kH9FrTYAlN+0KvWdyUiNDqbQ3YpeNQjV+0IfX/aR+TEtMuqpCu5FrooBRl
         f+dA==
X-Forwarded-Encrypted: i=1; AKwUvBzfw38nRTau8jzq198bpLQuyeM8D28TIRBe1N+Ccl9XQUh+AeXPi4BtI8grB+j2RbD16k9hq0M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bKJkAW6rgEPxIF5vUCWajo3V+XsU2B5kYMd8GNLNgK6e9WNSK
	rhxKte2XH2BVMI9EcQn8wS5ld3m7igNXQqYM+qkLPXB+kfIJCajcjtg/PITfMP1ylIG/sFkHow8
	5v7yuH5Ra1X9+73EVCB5gjsRP1X1f4KwVouWMJlq/2Q==
X-Gm-Gg: AYBFou15A2K5xYtIfvfo7l9cScGe4jn77w8T0YU9H9GfVYyhAmVGpnTNybzD8jeCtcX
	O3FdP50mTlb9+wBl/rAI0Vyq9vgl0NB87m7c5QzJ5NAcFy5JwS6lJ/0StkEX/C5B+GPfjuoFvUR
	QNYXN0N3ixJRUiJd1gBsrwZu4FZKTeZkWuwoJhgmvs8qAdziumvX3KvjHQodUNrnh4l9urDJfJj
	NWZcOJYkUx8VFJeRkBruAGTAZAzuC+lFCaVxbezHIgwgBlEHOfaOzIMzlshAyNeDOILD6EivX86
	iMxffUqRW500ORfyI7VzmxeEfFMVYqaCv8FDs/vgfaKEVwhlVc139raHkPhYaKw4zzBluHeCUfg
	n9q5Y5EAMc4e2uhL4tebjpanpUIUcpYy/bUZxFBv4PZjOSQ+QlcInC7JzJAbXw9F5aI/39CnvYK
	avV6/gltscmZIRvMf4i/h78sVGUuLLQeHEYDqPBHSkH9xuK/F8jKEoIsHW
X-Received: by 2002:a05:620a:2794:b0:939:b0c8:b068 with SMTP id
 af79cd13be357-945f34bc0a1mr254496385a.16.1793966472954; Fri, 06 Nov 2026
 04:01:12 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Jan Fabian <mail@janfabian.cz>
Date: Fri, 6 Nov 2026 13:01:01 +0100
X-Gm-Features: AclHuK9A-2FTFvlKyzhSApeifYzSQH0lEyNG7mAx3QstJCDBSgdJAuxX-NobXGY
Message-ID: <CAEwhnkgosQd5hnN0qkH_xVrxngfhCpnALR6Gi7M1j-4tnSEKOw@mail.gmail.com>
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e)
 -- 6.12.73 to 6.12.85
To: tiwai@suse.de
Cc: kailang@realtek.com, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, mikekarcic@protonmail.com, 
	regressions@lists.linux.dev, sean@starlabs.systems, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(Reply to https://lore.kernel.org/all/87jysdv4qg.wl-tiwai@suse.de/
sent from webmail, so it may not thread automatically.)

Hi Takashi, Kailang,

Another data point from an X1 Carbon Gen 12 with the same codec and
SSID, which behaves like Mike's: the pop is still there with
46c862f5419e. Turning AMP silence detection back on at runtime removes
it, with no kernel rebuild.

Hardware: ThinkPad X1 Carbon Gen 12 (21KC004TGE), BIOS N3YET86W (1.51),
Core Ultra 7 155U. ALC287, vendor 0x10ec0287, subsystem 0x17aa231e,
revision 0x100002.

Software: Ubuntu 26.04, kernel 7.0.0-42-generic (based on 7.0.14), SOF
firmware 2.14.1.1 with sof-hda-generic-2ch.tplg, PipeWire 1.6.2,
WirePlumber 0.5.13.

I checked the compiled module to confirm 46c862f5419e is in effect:
alc287_alc1318_playback_pcm_hook only calls alc_write_coefex_idx, and
alc287_fixup_lenovo_thinkpad_with_alc1318 calls alc_process_coef_fw
twice. So dis_coefs runs once at probe, and en_coefs isn't present.

Symptom: a pop about 5 s after any sound. The sink goes from idle to
suspended exactly 5 s after playback ends, matching WirePlumber's
default timeout. Setting session.suspend-timeout-seconds = 0 stops the
pop, but costs roughly 1-2 W at idle on battery (about 4.4 W against
2.4 W), so it isn't a good workaround here.

Runtime test, writing the old en_coefs values:

  for p in "0x24 0x0013" "0x25 0x0000" "0x26 0xC203" \
           "0x28 0x0084" "0x29 0xb023"; do
    set -- $p
    hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX $1
    hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF $2
  done

Results, by ear, on one boot:

- Before the write: a pop about 5 s after a bell.
- After the write: no pop after two bells, with the sink still
  suspending normally.
- The 630fbc6e870e scenario: a 13 s all-zero stream from one pw-play,
  with three bells from a second pw-play starting 7 s in. All three
  were audible, with no pop afterwards. That was one run, so it says
  little about the original no-sound bug.
- The write also works with the sink and codec runtime-suspended: no
  pop after a bell in a later run.

Not tested yet: whether the setting survives system suspend or
hibernate.

Since Kailang confirmed the same SSID shows different behaviour, is
there something I can read from this machine that would separate the
two groups, such as an amp revision? I'm also happy to test a patch.
From a quick look, master still has the probe-time dis_coefs call as
of late October.

Thanks,
JF
