Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7637B023
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037808; cv=none; b=UBzVdQVRa4GvgyKFsMP71PjeGQgwYx50xeNO8Q5TLObMQRiwXwPCX6IRcGr395iQs3lsxpzwAaus+yK1v6deRsyEONiWPHqquGiN/kYyS2Jlvlbwm8UlnRL9zW/zVXeAkSpDpLWCKPbBEBo8kzi6v0CdICVxoZGDpL4/FGPruyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037808; c=relaxed/simple;
	bh=Qml224tHKA8pz6kM6bxIVffaV1GkYgFiaokw4YNBcMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/rKVp9zA2yjLw+9mSt2if2A4QrjjrCvign5T14hX4tV1GmSkFtA+ajZjD12HnZMaeL5+3a013dmoDTeKWCZyS7PyTZeSp7Px0T/srn/Bz2PNB+/XdyJivOmCAuuD4q43mSfCKhpbN95ZpvX27uUBFqP3k59LbxUcgtaus2c7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DNf2B88j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=axtm2+lO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DNf2B88j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="axtm2+lO"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I7E7La3861021
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qml224tHKA8pz6kM6bxIVffaV1GkYgFiaokw4YNBcMA=; b=DNf2B88jZaakr7VU
	jYZn2hisSZSEExDZXc9G2lZX+A8xGtPgjALNSIU0avy7MWMBGnilYd9f9PWjgf3c
	Nmsj9D4sktc5BJDEeZjsZXe0Jlp/b5sBHY4ZD3HKGLs+zfJDrd7DJNQ0REu4jtBV
	q5RaHVxAmiK0FFKntHbBvYtGBoiEjjK29oDoHmWlzPlePYCzhI5XHysuS1ow2Nab
	FcYtTWDJHkKBcdUY/7g8SgVxwi7GgJP5TmYtawyEy5fM/Qi7exn4j3reIR8vEaDz
	EedVt60t7G5FyUceZ1WUU26s+3BjF5UiQpeTFs8X5IrJsUyp28i96QY1k/QwJlR6
	r4JC1w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4f5ps0sa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 07:23:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so8032508a91.2
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787037806; x=1787642606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qml224tHKA8pz6kM6bxIVffaV1GkYgFiaokw4YNBcMA=;
        b=axtm2+lO4kRkVzclyJeMz6w+JS17G52V01YeDrgqWA0KRZU4oFeCW+P3jVdtARQpOW
         hpeZmRDskWFVJgAavATZHkZNw4DF0Ulj/vD9lCSc9X0YhDp0C+5r3qR+S31aCrkkmVuJ
         CuoFCk74DpuvtumkcG+O1ZCpbV0FkOCgrAUrzu1H+WfhPmFi23dVKrzD+vYk9UvKVlD3
         g02wO1197kvIERuHMlE5oztlCzF4zdQqY8nTUzYj4rvTGiR8bZ900EyTBFICFxOCmNu7
         6YLJ9cNsuFgnR2AolXCUQ/VOeYutXB1Bbbbuv2HJZ5vc4h17fwvi2fKxnXFepgvGG3Oh
         A1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787037806; x=1787642606;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qml224tHKA8pz6kM6bxIVffaV1GkYgFiaokw4YNBcMA=;
        b=XmutfC/QntEBV3vV13UelwwFld9fUgh2LloZtyh13ohXeahZV0on7+KYoMHQKwIv2q
         uxKCR1CdAyPRribxub59p6zoVcIbK3ji0oD9IOrlIsuQz0ZcAx5qEieaUmLIRx2A2Mwo
         PWg8T22J88LEsR056xGoJfnZcVIEp0AA/Pthj+sG2hayXFTGMFtG/7YjbiOd47XRtsA+
         lR4QwH1AZGJwWi7iC8w8bRBUmAfbXtVE/yJLBIbkkRuZGsWrQosnfBY9saZEu9uYINTq
         SjZZspZYZ2AbiLRObJTZRw6rAr5iHTcNsskqFRQSEmx/vy0U8LYTXlYDrh8Mf6ueLlYY
         cPyg==
X-Forwarded-Encrypted: i=1; AHgh+RoB9qC1Ek0n8rrObvnksjKUQ5dCSNdVZl8qjTtl383SU8BV4TFF0GQIAsRTPPCXcj417HN7nyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxpLKSYfbu9u8FnToSfkp/xSxh7enUR8In/C9ncqQlkiHNya6
	+WylSWyOpBfwAJfGaM7mGG6/KPkVghcGx6dpvlmsL3l3uPWISkMORnfMVSITILe2NWGnA07bQwM
	yXSH7RQYBI/zXjKDi8Zgm57AikU6Z+kuobLiqfdD+a7NAd3dAmmuv/r2OJIc=
X-Gm-Gg: AR+sD11aLvQGPXMwZ/jS/UgI98uxCU59qyE4/PJ9Fq1XKSWGKGURV4wdJt0nUch4gP+
	m2JuAdpiJm46Iy+pDrQNQ0WZB54axjGcfAJTL2qe1qQK40Oszag+cuu0jlEN0GBJ2FVeOXrL5Op
	5dFBvtDzbrbFtzUACQpwMBPH8bi3oPGa8ON883w0Fwt206+aUfaMPpY6ZoTBQLpSrj8gBWFlxWz
	rWGvyPYOE68UPe5a06hNjAchC6rgF6StFae8rNO2LrbKwRzgiZ0+j4IuUPDhFoQlwuTlQ95r1lp
	F/F/joopMYs725Y0zunDZ9w0G3oDtZyTifoiKZuFzCB7rri9xLpPlAlCI2/MOo13Bq9y297fGGz
	H69LZPa0GhkYW/ZOOu2fHhTI=
X-Received: by 2002:a17:90b:524b:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-3933cb3f7d3mr34521488a91.8.1787037805987;
        Tue, 18 Aug 2026 00:23:25 -0700 (PDT)
X-Received: by 2002:a17:90b:524b:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-3933cb3f7d3mr34521438a91.8.1787037805386;
        Tue, 18 Aug 2026 00:23:25 -0700 (PDT)
Received: from [10.239.97.207] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339d00eafsm6844315a91.1.2026.08.18.00.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 00:23:25 -0700 (PDT)
Message-ID: <53126b4a-09a9-443b-bfb5-e7285494aa7a@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 15:23:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org, liulzhao@qti.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, cxin@qti.qualcomm.com
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <20260818070324.136726-1-xin.chen2@oss.qualcomm.com>
 <2e072c67-9d42-409a-8c24-82e88dd01418@kernel.org>
From: Xin Chen <xin.chen2@oss.qualcomm.com>
In-Reply-To: <2e072c67-9d42-409a-8c24-82e88dd01418@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S+/pBosP c=1 sm=1 tr=0 ts=6a84086e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=tjhzb4fLYD-Z8NmU190A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: qGS-KSnyBmgxs6NFDZ2rtC33LmWxhb2G
X-Proofpoint-ORIG-GUID: qGS-KSnyBmgxs6NFDZ2rtC33LmWxhb2G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1MiBTYWx0ZWRfX40ikK/xkP1zD
 mDxXmDUxlZSmfskSQ15wkLVIlDvSA6cIlfGKLImofifSJSnAK6ns3XbNJ+sEAwcGoHKMalp/7NM
 s8tJdlrgNtsbgx9QLNNh4iS9cBaZQ1Pz5Rtv3IoV7TRUydimhLdSeHXCGy/qn9zrqV9oFhxrbQ3
 4r33hcC5YoXkLYgMEXQZql0LAgYO7ti8AOIe0HpjbNFSwXS4bNNLBXwT3EtSMs0b7bV5o8xhila
 C4dsts2O+1OvTiZYOW4blqnwllhQbVeNTQ9Lisz6UmvnZyLCDClVCZemS+t8cv2fpoFCZhngxMf
 thD7FWc99/YGxbSG7fdOpCNldMZICOiMCobi+SeUgx4jBeNNQ4BvznSlXDSbAhEP8mfw9juHn03
 uZrrFu60h1g1tOzd99LJC3O+pUotWwlch1xRprb/C50hWIkuAMIexTKYnFkZwpRT3gk4x8lKrOj
 9QFjLQnOSM8ixrF09/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1MiBTYWx0ZWRfXy2uTq2/0zJEV
 ru2o7yM5mFFi8tsJ6CxYSqCb9y7m65T1QnKF2pBUl01SwtXtJDecQHt3eO6GDNU5ojG0Hv+Nhe/
 nTTN8r3/LrCZ4s/uEThgj6IvKHTKjeU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180052

On Tue, Aug 18, 2026, Jiri Slaby wrote:
 > Switching from order-0 to order-2? If you ran out of vmspace on some
 > 32bit platform, perhaps. But you apparently did not. So all this
 > feels odd.

To clarify: the concern is not vmalloc address space exhaustion.
The issue is that vzalloc() allocates order-0 pages from the buddy
allocator via the bulk allocation path (alloc_pages_bulk_noprof),
which uses ALLOC_WMARK_LOW and does not perform direct reclaim.
When two back-to-back vzalloc() calls drain enough order-0 pages
to push the zone below the low watermark, a subsequent
skb_clone(GFP_KERNEL) in hci_send_cmd_sync() fails silently,
leaving hdev->req_skb NULL and causing BT enable to time out with
-ETIMEDOUT.

kvzalloc_obj() serves the ~10 KB n_tty_data from the kmalloc-16384
slab, which is backed by order-2 compound pages — a separate pool
that does not deplete the order-0 free list that skb_clone() depends
on.  The commit message could have been clearer on this point; I will
improve it in the next version.

Thanks,
Xin Chen
