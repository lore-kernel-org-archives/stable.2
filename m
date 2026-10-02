Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F3379C4A
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944906; cv=pass; b=nJ90LwFDx+A5Y9+94uBNRUgMH53PWKG80poXTVgQ0wpopMojNXouNIdAY5wibZBJfjv+q2uERz0zYB7HQh943jVTg2D1fpe9Laen9fSAbRwTV5QWC3m06DnDyE+M2TyrcbcnQeSHm/IHuwK2bmti9BWCbVBvnxK5oqpf0lB0YeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944906; c=relaxed/simple;
	bh=dRZaT0v2TmBZvF8WsGQdtfCeSyKpr6m0eRP3xCHKJKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Luw506aEIrRU2EwsdFiRuUZjtezvBm6M8E1755I8R55LA9Mn4pKZZ9kZdBoLVC00t4Ydx9UOcbZDbykNa7SWLb/v/12oX2sai/OAqBg3g39hqgeC6uao045QvfgthWKzIA4O3e/erH0oNHYVyzWgJU6Obvf/q3tDak6jLazQr/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O3mYYKpX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XINPyfqQ; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O3mYYKpX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XINPyfqQ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929niBO755001
	for <stable@vger.kernel.org>; Fri, 2 Oct 2026 12:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dRZaT0v2TmBZvF8WsGQdtfCeSyKpr6m0eRP3xCHKJKA=; b=O3mYYKpXAsxABBqg
	U5I9dO9TF1exTEE6OcmhZO4qCL4JuCSlZR2Vq1f+xixjOvNlSWt3FJe2Mk/z4lw4
	ICGBunk3IUplElpmqCustFs8VuuJl6zWFMnn/CCGf9NuAk+U4NP+nOFEPextLLWF
	XNEJ+1YMVt+k/WU7svtTTZ4WUa1J8flu9MTt+kwR9HpitjFWvlVEnMxRMtFBbEZo
	i6ol4F1qpArcWZ8Wb06n238+s8bTSlM2lGXdh1CWmdXjFOF6XUFRjPp+IrwaiLGP
	c8+jhStmkQAwxnCLJyvHcgI4noZ1JLSLXAlpy9ltVsRLj3114cMfANYuXEkjTJ4b
	uHedGA==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9abybq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:41:42 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-677ada64e84so876892d50.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 05:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790944902; cv=none;
        d=google.com; s=arc-20260327;
        b=WoFZGMnlvEJ7J50yHO/LIAD64cTCpbVIZeMtTaH9KFgWYBnc8zK+AKyh4/eWMVMiEa
         FMWMpAYiKhi6mb8vQYnhToYWWL2s0GoJRUgr+O50VUeJEqZddjr8GLN6va0QwcXgL2zF
         SMOcmJ1l3mIjQVCgNH5lCZ7mZKcBem2vfstt0W/TNpE26fW2ENCPMTOrfAsVIbGaQw8c
         WbRs0WN9IT2DFP1LOMKM0HiF6L83gBVPqmiXX4ONxasd98Wx5NPjjyuxdM1hG6vQGgPv
         T5A9JLaumliyux7qCfjvZkAPDrYR1a4g9eswDUjpRKCFtmezj2Ur7seNAlIYhdyvQ+Sg
         pNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dRZaT0v2TmBZvF8WsGQdtfCeSyKpr6m0eRP3xCHKJKA=;
        fh=cGSALMDelK837MzxJxlw+NfU1AhVlHNCiRvTk3+F99s=;
        b=al0GoghiDs/I1fgo3+kIALWeOWDQDEuJ9R5tl5+JwUOE8Y/bQlznTuhsXlGza2SxQ7
         z7keeyfkUVgeQs61aHL7MPxSSsTy6/6kEoVwBlNrSWEqHYkSQtUIBCxopBROLi7XQX4E
         YMCTAf+yN16gRc8L5GRa1E/f9Cys72hW3jkVbodVTRhyw7dVSdSlCjBnfTvvllTLnLZs
         PjIRcEd5vPAVGXt+mK/UFbeFMhkBrwUdYflT7qZJpS0Pxc0e0aSI5imVU6lUYzTkFt4O
         aX3UzyCwmfmqJpx8pOe5oTpP2lQuMTK0U9XhYWJuZe/EP8TlFdxNpCBjymF3FVxv9inx
         3yRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790944902; x=1791549702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRZaT0v2TmBZvF8WsGQdtfCeSyKpr6m0eRP3xCHKJKA=;
        b=XINPyfqQn+m709BVydKwn8wotUdOxiHuRtJqvooLPeN030srIP2CYI4AxX47PUMVkL
         31+HNJ2gvC4ijnkoleTgU0EcINAvpQ8XsWi4YhwDp567jZ7blfBJhtVaFPzSoUVzWCCT
         qQzvp/Eu2N+hvxs5FErMgQOGbpYwjzpkkuMXnJ0tZKIWgmL6QZQ0xW3/xQjFH2ccewau
         1Cc2mvhfDIbpx60LgT65lmYtwp1KG2pE67SVBWdoAoJvUYwfasqMA0tuJ1Ojh0A2sTcq
         G0jLU+NS81mVxJ2IRxrsNUMDk9CSkKOx7Jc9FlRYBtgRT3Vncob6/KwZlTk/sxRpTGPf
         pomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944902; x=1791549702;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dRZaT0v2TmBZvF8WsGQdtfCeSyKpr6m0eRP3xCHKJKA=;
        b=xFrSWciHSzw7WA2o3HaklQZDp/rIRqULHgpO/E2aaqJ8HLcbILLJdF6PO5wh2lLg46
         0BIPo7+zu2MvflX+0lr0YiwxoSKQlB6sWP6/59OsRPrfb9R1hE2pxYT4uCzRw64rNE3P
         F0cm49mNwnoAVM5UC1BDsOyhpxOcrxQtYs4tbIG+oUcn1SoASvI2wSwhSQ8SVHzyFyFs
         1DT9wd0gG2mBNC2Y4J/HBOSxPDGmHm+w06Uyk3dbLvgCYsWK3nNVg4Blz7eGJ4sXHN9q
         58hCYFp2c8L0IpXGRNFL/f8KNQluC5rvLZCQdfrSRyIsi7SpPzv1inO8DXSE0Unt83t8
         iyQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdxZXdvO+23tpMF6ZYoGePrp7ynChzjEfgDdMp/jllVsQiGwpveao8yDwqBUBSv7KYx5B0bQM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwi8LXWL7RFFnx1/d5vYI4Ze4siFHnHoul9GVugyQLqzp+4vyV
	794F0Cupxxw6u2iFjDJKLLdPHXdUqcSOU1LAY4d2ad89tqohthEMyhy7j3XvMroFrY7P8tHBgs6
	rFp94UVhMk2OCtesaw+uWpN2A5Neg1xizaQYUExdfWza6TMvzP8csjZJUfky0f+7WX0nCxbOP3h
	P1S4YPvlqJCvCyfIwMe/r5FT3uVmRod9o58Q==
X-Gm-Gg: AYBFou1hvpBsXW5qfwLYiMxEhLpUgrtw1Z9hS+gh/OZ+lPXXgMg+sAIdlmONmzygKJj
	74kv2on/LxQnzvAELPfPsoASxqqiWZUxwA6GP0Gf3XpAtaoymQGV5M0fsywr7JUC7BqUgP2Qb5F
	eU38hSW0j9Gs+DnuWgHsBBy84J8ch8q0PWtAIPtcYuIE2iEySQLA7UbVI=
X-Received: by 2002:a53:ac94:0:b0:677:b096:dc85 with SMTP id 956f58d0204a3-677b096e313mr536123d50.2.1790944902474;
        Fri, 02 Oct 2026 05:41:42 -0700 (PDT)
X-Received: by 2002:a53:ac94:0:b0:677:b096:dc85 with SMTP id
 956f58d0204a3-677b096e313mr536113d50.2.1790944901914; Fri, 02 Oct 2026
 05:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928143113.1700001-1-g.osokin@auroraos.dev> <ar5ZrHihBjaFKf5U@sumit-xelite>
In-Reply-To: <ar5ZrHihBjaFKf5U@sumit-xelite>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 14:41:31 +0200
X-Gm-Features: AclHuK-7c1iGj-ldS6d2v44_ZjTFL0eWnqOG7BeC3ANxyOwSZZphCREJwfZPF3o
Message-ID: <CAGgiveU894kL9YiLse+JMJgX0Ck7W_6ZQ8hfX=6KU7wFAr=WAw@mail.gmail.com>
Subject: Re: [PATCH] tee: shm: reject zero-sized allocations in tee_dyn_shm_alloc_helper()
To: Georgiy Osokin <g.osokin@auroraos.dev>, Jens Wiklander <jenswi@kernel.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1MCBTYWx0ZWRfX5XPbnsYLfSYd
 q0E4RQVB7niRTd3bg6nKwG4gOJx3Z4VCc2dg0F2YVpK6aYRRW3vNrWZCxXg7k2Ve7rpQX25VY96
 0mvb+hAsRlM/ThNY47GhS4zIHJt3sDY=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abfa687 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=HH5vDtPzAAAA:8 a=EUspDBNiAAAA:8
 a=k6Az_GHFfqOohqVTO2QA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-ORIG-GUID: lVxpq8YToW5vDlvECM3zsgFDIlUBq5yE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1MCBTYWx0ZWRfX4IKIArIqRwGI
 8jhJrLX4KT4LFtdmUHhf7cq48mJH6PlyJu7oKPUlQqXV7aj6gpqVxW/2x7REZMyXUxLT3AhKKbA
 EapqQIckb3MDls/RZ7pMno9aM/jb2Nk5KGDTZTb3n7ykUb+52OoDO6oYC1azyI9HL6rxcjQwFJx
 vJZR4Q0oPybIBhTkNFMN5dINddrJwakKRRfOrik4zc7usYyp2NDjQOyBYhFncbiZsLt8jU/T6id
 ZJwlTg177fUEWnD+aU0XpmAGpqnpBCJNRbsyV2lSZCSoeNCAycZvF5rxglSf1RKR2o67lLegHDo
 z4jmVjLjHhyf3+4TtVRxstqJysC89Ls9+gto/6J25AHxsyXOSlwZLn8BA4EJsQnF/hwobhVMFuI
 x0Egziscg1ZFW/gXUWEDGR04UW5/9fxSdzEXrPUPF/Po6aLYIWXN0yToIpT0clz7ISERbdkbCMf
 6kXVME7itbO1iapkwXA==
X-Proofpoint-GUID: lVxpq8YToW5vDlvECM3zsgFDIlUBq5yE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020050

Hi,

On Thu, Oct 1, 2026 at 3:01=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Mon, 28 Sep 2026 at 17:31:13 +0300, Georgiy Osokin wrote:
> >tee_dyn_shm_alloc_helper() derives nr_pages from a caller-supplied size
> >and passes it to alloc_pages_exact() without checking it. For size =3D=
=3D 0
> >nr_pages is 0, and alloc_pages_exact(0) calls get_order(0), which is
> >documented as undefined and returns BITS_PER_LONG - PAGE_SHIFT. The page
> >allocator then trips its order > MAX_PAGE_ORDER warning and fails the
> >allocation; on a panic_on_warn kernel that ends the boot.
> >
> >This can be triggered by TEE_IOC_SHM_ALLOC with struct
> >tee_ioctl_shm_alloc_data where size is 0.
> >
> >Reject a zero page count, as register_shm_helper() already does for the
> >register path.
> >
> >Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
> >Cc: stable@vger.kernel.org
> >Cc: lvc-project@linuxtesting.org
> >Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> >---
> > drivers/tee/tee_shm.c | 4 ++++
> > 1 file changed, 4 insertions(+)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good, I'm picking this up.

Thanks,
Jens
