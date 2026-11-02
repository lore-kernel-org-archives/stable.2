Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.61.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619378;
	b=V+IXejk4+isDcJn8+tr2AwN7iPc9m5qb++WaNIAaEqetv+sndrftm7snunamM0E+LwfP
	 xnPKN+wb9nRLreoquWjWjZtlgdfYuFZzgFyDzwA9l01HAQdkuAxt0Pg16tiiRoKdBfiPV
	 P9iy0oK2+1Dr59yI3eYUoQG3SUcle0wIr9luZghde6AuPItcZlXJ6mSj8evLenr8E+1Q0
	 VU7Nc0vnndWFlHCKa7OE0jW7PjDmrzELmjRdt+pxUp+tv0OJa6ff5v/0gin0/CpppgvQE
	 6Pg6/tQ4pHeGWyQrfsTWSvSwvssiiBbDS9ezMzDQSIpUkiu4DP99OPqYQ9acFpjct3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619378;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=AMs5lGNpxxs+yEame9hGaGR29jtnnZiG9iEQ8xGx50k=;
	b=u8a2t8qS6hmTRbUu6mVZ2ONNFVhGbz2ZGRCAWOyddnaoegrExxBJ/R4CJ3dH3nHbvvtj
	 CEr1qKd3AUTZSSM0JsD3WvPyV+DDXSPZFz/CeUb2oaxpKzE2Y6GC1bUTRcwviUAtEip/p
	 iGYCSv9sEMmOoCIsPt9yivqAb24qzjtD2sdbXCHJeTzH++BwLXgrKkwx60eIf48gG4eDh
	 A3j4wpPg0Fy72uHYrhIEvY8/3K2ZLHbLUdZ3RtN+O767Ii3wpXeeNuB1dzZP8xTjBWtox
	 0BLTvASc6puz+lqnwCxGmuocgiToe2fxeUWDIpz5P7g7XyGHTQFLx2meR0hrN7afRWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=V5+kM6Qp;
	arc=none smtp.remote-ip=188.68.61.103
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DA606A327;
	Mon,  2 Nov 2026 11:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6DA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=V5+kM6Qp
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4jJ8l36jvSz8KBr;
	Mon,  2 Nov 2026 12:35:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793619311;
	bh=FwhdT9DbUMYiVaSPZxWHymVeD0TBHBvHuIdw+gdl10w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V5+kM6Qp5PTYdAIeuqH0yH+NZnV1vbLY0PlWof2qY1W5oCt84fiA9aRUFzTbEYfiy
	 Fj7ZW97vruIUILZCrZsQ0T6zdrY08QOc1Vp1m2KlGlyTtf+Z+5PoVrUTQuED4mdbV+
	 aAUhbLbtog7sKE8cL9trM0J+YTG+AT2l6CDXbnByfOONXOk9M5zQj4aV4RbZSAiPhN
	 IMnyzOSmScg083Zcx8nn9TUuzQqJ4sz68Cd5EcF2Dfz+nm3Z0hI4EgUvHVcqwzZGWm
	 BVk/qgVBWHnKKZ/anb80Ix/rVk/8HkfZ75N2llMToJpvRz/7oAQqnfRMHDTRcqjzZO
	 FS8u4ceHXWaEw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4jJ8l360qlz8KBP;
	Mon,  2 Nov 2026 12:35:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jJ8l30j7Dz8tkH;
	Mon,  2 Nov 2026 12:35:11 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 4C3CB5F948;
	Mon,  2 Nov 2026 12:35:06 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4e500063-d985-46b6-a0a1-3feaa77c4b2f@leemhuis.info>
Date: Mon, 2 Nov 2026 12:35:04 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ALSA: hda/tas2781: divide error on playback open
 after accepting V1 calibration data without CRC (Lenovo Yoga Pro 9 16IRP8)
To: med.jebabli@gmail.com, tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
 Cristian Castellano <cristian.castellano@icloud.com>,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <a84fe7b5-ba90-4e51-afcc-548f8b30180b@icloud.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <a84fe7b5-ba90-4e51-afcc-548f8b30180b@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179361930662.1245276.4844926124568559179@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 4C3CB5F948
X-NC-CID: ye0FPkcKvoyeB+2G998DlD7CmBgL3dSm2kQpZugzaqbdCaH12Gg=

On 10/27/26 23:21, Cristian Castellano wrote:
> Hello, since I updated to 7.2.11 (and then to 7.3), opening a
> playback stream on my Lenovo Yoga Pro 9 16IRP8 (83BY, subsystem
> 17aa:3835, BIOS KVCN44WW) triggers a divide error in
> snd_soc_tas2781_fmwlib and audio stops working. 7.2.9 just works.
> 
> The only tas2781 change between the two I found is: c1b708f712f5
> ("ALSA: hda/tas2781: Accept V1 calibration data without CRC")
> (upstream 408249089c48).

Mohamed Yassine Jebabli: have you seen this? It's a change of yours that
causes this problem.

Cristian: can you maybe try if reverting that patch fixes things for
you? That we know that this is a option in case no fix comes into reach
soon.

Ideally please test vanilla Linux, ideally mainline? CachyOS might not
modify this drivers code, but occasionally changes in lower levels an
cause trouble (but I doubt that is the case here).

Ciao, Thorsten


> At boot the driver now logs:
> 
> tas2781-hda i2c-TIAS2781:00: tas2781_apply_calib: V1 data without
> CRC, accepting
> 
> Before that commit the data was rejected and the amplifiers worked
> with default parameters. On this machine the CALI_DATA EFI variable 
> (CALI_DATA-1f52d2a1-bb3a-457d-bc09-43a3f4310a92) contains two non-zero
> device entries followed by zeros, with TimeStamp and CRC zeroed:
> 
>   0000000 07 00 00 00 5c c8 20 1d 28 b5 27 23 2a 79 42 16
>   0000016 f2 07 c5 00 00 00 e0 2e 01 f7 2a 1d 72 6f 1b 23
>   0000032 2a 41 4a 16 c4 0a c3 00 00 00 e0 2e 00 00 00 00
>   0000048 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   *
>   0000128 00 00 00 00
> 
> (the first 4 bytes are the EFI attributes)
> 
> Oops:
> 
>   Oops: divide error: 0000 [#1] SMP NOPTI
>   CPU: 10 UID: 1000 PID: 1533 Comm: wireplumber Tainted: G        W  O        7.3.0-4-cachyos #1 PREEMPT(full)
>   Hardware name: LENOVO 83BY/LNVNB161216, BIOS KVCN44WW 03/05/2025
>   RIP: 0010:tasdevice_select_tuningprm_cfg+0x8c2/0xa90 [snd_soc_tas2781_fmwlib]
>   Code: 4c 89 f7 41 b8 04 00 00 00 2e 2e 2e 41 ff d3 85 c0 0f 88 97 01 00 00 48 8b 4c 24 10 66 0f 38 f0 01 0f b7 c0 0f af 44 24 18 99 <f7> 7c 24 24 88 21 88 41 01 c6 41 08 01 48 8b 4c 24 08 48 8b 44 24
>   RAX: 0000000000000000 RBX: 000000000000002a RCX: ffff8d36ca8af218
>   RDX: 0000000000000000 RSI: 0000000000000db8 RDI: ffff8d36ca8af21b
>   RBP: 0000000000000000 R08: 0000000000000004 R09: 000000000000000a
>   R10: 0000000000000100 R11: ffffffff87559290 R12: ffff8d3684e350df
>   R13: ffff8d36a861d9b8 R14: ffff8d3684e35038 R15: 0000000000000002
>   Call Trace:
>    <TASK>
>    tasdevice_tuning_switch+0x71/0x80 [snd_soc_tas2781_fmwlib]
>    tas2781_hda_playback_hook+0x4c/0x110 [snd_hda_scodec_tas2781_i2c]
>    hda_component_manager_playback_hook+0xb5/0x370 [snd_hda_scodec_component]
>    playback_pcm_open+0x79/0xa0 [snd_hda_codec_generic]
>    hdac_hda_dai_open+0x5c/0x90 [snd_soc_hdac_hda]
>    snd_soc_dai_startup+0x52/0x90 [snd_soc_core]
>    __soc_pcm_open+0x108/0x6c0 [snd_soc_core]
>    dpcm_be_dai_startup+0x153/0x3c0 [snd_soc_core]
>    dpcm_fe_dai_open+0x109/0xc00 [snd_soc_core]
>    snd_pcm_open_substream+0x604/0x920 [snd_pcm]
>    snd_pcm_open+0xeb/0x220 [snd_pcm]
>    snd_pcm_playback_open+0x39/0x60 [snd_pcm]
>    chrdev_open+0xbf/0x230
>    vfs_open+0x3f8/0x520
>    path_openat+0x4f4/0xc50
>    do_file_open+0xd7/0x150
>    do_syscall_64+0x8f/0x380
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
> 
> The kernel is  linux-cachyos 7.3 (taint O is from the NVIDIA module); 
> CachyOS does not patch the tas2781 driver, and its LTS, 6.18.55
> works. If it is needed, I can test patches.
> 
> #regzbot introduced: 408249089c48
> 
> Thank you,
> Cristian Castellano

