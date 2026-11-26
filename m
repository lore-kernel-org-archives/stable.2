Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795655133;
	b=LeJxLD5Wvy+tRdmpsxP3EJn/oymZu4o2HmOOuctCk4Jo5Z1+3royJuSPXRiJfwwryv3U
	 mBaBd4ekExvkdgvrWGwMbTu6oPakpQOCITgdgKjaYJ2KMsE5afQDiLlHeSzpfmlf4w1Lz
	 GOXliJdqcd+Gt2UylQPOIRJC1ynGNABhYMkoIg5YkEp68N3A09EDJTrJO8CHgYx6zk85/
	 KAkd0wt4kztx7gyMKiz3Zd6lm8c0KxVIq0vr/N3bKIT6AkUufqixXvzyMro8rDQfTaD8D
	 5szOSa4dUWzg9xOpo2x0tAEx1Hvyi8lMa8f0AMvOjOc6ZB22oPepFT8wFG7FJ1RxQZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oZFbZu0+kSU0ykNmAfKFLTt1Nnu3oYAy3AIE96bAt98=;
	b=Rxg0WYYzJ+QOVNyYWLFZWE4pp1aMz/XSu5wx//OmvPJCPHSygnNk4QOPaVCcCUOg0Iye
	 BpKrG/Onbutwhw5CM/aeLlwhCl5aUz/Zwag45zF6ElhneA0Ski7MWa5AHdbWa1rA/bQ4h
	 jq8qE1HPAS0dE5zv8gVzMWuMcMxY/ORhdQWFEjweDUljBcuQQLn1GdM2xRM3vCDosxlY8
	 AQyBbUpqqQK4dUDEKSXicr5i9fX9LoFYXbF0MHWTnBkBhmmg0btrD60477DK0UicNojyt
	 qrrAxf5z00fvCUVjBi92Sqn+7urhHRpS2hTHm2TfvYSJtbekhQ3l/3pOqwEc7S/tXbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cgoyLmaJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286B606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6286B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cgoyLmaJ
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-702fd86d674so4215068eaf.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:05:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795655132; cv=none;
        d=google.com; s=arc-20260327;
        b=oPF8JNZD4STJquLr0SI2snP3JySops9iTNQ4t/GooQUz6kmFtdB+WW5c9E0aqdPrzZ
         iazFNH4y/uuYXu/jTOoJUZKrTuPEGv0xuMxr12yrUsnBgyFl7U4ZsiQaPqzL21jaNI7L
         mRYNppl7P9HaFFmkn4d1s4T6+NTRHetI8AlVuOKeqbNgROX6jOdYstTux4bt42JMNb8a
         wwl0sL9mgLoGWlvuWBV7Z6kzcAHKHjEHAMPykt8VcKWPG2CljtlS+g/nlFOWiEByIyzt
         olO3g951VtMrAlPZk1sDwI3VYlamB4Zzn3DDl+yjgx7Jeisk+vDLK4dghzXA3Ausy8kg
         Lw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oZFbZu0+kSU0ykNmAfKFLTt1Nnu3oYAy3AIE96bAt98=;
        fh=ngdrjtmQrfgYwHuozChl+uo1JD+9IO9TsHxT2PWUOxs=;
        b=cROP7Bt9zGysutTstPFvu7TsjDrUaDvcRKJg1tM1NAxvfveWtspKXqfPsecx6NG62H
         QHtZHsmevmFTc6d52Wphkk+NKPtggt3mFh6utYoA4g4cBkgi3d/clatlHSCNCojErGgi
         SUMQuQ2rZqbeAUkDedDTx7XuPvkzwwqqRU+EFBJhX3MgZgYx421VFNjIopujLyfX5bpa
         P+ouX011eeHcrZdS8jWR1eymI+D66SItpTIhyMHB+hEPFa1fb9a6ThTfK1W9VEMcvSqg
         4zsZLr577WDDjUwraYu8PaMq95MZhka7cl/c1XSQSnjtNAGelftK6QI+unj2jgedr6A7
         k8Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795655132; x=1796259932; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oZFbZu0+kSU0ykNmAfKFLTt1Nnu3oYAy3AIE96bAt98=;
        b=cgoyLmaJMVDNVs+2Bkuc4Gq4+rP+DzY8TDkVwXQhjOAL+dp4qnzsQw8tWInOtDs9Mq
         UfCGt5aDesmtR99fdlhyjGFE9kcH+meWw8pUXjFyF8a1RVQj4OBSi4+qlisTXaVaqgIl
         MrliG4v4ek1mtcAZbQi/ZDUGtd/sOUBo42s/CcXIYbpBMonrrKUcXJLrTV1cUPei4yoV
         snDcKqQ1TfQK5lOBKjhZFnby1iBhoWTvyUsF9NmKO5vTZYskOK8pu1aA7GCOM5k3yfAa
         2yRXENBU1NR+BtcUWuJPXZqe/ek14dU8nj0xUic9ShVJ4x0nU3/Xr92BgafYQtw7+MG5
         XGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655132; x=1796259932;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oZFbZu0+kSU0ykNmAfKFLTt1Nnu3oYAy3AIE96bAt98=;
        b=iJtuVkwxfTh6RdRprhnsX0e2PRly9GqayMWDeGe9g49nrvsrriOQhiFGSTAXha5zuV
         whU+11n1tb1JABvpuD1Wm7cVb3SwhmRrbsL0tlGZhMDY1XEfuA9KBjVxKcBw+qQIL7uX
         Jsd//GTjAdSVzVPqTp+hS+KrSuwkxjYSMRmQQGL17Fdqr8nOrxXsv4XepXCP/iDFlURY
         TbaNC5ExGxHfD6S5FBqSlNxpR0N2jPSSyjOvZTlxe42qx7dSkH3OLxWrFirR8PI8Vapc
         NkgFKznst/h0zT3k0Lc1gMUwgWi88T6zOTWAOWlWutrcoTIlFryR116UiwT5yyTNa3ln
         b2rw==
X-Forwarded-Encrypted: i=1; AL+hErHxv7B4P/KNpyNTLsJDypbxakRje/JmdypWbaGiZA8/EXaPBILaATNEHlMCegholjopRpRODr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZPuqsZ03HB2AjHPc1SmMnVLMbukZqiWddK5YzJj0XyBBDLoil
	ez0czGNRqcb1S1S3uh62lKIbjCdo/wbyMXYcOlm5L+cC57d2MPbtv0PNi0//j0OSbB/wFnXgK3I
	gfRP0eVG+k5MRoWXQ1n6wi6sK2FW+eeI=
X-Gm-Gg: AZFdTZfVtPDrVdQh20EDq7F/Cs8nW7SXRazZUcTqlOkEigDRFtRNG0BopwSuleCWdqZ
	68Qs/1c+T/rAaQ5RpImngMEZz+ke4IT1yRmm9DXH1O+45s/c5lWZi8NFvszVymK3SualBN4aMx/
	kRmC39quwmC9/U2BZUJBNm569cAwzfT+9bpesYyBfpjn/Cc/k7IWOuzuWZtBIiI2HSCeuyOdSuW
	zx/Pv7pi4s+qDWeltbo7my+/rdFFo8aCIfygKWe86Xz7Xp3DwIAElj55VNPNQm/uLclxtL04nfl
	xeusMR+cEDdQO0GXuXjLY8njki/kej9ztLGwL2RzFlYHLlsH9ktosRuMI1BeraXrSOuscsb1t7E
	9pFAvoSy++oZt73XLhjYlcMP2WDtQ0xfq4shiZna0Sz+Wfi5QOCwdpWXcQTjNtlBZpU75G0qF4L
	BBL81HPs0Z8LZ+PA==
X-Received: by 2002:a05:6820:c5cf:10b0:71b:82fc:ad8c with SMTP id
 006d021491bc7-71b82fcb56fmr1443500eaf.44.1795655131818; Wed, 25 Nov 2026
 17:05:31 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-sp11-noturbo-v1-1-37e1083cec5b@gmail.com> <20261123-eccentric-ludicrous-roadrunner-0a7efe@sudeepholla>
In-Reply-To: <20261123-eccentric-ludicrous-roadrunner-0a7efe@sudeepholla>
From: Dale Whinham <daleyo@gmail.com>
Date: Thu, 26 Nov 2026 01:04:55 +0000
X-Gm-Features: Aa3M54oTuIZ-TKok2yilEFNywBJAakQOAVzcdKFaeMZPoEEMc6Y-VCIDW_86pZY
Message-ID: <CAFcmK8g+Udyp9h24WSEx2RepBA=rZpEQs==1hTi83A+_zF-GOw@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Don't mark OPPs as turbo without a
 sustained frequency
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Dhruva Gole <d-gole@ti.com>, 
	Haipeng Lin <jimmie.lin@gmail.com>, Charlie Garner <charlie@akao.au>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 10:26, Sudeep Holla <sudeep.holla@kernel.org> wrote:
> Charlie had posted a fix for this a while ago but never got back to my
> comments.[1]

Apologies, I hadn't seen that patch, but I'm glad you are familiar
with the issue.

> I worked out something very similar as a solution. Anyways does it work
> if we also add the check for non-zero dom->sustained_perf_level ?

Haipeng Lin has an X1P machine so hopefully he will be able to confirm
soon if adding a check for non-zero sustained_perf_level into the
chain still works.

> No need to repost if you agree, I will fix it up while applying ?

Absolutely fine with me, thank you.

Best regards,
Dale
