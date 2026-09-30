Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F44E2F20
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790801174; cv=none; b=R1VlB48KYL3Ao+X6t9nKrKpUWR37hQx9rYZTgjFkhgD/qfNlH6RdI8T0zuV7KExX15QQkVsV60e8XBCcRAbF5vs9LNI0lINPCarFHRwf3CFoZIrWtex0Gzo7/aQtpue67FC272Wat3MZvHrp/PsY0W+MeXkE+MEC0zecj9UjQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790801174; c=relaxed/simple;
	bh=yAQ585lNH1jUTd+5p2fTkQEVt8HCoFAfpndGNj9cD1Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvpP0A/AQ8PuJMnbYYX29pj7Yxhb9yYoVzFgx+faQxvx4Y+qbHhR7OC2rCFFRvnN7Ud/9QQsXCPcRBUwZkQzMM96u6jg/3hf6YD+7rZWLx0NT1UrYsNbA0IB+0lozSua55qxHrJRanvrYQze/M6i2LGPsxAPI+bvnEvJ+ZYuPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=iLiMCSsK; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="iLiMCSsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1790801164; x=1791060364;
	bh=aSDMcsMjHnp3Y060QClQXCLPIrlJvpS+hNxMuOnsPAU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iLiMCSsK3aewrZAjppgmGDO5pS6RNWMdT3pgSDNdPSQzdtgLjxPLDlMVKue0HylWA
	 TnpLI6+p4NZ/B9QVtUlXE/7G3iKvY1DPJxOSyfOtz5MyYzCFSidvKmrwMO1XRlDp7Z
	 ksme/WRRBmVfeat8UMHOmDWGemr3uQtrOiJBngUCxteEVs4E9HJtt8bW0Tc4aUF5Xx
	 lVWnAS61haG7bXsrygubRAqq5nfVMqQxpzPJLTjUWhDvP+t5mg670Qn6Yrq0YsaVVd
	 WypSvWmyRSVWb4iaC/3NDen0hH4qM0HnqxuOeQN7Cj3OKUyzBy4aESagFgifsqAKNa
	 VeIsUsOoZscYA==
Date: Wed, 30 Sep 2026 20:46:01 +0000
To: Thorsten Leemhuis <regressions@leemhuis.info>
From: Mike Karcic <mikekarcic@protonmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Kailang <kailang@realtek.com>, Sean Rhodes <sean@starlabs.systems>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e) -- 6.12.73 to 6.12.85
Message-ID: <Ec4j0RfeT26a8BoOVxaZhKI1UKjRqEeSHl-MuYi9vXNaYXf1-ZbF693NaGdqetY65BTbhYXjfPJbWco8JUOcMOF5InHN84Ag__OKGT2bHzw=@protonmail.com>
In-Reply-To: <edadb400-b2b0-469c-9aeb-9ae82dee13fd@leemhuis.info>
References: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com> <87mrxjsk52.wl-tiwai@suse.de> <bibLdgyll9YOEDANdCBy8WOqeOeJry1SnahLR-EhoGkttJ6BE2srDZ9jv0gjkt0bA19aKivruQs3nkMQWbdEXPaOrLT80xjzF4KJvDcB-IU=@protonmail.com> <87cxyfs2vm.wl-tiwai@suse.de> <833d600fdebd4aaeab6706185ce854e6@realtek.com> <87wlwgygyf.wl-tiwai@suse.de> <330931ee49624f2486f66e510271d80a@realtek.com> <87jysdv4qg.wl-tiwai@suse.de> <edadb400-b2b0-469c-9aeb-9ae82dee13fd@leemhuis.info>
Feedback-ID: 22946815:user:proton
X-Pm-Message-ID: ba1b525957c451503807398badc9c966771dc362
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bringing this back with two new data points from the same unit
(ThinkPad X1 Carbon Gen 12, machine type 21KC / 21KCCTO1WW, ALC287,
SSID 17aa:231e, BIOS N3YET85W (1.50)).

1. Windows: I installed Windows 11 on this laptop with Lenovo's Realtek
audio driver (6.0.9788.1, from Lenovo's driver pack) and used it for a
few hours without the chirp ever reproducing. As soon as I switched
back to Fedora/Aurora, it chirped again right away.

2. Linux: on a stock Fedora/Aurora 44 kernel (7.1.8-200.fc44), I wrote
the old en_coefs values once after boot, i.e. these writes to the
vendor widget 0x20 (sent through /dev/snd/hwC0D0; equivalent hda-verb
commands shown):

hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x24
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF  0x0013
hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x25
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF  0x0000
hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x26
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF  0xc203
hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x28
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF  0x0084
hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x29
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF  0xb023

After that the chirp no longer occurs. I now run this from a systemd
oneshot service at boot, and the chirp stays away across reboots. I
have not yet checked suspend/resume.

Happy to test anything else.

Thanks,
Mike

Sent with Proton Mail secure email.

On Monday, July 6th, 2026 at 6:58 AM, Thorsten Leemhuis <regressions@leemhu=
is.info> wrote:

> On 6/5/26 09:14, Takashi Iwai wrote:
> > On Fri, 05 Jun 2026 09:02:29 +0200,
> > Kailang wrote:
> >> Yes, it's the same codec and SSID. It's the same model of machine.
> > Hrm, and still they show different behavior?  That's tough.
>=20
> TWIMC: I have this on the list of regressions I track, but seems things
> stalled -- and at the same time it's a tricky situation where fixing
> this regressions would cause another regression. Which is why I'll stop
> tracking this, unless this reminder bringt this thread back to life someh=
ow.
>=20
> Ciao, Thorsten
>=20
> >> -----Original Message-----
> >> From: Takashi Iwai <tiwai@suse.de>
> >> Sent: Wednesday, June 3, 2026 1:45 AM
> >> To: Kailang <kailang@realtek.com>
> >> Cc: Takashi Iwai <tiwai@suse.de>; Mike Karcic <mikekarcic@protonmail.c=
om>; Sean Rhodes <sean@starlabs.systems>; stable@vger.kernel.org; regressio=
ns@lists.linux.dev; linux-sound@vger.kernel.org; linux-kernel@vger.kernel.o=
rg
> >> Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17a=
a:231e) -- 6.12.73 to 6.12.85
> >>
> >>
> >> External mail : This email originated from outside the organization. D=
o not reply, click links, or open attachments unless you recognize the send=
er and know the content is safe.
> >>
> >>
> >>
> >> On Tue, 02 Jun 2026 08:14:14 +0200,
> >> Kailang wrote:
> >>>
> >>>
> >>> There were the same SSID for two different symptoms.
> >>> But this project was from 2025. This machine maybe didn't in our site=
.
> >>
> >> Aha, that can explain the difference of the behavior, then.
> >> Do both of them have the same codec ID and SSID, too?
> >>
> >>
> >> Takashi
> >>
> >>>
> >>> -----Original Message-----
> >>> From: Takashi Iwai <tiwai@suse.de>
> >>> Sent: Friday, May 29, 2026 4:20 AM
> >>> To: Mike Karcic <mikekarcic@protonmail.com>
> >>> Cc: Kailang <kailang@realtek.com>; Takashi Iwai <tiwai@suse.de>; Sean
> >>> Rhodes <sean@starlabs.systems>; stable@vger.kernel.org;
> >>> regressions@lists.linux.dev; linux-sound@vger.kernel.org;
> >>> linux-kernel@vger.kernel.org
> >>> Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287
> >>> (17aa:231e) -- 6.12.73 to 6.12.85
> >>>
> >>>
> >>> External mail : This email originated from outside the organization. =
Do not reply, click links, or open attachments unless you recognize the sen=
der and know the content is safe.
> >>>
> >>>
> >>>
> >>> On Thu, 28 May 2026 20:27:30 +0200,
> >>> Mike Karcic wrote:
> >>>>
> >>>> Yes, I can confirm the patched kernel is running, and commenting out=
 that line fixes the problem completely.
> >>>>
> >>>> Below is output with the added debug lines as requested:
> >>>>
> >>>> $ uname -r
> >>>> 6.12.90-debug-no-discoefs
> >>>>
> >>>> $ sudo dmesg | grep -i "alc287_alc1318"
> >>>> [  453.823528] snd_hda_codec_realtek ehdaudio0D0:
> >>>> alc287_alc1318_playback_pcm_hook called action=3D0 [  453.871577]
> >>>> snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook
> >>>> called action=3D1 [  459.605379] snd_hda_codec_realtek ehdaudio0D0:
> >>>> alc287_alc1318_playback_pcm_hook called action=3D2 [  459.605497]
> >>>> snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook
> >>>> called action=3D3
> >>>>
> >>>> $ grep -n -A5 -B2 "alc_process_coef_fw.*dis_coefs" sound/pci/hda/pat=
ch_realtek.c
> >>>> 7918-           return;
> >>>> 7919-   alc_update_coef_idx(codec, 0x10, 1<<11, 1<<11);
> >>>> 7920:   /* alc_process_coef_fw(codec, dis_coefs); */ /* commented ou=
t for testing */
> >>>> 7921-   alc_process_coef_fw(codec, coefs);
> >>>> 7922-   spec->power_hook =3D alc287_s4_power_gpio3_default;
> >>>> 7923-   spec->gen.pcm_playback_hook =3D alc287_alc1318_playback_pcm_=
hook;
> >>>> 7924-}
> >>>
> >>> Hm, then the previous fix doesn't seem working, obviously.
> >>> Kailang, could you check this in your side?
> >>>
> >>> Maybe we should apply the AMP-silence-detection disablement condition=
ally to certain models?
> >>>
> >>>
> >>> thanks,
> >>>
> >>> Takashi
> >>>
> >>>>
> >>>>
> >>>>
> >>>> Sent with Proton Mail secure email.
> >>>>
> >>>> On Thursday, May 28th, 2026 at 10:07 AM, Takashi Iwai <tiwai@suse.de=
> wrote:
> >>>>
> >>>>> On Thu, 28 May 2026 15:38:54 +0200, Mike Karcic wrote:
> >>>>>>
> >>>>>> I did test 46c862f5419e on 6.12.90. Chirp still present.
> >>>>>>
> >>>>>> I'm also on a ThinkPad X1 Carbon Gen 12 with ALC287 (17aa:231e),
> >>>>>> same as the original reporter. The fix resolved it for them but
> >>>>>> not for me.
> >>>>>>
> >>>>>> Only a full revert of 630fbc6e870e resolves the issue.
> >>>>>>
> >>>>>> Verification on the running kernel:
> >>>>>>
> >>>>>>   $ grep -c "dis_coefs" sound/pci/hda/patch_realtek.c
> >>>>>>   2
> >>>>>>
> >>>>>>   $ grep -c "en_coefs" sound/pci/hda/patch_realtek.c
> >>>>>>   0
> >>>>>>
> >>>>>>   $ sed -n '/alc287_alc1318_playback_pcm_hook/,/^}/p' sound/pci/hd=
a/patch_realtek.c
> >>>>>>   static void alc287_alc1318_playback_pcm_hook(struct hda_pcm_stre=
am *hinfo,
> >>>>>>                                      struct hda_codec *codec,
> >>>>>>                                      struct snd_pcm_substream *sub=
stream,
> >>>>>>                                      int action)
> >>>>>>   {
> >>>>>>           switch (action) {
> >>>>>>           case HDA_GEN_PCM_ACT_OPEN:
> >>>>>>                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x954f);
> >>>>>>                   break;
> >>>>>>           case HDA_GEN_PCM_ACT_CLOSE:
> >>>>>>                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x554f);
> >>>>>>                   break;
> >>>>>>           }
> >>>>>>   }
> >>>>>>
> >>>>>> Happy to test further patches.
> >>>>>
> >>>>> Just to be sure, could you verify that you've tested really the
> >>>>> patched kernel, e.g. by adding a debug print, etc?
> >>>>> If yes and the problem is seen even with the patch, try to comment =
out
> >>>>>   alc_process_coef_fw(codec, dis_coefs); and confirm that this
> >>>>> fixes the problem.
> >>>>>
> >>>>>
> >>>>> Takashi
> >>>>>
> >
>=20
> 
