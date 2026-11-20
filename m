Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795163584;
	b=wC42+RZfpwfF32+eT82dHljwr1ztpQgSemU+no4mpeSrVmnpU2LFFfZ+oI6LKnCdxVcs
	 SLbIaN/YPrkk1u3xyNIbVrDS7yoHfdDv0ha0zRJutHPUdC0zds0nmtL+T4ae9BQ329c8T
	 C4mwZdThIeA2v3ldUQS5UKBPrs6NMkUBaXXBt3IHlLlTBoxiCF0ceDvgpUY5px5LgZdid
	 U0+L3+ymgsa5KJum6J3r2TsJq28CEdnjfPv42Nw+mJ7/ibusBxa3cW3Ul8S1OISbmzK2n
	 30EfhRdctDde4hKG7IXEHsJMhFowu6GWAUfHUJElBGolpgq5OZxNMgEYmVei9Tdf6kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163584;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AwhuHb8kzOf4Sv+VK/GWTnxYFGg1t3CavkDXu4WyyKw=;
	b=AHJ6J7ijh4h2apPkEN2fOHdwx4TwssY+piAq2R//Fvqq9PmDSMSoj9+mmbj2acZJW2bD
	 qSzgHeC3LS3+ieCsbbLqpvHyYeQef/2sfq9/klMV3cTZ6i3ZTvai1zglpAtRlKvy2R3uQ
	 LJT74LFoisdAIi9K4hibVCenzlov9VexV4OkiJ3Jbo8/Hm7R8t1XJLpeN6pb1knBVxBZy
	 Mpp6YxIiS0IzQR/Jfk1qGZvGYxfSy6UsqaF/epXNfyA34dxG7SVJD2PoocsCznoieGceZ
	 dm/P8pQXhPFQ5bnMNYukCweutNMPb0HVkybhAfqrnU9500IZ0QVmO99qe/6qHHI2vxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AkMpuipO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="bY/H1PAg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12C606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E12C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AkMpuipO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bY/H1PAg
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fq372695555
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AwhuHb8kzOf4Sv+VK/GWTnxYFGg1t3CavkDXu4WyyKw=; b=AkMpuipOaXUQtf44
	LKnET7leBzKWmLPkW706dCVmxRawALoP2UOII7YjXnYENh/C/2muz/3xSK7iiubO
	yja2NECnxTbE7LHzKVAWycd4APujSgH6EX+/5oUuHEzX3AKrM7Vl+T/1tE83qdKp
	su9E68arYKGVXgclpypqQAfb814KfdaIEGXdCGVV6m2BltnYz8jUNc17U2twrmjX
	PZUmDnRTbZTnM6EZetbXqpGTcTZkbhy2gIyiUUtJ434I1xpsYXH92uIlFRA2oWe4
	DCRtQZmjYg0ebi/RL0pimpkMXyYhDXUGxvLt/XYbmMfL793SYtq8ny0p6oKGBQQW
	exHIMA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au2q56-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:33:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f1f2fafeaso87918885a.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:33:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795163582; cv=none;
        d=google.com; s=arc-20260327;
        b=dHkJejUk7N+2PoAG6QfkWsiwPzh9VW2ejAUE9lJ/ZoL04KSjn4IdtASUDqIgbaUx8z
         0jLAicypQHY+bBllQ2k4ZSW3SYErrWvaavrXrzrnO3ElLM7BT0/CirHbRc17wk5pW12z
         aXf0HxBXjYSAfiITW9/ngvbOH4dOaSSZVGV8HWZmOLu3DJKrJvZy6xTRS0ihiHZYHhfH
         1C/kiISF3+LpJNw6axeGBzXASwZLUc0Bd/hXwmn77M4apsQgJuYmnYqmNPJmJfCGCcae
         zKqnGfKhA57WM/U+xuTyA/gUpzjecbYqBW1yeQXiPkogKeIb+1+aiI7Vvhk5lRfBjGul
         EouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AwhuHb8kzOf4Sv+VK/GWTnxYFGg1t3CavkDXu4WyyKw=;
        fh=rucu1KXpMWqVJ3jHhDXgJ5ytVyyKpSR9Hyxv6a87wiQ=;
        b=f19xH7n4XpJsBSkSyuJl3HrjCe2n3x3uXQcy3hcC5mUkI7b/zQXVyEu+ZsbCn0wBAz
         Re0qPBH2OIof/AeHpFYVkhqbKtCABtJocNTyIjrf/ijD5ZSIitUzS6/g2gvQfWM8e5WS
         ktk1Cl92FjGsoFwqNOROMrn/pX8iYZDT/Al7eFmKaFg5jlWxJtYlHffdlVrW5xaV0ZID
         Zxby2dNPNKCQLY0ZNNZRL6XGBxHMpzwEb7Ca5TD98PasbKexl/CX58iAWVO8OKS7Ner2
         sv8C9gnkwj9VO/FhD4T1Vsp3TQYvzD4uD4hTBpzsDdzvIeLIEqbkSik/r8YieAZlMV6I
         9OOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795163582; x=1795768382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AwhuHb8kzOf4Sv+VK/GWTnxYFGg1t3CavkDXu4WyyKw=;
        b=bY/H1PAgTU6t7pOPxCBNbQC9ZYUKPl6AY+CCqVcyeNY7uWBFqCUHpyJpJcqPZL807y
         jVBmPEPfzxix/UMYqfzkiY6TrKKVrkhN8VCZ7XQYOfcWzQ3fcSJI5ZsCC2jVctzhpZgT
         +rQveC/jnyIHVZn7Nth12x2NA1ofo69otODYg9D0kpMLzxCamgdsE532898/MOVYFpJC
         wnIdYlmRwyrMsEt/5Gx3YwJ9BMxcKXT/jFhzF6k/EGHKjGyu4NpAp9De/1n7f0G0F0wX
         w3Reub736UBoHvOuu1CbGgCo29ZDj9BVSCnGOmN1Ovr7wN30jNtdYS9NY3WOgwFjjuyu
         Vlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163582; x=1795768382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwhuHb8kzOf4Sv+VK/GWTnxYFGg1t3CavkDXu4WyyKw=;
        b=DAgGd12j6kR6P/mZE3kmbWHcgadOOzN2e4jb72X+tCViXa2zJrQAAvaGxOJQLIWrDB
         l3daU7rvM46jnOVrRplE1owReZSHmj1oTNxX/1c3C8TCwSIbZvKf1l60lP9U86oZx6Zx
         v6FXd1cC1uy5V5l4WCQnwIfv/5+Kh/aYJmKwWKed4BvZFRofSmPfQoz7Kdvl0D6s15Kz
         wAIc+DoPCJNJueAWkJjo2aDAeropURr2S22+u8XPmurfstw5ftq3gfZDnQuM4AZD4Cwi
         Ss63D9n8f74gU1y7ONzZxn7+CSzgQx8P6f6Z84cCJe+gUgYQ4UMM2bJvYvgiePddQIWO
         q/VA==
X-Forwarded-Encrypted: i=1; AL+hErFtC7FAc8ujWo6tIU2kGN6kkQyxsc0iWIxgKTW20ELVdo+6F093XrTYls34/V1gra/9EQ9loKk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZF6Oi8bN+HwgKhTpyzKa4awNk9RY020NpU1ZSg0tHOCOxNb0C
	NcCEW2+Imm6iGwK4+XkoWhF7V9zJZgoITqzODUZer+Rkjfom5hDwjv8OldsMVN0rvVKs+pkhuWl
	Y/B7TiqKJmcsYKTzt5heNQ2clBhGyixGXaDvDr86m/WlmmuasKj/xSQYSJ6WKpjEtZ8bhQNWY2x
	s3S6YC/lXcP0A7wVJfcvzWrbksgJDIitIwKw==
X-Gm-Gg: AYBFou0jA233XX1oQUJT66QqMMyFoNtRBFhYNZgfEUKFpkbuX4exkcIw9gN/HmQ6Jdk
	kIlFEazTHUn0UOOWYR+ouGaYsHoxQM19ElcQPq3/SulZ+9Tf3Ow9gfGhet5Tpy/fHSecOtGqAcV
	60o/02ZKucIODbZUvYR+JRglVtbTuzboNieGkLIr7IARAPNcGzBMCzsQYcAjVfnMmEJfpE/xBJH
	1NdnKpOywUilaycLchqqX5srOHWSzuLP18BcJtE92AWPhnT+33vvy9VzqX+ZJA9EfFTs1JWK713
X-Received: by 2002:a05:620a:5394:10b0:949:bda2:194d with SMTP id af79cd13be357-949bda21c95mr163124785a.83.1795163581566;
        Fri, 20 Nov 2026 00:33:01 -0800 (PST)
X-Received: by 2002:a05:620a:5394:10b0:949:bda2:194d with SMTP id
 af79cd13be357-949bda21c95mr163123085a.83.1795163581044; Fri, 20 Nov 2026
 00:33:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-wcnss-series-v1-v2-0-3fed518decfb@atlr-engineering.com> <20261120-wcnss-series-v1-v2-1-3fed518decfb@atlr-engineering.com>
In-Reply-To: <20261120-wcnss-series-v1-v2-1-3fed518decfb@atlr-engineering.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 09:32:44 +0100
X-Gm-Features: AclHuK9d362EMFPFXhM64AVRYKskGoTlaSxy6WxsQcqESpcHzMJ2h3YDR0lL_Mc
Message-ID: <CAFEp6-3TfPV0iy3O=HKZXPhpDpRLffL0RZZt8n9aVBk-v_HQ8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: qcom: msm8974: Fix WCNSS wifi interrupt
 trigger type
To: arapaille@atlr-engineering.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@lucaweiss.eu>,
        Eugene Krasnikov <k.eugene.e@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        stable@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMyBTYWx0ZWRfX8sUhIz4p1Sq4
 ymVAiVx8PjYNMHl7iFOpvZNzA609d8XFNQEIcewxdV1eg9wj1I3cg3u2hshjr6oHAzUhFSxHJL4
 pwtdofGLBiIklYPAWswhiV1pS/u3uxZNTbJ0Uwcf+CXKnz74ZWJFZy+ePXPGoUvcD6vItuN5+v/
 KR7lXWnYieHaiujyGcCPnbZuZriWbl5OqoO+HBzDUC3nClSRIM2EGCZtUQ8MIBEifJnWPTB1aN6
 X1cZnRaFSxMRniOhC6JUo4TSPCAGFVUbcdf0AR+m+IMlqc4l+iNgdorigLkGq2nIWVALtqP7r/b
 gDTi/EVu+cdegihiuHcp6H7I24drVGoDJDvPr7SS7Jti3zxHRqI7n7p+URbK5Xyit6AtWCP6NZi
 hr5LDPXsfqlhSV2+Ay/KfdSLBTWICOi7uwGUkTLIu5hOpT9IqDAJfoOXEHon4ydhpcWXXvrS/Hv
 Vh9iu64tQAH4St+1Omw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMyBTYWx0ZWRfX4wZjkI7d+7Ts
 4ewdv0vWvFscyOXLqferzkBVoqdZ9Ts9h6fMYr7Gs1UTaglyKR0KyrlkTmo+KENTq9N6Ky4U5Vt
 GC9/FDChcLHKuU76UB74HglcPw9nu0g=
X-Proofpoint-ORIG-GUID: g7vEp1_ptvGds6ILuv6vZAI8BSTgyJ5x
X-Proofpoint-GUID: g7vEp1_ptvGds6ILuv6vZAI8BSTgyJ5x
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6b0005be cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=Knk3v0qlAAAA:8 a=6H0WHjuAAAAA:8
 a=EUspDBNiAAAA:8 a=idF7ahqy7yQlu2L1qvIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=L2g3GqtBoyQv0ocsUjqh:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200033

On Fri, Nov 20, 2026 at 9:05=E2=80=AFAM Alexandre Rapaille via B4 Relay
<devnull+arapaille.atlr-engineering.com@kernel.org> wrote:
>
> From: Alexandre Rapaille <arapaille@atlr-engineering.com>
>
> wcn36xx requests tx/rx as IRQF_TRIGGER_HIGH, overriding this edge type, s=
o
> the re-probe after a WCNSS restart fails ("type mismatch, failed to map
> hwirq-177") and wlan0 never returns. Use level high like other WCNSS SoCs=
.
>
> Fixes: c7c0edecfba8 ("ARM: dts: msm8974: Introduce the wcnss remoteproc n=
ode")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Alexandre Rapaille <arapaille@atlr-engineering.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts=
/qcom/qcom-msm8974.dtsi
> index f300de74c4..b9666feb8b 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
> @@ -814,8 +814,8 @@ bluetooth {
>                                         wifi {
>                                                 compatible =3D "qcom,wcns=
s-wlan";
>
> -                                               interrupts =3D <GIC_SPI 1=
45 IRQ_TYPE_EDGE_RISING>,
> -                                                            <GIC_SPI 146=
 IRQ_TYPE_EDGE_RISING>;
> +                                               interrupts =3D <GIC_SPI 1=
45 IRQ_TYPE_LEVEL_HIGH>,
> +                                                            <GIC_SPI 146=
 IRQ_TYPE_LEVEL_HIGH>;
>                                                 interrupt-names =3D "tx",=
 "rx";
>
>                                                 qcom,smem-states =3D <&ap=
ps_smsm 10>, <&apps_smsm 9>;
>
> --
> 2.43.0
>
>
