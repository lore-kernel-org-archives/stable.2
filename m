Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795359918;
	b=E06PTHqTOF3SYxonMPwB3Z/2reubW6p8nFnD/fyVMTYTHmFtln8T6wFPGsC+zBCb4xpa
	 /P26yiBl0QR/klp9j/ACMx2/+VrPDBRmTVvGSZ8c6tQ80fjiIN0/lQp4QVGxVszv05+CN
	 PQ8ophm/Y7oNd0aNTbL797eykrEZNTx2F0d7/PWHiJ656jScOm6TjuTN6I5h3IV/5eNyb
	 6WgMf431UINhT1VdnfkT5harjq5tFc8DS7gB1Bqv2LWFu7gV6vlUwpzSiW4NAiuZClXHJ
	 I4FwZrGZlyEaVbbKrB0AQ3uyRj/esAlZlRqa+u83kHxN+srCZGPVIAGmz9/LdJENmPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795359918;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Mvu2hRSv9VNrtPorrCskxdrDA3PVFViqcTkCEB4jfAI=;
	b=B1J+I/jf4BPPDMuhwnSRpJ5lGq+1qZ2P0cbp0vIIpgtadnqQlAGlCtnQ13QHUPdXfEmI
	 iihrznDowtvkuXw4Pn11KR6amr0wmOqb8YaDmHMSt7SU+a04aZ+/OLM/j+MNZ4KAFXmg7
	 84Q1fhPEnWK6guYi1IwJRLdA0wQvKbtnGLaGLSPb2/nx26mJVsFKvD8U/RMFZeTyMIeCG
	 3eyKL636u0XCGmUghlSq7Z0Ap+9vfHGRH1UNO+RSLy39sXU7IgzuyVndC5yMilyDvmg7K
	 e4S8dG5OCXTlW/pmo3tpMWVW9O887PT0tHtN+0j3aWYAwBG0oc4S4FThzliDG3EbJ/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TqV69S5Z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="Z/4ftxKM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBD4606A330
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFBD4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TqV69S5Z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z/4ftxKM
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMBk4LQ1665880
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mvu2hRSv9VNrtPorrCskxdrDA3PVFViqcTkCEB4jfAI=; b=TqV69S5ZkRsdsqAd
	VLC2a8JFbZUznZtSZtyqeaXkzdeA+CxvjWzTHDg4diPq4edORZ9Ajq3f5nnSCm26
	QFWVn3goXlQ3UcBC1PB0pzRAAUj28Yd4CLQRXvZZ0gaLLL7+9iAURke0ozKo91Wf
	LWSUOFJ4d9vnlL4JYmhcKkFbusN1mmR6IjzMW1RP4JOaFysoMWxmxleG59NZ1Iee
	1C7ilFrbCphRtkUi4N13ppYwfPz1mUPXPg+RsxcAJFR9+ADhkuNeXlpHt1125Z+p
	aMvXdDqaWDzDk7WRVEB2RR5OGkQRoUO8/57bY/NJtqgc1VqB7K2VWBxxKzGzg/6g
	nasuCA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j34fk3eq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:05:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94967c6d4f4so275677385a.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:05:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795359916; cv=none;
        d=google.com; s=arc-20260327;
        b=s6snB7p/tDqGGbqO3BZVnpjtEkMS5ZWrWYCEym7YBP1CBNJMFYVL8AcepobCiarkva
         5lxq14bH+gCP4z/S3dECkrOK43eE9CjbxDtgLMHulZyBf3di7a7bCYkV/xIy+qrA9B0k
         aR1RZ8sPcBQkgQHV8Jryrx2nLSuTdPqpKzSkoTWx7OZKFDpZQ9Y6lBLWl2FEyVFG0YQi
         KUoKtqq2Qil1TO3it4XPoLZcMEww/W7tisF/CTUB5/QreAWj+5om8loMcsdItL0sdeuy
         7JUZq87wHFqmTVy+91m9IHLiydKiY4vOgtlftGn18ezAcz+FxkEAk8a2DmvVp8bxop2l
         y8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mvu2hRSv9VNrtPorrCskxdrDA3PVFViqcTkCEB4jfAI=;
        fh=UR6lPYwEtDHvzpXdM5ycBcjyM6q3PhmsTF9o//P5cnA=;
        b=LFHm7x4KbBK4zyYonW4AoThUukeAQcOPUG9c/aInPYNss3zC8YXwFCz5socLzqPXAZ
         KV/Z+QZhgsTju26e5XSwaZbLn0UrUsL69EEmmSQgRjrDNZ/LBoQgpA632JqAAuCI8Jq9
         3LDzcF3vHSNgUGY+gqAkv7QFZWsW1x2jbGDGdSWZza3Gs1vaf+q1saGS8vXm+1mxQkKO
         CmAW+kMrtMiMtA/zUTyBA1Ntsefl+SAaK5liY2b+K5FoJzXmDoDmjXGMH6KUSCqpWjMz
         lPFJM1SMwzpNcxBpp0Smb2gdmMhtXbqK52FxrUKaCEefqkn9/EYy1nDt+dInn12vwji7
         xxuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795359916; x=1795964716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mvu2hRSv9VNrtPorrCskxdrDA3PVFViqcTkCEB4jfAI=;
        b=Z/4ftxKMtQfOIb2KP1kNzDWz2Y6bySTaWgPKGRJAREYzXnuc+3+38Su9eyDZHBZPQ4
         2tgASRAbv8vQ4rzs9SBr6PVXjJQqIdszphP2sHV88HE2IBBsH35EteM9EFs0oP0mbxGF
         EgTaM20xsayoC0N9IC60sYb9YYgOj5u+hdvqmqD2aI2/xn2gPiZcpt2gI1eyTmIoCKVT
         9eMkkRTIxA4HzkRV02v9Xx9YPaDhr7mIDp70pD8jjkdrqutGQwTuwdl72KPM3LQOJ2kf
         lAwg+SQduGZo0Ycnfe0rIUJU8vZjAlTYc4zB34pAOQAbp+N3B9L63YR+GmPCdusmRodN
         Ctng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795359916; x=1795964716;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mvu2hRSv9VNrtPorrCskxdrDA3PVFViqcTkCEB4jfAI=;
        b=TOf+ZjhvNxrr18QU3NIg2M3guAd4xurxR+z4LfxuSNZwbx+U0qDBbcta+asD5QM0Ct
         juBJPqDxw2hF9X739IcbQFQ9AorwD0Yp0jFAqOJ0jl8Wh1z0AuIme6shvaekjfv3wD+Q
         iInFGB7UP8VFZVeiKzAfPq6maaXG27LmcndRaBZBL1MDXSSLQ1BmLRgKc7jMP+TQD5Yr
         BCc/87ZVnyHvTtraAG2FwJKUbyp5QH6nASPox4s11Vghdoc2v4r3y7kO1AbTKgzT4WSY
         mQdv6pQoFgbAhSnmY968k93sMPYlM9IddgMa1lbV/opTS0b9wGnS+VwVUD/WpSjGoZXZ
         VAGA==
X-Forwarded-Encrypted: i=1; AL+hErFgVlSrXgDJ7BJlZM9oujYgHU3HRnDCnQ8UUK6YHgNuX4xG0cbA2ce6LrQDyccjly5esw1VmDg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tfgPGMofcGGvoCMqxLr65NTh7d21odAMwOVf7MTAhFIE7Yun5
	Dm2DJc1vhBI8D9913pnjziUKaRAcE0ql7v45OEWF0ns5sOsLULcUObMlLgvkmkSGfxH8MFhoDV/
	WmBsG/s0mdFS4up+OIX8MEWVB/TyAmEOPBI4z440PK3k2jFjHrxoC5O2nu+HoYlMundw4hNfb/Z
	/YbqbaYlgJadq1E9a9x5I8rPF8OV1/77P4gg==
X-Gm-Gg: AZFdTZdN+/uTU+t/vDNjBxd1jVCvvHoCCGAzCnr4etz0f6T5IspMAXqt632sGTAieWa
	RkDd4/0s17n6T+mUygvNLxvAlnsMH4DCX9Dd1fB0slaLfcBunf9FdeZb/MuRLQFGm3ZdL9TQJsu
	x1smudO5lP+MT+iqLKrnnkzaWe2k+Th8ksarYG13ScB3jDmKwlejwyZh4WrmRsmXtNbkK/dCoUj
	HffBFTOb8EwTOE4boOnbGnZTmN4CnQ6ZjXkk9X0g6xCo5QO/7muGRIDLTJCx6Hr9q52W0aCddnf
X-Received: by 2002:a05:620a:4012:b0:949:3365:7402 with SMTP id af79cd13be357-949ba9b8ee1mr1472737885a.17.1795359915801;
        Sun, 22 Nov 2026 07:05:15 -0800 (PST)
X-Received: by 2002:a05:620a:4012:b0:949:3365:7402 with SMTP id
 af79cd13be357-949ba9b8ee1mr1472730685a.17.1795359915203; Sun, 22 Nov 2026
 07:05:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122050039.861287-1-davidlwesten@gmail.com>
In-Reply-To: <20261122050039.861287-1-davidlwesten@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 16:05:04 +0100
X-Gm-Features: Aa3M54om7_Bu2prslwxgzjqJgGVDuwBMZkqZHvyNbC6f6bUZvndDC16atbuK-9k
Message-ID: <CAFEp6-0_5YwOz6DiRKi_mNn2fCg7rJvYGYjOrVd903wdKZwCHQ@mail.gmail.com>
Subject: Re: [PATCH net] net: wwan: iosm: always send the host sleep message
 on suspend
To: David Westen <davidlwesten@gmail.com>
Cc: netdev@vger.kernel.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, m.chetan.kumar@linux.intel.com,
        mail@maciej.szmigiero.name, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 2OwvFGa2Ih4TEMR-2c4pb7gaLpbUxS0s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA1OSBTYWx0ZWRfXxl//EJ7tcr6d
 fvv8VIFiDGd9cPbRX7pMWL2RIp46bnC6VdGhaIEDKvpI7aoJivROtIEYXp5Pnp72NsG+iBeqVvN
 423W/uq2ui4CLU519MAVQ+e3++6MJPeo9npoHnJgQx/jbOErzCzBa1LSeemgMH8qiefF+LC1gMo
 M6ZeFE4bLH8pt4uEcl5SraDURiuF7yuYrX3d51g/ufsa6Kofgn3EoEflHQOwfzhIaXoQrzu3/GX
 br3O+jJQM0G6c3cO/CJD+oq0ekV5K5mowQalTdZB9qGlymK9zCE5Ymm06jb4LI7+BhMMZbKNOFt
 OHah+BMc8k0JAJwU4mL3wzOKJIjBqf19bAXwQxxSLt3o9YN+CQhkUHlJQBa+hZV8ejqftlcdeGX
 ohUPZVdh1ZbFggkIxhGwIwUJxF2URZoX0fgik+/uicnoAwCUCXbDyvbnM6HQIlMkj6Y2KBTc51Y
 oo1Fwf4BMMWDRo5CLLg==
X-Authority-Analysis: v=2.4 cv=PsUG/AM3 c=1 sm=1 tr=0 ts=6b0304ac cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=6kzURy52d_XsnYN-:21 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=KygpZSa6NscGoRIuHFAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA1OSBTYWx0ZWRfX38h7eXmJiF9S
 vBqO5VXwF+MdMu+Zl799iLxHpz3wwPnx19H/VVsx03dBMT+rbBp/XuBAIK0wpMxoNmfXqkwA2jA
 KCOlFxR63KaFh9jdm76ggYPrAs8ll1Y=
X-Proofpoint-GUID: 2OwvFGa2Ih4TEMR-2c4pb7gaLpbUxS0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220059

Hi David,

On Sun, Nov 22, 2026 at 6:01=E2=80=AFAM David Westen <davidlwesten@gmail.co=
m> wrote:
>
> Unless the BIOS reports D3L2 for the WWAN slot, the suspend callback
> only rings the FORCE_SLEEP doorbell, and resume the FORCE_ACTIVE one.
> Neither waits for the modem. The driver doesn't keep the device in
> D0, so the PCI core then puts it into D3hot anyway. An XMM7360 in a
> ThinkPad X1 Carbon 6th gen doesn't survive that: after
> suspend-to-idle its execution stage already reads CD_READY when the
> resume callback runs, and the first port open fails:
>
>   iosm 0000:03:00.0: PORT open refused, phase A-CD_READY
>
> The modem then stays unusable until an ACPI reset.
>
> Send the ENTER_SLEEP and EXIT_SLEEP host sleep messages on every
> system suspend, as the D3L2 path already does, so the modem knows it
> is going to D3 before it gets there.
>
> This ignores the BIOS RTD3 setting for system suspend. The setting
> only selects the sleep protocol; the PCI core chooses the power state
> without it, and here chooses D3hot, which the doorbell protocol
> doesn't survive. Honoring D0L12 literally would mean keeping the
> device in D0, as commit f4dd5174e273 ("net: wwan: iosm: Keep device
> at D0 for s2idle case") did. That was reverted, D3 being the expected
> state.
>
> With this change the modem stays in RUN through 2 and 10 minute
> suspend-to-idle cycles, and its data session keeps working. Platforms
> that do well with the doorbells now use the messages too.

I don't find the commit message particularly clear, as I understand
it, this change effectively ignores d3l2_support and always uses the
host sleep message path, so could you please simplify the commit
message and more directly explain the problem, its impact, why the
d3l2_support distinction is no longer valid, and how this change fixes
it?

Also see below inline comment.

>
> Fixes: be8c936e540f ("net: iosm: power management")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Westen <davidlwesten@gmail.com>
> ---
>
> Notes:
>     This is independent of my S3 series ("net: wwan: iosm: fix S3 resume =
by
>     re-binding the driver around it"), which leaves suspend-to-idle to th=
ese
>     callbacks; it applies with or without it.
>
>     Maciej suggested forcing the D3L2 path for suspend-to-idle earlier an=
d it
>     helped another XMM7360 user with the same CD_READY symptom:
>     https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/work_i=
tems/992#note_2938256
>
>     Tested on an XMM7360 (ThinkPad X1 Carbon 6th gen, BIOS reports D0L12)
>     with 7.2.15 and a debug build that forces the D3L2 path, which is wha=
t
>     this patch does, logging the execution stage and the PCI power state.
>     Starting from a fresh ACPI reset, the doorbells left the modem in
>     CD_READY by the resume callback after 2 minutes of suspend-to-idle.
>     With the host sleep messages it stayed in RUN through four cycles of =
2
>     and 10 minutes, two of them right after a fresh reset, and ping over
>     wwan0 still worked afterwards. The modem and its root port went to
>     D3hot in both cases. This patch itself, backported to 7.2.15 on top o=
f
>     my S3 series, then passed a 2 and a 10 minute suspend-to-idle cycle w=
ith
>     ping working after each, and S3 with my series still works. Built wit=
h
>     W=3D1 on net/main. Not tested on the XMM7560 or on a platform where t=
he
>     doorbells work.
>
>     The investigation and the patch were done with an AI coding assistant
>     (Claude Opus 5.5). It read the driver and the earlier discussion, and
>     added temporary debug logging to record the execution stage, the PCI
>     power state and the messages around suspend and resume. We wrote the
>     change and the changelog together, and I ran the tests.
>
>  drivers/net/wwan/iosm/iosm_ipc_pcie.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/ios=
m/iosm_ipc_pcie.c
> index 49052eb511ba..dd7cfe3747ef 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> @@ -406,14 +406,10 @@ static int __maybe_unused ipc_pcie_suspend_cb(struc=
t device *dev)
>
>         ipc_pcie =3D pci_get_drvdata(pdev);
>
> -       switch (ipc_pcie->d3l2_support) {
> -       case IPC_PCIE_D0L12:
> -               ipc_pcie_suspend_s2idle(ipc_pcie);

So ipc_pcie_resume_s2idle function becomes dead code?

> -               break;
> -       case IPC_PCIE_D3L2:
> -               ipc_pcie_suspend(ipc_pcie);
> -               break;
> -       }
> +       /* The PCI core puts the device into D3 whatever the BIOS RTD3 se=
tting
> +        * says, so the modem has to be told with the host sleep message.
> +        */
> +       ipc_pcie_suspend(ipc_pcie);
>
>         return 0;
>  }
> @@ -427,14 +423,7 @@ static int __maybe_unused ipc_pcie_resume_cb(struct =
device *dev)
>
>         ipc_pcie =3D pci_get_drvdata(pdev);
>
> -       switch (ipc_pcie->d3l2_support) {
> -       case IPC_PCIE_D0L12:
> -               ipc_pcie_resume_s2idle(ipc_pcie);
> -               break;
> -       case IPC_PCIE_D3L2:
> -               ipc_pcie_resume(ipc_pcie);
> -               break;
> -       }
> +       ipc_pcie_resume(ipc_pcie);
>
>         return 0;
>  }
> --
> 2.56.0
>
