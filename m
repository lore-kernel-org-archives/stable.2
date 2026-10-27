Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.74.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139724;
	b=WzNj31FOA6KeQhvtlMFJMfSlgl9YsDRm24za8X4QgWKPFs7O9KWvL0M/DKSm2guIWsv3
	 acZfnNkrCtmD3/FV4vo0yyA3SiXKP5giV0PYxQUZD0D7PjVfPWQMNDSIgH17vHMJZxJvq
	 IUVuMp+y73haz1cjsX0mWEJ1wf4D1nGZ6Fxl9ED+5bqNlTGM3MZ8xmaqz1ad5D8ZT7UGC
	 ODTkKONhtBvzKEQCEud0Eg0RelBWq1LMdOYM8YWjENQzI0cDRYfjRKDax4g8QhGcNfAfC
	 v8AHdeoRbpkgGcRuZWWiJ0J/SiOuaPbswXsh9yDIJeUCDwiRYqwqKyZVclV+pQenGng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139724;
	h=DMARC-Filter:Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:
	 Cc:From:Subject:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Info-Out:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-JNJ;
	bh=9HJ62GiGTy/gw8NufnOvKlJLBVkRKKV7d6QpXBkvd7E=;
	b=YA3SPwisXVe0T6M1O18tZH0yOYl2F03CNDzAzkZwd+tGHBP3zMTiHV2oa9M5E5GMLA0p
	 2D3bRoBtEwEvr2tDNT4cAkulwm4Lj3YrmLMJWBt43Furdhs6Kaqd+fKvBfvm/Q4DLgvsV
	 BCceYphfa8MPgMGSNxL6M8dG2SPFgtgYw3JvVcH41IEHjd9Y4Vy+7r/fOPJskTip8YeDn
	 4fENz2Ln9VaZYiXqma+9jtcz4uAGvVDEzLv8y/BNtPKV9sQ5QbNLY2E6FQHaQVXguH80s
	 6TQo07MA7rRStsmjLDLKrj6CZ2aRn9dShOpYYW1hIwIF78UM45hopL2L4DdXxuZde+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=icloud.com;
	spf=pass smtp.mailfrom=icloud.com;
	dkim=pass header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=GYg0Zs0o;
	arc=none smtp.remote-ip=57.103.74.231
Received: from outbound.ms.icloud.com (ms-2004l-snip4-11.eps.apple.com [57.103.74.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8C6606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 22:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B8C6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=GYg0Zs0o
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id 6262F18000A6;
	Tue, 27 Oct 2026 22:22:01 +0000 (UTC)
X-ICL-RepId: 01a17f74-c466-7522-87aa-3ffceb447af1
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhNC0MDXBxCC0AdXwddEhVdRVAfXhhGGVgWHQ5WGEYVVRRSA1grWxNVF0YJGQhdHRkeV1BeCF4fTBwdDlgGEgJaRQZNXw5eHwQXRhlVBEceXVZeHhkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPDA9fVBUOGgZAVQoLQBRMVlgGRlMWWhseWANTVEhbSwNcD1tQMFAbXwJCDxwTVhUNTUMSQhUEEVABWB5W
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1793139722; x=1824675722; bh=9HJ62GiGTy/gw8NufnOvKlJLBVkRKKV7d6QpXBkvd7E=; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:x-icloud-hme; b=GYg0Zs0oxKfswLL50Dy9wQUyFJ9eaTegkAUgGtb6IAO5Z/9RKwUp/1aIXAMdJ5Nn67V1xzqJt9yumqI/vPn9XZqipoeFJRTHA+nb/F8hgi+LbW6+qRNRD8KNAvoTfo7NCZm7P7PWkAECUJHVzpe2qioByy6wt5gl9qpsf/kFiE0SweW8987dxXuLnoM0KskCNcozCeFJbyZfREP7W8HgMReAbdY7sewRUupDrL4daZcct8zVR2bNzPtm6PfIV1RdhF5cnaCdBFjC0ZAZbFYRvWGh/op4XUjeOXKXRpPvkn407L6t6KJjCku577QXuODnERi0X29nESGQnpLH9kg2EA==
Received: from [192.168.1.50] (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id 5196F180013C;
	Tue, 27 Oct 2026 22:21:59 +0000 (UTC)
Message-ID: <a84fe7b5-ba90-4e51-afcc-548f8b30180b@icloud.com>
Date: Tue, 27 Oct 2026 23:21:57 +0100
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
Content-Language: en-US
To: med.jebabli@gmail.com, tiwai@suse.de
Cc: linux-sound@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
From: Cristian Castellano <cristian.castellano@icloud.com>
Subject: [REGRESSION] ALSA: hda/tas2781: divide error on playback open after
 accepting V1 calibration data without CRC (Lenovo Yoga Pro 9 16IRP8)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=SrOdKfO0 c=1 sm=1 tr=0 ts=6ae12409
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=eD1N5GnKAbQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VfikHhr-D2iK5rlxiJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA5MCBTYWx0ZWRfX8X/qb+UQpwhq
 48wYsNv7WhrmnpP01REaPS4kYjvVJoAg6ZMb/XBsYpk30YpfGNnDTHHJfh6MyAB6u6UFmse6VPN
 2OXNDPrYyHzt4Hk6wq8bdgWYuTD+BV9Xy75509siASZKscLGGut+iCoRLVz6gI3IWXtCRNo7y4H
 TsKcqE2cKSSmllR/oHsVzkMZpq9dc+9YQ9FpbtjPRc66nKwtvHSaWcJwoXjPIIs7pcIJ0aJDVSv
 PN+/FX9xgdYkatuBB36psEpy6Nb3+/uGufyKiVerzBUzWXCEo0J31z05Mfq243YNvrJ5WiACazx
 dtla8lbPm645QlxXlVCELwEdNKRDa55t6+j3s820XrVVrw00ts8rjk2eJ5U+AU=
X-Proofpoint-GUID: zvmonwOqKB_Wd4m3Y7uZFogIyICaqb9Y
X-Proofpoint-ORIG-GUID: zvmonwOqKB_Wd4m3Y7uZFogIyICaqb9Y
X-JNJ: AAAAAAABqFK7fFSoe7rCT4ANnaHlhYTdBA0lRwtOCMx6VOTy/8iaEGvF/169W9N5AXD0na
 OXopY8FIA9LzETibOKNkitaouP8Qo2tEx4sXgXLlTPk8TUicADGZtWlhkGIHOWgIDSaLiD
 K11PIc1ZjvlxSSWVH7s9yImvCFx5sX3oTpiR9Vnh3g4sJaEC0C1nPRgOzBiw3imwEPxZu1
 3SQVh4QkxYgqpl29Qf4h/zXsIoYrlxQzc2t+MA5y6OAHusAXghJBTJRvCB4gMhC9Nd1mpB
 3FqdgnsneUXplnMoAHRAWqrZ1Nv1u5H9iYAmeKtqVUsoneudzbXqTZ6sbpXlGQE+cJmLQd
 QOGuWMVo7Dh0xfL6yu/bPlFXWeLdAHhSWdld7PBAXiyhrzrsrKxgV5u/VScKEFBNv59jPC
 08uWUUD1xF4nmM2Y56YdzBT0VtPpGjqL6yFmG95thmnqpe/sJQpTmKjOldS98f7fCpSYnu
 sI7hv79YtVB/grpTZ6gfNDwZ9K7iWFNt8giDQ+zxSuVW44E/lHormsDhK2eEOZZyGTSPVt
 mVNUqaBWfvWRjVgyfOHw3sIcP5OELRLO3p80iegRYJla9JLfahRPGFlumIiLmXp910mDCi
 EbqnV0zELe//qWqQ0TOHq/oSkGNWLSzNYFnbiF5L1RNEqmULwkaVfLWfsERKHw+Y7Y8DE5
 JouC5lLQ9PnmZyi3YFGd1Dy/i7c+Xw9EjKpzmzozjDh824A0MTNYuv0AAiDgBRhghx6XQc
 /NPhwoC6nIU/jYPypy0eZfFv0eee5GVPeJx1teleTPf5g5i0nur4zmV54OrPGkBt//Qa7F
 AW8VuveUdp3YgNDc/6V4L2JpR0Kq3mK1RXAuCS5ByjLJUMjnwIhND72UATEG5swgZ+e5YD
 idAD1PFBvSJXb94E2xtvIzsn9QtFpvBTIh0SWhV1KzjNRSUPW45WQfSwh99uc0myxtUC4i
 itwWweSBsFU5LwcIFZVMTa7JzQWfjWTNa0FWVnLopCRtTSclVRUfGPbyLy7tRWNtb8Yd+R
 6873Y59NjaPg2b3QNr6gHkXTNMdOjGabGxHAPkfH061OUJZ21oYXokTh+x7zb3cBdjhv9U
 r35EHens5QGW2f9UzU9M8NYWXG5k7ym9BHGcSMZ1NQIFn0j8zNn3ViYzBxN8L9VX13+yAw
 PS+E3s75syQMHGlM1TNXsJeGCmrgLY+YRocc3+wzRv2FUg+IgHRxXCd2kDBr1Ew5qqgDwP
 oS3FpyrB9q6AO/7Y1mwUHlqud+Z24WkdlyoPmbnM7Ny38+dT4ZU5ilYDR58Ta1JQ46A8A0
 v4Wqlkt1cTGwmmQ0xr9pc60EJpGgna3MUxKzky1ebI49xd9AEy0DETrAiUZw==

Hello, since I updated to 7.2.11 (and then to 7.3), opening a playback stream on my Lenovo Yoga Pro 9
16IRP8 (83BY, subsystem 17aa:3835, BIOS KVCN44WW) triggers a divide error in snd_soc_tas2781_fmwlib and audio stops working. 7.2.9 just works.

The only tas2781 change between the two I found is:
c1b708f712f5 ("ALSA: hda/tas2781: Accept V1 calibration data without CRC") (upstream 408249089c48).

At boot the driver now logs:

  tas2781-hda i2c-TIAS2781:00: tas2781_apply_calib: V1 data without CRC, accepting

Before that commit the data was rejected and the amplifiers worked with
default parameters. On this machine the CALI_DATA EFI variable
(CALI_DATA-1f52d2a1-bb3a-457d-bc09-43a3f4310a92) contains two non-zero
device entries followed by zeros, with TimeStamp and CRC zeroed:

  0000000 07 00 00 00 5c c8 20 1d 28 b5 27 23 2a 79 42 16
  0000016 f2 07 c5 00 00 00 e0 2e 01 f7 2a 1d 72 6f 1b 23
  0000032 2a 41 4a 16 c4 0a c3 00 00 00 e0 2e 00 00 00 00
  0000048 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  *
  0000128 00 00 00 00

(the first 4 bytes are the EFI attributes)

Oops:

  Oops: divide error: 0000 [#1] SMP NOPTI
  CPU: 10 UID: 1000 PID: 1533 Comm: wireplumber Tainted: G        W  O        7.3.0-4-cachyos #1 PREEMPT(full)
  Hardware name: LENOVO 83BY/LNVNB161216, BIOS KVCN44WW 03/05/2025
  RIP: 0010:tasdevice_select_tuningprm_cfg+0x8c2/0xa90 [snd_soc_tas2781_fmwlib]
  Code: 4c 89 f7 41 b8 04 00 00 00 2e 2e 2e 41 ff d3 85 c0 0f 88 97 01 00 00 48 8b 4c 24 10 66 0f 38 f0 01 0f b7 c0 0f af 44 24 18 99 <f7> 7c 24 24 88 21 88 41 01 c6 41 08 01 48 8b 4c 24 08 48 8b 44 24
  RAX: 0000000000000000 RBX: 000000000000002a RCX: ffff8d36ca8af218
  RDX: 0000000000000000 RSI: 0000000000000db8 RDI: ffff8d36ca8af21b
  RBP: 0000000000000000 R08: 0000000000000004 R09: 000000000000000a
  R10: 0000000000000100 R11: ffffffff87559290 R12: ffff8d3684e350df
  R13: ffff8d36a861d9b8 R14: ffff8d3684e35038 R15: 0000000000000002
  Call Trace:
   <TASK>
   tasdevice_tuning_switch+0x71/0x80 [snd_soc_tas2781_fmwlib]
   tas2781_hda_playback_hook+0x4c/0x110 [snd_hda_scodec_tas2781_i2c]
   hda_component_manager_playback_hook+0xb5/0x370 [snd_hda_scodec_component]
   playback_pcm_open+0x79/0xa0 [snd_hda_codec_generic]
   hdac_hda_dai_open+0x5c/0x90 [snd_soc_hdac_hda]
   snd_soc_dai_startup+0x52/0x90 [snd_soc_core]
   __soc_pcm_open+0x108/0x6c0 [snd_soc_core]
   dpcm_be_dai_startup+0x153/0x3c0 [snd_soc_core]
   dpcm_fe_dai_open+0x109/0xc00 [snd_soc_core]
   snd_pcm_open_substream+0x604/0x920 [snd_pcm]
   snd_pcm_open+0xeb/0x220 [snd_pcm]
   snd_pcm_playback_open+0x39/0x60 [snd_pcm]
   chrdev_open+0xbf/0x230
   vfs_open+0x3f8/0x520
   path_openat+0x4f4/0xc50
   do_file_open+0xd7/0x150
   do_syscall_64+0x8f/0x380
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

The kernel is  linux-cachyos 7.3 (taint O is from the NVIDIA module);
CachyOS does not patch the tas2781 driver, and its LTS, 6.18.55  works. If it is needed, I can test patches.

#regzbot introduced: 408249089c48

Thank you,
Cristian Castellano


