Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793570905;
	b=U/cgD8RJGq9BzxjE63gSmfpM14eJ91AeK7PEyWt/KTQl/VJ3q8Dy3h2LVWEh2zb1vDpE
	 I3DxWu8/Sogh3ePf4skpB3a4CxSd8LIE/wwVmykI70jw4l5dONJB4gH+9jDhfh+uBJfs/
	 z5FBVRnySIdufsboQKJ6gSy3SoXziM0EKxHVrvaxWHf+phTkO/4Xy3bPataatXBRyJ35j
	 UmiCQNpQ4x3bm1LCBvZnykUAw3AL2+fIfQ63kUJQWDJoTKHIzSAa/VvvtTdQVJWbjHWEz
	 awNgtY8CAjEx0fUAeHspXhQ1w/71hRXYsbbuVE08kRuVtbR4UUsniBrIfb84CUMemyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793570905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ke4KbqwqCKYn0fEw5PERuGTENoYwaxYdM1DbUs2Fopc=;
	b=4leCE0TrXYaHW0gKVtMH5meLbcrigzlPvyzMk211VKY5B6EAv5SUoW36vSV7XWMSLLWS
	 8ZSpbwk+lLU46s0CbltbhSbOH03jvZcGRDNk0GGX33k3e66trjxqD/afTGqjit8s28/GA
	 73WT9/iO6jyKXAvP5mjYBIv8t3mK7JovrNkKjcU9giiZK6DUWiXPEMucyZ6pU6PuIZc31
	 D7cIXWs/chxUoVpILv4pJAWkphjWXA2zUsuxzQfBtFthuwT98oFmLDOvd1tT2pQo/r372
	 XeVCi3QgAm7ynAyA6zkOFTTSvLPwfWdEkTEVG3bbWpnzlCOs1aTrar6QS0Zm1By9PPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Edoun3lc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE7606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 22:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ADE7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Edoun3lc
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a60f90a924so724273b3a.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 14:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793570904; cv=none;
        d=google.com; s=arc-20260327;
        b=itCzGINhw4X+6m05ybaVnM6r5CX+jOX8n6dbkPZED8AtX2bWe1d2983slB3GSeb0Sc
         NdGf2w7+PUMi/He64BHrqm+RMKNVDH4sNI9ghX+Q7jKhCGd21gSBPACfTai4QoyQfHnP
         YdZXDU4msOQa+Z2WXe7ndAI1z0Pl9K+ieX7X6J/ApztueTJUOUTCyMjaJUQ9+Pxz3uY8
         NsPik2g0BXVPe/BNXgHzAd3B8X/0w3DYZQHQDUKPsmQ1hrszpRHpRJFk2cIezwTDj6/E
         5l/alSvjZT8Pflznm48byB9G0iinxjz5ONZq5x9Fx5xoFW63r9mW51PbOnUjBxLjUbOE
         nNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ke4KbqwqCKYn0fEw5PERuGTENoYwaxYdM1DbUs2Fopc=;
        fh=u70bgf8OKHh+LTVa5K7XokHvNF+8Y66iutJ1H+n7fXE=;
        b=XuKqzAE12uayz/T1/l1TKBYPFnSdZDLkiGUhr6qN2TCrWm+JATX4yETmYPH7lTgKV3
         jJPWnmOSIPBPPwREwhtt8Dh+zbomRdNwGzonfxx5NIKekeQG2dMaQwbLb+wVt3pukqs3
         Tzibez2/93CS4UfLPd5/AWft1RdshN8+GEcCePNqCI8V8rw5HPm8aawSl+dVi311W+yx
         k6KrlAUAeSeHejtOaFr793jd02doUnF/PY5EtRjPchZFEW6CdMtMct4n5QPgICTtsEu6
         6l3g3ZgwjnPPjC+jf1CYfQ/A0/CTCzTmDyWE/+oLhHXeYeeU+Oic34ZZvab73DBdQtfT
         GbOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793570904; x=1794175704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ke4KbqwqCKYn0fEw5PERuGTENoYwaxYdM1DbUs2Fopc=;
        b=Edoun3lc41UYZtcPN2YtEdQOXNgQvW6Y/sz9dZRx4YRMYUgYd0/T1wWoRsJao0oBAA
         5eqh06VLdtAKF8xyLO+fyE0Z4JQTDt8T7zjIbQewXTC3YPS1/8vaEttmr8U7yHqq77KD
         6bkEF6ZPyKXWbbkdNs8Ow70qA2rxuSEVD5pkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793570904; x=1794175704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke4KbqwqCKYn0fEw5PERuGTENoYwaxYdM1DbUs2Fopc=;
        b=grpkDM8YvubnqdNmWrJAiieZrVcjpoD9osakO0kHwz06P47xF1a3c6nhJiSmW5nTCC
         /7v3afbS4MepiL7R7spzxG9O1p5+4a2wEYAKpw77Pn3/dZntIBqawVUAvUhTPKKESLla
         2EEM/KxCia7Xr+CAx4H9TgPADvZj6eMJck2gTPetJ2Mjlz16VXP3NI00pCo7+bxqjcC/
         HeWetsYF8AeLWMZnRi3KIfzdlLzasiTDGeUXwtARen4QXly+1kWP6GplAKuHvOVBXaEQ
         leiY4EIdmKoHq/6aUdUMcIYO8clKZF/0TyYdGOOgl3rE7B8hVzFgmKcrgfxU/klV9/1B
         u8rA==
X-Forwarded-Encrypted: i=1; AKwUvBwCXUNY6HBRbSLSC2qKyEsiOAd0JmQUdAc48pHwp8BBU4veAbUpsGzgBpYYlBa2cXsgK6vDKS4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJquS0hqd1f4W8FJOpiHOhJTIaky9iW0O9LD/bsYIrXgDeOyMZB
	KJ4f9DbJna/jbsV8ISUiHmwDNCk3SA6S2gpZFIxHrbkJXwK3ErHHjPd1zo6Bhfqbgq4gIcg2D9X
	5UH4QcXEPDLu3wJnntA1Q3Z74UthPFewnRGB6O4DUvgfcgy3KL5HAtg==
X-Gm-Gg: AYBFou3t+wUwch7sr5yFHzmiXmBGqiG6EvbO3jv7v+qH0RkyU4Vus1ZA0oWrscR5Dzx
	zn+ZReurZww5D+p1Z7vbpiZG1ar2AlahcUszOo8/aewWiadAiIW6WF7X5Jywo3uVWyYMgQcV7uB
	yLl2lCVmFPXoEm+XNS67rsfkWfPJPdxRJYuJc7/yNUmb2aQDxoCndCK3Mh5jJ2YGZwgtGUb0ZeU
	WHD925WT0e7uzcyNuGVk35rSrUwIH/iqjIyQtyVDiQ7tEaXXEe3eEaov+jEM4UGDnpnwURf8AYe
	zswtLM9MvbEBVmEHRkDFgdn9osN3n+0eclKeXBNhl3KFzVLSrh99gd1DrvJAqXRHsgo2aFTn/sl
	V7i9FXfugDudXGZ8xqZiddsKVJxpPYKBivrSaCSioECCIdqMjtAqj9mkpzKlBE4ENYNzjZGmIOw
	Zoe+nePgNOjMMcI5s=
X-Received: by 2002:a05:6a00:12d5:b0:8a0:5d8f:6675 with SMTP id
 d2e1a72fcca58-8a9bfbf4ce4mr6600642b3a.58.1793570904488; Sun, 01 Nov 2026
 14:08:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v1.r2.20261031160050-3@mojatatu.com> <179356441771.3131.1618449912961461255@kernel.org>
In-Reply-To: <179356441771.3131.1618449912961461255@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 1 Nov 2026 17:08:12 -0500
X-Gm-Features: AclHuK-rEYdLUizre6WqtVeCRp5nbMqf3uSANng7nnZL1dTrmlvsMkzmwbBVzM8
Message-ID: <CAM0EoMm+Ewhw2exfUt4LYvsFS1E_RRre9NLD0qq7uzOSxJXbQQ@mail.gmail.com>
Subject: Re: [PATCH net 3/3 repost2] net/sched: sch_teql: reject qdiscs from
 another network namespace
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shawnq1@163.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	kuba@kernel.org, pabeni@redhat.com, victor@mojatatu.com, 
	thomas.goff@boeing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 3:20=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The fix checks that a teql slave and its master are in the
>   same netns only once, in teql_qdisc_init() (net/sched/sch_teql.c:211).

Pre-existing, out of scope for this fix. We have captured it as a followup.

> - [Low] tc-testing case 124e ('Try to add teql as a child qdisc',
>   tools/testing/selftests/tc-testing/tc-tests/qdiscs/teql.json) no=E2=80=
=A6

Ok, fine i will send a v2 with a new tdc test as patch 4.

cheers,
jamal
