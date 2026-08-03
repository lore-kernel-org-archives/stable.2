Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14133128B6
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 05:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735854; cv=none; b=Qm0VSRWfAmQgiVlBQTCSm3sNDCdv9k+unD8wcPI9Hhj1Jawajaefy3PJ8rKt5OROzwZmg3wN1GQStaPB6HyyixxQNM/6SE6DLioY/PXifDXC0EAt+enSEXF9+y5Pkum4a3/z7M2ejZEVlTNc+GfHD3BfOK7uXH4WqYssfUPqqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735854; c=relaxed/simple;
	bh=yjB7RGHZWNCfModfSNNs6/sJuqTLBvL7I9fkLDpx6ag=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rpih4c48rYfF3dXp3tYqyhukRtZLyoesO7EcgVa4iSmcBUu7OmiqVQCbJErVxg1HVW/Nb0ZvjFFkkApODboHarBC6sYs931zeCPaQ6rM5svaFTfkHkujkEeBPlUZ05b5gk4oqUC5Buh0K/mtMbWgkgVgC4EGbvYoOlav0b/+DXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PnWhTstw; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PnWhTstw"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-ca12086c06eso2351175a12.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 22:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785735852; x=1786340652;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=df1R3651GFZlufP+Sp9/jqANKcFbF/GkeE2awbI5Hgs=;
        b=ESVj30gL44oQWWtu0PQuXqMDCMrBlI1e7jJqFhMOSkFmePuzlXE6VX/yN6WVEFwDjq
         X94UhhVQBY/eXPJSZHpHD/rCufqJ7h34ZAdW78cESJyxQb5TPRGgY70v6fSrVxwLbxAA
         gKiytLIXEBWkT+KJHRZziUfz5ovE5rs9DJCvlj+PWAQwzdFoc+auvAPzD7cRlPuIlu0Y
         R79WfGyDkjE1R5FHqymQsVw7dWKMTK96RJSFgktXgVoy5MtkzaiCvUp8Oz1Q3hdyfuT0
         SQHe4Z41/1bCdVYY+GUUTmStnhUD0i+eC2Y2lrvjkxSpzA9lT9fKQ57odv1+sDvVQmc6
         qXVg==
X-Forwarded-Encrypted: i=1; AHgh+RpcsN8DGUXK2v1GaMVC8PLCiuse5BcDc7BqAMOFFYhZKNVQZRcnRvpkRJhyRwEdX1DUFcKsWxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjs9kb1FixLp4yxK1pawJSsG6o3w3/t78MVxFccNkjL9a7Onm
	wAdNsQ5+TJ3hRqqY0aeleS4SEbEoqhEAtdnk6z+auE2VLCgBuTS19Cvkji8ERuAYcRSHk3xzNuX
	7DYY7Js5pALbHcV5TQ4VsAKwPqKXOMti9lT4dLHCvu8KylbDMf+iumVzHPgQ4Q8a76BOhFfxxNl
	BPxa39wcQS7b09L8Vw/8t7C1R87WI0g7VevoNNR/Qfr6J9HK/orJ/pSEkbCn8DoEtNiJ+1B2iWa
	m8cFxLVJOZfx0qM+Q==
X-Gm-Gg: AR+sD11z/NrVrHEovol77tNSbIw9TLfKeE3u2JSO6NmutTjzsU6zo38d3N7Z41n2qCm
	ZoAgjG3W/QA2FTZcggiwzgZiI6yCbrDG3IZneKsu5J1lpHBKDihDnfrEy9bPkfmN/bQ30FSjNw0
	+jj34IXHYtd3ZMm0dAWbXjNAUMbHfS3pgxQVt2bTJYMnWkK0D0C/G4bIgVzmXtk/p9srUndxWC3
	Xi7jnHuDrA3EEXfZYXcDjuiQmNjgWHh+e3h0c3yZiczbpjR2USw8W4pVzHO3ooigrIy2jUz2CGB
	TBBXI/SwbUgM1a8s26dRnDB2wXujAj84rdfJ/UHbyaSpfbvXhjp/YlktgEEeCDILQTvDccjA+oO
	Jow24Y2FjuZEahBGSqPPkJYemJomZ+/myVrCunDG+JK8o9Amvr/XjIHSRXLQFZWORqWHy38NgqQ
	W1jO4HmYqJJ+uUiDSLBl+ECW5wD5TuCfZRon9/J9k=
X-Received: by 2002:a05:6a21:7109:b0:3c3:856e:dccd with SMTP id adf61e73a8af0-3c92a628e22mr8244760637.23.1785735852040;
        Sun, 02 Aug 2026 22:44:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cbe39cafaa9sm703175a12.8.2026.08.02.22.44.11
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2026 22:44:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15cec1ccb6so299037366b.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 22:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785735850; x=1786340650; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=df1R3651GFZlufP+Sp9/jqANKcFbF/GkeE2awbI5Hgs=;
        b=PnWhTstwB6GTPm+7ZWf5nCyzXES3Ag+gUw4MegEjp1Pj5YESi12kdGVHFntcwU1Dmm
         NaVbyzYw3Lk5GsVjspuiiMRc+8UTxMWqdYD0VblyG+L96Y0Ol5UMsEIAtAtI4Vvfm8U2
         H+hufJ6Jyfoqs0swJTsNDjAMUo0feP3Mn7RBk=
X-Forwarded-Encrypted: i=1; AHgh+RqrTCraQrGB/fezWFogTzPH5WmTMnW+nRxdGSqv4e0eZFbu9prM3/lspGRpO+hcO70iqrnoyAQ=@vger.kernel.org
X-Received: by 2002:a17:906:f1cf:b0:c16:8931:245c with SMTP id a640c23a62f3a-c1fe81e1316mr455358966b.21.1785735849940;
        Sun, 02 Aug 2026 22:44:09 -0700 (PDT)
X-Received: by 2002:a17:906:f1cf:b0:c16:8931:245c with SMTP id a640c23a62f3a-c1fe81e1316mr455357966b.21.1785735849510;
        Sun, 02 Aug 2026 22:44:09 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4537755sm496563766b.54.2026.08.02.22.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 22:44:09 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, Abdun Nihaal <nihaal@cse.iitm.ac.in>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Date: Mon, 03 Aug 2026 07:44:08 +0200
Message-ID: <19fc626a040.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <6648c1d61a44ad732550ff20c0b1aecaa43676f6.camel@sipsolutions.net>
References: <20260722110713.115988-1-nihaal@cse.iitm.ac.in>
 <20260802083905.3819981-2-arend.vanspriel@broadcom.com>
 <e059b52701d3cad4480dfb506e61474924b9f29e.camel@sipsolutions.net>
 <6648c1d61a44ad732550ff20c0b1aecaa43676f6.camel@sipsolutions.net>
User-Agent: AquaMail/1.59.0 (build: 105900627)
Subject: Re: [PATCH] wifi: brcmfmac: Fix memory leak in brcmf_sdio_read_control()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Op 2 augustus 2026 18:44:40 schreef Johannes Berg <johannes@sipsolutions.net>:

> On Sun, 2026-08-02 at 18:41 +0200, Johannes Berg wrote:
>> On Sun, 2026-08-02 at 10:38 +0200, Arend van Spriel wrote:
>>> On Wed, 22 Jul 2026 16:37:12 +0530, Abdun Nihaal <nihaal@cse.iitm.ac.in> wrote:
>>>> The memory allocated for buf is not freed in some of the error paths in
>>>> brcmf_sdio_read_control(). Fix that by adding vfree() calls.
>>>>
>>>> Fixes: dd43a01c5cdb ("brcmfmac: use dynamically allocated control frame 
>>>> buffer")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
>>>> ---
>>>> Compile tested only. Issue found using static analysis.
>>>>
>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>
>>> To be applied to wireless tree.
>>
>> I'm going to put this into wireless-next, at this point (-rc6) this just
>> doesn't cut it, the commit message makes it sound purely theoretical.
>
> Actually, I'm not even going to do that - sprinkling vfree()s over the
> code when moving the one that exists would be sufficient is, and I'm
> being generous here, not a good change.

Sorry, Johannes

I looked at moving the vfree() to the done: label, but the code also gets 
there in the success path to wakeup waiters. In the success path the buf is 
stored for further processing so it should not be freed. Maybe better to do:

        spin_unlock_bh(&bus->rxctl_lock);
        brcmf_sdio_dcmd_resp_wake(bus);
        return;

fail:
        vfree(buf);
        /* Awake any waiters */
        brcmf_sdio_dcmd_resp_wake(bus);
}

Gr. AvS



