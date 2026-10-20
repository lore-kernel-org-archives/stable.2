Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792481278;
	b=2nBXleErpdWdQZf8/C9T+AiAtVeR+++NRYUlMgN3HjLsdQ6JdtOURdDW10n3JnMqK/+g
	 KVDR1I2UH1EvYJWuz3wZkOeNjlQA9BIe5+ErveHIBxSCA1cSsZRVBwcXewmAQqNjiZJ2s
	 4xi3N211DXNLLzVCpCX+02HvLpBGLSh78sFosvsSTvUzoD3gXr23fwuRLy3Uq4Dx78lB3
	 WC9kpHUcUNQcp/5rWJ918Dg2jHFkYuGgAqhYt1igJcEwQf7b2U4pzcyyBJviFfF4ZUvyq
	 DtAJlULizmyaPsYrfFhHscWFJ3gTIWE/jOn2i3ApNPoFqm9ZPdk7qB8TCzJ+T63D+Qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481278;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=uryACFItQvoVSCXIDTmHDQJ1dZiVZTVi9wKR8Cs4A3k=;
	b=NHfHx5oMqneR/V15OZ9u6ekTUSzAOfM6vhjEVmaldlNonp1VVoblJjGdWYEDjO73fyiz
	 MpkdRAWZBzs1YZOD6yqzM0FNG54Ycl4SHDxbJgbA3DPxjvIiXpvMRDfg+vb2BGa+E52vI
	 mmK31lx2xcigxHTwDeRwSHQzRwbS+NggbSoAAyrKm2Osn8WRN0dbdtZuJA3bvOszdj9Tq
	 jkC7eqanu67K5lBx7nea0pgmgntn6bf3Qa9weEpGZxzgK63SLJk5I+EWb/2FFwnhHJFLI
	 s8bBgxHRLH7JkGak6B8TvKYdQnO+xcVzCUF2x1D1rqFwCoZwqewPdQpn0TNNnUfdcQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JGMTvWOl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HsUUgMmk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE972606A328
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE972606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JGMTvWOl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HsUUgMmk
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K4Eb8L1134443
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uryACFItQvoVSCXIDTmHDQJ1dZiVZTVi9wKR8Cs4A3k=; b=JGMTvWOlYgDWwsR4
	px87J5+exc88G4hmXIZIwtukYLxRO914Z4LsmKcoNegLaS2ElQ/TQ7t8F69p1CSe
	Bm4DAxTy1ck9PbnyM1mSBympoFSqVOkR3XNjstFzb0Jddht29FnN0hdAb4n0dbIy
	NpZTu0uBCXhwG2BXT9a3g8+9m1b7Futb5aSRY8x/W/R+Rb7wBK5HksyotzZBDvU1
	9zj+xbfHza6SMMsKlck/LOuqY2APMA94D3G7jUIMT86nH/LS429AmPyqGd/dIT8j
	ZmssFiysJeDA9oTvkU2c96rKltdnbkwBrh+ar+CgO/70aIW+1vz5XmB3+PlYwlZY
	Al2OVw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5phdqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:27:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ecdc701a2so352417085a.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 00:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792481276; cv=none;
        d=google.com; s=arc-20260327;
        b=g01LIPOD50lZXzLNedh285kcDd/tL4i4e4lVe0W3GFM/7IkIYwCzRx7B0oOiKrB5Wb
         l1VsZIbhKIw1O/twboRfkPAaJWibyZM2Uz0yS8yF0dC9+8sLuUIoghzjr9esFbucQehn
         ynFcNSYSRtCMPshf4fi94EPjKrnF5gk7/3W4ywT2IO6F8+xnpd9eAAVaBUj8dXyGVXQM
         6qHzzfEibE5ZgMA9mAQDMb2ordd9s8T2zFEB9dM5UNIIfC8/QN+tOy1gd13VlU6pl93U
         FQU8oUCvTBnfTvjqFjkCl1YAEziokjppuyjjI3LusylC0n3BwmJtrO5n1Kw+LByENOWl
         7kVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uryACFItQvoVSCXIDTmHDQJ1dZiVZTVi9wKR8Cs4A3k=;
        fh=0AhiTksTKefemW8t3tYaAiQLb69U9InfvQ+oEXakEeA=;
        b=r/kFcaBIzNR83KXFpimFgeP9cXnwc/3Y/NnFAHkd5JDeuhlj3XDP2YdIYiX35lvDg5
         IQ5YjNrMPfpWD74vdkylyE9BXd4fQCLSMTweQg2OnUwQSHQCFxa/cLvrxIihKIxphlNJ
         mwClvpl63Ghv+DgQoheenA3foM0J/JEH3MyBd/eEIqhXDw1Y22KqiZwNjDslTG93Vf7N
         sNrhCAvpixj5B35Ed6g5vjT7sCbNAeUmofyf1YtBLHQ6ek2d7LLBqQB66mLCniz8AOt2
         cKbORVNGE2Kmqx9qOPdq78tQMjU/ZbjVDDjG2s6T0SLe2wINfOW4e14mrHFVGaDIfwq2
         DpkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792481276; x=1793086076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uryACFItQvoVSCXIDTmHDQJ1dZiVZTVi9wKR8Cs4A3k=;
        b=HsUUgMmk0b65hZxUGTsKmWWmrqC2vVSWE6HZ1B9CP5iTl6oH6q/SGCPnhWE0Py3czf
         nnh1Q7Ppqk3mVCFbAXqGUA93GqAucPNjq8BlkUJv6b0CUEhDS3vTD/7Jo96E0FhRE5H3
         nkTDlOw2GQZRVUV9lpXaj0mCYj1kaf1QAT7cJVi8VvgrLWXPhkGmesTWvKWHKLcXFao2
         UciWKhuFo7baRbNavt+bRYBWz5Ek7hrYpIK7Nr43lUbsoO9Eehutw72gmOaMWxbjBrXo
         jD4nL6ALeETVRi93zXkmtTuTDvnoPsTMtXU2YlfGnprkwze0/dEJbtSKVzpHfLUKvyf+
         EeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481276; x=1793086076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uryACFItQvoVSCXIDTmHDQJ1dZiVZTVi9wKR8Cs4A3k=;
        b=Tcu7+b7+lyNrPj5iAJxdkyoSXs4FfnqzSjA/w0TOdJNdsHb2pKA+qA1lKaS0XlAlVk
         qoNVobBflchHddQtuNWM8LXNQbe1RZ5C8Cu8O+1uKPbzgBVjic2pogdtjGH4q3bOm0XU
         krEPY6zPnBqFp4s6n96mw7JoLCGvCY2JkmnhiVE6rmEgVNEQ6Vh5A/0uG3bLXMkiLfp9
         FxJU9lDRCuu04F6YgdkdnjsufkISm6bfbPoKt3M/gK++BMfEAIdCjM2Q7basT5resrsX
         RtLatcFnjk0hWh4jAzIkCGHLx4BsMtKttCS/ZRr2bWcvcQHTLdxmaKS/F+E78Ztt93UK
         3l2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxWAltDcyivH+zhRV2kCG5/yDriZBdToJ9znq+5QVGL92J3dtFYJvyK1KijHft/Dt+4j5iJlMw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTJrbv6SPTkkyGLMFQ/Ub4BmhFHIhrUdqKXME1cLzqRvcYJOOY
	AXp0kyq0PQVNo7iYOC3dUu0gxNNR+SnxVsNcPjRGgpWCP3kT6UJ2foV8BIQhi2IsM8o/My2zuXI
	vfVT1Y4FvjIOG9jjnnnWq2bpfwcfSVmhGC4q4FjsF+UKVv/p0k62NCSU+epjl8V2jXXC3E59QRY
	2wiZ0D/41o6f74aKNk6nvwwfp1iPJSawtQVQ==
X-Gm-Gg: AYBFou03qZggA+nQvjBqCQuasjy6cXDuH49rmSYN/amzmsNGGTXN2YWu7KuRMvNP2Wv
	kvaSWDNVW2XGKGHVIlAubA/WoDmP7JxbmIM1ubrTCIHhsn+FWPeZeZeyBcr+73gFqLmKH5Sg8wB
	/CKGek5nC4OTvvXMNOKfDH8XLAOgsrGidt6hC6CM4m4Kw5g8bfffgrqkxrTg0xWsK4eDc4pKtaT
	N7wS9bCVpyCZBWQG0ccWwShHLSFmfpfLkkV7pbkIe8r39NgryiCtGzF99oh4Fcp9WlVUBskRBs=
X-Received: by 2002:a05:620a:2990:b0:93c:62c4:e2e2 with SMTP id af79cd13be357-93f29b7fa60mr1609173585a.12.1792481275964;
        Tue, 20 Oct 2026 00:27:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2990:b0:93c:62c4:e2e2 with SMTP id
 af79cd13be357-93f29b7fa60mr1609170585a.12.1792481275371; Tue, 20 Oct 2026
 00:27:55 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019055109.49922-1-slark_xiao@163.com> <CAFEp6-2XUE4AQPm5hinnRGyrrsHok2ftsFXragiHgDSKKtKWow@mail.gmail.com>
 <70714501.3175.1a157532149.Coremail.slark_xiao@163.com>
In-Reply-To: <70714501.3175.1a157532149.Coremail.slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:27:43 +0200
X-Gm-Features: AclHuK-6GBMcAS-d0BXDcZveUx2q3Jcid6zCI09TYG0U3nhdIt1a8EQqHNimECY
Message-ID: <CAFEp6-3o6gCb61hCQTJydiH2aD6CBVRa947tpmLe4L9j85Jg5w@mail.gmail.com>
Subject: Re: Re: [PATCH] bus: mhi: host: pci_generic: Update the default
 autosuspend_delay_ms as 5000ms
To: Slark Xiao <slark_xiao@163.com>
Cc: mani@kernel.org, jeff.hugo@oss.qualcomm.com,
        krishna.chundru@oss.qualcomm.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=a7WlZkSF c=1 sm=1 tr=0 ts=6ad717fc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8
 a=8Bi4WqdHlDIZjTcgTq8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: XDnLgkeD_2rQBrcAootICZADLEdHUjmO
X-Proofpoint-GUID: XDnLgkeD_2rQBrcAootICZADLEdHUjmO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyOSBTYWx0ZWRfX5MjyhRRiPoQw
 kBwxFP5B+9Fgako8wSl5ViR8/e9RY3smA9yobRCqNBsiY+yDwHsgNg8yIQOj5JTbQcUxMxn9BbZ
 LEEemlu1hElGvx+QJ0tyqj5jwc9l4oGPx61lJ7NfBKBD2JHVFsghk4E0rqN2iW/nhMTQe5T/gfp
 +PUsOrEUkTVXrvRa5iVbFjgqh0TirG6zAOzk4HrPiMSBxE7rIuzql+BeNoIM0z7TdUni4hP3vrK
 PWpOU8wuC8QDFOadPmJTB3E6uN9Qs5wOess9CRjUb1zsK/+86y25gmunc0pU5mkPfdLGHCfFcQ7
 +KiPMwbXopYPPOkekqkak78AVW4bNQfFd7fSe4hQ+eZvAp/e6wihkjuDM2iaXnQU0679Hna+sG2
 hzE5cWmiwj9IY6kRo9+A1G3jhw1RGCXd24lBLVghq1tYvrXTumoeAc9EReJJNnApRGBQwa5FTXm
 3LnhDnHFpXR1kimxbBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyOSBTYWx0ZWRfXyelq162kMkBj
 KUGfoA/9ymptPeqfad0qW6NYy4vbEkEcrLlUkLxPTR7rTFg6ceWHP0Xir8tEca0kQh3MNdkOkE5
 eqKxNursknb6sDzFFRQW0ueEFsy1C8w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200029

Hi Slark,

On Tue, Oct 20, 2026 at 5:20=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
>
> At 2026-10-19 15:41:27, "Loic Poulain" <loic.poulain@oss.qualcomm.com> wr=
ote:
> >On Mon, Oct 19, 2026 at 7:52=E2=80=AFAM Slark Xiao <slark_xiao@163.com> =
wrote:
> >>
> >> For some MHI devices in some specific scenario, the default value
> >> of autosuspend_delay_ms may not enough to handle last wake event.
> >> This may lead to some unexpected problems.
> >>
> >> Refer to the Qualcomm's Windows settings and we checked this with
> >> Quaclomm over case, Qualcomm recommend us to set this as 5000ms.
> >
> >Qualcomm
> >
> >> Qualcomm also suggests us to update this for all MHI devices.
> >> Since this setting has affected some existed kernel versions, it's
> >> better to be applied to stable version.
> >
> >This looks more like a workaround than a proper fix. It would be
> >helpful to describe the underlying issue, including the timing and
> >sequence of events that make this necessary. In principle, either the
> >device can be suspended at that point or it cannot. Relying on a
> >delayed suspend feels fragile and may end up masking the real problem.
> >
> Hi Loic,
> Honestly, Qualcomm has been analyzing for over 2 months and still hasn't
> identified the root cause.
>
> Actually I have explained the reasons behind the events to Mani in anothe=
r
> thread, you can refer to https://lore.kernel.org/mhi/20260919095506.9570-=
1-slark_xiao@163.com/
>
> From Qualcomm's perspective, 2 seconds is not enough for their default de=
sign.
> They recommended us to update this value to 5 seconds and Mani checked th=
is
> internally as well. So we decided to update this 5 seconds setting to all=
 MHI devices.

Thanks. I'm really surprised we still don't have a more precise
understanding or description of the underlying issue. That said, I
think it's reasonable to proceed with this as an initial workaround.

Could you please send a v2 that introduces a define for the 5000 ms
timeout? It would also be helpful to add a comment explaining that
this value is required to accommodate the 'late wake-event issue'.

Regards,
Loic

>
> Thanks
> >>
> >> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime P=
M")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >> ---
> >>  drivers/bus/mhi/host/pci_generic.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host=
/pci_generic.c
> >> index 7193a384cca4..40735beb46cb 100644
> >> --- a/drivers/bus/mhi/host/pci_generic.c
> >> +++ b/drivers/bus/mhi/host/pci_generic.c
> >> @@ -1483,7 +1483,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, c=
onst struct pci_device_id *id)
> >>
> >>         /* Allow runtime suspend only if both PME from D3Hot and M3 ar=
e supported */
> >>         if (pci_pme_capable(pdev, PCI_D3hot) && !(info->no_m3)) {
> >> -               pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
> >> +               pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
> >>                 pm_runtime_use_autosuspend(&pdev->dev);
> >>                 pm_runtime_mark_last_busy(&pdev->dev);
> >>                 pm_runtime_put_noidle(&pdev->dev);
> >> --
> >> 2.53.0
> >>
