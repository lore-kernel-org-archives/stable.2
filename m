Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC21C5499
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253160; cv=none; b=roskGP0M9WvnQX224C939J0cx2rG5HZQ86cSj4KC2rh3TO5HFkt4GCYAgYJOvPxg4g/p1nxehkjoGNrKegiMpT1GwHCir0ES+6pRvRdXSxQ3XsN6uX4naXUXi2dFEuad8sNuemQWu/DizCw8c0l9UrySxKsSaF4zlhg/Lxn2BTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253160; c=relaxed/simple;
	bh=I+J3lijk9qNAEc8We+uj5POGMAxHJEguo+5161ZH51A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF4bzHko27ck89ztVXZkJqzTtq0pBgexQ64302ub1EFIpjAxbvjNOZErXyA9kd0rymH+jSe7fsl4p9MfEylLa7CfLcs308zUXd9jAe0d2oYbvECkDHJ3JrhtRo/occfl8JtzCXhcsCeS56NMWfm1YbzeGdspdP39Yfcjej9o9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PsSn/PK4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WJO3+L5j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PsSn/PK4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WJO3+L5j"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC4sBo1630757
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A0DzMsof/BPeClgNGuLflawDdZB+Su4EkTYJSKZSgpk=; b=PsSn/PK4jle23gbd
	MNEt0oNAfO8sIJY3D/Am/tdXEQazyDYk1SG2Np7kO3KqBXVvdZI0Y8TJCwbj7Cnt
	jBJ87XwM7+yTUsxu+0rMfD7Uz2VYaVYIHuAlImjb9v5BFH5xivKsk/vfhYjmAfIq
	y5sNexITJMd6QCTG49+uZH+fMXcWPEyOknvI6rF9XH3Tk3cZCDHvCOKi0jRyR5TU
	VaF0XpYj8FzMvbPONhPYwfc2rp8gotzGr4wVK6vMyB4hrZFzAF5k+BnGtu17kB5n
	Qb5sBIogxoBqD20Ez44D15qaWkG+0+nd3FJ+gEbD8worjdTYGelVmDwP6ULqKEfN
	J4fmSg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvr90b1y6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:32:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so3714849eec.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790253157; x=1790857957; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0DzMsof/BPeClgNGuLflawDdZB+Su4EkTYJSKZSgpk=;
        b=WJO3+L5jOkjjhMTgzH75NCGUatKs4hsEWJX9ByHlfw72tCj2A8chzCjw4V17RmJz3x
         rQuHl1UQVzFa7r9wredELhV2PLY0Ipw8fktd6dBhxvO1X0EGheV2M9+a3shuMsW4BRJS
         Dg1nZ5OzLWqZCgX6QoCYYRfVCwpoRKpxoq9nAC3ebUnkx98X73xJ6vxcRM96G6Cc68NY
         7oq3RAZiG0INWSWjJgT9tGPq/6+pDr6JYrr7GBiwO/HB+e2nhNBB+fW+XT+oAS0sIn4y
         staKteiB5pNKKVU7BDmGiY5GizIIn1SsPK1toYQHNRFoJYBkGu+jH2UiFeu7+l1AaOql
         RKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790253157; x=1790857957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A0DzMsof/BPeClgNGuLflawDdZB+Su4EkTYJSKZSgpk=;
        b=ZekQblFH2qyPK/IX+uB59mVP7sMj4GEtfxdyupOJZOFPQgEzaw6vraF5xaVWZ/QprU
         O6ZKNZVnGsL13x2UQpzd9ROb6/PT4AR3exguu6MtGts9aKE6VWlJxBf7cPxrwP5DsMzr
         GCqBZ+gpC9wkbIR+h+u9xLmYO8rLTFZ3cJ0YZuh2/jm8kGz/oJMgESbJmvgg24FhBQF/
         pIgojVBrjnyV3cBEsMfZ4gfJfeFD8f4Y99eznROtPHLAXTmfiGSMAAWQ0CTtxxYLeSJH
         77tMxLCI8EHFJuWCm+kSgGojk0xC4b1oPonM2QL84b/x2Q4gczKIpM9RxBlRs+7OsCZ+
         P04Q==
X-Forwarded-Encrypted: i=1; AKwUvBzi0uDh8dU4moqyHYRhm3/jqVRWzKUqjKPtZS8nQwrDFmShdTBnexeWTEclgpL1XszyfGrz4pw=@vger.kernel.org
X-Gm-Message-State: AFuF++lfgAH4Grx6dXjvDf68AwRenm8wLjvCrPr6twlodSS5AxUH/cGZ
	ARv1L97hPT7FXsa2var4qRJBD8sp5p3SwPxNuUQVbmFEP7XnIu4gDrk1Yufqqc0XgzpMv5Wp32g
	Ex82vKx4Zv9vcK1XUowfX7GZOFOHANgmX8IaITN32Vru9ZvZlsFF6ttsmsYE=
X-Gm-Gg: AYBFou2IdIEBQCSV9//nPhZcbfdZgO/4bsW7k60YpU3bJkmmDA9S3K15npYgJuFkhlh
	UQg6IaMsrnliBgOEh8xisJPHDdskOj9s8lOSgkvxA7TwUNHcFecr46mrsg3E2Vg80z3dRxhQg4H
	V+in3SrNuYhtzqAzaB9ctS3YJ3jkgc6BCkG1uR+iLVuSq2KGT5vYFKYxPo5XZoW0/+2UU9DDFMB
	2UZHh4sewJeGdYRKuFMtTl2SzitWk0ECUhZebwDr1ZL7CtOh2CWjMPEyFOMtJo51NWH3nMG3VVN
	/+PPlB7c6JT3uJjhW+B8MLK3XAPN9y9E3DqGhDjkS8eBX9ArRfP17nC469aPMJD+DQ/Tmo/Pb2b
	8SBCDCf2NQ3SEr+NLiSBAaKUGcg==
X-Received: by 2002:a05:7301:da87:b0:339:d06e:64ea with SMTP id 5a478bee46e88-33ffe343a49mr1710411eec.4.1790253157156;
        Thu, 24 Sep 2026 05:32:37 -0700 (PDT)
X-Received: by 2002:a05:7301:da87:b0:339:d06e:64ea with SMTP id 5a478bee46e88-33ffe343a49mr1710371eec.4.1790253156373;
        Thu, 24 Sep 2026 05:32:36 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7c63bsm13461908eec.10.2026.09.24.05.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:32:35 -0700 (PDT)
Date: Thu, 24 Sep 2026 18:02:29 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rajagopal Venkat <rajagopal.venkat@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] devfreq: stop monitor before calling governor GOV_STOP
Message-ID: <20260924123229.qkiyz5zo2owh5xtv@hu-mojha-hyd.qualcomm.com>
References: <20260721171141.1281754-1-mukesh.ojha@oss.qualcomm.com>
 <20260803181614.wk62kshvmbx6rpab@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803181614.wk62kshvmbx6rpab@hu-mojha-hyd.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1MSBTYWx0ZWRfX/5z8lClXFQi3
 hAJyr9a9bR4eW7iSy7B5nK9mJ9bRCnsc92fXVApin5vDZnHCvXWq+dg3H+4wlkWW96O2xKnkQoR
 kKX6sDrfTvqi7Ydy7pnEj6iykPGzR60=
X-Proofpoint-GUID: TRHt4VioA3WCnckRKHRYuQKZQxHOA1Yg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1MSBTYWx0ZWRfX9JpPR+Zwn13J
 hNZPxXxA6vxG9D17Zlh9QM84ST3gE2JMliWt9ij6PGQZWnzNggrTHzVn7ARdBeAxstCwq4QYl+/
 6C+JQ/DOx2+p5Q41rc5b/rkItvwEAuZERW7pT5DVLb8K/j7Zt3PDT+zmOe7zhZgkCoHGwuGLvU9
 tCGkqxz7RNrr+l29g/aj6qdqg6dOBA0Y88RSRPGZrByLaiVG/Ig8juDNTttAIFzmdEvsTzoWDwM
 L2d38oxx+peUxTFxftYijs1jX5RmGSvf2FrYZCFwVZaO6ejXtmtX/yNGJH0nql76UL3Yb69bfBK
 AOD0BTW9o13//uMviBjNt33pzNLT0AdeLGpCvNElQXpU0ua1triDDq52veoX1HPZF+XX9uT56Qj
 ZgadXke7iAY4gJ/V35B0QneHayu7sXWROULUNO5D/4S058t6yAOtdrCTdf1RdAi6gJWREa8zKWc
 PCdWdM2iqDDO2kX2nJw==
X-Proofpoint-ORIG-GUID: TRHt4VioA3WCnckRKHRYuQKZQxHOA1Yg
X-Authority-Analysis: v=2.4 cv=fMusTpae c=1 sm=1 tr=0 ts=6ab51866 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=x_Bf0CEzfFRy0vkMM70A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240051

On Mon, Aug 03, 2026 at 11:46:14PM +0530, Mukesh Ojha wrote:
> On Tue, Jul 21, 2026 at 10:41:41PM +0530, Mukesh Ojha wrote:
> > The following NULL pointer dereference is observed when devfreq_monitor
> > fires after userspace_exit() has freed governor_data:
> > 
> >   pc : devfreq_userspace_func+0x10/0x2c
> >   Code: 39402109 --> ldrb w9, [x0, #8]   (x0 = NULL)
> >   Call trace:
> >    devfreq_userspace_func+0x10/0x2c
> >    devfreq_monitor+0x34/0x134
> >    process_scheduled_works+0x1d8/0x804
> >    worker_thread+0x1c0/0x458
> > 
> > The fault address 0x8 is userspace_data.valid — an 8-byte unsigned long
> > (user_frequency) precedes it, so governor_data == NULL is the cause.
> > 
> > The race: devfreq_resume_device() reads df->governor without holding
> > devfreq_list_lock, while governor_store() updates it under that lock.
> > The stale pointer dispatches GOV_RESUME to the old governor
> > (simple_ondemand) after the switch has already completed:
> > 
> >   CPU 0 (devfreq_resume_device)        CPU 1 (governor_store)
> > 
> >   read df->governor → simple_ondemand
> >                                        lock(devfreq_list_lock)
> >                                        GOV_STOP → monitor stopped
> >                                        df->governor = userspace
> >                                        GOV_START → governor_data alloc'd
> >                                        unlock(devfreq_list_lock)
> >   simple_ondemand->event_handler
> >     (DEVFREQ_GOV_RESUME)
> >     → devfreq_monitor_resume()
> >         stop_polling == true → re-queue work  ← stray monitor!
> >         stop_polling = false
> > 
> > devfreq_monitor is now queued with df->governor == userspace. When
> > devfreq_remove_device() or governor_store() next calls userspace GOV_STOP,
> > userspace_exit() frees governor_data. The stray monitor fires,
> > dereferences NULL governor_data, and crashes.
> > 
> > Call devfreq_monitor_stop() before every GOV_STOP dispatch in the core,
> > ensuring the polling work is fully cancelled before any governor tears down
> > its private data.  devfreq_monitor_stop() is safe unconditionally:
> > IRQ_DRIVEN governors return immediately, polling governors that already
> > call it in their own GOV_STOP handler make the second call a no-op
> > (stop_polling already true), and governors that never polled get a harmless
> > cancel_delayed_work_sync() on an empty queue.
> > 
> > Four sites are fixed: devfreq_remove_device(), governor_store(),
> > devfreq_remove_governor() (governor module unload), and timer_store()
> > (timer-type change performs a GOV_STOP + GOV_START cycle).
> > 
> > Fixes: 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices which can idle")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> Can we consider reviewing fix for the mentioned issue ?

Change still applies on linux-next tip, So no need of a rebase.

Can I get review on this ?

-- 
-Mukesh Ojha
