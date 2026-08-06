Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530153F326E
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052716; cv=pass; b=NBCuBi/Fysz9cVQjc76RcxVXKQLx4dkJl72Swd+gupmPJ1xCF0kXZXghLJ/I13hxvPhfP2P34DM8LxqvKb3Nhx2Vl9xb0uL1wyG2xekscN0qbqIaE7DGJqFlShcfP1DU1dhuR9SHUMJfIKFsLjQpfNvSDMim0PTJhtWwNzolD9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052716; c=relaxed/simple;
	bh=PK328fsXxrnSfxwWxbhaOTBsxDsbWAQZmZRHgDGiP+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV7Oku3Uxp6FhO+H593a07stxYtVncunPDNYcRmCW0YaigA0nmZ7GaS12fHwhOoPq1NjnBXdfyMu4Mgvq6QvPdop5hfZej6Wcm/QsEvS4EtNuQ0YQW/hh9Ewz83u962A4+H/gc3e/ReP/8oZ6Hfm9/HHN0ptnKzYRAqSiJDV0W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=OUEVn1af; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=alxYbj9m; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="OUEVn1af";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="alxYbj9m"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676L9uIm4162565
	for <stable@vger.kernel.org>; Thu, 6 Aug 2026 21:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=; b=OUEV
	n1afqfcYalp/dvkYGJtHNlajXOIIRfYZLt5YedM1CA6PJ1yxajN8vAxR9p9++GqR
	QOkueM3WMr6/5NUJuk7BCpttIkMW3qrzMWFgvQQygnBixEshBrGxw35kUN/ZUXaY
	Suieuioj7Rv4mZrQUn0Zg5+EB456OxQtxrAr/lGzxg77qpo3IG9TpLIa+/xZKH98
	ZnDbA/eLx2bHZ3TBVAkYiOEQtiWMvGHuFiHUhErdbIeLszHPYuefaQc+U7Jos09i
	0EBxPD+xQk9GZwpI75tnme4N4WVD4X1ed3Fr8kjqEXEF8VrQvnqXJBqaH9lwyxJw
	0a3TvZ0w+8IGNShi7w==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fvq5kbsx6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 06 Aug 2026 21:45:14 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66ac1d28eb7so2347436d50.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 14:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786052713; cv=none;
        d=google.com; s=arc-20260327;
        b=VRlIrcYgRXVR0wNk7oKdY6ehNcUyIHuimKK83SHpDwefa7RcbyzOi5RZCgYoCwf83L
         /vnB3YN1XBhU5csfkdkgZ5DXBRLloClSTsoP3I2BQlwsZX2vzPIxABhB+bHBvOW2+BWO
         7AXFy+Kr9WOqfPSW8iV4VkX5YxZYjcu2iQlgKUe6YLVBXXJDR4aBCz78POvWO4qyaXxq
         S+uTFXK+MwHPwjUJOX924w/H0noDodcwPUM/i6xtbcusf7qpH9hQMgJtB+juNSiQPwIr
         cfsmFHweNXabANVSSKCakrGa5ET32TbuYcw4UnnoI4XKhosz/vUXcGS5nahz25vJibSi
         BNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=;
        fh=bgC8lSBpoI+654K+Twj6EKVkmq+yDdviXC/Tz4kH/n8=;
        b=J+BfHi8OimsiIz4+oTj1tNnQ+dmyr3IFzKHM+O+smb67urhY8sSg0c4L1FV4dYkZ+B
         XajcOgR79lkTD8zE/CzcVOkGSvqVw52iNpcDJVtbl6UcvswxUGPp4ZW2gCyZ8rNswyaq
         pVuVokpWeBb2wNkywivSzzVfHMpWq27ix1EHjT0zR2/P6SmF8v7DiF65ZVTJ+pEIkHMH
         hTNR2ojpqbBGDcmX2+PMkavLVFc7p78SLfMjAhPH5vobx8iFoezdc2NECoOrvVnv9aIE
         cexUfhoJhAcmnvyJwhKXclqJrkL9k/T7St/HlD7MlmTmPiDjcfLTIyI2m+PPxN5QsxkY
         gPqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1786052713; x=1786657513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=;
        b=alxYbj9mK+s/YyRrr/7GTyGfvDNkPGzAGKItaVc6sel7LSOdSEUmUSaYICAdDKm0YP
         PF1AI1Fn9vzJSgkwzzdEyTNvrFQ7SrYvsIZR2d4utplAeKKUy4Qc8Kwwwvn/HJU2MeqJ
         L1bR+b93ikkaYCQj/JaYEWmZaJWxC05Xe9tu/InspoVwGlectf4z3QEnxvynmAGblwQ/
         Qvti2AeY/6Q5F7IEA70XNrNMfKxFXE/GG7ClrMy9pkGx+IpVpxgOC9/yxucj9b1iyp+e
         267L5PGPlNuz0gLy7xr9/k+x+uEvGveKDZWjRhbHaym1ITdzFl0+58KhW5BDKP7zpxtP
         uDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052713; x=1786657513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1kfv7quz9mKk+6GOaC33tWyYDCJTvIO1hmWivTvWbE=;
        b=BamI8L9q/RdyY2HYZANM5onNts8An017OK0CTYtjug05mG18dwk6HS2qaG1xkmRicv
         6cqmwE7cnjzl67yzS3vKuhS2uXB3a3sADeGOAEBKu0WxS1pilE05246ypZp865HQA9rG
         fMd1yrKNcbSD+IXuo9JzfNJmDODWX4WlEpIUtAaLALn/Sg4Ckuwo8/o0UqftQyf1JQl/
         o4D5E3GdHvzQ7f1OpfaJkn4N4NfXaZPdX81JkaQ0w6SP6bAjCQKIL5Fsdb5dZBl6ZUCB
         jP97mHlsUzUCLr2WGy3uqqM3SW9fbl1l9nNc7jCHDKqYqS7muzmLr2DPtO9VzK92x2WT
         jL6w==
X-Forwarded-Encrypted: i=1; AHgh+RrPELO/ojUh+aFsaUL6dkUkKO8oAHpERVcEwVRuBiN7yPqADuOuxNI+lZ7T2vYOskdN4lCZMqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Qbo40fVaF4ykNEf78HJbbQK9gMfIGX/I3RCP1a7snuQU3e/a
	qoocwgjEUcZBcdLZbsxDifb6hyTBK0uMx+fzin8nPyc7G+IOgJyQJX/glTftsWqelcVHdCBtewa
	qc5zld9thtRjQ0sb2eZkIygXLbH0T9qi93Vob8Y6Dptu1JmLIZ8H3IWJKVpg5AkjS+RTOTuz1Fl
	fEuCw4TmgIEqqNClGhrJswgM9VQcoBjKUq
X-Gm-Gg: AR+sD122dR7jcIq/7d3xu6TLFyBd8lAa9hcT1EUyPua2z9PxhDyRsuf11iI5wpbGqQL
	DYlRaToctuFag8SePgo4vm26INcUZs96nBt8/aCHESs18QV9h01k4NZNgUjJu+YbPBXCFIyX230
	NlQWvnnkpV1nqmGmubnzxRZSdFw7fDfhbQGdkasS3KG3W0Cs/4pPmrf7vhxw==
X-Received: by 2002:a05:690e:b87:b0:66a:c376:6f86 with SMTP id 956f58d0204a3-66ac37673bfmr2597598d50.8.1786052713252;
        Thu, 06 Aug 2026 14:45:13 -0700 (PDT)
X-Received: by 2002:a05:690e:b87:b0:66a:c376:6f86 with SMTP id
 956f58d0204a3-66ac37673bfmr2597553d50.8.1786052712556; Thu, 06 Aug 2026
 14:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com> <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
In-Reply-To: <CAPhsuW7gOs2Opo5DRm+YKxBxwU+ncBmEAKHYO5jPjzxM9S8i5w@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 6 Aug 2026 17:45:00 -0400
X-Gm-Features: AUfX_mycxuhE9bBXZ11D4K5vINcCDSJcPpDp_7gksuopKRHXb_3yuGXJfDBYFSA
Message-ID: <CAOu3gNi8i9m7nEuKF28G8cYqJULvE4W6CuDeYVFk58z1xSbBoQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz,
        jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org,
        joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net,
        stable@vger.kernel.org, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE3MCBTYWx0ZWRfX2hWx+3gTfu/o
 TfxczJ2HLkt3vu3TGumYb4eiThhXJd1fqlhM8q6EsVEH9dbTj7tKrKIxLlVcdPYI0t4WxnapUEK
 x6qjwMT+vYip27MM3aSYjFwfeDB213bjo941KaphpXPLv/gdJrO9
X-Proofpoint-ORIG-GUID: hhY2jRB4BRpA78Nifva_szikix6R1pHy
X-Authority-Analysis: v=2.4 cv=QfJWeMbv c=1 sm=1 tr=0 ts=6a75006a cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=ngmC-yC5AAAA:8 a=e25ExAebAAAA:8 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=meVymXHHAAAA:8 a=20KFwNOVAAAA:8 a=dDW-ktzWsA5qhXuJ1JwA:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22 a=P5XVh-r7Nk77isVNjX_M:22
 a=Fx-rEtueDibNKiZPBj-h:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE3MCBTYWx0ZWRfX7tuc65QEoY3+
 6NvwHGhMhpbsbdf2JMKnUK0sFHl/y26QFm0oxaPX+jEhHhuLAQvtAZ0OsxSplRpj5wu4npKlgna
 rK6UvBXAx8laI9jGysxn4fSku2a+lSowii53j+t+hm8sUudRFXCwaky+/oeM1QesfhFC7nMfmlI
 Q527+gIdzVwLQHwSRXtJ1dy0yH6+BqR1nbqG4cSKpUDVMSPdKid90GNPJc7lHJpI0KL/ITPgd5q
 IKhcON4QF6YA4OVG0NlOTsQIHFRE4FVqzjtRD+G1HwVdCwmtwdj3V0/kE6OH48twLv4klI5r+1k
 ghhFXjtx/iILEP+UMnQDrxgCEpOKI7CHhh2Yxh43nEfIZwgLjfBreCqbNyu9qjVMWUVK1FbbmsU
 I8HHAWm/K4UWUxs0LbwDJB1HE3bfr7w8+Aa5tT2G4977Y/80TFgkwc8TXrGFQWNCdEgPPPCd/bA
 nB0LGIYwat9MS0iUqWw==
X-Proofpoint-GUID: hhY2jRB4BRpA78Nifva_szikix6R1pHy
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060170

On Thu, Aug 6, 2026 at 5:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Aug 6, 2026 at 8:30=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > kernel.ftrace_enabled=3D0 is now refused on kernels that deprecate the
> > knob, so the old disable/reload flow no longer applies there. Probe
> > for this with ftrace_disable_supported() and keep the full original
> > scenario (disable, fail to load a livepatch, re-enable, load, confirm
> > disable is refused while loaded) on kernels where it still works;
> > otherwise just confirm the write is refused.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  .../testing/selftests/livepatch/https://urldefense.com/v3/__http://fun=
ctions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9obFozOCSU=
hPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$   | 14 ++++++
> >  .../selftests/livepatch/https://urldefense.com/v3/__http://test-ftrace=
.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9obFozOCSUhPg1KC=
QGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj6oTNhr1$         | 45 ++++++++++++-------
> >  2 files changed, 42 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/livepatch/https://urldefense.com/v=
3/__http://functions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTt=
sCXR9obFozOCSUhPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$  b/tools/testing=
/selftests/livepatch/https://urldefense.com/v3/__http://functions.sh__;!!Bm=
dzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9obFozOCSUhPg1KCQGTvfgZ9oT=
wgBkdB3nKZA1RCYtwwYj2qtEXgW$
> > index 30dc677b2f45..a65b7b1ac8ad 100644
> > --- a/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9ob=
FozOCSUhPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$
> > +++ b/tools/testing/selftests/livepatch/https://urldefense.com/v3/__htt=
p://functions.sh__;!!BmdzS3_lV9HdKG8!0iHqKyQrLfspbt4sQvekjrQjWLuiSTtsCXR9ob=
FozOCSUhPg1KCQGTvfgZ9oTwgBkdB3nKZA1RCYtwwYj2qtEXgW$
> > @@ -126,6 +126,20 @@ function set_ftrace_enabled() {
> >         echo "livepatch: kernel.ftrace_enabled =3D $result" > /dev/kmsg
> >  }
> >
> > +# ftrace_disable_supported() - probe whether kernel.ftrace_enabled=3D0
> > +#      can still disable ftrace on this kernel. Newer kernels deprecat=
e
> > +#      the knob and always refuse the write with -EOPNOTSUPP.
> > +function ftrace_disable_supported() {
> > +       local orig result
> > +
> > +       orig=3D$(sysctl --values kernel.ftrace_enabled)
> > +       sysctl -q kernel.ftrace_enabled=3D0 &> /dev/null
> > +       result=3D$(sysctl --values kernel.ftrace_enabled)
> > +       sysctl -q "kernel.ftrace_enabled=3D$orig" &> /dev/null
> > +
> > +       [[ "$result" =3D=3D "0" ]]
> > +}
>
> Since the selftests are shipped with the kernel code, I think
> we don't need to handle backward compatibility here. Instead,
> we can just assume disabling ftrace is no longer supported.
>
> Thanks,
> Song

I tend to agree but I think here[1] Steve and Miroslav asked for
backward compatability. V1 was actually the way you prefer.

Andrey

[1] - https://lore.kernel.org/bpf/alpine.LSU.2.21.2607311104390.25165@pobox=
.suse.cz/
>
> [...]
