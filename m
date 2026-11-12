Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794470669;
	b=lCR3lHvvjtpmRceChAqEHpV3kEEUhPNf8Z+fK/iUgGoCrXi8Ci0b9M8iePu1ckuzDKVq
	 UtZAqQFTicXvROqierSaK+vLvpQuN6FeOO+RCvoiKMUWN5UxYe9YvcfSq+I+pz7gIMMYV
	 MEMXuka6mRMwXI0AY/OXpLVLkDYkDqNBMDrhfheA2x7m6C3fESCl4T+6esJUdlSnR1YUx
	 uaJQBTUqPvg74EMDFMBqbuMWY5XfspDkyBr8d3Z8SMAVfAqAK7ofm+fg+1rRdaF1Fs05a
	 qBE8PdLpipso6ADtgL7H8bJ6wFFNV1UVDIL3zLhU3g/T7QSTDNAW61+duDWsfFHP0zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470669;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FHdDkmm9qQ0sg08pi6fTx+CVVlQ6MmZ0qIxULw4ryr4=;
	b=sUPyx32l8xnqE1UeWB5DbbLPpfWHr0rFrI5wfesAJiadfTXm4mUKRdyPjMmUpZ+YzvY4
	 DCUCCbL2tddAMk4qiOcRiHfpY/yR+qltRsqByhUckABTG862/nXsxKQ3gaL9kgW1VEDiz
	 Xisi46eBASjALYcWAHCTqy+8+DbmqVNs/Q47UuXHwYacqUPpghDB4qf5IaopirhRhIG0k
	 5SuieFwDSXcBvXC/8oF5MrHeUEZF0H73ec/ubeRrMBOhRP2KV+9ILg1Q3skRivgM7/jsB
	 ObumcY4GM2y+ZndwCI5WSM8miU2gxrh3zuKt3QJ2ftD+RwofBQcvNzkd1qTl0VIaZ/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="dLgq8/0p";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CpqfoR36;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71310606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71310606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dLgq8/0p;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CpqfoR36
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC7j8PO126726
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FHdDkmm9qQ0sg08pi6fTx+CVVlQ6MmZ0qIxULw4ryr4=; b=dLgq8/0p1TeRQfqz
	aQablB4xWhDlJA86+7ncgunabxiAC77cnwbZBLuOhnjH6wjbpiENw5at63ktFsHM
	n8G0QoAh2QclxoWCxFTmML26ARntleTWTZnZsVSNyla/rQI/ABDZrmlVNjw2vapB
	tfg4HHUSvPLJPWp8aYGf6Duw798plsYL6b3Ca0s4BdrzvCkRHX0E9/45Z8AjGNMp
	NU+3iKJhurCWzNcGDoOjfS0IPCwhgG9mHYrXaM1kxfLXsvtK+ajV+Vrl3dSNeoF1
	RceIwJIZFLdKKhmGJf2T2jCSaDlsn1kHRd9ZvYqyI5GCpvBeiJ6/0HMgj/b63MCf
	yvZQUQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a082ng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:04:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93caf6c528aso78153985a.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:04:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794470668; cv=none;
        d=google.com; s=arc-20260327;
        b=FsMpLm4gK8KlWLB0ATEwXMQxBQZsqE+bpVwa0TXBqCOJ2dnxGti5q7nlwkJF0tvwPa
         fi2XggpdL+GKo/Xo0/BE8Oh1bAksgtKRujQXz5hlAIFXNzNZ7uy553yTtHXNMyLMCqzS
         5uWfxHoYccXlfmAq7w7vHIeHdbRedi3fo/NBlcIltK4DB8wrEuRGxpAYR6RJ2AX3KcwX
         2yJ05qxaFCWf5gHVKtyxYFD18VkIlWLi9BtWMFaOrqCLAfTGgRFi5xW58cf24dH2m89v
         Zt6zMLml4pPKYDAKHzM4TywcRadQDnfiQylL9HYNAvukapNKq18LPrjbYb+yEMAvEkc1
         ZlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FHdDkmm9qQ0sg08pi6fTx+CVVlQ6MmZ0qIxULw4ryr4=;
        fh=dvRz4NjV+tHLNUH54XnTNwKn0gt2+Avf8vzJK+NRdYU=;
        b=dE3hP8zH9w3UD/vAhU9/DbP0kyz5TTFfQQ9FK0AEV0Lilso2nAAIkyzH5+ARk26v8L
         YpOya7TsPLU03jFZARNReLSpeIVOGFn54NU78MKRg2CnZe6AW+M2UBxmxzfqhCW3vaBw
         awEIzqOr+2YU4UdHEKF6dnUi4XbGKpDTJz+tCJTbYrDUlmOLim1gp631wAtie5aPUZG2
         v/aRGDkJW+REMtE0Vwy1VOUjxqElSAWXn8FgsIRFaxRV12ZKW26zD5MeqfQQ5LdkYnHE
         cneoY3EpQMhBhi5P3ZQvJoSlSD15VwT1KPZw+TbzYga6sMyWopFh/nimQKmt0l0bl4Ux
         jhBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794470668; x=1795075468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FHdDkmm9qQ0sg08pi6fTx+CVVlQ6MmZ0qIxULw4ryr4=;
        b=CpqfoR36InocL+dXtURO79yYV/G7f4D2RIZY5IWRqNFKT+JMxXlLFvezQUf4RIYMi3
         d5YiR4MYons3bEDzwiUY/E6DqDyOZb21/TYBi870TVpoNVaMekvS5mCX4z9VHGd6V96V
         n8MkrFhCm1GpbgPmCR7L/2u1sZ+1pGNrAOj/AelKZydaA9tPPMcoJAfo4BKWaIqoMyMJ
         Xck5U0wKX0rJ6UJ9maOGp9RN8O5FAJCQZcr5SwTu0kmQSBupCeUwVwxTPNcTj/5fKTWD
         VfB0QC10JTZCHZSg3BGyJTju3dUPTVgo8a3/aJD6167PR68zuNMiLgRbYeYpNqNpLy8g
         G2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794470668; x=1795075468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHdDkmm9qQ0sg08pi6fTx+CVVlQ6MmZ0qIxULw4ryr4=;
        b=G2i3ySGbw/1BMvLPVgg2aMsyhulTDjqTspuKgM3U170p2Kz8v87OAE+f9k8XIqQLrd
         0g02yJtXQ4P3P0yvCPidrkTMt8Gv08y69W93RTCKSMgJ32tKX96jVgHJYy56EPhphwTO
         oyFGTvpdOIHO5wpSojFFUFajc2jQzCDvOru0rwZsWnVUOaLdLIUC8LvaS9nnHJi9yp26
         hMXhuU69DYU/cr+ACDoaB+yGb2AOF9Krz3cIN6ptlX7gEKrsv3VEcOZTX2pRiACwDOQQ
         M5ythoySFuhOvacrX+4MZKsZ9Y7h/p72U+XpAxkEYczzu5IsEXBEj88a7eYeZDbYYsjl
         Etyw==
X-Forwarded-Encrypted: i=1; AL+hErHs8ik1s8jRQN3kmfzdkiR7cJ7ySB403sY2eYIGUsmZw90NvfYdaJPS/BUkVZTGSGk5tljEejU=@vger.kernel.org
X-Gm-Message-State: APuU4Z96jle+Es2QVwlYSO66Kpyzy+wPB+ZkC+Rd3VenyWSjprJB9/Sk
	q4tgOz2wNxfc70AUSO/7yU6tP1/BfvfAZPNsAqnExotiggC9n5HT9hIiqMek2tZ6UbIp5wJ9XDx
	kF28rEXi4NrakXy0NW4iKvDKCbV5xtdIlYHs/Qt/IJy61sbI3xvOSiVYwTexKzMXtUwIpSB5hlH
	1IQZo63KoUGO0R2LwQr8zCXHF9JLqZTaTpjQ==
X-Gm-Gg: AYBFou0oWcDs0gpRcSUUab4V6IQAK1fKal8Bcfds6z82WNlqMDYP3vcp3lXmjpfYq4Z
	hZMiU96XoAdtBnIgx3nItr/gxCqqsn2rNTILjTMBh1YcyGf2RP+DTSDgawtvSKeOHPyYgiA1Dpq
	dEnrG/CDfY0AREzrEKLVbGrH7U9pjjwa3GgbPboXKArxq+dXyFvljEcnlmlboexoSB5FRz8/IWg
	Dl2RZySkijlSgcV64vVsqVQMCCQEmd6JuISPCy3LF/D8xiPcEidI6wU5jBvyVXtmykur7G0HK4=
X-Received: by 2002:a05:620a:44c9:b0:93e:63fd:40a4 with SMTP id af79cd13be357-947affc0f53mr794132785a.55.1794470667755;
        Thu, 12 Nov 2026 00:04:27 -0800 (PST)
X-Received: by 2002:a05:620a:44c9:b0:93e:63fd:40a4 with SMTP id
 af79cd13be357-947affc0f53mr794127085a.55.1794470667208; Thu, 12 Nov 2026
 00:04:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110043006.56681-1-mhun512@gmail.com> <20261111174106.09f639ca@kernel.org>
In-Reply-To: <20261111174106.09f639ca@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 09:04:15 +0100
X-Gm-Features: AclHuK9VZabyLQbVKXJVYfq63j7iP9JQyT0QdrkFRZjz2E-OQ6UaYfMCOc0aFYE
Message-ID: <CAFEp6-1mdXkaH0gskH6VaW_xRjSPPP3VyfGbNpE1M3kDAbeDaw@mail.gmail.com>
Subject: Re: [PATCH net] net: wwan: mhi_wwan_mbim: disable rx_refill work on removal
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: TRaICkTgd_QHX5Kzcr21b8cOhLCu10kB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMSBTYWx0ZWRfXy/6tmgWiqfrr
 k83OQWzJNZeBpw+klvqn+MhyyiojZytcrAePOyvtW1bx3fl8T6pWNnRh09xc15M/TNAZuv+rziY
 OEi7LrUAeDg2c+0UAktJKD/bydOXhrMRxZ8C4C3Fi7BPh9o2qPUHLH1WUgUqUJaaoPddfwFTpm+
 4Jcj7CXIrMz2QF56mXMCWUTcGVksONNPaOKMeOEEBBEBtoxxGQDLBiPlaYPUn5Gu+MSPSVZlzeY
 7KYKo9Kv4x2o7WiPiRGTB/WnPWeAs8V+JHTKWRkkZNPOKKYx07QGcSV6FcPeBFHukDnJzQGkQFu
 7kwyfmdTGlpAHpgAO9wwfzDljEETwEZbmLnWlQ4IwqGpv49kFxGNrj/J07s/DysU0aGDNRIH5U2
 J314UwVHg9ypp+f9hFI4Lhz493afyp1SvHlPpO0qkWX3ON2Asp6r00gDRxDf51Fk3jTk543YaPe
 3fdQYBktSRU9h9sJZ3g==
X-Proofpoint-ORIG-GUID: TRaICkTgd_QHX5Kzcr21b8cOhLCu10kB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMSBTYWx0ZWRfX3F2CBLitlu49
 2sYolh33MQw8d0beKqsfPl7ioX9GdNgqjOcK10pFLSBLbUjOqmZd26fJzlZ8urxRwqdSCW1w2Fr
 URyYpkQPYuVu1FCRTizpP6kdGDaHgTE=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af5730c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=9R54UkLUAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=r-nYRLqk3h2YVGBGkBAA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120031

On Thu, Nov 12, 2026 at 2:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  9 Nov 2026 23:30:06 -0500 Myeonghun Pak wrote:
> > mhi_mbim_remove() cancels rx_refill before wwan_unregister_ops()
> > removes the links. Bringing a link up in between calls mhi_mbim_ndo_ope=
n()
> > and queues the work again. With the MHI channels already reset, the
> > work cannot refill RX buffers and keeps re-arming itself, eventually
> > running after devres frees the context.
> >
> > Use disable_delayed_work_sync() to drain the work and reject later
> > queueing. Probe initializes fresh work on rebind.
> >
> > Found by a static analysis tool under development.
> >
> > Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
> > Cc: stable@vger.kernel.org # v6.10+
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> >
> > ---
> >
> > diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_ww=
an_mbim.c
> > index 336f89756f10..3b6b0066f673 100644
> > --- a/drivers/net/wwan/mhi_wwan_mbim.c
> > +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> > @@ -650,7 +650,7 @@ static void mhi_mbim_remove(struct mhi_device *mhi_=
dev)
> >       struct mhi_controller *cntrl =3D mhi_dev->mhi_cntrl;
> >
> >       mhi_unprepare_from_transfer(mhi_dev);
> > -     cancel_delayed_work_sync(&mbim->rx_refill);
> > +     disable_delayed_work_sync(&mbim->rx_refill);
> >       wwan_unregister_ops(&cntrl->mhi_dev->dev);
> >       kfree_skb(mbim->skbagg_head);
> >       dev_set_drvdata(&mhi_dev->dev, NULL);
>
> AI says this is not enough for make the teardown correct:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110043006.56681-=
1-mhun512@gmail.com

Indeed, thank you.

Myeonghun, could you move the disable_delayed_work_sync() call to the
appropriate location, as described in the link above?

Thanks,
Loic
