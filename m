Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793699087;
	b=PCKbQnSllCBBxiBPFk/2HmkINwp1MRPoC0pjAE1ZJM3uJLXwCH6LzVMq2o4V4dkNFcLr
	 juaJf9ff4W5c0WI4qXcPe96qARtpe8cyPMqjTcN0wKL3pe0/Gi/SVv5US1nCdidEC0ZmD
	 k7iBxI3qT+KxyYxew/ntxfoELYIJl7n2VFRYc+85Ts9h0yOApn1NpfYTFYZLQu/NmKjlr
	 IazsBxIHXLY1Q/fkEUjKvTpzJBT5oCJZJ18X+y0aWy7E16iJmBbdqMaRdpxD1nzVpBJuc
	 Yx5QOZ99cDchvuvqp1MfOXYRZ4uQz6KitV7Qahhjl7Nn5DmnpW5G/6UYkQs2nEzpssQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/J9BnLRGC8uxOFLsZCgp0LPx3pkvhWp1geAJQFcvRlg=;
	b=0xWEDYc2OM/hjYTCgKcoxSJj+BJra0K/jkvleBPPca87wAOVE0nVYbCVU6dTdxTi/+o9
	 Vhmg3tbt+OcltaXK9UlwKMSHqOUNtYjKLuOG4/HC9yrhEjDLIR8ku694D/itOP4b26gnh
	 IGRqTcvg54Cy3vGy5nUCjnpmMajeNx3P7ZYhRtXKsnFk3iBXo+3eLNs08FSKEBMxjKqle
	 5p5O8k3rJ2hUyrC7EfeNhu5iJoE++vb4rBpoX7o+zy1M8O8M/c0Qvk8IvJQG2Vr++D0JR
	 jGQOjZlZG1KEpPhT3Mob8YGrY+OCi7lxL6edxxNqRzQZb7egnmQA2kYKvSXYPuPBVww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YguAz9ks;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FCB606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9FCB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YguAz9ks
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso18036935e9.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:44:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793699085; cv=none;
        d=google.com; s=arc-20260327;
        b=eilRoiCGF5M44Klujzc+zBAB0ngnJxlOukmUG9Gk768h5pi+5fxfI5Y+volZz41toA
         XdyO49JIAECXgMkHMoHuF6G5Jk4nknOlpxC3flUdyZ9NNDidM6UHShAtTV0fTgBKuIBD
         Iif/aRuMgfkfUJFwhLahackb0eZQOD0CHkIMWtETVc5ZTnt7jOxDRyLcBhd/tBI/UTiG
         6vcY8joRvF+1QQpnsd8hkbY0N+wEq4loC4E4n2iOzpMuU8Gtzh9rljDl3561XVBut14R
         ODAQTp8C5gjjd3QNIpCySCwnznXecLp0vMsNyfqEj89M9jwgOAvzCf1FbzJiRv9MbChW
         7WNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/J9BnLRGC8uxOFLsZCgp0LPx3pkvhWp1geAJQFcvRlg=;
        fh=C4chSODV1ICnJzw4+/S5BztlDsRilnqWx+7fI2hwr+Q=;
        b=PMZ9jPKQ0gMJAIhO2wjsUe/woI9fzb/rGbm1tBZp6g3HO7P96+v8KyXhtZ/xb6KEVn
         nrZHCA3RzwCjcIxDNF/VASpCYs9OT1fIsFRiP6vFnhen5MNbawnWAsMHW8xdzIubEfVJ
         mG93DOdssnhtA7p2Kd6vWObf5KcjyYy2X1xWZ746/44+1M/EmZrOmM/nFtiOm9uzCzgy
         fdjVp3+HYSmLyGXA00w3/vSI+n8XlUrQhNkkVU9Yam+7PpTrmkKvQ8+ebwbDHFsQK2u7
         ZZM6EOk8E7y67WEk18GCiPQxDmbpd8iTh0VbjqqTs6S1nIDPk8C9N6SY76/MpALXdm86
         EuOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793699085; x=1794303885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/J9BnLRGC8uxOFLsZCgp0LPx3pkvhWp1geAJQFcvRlg=;
        b=YguAz9ksusO1kYn9ldEh6G59tRSryK/H9lsi9C/OXfbDQzVbl+WhpbbBXkyWFd2M+h
         GVw5TCvwn55OlG5+4BmF0koUcdQBPyMCgWl7/FjYWST7xJ6UwFH69C0Bq4ttM7rPmZgW
         Yh9wnR6qai4FhnTVIvf5+JrXFJOnM30ITNmaLazUybtqgohKerZAAATk83px4TT3IZ6x
         BuqWDZ3SsxVTOfrC0LNECls5azbxKq7xgXnTlAdFEhnp+R+o9IePsDU8UgFVi57xRaCB
         PUP7Bemofx471puO1OnhL3YY1e6XP3J/s1rHmO4yVAgsa7k33zcJF21O2SLpDVSCFBeZ
         vCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699085; x=1794303885;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/J9BnLRGC8uxOFLsZCgp0LPx3pkvhWp1geAJQFcvRlg=;
        b=YHkscHQfYYhMKLGmQ7w/EIvwZJhkGT00AKi0KJqZvtww5WbvAvsmYmnOOEqJ0Ixd0X
         RJE4L2vgiMlp3V7rklJI7lydib1MJlSDSpSddcjL75uA3wgbgIejE+CYUrWkLEahJatK
         ZZ0qwAp2O1oFPrXY8a0h8/sGYR7BLrjjmM5PMtrwDsTEixCQ2OgVW/fTw/bkmtgcx/Fx
         dFCNfniM10DN1p+dX/FxZe+Mr648KKSkvMklaMh0pnT16iQLgg64bMsY6nphPb/Q9FhO
         HBoWPvVhqKkJDbgxHD2/4KFLACgeBIcqGw+aVmbPAOmV71HJWLuln75iRY2wT8n19Fej
         iKoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLADCCesiBmlEJIfMIQ+J6sIOUjA9Dzt04ZkBGaD1EousXNq2vJMEIKu/1ykt6p3WiL7yYZlE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xcrGrwdlcdIu5+IWapFcfmOQwLUiNOAkALqQ3LaVHEevS8OA/
	Ja+7elBVWcuckq/2GY+CujHeZ8hPY0z9Tyl3qmQaE3Iq7EP82KRb3BSFqPyQRgG4IgKhpgU3rGS
	Rpie4w8cWXbc9ak1NFUGpJrGLFO+ElDQ=
X-Gm-Gg: AYBFou3xeNPnm10AoR0M8QLuHoi/6oOoPAfsZg98TICHiDLBneWYBPosjkq+V/F1HKr
	3mgG4rvGXSubTuRWXa4sbjvhmNq1nmk801jMUymX+/+kXFVyig1Hpew2SmR8n8UkNqr3EtLrpLE
	/4wmwZ+yxHYDBNlml5buoobLxpNZyWH+zhgI8kGR32z9n0E6G3ZAIHqE4WgZhPwau8Z7Thh8pjr
	O5Ju0n1V+84Q8yolOJHBWapedtSJlAdFvr7reNqnL+PKN75tPggwwgjWRLsThcK5z8DLqTh/e4H
	H+hPQytGljzcIt8YgZHnYk2+F+xNzqn3gV7YTrx+MPFsL1wqQ7z95KoysTBIppVgAiLr5SkKnam
	WQbl4ksy8AjvBMC83jNZostSbMUCGmlvG1v/KUSAH14TLNpXz1+83zHsrlr0d3LZ6skbVLA==
X-Received: by 2002:a05:600c:5246:b0:4a1:f377:5c6c with SMTP id
 5b1f17b1804b1-4ac16acfe48mr291991475e9.10.1793699084886; Tue, 03 Nov 2026
 01:44:44 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <a84fe7b5-ba90-4e51-afcc-548f8b30180b@icloud.com> <4e500063-d985-46b6-a0a1-3feaa77c4b2f@leemhuis.info>
In-Reply-To: <4e500063-d985-46b6-a0a1-3feaa77c4b2f@leemhuis.info>
From: Mohamed Yassine JEBABLI <med.jebabli@gmail.com>
Date: Tue, 3 Nov 2026 10:44:32 +0100
X-Gm-Features: AclHuK9LrOPRysXH3dwqwQb4TVsSxZhcptimLlVHKzJ2_9mQk8sFNwCloZqoTrE
Message-ID: <CAN6p6ihUEgoPLs-Xtg0Rwntoxzp-_9_99Aj7_R_M2PL0Vn7U1w@mail.gmail.com>
Subject: Re: [REGRESSION] ALSA: hda/tas2781: divide error on playback open
 after accepting V1 calibration data without CRC (Lenovo Yoga Pro 9 16IRP8)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: tiwai@suse.de, linux-sound@vger.kernel.org, 
	Cristian Castellano <cristian.castellano@icloud.com>, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cristian, Thorsten, Takashi,

Sorry for the breakage, and thanks for the detailed report.

The two populated entries in the dump are valid (R0 =3D 3.64/3.65 ohm,
1/R0 consistent), so I suspect p->ndev is larger than 2 on this
machine: the V1 loop then converts all-zero entries for the remaining
devices, and tas2781_cali_preproc() divides by re_cal =3D=3D 0. My patch
only checked the first entry, which was not enough.

Fix posted here, Cristian please give it a try:
https://lore.kernel.org/all/4e500063-d985-46b6-a0a1-3feaa77c4b2f@leemhuis.i=
nfo/

Takashi's re_cal check looks like a good additional safeguard.

Thanks,
Mohamed Yassine JEBABLI
Tel : +33 77 38 91 074
Boulogne Billancourt - PARIS

Mohamed Yassine JEBABLI
Tel : +33 77 38 91 074
Boulogne Billancourt - PARIS



Le lun. 2 nov. 2026 =C3=A0 12:36, Thorsten Leemhuis
<regressions@leemhuis.info> a =C3=A9crit :
>
> On 10/27/26 23:21, Cristian Castellano wrote:
> > Hello, since I updated to 7.2.11 (and then to 7.3), opening a
> > playback stream on my Lenovo Yoga Pro 9 16IRP8 (83BY, subsystem
> > 17aa:3835, BIOS KVCN44WW) triggers a divide error in
> > snd_soc_tas2781_fmwlib and audio stops working. 7.2.9 just works.
> >
> > The only tas2781 change between the two I found is: c1b708f712f5
> > ("ALSA: hda/tas2781: Accept V1 calibration data without CRC")
> > (upstream 408249089c48).
>
> Mohamed Yassine Jebabli: have you seen this? It's a change of yours that
> causes this problem.
>
> Cristian: can you maybe try if reverting that patch fixes things for
> you? That we know that this is a option in case no fix comes into reach
> soon.
>
> Ideally please test vanilla Linux, ideally mainline? CachyOS might not
> modify this drivers code, but occasionally changes in lower levels an
> cause trouble (but I doubt that is the case here).
>
> Ciao, Thorsten
>
>
> > At boot the driver now logs:
> >
> > tas2781-hda i2c-TIAS2781:00: tas2781_apply_calib: V1 data without
> > CRC, accepting
> >
> > Before that commit the data was rejected and the amplifiers worked
> > with default parameters. On this machine the CALI_DATA EFI variable
> > (CALI_DATA-1f52d2a1-bb3a-457d-bc09-43a3f4310a92) contains two non-zero
> > device entries followed by zeros, with TimeStamp and CRC zeroed:
> >
> >   0000000 07 00 00 00 5c c8 20 1d 28 b5 27 23 2a 79 42 16
> >   0000016 f2 07 c5 00 00 00 e0 2e 01 f7 2a 1d 72 6f 1b 23
> >   0000032 2a 41 4a 16 c4 0a c3 00 00 00 e0 2e 00 00 00 00
> >   0000048 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >   *
> >   0000128 00 00 00 00
> >
> > (the first 4 bytes are the EFI attributes)
> >
> > Oops:
> >
> >   Oops: divide error: 0000 [#1] SMP NOPTI
> >   CPU: 10 UID: 1000 PID: 1533 Comm: wireplumber Tainted: G        W  O =
       7.3.0-4-cachyos #1 PREEMPT(full)
> >   Hardware name: LENOVO 83BY/LNVNB161216, BIOS KVCN44WW 03/05/2025
> >   RIP: 0010:tasdevice_select_tuningprm_cfg+0x8c2/0xa90 [snd_soc_tas2781=
_fmwlib]
> >   Code: 4c 89 f7 41 b8 04 00 00 00 2e 2e 2e 41 ff d3 85 c0 0f 88 97 01 =
00 00 48 8b 4c 24 10 66 0f 38 f0 01 0f b7 c0 0f af 44 24 18 99 <f7> 7c 24 2=
4 88 21 88 41 01 c6 41 08 01 48 8b 4c 24 08 48 8b 44 24
> >   RAX: 0000000000000000 RBX: 000000000000002a RCX: ffff8d36ca8af218
> >   RDX: 0000000000000000 RSI: 0000000000000db8 RDI: ffff8d36ca8af21b
> >   RBP: 0000000000000000 R08: 0000000000000004 R09: 000000000000000a
> >   R10: 0000000000000100 R11: ffffffff87559290 R12: ffff8d3684e350df
> >   R13: ffff8d36a861d9b8 R14: ffff8d3684e35038 R15: 0000000000000002
> >   Call Trace:
> >    <TASK>
> >    tasdevice_tuning_switch+0x71/0x80 [snd_soc_tas2781_fmwlib]
> >    tas2781_hda_playback_hook+0x4c/0x110 [snd_hda_scodec_tas2781_i2c]
> >    hda_component_manager_playback_hook+0xb5/0x370 [snd_hda_scodec_compo=
nent]
> >    playback_pcm_open+0x79/0xa0 [snd_hda_codec_generic]
> >    hdac_hda_dai_open+0x5c/0x90 [snd_soc_hdac_hda]
> >    snd_soc_dai_startup+0x52/0x90 [snd_soc_core]
> >    __soc_pcm_open+0x108/0x6c0 [snd_soc_core]
> >    dpcm_be_dai_startup+0x153/0x3c0 [snd_soc_core]
> >    dpcm_fe_dai_open+0x109/0xc00 [snd_soc_core]
> >    snd_pcm_open_substream+0x604/0x920 [snd_pcm]
> >    snd_pcm_open+0xeb/0x220 [snd_pcm]
> >    snd_pcm_playback_open+0x39/0x60 [snd_pcm]
> >    chrdev_open+0xbf/0x230
> >    vfs_open+0x3f8/0x520
> >    path_openat+0x4f4/0xc50
> >    do_file_open+0xd7/0x150
> >    do_syscall_64+0x8f/0x380
> >    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >    </TASK>
> >
> > The kernel is  linux-cachyos 7.3 (taint O is from the NVIDIA module);
> > CachyOS does not patch the tas2781 driver, and its LTS, 6.18.55
> > works. If it is needed, I can test patches.
> >
> > #regzbot introduced: 408249089c48
> >
> > Thank you,
> > Cristian Castellano
>
