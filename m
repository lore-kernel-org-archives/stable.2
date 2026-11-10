Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794301002;
	b=lhzhYqRF5JbTGyCU+q8Pf7Cj3+hj2XJpqdCWEoFRZI53UaPJ+J0sVCu4jiU9AeUu1Lni
	 petQzjiJM/FynFup4M4TA0OXF+7UW9eS6bEJ4ng6WdMhBAtNiR5eIi3txdfCrj5iXc+xk
	 Miu6FzIB+mSEAmydjDSDaAdIuJkE0pS9TlLBAO/VDnTmtGcQRSji+NtY0pUfqVZ2kiuja
	 W9+Uj2d4zcJOFOIV/oHX9to02GcUqeXJbrGG/YLKkG2+tSGlbHgyjUTm+c4kD5dAchvsM
	 i45hFhxW48Ys6g5xWhhREqK1aQCw82LQNxNk6B946nR3XMuJw3Jhlg4cDrIU9vp2Xww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301002;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bfYkXKftGpF5yfABS1UtuwUuTJGO6Y1zVSNuiv9+v4E=;
	b=GFoCY5sBgGzb1arDtQIwWIFdwcfl2iBjH6yin489+E3Uy17gQJFmtTEV/5I1h0WFwQMQ
	 vTDDmnIl0aMkq1w3hlvGyg4FP/BTuHGByoS/zwuzP/QnPCuLZknMPQ7anwydG9cA97iNS
	 hvy8hiUkeBWS89NdECDewGmr+gCSAMkEZudoqSeORSVcsbrNGoarplcaqKvZ9vqc0tKWO
	 KwtrKlBnvhL6O6+6TuCkGz6cCpJ9FxElvOI/LmexpGsQ3aTXzhup5NNHEnxwshmto1Xg3
	 7r86ZFk9810zg20qI+hAd/HaF/46B4p8n6EjiLZZcdX9AcgMuq9xjabOTuonirIY3RQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NcVYKVcT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LYXWldO0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF4C606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF4C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NcVYKVcT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LYXWldO0
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8ZPjf3850073
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bfYkXKftGpF5yfABS1UtuwUuTJGO6Y1zVSNuiv9+v4E=; b=NcVYKVcTuU177hG+
	ArpYA8LSEzGHsMJugRQmXh9xVaC8dkypRx3jlMrTLrRq6LmqEHY7wpxzkbleek4s
	MWaNTGJ5EVtdAUUqCP6H5DR8KZ4v7gWwExqvulvvHJ7MImIn72VKOem0Nk73T77X
	GdbNFZF796f/ch+x4kkp4MwCgFlsrnXMj/+55NgW0/hljc/dwn8ss0fFK300J+G3
	ud6i+QU5vkz6MoI42APFOr2z29ekPSG2/m5cEOroWx+WVJM6pJ8dO1V1ZD6tSK1P
	Q9F9GTTN3PMh07zaFDGmlOhqIHrmw2fEPTXCcA4N9mPMyEircZl4ERqxK7jYreyo
	6ultrw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyvwg29s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:56:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so414348485a.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 00:56:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794300999; cv=none;
        d=google.com; s=arc-20260327;
        b=IUuy7iKxHIELGVRaVLAYGOeBbVEg6lfASEMY5TKbnyurl5Ng2BPGqf+KkP+UcpDycM
         Al+nmRa7/0iAtcGVySElUQHRbYuuqP7UI4pgRCnEtoyNzjoiD/Vg468qkXvpNKSWdHKo
         mRZ9RWvDpYvDxYnZTClIvjpxXLnC9nlCtPf+i2EfRZaGoQNH9LOObR5TnyJdqvdW/QUt
         kLjddat0EwyzIU6LXepZ4+T+eqgwKUDP2IM/tg8Jp+QYBPYRUWuRTXCaOFFkboxG/paY
         hbA4F44B886HPLuhUzIM3g9NT6GD9i3f48gCuilHXFChoAeahauI0pN0xWEPAhheeHCz
         2myw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bfYkXKftGpF5yfABS1UtuwUuTJGO6Y1zVSNuiv9+v4E=;
        fh=0hRywhQm4Vt34EqQK4tkcEkHZSriJBFxVIWJ/tjRVOM=;
        b=rm/d7MNQ2dXt63LXVNzmBaTDkA1WkCWZJikb9ycQQzgUfSoqNtV2Q+rHnlECC/W/19
         RppyJoCK+4b5EXtSF9Q0JmzW+iK7j4wdxegFl/sTMjCJiiGTfpfzvixc4Yzq8luJxm2y
         2LicQxaE7IgKhVhT4LX7XXhNZ9ZYSxwREuBA3UoGwOd1tCJQTx5hpONn3IxpLdy9ChQR
         UaNZVa8WvR+pQWjqxeJNOLChA1NwWFRPHRE3iEoNhlF+fe8S9WA1V7D7TrNCZWeEQ8s6
         HHs6JWBnjx5t39odnDxIo97EWjxFl6K5mTB4+psWUUqkorfWcstFuUCLiVYKWjdJlxhU
         e9pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794300999; x=1794905799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfYkXKftGpF5yfABS1UtuwUuTJGO6Y1zVSNuiv9+v4E=;
        b=LYXWldO0c0vma7FyZr15NbRiXa35ihkswPHRtXQQ1W5Ze9bs35doGfEBxaer1nfpzC
         bD/UTK49HmANCUZfCbW/I82oMeFRSge9KfDedtqZvpgX6K66QktnPDnrIYzCGiaQoDOr
         7NSusd0d5U33/V+CdkT+NbdpHD3LxUtI4lXJtSYVcCO6x/AdW8cao+3AqGNxrBpQwsEu
         3BTwUO6iDAdCMb3XP7Y5YmUubPe0NwRdlyufzK+uHkNOuqKWjSekbqnx/RL41xWLjwM9
         d4ssCS1MYf/GdizKd2yaoQzL6+/ItVe+qPVngUL8ls6i4GCFsA9L1EdPkbMatCowYHCJ
         2r3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794300999; x=1794905799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfYkXKftGpF5yfABS1UtuwUuTJGO6Y1zVSNuiv9+v4E=;
        b=Q3Lit36iHDAYtiGW5FmPQuatpBTUZ/9VHtsjacWGDxO7VMi2u2nR410baz3txbbzqf
         QKVvLpS1s8AhnmkT2Qo5s6+0cHib/RojLC34VvG0IW2c4xsqxHqH07guI83r+5xogRWk
         dWx09/N4GlRMns4TRkgpIEczSB2A+xmgk2bWEmeZTwZSKBxyb74dL7qs2IGBtAfe7e94
         28wOj6p09C/7KaHPAdlydHOFwCm8IOF6EiA5QwJkABcXUiYzrWLlN6CorQsNHDtLjG5P
         URHUgqGjIMorDKV8PYzELtGyLV8X8vdmsryQRsh17cx5MLQimWz+ssFmIJ6AvOG7awXR
         fZAA==
X-Forwarded-Encrypted: i=1; AL+hErFTRa0JsWMOsJbmgwCpznPMOVHdqH0txpfL3SnrdFRoX60DKe9XNSMSPYIFZxuwZiwAC5G7zyI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UoHmD2zEYEMshHkA7QleIr2BV6BmBU3BSC0ld+fpgz3w8PPWk
	wfbHSpF3aLaCzwf3e9yatRO8xSaVwA/nRbLb3DR5QnDE0sIGoyd/5i73p91gJCZXX2XC4GTTQHg
	cAKySBIwAzMMNvoQ7MrMjU7GSB2lxzWABvI7WkH0mbXuTNJX5j3shuB8/UTAkero6iDkxPUuFki
	XDcZ3fY2xGCdBLnYn6GbM0B2HQ3GI+12XMJg==
X-Gm-Gg: AYBFou33wM3rzsjbeR7s424MMuBS1XPIoedXJ+jHl8rD0DXgibgsOq589vP2922h6CK
	X8FXZ8vsNZ2Rh0qXYymlBuBYZAkxz1qLPeAz0g1Pn+ooj63iousTywhacbqo5KSvYOTNr6nqKWz
	WdkQWF+fGdFSfKRxyL7Nj8Rkt7ZVaAmmHNRalhfTJnJiyN2PPluNFbxzA1MftoZ0QOklb6GWxiX
	+4ivzDl/lfSNOxa1UVuCFV2eCDsP0xAMJTaBJYTYkOOhvYfiI/L5/AyMmmHfF9wHyHEEsT2Moc=
X-Received: by 2002:a05:620a:1b99:b0:947:1d0a:c8b5 with SMTP id af79cd13be357-9479f376a32mr281793885a.54.1794300999453;
        Tue, 10 Nov 2026 00:56:39 -0800 (PST)
X-Received: by 2002:a05:620a:1b99:b0:947:1d0a:c8b5 with SMTP id
 af79cd13be357-9479f376a32mr281790885a.54.1794300998919; Tue, 10 Nov 2026
 00:56:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110043006.56681-1-mhun512@gmail.com>
In-Reply-To: <20261110043006.56681-1-mhun512@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 09:56:26 +0100
X-Gm-Features: AclHuK-N0de4R4VH80DI2aBSXz1-I_SLqkM14uwyZxhv9nGfyqNbeQpXZOsGSKI
Message-ID: <CAFEp6-034hcHagE08zVahE4xPDxUcTbFNYR11N5N-mf2ojG4WA@mail.gmail.com>
Subject: Re: [PATCH net] net: wwan: mhi_wwan_mbim: disable rx_refill work on removal
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: DfWtivVstuSJgwt3fsDeZrTGocGKKddZ
X-Proofpoint-ORIG-GUID: DfWtivVstuSJgwt3fsDeZrTGocGKKddZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNSBTYWx0ZWRfX7m+MT4CrRMJ5
 6eNmJYth+zBvZlj5h27TLVK1ReerASrjc2KpwLFbNXjFYxZrY8+Umi2cQP5WipdoX7WZQBRbFNU
 1hC7bK0+rUKmAsMUOxjxVL4su8oI/eQ=
X-Authority-Analysis: v=2.4 cv=NNpAaE6g c=1 sm=1 tr=0 ts=6af2dc48 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=V0Bt14TRAW-i4m3jyEMA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNSBTYWx0ZWRfX/nO5p8krpBLP
 9hWFn4A9yDl2n07kHxuJHx3LlMwux9gBZ5hcHhWHI3Bi1+NzHyFviIcdRusSR+xfJygxLt2ljkQ
 EHztCxmhOZUNXzu5jktmQj4P0eo+ykYT9zEsi7guut1HhATLP3wYnZEPunc5CmAhfZ4OjQEd6o8
 qnrok7KHMisYjmKU7ezLCVxndib4AOXr/rwIYmfob7aHa3g+arS6WEbflr4IAi4Ao3baT0RVeXH
 s45F2pmVQDpTgqinfxQucLg5nZB8jlPbBZWB32Qb2kZ0osIZGrjF2y/Z42wQJeHXAvsZgwVB5Az
 0LrMRhYBfFPBR8XpCZ10ziIltWjr+lRl79Kw+EBMa1eDOFN+oqk1r+Ayvhl6DXMvxMsvPzM1IFp
 spX9iSWT6+ar0zpqhBX75uZm80MepOPRXuzaSk2JSNF1ka2wr9gV/nD/CoWWBcYy7wRobqHAH8a
 STrf/KsQus+bPyC9cjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100035

On Tue, Nov 10, 2026 at 5:30=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com> w=
rote:
>
> mhi_mbim_remove() cancels rx_refill before wwan_unregister_ops()
> removes the links. Bringing a link up in between calls mhi_mbim_ndo_open(=
)
> and queues the work again. With the MHI channels already reset, the
> work cannot refill RX buffers and keeps re-arming itself, eventually
> running after devres frees the context.
>
> Use disable_delayed_work_sync() to drain the work and reject later
> queueing. Probe initializes fresh work on rebind.
>
> Found by a static analysis tool under development.
>
> Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
> Cc: stable@vger.kernel.org # v6.10+
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

>
> ---
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index 336f89756f10..3b6b0066f673 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -650,7 +650,7 @@ static void mhi_mbim_remove(struct mhi_device *mhi_de=
v)
>         struct mhi_controller *cntrl =3D mhi_dev->mhi_cntrl;
>
>         mhi_unprepare_from_transfer(mhi_dev);
> -       cancel_delayed_work_sync(&mbim->rx_refill);
> +       disable_delayed_work_sync(&mbim->rx_refill);
>         wwan_unregister_ops(&cntrl->mhi_dev->dev);
>         kfree_skb(mbim->skbagg_head);
>         dev_set_drvdata(&mhi_dev->dev, NULL);
>
> base-commit: 0edbc945eb9edd0086f25b151a79cfe4adc0dfa8
> --
> 2.43.0
>
