Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3582431E49
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959888; cv=none; b=LP1yzY+8a2Y6pb0pP0q2JtxEOHJXeDaj6GVnMbsiJnjj8e+C4huAhUi/v2BY3wwlq26aS90FLNFFPZLz838Hhvb05fizcz0qXlnsjrtInL9dBXXn/NUBX9425IuzL4KAEgDMKE3v+BCId9lp4jQ7wGB8Z1onRKCN+KyP1KdJK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959888; c=relaxed/simple;
	bh=D9zcpEo2BTnjHoDwntn2qm/V1fY3IMNo7NTHG8pKzKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgLGpADnZOqn1fCm+YlDjBX2XgWI1IFDL5bGp0iEavo5sYLOhQlpO3S3O3F4B9rGJDrhbZyU7I6/sE4JuuHlECVO6n0BMo8VBN23IPzvJ/uHCV+3LW3XPe3gv79k5QR6yrqRRoqgPEHw5s5YRFKMo9PWEYXAvPGNdMdRa76CSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l27H+qwL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J8bT5/fX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l27H+qwL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J8bT5/fX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621KJx73053488
	for <stable@vger.kernel.org>; Thu, 2 Jul 2026 02:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aAocksvrvPiuDLZfb8BX1Ap+
	0GdsKT9KorXLJ830nKw=; b=l27H+qwLr0JagE3CWYagpwkMQQFOAO5shE+X50T3
	8FZ6qoFlq5MvKzsnmKa4vRr0+GHJMGZpNDk4rx2O8KdqUeHLMaJrabCHk3nUMkS+
	+y2XutBQfw+51/3ZnAWZ5IU9g3DyxGE8DyFcjNxBig2b9vtOPgpgLQ4ISATWh9nr
	79596mtWdj82JC6vpQXgpc+6qJhphdQH3pdWkYslF1uznoWM9URigPjz3twe/YDG
	eyKgVJmUeu91cjrK7P8crnyc41rygd8osv5+1mFe/Wt2agUWRv5nA6xMC1c3+ikX
	ak/cty4vrCpTBvMfhTNoQKEROxrYMSR6uYmqP6IhO1VDjA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd3mfk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 02 Jul 2026 02:38:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c894391f000so2378697a12.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 19:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782959885; x=1783564685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAocksvrvPiuDLZfb8BX1Ap+0GdsKT9KorXLJ830nKw=;
        b=J8bT5/fXctBNvfpe6tt4+G7WqhQNUKYgKQbc/4/pW4+feY71K84wWf5bAbdQ11/ETk
         K+iHMnrA9h0E22e1O/zlbIBpgopHpcMPs+rQx4C8divFscF17IMJ1y+xT0hVszBLn45y
         tj9/kPt0y2pStXdTXPflx0oe1peUWeMpj1v7C05rFTHCNNuZRuVneA5Pl5HdCVBu0lmI
         bwGo8QlNG0EDxEfhKwHgmUEOUpiNxWO5RRNwTrpzSXQJ8rt246oddTBpUcor5B5RrZdF
         gCwsyyQPvEeCpCgMioyeBJSIVwGsNpAJ3YcYazaHNO3IQQZrCWRdfYjDnEegThNTkURk
         mvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782959885; x=1783564685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAocksvrvPiuDLZfb8BX1Ap+0GdsKT9KorXLJ830nKw=;
        b=Mb+61WLy51IH6J6MJbB7azS0naosSEZ2BnxI8ZL/NAdQ2HVdZoGh6oCj0c4xGrBqGf
         OBbXEL9GEUz7nF7tJYpezgl0dgt3AacQDa4rrebaRC3KmPDZx2IFF/nu8v9Sujft3l4s
         h006lGr3KeSOPUmrxVfU3yobcgrPWxg6jtZjhaWn+16JBVli1AMBdXmHXOUTBeaa+Mcv
         7QyaQU81k64PEoGLajrg0JGKX//QbrbCbMVe2Yul5hn79GJxK0XgchmcTTkA6otBXYyS
         aci/fpgkiG5ejVvNuYeG5ZIuVMQyFToV73U3NTCdndxizq3lbFoAyryZOwsakpgJlzO2
         chaA==
X-Forwarded-Encrypted: i=1; AFNElJ/H/TFKrryynxbfDOX4kBB3aWuq+8voz4i9+/fgjqKxMW4SrxmWIBuBf59KPQ7FkcUYUz+qSH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnabuek0iRx9ic2Nz3KK+F0j/nOkYp/B18APO0S4C7mKd9k0m
	F4Wj05tcfxelNz0DVf1C4FQLPnBJ5nOP8YEexV89x1JzBaoI1dOKLb2tycjb3TjJRmd8u/4qS75
	3jIQIhBnsOcFMQxgoJORe4CFrTbUh1bwkttaNIz4mRIJqAXqPO6uahfRVwAk=
X-Gm-Gg: AfdE7cmuCcqSd82iGfC/SutT9oQZ+kXOm5QUjYwMvi5DhUROrcBBy6OEdrfOIQUGveJ
	3OrjxnXxjsm6IRks8mUoeOlYw4EJy2ulAtpUm/bAIk6kg1jl0tK32EI86pjz0CVIMvFv2APJzYA
	9IwhCH7RWF1D+5Bbl3zaAq4liXPVDY/ZgGviL9MH6tLop7OSPmVImbNbZwM2f7YpXG0G0QnVB5b
	QV0PAYOw9etYlfO1okYhwv5P4n8fw1//t2uupfHQzYn4npYlieFeQt7NhGupWAIy1v6QMDXkO+7
	ui4xwC3amaUPkXpYKuF+ROje/aMEipb0E6gTxPbWnZapKcv1Gh8cn4m+2PJEc7gymoyXW5MKSVO
	2zl46z7qgt8AMLgmARSN20EcuwckNdMfzx3kgVEaRDgWgeSR3Db6jDRNA5dI=
X-Received: by 2002:a05:6a21:398f:b0:3bf:e449:332a with SMTP id adf61e73a8af0-3bff3ffd7bfmr4105587637.3.1782959885038;
        Wed, 01 Jul 2026 19:38:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:398f:b0:3bf:e449:332a with SMTP id adf61e73a8af0-3bff3ffd7bfmr4105560637.3.1782959884515;
        Wed, 01 Jul 2026 19:38:04 -0700 (PDT)
Received: from hu-yutlin-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm4458728c88.10.2026.07.01.19.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 19:38:04 -0700 (PDT)
Date: Wed, 1 Jul 2026 19:38:02 -0700
From: Eddie Lin <eddie.lin@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
Message-ID: <20260702023802.vsma2ler3idkj7ru@hu-yutlin-lv.qualcomm.com>
References: <20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com>
 <8798249b-631f-410e-8b1a-fb1c35545134@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8798249b-631f-410e-8b1a-fb1c35545134@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a45cf0d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ADK-pmORIISXle8dMtUA:9
 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: Mdb_lPo4zmfh2ncBoN0MGi65s64xe_oq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyNCBTYWx0ZWRfXyioqy7TUK+A7
 Uj/66uy+cVIAf7o1Ids0gmTyYNdqJ/tE02Al2j8+I5Z8JYFMc1SIHQ6nFTIuQkfpvrecu76Tgih
 E+C48a3TAnFLZ+x8SYoGaYg06xkw0hk=
X-Proofpoint-GUID: Mdb_lPo4zmfh2ncBoN0MGi65s64xe_oq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyNCBTYWx0ZWRfX3mCM28rozXdA
 yY0yEq8XGsin//ueDsG4R9u7Qh9nW6B1c2lk/nwqVe3O2fQnQIVpWuCI74osxlmAgefR7B1IqiI
 nvdk70HvuRroMnp74AlJTjkXym8uncOdCML8fxTzOdl0v1fQmm8UYfrVyZlpeLgxNqRRYMpYMNU
 G4Rudv0Ex2TTz6oYN/ahQedQON/uHAFbMXWQgZYrKhybw6apNfIX1PEpzlUE8X7SgjxmXLMyBE9
 LHS2dAVGe3NqH48+akzobzWoR9U7P5SLPfNhRYRFPbhRYoAJ5qwtds3dZDg8qdN8gAUPTCKY4t9
 2cQ8pMbVersaoH9lKe0gh4yLa0w13hMFksuoZgx6hJmHiPQ4jEzJtodZqJnaipEZ1uAVjoQ3+Bm
 l8h08KHSyOsDsU354c24FbQWxCp8LXdqskERKvvYmHUdk+675mh+PLTO6aysgcXsAKfynZor/pg
 bcqam51Ky1CwJ1DnnvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020024

Thanks for the review! 
I've addressed the comment and sent out v3.

On Wed, Jul 01, 2026 at 05:05:40PM +0530, Ekansh Gupta wrote:
> On 17-06-2026 16:39, Eddie Lin wrote:
> > The 'ctx_idr' is initialized but never destroyed when
> > the channel context is freed, leading to a memory leak.
> > Add idr_destroy() to properly clean up the IDR resources.
> > 
> > Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
> > ---
> > This patch fixes a memory leak in the FastRPC driver by destroying the
> > IDR associated with the channel context during cleanup.
> Looks to be duplicate information. Please remove this.> ---
> > Changes in v2:
> > - Added Fixes tag.
> > - Added Cc: stable@vger.kernel.org.
> > - Removed duplicate description from cover letter.
> > - Link to v1: https://patch.msgid.link/20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com
> > ---
> >  drivers/misc/fastrpc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index a9b2ae44c06f..7727850e9240 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
> >  
> >  	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
> >  
> > +	idr_destroy(&cctx->ctx_idr);
> >  	kfree(cctx);
> >  }
> >  
> > 
> > ---
> > base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
> > change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
> > 
> > Best regards,
> > --  
> > Eddie Lin <eddie.lin@oss.qualcomm.com>
> > 
> 
