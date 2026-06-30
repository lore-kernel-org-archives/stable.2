Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4D472760
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849564; cv=pass; b=SjBnfOWx3Zr5sSrW+XYT9Rx0W0JFbJDUz73lRj3AAMI3xK4uMgt8C3NofpC7Ph+MGjuhl+gLCLjctiOygKnorQnV0PG/i87yAfO/8t8UCt73Yw0+7VoVG7GrexE67xsJVv8UXxBsPslFCPGQbzdrvO+Fw7FPfp81JLxjZV0rHmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849564; c=relaxed/simple;
	bh=RiKwOhz2rdMC9/aebYm1g33822i4EXTv8wYdbkHCerM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cohp+UqAbA8Ecl5DAZEIkAVoX1LEHGwe1rfDtHaCxgjnFRUxsuVeSqhkG5MgQRH35TVso/4VW2EfLtL29b1zmmWiHS+6lLGLoz0rtDVB9uUqDba7vHTNzwcwyn1o5HAtt4JgPCuAPjoxVZ88jF8/7zqfIKXBpctEfuKn9hLAbJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdR8HRwp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XN24c5TU; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdR8HRwp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XN24c5TU"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDmMt2937318
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 19:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=; b=cdR8HRwpOL0F5KGf
	Pa72vskx0M2kP/Z35S2cu0vrb4j+OEKIt6KMM7Th6UonX+P19BpjlUhTk5Li1d1Z
	Y/Wv59ciZPfT/RYaiQrRsZFm3fZPcDfKBwaFfoTbWjAmnFyZj3n9bpk2D9uAq+as
	Zefne9lZYGQzV3whovwFyt/TN8jYz46vzYj5NL0+/lOGbG9MlNpdo0tsMl5xk0yg
	fCV3pDFQVQuR35FiZSvIftsxLo2l1P5E5HN15BL52dlkXhgQkdoSVKvLPz9tpEoo
	i0SPA3tzquu7dDbPf2qsPBmIKC29344dcx2/YoqDcNf3SztycbPjKCqS4n+bRngs
	SWWdJg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc09pdk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 19:59:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ef8249f871so53717826d6.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 12:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849561; cv=none;
        d=google.com; s=arc-20260327;
        b=VyKRtxx9s9/9+jzJVU7rKObZ/fUiUAY8I+jUNTMzGHfseo6FVZ1ANy+ZMUWB54UZ71
         Rd7JB7aRyip1VGvdeI0vsa0HtkcczvyEAHmxlpsf89MWEnQZZMjScTvat60LlCGF5yWJ
         dHtgTV9QvyJYb8KZmDPOuUijt5n76UMPsehgNO6YthxR1O9uBuR2NnVh6+xEIKwHNP19
         rKjMcZcHXlhv2MAfy11zykpU2YttmGUHoytBjIAMs8/IpZcWdZRT5GY8vCLGcT7gkNyJ
         b0siaWM88GkBYhuctsIKQqrIwwQEJi6bx5tmK7sM8gync66hjJE6bIfvHKy1Wp/ZenI1
         JwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        fh=8SMFZPQDcQAx/jZ2Gs0gWR9eXwOprV3WN4ShkHqP0Gs=;
        b=shp9TYC6kQ40MxWCwe+XvLh+g9rLm6+v1qDWsClOa28Xi6HcbVg9Fblnse/+9iFZ98
         RmkBZS25E8VOHaH6TtKmJQFXXalKN97tGlCUE3p8aaoidJaJdnD8WS7QgC+w2NJayKzC
         yyj76z6DFU7bEFXOZQyJCHOTOQiEC3MVDY7BVlJS3st+houtOjqQUUaboIraeOQKUjV0
         s6fuqzEIAoeDXXY+NMS3zoyl26I6R8IQRjQxcX5JljC8LDe4WTCQP6jZMELxolWZCtb2
         A3zii6KpXp7+gW2TyzhCYurZI8cpYPkEe00q/SrOMMzHvJvYtaKp6Aqtti7ivvDc5IqM
         mjhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782849561; x=1783454361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        b=XN24c5TU1mLtMwwVQrpsA3cb+Ec8JVOKflkTLwTXGBmehHakzQGPaN2aEZbPFpbD97
         LJXI7Xi/LFKLihPbM/Ozc33AJiWJHQW3D1ngB20cGK4F0B+mw1KKlsWOORfLOvwYsoe+
         pmnAxjzZ9/JjnTdkln0XJbGOPCH4QQHP6a4M2/WUsRbPfukntEC+Cb5T4b5ddzPzo/1E
         Fgqd0htDz4EopwjnY4LZMQlSDeipFKR95uSEQi4bnEoxNaYVXOfOSGL1EIqOhDX1SE0p
         xMUobMZUWaIXPebd5HgAPV046c5JKpeaohJhunSH/eiRKkNKEPKNFA+8OSveeGfCXZK+
         ujaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849561; x=1783454361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        b=JcCzZZHfSFFl482I16ntRoVx/843dtuxREdYwMCTFWG+39/CZ8g/BUZigWoVRIJySj
         uaDYm+pt+oAETPLNgvWuujQ9/bR+SD4kn2/D6ZWCWFavy2lor03hU+I2MkPv2nPvbnfQ
         o1bGJmbSBtmJGX7LQFHnBIcWdXLX6zuLu6SnH5s6wNugCmLlrhU1ONQRgsQ6i40svFsE
         Pp3dYG+AgHH+dSRNP8BWufCcsedzEYqmNaNvgY/t3BfLmk86UMd2g+1+v1JMBSyh/rS+
         16b2NU/Golt1x5of8f2+aGi7e54ilYDNsIVeGJBrb/hcgeVQ3T6LwxA+bzarJi920W8Q
         bVuA==
X-Forwarded-Encrypted: i=1; AHgh+RrhH9dSvupCKtmyFyQRoQv/6FyNL8HX5cLSgZZEYsGDW6tl+ghJCKpQtWYXcOKkulO6EEitTVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3fghCp/VPKChLMOJk6Ogzr3BOdWrNQH8x1cji1Hv7oG8uH6a
	0BSHLpaa0ISx2YvzLgMcz3Ml2P3mH0k8ishiHax2dKaiLh+A0p6oCJdXWRzUhCCRFO3I/vkJUWU
	KG3asOSfkAd9eZHoDtHWmWI7s101dy9XRostkEAiJes1qGEG2IYFymfaBiyXTQmoMOlhUiPFj0x
	xcCkR4PPc3vHSAoaGNts1TiIb6YazpH/0xyQ==
X-Gm-Gg: AfdE7ckZzodP3jXqJ3DElHVJTevOWCRPFM12Kv6YaFsNaj2Wf9EuIT9hPJbzWtwmst+
	bodULP5P5phCqF4bimjdVKmjND/55fQYJmldHDt1j2jRrlyNKrmKdleJ7ZUejhuXHFYncMoCBaQ
	7V5kIlWvmH1P/T2b+cWnTfpdlpnCHgMUlkDB3pEwHiooS+CYeeGdeOBO/W6swvGblGSQqj1CPxi
	uiYUTI+dmlNKheCWJRtcxzhCRVhxIJu/piEk9v+MWRvuWr82Et7VXLFtXbhFpAWUOHNqBs0mZbg
	0lduS/zFINA=
X-Received: by 2002:a05:6214:821b:10b0:8ce:e651:5d63 with SMTP id 6a1803df08f44-8f2d1343d13mr25863816d6.31.1782849561039;
        Tue, 30 Jun 2026 12:59:21 -0700 (PDT)
X-Received: by 2002:a05:6214:821b:10b0:8ce:e651:5d63 with SMTP id
 6a1803df08f44-8f2d1343d13mr25863166d6.31.1782849560532; Tue, 30 Jun 2026
 12:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com> <20260630180219.GA4139943-robh@kernel.org>
In-Reply-To: <20260630180219.GA4139943-robh@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 21:59:09 +0200
X-Gm-Features: AVVi8CcrbqRCRkmYSZLH_ub9JNgkd2IUQmjyz1dD9_QoekOgl29FSB3CCebEUbk
Message-ID: <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE5MyBTYWx0ZWRfX7l0GwHAY0N0q
 i5DJ/r1qkK6IWY5ba/9oS7eFpg3iuRBfHHhaU1LJ2dC0RnU+uOrCj0PIphGNX/H3ZeKlVj0EFbn
 YfaGRHX2jmUUf9QoC99vFFc0gyrm2rjdtlqEav0IFtNMgaZRhhIoboPunqbIj3/C/+XFOFQN1YA
 p/kU5faTxQ2bWTjz25OBI3lW+wL5t29uXcuDjFZGl6q2LqGKd9+fv9VbovHBoQc7otCYlzoExp3
 B04J6bbYJ+lby5ciPUK72Et9SptLWApOEaG2maRrrWZksisjgis0XigJw+dRw/8h/9mGyPUUXAE
 vTiCRZmkx4m3gCc9xHbA81IreBbj4wfS256psiMIyDjvyO2r8hFfgCHwhd2CtqaOFku/w2GpXk7
 2d8ZcdHHNygqOyezdPIRRDblhzds3NHLbd20CMOVd85ph4V+kortFp8rKNrNq9a+ENFuRS5ptW0
 scFejjviDtPQdgFvpqA==
X-Proofpoint-GUID: _gvZgKonjfUVNyPtOeTAaMhnKAdS8yjP
X-Proofpoint-ORIG-GUID: _gvZgKonjfUVNyPtOeTAaMhnKAdS8yjP
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a442019 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=2sLY7anfMaDELvqluMMA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE5MyBTYWx0ZWRfX57sUba6X7o+n
 EhZ0HNqLwPn9o5OJ3UfnLXGMXI/6PnXOSnjXAflpPqvZfD6xE8d5fhcXuMufjflmL0IQN6ws2ZC
 sDH3FYPkwPCRHAw8lMd179BxQQfFagI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300193

Hi Rob,

On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > Child nodes of a fixed-partitions node are not necessarily partition
> > entries, for example an nvmem-layout node has no reg property. The
> > current code passes a NULL reg pointer and uninitialized len to the
> > length check, which can result in a kernel panic or silent failure to
> > register any partitions.
>
> That does not sound right to me. A fixed-partitions node should only be
> defining partitions with address ranges. I would expect a partition node
> could be nvmem-layout, but not the whole address range. If you wanted
> the latter, then just do:
>
> partitions {
>   ...
> };
>
> nvmem-layout {
>   ...
> };

In our case, the nvmem-layout needs to be associated with a specific
eMMC hardware partition, nvmem cells can be a simple sub-range within
the global eMMC, each hardware partition (boot0, boot1, user...)
having its own address spaces.

That said, your point about not abusing fixed-partitions is valid. I
initially dropped the compatible =3D "fixed-partitions" from the
partitions-boot1 node when it only carries an nvmem-layout and no
actual partition entries, making it a plain named container node. But
it's a bit fragile if we want to support both nvmem-layout and
fixed-partitions.

Regarding your expectation of a partition node being a nvmem-layout,
do you mean that the nvmem-layout should live under a fixed-partitions
node? Something along these lines:

partitions-boot1 {
      compatible =3D "fixed-partitions";
      #address-cells =3D <1>;
      #size-cells =3D <1>;

      nvmem@4400 {
          reg =3D <0x4400 0x1000>;

          nvmem-layout {
              compatible =3D "fixed-layout";
              #address-cells =3D <1>;
              #size-cells =3D <1>;

              wifi_mac_addr: mac-addr@0 {
                  compatible =3D "mac-base";
                  reg =3D <0x0 0x6>;
                  #nvmem-cell-cells =3D <1>;
              };
      [...]

That makes some sense, this would require extra work for the
emmc/block layer to also associate fwnodes with logical partitions,
not just the whole disk/hw (hw part), Is that the direction you'd like
us to go?

Also, Note that regardless of which approach we settle on, this
specific fix/patch remains necessary to validate the partition node
and prevent NULL-deref.

Regards,
Loic
