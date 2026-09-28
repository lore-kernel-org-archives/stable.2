Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF54F4EB867
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611603; cv=pass; b=NbMWzj1+kOTnCV+kI5/7rfVEzn1ABdaRsKWtQaF5YhWPaK/R0OSUkIHyBXnKBib+F1FwiOB3ogXCHwxoF7dMLrNlk1X41bc/yMoijkgkKYBJXHipwrDduKn+m/1Xlt56KlbqDhiD5kYizbP3oAa8/HtnJJt+CcrbGdVstd+6svk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611603; c=relaxed/simple;
	bh=AxwspMKsVZK1XQ0X1dJ8SvYhPShfagggpXNX3D7+lkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXqdZ2CY/6cP4zRymr8VOW85vPjt5gg0+AQMf/tWmHyruUEmU7mBE0xpJhv9tUTevb/ncCiKNYb6ymitNOx3WwpGDh2E57buZsekTHoHBQ2NIuuRrcUK7QA96Nk2F2S3E6vgyUDiyyDatEc4/JrPOANWBelRd5tZ3etB/hyasms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M5E5ZulZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YRlnwJPM; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M5E5ZulZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YRlnwJPM"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SEduie379019
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bsxl3A6ArhrDNBtoIVBz3Hxm6FeKIX0tXSSS585UBX0=; b=M5E5ZulZAP4oNlP6
	EtiXRsQkimO0coeymPP9xnQgROgpGWaYQowXn9Oadi0rj38qsAVXzTjuOFgau5pm
	t93DeZOdyYrvHi58xTkHBABjEamUNnpeHNTG62CPil7fTTStxpz0aDkLtbfecKAM
	3UDlSEwTMGkE3mLZTGc1BZkZfF0mp1WVOsHGgmTrn+ot9MemCFI66nWn0IbUtIJg
	tZSy4RWIadrmToiStbs6FgIYzIWihhWfRSyoa3dQcWqb+0jbF4m6bO4IVqODp/cZ
	dGMq3zCAjRCswtd5kC+07wD+V9nISDhwP24lU0jQGVt/ixvOQbDN2l/VVF9eLsst
	LVSpjA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyqx390qa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:06:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso2855437a91.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790611593; cv=none;
        d=google.com; s=arc-20260327;
        b=idkGcB/57Ysz62UhQGHyW6633i9L+ZLaiMupAAdpzTPq9BcMxyyV+R3SkZvTjZREAg
         q9sY6EdYWpn2Msh2ipzVvIL8Q4AlgUObpriHsf3+c//2+I5xUewNm/Hqs/+rI3qvxFok
         r4RZmhCAr+/pbA9XO4r4iVV5obsF/Oas6NJxcxHVeCgysNwn1k0/N8QdsvUJ6XwHJ1Id
         IuiiQ20WmgdfuyvmMGMAaaynFYauMts9isHZku1/XMJifR74kmk/R6Ex7IDJpsG8S3do
         0VQ/IqvXKt9gYNXKb8z+TLuNd8LhGFgLcfy1ikSHO9fSLfi06qv1/96/yihLRD8N4/rX
         e0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bsxl3A6ArhrDNBtoIVBz3Hxm6FeKIX0tXSSS585UBX0=;
        fh=gVfm2baats43a1/JbOQIFrpiU6Qk5aPfMqawuwBxm6o=;
        b=rVnBm92hHcBmkzGTvYh0xms/pUVMUD6PCqBCOyIXjq0crwslTpcUFnRVxqV7ZR4BPJ
         /HkQ94ZQ/Y/A5Ldh40zFHXneAu80tU69aHGRE7B3BkXEKfvUBMkWePqoJoAAAJaZl/z+
         8G7ZxuqY7IWK2h6VOoYqEWTitqjbCTO5hUd2uEfDIfxpUyX46POyJ531LiVQTjHvZVbs
         PaporZA+B9NkutvCGhL3kIjCXoZFYvHN5TR6WNzovkyPL6SnIMCMLxquVVEZ501gnqmH
         +Rryv9jcw04k+EUhUG+nsl/EQjHRs5PmTIFzTYk5CZsrlBZEdn6+72W3CerDKDQSmxnV
         2TJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790611593; x=1791216393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bsxl3A6ArhrDNBtoIVBz3Hxm6FeKIX0tXSSS585UBX0=;
        b=YRlnwJPM843OPEp7IQ/+gvYPbTFbRHkvhu67xcpzhdr1cNWWejIrmpqdHYJmFvk4Ib
         /Q4R0TUKCeWsxx/VHY8y7vLwWh76tywzmxNgW2iWIJ/dfuqHVBFA4GiuFfBu8dd/2Uyf
         VEmCy8I1sV4UmzxuuZQYpCDldO6uLUWfdH+UX1S9JHzc+tq8899biEt0JK1jiAZI5Ibx
         5NVSYwyp0wq1J5SBJpSa02M68shY71PDdzUBABqewepYr5Pacmb8WuTIVL8BAtxdD6TD
         MeGNUZix6pEc3RA7vbxXIvb2hgSe/PINEtdcQntsHTx7VBg+XlKA7jwoa5B79T4MZ/Ml
         GRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611593; x=1791216393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bsxl3A6ArhrDNBtoIVBz3Hxm6FeKIX0tXSSS585UBX0=;
        b=hlIqyGkcGq0dxdQY4eiPYrw7pStVwCSLl3EPYb3BEdSyGzybUjR842MXAxUg2v5/2t
         bMOnf2ehFlOccmdYJvyqpUzXn+kTqRYP4JrZywkcFHFZUAffEJHFve2iRvkv1NNXc+zX
         ZX9BgwxET+TlnjCjm0NxiTUS5/kHiOSexxJNaF9CbVCQb3g2fuM/YtszSIN6N2g+7SEr
         brAEnNt56PxlbMeDEr8GEDMyjoACbuLpcOD5+td+VH5bfGoHi7pwOBS26336rVqcbR2p
         wzAIui35fmD2IyrRdJoigxWQLU9HmZMpqz7TkMKkm09WIYP0b1GpSEb47gceHMNf7rjH
         39Uw==
X-Forwarded-Encrypted: i=1; AKwUvBzsmKHm4isNmHSRDiQA86GMs7ZtGt69x+DndqkkhN2LkF2kACkPVy3/N9Q1qvPGvLb1oa5g+BU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUcOGUlNnf0Eu+rkWWimqxnMozkMJsv6pqICGUxj7OmIjLNnAE
	YffpCkAnb7Ngmudz+1M/sXPeUGiQI4TNWzWao6Ay+32klaXnmiHj54ufJpa+r3oijeHTIR8sLyt
	/kkjCmhUqe3n63b6dhaYyDzoWSQVHu4rGsARaELtbmVde3piM7IgHdZN9S+IPnmyQrw0AmexMZf
	NQUoiyxTqFWnKu3aHixJJa77QQ+mS5EhqHyA==
X-Gm-Gg: AYBFou09+eOYybADGOJS2jLOIs9M4zaKuptz7mFVGtsEtgTqRulMkKgZYYUTYcZ2z99
	G/82yDNgtXtYVs/tpiD5qI5NmVx5ISGRsgzYAjcUxkyqCJqj7qhlcXM2dREiGu25dnv+UHKnp8u
	dkrjQMPRmzGfnsIMlYjMmoE8bfsjvpcXuQMXKGkyZMPZam5HPOKNCayC00Rw==
X-Received: by 2002:a17:90b:3e44:b0:3a0:e247:3ad3 with SMTP id 98e67ed59e1d1-3a0e2474be8mr3602121a91.40.1790611592615;
        Mon, 28 Sep 2026 09:06:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3e44:b0:3a0:e247:3ad3 with SMTP id
 98e67ed59e1d1-3a0e2474be8mr3602106a91.40.1790611592087; Mon, 28 Sep 2026
 09:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917101750.2146473-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917101750.2146473-1-vulab@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:06:20 +0200
X-Gm-Features: AclHuK82ucEdSmeT-bQHmbw_Uh16I1-7A4GMKqZ9onj_bi2194OPKgUaCmdLCEY
Message-ID: <CAPx+jO8Jef67qM2nvZKO77=H7P5EAAQQq-LfpFxCuUmhi+xiUg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix OF node leak in mmc_add_card()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: hansg@kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        s.hauer@pengutronix.de, ulfh@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX+LOdNlvQ7QHR
 TubmuD4ZX8eQFVlYk1VEFORC5411XyEI5c876iPAlc1DRSJlL+Pa5ayxKn/FLLDJTa1YP0kg/CJ
 +RFW+JmTH3WT1pJTnqrMH9DXGDWhyrYgvQO9MCxhprzNps2QSJD2HLykvDvjuFqRPUVkX7DStJs
 zYV1+fvuHbH9KaGByEJxwXLi4xAvk1gNbIz/m4kNPbvS2JtxP4x0LTQhMxj7OxkrdHKb3+Ol3g+
 9S0pdfyVPGp9AAnBQ8uw3ywHxwzbqvHhPtoEXw0a+ws840YlcLdo2COBhicAAafMcJ58+NqrCjZ
 Zo9JFeydOB10eUITwCEAm7+P0YwfLINcX3sBDaXT02z89tuoLx6Q2VWJH78xaStbQxU7fXFaulk
 KVceg3hUgx0SZ/PkzB8gD5d9IJyEhTnPcwR6DnbNXYtMFC7l4bV4ywIr2iHngq/Gcc8DUqcSMb8
 mNfdAjc40/kowaNgDGA==
X-Authority-Analysis: v=2.4 cv=f7jdl+yM c=1 sm=1 tr=0 ts=6aba9089 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=PUCtf4xQaR7MHDhmUGEA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: li9xii3y_j19k_WEaXcGsD2-_kJenYme
X-Proofpoint-GUID: li9xii3y_j19k_WEaXcGsD2-_kJenYme
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX3J5VtmCkXBL/
 c1unDedvaW5QWnoagX89v5BlRXOXuxfr+7RlbTou3zwZhO/nYcdfT2ouZ7ZJ3Kp112Twpc/H+Ut
 nh4iqMmT8DfjJuM0DTAdaiIamFGgoKY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280064

On Thu, Sep 17, 2026 at 12:18=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> mmc_add_card() stores the OF node returned by
> mmc_of_find_child_device() in card->dev.of_node before calling
> device_add().  That node carries a reference which is normally
> released in mmc_remove_card(), but only when the card has been
> marked present.  If device_add() fails, mmc_card_set_present() is
> never reached and the cleanup of the failed attach cannot release
> the node, so the reference is leaked.
>
> Release the reference on the device_add() failure path.
>
> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

We have already a commit that takes care of this ("08b54e16d547 mmc:
core: Fix OF node reference leak on card add failure")

Kind regards
Uffe

> ---
>  drivers/mmc/core/bus.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index be5cf338bdeb..4d862d9bab23 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -379,8 +379,11 @@ int mmc_add_card(struct mmc_card *card)
>         device_enable_async_suspend(&card->dev);
>
>         ret =3D device_add(&card->dev);
> -       if (ret)
> +       if (ret) {
> +               of_node_put(card->dev.of_node);
> +               card->dev.of_node =3D NULL;
>                 return ret;
> +       }
>
>         mmc_card_set_present(card);
>
> --
> 2.34.1
>
