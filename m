Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9535AC13
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902125; cv=pass; b=aFt/v+3HB34G4i6Qlw0F8l6h9Ajt+FL8tSKQTblxzEgTCoRpLuqVy9bcVyI5vr0ECM0f2D+ha5V2dEheLBI1kkMmOlzTaQpfnx185BLCdXDCUjguA9pbLJtI4rPJ22rT4Tqaao2VErTKzgmB9AbuvHBT+KLYSy+AEoeqO1XGerE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902125; c=relaxed/simple;
	bh=apqdQKr7PEHlxfQQiXiex1WWm8qUWolV2mUZV3BhAi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUltTMNADc3ujadStyk1x5SlC57cwiTnIaUC03bTVI7hXJ2um4aBX1ZmBhr1s2ZngRp1cCVPLfE/Bb4riSJ1UxKuRpFD2Voqk3BSZCjr7sC1NdHdav4pTOT6kv+64paYtbNnEeYbWHJw5LU6ia8dQF+NwdeMwCAz3iOJa6/4aLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JswXacds; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6+OoMoK; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JswXacds";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6+OoMoK"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHUpbj1322356
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 20:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zA8WqZ4MHUkpwOcrbs9rDdlT2zHB2hwUW99729Sbo6k=; b=JswXacds6arRJBdU
	BJn3HY+P8T68LsUJxkpxBB5wKEHB8ZawFBQM5umE1kWxgtBcBzHZTM+0PwlzQK93
	MW+bHlhgGdg8WzNUu8TFDuz+Clo5iseNEz8nz5hNk8adcDTOubNtoPwy88OLKJ8a
	kHRP8au++2NzpKn82UX6Hnj4EHU9tXuxBHaHK596WlnWxWIfYT2Q2/grjTpp3fUt
	KNXP+DaENpyEi1Iko0y7P5J5HmWX3nzEFfMQGXWLFfSHBmIiVQsF1rG4uDmPb1e+
	yhYzcf4dRAWtmyX/tqZdy+kU6rAuKIf/NTDIu3hlc9cOSGFqf/rggJc9+uweXW5K
	t0KkiQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ew5hp9s82-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 20:48:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9157c8eb597so383021685a.2
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781902122; cv=none;
        d=google.com; s=arc-20240605;
        b=KTIbLJrpv9Rp4gj0js5c2lmcr2kCSv/BQbd2Gx1+nEHkrI4GTaBmmP+f2b748zdBmS
         o7srAiS00mpyLP6JQrYymJE/wsbexQ+4v8s8t0LXJa/8cPCNNF6kxrFe2yKtQyDFbpxC
         ZBL48xOptifovWkSX3THemQlUezIDO/4z7KrLNE/7HWeV+FpjxbDyqv3j69zbv3MqHwu
         VoMckk575wOkyHS5fUtpHUR7Z1tM7QookXW10mNcITv6z40hiIHgdouo4hzbh/Ep+sU5
         b6zJuxaBoCZgXjtn/47mVTsO2DM+MTLYZUH7Jq4ai8/bZcP4AjsLZKOzpKv40Zyr8JNS
         qbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zA8WqZ4MHUkpwOcrbs9rDdlT2zHB2hwUW99729Sbo6k=;
        fh=Dw2EPuUCWmJr1UePkE6ghbx3kqWeKwO1COAyIndclQA=;
        b=EWmK8WD4OTcpK9nx9UscFv7aiEwBQ/EPNODNlVAWi2VpTXqEq5YwmpH8DXgZqSArsv
         i5fFw65kO3gQzkPICHswPBT4zYFsntRSPdkV1t+hG764tzD+QO5XXPF0TNAm8+XnSxew
         tOrbaFlsJ+5WHu81VokXkyGgDRZ097+GJQ/959ca7vvrA/ApkAGn1DWuWGubt30rzbjI
         5Vavq/T5inTb9ZLY1yosKyKdgoxx5stonex2pmNUh4WpomdVBZUJtANGYkidXUTnZHEk
         zWFovpYqWaDFxysAIjaWQfwiuSRi4xK8/CkN/O9ddmNVGwXbraYJ3R3d86womrPtl75Y
         8mzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781902122; x=1782506922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA8WqZ4MHUkpwOcrbs9rDdlT2zHB2hwUW99729Sbo6k=;
        b=U6+OoMoKIh21RyXbOjGWQHEJyH4gn+fIQLldzPy9kKpjzFVwSWo/6IZCIa+q4GYsoN
         xoTdMqe89RzzTbHyjrmHUprbr4AjNhuf0MmTcfakdUO1Ev6zFpFn3C1goF4F6ABDn9Pi
         wDtQOQw6C51xS1x8w/MF64DBppf+O/9XucHZAuOzCHzGTBZ7GvIO0biT8GqIuU4gVTZ5
         aUVI55gHXjlSsyRIrd+ho4P+2M6f66S/MUs3v8vtn34mryejzzc3Gz/jsxkAoOL21E+m
         mokElNun/kxgo1VMNkOdY1H4LHHBognwGSRuvqmH8qZGmRw0/tRR6QJvkyl+1sUutxD6
         JR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902122; x=1782506922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zA8WqZ4MHUkpwOcrbs9rDdlT2zHB2hwUW99729Sbo6k=;
        b=Tf7VtjZuUibG3rOetrB92w17US1os7jSdrV50CRAei57j0rMnNYpcr/2EpWe/T54xp
         xJyLTLaYKOguPHIFfl4bBkxUfBb9/7Fg+mShotjptG/oGO8tKKcjkvVu2qKyGBStPYv0
         esYNMvBDHkgTjGgSGDM8tScdBtFAQIDbHj/9XgbQny1PO96KvAcvWx+/C63fiWTh1QON
         siafwbk4JUkyyom4CVo/BcH8LTNOQXUuaLGqLOt4WV7LxtnDdTe8gmLpT+IpP3GFSCjl
         rcB/TZRrpmrx6Siu+7GfXLBMedikiDwIYlYLskq8EV6UVvZp2ttHOoYZxQWKB3Xdv4IQ
         PrOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xDDlumsV+wwMtASCOqEPRW8o5EpkMng3ezuIeFSeqRgMupktaFlV8dtR+PBYDk45/8Hf9cNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8V9+KowrjldPvuAquXS0NxLtPIwRj1SfZ52CLzCYwiR+ka3yu
	s64g0VQDjtkmRU2bl549UtdShHx5UCUgb8UpThNmSNGiMseiRoFyb9yBNlv4wO3N4WgEtJEEIMx
	sYR4/mRz1N9/LveQNUUoOHubRyrX9vhhfyeAJU9sHB/9enBwWTOJAOH2O51epL8PvlXUnL3hv0x
	O5e4mTMmUIqn0ubCRFcB5bukfmcyNkDTNVrQ==
X-Gm-Gg: AfdE7cnJu79Q6oSCmiHMFTXcLeECr26jbeNrThRwqpsQdCU8pg1XyR+NMp6MKDHqLhD
	4sas49ii211VgO4PfvCOYZqRAtR0Pl6vmi48x9HR4fv/TUlmNqnlkIRG6j4qDL1JrxoOk6xhfAi
	NesjV3vsgMJEC3LQ3jfkdMJzbPp7J081w8LC77CHOhD3uOZd/PEBVw0Bhpj1ON6ihUhTBJ6LScg
	WeE6c5Ud+tP1HbG1BBXMg3QASX82CUGV6JzdzGqXvkalcfnZaHZO4AE9ArXcb7b+jLSbyE7NAZt
	B0D9qhJy+g==
X-Received: by 2002:a05:620a:2688:b0:915:7c1a:1390 with SMTP id af79cd13be357-92091786f27mr820314285a.39.1781902122159;
        Fri, 19 Jun 2026 13:48:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2688:b0:915:7c1a:1390 with SMTP id
 af79cd13be357-92091786f27mr820309685a.39.1781902121691; Fri, 19 Jun 2026
 13:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178185979029.4044562.9993615975949055530@maoyixie.com>
In-Reply-To: <178185979029.4044562.9993615975949055530@maoyixie.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 22:48:30 +0200
X-Gm-Features: AVVi8CcIfYL72Jybgb_uyRdiwHEb7NkzGSSu17a63NnIJruCaL_QhhQ5jNnd0gk
Message-ID: <CAFEp6-37ambJxjnwxqMCnc5bGLmL0d+6dNtu_pNVYc4WKOSb5g@mail.gmail.com>
Subject: Re: [PATCH net] net: wwan: iosm: bound device offsets in the MUX
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
X-Proofpoint-GUID: RiVl0Ylashs82OdsxkzY8bvWpfUKGV3m
X-Authority-Analysis: v=2.4 cv=aOHAb79m c=1 sm=1 tr=0 ts=6a35ab2a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=d3nvGuovzB6WDmDeTcMA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: RiVl0Ylashs82OdsxkzY8bvWpfUKGV3m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIwMCBTYWx0ZWRfX41r7VIwm6RsW
 X4Gkft1/smDwKyebmp1E8uB1m9i7uzZe7D94Q6EjTz6vkLiOGlK8aHVdOmoEn6MqGFQnHy0G+Zr
 VwMzFBV6twv3Ul/MUehPVVvKUzLZydw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIwMCBTYWx0ZWRfX5jHiiQtmNpCd
 RNBvb8NlXbtvx/0GJvY6NQ8Gf95JNJq7cucVtJZ+ErdT7HDBQ9k29SB9P8OkLIu0U/mBeFr1tFJ
 XH5o7si52d2BfdN1H/1oGTGF11Z144vIWAjLKawRsVDImMa4nmJATbIMhdZT+QWeDGuutLgxklX
 tN/5CghUjUXRJrE0s0iuSoD4KhKcZKeGZP4BmMol2by0akCuQINub7RbZSG/E+lFraxIP0V3EyJ
 qiF8f94zEwlgPkaD/WmqQCFr5OEk2R9MD7y+yEJI8M/+VXyaFhiL/yLLwmznXxItzYe6L1EMjma
 CzBtY91OpJKcCNKhn58RF+m23/BWXAtpUZMrYRuN6XF5Q7+rI2hxpuLYOWHG4CEIiCXfl+NnM2f
 lxvRpEHMFjUDlDgOkWJXBs67uFvkWxtW1yFb9eQQhK9iPkIIeCta3JA8nimX3j4heQVxQWZh1wT
 RY0fNA0ujYU3R1rhttA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190200

On Fri, Jun 19, 2026 at 11:03=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com>=
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
> Validate every device offset and length against skb->len before use.
> The block header must fit. Each table header, on entry and after every
> next_table_index, must lie inside the skb. The datagram table must fit.
> Each datagram index and length must stay inside the skb. The header
> padding must not exceed the datagram length so the receive length does
> not wrap.
>
> This was reproduced under KASAN as a slab out of bounds read on a normal
> downlink receive once the iosm net device is up.
>
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 23 ++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwa=
n/iosm/iosm_ipc_mux_codec.c
> index bff46f7ca59f..1c021bb0aa7a 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -557,15 +557,21 @@ static int mux_dl_process_dg(struct iosm_mux *ipc_m=
ux, struct mux_adbh *adbh,
>                                 < sizeof(struct mux_adbh))
>                         goto dg_error;
>
> -               /* Is the packet inside of the ADB */
> +               /* Is the packet inside of the ADB and the received skb ?=
 */
>                 if (le32_to_cpu(dg->datagram_index) >=3D
> -                                       le32_to_cpu(adbh->block_length)) =
{
> +                                       le32_to_cpu(adbh->block_length) |=
|
> +                   le32_to_cpu(dg->datagram_index) >=3D skb->len ||
> +                   le16_to_cpu(dg->datagram_length) >
> +                           skb->len - le32_to_cpu(dg->datagram_index)) {

The logic is ok, but for readability, I would suggest to convert
dg->datagram_index and dg->datagram_length into intermediate
native-endian local variables (e.g dg_index, dg_len), making the if
condition cleaner and avoiding repeated conversions.


>                         goto dg_error;
>                 } else {
>                         packet_offset =3D
>                                 le32_to_cpu(dg->datagram_index) +
>                                 dl_head_pad_len;
>                         dg_len =3D le16_to_cpu(dg->datagram_length);
> +                       /* The header padding must not exceed the datagra=
m. */
> +                       if (dl_head_pad_len >=3D dg_len)
> +                               goto dg_error;
>                         /* Pass the packet to the netif layer. */
>                         rc =3D ipc_mux_net_receive(ipc_mux, if_id, ipc_mu=
x->wwan,
>                                                  packet_offset,
> @@ -595,6 +601,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
ux,
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
> @@ -606,6 +616,11 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
ux,
>
>         /* Loop through mixed session tables. */
>         while (adth_index) {
> +               /* The table header must lie within the received skb. */
> +               if (adth_index < sizeof(struct mux_adbh) ||
> +                   adth_index > skb->len - sizeof(struct mux_adth))
> +                       goto adb_decode_err;
> +
>                 /* Get the reference to the table header. */
>                 adth =3D (struct mux_adth *)(block + adth_index);
>
> @@ -629,6 +644,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
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
>
