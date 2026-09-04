Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B083D5222
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507945; cv=pass; b=AoqjN2aMG5B4yDQ3fPRqcPyBL3uArrjOLJVlk8kQu7qp74vBf7HN0mY9rt0XM7bOyWHcyJD0jpDrYBYTE0pfkHVJKNl0aLNyAvQViBxHuHpcLNJN2DqWuhgQbU6xihhEbRX3OG+UKoMAAXNSEr8CcV8vv3BBtip4WBkb5qHHTiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507945; c=relaxed/simple;
	bh=U5ApS72uEjKEs5mPiYz4Sb9WyBZ+8Xb3wknNXul3qjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWVWLGEw3FUbzg8j3MQfpMbXCb3oBBo3LhZLChQ9MPZqofoatrQs7HLMRA6k7GtsDjvgyjiXKejjk/d6f9YS+ds7dx3ffks4kjqYH3nBsc6wCx/xOzZqBf0qcbqRRWdOgrh+17KODqXCNdqHMP9vVYpowgtO5y6pgh6yPRjPwaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CBgs5nlb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D6Aullbr; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CBgs5nlb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D6Aullbr"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68462lsg1545537
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 07:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q6qZ2VR8/sUhxooIKjGel5j3+haR5Iv/MA+vGmwiZbU=; b=CBgs5nlb0vyHXZHE
	CfDIHz9bdopunyqpjuPfCJiVyzLGJTJSSuXdV5NOM/FWd3auNC77Od7xTOIObTxX
	m2AK68aaHGeFD/nMxdZQPcoTxmfAgXD1XVPahvQoV4XeooE131fHZ2nYRLedLXSb
	7O6Zsqly7jU9cIKtCQGjyVH2YNWzIgdW8AOnOQJrn4kK6Gw+x1jO9+ahwAVPD14p
	3sSuHwykqgQunS8swd02Ls+1I0iMrbcN//Hu9iW86cjEGa2VgLR9JIEsH947YNxp
	5V9ZPGk1e+q7i4k7WGR0+I3zs7LL4SAbQ0ODb9LzNfWiDpePeRGGGPU2T8JaeZz4
	xA+raQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfpmqrp4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 07:45:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930b571432fso118361885a.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 00:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788507941; cv=none;
        d=google.com; s=arc-20260327;
        b=ZMMuC9zBO6Wb48ThQrniquoWvpdj+rZIfQTBEMtJdLjnMK8bdAWyi26lNQ8cru5WKY
         7nZe6cfrjlwDFKrN0j81vqSHT/8mVOHuqxLubJeEWjX+a5S2ae+sTQiFvUELOmXts9DR
         l5CvG7g0AG1oM1htfAUidH4sKtDzl9Jf+V3qPEuUOSikMAySysYNWbXAZjwL5Bqt77lB
         zIWv9RYLLuwN7RxO5gZCuE+LmEqNlAezXYEQOHFryCZhuXGPM3oG5i+FKlz8PlP7uNa4
         RN23d0hCbCQ+sct2kI0glmIzog60HghEOnFdyscbscHYIa7fmeS0+pXww/aDTGFXI1ok
         MfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q6qZ2VR8/sUhxooIKjGel5j3+haR5Iv/MA+vGmwiZbU=;
        fh=aeuHZb/jXip09w7ooI+7ItbjvxfMiYFherrXMkbOats=;
        b=AuuzrJiRUUx/NII0Vjx4jJfaPdHz8nWY1J2FRWrHLOgRkplampGbk9Dgy6phJq6fzA
         aSiPZmuVuL2G9MrjvKqbHi8X9lxSUm/DUTOuVUorAj6p9wBAASB+2vLmxtyMv/E6Gwx9
         WGa/LltnVsKUA9DM1fF2PGbR4tIuWYRptTL5RvQlHWOw2w/QNNxMNR7aiUwlsn8xr0NU
         pWrNmZiVMka+rtNiei7Vdfgsl60gSP/L3SVTlKeQLfGMgyde96JEZPXTifqyq4S0JUiK
         O6c0F28+CV06q/X+320x3k2KHV78OBLD9+5wW5isjtVRhoIKval1L3fEL1QHam4rnnYf
         4dCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788507941; x=1789112741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q6qZ2VR8/sUhxooIKjGel5j3+haR5Iv/MA+vGmwiZbU=;
        b=D6AullbrfQiasS7lzSqRVaXsKOzCh2zeEySlTnwnUhTNOKq6vkZRaVFGtWwDOTJp4R
         Q+yK3w89OM7KTYUsnbsynJU/cH0qtIvXN6zGAbe905KD08CA5v6rNgLQhrVgIC028AxS
         kvPcbszGwSpscKirwyhQMJ8HCKI1nYxS3kJOA56SfU99Zpmjw0srNqxXA6zoscTAVz8L
         CHfetgs5EydP9gG2bjQZCMwkURGlpJfDFvSxTV7F+nQuBU4VT4RHhov68IXM/Xi3fnW5
         n/zyboDkq7ZwaCruPVYMuaz5RDJLHOoUnBaEwcluh21P+4VEjhUkUIHpUYYgVLCU6WcY
         pLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507941; x=1789112741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q6qZ2VR8/sUhxooIKjGel5j3+haR5Iv/MA+vGmwiZbU=;
        b=iqbSGQRj0/9qAkQBK097FtPRw4Bj8DNdk7IHKXjn+rQcF3a0o9uO76Z6uubf1RjjvA
         6lA2ey7BdpKywz//Xnp1B86J4b5p0glGl/ZuzplQsL9abVmBWryVOOTAZFKCW+AxolSm
         Amf87mLLh0Sf4VpNUm9JXnlykn/BzhDzNcnhLfWBRfgauTGsRYecVhgiJrPJaG5yqMN9
         DpTKzsH1sZ3+f68uQs8lHsLY7R/5WNs05mLjA8tykGVHArUjv09SDcMCxvNKKseDFRTU
         A18O7yywy1BDfAKEm6Ta/2qtDZTiGAyVKaXHD6Ds7QOMI4E3U+ibYf53l3JawtGvEcbK
         TCcg==
X-Forwarded-Encrypted: i=1; AKwUvByRGlLJBCT7mXVmnO2iqkFlQQK+F8AKN3WCLX+sS/yVl9+xs+cyXOu7IhFlfDtElOvv7PiVGVI=@vger.kernel.org
X-Gm-Message-State: AFuF++kByPn6EGY+s6KmSZBW3RSNLsnXeK/FdaxCCtpLOG5AvQfRuBKk
	JkzEeGRqb5owKrtXDH/jqZ1HkxklPYXEHp/vsNp3vNfnL9GL84XOZW+Nmbe3RQXIrgt7Eja86YM
	N3pYcLiwpM9WV7BDW6G++tFeX7pUZnemx6sy2ddlcds2bv5/QUMMGQfbQi3METzKBGhzqEb2yN4
	y5AxxdfN0WK9erNfaPCuBiUFqGcogjxEPFAQ==
X-Gm-Gg: AYBFou3EtxyWkfoHUk5F5LFdzRBulwTfCR8uDzJuXnoIApliR5YgcfoqhUOJzChb/X2
	E8WyJNV6kphLwKppKnHXjTHpxWVZpnJ1yHtVM7yVzbq9SsltxvP3DIagkBtIw6mhp0vrHA2WsAD
	p+36JyNh/xBJEpYOwJCTMa7pGXDumSS2DuGclmZU71pKBKrwSDnWWX+k+j/7gPm2sX5J1iyAvoA
	f5WNDQmESeL2g3hs1dmFniAsswZl+xPJ15Zz0L4wMRWvJKYhxrWYVMkBTQVOuu9e+muz0Cp/sfb
X-Received: by 2002:a05:620a:bd5:b0:937:4550:96c9 with SMTP id af79cd13be357-9396e0e1302mr1054102385a.21.1788507941441;
        Fri, 04 Sep 2026 00:45:41 -0700 (PDT)
X-Received: by 2002:a05:620a:bd5:b0:937:4550:96c9 with SMTP id
 af79cd13be357-9396e0e1302mr1054100585a.21.1788507940986; Fri, 04 Sep 2026
 00:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v14-0-01ef1eced075@linaro.org>
 <20260903-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v14-1-01ef1eced075@linaro.org>
In-Reply-To: <20260903-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v14-1-01ef1eced075@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 09:45:29 +0200
X-Gm-Features: AcwNN1WWU5FRzvZrK5fq_LzdAaGftwm82SLjDwjNGTlCYX8Fb3yJIL48uBH_wr4
Message-ID: <CAFEp6-2nWfjF18R9pw0xFt92GcPORKKa+ix8czQ=m512TYuP8Q@mail.gmail.com>
Subject: Re: [PATCH v14 1/4] phy: core: Fix use-after-free in phy_get paths
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        "Bryan O'Donoghue" <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felipe Balbi <balbi@ti.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA3MCBTYWx0ZWRfX/v9J4v/ojoR3
 d9/AckrzqEWc37S9dgkmMpJDIooGrH4BNwfdxgWffAIsHy3+nwjiyk1uWK9sSYSzf3vscPjg4rh
 lmJhVYs5Ag8eSIcP47NnOZMexXF6C7Q=
X-Authority-Analysis: v=2.4 cv=eovvCIpX c=1 sm=1 tr=0 ts=6a9a7726 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=j3EoGy_XDV5ESBrvTGYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA3MCBTYWx0ZWRfX1BQFKcYEowvW
 d03FBnu/fbLeeGoHd5hK5DLTuaCLRmwG3gnTQPlVAjG0wM22rLrFhuf3xUXO+hXiiLONsWhBt0Q
 +AEJvxUF/t2TpmTwrKqRZMP4YxQNM1IZm+ryhF0qpIMapqTIoLUVYMPwRIp9lvBs8uXlV7cNj7Q
 Mfi2JazDdREvUtE5Kp8MjDJDJqnW5Bjqjm1Uc3jUlXFn9+CApAsApJrH6l44si/QDhdbhpuq5hp
 4KwbYyKDlmeh2c2pali0cCy4PIPY5165gKjqkgt/COotT3ANXVVIZ9SqHDm/KgmUVHj0Czvn/9F
 zTo0dW/IPAhAIrfrYeP15XVUyp2mmiIBDX+zhYrw9dmIrW96ZDpurLR4XCZEngXOB6XgWqrCsUi
 S5ZzoVuidjPSzkfq9EcjgwPQmGHCo0Y6h+BzDe2o58yKtw1v/c0xyB/K52KDLQptrG05JUJLDpo
 SsGezdxp6O6FYN5/mUw==
X-Proofpoint-ORIG-GUID: 7Z9yEifckFGTUZfsP2QjyFtOJPzphPfr
X-Proofpoint-GUID: 7Z9yEifckFGTUZfsP2QjyFtOJPzphPfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040070

Hi Bryan,

On Fri, Sep 4, 2026 at 12:59=E2=80=AFAM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> Sashiko asked during a patch review if the existing usage pattern had a
> race condition; specifically in of_phy_get() if it was possible between
> returning from _of_phy_get() and running try_module_get() that a module
> might be unbound leading to use-after-free.
>
> Looking at the code this appears to be so, there is no linkage between th=
e
> phy and module under a synchronisation primitive.
>
> Using the phy_provider_mutex in phy_get() will ensure there is a link bet=
ween
> the returned phy pointer and the module_get() bumping the module referenc=
e
> count.
>
> Amend phy_get(), of_phy_get() and devm_of_phy_get_by_index() to fix the
> same usage pattern.
>
> phy_provider_unregister() must take the phy_provider_mutex so amending
> phy_get()/of_phy_get() to take that same mutex guarantees there is no
> use-after-free.
>
> Fixes: ff764963479a1 ("drivers: phy: add generic PHY framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/phy/phy-core.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 21aaf2f76e53e..cd9ace125567a 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -124,13 +124,11 @@ static struct phy *phy_find(struct device *dev, con=
st char *con_id)
>         const char *dev_id =3D dev_name(dev);
>         struct phy_lookup *p, *pl =3D NULL;
>
> -       mutex_lock(&phy_provider_mutex);
>         list_for_each_entry(p, &phys, node)
>                 if (!strcmp(p->dev_id, dev_id) && !strcmp(p->con_id, con_=
id)) {
>                         pl =3D p;
>                         break;
>                 }
> -       mutex_unlock(&phy_provider_mutex);
>
>         return pl ? pl->phy : ERR_PTR(-ENODEV);
>  }
> @@ -635,11 +633,10 @@ static struct phy *_of_phy_get(struct device_node *=
np, int index)
>                 goto out_put_node;
>         }
>
> -       mutex_lock(&phy_provider_mutex);

Then, now we're moving the responsibility to the callers, maybe we should h=
ave:
    lockdep_assert_held(&phy_provider_mutex)

>         phy_provider =3D of_phy_provider_lookup(args.np);
>         if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner))=
 {
>                 phy =3D ERR_PTR(-EPROBE_DEFER);
> -               goto out_unlock;
> +               goto out_put_node;
>         }
>
>         if (!of_device_is_available(args.np)) {
> @@ -653,8 +650,6 @@ static struct phy *_of_phy_get(struct device_node *np=
, int index)
>  out_put_module:
>         module_put(phy_provider->owner);
>
> -out_unlock:
> -       mutex_unlock(&phy_provider_mutex);
>  out_put_node:
>         of_node_put(args.np);
>
> @@ -678,15 +673,21 @@ struct phy *of_phy_get(struct device_node *np, cons=
t char *con_id)
>         if (con_id)
>                 index =3D of_property_match_string(np, "phy-names", con_i=
d);
>
> +       mutex_lock(&phy_provider_mutex);
> +
>         phy =3D _of_phy_get(np, index);
>         if (IS_ERR(phy))
> -               return phy;
> +               goto out_unlock;
>
> -       if (!try_module_get(phy->ops->owner))
> -               return ERR_PTR(-EPROBE_DEFER);
> +       if (!try_module_get(phy->ops->owner)) {
> +               phy =3D ERR_PTR(-EPROBE_DEFER);
> +               goto out_unlock;
> +       }
>
>         get_device(&phy->dev);
>
> +out_unlock:
> +       mutex_unlock(&phy_provider_mutex);
>         return phy;
>  }
>  EXPORT_SYMBOL_GPL(of_phy_get);
> @@ -786,6 +787,7 @@ struct phy *phy_get(struct device *dev, const char *s=
tring)
>         struct phy *phy;
>         struct device_link *link;
>
> +       mutex_lock(&phy_provider_mutex);
>         if (dev->of_node) {
>                 if (string)
>                         index =3D of_property_match_string(dev->of_node, =
"phy-names",
> @@ -796,15 +798,18 @@ struct phy *phy_get(struct device *dev, const char =
*string)
>         } else {
>                 if (string =3D=3D NULL) {
>                         dev_WARN(dev, "missing string\n");
> -                       return ERR_PTR(-EINVAL);
> +                       phy =3D ERR_PTR(-EINVAL);
> +                       goto out_unlock;
>                 }
>                 phy =3D phy_find(dev, string);
>         }
>         if (IS_ERR(phy))
> -               return phy;
> +               goto out_unlock;
>
> -       if (!try_module_get(phy->ops->owner))
> -               return ERR_PTR(-EPROBE_DEFER);
> +       if (!try_module_get(phy->ops->owner)) {
> +               phy =3D ERR_PTR(-EPROBE_DEFER);
> +               goto out_unlock;
> +       }
>
>         get_device(&phy->dev);
>
> @@ -813,6 +818,8 @@ struct phy *phy_get(struct device *dev, const char *s=
tring)
>                 dev_dbg(dev, "failed to create device link to %s\n",
>                         dev_name(phy->dev.parent));
>
> +out_unlock:
> +       mutex_unlock(&phy_provider_mutex);
>         return phy;
>  }
>  EXPORT_SYMBOL_GPL(phy_get);
> @@ -961,15 +968,17 @@ struct phy *devm_of_phy_get_by_index(struct device =
*dev, struct device_node *np,
>         if (!ptr)
>                 return ERR_PTR(-ENOMEM);
>
> +       mutex_lock(&phy_provider_mutex);
>         phy =3D _of_phy_get(np, index);
>         if (IS_ERR(phy)) {
>                 devres_free(ptr);
> -               return phy;
> +               goto out_unlock;
>         }
>
>         if (!try_module_get(phy->ops->owner)) {
>                 devres_free(ptr);
> -               return ERR_PTR(-EPROBE_DEFER);
> +               phy =3D ERR_PTR(-EPROBE_DEFER);
> +               goto out_unlock;
>         }
>
>         get_device(&phy->dev);
> @@ -982,6 +991,8 @@ struct phy *devm_of_phy_get_by_index(struct device *d=
ev, struct device_node *np,
>                 dev_dbg(dev, "failed to create device link to %s\n",
>                         dev_name(phy->dev.parent));
>
> +out_unlock:
> +       mutex_unlock(&phy_provider_mutex);
>         return phy;
>  }
>  EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
>
> --
> 2.55.0
>
