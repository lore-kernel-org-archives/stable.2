Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B83A6F1A;
	Mon,  6 Jul 2026 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335525; cv=none; b=cyUKX2hQA5E1Sc7FkYEniCF1JspuCvev1Q8zV9OZH4O0d1+ShT3EyVzRJ8vewz2SWvmiBmrbKtBl77jc8lfVR7Xarmr7Qu6pJ8p03w4OwrfzFTTwxHXQNzdSfXt52q9ZSZ+ZvbtQs7svEUk5JJ1+82QFkBPqJ+SEn4Tu7xiLIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335525; c=relaxed/simple;
	bh=8JOUaJa/hcgHmhbsk1hR7PAGojXlkFe6TWE2qXkJcps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJd5cmpnxkeuFK4YNLfSaNIG7yCIYE41d75ZO1GnntYG6D+dOWcXYNIXLfQzX48wHXOYKTdE/gUlAyuM16b1l/Ah+NmSEpGWTTS1kB5l+XF1mqBSpNNc3wSA26TXKGj4e3oBXF6HCJD05ol0VJT4+Jx/7S1tmgigYU65VWQ/334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=lpi98BTI; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="lpi98BTI"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gv1YJ02Jxz8F36;
	Mon,  6 Jul 2026 12:58:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783335492;
	bh=8JOUaJa/hcgHmhbsk1hR7PAGojXlkFe6TWE2qXkJcps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lpi98BTIeNCtddRtIKqYslBPst5+0PHkYA+ujiRLSn+crDuoeaFyV3zNotNUofpy2
	 2dYnPJqBkRTYWivU16jwQU3C0uy8IhFBJz/DxtvWTZ0zdmbxe3i4ZbdO09dBKcMkRO
	 AcJtOwPoqp5T11s3Icxq/hCgsf5kNGLKNAWyLDZ/LEuT882pfbNku0xLb2thLw+Kn0
	 bPMw9P3cXGVojjZjmr4ZfHSj7szX+bbyfASsrD0V8/rceUNq7D4cSImmvFNlJdjJyG
	 7dDKlMeHzABWHaVmlYbAj4uOrwv8/0sDUTU7hXTQrweC8ggZFGtlBy8F0X5vaGGEJi
	 /QTGIemoNpSWw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gv1YH6Qjyz8F2p;
	Mon,  6 Jul 2026 12:58:11 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gv1YH1hT1z8svC;
	Mon,  6 Jul 2026 12:58:10 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 0EDDD5F96B;
	Mon,  6 Jul 2026 12:58:10 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <edadb400-b2b0-469c-9aeb-9ae82dee13fd@leemhuis.info>
Date: Mon, 6 Jul 2026 12:58:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e)
 -- 6.12.73 to 6.12.85
To: Takashi Iwai <tiwai@suse.de>, Kailang <kailang@realtek.com>
Cc: Mike Karcic <mikekarcic@protonmail.com>,
 Sean Rhodes <sean@starlabs.systems>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: 
 <O6pYAi7yf23du9ivLsL0QqrnTmodj2lDTL7Wviv7I_nhjVtvllO7Y5Ban0TeTqrastb1RWhJtlkqrM3quLMWSriai-YjjGy312MTcEhxyWs=@protonmail.com>
 <CABtds-3GOyBr1H=c5aFV1uzfkhO3d1NHMPuon_cWDq0V=pFwUA@mail.gmail.com>
 <wZmYozyav1sNx53nFr4ShKmcdLFVJp5bdUOJgUq1I57MX6kgyq7n8XvH-MWG9Fi4q2x4CQqjEQ3Q8ok5MClut8hNixnhVmVtXkhcOzH1sw8=@protonmail.com>
 <87eciwukvy.wl-tiwai@suse.de>
 <RfzfjlzeaeMgNNWNST_Zzx1v49rYjM63MvAV6O5_fFIoZJ73GcN69FDLJcwhJ3s6fl9TVD2l45YBh2n3hy95LM7rhLhoVt8dU9stMkuVJvE=@protonmail.com>
 <87mrxjsk52.wl-tiwai@suse.de>
 <bibLdgyll9YOEDANdCBy8WOqeOeJry1SnahLR-EhoGkttJ6BE2srDZ9jv0gjkt0bA19aKivruQs3nkMQWbdEXPaOrLT80xjzF4KJvDcB-IU=@protonmail.com>
 <87cxyfs2vm.wl-tiwai@suse.de> <833d600fdebd4aaeab6706185ce854e6@realtek.com>
 <87wlwgygyf.wl-tiwai@suse.de> <330931ee49624f2486f66e510271d80a@realtek.com>
 <87jysdv4qg.wl-tiwai@suse.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <87jysdv4qg.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178333549067.691035.17694904032926316770@mxe9fb.netcup.net>
X-NC-CID: cQj7Pm0GrDXa6gdRfors0hb5IfwYsCQ48gm4enipgAJEAZl7t1k=

On 6/5/26 09:14, Takashi Iwai wrote:
> On Fri, 05 Jun 2026 09:02:29 +0200,
> Kailang wrote:
>> Yes, it's the same codec and SSID. It's the same model of machine.
> Hrm, and still they show different behavior?  That's tough.

TWIMC: I have this on the list of regressions I track, but seems things
stalled -- and at the same time it's a tricky situation where fixing
this regressions would cause another regression. Which is why I'll stop
tracking this, unless this reminder bringt this thread back to life somehow.

Ciao, Thorsten

>> -----Original Message-----
>> From: Takashi Iwai <tiwai@suse.de> 
>> Sent: Wednesday, June 3, 2026 1:45 AM
>> To: Kailang <kailang@realtek.com>
>> Cc: Takashi Iwai <tiwai@suse.de>; Mike Karcic <mikekarcic@protonmail.com>; Sean Rhodes <sean@starlabs.systems>; stable@vger.kernel.org; regressions@lists.linux.dev; linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 (17aa:231e) -- 6.12.73 to 6.12.85
>>
>>
>> External mail : This email originated from outside the organization. Do not reply, click links, or open attachments unless you recognize the sender and know the content is safe.
>>
>>
>>
>> On Tue, 02 Jun 2026 08:14:14 +0200,
>> Kailang wrote:
>>>
>>>
>>> There were the same SSID for two different symptoms.
>>> But this project was from 2025. This machine maybe didn't in our site.
>>
>> Aha, that can explain the difference of the behavior, then.
>> Do both of them have the same codec ID and SSID, too?
>>
>>
>> Takashi
>>
>>>
>>> -----Original Message-----
>>> From: Takashi Iwai <tiwai@suse.de>
>>> Sent: Friday, May 29, 2026 4:20 AM
>>> To: Mike Karcic <mikekarcic@protonmail.com>
>>> Cc: Kailang <kailang@realtek.com>; Takashi Iwai <tiwai@suse.de>; Sean 
>>> Rhodes <sean@starlabs.systems>; stable@vger.kernel.org; 
>>> regressions@lists.linux.dev; linux-sound@vger.kernel.org; 
>>> linux-kernel@vger.kernel.org
>>> Subject: Re: [REGRESSION] Speaker pop/chirp on Meteor Lake ALC287 
>>> (17aa:231e) -- 6.12.73 to 6.12.85
>>>
>>>
>>> External mail : This email originated from outside the organization. Do not reply, click links, or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>>
>>> On Thu, 28 May 2026 20:27:30 +0200,
>>> Mike Karcic wrote:
>>>>
>>>> Yes, I can confirm the patched kernel is running, and commenting out that line fixes the problem completely.
>>>>
>>>> Below is output with the added debug lines as requested:
>>>>
>>>> $ uname -r
>>>> 6.12.90-debug-no-discoefs
>>>>
>>>> $ sudo dmesg | grep -i "alc287_alc1318"
>>>> [  453.823528] snd_hda_codec_realtek ehdaudio0D0:
>>>> alc287_alc1318_playback_pcm_hook called action=0 [  453.871577] 
>>>> snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook 
>>>> called action=1 [  459.605379] snd_hda_codec_realtek ehdaudio0D0:
>>>> alc287_alc1318_playback_pcm_hook called action=2 [  459.605497] 
>>>> snd_hda_codec_realtek ehdaudio0D0: alc287_alc1318_playback_pcm_hook 
>>>> called action=3
>>>>
>>>> $ grep -n -A5 -B2 "alc_process_coef_fw.*dis_coefs" sound/pci/hda/patch_realtek.c
>>>> 7918-           return;
>>>> 7919-   alc_update_coef_idx(codec, 0x10, 1<<11, 1<<11);
>>>> 7920:   /* alc_process_coef_fw(codec, dis_coefs); */ /* commented out for testing */
>>>> 7921-   alc_process_coef_fw(codec, coefs);
>>>> 7922-   spec->power_hook = alc287_s4_power_gpio3_default;
>>>> 7923-   spec->gen.pcm_playback_hook = alc287_alc1318_playback_pcm_hook;
>>>> 7924-}
>>>
>>> Hm, then the previous fix doesn't seem working, obviously.
>>> Kailang, could you check this in your side?
>>>
>>> Maybe we should apply the AMP-silence-detection disablement conditionally to certain models?
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>>>
>>>>
>>>>
>>>> Sent with Proton Mail secure email.
>>>>
>>>> On Thursday, May 28th, 2026 at 10:07 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>>>
>>>>> On Thu, 28 May 2026 15:38:54 +0200, Mike Karcic wrote:
>>>>>>
>>>>>> I did test 46c862f5419e on 6.12.90. Chirp still present.
>>>>>>
>>>>>> I'm also on a ThinkPad X1 Carbon Gen 12 with ALC287 (17aa:231e), 
>>>>>> same as the original reporter. The fix resolved it for them but 
>>>>>> not for me.
>>>>>>
>>>>>> Only a full revert of 630fbc6e870e resolves the issue.
>>>>>>
>>>>>> Verification on the running kernel:
>>>>>>
>>>>>>   $ grep -c "dis_coefs" sound/pci/hda/patch_realtek.c
>>>>>>   2
>>>>>>
>>>>>>   $ grep -c "en_coefs" sound/pci/hda/patch_realtek.c
>>>>>>   0
>>>>>>
>>>>>>   $ sed -n '/alc287_alc1318_playback_pcm_hook/,/^}/p' sound/pci/hda/patch_realtek.c
>>>>>>   static void alc287_alc1318_playback_pcm_hook(struct hda_pcm_stream *hinfo,
>>>>>>                                      struct hda_codec *codec,
>>>>>>                                      struct snd_pcm_substream *substream,
>>>>>>                                      int action)
>>>>>>   {
>>>>>>           switch (action) {
>>>>>>           case HDA_GEN_PCM_ACT_OPEN:
>>>>>>                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x954f);
>>>>>>                   break;
>>>>>>           case HDA_GEN_PCM_ACT_CLOSE:
>>>>>>                   alc_write_coefex_idx(codec, 0x5a, 0x00, 0x554f);
>>>>>>                   break;
>>>>>>           }
>>>>>>   }
>>>>>>
>>>>>> Happy to test further patches.
>>>>>
>>>>> Just to be sure, could you verify that you've tested really the 
>>>>> patched kernel, e.g. by adding a debug print, etc?
>>>>> If yes and the problem is seen even with the patch, try to comment out
>>>>>   alc_process_coef_fw(codec, dis_coefs); and confirm that this 
>>>>> fixes the problem.
>>>>>
>>>>>
>>>>> Takashi
>>>>>
> 

