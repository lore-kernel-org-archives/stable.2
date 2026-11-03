Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793699582;
	b=GuXAy7ta/wvZGJdsPPIV6hEqSaD0ZEmi1zWXGnDpgIdN+azHnQcpsqtGlEj3B1FATTVH
	 rTkXO6VUmF3n9zgYndhdq8yy+AqlFCC128tGodmIXVjAT+904SSYb01gxonvH81bX+Xpd
	 l/romIdLQ7mPHbzydnFyTOMtpSnejVrRZkhsFt2QwN3XZFlFwRk8I9Sd1fH1fMgwYG2q3
	 fnUGOKByS9ciLUh5eqL3Rp3abJe4X5QwCmATjpOjhPxc7rNkBPCBPNx4OyqKwmeYIYgB0
	 S/a8IyuIzqLbuiWse0Rg6AYdHXaE56W/Eg35iNPBlvdoNuKziqsBy1QaxwbyoKklKRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GKajE82zSLmmO4qRbQtdvvELq+9Ww/Uvb5sLbelJn60=;
	b=xYbxB7zNj8uySEO9qFY6jRNs9GjEJvZpn2ugAsI/VXOBl+ZSihlCL/oxVTIzI7Q7HHWS
	 YN13RFK+PQhlOyJCXhx+zbVdkDYWoqli06gGHIWbHw1WUY4gxKcm3J2bk3BPEM9E+Akbo
	 PHzwlxtdE/H3G/n6fovBBDAvlYQcYBL0HyhMEtYDly6I0QM7vKQTwexmv1jGeggvKeDLy
	 93ZxN5RgTWZyy5N81QadyoQM2M3McVeCqbcI7GXwANK2BlhxGjULk5wPeUBFhcCfJHrPo
	 xQZkQKGqEu22IIxBylD+VR1jLq5JI6q66eDNrQPac4/Qwfzi4u8IbdgQ0QlR4Vz7X4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=peOfMWHI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E188606D814
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E188606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=peOfMWHI
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so2736255e9.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:53:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793699580; cv=none;
        d=google.com; s=arc-20260327;
        b=sL/s0Gl5vGTjIWP18dU5hqK71WVLTI72maObJkHLW45BS4ZsWOJSxR0M1i8SGb5bBJ
         bnCso9Y5RDf77toX5jNu4w0zeHNNp+DWpWE6CNmeLzKsYn7+0K3hWaNwjcs0CLTyks4Q
         nqG5Savg6lsDl+JZz0aYO8jYjjTXVsZYHtenAN1pAKovgnzTuHXqZZKeLc5QUIiLDgIg
         KJw/eQibW0jkeVfhjCB+wmSLjPpJzydaD+fgEkkIUc4VYHsXyKimaVKfGDKltTPjmfnl
         Ye+vL39HLXhvcyEL1EJqjcpT7Ux2Sg6Rp8qso2X4Dn/eYxPT7GKnqDsk41elaNs6ynVk
         1F1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GKajE82zSLmmO4qRbQtdvvELq+9Ww/Uvb5sLbelJn60=;
        fh=h/nP8johD+LhMF8UATxiO0PFmThGl3eXUj7NhZxFs9I=;
        b=QnE+YCDT1ZN2mATK9ZbBJq1PA0czstV84hhVt5d8lUw2SjRvrRXztLAIaiPHoAbbB6
         vHvvhZUJj64kIL9inZD4pueMMM28a8xL1VWLdfdZduTUPV0a7x/e+tuWeAdzwXfn1U9e
         WJsTW9nE9KdDYUuDaGNemPv+Ltl1T0RR1geg0Mb9srqHPrg4FhGihlCqzeajzks5vzwE
         +3OJ0gyFYDCTJUxLltJEzcURkqnpNVbKu+ek5MDchN9AOo8BRAmzBPMPnWQ8XHH2bM/R
         XFSm0mLGodgzer9z9q4PJ8vDdmzHCBpsX2lIhe0DQwqOHXw819yykcQrYRZxqgTSKrEU
         rp8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793699580; x=1794304380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GKajE82zSLmmO4qRbQtdvvELq+9Ww/Uvb5sLbelJn60=;
        b=peOfMWHIyzPwQL61CM2Ow15fwXr1AP34xKdyJRsvJGFAZthiMpVMa+CKMowW/WU88B
         co+S5JaCwDNgs3aoomA7DluS7vfYIKfqbHgzg7FHBBtl3O0VQiRADXJPD+IXWYv1kc+x
         WccRM5dwWr+wIWtHQmtYZTQiYyADTYnA6+Zx4UYOFIpUFREuYSmEznv9r14AWEFq3PjR
         /6wQEsXEVBQxClps1ArrT/n3tfUBaPgMGfM2dJ0B2nA6v0KJLsFPl8xFGJ27B7siqBZY
         5rXTU+p1w/BCSLrQ2jJ+zuDZlUFV0ZwMDubgurKGqBKuKmFwECymcdv1Rs18sIbGf02n
         js3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699580; x=1794304380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKajE82zSLmmO4qRbQtdvvELq+9Ww/Uvb5sLbelJn60=;
        b=1mnAV+EP4aFW/tzU0T6N4bksl0QjxMesai3p5t51Je27GWZjroYiWq8JQMmHTADc+Z
         6HPPa5Pj+uJ3ygIrC2prvG6tiik9CCZ2lVGVw9qlTIUOpSAD+DdI0EFqa/bWRt2zyYUl
         eOyeKHWanwmee0BTUOrkTzE2JErlY5J8wc8Wn2Ky+V72i6DUtwyu2ZHpQlHc0/lwj7io
         My2jxRIRRM1L40WPILojFQKqJW/mB5RlEjVSgWTNYSqqoUgVy8xACTe30HUmlPym6qt4
         nCkxR9+MNVmlMSCeBf7wAKrs0uLZS0oNxuJf7mFK9eq5PB33ZiTNoPFPPpc53xMTm/II
         Ccnw==
X-Forwarded-Encrypted: i=1; AKwUvByOPwsY1SCmwuiGfumx9yD/mGnhGozZjSJy6R7y0+ChkenF6BXCPM2gFs3jChMjcNhl/2A+VoM=@vger.kernel.org
X-Gm-Message-State: APuU4Z80TxD0LOX1NeZBkw/wJyPfQDVg0LwBXEtlA0Euhkm5aMLdDs2c
	PP/EcM1nD5CLg+O1OvQAklBbjGeMa1U2tfwtBclBR0z0ZtUAg0sjTf1zM6yvysrC/Di6gDBr86R
	vXQWT3EibIPgFYW5uSCcIsLFTphARwqg=
X-Gm-Gg: AYBFou1GdeOSD84N0NjKCVdtkMgUk52+17QooRPbuf0lYhRNpElNU2DLXX6Z50hmjN0
	X8opqO1hcnUea3xASDLb35md5SdJP7citygW8K1D6XXAXM9Iw9HFFi9yzMcoo68o4wPscpV297s
	IjT4b6Xkdf+moJ1UdZxiXbk7HId+KYDCiq4bDPBi01tUuVihM+QWdWA5cEUOBOsh8kS52z/gAmG
	l8JTgTJgVuX/P/ZR68V40GXOiX12kpDvqku0wYnKoOaM6f3WTaDEyRecAtW3OJ17ee104MrS5Tv
	dI1xoSjkOzn0pSYlBCpuf3EWqEv+u8x+rcjIaFyHsvQwWtSBBFueyPQWG9oCSEyBQZiq/XuhkHE
	5vUKXG6WDutO6pByoZ/qwVOUvFPB62qVAcXqUJf/c7vdv1Q3w97YydzWoikhNJ7+khIS/vW1HOZ
	yTZOehwbSEiT8I2Oo=
X-Received: by 2002:a05:600d:6508:b0:4b0:b9ff:1e7c with SMTP id
 5b1f17b1804b1-4b0b9ff2129mr116381315e9.15.1793699579991; Tue, 03 Nov 2026
 01:52:59 -0800 (PST)
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
Date: Tue, 3 Nov 2026 10:52:48 +0100
X-Gm-Features: AclHuK_gVSoghFofHU4OU9sa8nsiBkF76JbJCDYGPYcibo5ActA64gLH3ScUcvw
Message-ID: <CAN6p6ihSizkgHHYP2ns1ifE-eDeR2ZsK=wWyi4JoEgF3gQ3zxg@mail.gmail.com>
Subject: Re: [REGRESSION] ALSA: hda/tas2781: divide error on playback open
 after accepting V1 calibration data without CRC (Lenovo Yoga Pro 9 16IRP8)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: tiwai@suse.de, linux-sound@vger.kernel.org, 
	Cristian Castellano <cristian.castellano@icloud.com>, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cristian, Thorsten, Takashi,

(Resending as plain text, the previous mail was rejected by the
list and also pointed to the wrong link, sorry for the noise.)

Sorry for the breakage, and thanks for the detailed report.

The two populated entries in the dump are valid (R0 =3D 3.64/3.65 ohm,
1/R0 consistent), so I suspect p->ndev is larger than 2 on this
machine: the V1 loop then converts all-zero entries for the remaining
devices, and tas2781_cali_preproc() divides by re_cal =3D=3D 0. My patch
only checked the first entry, which was not enough.

Fix posted here, Cristian please give it a try:
https://lore.kernel.org/all/20261103-tas2781-v1-nocrc-fix-v1-1-a769c27f21ce=
@gmail.com/

Takashi's re_cal check looks like a good additional safeguard.

Thanks,
Mohamed yassine JEBABLI

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
