Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795450876;
	b=AHKB4i48XDSeifsqU6vDJmVx8YuCDsT1+wvUKZCLFOa4egTCLw6ZAoMAVA9auD6rWI1y
	 2ABJE9eqt/G1E8Jt9r/JcELH6KUMJH1VZBOs+cNVO9yepURyRwOsCdAWeaajQA+Oql/Hs
	 QzT+CTbOjFNQl6I1OXZBD5htY7E8IH2JgWr7W7QvwAeRgfqU/JLq1LX2CN1FaxJdLIMK7
	 a7HqEWvSyC7eMPVxJoQNaZC5PTnrFY+MblELt/qfTRV8AV8OwcmJoyz3Fk+u3AULXs+EB
	 oIOZSDgCZNRCZW1KgXld/r9QWNWo4f2ZtH8mDCiOrx2JeDTn2BVIAz3ZMFqLjZ9rw+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450876;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=pk67/hXS9CWh4vlTcztHypEGoxMFfpG8vfbm7E4XmBY=;
	b=IqcbT4gzPQEfxVoM2F2wRaMzfrlqbpTadl2X+X/7QzU9QXOa8WVSdb1FNGKGEEEVVx4t
	 9STSnknkJD7oQf3cmQpxr84xubOlHircKXUm9n2oo9ga96uXFBWw7XsIfjGt/wJZWgBUf
	 Te6PWrCMdSbxyE90Do8gJ5paET20nrHUuQfrt5zplQEp3t/USaVVRuPqgpuAnpijudXd7
	 /mw9Sz6M93NSjHoVrP4Q1i6QxKZY3Y0rXTaIar1mYg8XuRu5g5W35WQan7xfziV2jngSg
	 oVrhu78ghu41o16VzOYytGn1X86QT13E1lRSgs++R4K+2rO76UPx8XsLjzHgtW7d3mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SUNHin0O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A1zHvwHu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB4606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99FB4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SUNHin0O;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A1zHvwHu
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANGH3YU1093811
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pk67/hXS9CWh4vlTcztHypEGoxMFfpG8vfbm7E4XmBY=; b=SUNHin0OhRr3bhDm
	CtAfmREiUshcu9bxq7PMGoMcyYoE03SfrDgJ0hqiASjaqsLtV1Jk+mAWywtR4czA
	KjbVxkG3VQjfS/SIxkPyhKpqGcXWkcispE/n8DM5ZKQGHqtrIXBmOW4eEmoDPzOZ
	XSTgJF0cl55LL4iL2Pv3Szag3X3IrqvoWxzvfvISb1sxffxe0WFQtEkLHyPx2GMm
	wzD2BHy0v+CQ1NM1JPKZ8C72CY3+G2+Ht9/2yfD0EZrrX5Ty3HPOdbqGzPFrpqNH
	tpZ6hSMGUHFb7Z/MPEQ8es5Wj1roZsmWcqqbNE8LQvyY90Ahv96yLSjB0wIPxgTk
	eOGPBQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ma0s8qh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:21:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b41b099809so3021094a91.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:21:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795450874; cv=none;
        d=google.com; s=arc-20260327;
        b=NcPBy8/FgKss0e6ri0x5/arU1Jlfmrs8ge8DOW8DNdJl8WMv1277nHNr0UxxWNDyj8
         YoSEBLn7H4Qzl9LPn4FeFeTZl3GHKYcIJ0+KJtJ93zASJW3oL+5R1HQtp3RADHTLymq3
         CAzz7Iy6FbR81+IGBZsKnqDCjqf7HbzV2pbOavi7heg70KN+HkjuNadZyYMtjlQqecMp
         A6v3clYiVJiUZSOXlOTS8p9RkdIEV1+B0EoMKWmL1tfwRYO4vyTABoAJ81J03r3Lxwac
         Tx8s6JM93scU3Y1KkXeDXX1LB4cBwTlJUzjw+cr5lyouY2xZmbdX0FG/UzUjRQGy6JUh
         fe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pk67/hXS9CWh4vlTcztHypEGoxMFfpG8vfbm7E4XmBY=;
        fh=GwJKxsi9eY+14dStrYzL1tQQcU08vLSmFhhPR7PMmZg=;
        b=Hnei2pG0svG4yPN4V/i9/7i323EREc7Z3d2v+if4Y8cSKkQtZ9TlJf0BEi0UDcXq8h
         yQ0WWMjGj5LxGcPpKpsCRKRbnWGK5VzX2u850nmqBXjdKwlScZ/qhxOmt0pwWiTzFRqW
         HwAnuyV9zbD+icOqVdE8YbUeHoJfmd/wBK1fLruvklzvbYr/aqEWV/BSGqNC6V5pmB2u
         r4u9GotSFftYTJbGiKOPskWgseqqUrmsPBJFu64OChIwl9ffneNKVMkt6vM8v4ncwl4Y
         TqQlNzgK9YnGxsbkF/MahO+zwjAU4FsFbs/3SNgf0BX6v2mfuM3Td7CNSdODHsTQlSj+
         L9xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795450874; x=1796055674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pk67/hXS9CWh4vlTcztHypEGoxMFfpG8vfbm7E4XmBY=;
        b=A1zHvwHu4ho0BioIlPVNcen6by5M+AaLJb76KigsDbRNdWIHWFf1TJjLjd4BliJq0S
         7up/DPRjMjD33DcY/1bM9BJUf0JLWttTbM1uTedLKAsz54rhcN6TaXj82mJaHzFmaE2b
         nxkaVmRjX/d1EH3tptP+qKqpOFHtnMTmwU+C8ZqLxJvxdvb/M9w367ypqDkdWYCHDU8v
         hHD+Cnw9Ivd1P70Q5PfKE37yc84AkTHjxvzUGQVnWUGrFZ/mPzSokB49FrF4EykYqK4v
         HrC3Pkri7BLiPerw9B2GksKphl3BF4/TOc0MhPf9ohLN9pKsyJZJPtTvPcFdXLKMdAhP
         UGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450874; x=1796055674;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pk67/hXS9CWh4vlTcztHypEGoxMFfpG8vfbm7E4XmBY=;
        b=XvO6mu4mk6JAuXPX6MxbUIpAOW2D2mQENXvQTg0T0PnX5sGlS1pjhNUYOZ7LsG4xtM
         HZJEYHYwV/TOTiD8mwaJgjtfFyDLLy4aUVxKwjLfvcy6MPzOR0ll5t+zbAJsOEAtYNY7
         A4OfTz0oFUk/7NvDm8GkVok8fRwtgKSLG7mXMpzLADG6O1ZUmtx0+Z5JOayzmCnp4I/h
         jNsLrhqwZ/jSpBimAtyC9NsOS4mrLLrgAjYBun4jI8ngLGIGFuAzSm2cKS8ut3Oc3K+a
         j+DPuTKx5+mgP803qrEgUDaZMDvOA9yFFqAkToUTYmcA2fkTPtMqysCmyRszE9sm1SaE
         O8NA==
X-Forwarded-Encrypted: i=1; AL+hErFqiJtdPgtqOC0THN+X3eYFSagcISi5JpOjIpf6ANpGdYg0y0a+0aNGxpu3mcTpiM/RJRujk4k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q0mTznzL5czvlZHf02Q2QY4OuQjmC3McmAb9SsR+sT8U0lxT5
	NX3pCOju87H5RUY9t9N+NC1gFmqILQWvxSHz9Uodh7zWbx/3mq8HzNvwSPHTL6mcpiMUHZr4Xvg
	PFKPqanvxDxNbfQ4YGxMUEEBUahD+8b8ljn5T7UuZgqI90Edd9StYy+YPY52qXHS12I5xhN0E/l
	q1WWnmbhmpGrahDQWf5mU/rojKTLZGLU1aHg==
X-Gm-Gg: AZFdTZcaj71qfKM0a2/CPgzz3iDe9pUfTl74YCpTralcNieL0I6r0JVMLdi/4idIBl5
	9Y1/fSTu1Bt7ksJ6FVbnVd0BWZMMTQMTQow9Hc3ojvb1jLUJX+AMHrflXnlZXwkBldiyk71Pewc
	7uPXGr/eNFzTDniCuGHSov0kz1Q+Iq5mrXwij7WA0c5r+IseMwQkd2HueHg7hgE0vZTVbZ8LaZY
	mA/n2x8rQB5zyAl
X-Received: by 2002:a17:90b:3b49:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3b41c9beaefmr11525926a91.67.1795450874039;
        Mon, 23 Nov 2026 08:21:14 -0800 (PST)
X-Received: by 2002:a17:90b:3b49:b0:3ac:b048:fa13 with SMTP id
 98e67ed59e1d1-3b41c9beaefmr11525901a91.67.1795450873365; Mon, 23 Nov 2026
 08:21:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179259111932.19580.13027750156272888992@gmail.com>
In-Reply-To: <179259111932.19580.13027750156272888992@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 17:21:01 +0100
X-Gm-Features: Aa3M54p5hRWYEEHgjaTJlT9_Lb0ZXa0hS2O8Lw6qo7tyI0uEXYOUPeVJEQxKehY
Message-ID: <CAPx+jO8xT3thJqDfTGNDdEe_EZ7fL5HHP-gjy3uZJtvemmNeyg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: clear states after freeing them
To: Anfernee Cao <anferneemelokc5@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: gqRy5X9PqSwsdEpezlPaiGk3x3QqSfV0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NSBTYWx0ZWRfX2zOQ3ZPxBPqa
 PgbHgtyze0aANMFFOFJ2+oB6dzc4vO6N34uIiiH3XAdRiVtc2El4nQiAGucqyCqWMpO7NsaBQrb
 xkPD2EHwRwcrwfUSkB1CWO5YNcFGqpw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NSBTYWx0ZWRfX944/h4Dg6/XF
 OtvgEi21QkZL4VVCGvoWOFnOHa9QUfhk9A/mcUd5ZugKmAO+7IDEUfOZ0fQ7uo2fMo55Bgv/9YX
 iY7gUx80ix8tWXfZWsLaXF+7KNuJasBdx6FAVHAlaxZTEasZcVC6TsO4YrS12Y/RZPitvBH4e5m
 6pD7PKo+50RABnQKG37KUJtXZX7e2zLwvbrS4jqnnXhwwKsFroUHK98s/zbg/Zs8Zuw0V7uKtjk
 VRTxF3GTxbzN5zWOnCweTwsNTTNy0C5SQas7lNCjhx7NXLomLuYP4efhI0uO9cm+cMJr7W+S22N
 4ecdKelVJz94BsPsT/Z40OLs2P1m14FqPxW3td8Nw/ofoDWN6TGLmh0+l+pv6v0nNwWh6nqgPqv
 g8sa7iQrteEgGrrc4AE7zRVlUJK5nsLUU0jazd0x+IzuhwhbxJyY7O5ZK7I7brbkyuGZZiZis8w
 ajwWW/1sKd2AjLMBS4Q==
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6b0467fa cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=gKRGjSYNajUN44eR1FMA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: gqRy5X9PqSwsdEpezlPaiGk3x3QqSfV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230065

On Wed, Oct 21, 2026 at 3:58=E2=80=AFPM Anfernee Cao <anferneemelokc5@gmail=
.com> wrote:
>
> genpd_free_data() frees the genpd power states through the ->free_states(=
)
> callback, but leaves genpd->states and genpd->state_count pointing at the
> freed memory.
>
> Providers that allocate the states themselves hand them over to genpd by
> setting ->free_states().  When they fail after genpd has taken over, they
> still run their own free helper, as psci_pd_init() and the RISC-V SBI idl=
e
> driver do:
>
>     remove_pd:
>             pm_genpd_remove(pd);  /* frees states via ->free_states() */
>     ...
>             dt_idle_pd_free(pd);  /* frees them again */
>
> The second call dereferences the freed states array and frees it again,
> causing a use-after-free and a double free.
>
> Clear genpd->states and genpd->state_count once the states have been
> freed, so that a later free helper becomes a no-op.
>
> This issue was found by manual code inspection.
>
> Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from =
PSCI domain driver")
> Cc: stable@vger.kernel.org # v5.18+
> Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 052ec478dfcc..12db69f53aee 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2353,8 +2353,11 @@ static void genpd_free_data(struct generic_pm_doma=
in *genpd)
>                 ida_free(&genpd_ida, genpd->device_id);
>         if (genpd_is_cpu_domain(genpd))
>                 free_cpumask_var(genpd->cpus);
> -       if (genpd->free_states)
> +       if (genpd->free_states) {
>                 genpd->free_states(genpd->states, genpd->state_count);
> +               genpd->states =3D NULL;
> +               genpd->state_count =3D 0;
> +       }
>         kfree(genpd->gd);
>  }
>
> --
> 2.54.0.windows.1
>
