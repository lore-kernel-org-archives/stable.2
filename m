Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB43655F5
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120259; cv=pass; b=oDMgosT6Jp9m3/jMmo3ANEi1yMFgdYOzynWr4nFpclpyjX7MwjFesWuzbzT8vQtgIOH9iuoZ0EoEoSNiLgc67JWIvb2sN5G+GswW2M+AUWG8OtGY0D+4kx/I5+VaU2N++MIWXOE1aYzwykevpUv3p1cksKA9h7RCpEOd+/DoX34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120259; c=relaxed/simple;
	bh=+vjfu+BhfoRhdod3ax7XIibD0urP8iK+x+y0nVqbMLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz7fYKtgHVpFy+RKniGpwwDxtaT3+VRM4RdHN0VGOYedZl3ixydYTgyrkDeZuaK410eEf3nfw4MilLdt31MRcxtlcK7zYY6PdjlD9AZn9l3cWucI9SBzJzukLGzMr/vcGLK9uFVFS/CanADmkTCEv87LARCkafKyW/rWcMWLz90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TkT2XMH5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KMQKP3Kq; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TkT2XMH5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KMQKP3Kq"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M59F7d2427862
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GArM74qnbNn74pkKdk5flnpvpw6XEnRlwvdWaHNFJaM=; b=TkT2XMH5fGdfmxh+
	L5zZ6+w8+34sEglP8ScnznU3OodYXcZe97s5VsCq8CqwORHI55iV9plqZ2TmfBt4
	lSbhgGRqoJKcUgiSv3oTiMO3SVB2wSwV9nn9ue2eZJErE4T8REmFO4gEF2DoHleq
	jzyLg+LEAW8UJ6/voeyBTOaa6Oc6FqFeVWS07It4V3wLn+EC5znAdHZuMdSRlvPH
	RkJv/1c+n8V6SpfWLCpX/tyB3vPVYkJzkb9Vj0wB7GO0PrnL+qrZpTGg/syDidy8
	/+vxb6/QQ6kVbMjWgTEyMk3dq16f+UYpbnIc+vE2nfaYF5TqGKCHAYi8AL+D6JTH
	01xR0A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewhtsdvv8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:24:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92158791d14so240475585a.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 02:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782120256; cv=none;
        d=google.com; s=arc-20240605;
        b=dcbYi/UHh1F3h8DNiywyaFNJsrEEqJLaIYudAp73WHDg83APx1nV7AwmTMgHkQ0E23
         RIfDDA/t0WtaD7nnRXnUFjPENH5MXrg8q5yaqXut8V49HAndX6uKq3eG0FYAc65uAmHb
         l3mxdhgTmTomgCiUVH6DqCGP8VHqv1UqUP9/VVEyBpxYDLIfnHJo0qElbsVZM4L1XH12
         mJNGEibkGgDuHaLiiV+XvNLKufeyNxgDxzYJ9lgAu61KTSJPyQ8AUTVHg48paOrydiCo
         pPrEaF/1YS9lWmQ0d1AtGGL+GFG0fxp9QMTIvmb9wD6incYT3j2lIjezv4SPs7YG+xu8
         ZTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GArM74qnbNn74pkKdk5flnpvpw6XEnRlwvdWaHNFJaM=;
        fh=zMkj6gLpUujLexgDKMDKs3ymzQEdhXmFCXb1jazPxBE=;
        b=EGV2IZ81ZPX5FpMZXTPUhj/egY0KkPXhdzkQPcIGnlUoz4TQPMvBJCSMpPldm3rBRt
         2Pi9/xS+Ed3i3YHcMNm4cpA7IuxcMUBzqUNpF/e+3zut9ilOy6YsYTRQ9cHlwDRYR0r4
         Fsu2f1i29dnSJbQeqJw2tcE+FjkRtTCAIpbf+z5a9FybgIuQ+owpHX9gFufOCOz6zEsk
         0JGa+D06gRXY9uopxXr9MKXuS/DOUPbFL20MZcod1urDsS3ClBQicFblpt/MpcYDrG5m
         k+wy99/KMhNZmmDyYyCvYlnudt5VjXXN81nFEi7q9s0nPe/QNLcP9Y5hJaOp+2Gfrhfj
         lnSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782120256; x=1782725056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GArM74qnbNn74pkKdk5flnpvpw6XEnRlwvdWaHNFJaM=;
        b=KMQKP3Kqe0MQrfyCHhoROjxXCD1ok8YmmBRw+ZcW6/9liwAIzuVmXFqphdYM5XmhkX
         ngM+fWvu8if32JonHJg0wBnjqiP2nSNCWs1w4X3V37B/ZS59DKiRf1/vHjakqbRVVMym
         1fGvvmON47m3hW6GGwaiNqo5aArYDFcY49lPDGyczxu2Sc53MHYn9ieMAkWylAfYfXjk
         L/vRoStlOLyrqj6kXdhGIkoNLdWeXVhPCkV1R4hzujejgoden3TQ2cqK8kknc8Nc+KfA
         MGafETl2GB7M264pzuhb5vyDiDLeYaNcfkdMsAakMITtz1PRGEgzYgqNKRIv7Cf6DLxE
         DMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782120256; x=1782725056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GArM74qnbNn74pkKdk5flnpvpw6XEnRlwvdWaHNFJaM=;
        b=tExiK23cdzFmG0KO8EQU2XEjNIiKKdrpZLQ8saAHdMwp4K1P/VnmN3b3h8r+Q7OegK
         sQxlISFGDN4HWE7LlwaXRNneb51ZoyVzJfkuT5Zwy8TWRhbRa3WKJkJ+KyHp+Ieh2aAv
         NPLuNkHz+mD7PdDy1WOp6f5WDgbeVspgTcWo0hVgpvAf0qDNvASTc9bmVBzhKkn+ljfO
         EPT0mW0ljaS4+QEwdrcWCS+PQPLcOPXg237QtAvgtC/h4aXLnvpna5FgY2oYh2uWR6js
         UxTNsBOVBiafyJA1nR4cwSr/bCvI+WkcX7udmfYohzi8ryTEqjCD2dSi5+DwlvO2YMD0
         NtLA==
X-Forwarded-Encrypted: i=1; AFNElJ+cUJAgijOFAN0R5K+dBgVleIPg2/sduUVWnMs+J5x62Jeh4MBfGsQNYGuWPW16Vpje5clDdHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnbQfFFxeuVhWjEhsoEPyHleVsj1zF4YUbgmCFC/baE7MEpnA
	LkDLwOnJfkK7ONFhF+hQyB6udEpDqU3jJMujgz5a2pYwfrL34r9TSrxsOZ3yIcK1q69GYkljszY
	XqNDBsXBsJVF1pPGBOvtkTx/gEERmi25ric1iX2VjiZhwqOzwiSaw1FEeZGE2vqWWJMJmF813Ze
	Z3d+lNcN4/E6Kkemb80D+vbkWR+bheDmsRvg==
X-Gm-Gg: AfdE7cmB96cVLBuInxQ5Sh+7pj8RzN8ChBo1gimzz+WFdVTGboPD+ifdLo9c/upMqn+
	mvv40YNXDMSowZ7MWjV28O8sbUQ873oPsSK8hbHp3I8bX98gcIi+lvxBCmkPqV5I3sOE9iP05JV
	ZEWvRvc5Gg/8rRKaIJwk3h5D8UHXvpnOGuZJI3Agmi0/o6bf3TwfDxbABOVuB33LM343B9e0sv+
	RncWZKxoE22u/Y9uE8BbrDkGNoctWdzoLFaCdAJP7wHhISpQGjimHtW+SKvOQhfBc/w2lpS+zWb
	POl7p3+oWA==
X-Received: by 2002:a05:620a:2947:b0:915:a101:48d with SMTP id af79cd13be357-9208ddc3d63mr2267953185a.56.1782120255938;
        Mon, 22 Jun 2026 02:24:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2947:b0:915:a101:48d with SMTP id
 af79cd13be357-9208ddc3d63mr2267949985a.56.1782120255356; Mon, 22 Jun 2026
 02:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178196118045.462404.11069139160448641355@maoyixie.com>
In-Reply-To: <178196118045.462404.11069139160448641355@maoyixie.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 11:24:04 +0200
X-Gm-Features: AVVi8CfyS_ylE1iVRIoh3zvGMYG3LeW2cuA8hUNIwvvj0zyp3zHOrXVrmx5bJso
Message-ID: <CAFEp6-04no0SNQ+Q4L0R78cmCgrVHManT_TzaYWsTAkxJ2LFww@mail.gmail.com>
Subject: Re: [PATCH net v2] net: wwan: iosm: bound device offsets in the MUX
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
X-Proofpoint-GUID: q2A3RCow_4Ovb-JIOFW-Y32FxpZufBfB
X-Proofpoint-ORIG-GUID: q2A3RCow_4Ovb-JIOFW-Y32FxpZufBfB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA5MiBTYWx0ZWRfX7p2heLQHX2iO
 ndW17OO4PV2MzpIQMfnT8oM7jNllLaBuA2LLcumau3gPLL3+SI7Ahulaf+fnecQo9yiadZzE1Ij
 jNCsSGWFf8g8+P2qqQS0Rq++45KYlu+KWF4drHiReGfW1Sh922TduhJ0fS+iVSSdMOXP0eA4cJ4
 krgo6R8emz2GSEjp7VHCnsVAp8zyCsuSGkjiQ3MGG8vE1U/275UxuattX6376PaN3+iwKqAN1q9
 8FNl/JHmhIrWfxCCtBvjAnSvmjYDWtPipGyVRmAJ36o4CLhfly7WX247iPgGUheIUN0fVHybWIB
 e+AI1K4PPSNWWeleqwFb0EzBVPvXZjWBZb06RW8jEaC4fQgkb67cUptf5M+DNlZ3cjbxDF+JYEU
 h7Kufc+HGKpsOr6nxMRCPz3VbmNxUa1RKeODm4xIszAftY36RL+wZJ66oFdANhLtBkWxIWD1pco
 H0s5VDtgFtA8Lu/DPEg==
X-Authority-Analysis: v=2.4 cv=bcRbluPB c=1 sm=1 tr=0 ts=6a38ff41 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=SnhycFdtAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=ckisEX8qNS7d6mgPHJgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=IdunurJ9zWQ3aaQyNLvr:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA5MiBTYWx0ZWRfXwUc9VKxBftdC
 3BeYMOLC2nCeRehqVnBTxWaelYSSwBYn4qi22Hl7wCMHbEcR0OYiHV2KeJR6bEluR6ovX8PxxSZ
 Jn5uDixVjf5jXTIC7ZEaCiIzLOiCSkQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220092

On Sat, Jun 20, 2026 at 3:13=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com> =
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
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
> Changes in v2:
> - mux_dl_process_dg now uses intermediate native endian locals dg_index
>   and dg_len so the bound checks read cleaner and avoid the repeated
>   le32_to_cpu conversions, per Loic Poulain's review. No functional
>   change.
>
> Link to v1: https://lore.kernel.org/all/178185979029.4044562.999361597594=
9055530@maoyixie.com/
>
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 33 ++++++++++++++++------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwa=
n/iosm/iosm_ipc_mux_codec.c
> index bff46f7ca59f..ff9a4bc52f29 100644
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
> @@ -595,6 +597,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
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
> @@ -606,6 +612,11 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
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
> @@ -629,6 +640,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
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
