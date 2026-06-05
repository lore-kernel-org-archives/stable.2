Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880940242E;
	Fri,  5 Jun 2026 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642956; cv=none; b=AxpPWkefKKy+dq2waltTxVcPwEqKBhSxBY7luOms1YovhfTJ7P9ylI3lpaZq1xAH/nw2xES/d5w9F67sv0WPhR8iWNr2TF7S6lRLv9+KMW1pOjqn5yYZSCc/JUc/s2anfEcUvOnCQbbbNVPQSk9IZ/9B0qG3Z1LyCjGzHPe0Ofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642956; c=relaxed/simple;
	bh=EFGeluncc9bSfyM5uQew0OqVIBlrOBxS+F68KlRdc1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h1ZZGOyzTHeRvIWa5UpXfne/PFZHPr+2DkQ11dACNcJ3KHWJt3QgKvNdR+1EBG2bc15GYrH4tP1b3lX7uktODltOdaHGj4q9CaUKq72WFznGurlS7ZDC/MHQH3s6Bi1dDu9aK8zyWAzQSPBlJz59l4tnfzIWiZk3dgWh2iOsdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KlO3B+Vp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KlO3B+Vp"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65572TyfC1208320, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780642949; bh=3RLzl/J92jZyUCnh0oN9f4vGr8dbHrP0TQA45xxI5Hw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KlO3B+Vpp/lKIBLEvyIDDuQ23unqlcWlx4yIof8f/Ug99DDbP4UqTyBVETgyCKkq/
	 WmPgwfPJe2IeYo46zfhVwjTuoUfx8kC8GARa007asCL/qXdz4rmI/ht9WpPtEq372K
	 4YZz5LgKZuHQtsUj/oF8nxvTytw9KdRTGmdPMNnO2padUovOLZCquMvkSlhxm8G6PX
	 CNz8hUMogDjZNSVQM0VVOvJ2OJdi492jkgQI3u3HDCxAAPTI8wsDyvgA5V4+UTvvVF
	 8BXJR+zbwE7VkUVFxReJFImS4WbLuhDZiIvmFN6rody5R65HY5wwfhwIsehI3SXJMt
	 QCnhv0AXaonyg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 65572TyfC1208320
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 15:02:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 15:02:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 5 Jun 2026 15:02:29 +0800
From: Kailang <kailang@realtek.com>
To: Takashi Iwai <tiwai@suse.de>
CC: Mike Karcic <mikekarcic@protonmail.com>, Sean Rhodes
	<sean@starlabs.systems>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e)
 -- 6.12.73 to 6.12.85
Thread-Topic: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e)
 -- 6.12.73 to 6.12.85
Thread-Index: AQHc7t9eJfAz3yPaB0G+XZXqEzNDFrYqzh7QgAA9JgCABITvsA==
Date: Fri, 5 Jun 2026 07:02:29 +0000
Message-ID: <330931ee49624f2486f66e510271d80a@realtek.com>
References: <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com>
	<CABtds-3GOyBr1H=c5aFV1uzfkhO3d1NHMPuon_cWDq0V=pFwUA@mail.gmail.com>
	<wZmYozyav1sNx53nFr4ShKmcdLFVJp5bdUOJgUq1I57MX6kgyq7n8XvH-MWG9Fi4q2x4CQqjEQ3Q8ok5MClut8hNixnhVmVtXkhcOzH1sw8=@protonmail.com>
	<87eciwukvy.wl-tiwai@suse.de>
	<RfzfjlzeaeMgNNWNST_Zzx1v49rYjM63MvAV6O5_fFIoZJ73GcN69FDLJcwhJ3s6fl9TVD2l45YBh2n3hy95LM7rhLhoVt8dU9stMkuVJvE=@protonmail.com>
	<87mrxjsk52.wl-tiwai@suse.de>
	<bibLdgyll9YOEDANdCBy8WOqeOeJry1SnahLR-EhoGkttJ6BE2srDZ9jv0gjkt0bA19aKivruQs3nkMQWbdEXPaOrLT80xjzF4KJvDcB-IU=@protonmail.com>
	<87cxyfs2vm.wl-tiwai@suse.de>	<833d600fdebd4aaeab6706185ce854e6@realtek.com>
 <87wlwgygyf.wl-tiwai@suse.de>
In-Reply-To: <87wlwgygyf.wl-tiwai@suse.de>
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


Yes, it's the same codec and SSID. It's the same model of machine.

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Wednesday, June 3, 2026 1:45 AM
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>; Mike Karcic <mikekarcic@protonmail.com>; =
Sean Rhodes <sean@starlabs.systems>; stable@vger.kernel.org; regressions@li=
sts.linux.dev; linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231=
e) -- 6.12.73 to 6.12.85


External mail : This email originated from outside the organization. Do not=
 reply, click links, or open attachments unless you recognize the sender an=
d know the content is safe.



On Tue, 02 Jun 2026 08:14:14 +0200,
Kailang wrote:
>
>
> There were the same SSID for two different symptoms.
> But this project was from 2025. This machine maybe didn't in our site.

Aha, that can explain the difference of the behavior, then.
Do both of them have the same codec ID and SSID, too?


Takashi

>
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Friday, May 29, 2026 4:20 AM
> To: Mike Karcic <mikekarcic@protonmail.com>
> Cc: Kailang <kailang@realtek.com>; Takashi Iwai <tiwai@suse.de>; Sean=20
> Rhodes <sean@starlabs.systems>; stable@vger.kernel.org;=20
> regressions@lists.linux.dev; linux-sound@vger.kernel.org;=20
> linux-kernel@vger.kernel.org
> Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287=20
> (17aa:231e) -- 6.12.73 to 6.12.85
>
>
> External mail : This email originated from outside the organization. Do n=
ot reply, click links, or open attachments unless you recognize the sender =
and know the content is safe.
>
>
>
> On Thu, 28 May 2026 20:27:30 +0200,
> Mike Karcic wrote:
> >
> > Yes, I can confirm the patched kernel is running, and commenting out th=
at line fixes the problem completely.
> >
> > Below is output with the added debug lines as requested:
> >
> > $ uname -r
> > 6.12.90-debug-no-discoefs
> >
> > $ sudo dmesg | grep -i "alc287_alc1318"
> > [  453.823528] snd_hda_codec_realtek ehdaudio0D0:
> > alc287_alc1318_playback_pcm_hook called action=3D0 [  453.871577]=20
> > snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook=20
> > called action=3D1 [  459.605379] snd_hda_codec_realtek ehdaudio0D0:
> > alc287_alc1318_playback_pcm_hook called action=3D2 [  459.605497]=20
> > snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook=20
> > called action=3D3
> >
> > $ grep -n -A5 -B2 "alc_process_coef_fw.*dis_coefs" sound/pci/hda/patch_=
realtek.c
> > 7918-           return;
> > 7919-   alc_update_coef_idx(codec, 0x10, 1<<11, 1<<11);
> > 7920:   /* alc_process_coef_fw(codec, dis_coefs); */ /* commented out f=
or testing */
> > 7921-   alc_process_coef_fw(codec, coefs);
> > 7922-   spec->power_hook =3D alc287_s4_power_gpio3_default;
> > 7923-   spec->gen.pcm_playback_hook =3D alc287_alc1318_playback_pcm_hoo=
k;
> > 7924-}
>
> Hm, then the previous fix doesn't seem working, obviously.
> Kailang, could you check this in your side?
>
> Maybe we should apply the AMP-silence-detection disablement conditionally=
 to certain models?
>
>
> thanks,
>
> Takashi
>
> >
> >
> >
> > Sent with Proton Mail secure email.
> >
> > On Thursday, May 28th, 2026 at 10:07 AM, Takashi Iwai <tiwai@suse.de> w=
rote:
> >
> > > On Thu, 28 May 2026 15:38:54 +0200, Mike Karcic wrote:
> > > >
> > > > I did test 46c862f5419e on 6.12.90. Chirp still present.
> > > >
> > > > I'm also on a ThinkPad X1 Carbon Gen 12 with ALC287 (17aa:231e),=20
> > > > same as the original reporter. The fix resolved it for them but=20
> > > > not for me.
> > > >
> > > > Only a full revert of 630fbc6e870e resolves the issue.
> > > >
> > > > Verification on the running kernel:
> > > >
> > > >   $ grep -c "dis_coefs" sound/pci/hda/patch_realtek.c
> > > >   2
> > > >
> > > >   $ grep -c "en_coefs" sound/pci/hda/patch_realtek.c
> > > >   0
> > > >
> > > >   $ sed -n '/alc287_alc1318_playback_pcm_hook/,/^}/p' sound/pci/hda=
/patch_realtek.c
> > > >   static void alc287_alc1318_playback_pcm_hook(struct hda_pcm_strea=
m *hinfo,
> > > >                                      struct hda_codec *codec,
> > > >                                      struct snd_pcm_substream *subs=
tream,
> > > >                                      int action)
> > > >   {
> > > >           switch (action) {
> > > >           case HDA_GEN_PCM_ACT_OPEN:
> > > >                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x954f);
> > > >                   break;
> > > >           case HDA_GEN_PCM_ACT_CLOSE:
> > > >                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x554f);
> > > >                   break;
> > > >           }
> > > >   }
> > > >
> > > > Happy to test further patches.
> > >
> > > Just to be sure, could you verify that you've tested really the=20
> > > patched kernel, e.g. by adding a debug print, etc?
> > > If yes and the problem is seen even with the patch, try to comment ou=
t
> > >   alc_process_coef_fw(codec, dis_coefs); and confirm that this=20
> > > fixes the problem.
> > >
> > >
> > > Takashi
> > >
