Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911251357E
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691870; cv=none; b=qqX6t7f1vn6m1jmJWSl34MR2U6rC45DmztQTkZESV0k2Yu2Sud5kWRoUSNSlbQRXmk+UnmhNiMQnEmukbGGWfRB+pfq+EzOg8ffq50fVmrxPL4/eGLL4QLAdieGsoffFQs7MelY9+f+UEkum7JrBsj+zL8xmh4rz6WvuDaDHR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691870; c=relaxed/simple;
	bh=uHpZL76WzFAlN9omYfUfgHBK04zz9UiXwnngsyjxnx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLXkV/4/nAA6pgx3kZhayvEI+legQlK/EauyhNjqY864wO0rHz6JhVQLGfFe7dURibjJks2WWOuQO4t9/yX/tLpxC42iOJLUeyVB6aw7BCg+JO2KReyY+jwX0dJX4b8Eybhcs0KxAGSLTiRh2UQ+eILN+ATdkF03abX1lbcwnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9mxQrwi; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9mxQrwi"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af7721e4aso608068666b.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790691865; x=1791296665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fJazDxMkWono34PQyfbuzm+nlBT/z7JfOyFwMEhNk2s=;
        b=a9mxQrwiHo1aKTDzLDFfL7c61Fz0V+o1ijM7J2Wf2b0yAYzbFtGUts/igqJZMPj/Sp
         DpvPD+vHvYRBbwjF6GSYD2htqu4ztracEXYcv9zcIPZ+m0ocRvtbSJ40vhJ9s1wImhhL
         Xoj548dadnJitJy3bcAUMUw3mxZ6pub4Y4as/jAM+fxUn9zh9ntoxyn3prZKCM7WXRev
         1jhS26GJGBsq30Ncip+yu96u1blj9JtLlbCH0cQNSW2GoEY7Or7ktRDxvcMgVpB6n8Gw
         +k9dnSDRVaZ210IXhQW/KFnUydb2Qfzks6KbEcD+1SchukivAFlIQohRGkUWhtrVgDuc
         5v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790691865; x=1791296665;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fJazDxMkWono34PQyfbuzm+nlBT/z7JfOyFwMEhNk2s=;
        b=mXWCuVLTp8bccYLbsGqEocWbczjGG4319XLSafFKl1291Wj8My77yyGF9/qNGMUA2l
         s6C2ZsNSD3GKBCUAYgAWcXKygwFZljufQIJpGLLVdp6MATrEygiwXQ8ohd52pHG4Fw5M
         pNYsvIqCSo9Mp1YZifgsy9aJ2mSfCY1/p9e1vvxE0/sns0S6LC3VQhIjwwLUYfu3DsyA
         g7WKrXffwo28A/Iu7MG043pg55s04m/FT2kZLL8ePkgShHDQ+OuukfFzMxTCr53zH3NZ
         tY3FBr/9mHXYtVgf2/yjiRawumZSjSNMGB4Mis+o1g2miv8f3ardDMaIBPIvh/Zmggpp
         rVJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwznzMXC65cxwNcMW0FoJTxkfCayzKLATJVRspa7vAWiq0GPjsuJrjLjqe25ZzAwK6MGe3RgBw=@vger.kernel.org
X-Gm-Message-State: AFuF++mzmdfke9AE8BWcxKTL005JvwGJs5VRwXnuZEyvXJMm2+MQUIiz
	eDg2qD86z9Xvim5Qv8eYxbwOu57y//5LFAlZoIlh9Wrn3N+/j/3jmWPc
X-Gm-Gg: AYBFou1F11IiS66e7L+yX3ewkYaT1n3QQSYfd+PHivz50EtDcZdQ1dZYL2hS/8K1SwV
	PIBqlWKm1hbqi2fNMsIjWx5qwFC/Yv2oYby0cn7aJL8eo3KgdNgL5Oc2/vAoYb9idbfCURSU1hx
	WYxvbxpNgfj2WO+JMRcbsOO6PwnY3CxSEYJAOfq/Yw/vzRp/0pzW8FgTSCwSrV0FPIH0pkW65ZB
	ZV57EzrNuTZaDIGyZM3HGqar4otHQ+UBAvGqNi4V2zA25FZkCxPtioTyXB/Q8arSZXPMGalXlA2
	lbsi/ZDr+WJxJTA6P90O+JyR+gJbBDf9QcMjX3gtrtCkeZ8hqYFJQd4ztALbOr472WZOjty5HrI
	MbmK9nxZAF2By1iD90efm7x9oVomyRDFM4ehQ02d5NTwT9cKJQQbwNvV5oWcQ5TesdIkzHbn0K1
	Uw2RMD9apsjU4aiB8+ShJ0sz9SbmxAqbX2n3Wqa5vF34ZZ3crfXUvpIf9ARtL8zNrkKqYuJQmKt
	zQfZgyzOp69PEAfnBTq5rBMPHX8WSlqv271YOtHeOBi6ANvIP4G0dFprAddirD/wuKnizPjHsvn
	ZJkuONQPN/ueBNEBU2IcqQ2re2Rc9y0VSDkTgv+WXUkLU0jIiB/L
X-Received: by 2002:a17:907:e149:b0:c2a:fcb7:62f2 with SMTP id a640c23a62f3a-c2afcb76e12mr569341466b.19.1790691865370;
        Tue, 29 Sep 2026 07:24:25 -0700 (PDT)
Received: from [192.168.0.46] ([63.135.75.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bcacfsm453243466b.74.2026.09.29.07.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 07:24:25 -0700 (PDT)
Message-ID: <0e1a1284-7069-4c46-9f35-57c10c129883@gmail.com>
Date: Tue, 29 Sep 2026 15:24:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires
 quirk
To: Takashi Iwai <tiwai@suse.de>, Faaris Ansari <faarisansari@googlemail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-sound@vger.kernel.org,
 =?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com>
 <2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org>
 <CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com>
 <2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org>
 <ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com>
 <2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org>
 <87tsn838gk.wl-tiwai@suse.de> <87mrt01bdg.wl-tiwai@suse.de>
 <87ecec19pa.wl-tiwai@suse.de>
Content-Language: en-US
From: Faaris Ansari <faaris.ansari@gmail.com>
In-Reply-To: <87ecec19pa.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Takashi and Sasha,


> Faaris, please let us know if this (or previous) one actually works
> for you.  Once after confirmation, I'll submit the proper patch for
> upstream.

I tested your latest patch where you removed the quirk for the iD14 
alone, and instead set it for all Audient devices.

I can confirm that this has indeed fixed the problem, and I can now 
correctly control my hardware volume without problems, thank you!


> ... or if you have a chance to test Christian's patch set and verify
> whether the problem is fixed there, we can avoid other changes:
>    https://lore.kernel.org/20260919151840.24371-1-arc@gmx.li
I tested Christian's patch alone, without any other changes. The problem 
still occurred with those patches.

This was also noted by Christian:

> As a matter of fact, I made a similar
> observation to yours when testing the patch set on the 'sound' kernel tree
> and the (very sporadic) issue did not disappear after applying the
> patches.
And further discussion below:

https://lore.kernel.org/all/CANBVYRAr8iFGFDgdTcDXuQyXt5M4TddZetsG9o1wbFao03R0yw@mail.gmail.com/


However, using both patches together (as well as a small patch for 
alsa-ucm-conf) has made my interface work very well - I'm very happy 
with these changes :)


Thank you for your work, Sasha, Takashi, and Christian,

Faaris


On 29/09/2026 14:14, Takashi Iwai wrote:
> On Tue, 29 Sep 2026 14:38:03 +0200,
> Takashi Iwai wrote:
>> On Tue, 29 Sep 2026 07:58:03 +0200,
>> Takashi Iwai wrote:
>>> On Tue, 29 Sep 2026 00:39:05 +0200,
>>> Sasha Levin wrote:
>>>>> [   80.940668] usb 3-1: cannot set ctl value: req = 0x1, wValue = 0x203,
>>>>> wIndex = 0xa00, type = 4, data = 0x0/0x81
>>>> [...]
>>>>> numid=4,iface=MIXER,name='EVO4  Playback Volume'
>>>>>     ; type=INTEGER,access=rw---R--,values=4,min=0,max=254,step=0
>>>>>     : values=182,182,0,0
>>>> Thanks, that narrows it down.
>>>>
>>>> Every failure is SET_CUR of the Volume control on feature unit 10, channel 3
>>>> (wValue 0x0203, wIndex 0x0a00). That unit is 'EVO4  Playback Volume' and
>>>> advertises read/write volume on all four channels. mixer_ctl_feature_put()
>>>> writes channels 1 and 2, then returns the channel 3 error, so the hardware
>>>> volume changes while userspace is told the write failed and adds software
>>>> attenuation on top. Faaris sees the same on 7.3-rc5, so this is a mainline
>>>> regression from 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write errors in
>>>> generic mixer put callbacks").
>>> Right.  So a simple fix would be to just to set the IGNORE_CTL_ERROR
>>> quirk flag like below.  One of iD14 models has already this flag, so
>>> it might be safer to set to all Audient devices.
>> ... and below is such a version to cover all Audient devices:
>>
>> Faaris, please let us know if this (or previous) one actually works
>> for you.  Once after confirmation, I'll submit the proper patch for
>> upstream.
> ... or if you have a chance to test Christian's patch set and verify
> whether the problem is fixed there, we can avoid other changes:
>    https://lore.kernel.org/20260919151840.24371-1-arc@gmx.li
>
>
> Takashi
