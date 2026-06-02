Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7B2D2382;
	Tue,  2 Jun 2026 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380862; cv=none; b=D3My+yeiwMxk42ANTJP5eCxzud/YKAnz6642clOyaNVc5vpR5DKaB2Tt4EazJ/VXm1v6eXp7omNXv4tMO02RwTz6UA8QcA9ffpmAfDI1Gfwhln1Stxlj1xxptx6mBZ2AYHxzNIWep82RHZ429e01XceR5/7RItZWjmEK9/8cYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380862; c=relaxed/simple;
	bh=ZZloKfi+BZkzFML4nwkLNn6PsJRRhLCXqfaYA3b9NT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+hBRjD4lp4N/ehgJUXoOeXwQyW+liIN5Hx6NcyeErriEr6T46eXk+W6jd4bt9mbCMDZ5XcUi/pxZ7lcTu6L/6hA/AvnpszUb8UivB43E4fPRC6iqhXgTTXSuBOUNgx5X6KDZ4b6BPBBesJUXycw5krcPmnrfoJQxAsbGNf/Gxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CKa0STd9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CKa0STd9"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6526EF4G02716836, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780380855; bh=ilJXk8Qu02sYQ2BxQLxa2OOTW7Tl/jc1dpPk5iv8ogA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CKa0STd9u6ScnEPUz8jVq0wgeAT9Mpd8kCQdFAFA+P5LdMm0aBWl1bbR4GnTL8gqU
	 2Pam4TuHemHZ+DSOQYegzXS81rbLzXlfCgZVekZyj3DiIQzFl6Eo/iDtEpDtVkDjoU
	 Qwd0sEc2YYWJiIN4DvdO/KKji+Y2wX5oiuiW+UFHWiY95tYnGakiIO/2/YkTKyI5rH
	 zFjDvQDjZVNvK/rgLG3TPLHaATDwTWu+1kO2HKEXC958tzAm/ekFr+gGLrIcBNDKCB
	 21f+UsVPm6gkPU/Pj4pI14I4MB3dy/PdO6uVPF9Obxn4TQxOQd+Wo3sMiZd4w84rJ/
	 AzwceZWJpKn9g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6526EF4G02716836
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jun 2026 14:14:15 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Jun 2026 14:14:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Jun 2026 14:14:15 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 2 Jun 2026 14:14:15 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>, Mike Karcic <mikekarcic@protonmail.com>
CC: Sean Rhodes <sean@starlabs.systems>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e)
 -- 6.12.73 to 6.12.85
Thread-Topic: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e)
 -- 6.12.73 to 6.12.85
Thread-Index: AQHc7t9eJfAz3yPaB0G+XZXqEzNDFrYqzh7Q
Date: Tue, 2 Jun 2026 06:14:14 +0000
Message-ID: <833d600fdebd4aaeab6706185ce854e6@realtek.com>
References: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com>
	<CABtds-3GOyBr1H=c5aFV1uzfkhO3d1NHMPuon_cWDq0V=pFwUA@mail.gmail.com>
	<wZmYozyav1sNx53nFr4ShKmcdLFVJp5bdUOJgUq1I57MX6kgyq7n8XvH-MWG9Fi4q2x4CQqjEQ3Q8ok5MClut8hNixnhVmVtXkhcOzH1sw8=@protonmail.com>
	<87eciwukvy.wl-tiwai@suse.de>
	<RfzfjlzeaeMgNNWNST_Zzx1v49rYjM63MvAV6O5_fFIoZJ73GcN69FDLJcwhJ3s6fl9TVD2l45YBh2n3hy95LM7rhLhoVt8dU9stMkuVJvE=@protonmail.com>
	<87mrxjsk52.wl-tiwai@suse.de>
	<bibLdgyll9YOEDANdCBy8WOqeOeJry1SnahLR-EhoGkttJ6BE2srDZ9jv0gjkt0bA19aKivruQs3nkMQWbdEXPaOrLT80xjzF4KJvDcB-IU=@protonmail.com>
 <87cxyfs2vm.wl-tiwai@suse.de>
In-Reply-To: <87cxyfs2vm.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


There were the same SSID for two different symptoms.
But this project was from 2025. This machine maybe didn't in our site.

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Friday, May 29, 2026 4:20 AM
To: Mike Karcic <mikekarcic@protonmail.com>
Cc: Kailang <kailang@realtek.com>; Takashi Iwai <tiwai@suse.de>; Sean Rhode=
s <sean@starlabs.systems>; stable@vger.kernel.org; regressions@lists.linux.=
dev; linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231=
e) -- 6.12.73 to 6.12.85


External mail : This email originated from outside the organization. Do not=
 reply, click links, or open attachments unless you recognize the sender an=
d know the content is safe.



On Thu, 28 May 2026 20:27:30 +0200,
Mike Karcic wrote:
>
> Yes, I can confirm the patched kernel is running, and commenting out that=
 line fixes the problem completely.
>
> Below is output with the added debug lines as requested:
>
> $ uname -r
> 6.12.90-debug-no-discoefs
>
> $ sudo dmesg | grep -i "alc287_alc1318"
> [  453.823528] snd_hda_codec_realtek ehdaudio0D0:=20
> alc287_alc1318_playback_pcm_hook called action=3D0 [  453.871577]=20
> snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook=20
> called action=3D1 [  459.605379] snd_hda_codec_realtek ehdaudio0D0:=20
> alc287_alc1318_playback_pcm_hook called action=3D2 [  459.605497]=20
> snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook=20
> called action=3D3
>
> $ grep -n -A5 -B2 "alc_process_coef_fw.*dis_coefs" sound/pci/hda/patch_re=
altek.c
> 7918-           return;
> 7919-   alc_update_coef_idx(codec, 0x10, 1<<11, 1<<11);
> 7920:   /* alc_process_coef_fw(codec, dis_coefs); */ /* commented out for=
 testing */
> 7921-   alc_process_coef_fw(codec, coefs);
> 7922-   spec->power_hook =3D alc287_s4_power_gpio3_default;
> 7923-   spec->gen.pcm_playback_hook =3D alc287_alc1318_playback_pcm_hook;
> 7924-}

Hm, then the previous fix doesn't seem working, obviously.
Kailang, could you check this in your side?

Maybe we should apply the AMP-silence-detection disablement conditionally t=
o certain models?


thanks,

Takashi

>
>
>
> Sent with Proton Mail secure email.
>
> On Thursday, May 28th, 2026 at 10:07 AM, Takashi Iwai <tiwai@suse.de> wro=
te:
>
> > On Thu, 28 May 2026 15:38:54 +0200,
> > Mike Karcic wrote:
> > >
> > > I did test 46c862f5419e on 6.12.90. Chirp still present.
> > >
> > > I'm also on a ThinkPad X1 Carbon Gen 12 with ALC287 (17aa:231e),=20
> > > same as the original reporter. The fix resolved it for them but=20
> > > not for me.
> > >
> > > Only a full revert of 630fbc6e870e resolves the issue.
> > >
> > > Verification on the running kernel:
> > >
> > >   $ grep -c "dis_coefs" sound/pci/hda/patch_realtek.c
> > >   2
> > >
> > >   $ grep -c "en_coefs" sound/pci/hda/patch_realtek.c
> > >   0
> > >
> > >   $ sed -n '/alc287_alc1318_playback_pcm_hook/,/^}/p' sound/pci/hda/p=
atch_realtek.c
> > >   static void alc287_alc1318_playback_pcm_hook(struct hda_pcm_stream =
*hinfo,
> > >                                      struct hda_codec *codec,
> > >                                      struct snd_pcm_substream *substr=
eam,
> > >                                      int action)
> > >   {
> > >           switch (action) {
> > >           case HDA_GEN_PCM_ACT_OPEN:
> > >                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x954f);
> > >                   break;
> > >           case HDA_GEN_PCM_ACT_CLOSE:
> > >                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x554f);
> > >                   break;
> > >           }
> > >   }
> > >
> > > Happy to test further patches.
> >
> > Just to be sure, could you verify that you've tested really the=20
> > patched kernel, e.g. by adding a debug print, etc?
> > If yes and the problem is seen even with the patch, try to comment out
> >   alc_process_coef_fw(codec, dis_coefs); and confirm that this fixes=20
> > the problem.
> >
> >
> > Takashi
> >
