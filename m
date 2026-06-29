Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC573E1704
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719370; cv=pass; b=rX2PPb7xYZJbYekltGlVzdQcEE8ieQijoWuPcx7zLgpBkQpO01X5ZsyDBWFvhL+7smAavvJzQD2APYWfagbQD6yDzWqhkzgjUiREXjJArEraBFZoOE+8OGtmAjzH/si9kL7OnKvR1PYwd/tSR7cVaPOVrm/rEKHeSlleF+7b+dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719370; c=relaxed/simple;
	bh=btbZWvEafKqIS+blxXbzY2y2nMrTGxHr/GSus5YYopQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCdq7LeFHwQbIqWWTk0wEN4eYgkLavJnnwVBcg7ou0kkku4yDmZhocWLTJIp2onWGpczvM6Y15iGS5WGPZM+1k0i0ReuKLf+iDircYceo1DotyuXl1RRcOlssK2hsHtT72ef3y+6F8hEVSvxEIPTmbQdMenCwWhq+0P3z5jsS1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iv+TYoyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D+ZIi9pu; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iv+TYoyw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D+ZIi9pu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rSKN2124839
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 07:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PNuv6Xet+hQ1A5x1kF4sIiJsIr7UgLVZ+1RRk8NCKM0=; b=iv+TYoyw35MqA0P6
	ep2b7mOo7OZjgz/zY4r/iqyoEO+LLdTtlSRQgtkwPLMneRwNeDnaozkmP5tF+pya
	8jntfULb/Slc2gKLiX4vmpicffwkFUMpCr4bGEtzASBXc1K3n1bRfsLRSIt+HG4n
	OKm8zimIQ6xzI6VolXe0Dy0LH/DTM/7eua2nUW3GURHWQl13Ep9klGYk5TrtqfzL
	2xxjJ4o/xY1wnjwdod7sccJp5DbLbQqLqQx5nVVa/qTMENKWYf9U/6H+ozSOPKql
	QulRw8WYTKYeA/yAneN1dABMCvWdQ6Og9nCJyS5Q6BXMYPgSiaW50WgLX+u4aJzr
	MMV0aQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27335cpe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 07:49:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f05dd0dda9so22819856d6.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 00:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782719363; cv=none;
        d=google.com; s=arc-20260327;
        b=EaJdeh4q6/npgczTycVIB1nr0FKheFcf4Kz5bmk5Kclb2h+QPCj1R9oXtkj9gtMhjT
         JWlpVgb+NRE0K94pbQvPjUl94S08WZL1p9xuO+KrSckFFBhK1boLM07+wi2fwXYAv/Hz
         cRgB8YOrf9mSw94uxsUsxlXm1NjAOlucAU7WXwUF20Q4qMBLDcrMcSbBgXu7S7xJo+3C
         mWW1iwtQ22kRoCwXHZJSVrbJOnZehEsnDAWN6mahaaTKqsFu2T6P37d37BiVn5U3lXxA
         mmOLnW5uG6aOpV/49TXzyGPHbYhTgYWB72NxewpT0IbWBVg7UIKFS03O/IAtpYt1k478
         3+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PNuv6Xet+hQ1A5x1kF4sIiJsIr7UgLVZ+1RRk8NCKM0=;
        fh=L3t7nBnx261Sg+Ds9P62UrmjcbS3E6PMIIIN57FLUt0=;
        b=cAh2DNv46FQBZnKG+/ysYD8xmilpJQFPVva0uVq0Wv/fbuuVCkhNYSGfI7m0vjU9VN
         TNgnBWptKuZuP7feHVDFrTKgZLsXvzzIjEXcMecvJbv/rlUNwa3dBTCESYU2bHAH31TE
         yueBnOM0ZJ9vBTqQ/hyOOWymKLVX9qoMplO1zisaELjjx+aXblGMMVWsUVZoMP3fJ/xC
         MKCQjt28Na7tSAzo0I2WEZy5SupUwcHH+zLPcaZ0ENOh+ySaDNORHM3Eh9+ue39o3JSt
         iPjZ8Cm7FTqQrzSov2pwn8Uvt5RSmHfJqTDnnDildyfw/uN74WaUhvDtorxNH88bj7VT
         nWJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782719363; x=1783324163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNuv6Xet+hQ1A5x1kF4sIiJsIr7UgLVZ+1RRk8NCKM0=;
        b=D+ZIi9puSNmzy4vUVS9l2ilgrAOtGx74dsiyY+011sIowzSiP0PGJVwVO8tVcqdi+w
         qjQO5lMOqbbq1+iTeBrIYq+tA1AAKJbny0aLL/fKTFWIEnW/Y7+53NO9ZhuPbqvh+vFm
         86l12Yxm4M4vF3ZqGo/ci//UoCuERjTonCatYAxFlZJWx2VPev1Lz7RVfDgu9d/FiSTC
         3g1XOsNVFMOYORGD1aoc1w7WVxKFHNR/B2Ui0Hu2Ho4hzCfIegy8EueKT/IjkqGmnRl/
         Ey3xYIX80q5ZOfahxIvkN4+sdM/gRFkrK0+MtSMPHO5TI3vVMrbnxVwT/BJltUph/nbf
         kEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782719363; x=1783324163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PNuv6Xet+hQ1A5x1kF4sIiJsIr7UgLVZ+1RRk8NCKM0=;
        b=j+slQgnD6+BrRInJbKbkN6dtXGfm9sgH3Gc5eL9QFnlCRehxQWfH74dYr4S2vnvm/P
         61loU1U3fG22pJguk/AOWxuL1SYyvUyajJxJC+yMDhMlEiUDc//+iWmw2nIZ2W3Y2yA5
         EE0AnMGkYeYkKtlReJ3ajP+uG8Zz6VHx3FNF5I2xApIl+B57OaLncjQkrJ9LMfx28bKK
         BQXjJSbqW3dMk9d1Pbit06d3yu+i8FtTU7wsD5H+TjgogSOira6NfLgMcgeMvjo+RWig
         TFBA0SXsjXmoMJ4mDZgay8usiAe8AAUhMNsGx0G2uSzQpmTRSAm4r6Ihznlf/AdpOtA1
         qfFA==
X-Forwarded-Encrypted: i=1; AHgh+RppVVruuRbdUWM2nA78SUUgp+9o34DuDW+8+BAcEGsF7knz8DuyP9uSV6WM/SR6ANYAFD4Xi6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzTs/WgzydkjCk8NkLdzRg2DsPp86Qpa0uitsI2Arz7j93/3a0
	dLRM63wPoy6t7A8kLAbd+9XvGFmddJGktPVL3LjvBV56CAycLW9QwV+iH2NeTHeY0WablC5Qqbb
	2WPQJpbpB9roi7aJypfDIhT6qL/pUBPFXVoZh9BNGzZhPN4SD8NDdr2Kb36525fEU7Tn2LssSYV
	aaFKaPn1Zr5ubAFjuUhikkjgw7mRHTg3+QxA==
X-Gm-Gg: AfdE7cn372weF+Q7o4zLXLN2WKARFW1mma0EdGbJtLRu30JczlH69xOTb//HBs+PYHV
	gBqTZ0Du5MujQ50kDyNCrTr+E5n/EBZ3dMNPWMS9/m9alYV0MmsSsgyj9OXk0HTyVVZRO+J1dVv
	LHBBoas4obqWAtyg11+83KWYIdbP5CcDtXVKTtUkMd7nRdhsK/CnOvAtkp2wWe4ml7/l/DNl1Al
	2QLicbDDHwqXt3C171OxVW9gwWMksp9wlkhjAuqsPb68/EQTUy2cjQ12py6bhOzDQGLOPSQCFs0
	J5u8ZVyiEEg=
X-Received: by 2002:a05:6214:311a:b0:8f0:796:480b with SMTP id 6a1803df08f44-8f00796493cmr38684476d6.27.1782719362688;
        Mon, 29 Jun 2026 00:49:22 -0700 (PDT)
X-Received: by 2002:a05:6214:311a:b0:8f0:796:480b with SMTP id
 6a1803df08f44-8f00796493cmr38684246d6.27.1782719362149; Mon, 29 Jun 2026
 00:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178236824878.3259367.5389624724479864947@maoyixie.com>
In-Reply-To: <178236824878.3259367.5389624724479864947@maoyixie.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 09:49:10 +0200
X-Gm-Features: AVVi8CeThT6HkNNgV9aJl_cZk3MWOqnK73KnDiqiYz2ZGnzHZb1yeA29gTxkAQ0
Message-ID: <CAFEp6-1=qPdK1SQo+_ziomp=GzQP8wnc6SuRKsNtRmDspfJJ9g@mail.gmail.com>
Subject: Re: [PATCH net v3] net: wwan: iosm: bound device offsets in the MUX
 downlink decoder
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a422383 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=SnhycFdtAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=SzebcLgiP4Mo2SmTKnQA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=IdunurJ9zWQ3aaQyNLvr:22
X-Proofpoint-GUID: 8cO0tO-agFS1AdlH08Bub8S3tLUMCIxs
X-Proofpoint-ORIG-GUID: 8cO0tO-agFS1AdlH08Bub8S3tLUMCIxs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfXxo45WjGt7X4J
 jl67rUhE4/bX/IXik+iJ8asx0OZWlU/CIDgZtfhCggdo4vYhw6y032ZkNYysIjU8MVxI+qIvyb9
 jtsCu4hLDHppWxs0BTna0+LPWwOmd510cABFei1IccUqcks6kMvj0Ybe5aBdU0qmdxK1z3ok5wa
 WrxEUBt2wJ5nz9r2AhO4pE57BBib6vvCB98fsIpHemYXs8hYny75rsu9eTi1GJ/LRKfDBsW0Yzg
 /OnPMkM37+5n7b+ast6OFP5pu5zSi6xFVtYjm4ZFWU6uISdiCxBCNcjzgpIfcTp5khlWYzi5Q6m
 yvympFxzhwGYkr2za1HAVkT+NgBMgbgUxCkwpD7/NS5I0yqoW4LUMnQa5nQS/0krnUjofK+Go0W
 CFINGMEhtkqykFjUy/2fMagxYqZZtoxg4ZzB0s+VcFsdV/x+SyhoV87MUPR0gG4PYeaVKIcIPwU
 LvavjCuOdnOgAHGmc6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX4jKG0eyG6EBe
 5Ybl2JFuYkwTr6LmLrR9Icq/EgWR7zONuoipvHecCxxy6/JpyyLoMsa9jU0rEKN3aqh5i2MuMaF
 W5S03+Xe6+wwwoMuxogcMZSkG6u/JM0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290062

On Thu, Jun 25, 2026 at 8:17=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> mux_dl_adb_decode() walks a chain of aggregated datagram tables using
> offsets and lengths taken from the modem. first_table_index,
> next_table_index, table_length, datagram_index and datagram_length are
> all device supplied le values. Only first_table_index was checked, and
> only for being non zero. The decoder then formed adth =3D block +
> adth_index and read the table header and the datagram entries with no
> bound against the received skb. A modem that reports an index or a
> length past the downlink buffer makes the decoder read out of bounds.
>
> The buffer is IPC_MEM_MAX_DL_MUX_LITE_BUF_SIZE and skb->len is at most
> that, so skb->len is the real limit, but none of these in band offsets
> were checked against it.
>
> The table chain is also followed with no forward progress check. The loop
> takes the next table from adth->next_table_index and stops only when that
> reaches zero. A modem can stage two tables that point at each other, so
> the loop never ends. It runs in softirq and clones the skb on every pass.
>
> Validate every device offset and length against skb->len before use.
> The block header must fit. Each table header, on entry and after every
> next_table_index, must lie inside the skb. The datagram table must fit.
> Each datagram index and length must stay inside the skb. The header
> padding must not exceed the datagram length so the receive length does
> not wrap. Require each next_table_index to move forward so the chain
> cannot cycle.
>
> This was reproduced under KASAN as a slab out of bounds read on a normal
> downlink receive once the iosm net device is up.
>
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support"=
)
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> Changes in v3:
> - Also require next_table_index to move strictly forward, so a modem
>   cannot point two tables at each other and spin the decode loop in
>   softirq. Raised in review of v2.
>
> Link to v1: https://lore.kernel.org/all/178185979029.4044562.999361597594=
9055530@maoyixie.com/
> Link to v2: https://lore.kernel.org/all/178196118045.462404.1106913916044=
8641355@maoyixie.com/
>
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.c |   40 +++++++++++++++++++++-=
------
>  1 file changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwa=
n/iosm/iosm_ipc_mux_codec.c
> index bff46f7ca59f..0bbd41263cc2 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -553,19 +553,21 @@ static int mux_dl_process_dg(struct iosm_mux *ipc_m=
ux, struct mux_adbh *adbh,
>         u32 packet_offset, i, rc, dg_len;
>
>         for (i =3D 0; i < nr_of_dg; i++, dg++) {
> -               if (le32_to_cpu(dg->datagram_index)
> -                               < sizeof(struct mux_adbh))
> +               u32 dg_index =3D le32_to_cpu(dg->datagram_index);
> +
> +               dg_len =3D le16_to_cpu(dg->datagram_length);
> +
> +               if (dg_index < sizeof(struct mux_adbh))
>                         goto dg_error;
>
> -               /* Is the packet inside of the ADB */
> -               if (le32_to_cpu(dg->datagram_index) >=3D
> -                                       le32_to_cpu(adbh->block_length)) =
{
> +               /* Is the packet inside of the ADB and the received skb ?=
 */
> +               if (dg_index >=3D le32_to_cpu(adbh->block_length) ||
> +                   dg_index >=3D skb->len ||
> +                   dg_len > skb->len - dg_index ||
> +                   dl_head_pad_len >=3D dg_len) {
>                         goto dg_error;
>                 } else {
> -                       packet_offset =3D
> -                               le32_to_cpu(dg->datagram_index) +
> -                               dl_head_pad_len;
> -                       dg_len =3D le16_to_cpu(dg->datagram_length);
> +                       packet_offset =3D dg_index + dl_head_pad_len;
>                         /* Pass the packet to the netif layer. */
>                         rc =3D ipc_mux_net_receive(ipc_mux, if_id, ipc_mu=
x->wwan,
>                                                  packet_offset,
> @@ -589,12 +591,16 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_=
mux,
>         struct mux_adbh *adbh;
>         struct mux_adth *adth;
>         int nr_of_dg, if_id;
> -       u32 adth_index;
> +       u32 adth_index, prev_index =3D 0;
>         u8 *block;
>
>         block =3D skb->data;
>         adbh =3D (struct mux_adbh *)block;
>
> +       /* The block header itself must fit in the received skb. */
> +       if (skb->len < sizeof(struct mux_adbh))
> +               goto adb_decode_err;
> +
>         /* Process the aggregated datagram tables. */
>         adth_index =3D le32_to_cpu(adbh->first_table_index);
>
> @@ -606,6 +612,16 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
ux,
>
>         /* Loop through mixed session tables. */
>         while (adth_index) {
> +               /* The table header must lie within the received skb, and=
 the
> +                * chain must move forward so a modem cannot make the loo=
p
> +                * cycle between two tables.
> +                */
> +               if (adth_index <=3D prev_index ||
> +                   adth_index < sizeof(struct mux_adbh) ||
> +                   adth_index > skb->len - sizeof(struct mux_adth))
> +                       goto adb_decode_err;
> +               prev_index =3D adth_index;
> +
>                 /* Get the reference to the table header. */
>                 adth =3D (struct mux_adth *)(block + adth_index);
>
> @@ -629,6 +645,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
ux,
>                 if (le16_to_cpu(adth->table_length) < sizeof(struct mux_a=
dth))
>                         goto adb_decode_err;
>
> +               /* The whole datagram table must fit in the received skb.=
 */
> +               if (le16_to_cpu(adth->table_length) > skb->len - adth_ind=
ex)
> +                       goto adb_decode_err;
> +
>                 /* Calculate the number of datagrams. */
>                 nr_of_dg =3D (le16_to_cpu(adth->table_length) -
>                                         sizeof(struct mux_adth)) /
> --
> 2.34.1
