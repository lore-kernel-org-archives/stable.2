Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793913742;
	b=je2k50NlSCOaZuGB9w5Em8rqLbWUdGzU/mR+/NmhuC7XEq4HcQE1RyagjVOqypFV3mf+
	 9mgnwJf59zgiUEoj1clAyKhWbW+f3U57hCCw+ZQwyZpDllsleWrzMl1TBF53axWKex2Tt
	 K8N0al749QagPQ4ansIPS+HEr1HMuMgdQb89vy4WSOU2zSS8uP5z2Vmisz5vV7yi/qEQv
	 mFF+OOveexPWto1Dgk6N2gSsHZd4Yuv59N/5r4nia7x/wDUk04k3ipvWS5pyQEb3SmN/d
	 w1341uFKjbBjrp1AQaX5N/6mrLcHT75n2nTJreF8xD6htpCFzmy43iy9CIcb8Eji+cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913742;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Nnrlhh9vfNJxQiyuc7iHtauFwDzPC4RmVeRvPk7YN3w=;
	b=Y31tWBDyGhFJSj2+0Aq7TS7pm45p+fxxF5yGz09Oa4pN+9NXht/OGVhlbtXEIBr1SNVi
	 BD1zDJuk+MOZCkhNxt6OOlV+ks+dEEWdgsAXl1zpkCBIQETfx8SMVXEnQqGhPnfstuUX6
	 f9nossMb/UTd/BKo41JxSCF3KuM3DKw9DgGWMOL5x6mZGPxn+Hk1Fv1nTKq7qkOkagzji
	 SsKFq0KkQJyv21rfRGk5lzWRpRQECP0weML3UBfwWD3mAQWAfPP4qraoYGwerZO5/FNrE
	 KAFIntOfndbjXeJnUhhvkLrc0cuYG6pIVhVkO+iVJfW1vUyIgMOJQCkQ7cZaLO0AOCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=PF59IHuG;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=a1bE1DmT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E40606A333
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 21:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1E40606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=PF59IHuG;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=google header.b=a1bE1DmT
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5KLBd12433652
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 21:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Nnrlhh9vfNJxQiyuc7iHtauFwDzPC4RmVeRvPk7YN3w=; b=PF59
	IHuGXDChVbsRoWU8iwdv/Ql59cx6YOn9+8xpzkU+Mwo6fGmU31uRD4A3rGxtB92F
	FWYxcc8QCcDl6SyPbsR8h7sHu8v7nnhbRe6DA+q2e58g1tvDogd3B+z1vFfIXPe+
	D6PKWgun0Puh1svKHzcaZKKApdKl2kFpIKxpYnEw0LU+uBAxLQSfKn511r3y7hX6
	WtmtNzVacjsgytH9lF8LZW4hcm7L0e8UGjgwaUDHubsO98usD21XGgN0p97RiS6t
	UhlFiiku3YDTrLDQuQdEW4wUe3h/6MjM4gFqrnHa5/A1i9VDSrDQ6YJpuR/QxlzY
	wlyiIRtT0gaoXupG2g==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hrm99b2xx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 21:22:20 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b30789c6cfso33867327b3.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:22:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793913740; cv=none;
        d=google.com; s=arc-20260327;
        b=U0QGRwJptdHXURCp04rCKpPachvGRnqNY0CiCsXWFdyYY/jlVFCmuh2/w+v3QzsYT2
         JeXztnb6ZSP4yg+Y0O07EWNDjpp5gDed9OEpei5tCEy+yLLQtXRtyxbtSzVkmWtwe/pY
         ngmWmQ4LQxi2CiNBpY6781usKXIGvwq8FPp+2xhYbcWq87YeQC4RdkVHNp0wxRLUW0hH
         fRYHoHzKgfte4aVaAkUFztysqQvpSE07DQx2rvwxYbTcyBR1Usd1FMYQVuH7kS22VLEf
         gaTY0YcD15/41ja9vogC7ZdOJ9Ccsu1fiEX7SC4AP3o/Abyg52JSdchA327vmZHGY/2y
         GDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nnrlhh9vfNJxQiyuc7iHtauFwDzPC4RmVeRvPk7YN3w=;
        fh=Aiufc48Pg5t40AHsnNOj32gTvKej6yNOe0jh6uJeZfU=;
        b=fcobR1Q6ByqlVye/WqAD2nvmBu6gvZAucIXO1I1q3ZdGGp7rh1U7E6iQDMxj/0jpj8
         7M4HGNaLNKgDjWPPjMEy4/3wn18iEWu1MzVUtaztZdj3jU5HfRp5HuvjIrV7CCnHDGvX
         g1tyTTfCC3iGqPkZgmUSq5a+5BYTlkV4X8ixzgWPMpfVJePWi6FZY3XxQstpD4XL1YLm
         H4CkAd1EWeHRbO8Ekknd2kQre3nuT3mLwysXqPQJmZ8JesnONUZ54020zAHXWYNYhBAy
         v0TPWoTQm0nfDP5k8xv2fPqc30c7hRgpiGs/cf3u7Syat0l2YWL/nMTBUFDkdg7FsFz9
         aOIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1793913740; x=1794518540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nnrlhh9vfNJxQiyuc7iHtauFwDzPC4RmVeRvPk7YN3w=;
        b=a1bE1DmT8A9DuOfci10mNYa4KDO63xERGqK/QMK10vZfdG20m9kjOe6g0SfYFnVO0m
         Ms9gwzZiHNTN0V0oVYcIOvqtVd+jaxpcBb25dVMWSYpPXY4r3Y3W201K9J0q3s0j8YWQ
         xfRgCsVklMp9fkqoUuZFjTR7QP1kHc+SeLJ5kzQQP7ZJ/C+6N+oYWL2J62iw9PnDijQR
         VVAdTd+EM7L3pi+7vsdLosTJVS+q5m6B5thTCJMJnHVzVFhwFgHUEguqP5h+YQkxTBO2
         wp/1DYhmrbCgMNjIaIrCoevWokOYHQETqh1T+LrizIb9Noj7Q6H6cwunVwsAlakf/Jvj
         FnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793913740; x=1794518540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nnrlhh9vfNJxQiyuc7iHtauFwDzPC4RmVeRvPk7YN3w=;
        b=0sxZnPt4/Apqf//3EVRxz+5GyvWyO0RCBhIZfQZDgwU/CeqOk74HH27cAGDBa9Sk+K
         +mRQtoT8bE1WLTgw5HpMKUpIGgDa72t0i45RtkYvlT1GSip0vZtBTjXmL0vkt0HfMF65
         vfteUWYQp82kBnbcsAlGjNE2nzdEZUdoqMbsPKqrNYblJ5Gz5+7bgw7HyLZYcMRxVt7x
         InDNl08VbEya2BePVdJesnTPU16B3+K3CMmhpl/VFjRvTr+hLncR/OT4YAxaFxPwhrD4
         tgHBZ+4DW91PqIEw1M/DBTjcVDq5zEymCwysv3C8sfYaKomkcrCPnZwM/dJwXNOtJnX8
         I75w==
X-Gm-Message-State: APuU4Z85erU+ynXOhPx3kK51WhbpIovHM8Kl/NmcrSRoZ5YBdY2uB8tF
	bKs6dyodYFLWdChb4NWdWVm3JjwlwvZJyty7PyaHw4au0lzIvS7harvSprVokqUEhhZjH4XtH/o
	10XMq/8JFPN3c2lgWALLxCG0rZpY6jESw5/W44u7LZmuaQ1qINGDf4KMfSoj0B4IvM892RNTci8
	GN7eYZXUeTo0os8n1JlcbT9USrsV9esvDN
X-Gm-Gg: AYBFou1XqeW1Qc+a4ldVwYXudlGTXPC/yI7C8g1vfK+lNWj9MmuxEEeH2LrJH4pn0AE
	etJiDzEqGfysNWObLGzlZaOprCJfkztB2/3h4zBAAupaF3Wc7ftTX5pwT2vJhT+Khs8U9L457ze
	s6OwD72RicuZDXOv5IUPtXWuKDRHFnO9Ei6gRaSEBAK2SN2nbx5OI6tsg4
X-Received: by 2002:a05:690c:34c7:b0:8b1:8d69:1cd6 with SMTP id 00721157ae682-8b3417b1332mr1510937b3.8.1793913738778;
        Thu, 05 Nov 2026 13:22:18 -0800 (PST)
X-Received: by 2002:a05:690c:34c7:b0:8b1:8d69:1cd6 with SMTP id
 00721157ae682-8b3417b1332mr1510547b3.8.1793913736744; Thu, 05 Nov 2026
 13:22:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOu3gNgTSWE84fgdc1iUNKwes7E6u_X6b8pjZKBULEJWB=RAqQ@mail.gmail.com>
 <20260820182015.4272b7a4@fedora> <CAOu3gNgv91dq8jLShteRWphrSgNWQ1o1dkNxRr577ez7pMuv6g@mail.gmail.com>
 <20261104083903.0d7cdb06@gandalf.local.home> <CAOu3gNiggAdifeAUpycoO-zGKb0k2-nZqWrtDXMXm_HXT8L1Vw@mail.gmail.com>
 <20261104123019.1f7ed0c1@gandalf.local.home> <CAOu3gNiOGxC7fhjz=tVnmrR-rofVzLy5R4VbV8Wsv7nrNwQ63g@mail.gmail.com>
In-Reply-To: <CAOu3gNiOGxC7fhjz=tVnmrR-rofVzLy5R4VbV8Wsv7nrNwQ63g@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 5 Nov 2026 16:22:04 -0500
X-Gm-Features: AclHuK8kCZCncsa5FrwjTDtTO9orFQ9syBN9QhrFvoyj-hv8di6oiHN-S7a62QE
Message-ID: <CAOu3gNiaCgfPDjVJrt5hLkDuw9nU8-Om50MhZaP2U--91S9N+A@mail.gmail.com>
Subject: Re: [STABLE REQUEST] ftrace: deprecate the ftrace_enabled disable switch
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        sashal@kernel.org,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>,
        Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NCBTYWx0ZWRfX/dJhf4hu27OG
 qw2cR4RlC88asD28D5wYdASTosgVhIIhWz0UrWMFbRld+zEZ0pNqRwjiHQPMy06iqIdQ95Kr3bW
 mQrZyQJx1bgOpEW79qsp6rM1XQlZC/3EEunVO77Ef4HBB0cpjtMuHa8D8r4++waELY2K7O1QTaX
 U+6Qq4PnB9wDp5ysdqK5UxyXrIWOzN3S1LWrvJdqoZC2vR4Qrp1UNIeNg5RXgz7hu8wHycLkJBs
 yNA+N+KqTUsMI/v2r3XpNt0PXBU0j+GfRsOICI975o8U7lUjp8KwINlHzIQtKlLJGQZ4lf5WegU
 I9dYwp1NxRF48EVEfojan7ZLW0FPP7wEgVZ4xs0fd/qwaKuLSS1N0YdO6/QsGzCxBnHAPnLS2UX
 Tm3PMKR8EHCbprCaRy173ksVrkYSg6eL+xD4Mr+/cY+K5OZfG4UCsuCtAsZTV59hHytBKTL7Oko
 nXORhSgPc4RQ5e88dtQ==
X-Proofpoint-GUID: zRwTsqYWGF4lvaA_k7sx4xmVZRxwtjAl
X-Proofpoint-ORIG-GUID: zRwTsqYWGF4lvaA_k7sx4xmVZRxwtjAl
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6aecf38c cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8
 a=U5Pmj9hvqIsvDLiTjIcA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NCBTYWx0ZWRfX0EkiAecIuWww
 PkB+sE6IKSkz26GspuuBtRXHnkqFOrhXZfWp6vcGl9ssMs6iPcv5X+0gbxO81cF/cQZx8UjHxTN
 KCxRSnD3kcl3vQpjJqWn1ZiQBNXSsCu9cM7DGdCAsNJ8PvblmxWC
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050084

On Wed, Nov 4, 2026 at 12:32=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Wed, Nov 4, 2026 at 12:30=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Wed, 4 Nov 2026 10:43:37 -0500
> > Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > > Ok, so just to clear my own confusion: do we want to directly present
> > > this to stable as a backport fixing a bug, or go through merge to
> > > mainline first and then only backport? If we do want to take it into
> > > mainline then I think the selftest patch is beneficial especially
> > > because Jiri found some case that breaks there that needs furhter
> > > invistigation [1].
> >
> > It has to go to mainline before going to stable. I'm fine either way fo=
r
> > the selftest as that's really up to the bpf maintainers.
> >
> > -- Steve
>
> I will work on the failure Jiri reported and then will submit a V2 of
> the original.
>
> Thanks,
> Andrey

I reproduced and that a simple test corner case bug but it's all
irrelevant anyway. The tests basically attach fentry, fexit, kprobe,
and kretprobe programs in turn and confirm kernel.ftrace_enabled=3D0 is
refused with EBUSY and vice versa. Since mainline has [1], we cannot
test this for mainline kernel anyway and so the first 2 patches is
exactly what's needed both for mainline and for backport to stable.

Andrey

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Db0c857049153680e1b6ccb59abf359a4ca523561
