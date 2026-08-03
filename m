Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD5E1A683E
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780989; cv=none; b=sFnU+L1SZCEnj3O+sqr6cEkZGUv9J2R+EZ3IShqDtTrkF6kMYSPhGatmAhqggDV5YICuQibivaqjn1oQS6m9FNO78G4HR8GGw8ycjJD2brzwjvgjmAAyMgfa1MVbQIC3gOBSuxNYsmMfO0PaYGCPqLhxh8rA+gdWiEvnfXeXLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780989; c=relaxed/simple;
	bh=8HQlO9YzhcFgvta1xXwAV8nakDnf5AMM+s22JWnU3N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr5UtUIp+8SAi6Y6idFeSMSZ0XNCO+ea8UPBCJTbnZIPX7KAAsfqlRCev3SnoSwVHKwIcO0dHubb99p+qUChHVOMiAMiLdcD4bzO6MMIonv17tdSjo3KovHPL6ZC/pVaU83+/9l888AS8jfx3al2lQfG8DB5h7BA5ko+IoqFSHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hjlfki2K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ft4EKQZG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hjlfki2K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ft4EKQZG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673HB9Me1237814
	for <stable@vger.kernel.org>; Mon, 3 Aug 2026 18:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pjfF0tOHWHksszHWht8vyp9q2WC22S1DzS+dYPoTW8I=; b=Hjlfki2Kkz/TubAe
	ArpvGLDcxJcy7qWKX9PDZYJD7UG6h2eMiX0//gwxDi5Mt/4ISTH+UZv7MqM4LYtH
	oTkvOwYT438jBwgi6bt0QHDhcetnpOiKccEN9c53GdyNOdE/JNi9NhlBvw4W///x
	uuyvuYgiG65oaMxak8jOrELFooLLoWNCCKDGV3pNcJ4QIK43knWQ+nLzy+NuUjKv
	6Xz48a+AbMLZ3uFv3MHlif8pG+jgB8L6x5cBzG7W9xVZ4z4H8YwsymjeYLtlkwr3
	KHecLsneKyoLaedWKG65QPB1FR/aqKJDAZETsSp039HMt/AT6k9ah0qPn8KvVCX4
	ITj8yg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty5s88x4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 03 Aug 2026 18:16:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so4193136a91.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785780983; x=1786385783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjfF0tOHWHksszHWht8vyp9q2WC22S1DzS+dYPoTW8I=;
        b=ft4EKQZGrxUWqXXDJXvr7KXlRRpc/aOGTWY8wM+bpuB008c9qgk6flkNSh5vYQnn2f
         xa8TlgUG9NNbOYhFGuxk2R1MParVLSjv/ngxUDXlahMr4vSbCLH7De7eqINpxSHPPWDd
         gJ23MC7SWI7fDyUm97oxSiytlDAH6SKLpnroBgdF69OC7kPryxhzuxk1rUnXmz3CQ/oA
         SdlCjafhdUjIa315bLjeeIVsIkCekO6k19wo/BZ9URGdpodTnj4sPd6CiPQX/3ZOGEXV
         v61lj0If92X/lJG5uzK2Qz4r65ws48SqfS07qgbjF/kPOXNEiUnTxx2yFv2AdG0GhFWR
         FPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785780983; x=1786385783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pjfF0tOHWHksszHWht8vyp9q2WC22S1DzS+dYPoTW8I=;
        b=r5OYHIGGCE9T/akxaHlBDs64PPwTCznsjTIm+FxvPtKTy3l9vIOKt+EzuJQ+m4+Tfi
         j3B1C9h31vSTtT8G2Qrhxgl0CdR0CBfTc5J+eIGZyb6fqnU06sdaWEQpZqz7OgBtwa4c
         SOvkRMm373WHOn6LXodE/27YYeHi5s9Xn+4p5pElsHR3xOiC5FbhLhEFUAO1n85HkA+U
         dG3DOLS3msHO77WbpnDh5oZ+CmBNk10z90Te7yD95IYYyP1sW4Bh9IgsKOEz5S4d9k3q
         eKicUq+pFsimBALrdfbYA+X9pl8mmPQNSKaHrxl9ZfhNxiBhjop/tSs7TPxii7vRQ7na
         2r0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrbZhpCdTTuOYD5JQ2qJZtJaQGdrIYbvVOvJrX6UlDoEsy4L7gdDJt/ACLmUU4pMBohoIMPRZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzyG8S3Nb7yk9xbAKgthKFMUln7UdxI8oGrb7zK8rJtLyH2FVL
	vLC0+oe51BGK9v3OKOUSz5QJIoJowkHrke+jZ5ym/0YwOFAoCTvAj2aaCxW+Ru+jIDgoJWRa6VY
	lv0cMvLilPSkkqrdH4COXh6T2pGkgNARwoZO3rMQDA5Rc/fe7RezhVAbyG04=
X-Gm-Gg: AR+sD12bb/T9m1d1d2FFWW20lN9op00zYls/XkPp5wByG/iOU6L8lykN39zC6MVf2HW
	CMFowluJdSj6NbGXbnKEIXSXmuTbkW/nwjN4Ja3L7EW9DrN6+Ljy4UAJNgDczN6G27ktEaCwcFJ
	+VUTvLoIDK/Munu0LxireLRFvG6ej1zCJb/sBr1uJgC9kuiMiAg3YjNVXsdAv1KGYH36IlNj8ee
	nDSz3Z1/mcUwQKu/gbCUjOloftRBurMewpUgs1QXCMO+fdcUUZyc74ZLZpfKvyZZO942YDjnfAl
	MMkd7NZpiEKzMOmk4aCetfcRRWdc0OMJzYaQ14s5NS6eiLJAmEcLNpWzav2ftWT30El9YRSeP3x
	nfCbPlN6OSH0aJXbmPe4iNULNHq8=
X-Received: by 2002:a17:90b:4c41:b0:381:5a08:6291 with SMTP id 98e67ed59e1d1-38fbc4bc175mr9898694a91.20.1785780982717;
        Mon, 03 Aug 2026 11:16:22 -0700 (PDT)
X-Received: by 2002:a17:90b:4c41:b0:381:5a08:6291 with SMTP id 98e67ed59e1d1-38fbc4bc175mr9898652a91.20.1785780982073;
        Mon, 03 Aug 2026 11:16:22 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e107sm45374559eec.27.2026.08.03.11.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:16:21 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:46:14 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rajagopal Venkat <rajagopal.venkat@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] devfreq: stop monitor before calling governor GOV_STOP
Message-ID: <20260803181614.wk62kshvmbx6rpab@hu-mojha-hyd.qualcomm.com>
References: <20260721171141.1281754-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721171141.1281754-1-mukesh.ojha@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SPJykuvH c=1 sm=1 tr=0 ts=6a70daf7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0GuTR-5QzI1gVwP5EjkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: tFiLA-YY4iVfzdhFYtmzbAgRADty1AnE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE2MiBTYWx0ZWRfX5i3L+OYbyE1n
 8HyzEg5NDTf6vmE5eUHdqBTRJUHA55s4715hvSIZMJknqExCHRkvlsjLYn8HHwEo9GeNVDqhp1f
 9EOC7WdHIv2diPlEVZfZNvHva3Y6hxBKGU3BfV8YdtsAn4CTae7gfHT9IfBhlVnOfQQqL+IxKG0
 wrvkanNDdAkUM3QWhczBkkGkSKF3o1tlSjF/T4R/e6hR6rBpzkTLekfDZPiHdoYiUXb033GymVN
 v/nu3ZzA4Cu2iYL+ISq8Rv3ZvjYzdIHSbAvVFiCfEdIBJEwH7r81MmU6T/TM8SfcmKrlkf/xvvB
 eP2x+III9tfUnxd3gHTHySLurGHKe7EZklnxGFeUz7rHKJP6WHvdpKo5cv+CSjfqg01I66LLKUR
 QR5yjrr3L6GVGkeqQ0JWHe9lb9sfbsKTiVPC3+IHPWBZPCDsc96aP7HBQBxlIc+zzP3sl3EMS9o
 A6ODfVJ/y0QT+GC0ZLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE2MiBTYWx0ZWRfX2idQNi+3KINw
 HmUpbYomFZEONHdp+zMjVp/NDxzXcUOY+5lwRh7G5gG7MgcZ1Pe6B76jonPPTmUxKPT97RR589E
 WodRv3HjjGGRrOZCnK4nCE9f4vYX0Jo=
X-Proofpoint-GUID: tFiLA-YY4iVfzdhFYtmzbAgRADty1AnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030162

On Tue, Jul 21, 2026 at 10:41:41PM +0530, Mukesh Ojha wrote:
> The following NULL pointer dereference is observed when devfreq_monitor
> fires after userspace_exit() has freed governor_data:
> 
>   pc : devfreq_userspace_func+0x10/0x2c
>   Code: 39402109 --> ldrb w9, [x0, #8]   (x0 = NULL)
>   Call trace:
>    devfreq_userspace_func+0x10/0x2c
>    devfreq_monitor+0x34/0x134
>    process_scheduled_works+0x1d8/0x804
>    worker_thread+0x1c0/0x458
> 
> The fault address 0x8 is userspace_data.valid — an 8-byte unsigned long
> (user_frequency) precedes it, so governor_data == NULL is the cause.
> 
> The race: devfreq_resume_device() reads df->governor without holding
> devfreq_list_lock, while governor_store() updates it under that lock.
> The stale pointer dispatches GOV_RESUME to the old governor
> (simple_ondemand) after the switch has already completed:
> 
>   CPU 0 (devfreq_resume_device)        CPU 1 (governor_store)
> 
>   read df->governor → simple_ondemand
>                                        lock(devfreq_list_lock)
>                                        GOV_STOP → monitor stopped
>                                        df->governor = userspace
>                                        GOV_START → governor_data alloc'd
>                                        unlock(devfreq_list_lock)
>   simple_ondemand->event_handler
>     (DEVFREQ_GOV_RESUME)
>     → devfreq_monitor_resume()
>         stop_polling == true → re-queue work  ← stray monitor!
>         stop_polling = false
> 
> devfreq_monitor is now queued with df->governor == userspace. When
> devfreq_remove_device() or governor_store() next calls userspace GOV_STOP,
> userspace_exit() frees governor_data. The stray monitor fires,
> dereferences NULL governor_data, and crashes.
> 
> Call devfreq_monitor_stop() before every GOV_STOP dispatch in the core,
> ensuring the polling work is fully cancelled before any governor tears down
> its private data.  devfreq_monitor_stop() is safe unconditionally:
> IRQ_DRIVEN governors return immediately, polling governors that already
> call it in their own GOV_STOP handler make the second call a no-op
> (stop_polling already true), and governors that never polled get a harmless
> cancel_delayed_work_sync() on an empty queue.
> 
> Four sites are fixed: devfreq_remove_device(), governor_store(),
> devfreq_remove_governor() (governor module unload), and timer_store()
> (timer-type change performs a GOV_STOP + GOV_START cycle).
> 
> Fixes: 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices which can idle")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Can we consider reviewing fix for the mentioned issue ?

> ---
>  drivers/devfreq/devfreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index f08fc6966eae..7538f20657b7 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -993,9 +993,12 @@ int devfreq_remove_device(struct devfreq *devfreq)
>  
>  	devfreq_cooling_unregister(devfreq->cdev);
>  
> -	if (devfreq->governor)
> +	if (devfreq->governor) {
> +		devfreq_monitor_stop(devfreq);
>  		devfreq->governor->event_handler(devfreq,
>  						 DEVFREQ_GOV_STOP, NULL);
> +	}
> +
>  	device_unregister(&devfreq->dev);
>  
>  	return 0;
> @@ -1344,6 +1347,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
>  
>  		if (!strncmp(devfreq->governor->name, governor->name,
>  			     DEVFREQ_NAME_LEN)) {
> +			devfreq_monitor_stop(devfreq);
>  			ret = devfreq->governor->event_handler(devfreq,
>  						DEVFREQ_GOV_STOP, NULL);
>  			if (ret) {
> @@ -1416,6 +1420,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	 * Stop the current governor and remove the specific sysfs files
>  	 * which depend on current governor.
>  	 */
> +	devfreq_monitor_stop(df);
>  	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
>  	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
> @@ -1863,6 +1868,7 @@ static ssize_t timer_store(struct device *dev, struct device_attribute *attr,
>  	df->profile->timer = timer;
>  	mutex_unlock(&df->lock);
>  
> +	devfreq_monitor_stop(df);
>  	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
>  	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
> -- 
> 2.53.0
> 

-- 
-Mukesh Ojha
