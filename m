Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.75.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139530;
	b=JIGFeAdDHvDHjCuxul/JZCcU9myX5vfg4O8GCeYGfHv79DZM1DB121dJjgkCUKJF466r
	 rnKiNlerGuZhdxgQFj+PaiGZGfTvqPKKn5RUNtJB9OqEvNxd2l+3sDnOZwk7lLc12eDAi
	 kxPIoIGV3NuIPvwY3Q0LwaPgzPmQbyf1zLLOxy38mG/rcNahIWC4RfiJzqb51LE6dVkYC
	 e37H/dOFe6CnmzyD4UcWUEc+M+QAAG3KZdHbajbGfD7K3Rp//JVetDcmVwi/sFySX/Bkk
	 72bahQfSGhCTv0P7CMqxxF7DXkIZV/4d2gr6UAl1c13L1suPr45XQ9k9Y4+X/2S7eqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139530;
	h=DMARC-Filter:Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:
	 Cc:From:Subject:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Info-Out:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-JNJ;
	bh=9HJ62GiGTy/gw8NufnOvKlJLBVkRKKV7d6QpXBkvd7E=;
	b=AgORlZXEOJ93wg5s6imP86b4dUWSA4/S89m24VqY2z3t9srWshH0gLdYotIzjNcadH95
	 dPIWa/Xci0J/iLJzkh5rZRPv1DdHU1qobfXc76kgn5CUd0vNzgN5l7qaClbF4ppLc5Hbi
	 5W5/GGByBuGPhdm7m/3Qzf4wWynluuWbkIXDAViC+ymFz4+JN0fm1G5jLUvPNYLyhCaia
	 g6+2IlTFyTcJ9OG3rGcXO/J3UyBGIylWnWEZkufiEan/EwKPSIM+QLmicSXJClVK6iOlE
	 pCRHdFzIm3GMxSEDaGWawjPRt7ab2GcM+4cPf+xC37Z+rYd3bJwMu+SgHXuWojLW2Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=icloud.com;
	spf=pass smtp.mailfrom=icloud.com;
	dkim=pass header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=VznvtUGi;
	arc=none smtp.remote-ip=57.103.75.5
Received: from outbound.ms.icloud.com (ms-2006c-snip4-2.eps.apple.com [57.103.75.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B5606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 22:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC2B5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=VznvtUGi
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id C86AA180013F;
	Tue, 27 Oct 2026 22:18:48 +0000 (UTC)
X-ICL-RepId: 01a17f71-d450-7886-b377-c4fd3ec315ea
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhNC0MDXBxCC0AdXwddEhVdRVAfXhhGGVgWHQ5WGEYVVRRSA1grWxNVF0YJGQhdHRkeV1BeCF4fTBwdDlgGEgJaRQZNXw5eHwQXRhlVBEceXVZeHhkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPCVUOAxJdS1dAAlkGRhRMVwkHRgsSCU0eWAUOCxNYT1ddBlsBMFAbXwJCDxwTVhUNTUMSQhUEEVABWB5W
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1793139529; x=1824675529; bh=9HJ62GiGTy/gw8NufnOvKlJLBVkRKKV7d6QpXBkvd7E=; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:x-icloud-hme; b=VznvtUGiztfKk9qdLxrbMq+A955Zdmkiz1SkFCw6M1g+MCIbV1ARysdv1nl74NKU7294FXmt34BTGAAEBUFnMk/uWNxQRxlnVzwx7co0FS4ZYT7hxx3tkLeMFiY2NBG3jJPsHHsAHtEljnI0k8FekmSifsGztRAJQqJvn3eslK4IUVlzqZHXiQ+zem1RJcq+/8MMvStWqBfoiK6kVpl/8vNmqUpbI5RaTDDGTbor03h6ylKuqtrDEoEdDX+5eqli97x5NWyYnSPCqm8WHhhXn/VjgZ3n3O8R6ajDwUQzFTk1NXoVI28sLiS3Ez42fVsSJub22YTrgtNELcr5bPeFKw==
Received: from [192.168.1.50] (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id 69B3018000E6;
	Tue, 27 Oct 2026 22:18:47 +0000 (UTC)
Message-ID: <dbe1bd3d-5246-4dd0-9b05-52e9ca7d0103@icloud.com>
Date: Tue, 27 Oct 2026 23:18:44 +0100
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
Cc: linux-sound@vger.kernel.org, regressions@list.linux.dev,
 stable@vger.kernel.org
From: Cristian Castellano <cristian.castellano@icloud.com>
Subject: [REGRESSION] ALSA: hda/tas2781: divide error on playback open after
 accepting V1 calibration data without CRC (Lenovo Yoga Pro 9 16IRP8)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=J/ynLQnS c=1 sm=1 tr=0 ts=6ae12348
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=eD1N5GnKAbQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VfikHhr-D2iK5rlxiJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _kV_DvKpXF5sDviRAW_RzDQte_XOXlJK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA4OSBTYWx0ZWRfX8mIicfo56THN
 TC1fWLFCUxt9ArAhnqdPBaTVT1kHyUayulxehkkotPho5UDnT7PQtJISoNAUOPzhCvpir625mg6
 HXlHgO+Jcs7uJh3As43oT7Z5ZFGTTQqP1qttJCqmtb4WFhKcFahOqOy8FUsL8FXS1zIQXkTGqE3
 e22hhIEy+9As8YvEn6140jRKV6OqhElkdXNPITGCRxOP/hWzSlPnnNi8yiERQjoi5MtCQfr1uC7
 BENSp5uEZ/VIbEm0lIgrfuFUVEjSvysl41WnRAEv0OkNqoGzoNmV0U6YZzR8WhcDlaoumHUjD7H
 Zg5L6hIAgRTmCeK/IdB3PvmDozwWzVCmYb1tX4scgtuifM/y1aKNef5lrC6mWg=
X-Proofpoint-GUID: _kV_DvKpXF5sDviRAW_RzDQte_XOXlJK
X-JNJ: AAAAAAABZWL2jN0TDSiIGK7aFBiAikdNRgN1lXTJ2r5yP2oXeuPM6WqupHe7BoFKANULQb
 m9De+7DYXC1s6fzWKFC44zcYUL1lskJaC6QRPW4ayI2OoJ04KDyBB1Z0Xs1WGKzWP5L8V3
 eEdLYmbqd1VWFPzXFGITgc1xyeLSrC9CN3fdaFg2GG0MGFvqXAfBy1OL/xE2GQG3cNi5s4
 s16YLb9FYnqoWwmo3hDsogGGF1kkLwE4r3IClzZqIsPLZnhmcZ87fFl+UfMw9JbUWQHPl4
 3EwXwC0NKIH7yvz2iimfwdpSRAJMbBnkIngDVyyRBweD3+H9+bpHLo8ykaN8AOtED4NJDB
 3H4RJaCW8j9Df5fgHK27ORC8TwwhNftXt+D6fROuB0VYNIE/O8oXGBMBXFhuBfnT52Qs0v
 ErjzXW7uOUUGtH4kb3JwDXRbn23EFvtvJGCujKrWH25HV8h1w6XPz1MjYjTS4jnLVDlzYV
 lEPN9jTkVAdNvj5DCDGwqJG6nNsL6izBuJKb30UUtyPw4upQitMrN/kHZQtiKombzgtDHb
 plYZ+Awjm9oOiCjRcUCo3Ddm1X+yrOQG7ScCWg4aPPJMKXv+8vZhLP62EqBH3dotB7aG8n
 axVRb1zUfqP5BPAlKgmpgdWvhxdgFmxg7WJF41vLlFygcPy9Pcw9p97rcPbliRY7FjKILb
 sCpYKwlXxw/UtM+9Mb1+VXKA5B/L9+IWSq56PPOTh08tqT2/gtn/T6DoYxX34Ab+oZYVq3
 zMRxhuxfJmW4F6U3t5Ka1LwiU2o7Qad9FIHUSF0/ygxA7W0Nac57+Mun8qTxUTRSfX4ezk
 61N3gJT3TFGo50owjndVt0BulBx/itbVCcV44rlZLu2fhHv7NOzlBxZUxSIlKUxpBD8n91
 lyPhvCrGCrfJpnzwpMtVXeA/mMy8tXO2cPKZTOAznn/GAJ45KFfJpFV8PIm0JnmPXTaZNH
 2n16+oDFLp4ZM/EpLYIMcVP9RBM19te+5DhQM9aXShIU8iMEoBxG5KBeXtU9hGiqmsnBzy
 SUXr/XHHJXnyUje5QZi70WTGrCP0LplDM7n7QpfNQMldqSmWHkPbg9s66Z3Nc+c/fIb+Jg
 lzc/QEHHNRVGmdA0PPVaOEgoyM0tqkioq3n2YkrDECWjJZ8mVY1fjM2e3S/LxjWUmrqOPu
 dMl6w5zDumYBnWAZhrVUYyBbTtUXQ7F5WxWB9Sul6mdwjc2c0Za4/z507HjXjRcHAgj0LU
 dfxWn7BMSp5jg0ia54VaKLnT6tajrQfQ96SSDmhmFh5iCdXmB2hswcBSc0qDPRxgDPehNL
 SS7CEG/pzPydtoxhZYHtdJ+KYZZaZSyA8gDxAfJ5KCfEHWnH2ALQCPvg==

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


