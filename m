Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918008;
	b=ctXeY37+JejvaAq/iDrZNu3XjA1kQBQYre8ZSy+BuqvjYJjpZqaxqBjs1Ni0bqhd7Z8m
	 FMTrOD4DI4ql5xhGUZkd0eG2n79Z4OvU2Ojicpy71fgKMhOg3v33uIHBvgwsgiEcMijF4
	 7RdX1fW6noqVCjV6DtCmmEOx6L0DPD27q+cU2sa6ee43kurHCctz3F9nOliqdWgV7Zc+o
	 nRiu+SMmv4YCkcUFXocoLhNdkxTQYCWsenP+Thy3osQDQaznluBxQ7zAhAQUeZvefyXia
	 YJboAaido49Y4Kfk7uJViqsQYU1zXT1cs73FwG3tmlBFX6u2oLKKWoDjS0WiNOq2qKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=L5HnUNLFXRQf/6dxLPFNXYLFL4knAlxUvl8n9LuSkpg=;
	b=mf4GG8EIV3BmFEcSGvpOK0ymxN2rMMQT8Wx1QcSyrXjH1tfJ5es0e+PwUhuSRblCzY87
	 k9hZkySAye05aeseNXjCPmyfgUMiP2XWslaYvVKN1U3EIJ423XLOXWdHuC+dF70NwPVAq
	 hHhhFa6LRFjd7RIGnqIHQxJFsWMSiaoGDol6uMPPvcZhaF7WFy8WaVI/sD+S672eJzP6l
	 +HKi2Y4sRglK1bMe04cRzWtGQSnOfVWDlwVR3GJ3IFI9jn4r1s5zlP/Ae7DeJ/P8E/qcb
	 QMe9F1DPmg3HIZQT8X7YfYdjpGtQAyPi1/n5Yz7qpol+CkrsfLZlPQpky4dAzc1h0fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="CE/EP0C/";
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221F606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 08:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A221F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CE/EP0C/
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3537f63c9e6so926439eec.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792918002; x=1793522802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=L5HnUNLFXRQf/6dxLPFNXYLFL4knAlxUvl8n9LuSkpg=;
        b=CE/EP0C/9IpQBVCJ6taLKeH7aWnmy99LlpYvqDMGYLgGhGruyINltDQTUcY5NC8vwz
         YFWJNVoEj0tYA16X34ifZKEqpC71JFev+8aBw4hkNb4/tDO7ynX8ahRm9JjGE2bHyDt8
         KO1ScZMeEXoBM5NmTBVyM8QfewkDmOU0YJPAFSmSONK9RdcMAHchnT5kBm7ZF7dtsup8
         Do73CIqa+/Ib3YV2dNvsqWgdZCRn5Tn6QTGXNl5tlI1J5Nb45uanC5OPERytQIU6TPMQ
         qvUvJ2wxj9osjCxcDQjquJRRo2YFNqkg4mwKOfdkE2JJcwFb7TpzSPI993p51J+Bbim7
         csmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792918002; x=1793522802;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L5HnUNLFXRQf/6dxLPFNXYLFL4knAlxUvl8n9LuSkpg=;
        b=nd0qu8fVaKmS/XFU+N6mW/mU9WKesnOlbXRVw9d8BUEi/1jhuFWIYDUDcq4yos7Pv1
         CjCRKWVRZSica5K9qNQu54qDmhgca0vDd8pX/bvWo/HIcSqGJreqskSqAxWjdqGNQ1hL
         +/2jHI0MDTrbBFSfISFeugsWCFUo9Iv5/+u3jUSgbQbt3hV1wZmGQ16Q/dyjrm3DB5lz
         fVEhaKqBqUZ+9iwmZ0Frt14UgBJoqrXn9vGxZukuC/gpzntGeaZ17y1ufw0Szl+3wn9P
         5881cP49x5KmZ/KU96eCZKuwhk+AK1k4ey2Z6cEoXAjZeCukBYxmb0XSaXcHr/KOCPa2
         1HgQ==
X-Gm-Message-State: AFq9FYLIGebPAnm/rId9ZfykC8y8bWXcN/9saSliPQ8StawU/o+ewKZ+
	pw351e+pAAyrRqhrMwcie9HcKda/mpCNZMryOBgv6OYKE3St3M+Ll2s/
X-Gm-Gg: AYBFou3WIiJxnwbY72VDVuiQacK6uVlyr4aKH60/9bG1EV8cRpwwpM1YSvAFDs8X+OV
	yWtt2VFswHvnkErori+eWZjjx9fH7kYIlvRnMTvvvILatdxxaxNiPTMZRtud92Am/clFogmyoix
	/9Un8Q7UPYfceg32f5+Fuyb3yyGtAeOeQaWwzWuhixCeQtrRhVMA1dgLoPJEHZsthwzdrtppw4D
	jBQnh8gZX+9CWMmo6F5sfLIhsZIgxgvpcVkQhsu0O8Zs7qa1QMs3+l/9I9i1QNSFlNFb6SaO7Wl
	zVmPUDqjp0K2GPAZ++um4NZckcxZZqt3AlXXbjrh8RZbp9uqzVdZwWOot0QBvpjb9WAB/iW7j3a
	/8Mz/Bfx3uN7tPuMOwnVTtzoHNs8ThnN7wicuictFL+S7/LrX/mG8AoAaRZyVcynfwdoEj1pH1D
	6Nu66aGAdw9BoYLL3XmcIGq/22QdfsMqLUS9h/460A35MJ/WpZtEUtulnglwYJZ0KsrTAimgTJX
	0/gX0iAU4y8kZfH9qqsxXLDE4m6p9FxVFlYSla+k9xNtofW1eEt7YvX+hU3D8aZRw==
X-Received: by 2002:a05:7300:8aa3:b0:369:b82b:5fb0 with SMTP id 5a478bee46e88-369e84ac218mr5762198eec.23.1792918001511;
        Sun, 25 Oct 2026 01:46:41 -0700 (PDT)
Received: from ehlo.thunderbird.net ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm24418092eec.25.2026.10.25.01.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 01:46:40 -0700 (PDT)
Date: Sun, 25 Oct 2026 16:06:39 +0800
From: Coia Prant <coiaprant@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
CC: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Roger Lu <roger.lu@mediatek.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_soc=3A_mediatek=3A_SVS=3A_fix_devic?=
 =?US-ASCII?Q?e_reference_leak_in_svs=5Fadd=5Fdevice=5Flink=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <fa60e7c4-d8ca-4ff4-a56f-6a6e2bfbf3cf@web.de>
References: <20261023082948.1854252-1-coiaprant@gmail.com> <fa60e7c4-d8ca-4ff4-a56f-6a6e2bfbf3cf@web.de>
Message-ID: <9AE974CC-F342-42F0-84A3-D72C3A0326C2@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 25, 2026 3:58:06 PM GMT+08:00, Markus Elfring <Markus=2EElfring@=
web=2Ede> wrote:
>=E2=80=A6
>> Drop the reference before returning on both paths=2E
>=E2=80=A6
>
>How do you think about to increase the application of scope-based resourc=
e management?
>https://elixir=2Ebootlin=2Ecom/linux/v7=2E3/source/include/linux/device=
=2Eh#L1363
>
>Regards,
>Markus

Hi Markus,

Thanks for the suggestion=2E To be upfront: I'm not the maintainer of this
driver, I just ran into the leak while reading through the code and
wanted to send a minimal fix=2E

__free(), DEFINE_FREE() and return_ptr() only appeared in v6=2E5, while
this driver dates back to v5=2E19 and the fix is tagged for stable (first
LTS is v6=2E1)=2E Converting to scope-based cleanup here would not compile
on 6=2E1=2Ey and would force the stable team to rewrite the backport=2E

So I'd prefer to keep the explicit put_device() in this patch and leave
the __free(put_device) conversion to whoever owns the driver, as a
separate cleanup when the stable backport is no longer a concern=2E

Regards,
Coia
