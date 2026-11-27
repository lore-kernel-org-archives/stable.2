Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809514;
	b=z5yot0XcKb9bVf43bwHpEiX7AI6GSgtZyFHNc9A3/3kvN8M+Nt/v5BP5JRxh/SyAjnMx
	 8fuBf7UWZvzLnWCi+ltaemsfMFRTlXv00TZuj4f+tKxwiOk7uGlZAzpjZi+/7wrpsq2o/
	 5DJpmWOuR4zLEv8i0L7lVjwEC8piIQUn4q35GocKDJnNQvMIrYxBEGxAQ2nukDKW1lNsg
	 TWXz9ubIVNZmgXW2NfreNJenmhavs1nfitQltnYfa6cPsyqAmIW2lXfYzl1Y3dOzBjzdz
	 IL/+XneXwi602duVna6ErnFgAzPr7Kap2JDZK47z9dnmCGh5N45IJNZJArHn1FR/25g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809514;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+XTNWIgi9ID8EoeN/DwyL/tKJe5joumzVvmrChys3j4=;
	b=DK1rMbszor2rku9YmGI10pmzyTZ8xr2cpVeSLFR80F6n75JNCYhEW4rWzoRfsIZtp/RW
	 GgnDLHE2BjZAHCy00+6w7POcdJZcdYj0kZpAIzaGEI+gSUaLx+aYdFf/8wTnq1ktjWkEg
	 +kKkqXPdokzbWpDpAIQ2UHE1yVzdbaYB7G8L/83mILny3kfH+uEUEiUWK1H0ASUpFHNYW
	 LWjmlzUeJ5/pYL4Z+bddMf1HwGPli1LEoKzU2SL1CMAyHTfK3iM/L1QfODut1xVt9HwOP
	 +6WFviAg0zXGejzEh3dYcWoIuZUKsZjy1ECxwBMl2Qlqza3WGUXAk6hrnpYQI9iKeJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g3FX8NKb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OsX3jgu6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A56606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 19:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A56606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g3FX8NKb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OsX3jgu6
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJRK4p2668932
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 19:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+XTNWIgi9ID8EoeN/DwyL/tK
	Je5joumzVvmrChys3j4=; b=g3FX8NKb7bzFF9rqGgqaeJGhFiOFZPYid3kFU+dw
	H4wUAAiqNfq2dOJU4uEG35zZVPR/mjCoWWOLltGW8MYRPw1ewdCbr+fW0r+ktYT9
	R7bGvYPtkknaZ+X3X4TUds3mvDYcrh+BtQVvOYed45LCnUHK9GIcPR7EXthKW+pO
	uxc2GME/0mZ/7Fdh6tiD1/BJ0lmxSspyf0B6m4UzCz+SyiF4OO8teYoQcaGzcMMp
	F37MTtK/umQfmwA1mP7CWtb52gXC2rLRLIjk+gdBCN60h9/32UPAhICCW9zqN07F
	pAgk3wOA983UtygjFUiDJHDfKpwkHPWgbmjlz65gKdE2uw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g1jg2ak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 19:58:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934963b2bc0so1445757985a.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795809512; x=1796414312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+XTNWIgi9ID8EoeN/DwyL/tKJe5joumzVvmrChys3j4=;
        b=OsX3jgu6YYt5dJBvCs9pxRgp2DWcvrW6syOkodpEhu/97WRdeFoA0fZ0Y3Ei5lfpjE
         L+oefhX2rt6CBO9iqGNBIGvSF1ItoqU2NQIzznBiBFMnWbaz1AGQHgSr3dmWbdJSXkd9
         ppSA1/jW3qB8cHBjVXG+6/R7Lb/Ib+k1+Tj8iWhgfOj1wR7hDb1WzTM1z1Ib1wsZ+sLO
         bhp2vygwxYJvhHPLB5sNKJRyfEDWRouZdhBM7F+Ll8CJ1ksOXmyHVpZuR7zxyM7Ivr0O
         0m2R4R0HTl7fkP50gN3YZP7wWih47DyQ0+VckQn+qrECu9+kJP3JaVsdxB3z4WyVukZk
         g5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795809512; x=1796414312;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+XTNWIgi9ID8EoeN/DwyL/tKJe5joumzVvmrChys3j4=;
        b=ahfa2JTq8Iy9ZJGGgJE4ipE6RV29/YgxmyDC9YtiVzsYlKOZGmyfsr3PqjWMXRyamL
         YwmKEiYOwfg49bplteC14bI8Uuwc3+n/GPBPWQDKybQ9edIUNENInhLHUVi74a40Rst5
         AcdaleABcgy0mpjCyf77PAdRz8Pe6s9dwozpYmvwpSAI28u/zW4V25ZPBK+QMTbI3gPj
         N+LMHOWqUgFlS5GCz8lN05eX7cl11fmMv40TNS914h8ZypaDMevIXcZXB8xiZVZHiAb0
         f+/ZFena1phYl8vIsAEqJSEOgd/LcpSKa6b+XVX9O/1el/Hyr2x4Nx0uQaUkX3wnesG/
         Wd0Q==
X-Forwarded-Encrypted: i=1; AL+hErG6jDryjcG239fFJQUDbJy7Q7YxvlYWiY3iLrTnAYqS9c4p4dTYrs123UokFy8M3b2+b9Op4W8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IEHyqW3l5iEcTSADdZC1Py9IZDUigPqzmfogZLVTnrt+gMBye
	mibJl88qVB3HEvbt1blvgJPWDODoRwbzniPijis87XbhFztoOLgrU6RKCGQDfIxIsk8vHH1jKkp
	S+8ZQ/ah/dw/xL9bFZoMBMGn3oTvCMQFkPWIhxSbr6lGyvRs/2OVJDyswvdg=
X-Gm-Gg: AZFdTZfLjsw+BHhmFXrhoq3lxdtJEW6637JOVjrNFu/4T4LgDUavgftdtzjCZ3qfbfz
	PqdUrXieUBGtWN6AI9LIbHnl9Ms8twBpaD8D89/B9WnQ48MYMWd3TYfi5krHZoUapwUVGdaFHZu
	3Jmz3ELEMNs+v+gdT4b6vnb+gfB2eegm+w2rWbr7Dfbh7L71ax4cONK7AYbuP0kiWl54hQ/AEhb
	3zIulDfDzgHCFldDDM1154Fq+53cJr2I+x6nwvSkSMTXthZT6w3jkhujKwEl24co9QwhyyG4zkG
	1gL9LGp2fFixz+1hRou7AidmvP5Y/Mpz1Uuz0djpubpA7MvbPQ1TwIHrn95dsVj1C+VgzCMLsaJ
	yo4JN+ygxTrXeULmLHbI7zBIOclovgyTvwVdu+B5Phhgn4VM5+FEI8JWAhBKUqd7q+Xviahtihp
	zqL3o6sO1z4RNxdq700UCmPDUAbKIZjG39pu0QpM7jUZwooHelEuk+CqSAVEB+Bw==
X-Received: by 2002:a05:620a:8005:b0:949:3066:5569 with SMTP id af79cd13be357-949bab2f113mr4792665085a.46.1795809511942;
        Fri, 27 Nov 2026 11:58:31 -0800 (PST)
X-Received: by 2002:a05:620a:8005:b0:949:3066:5569 with SMTP id af79cd13be357-949bab2f113mr4792660685a.46.1795809511466;
        Fri, 27 Nov 2026 11:58:31 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd041813sm6192040e87.53.2026.11.27.11.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:58:30 -0800 (PST)
Date: Fri, 27 Nov 2026 21:58:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Michael McAllister <me@michaelmcallister.org>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: clear the DMA buffer pointer after freeing
 it
Message-ID: <o7iv6phsonvuruw7oufoj3d3glo6hpknpuwedue77wnprum2gz@ws2ux4bckblw>
References: <179422752570.88190.13452031230666113805.msm-dsi-pin-leak@michaelmcallister.org>
 <6m4cssgagnpvm2wawyj62veoqbglxv62rcqgxzaxvjynhn3dts@tlkaxvd6ph3n>
 <179458248277.51880.11276326781897812340.msm-dsi-double-free@michaelmcallister.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179458248277.51880.11276326781897812340.msm-dsi-double-free@michaelmcallister.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OSBTYWx0ZWRfX7Nu+EcA97uDo
 uMGACePNisNhO1TiadS4W8Wp4Me/4LAfh+gcr2ekxYJOqoj3vrhqxeauhW/Bs8oK3L78XmWOXah
 itxJhOmpOBb6GoXjkXkFjeg7QxBBLvmjxpCmOteA6dCwAt0Ik0gSy9dKv7VoelXrDmi3dNqFI3h
 fTTT7xIFsquJ5j5/NUUS/myvs+qyWNv9LrwFGHTxweOLrwFMu6sIXhF8IiqCSzNupdc7N4Np4bL
 czBKUygoW76VAWVKO9NJnNRiwm+42MjCfGUf/tG/1/U3vW1d0WKNSAbXjyLjqRMR1upHHwMHcYB
 QnFTSivqmZldB45vliccgnRaN3myFkmhfcszWUlPCoc4rrFmQnF0JRWkcNYamdTXFvX1h8+ufef
 Frbzkay3L6s0kYGiKj6zFwzEntJGjh9/luJWiCu/qxKaipyMyaYQTrt/tz9P+0g3sRUo0w+0nWd
 +OJW5Um1rfF9+Ah/Jvw==
X-Proofpoint-ORIG-GUID: hJZ4fS41OlXGCKRrw9g0xYUlByDGQtMe
X-Authority-Analysis: v=2.4 cv=QpzLTlyd c=1 sm=1 tr=0 ts=6b09e0e8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=JwJ85b4fAAAA:8 a=EUspDBNiAAAA:8 a=hKRTAnW6OJ533CQEYPgA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=qg2vb7sgHZQYDKbllo_a:22
X-Proofpoint-GUID: hJZ4fS41OlXGCKRrw9g0xYUlByDGQtMe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OSBTYWx0ZWRfX+PfWPW7ObPH3
 6jqiCoasIHog5k2fnYhcVxH3k0X9w0tq6Lb+azvaU3KUVBjQj2o+GexqC126KQ9oZj0+ruwEM7u
 jh9jLDaPzBazDN1ZhqkeTZ3AQ43kVT4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270079

On Fri, Nov 13, 2026 at 03:08:02PM +0000, Michael McAllister wrote:
> The DSI host survives component unbind. On DSI v2, freeing the command
> buffer leaves tx_buf pointing at freed memory. If a later bind fails
> before allocating a new buffer, another unbind can free it again.
> 
> Clear tx_buf after freeing it, as we already do for tx_gem_obj.
> 
> Fixes: 5e05be782645 ("drm/msm/dsi: free TX buffer in unbind")
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/bug/linux-6f5085d3-ef49-482c-86e4-a2438bc1b91f
> Signed-off-by: Michael McAllister <me@michaelmcallister.org>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
