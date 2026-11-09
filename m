Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243341;
	b=oZ1+2BuNHjVxKWAsdgLludO/IRh9jkSNCdQNBGhnGuH0hEfScmy2BgEZeHULv0mqCq4P
	 bl13fpqpgcWm6/2MuY5HTVdNwZNQxdvynUQguS1pr5OVHot2xiH4qKKAcRZ9pgOJACGth
	 LvkEH/vyLeJMw8H4QaAFJuyBgYl61CfERWXE5LSoYibxs7VI9fShuIZvzdQoZ4w8SK1Al
	 yvORcenF7MzjxnMWrj3elzTJHwLpcPg4roJ5xeTboRVtyOJhU+q2Fg2NZ8EyS5HjonzWV
	 KQs4eipalmbaFzkkGElUWFCQ+BpEcoowsaHPdIQIaL1zfBNvUgW2E028oV1VgHaRpHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243341;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bjV9zPSqZzSjy7az1JAePwYJ6AKs5SGK11NxPTFGx44=;
	b=FyBs+23zvkuOd40PUEHHn0efjjD90Q+7tpF/1/GJoaJwvduKkFyqXH49hG/F/TCjsPJ/
	 sTRt6zcpW0sWpSD9JKkI3xqXACK6C5KKth3SaxMQ5wJvAwPH69CcFWTOjsWynYESa2Nik
	 5Fb3kjOtxfUt0CXPyIuCtd9hU5ksd/C0kNY4IPSoZKQk3m/Rq4dDyyG6el5aBzFmRQiCo
	 nPIf4x3oGTzah31BNltS6gGOY8yrV81KhFfZQKeSR6l5Y/fby/qRgdHhCmm561OlTyl/v
	 +xOR8kSbF7oFzMzF2SWAOb9LrXHKtaWMEceBlwUv3d9RisErJMghHfm8GzF1Anz3fUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T2k2haY3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c9MIWa9T;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6CC60A2628
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF6CC60A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T2k2haY3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c9MIWa9T
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9EPgB81141674
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 16:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bjV9zPSqZzSjy7az1JAePwYJ6AKs5SGK11NxPTFGx44=; b=T2k2haY3g2VkEIHP
	rxOCj1QXlc7k5c2V3lG6aArRReThBv1wOBb5c7QtL9w+7CTrXzAWe/kdGVWuh+RJ
	JFfXZmEsl/6s9ZnkQ0CbUBxAcdfr6L+9NJKYZnarPJkSUZ1biPjSe41he3KO9b6v
	pIjHH4gIc21NyqPk3ySmyo4T97lVjPhUrdzUdnqP/xCjSxwbnVc7BEFKwV2LaGfu
	FBjfd4kKNhA9fBrDB7dcZuXHPUPjNmGK/l+rW8WfP+yGTh9sps5CTgYXjwtlFbm4
	dI+1mojUKjovCrCnWelwAKWko00uVWuZnb4cKid9d6hdiHmvb0/bZT5ITKtXGeNu
	T/rYDw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx80jps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 16:55:39 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1a2b6fab7a6so972301c88.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794243339; x=1794848139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bjV9zPSqZzSjy7az1JAePwYJ6AKs5SGK11NxPTFGx44=;
        b=c9MIWa9TbaqaTZLBMC5VrjGXdrGKgNi6R+6f8Bp5hxdVL7h8pwC8aaeeZRDEv3iAgE
         cEbXuRimNj+FGgv/e6KzN8g+yWlKa2Lo+5tz1bB+7wIcLCta+FvYZl6A9/QZf5wvmXXH
         J586HyDW/l9mJGYzYsOsp+bcUuzLhu41ak0DAJeRilQf6E9BvyZ4BFobU8Fr7Ivqv22F
         in1XvNIrgOXSrWC+WBRKUC+WUuxUtFiQK8Inl8oxD64Q1Wnn0iTPgXlffjkeW2B/mX2E
         XVaZqg2AI7vMFiZp28gBWn92lzyxzFO/HOjvttR0JJgYvZDzV5Dyt5GVdZedm3HsPJRW
         RhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243339; x=1794848139;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bjV9zPSqZzSjy7az1JAePwYJ6AKs5SGK11NxPTFGx44=;
        b=CZ+w+99IMFGXJHekfDQwZqXZWTUVi7XMPdPZec6bOZUKVF56UhxWmXmCYH/VqEcu4u
         20YU8zUvMJwcjCcam090s0OtXaQEWlyjPKvvtpwQcp2caet3niGS1hQWI/vuh3aj3WN4
         3yGEhWENvVcQlKn0uxc15q0GLQaBVv/oWUTt0YfwaYamY54a39OSgpqAcHFiQSJOm6e0
         6IqHLVN4tsFUpQDh4haWJRRI5w8o+61rnHaoPRkujEUdosyGOHF4XEZ4IUYjC0G0OIah
         Na+BBBlXB6832cVoPV9ZKLmySaMwnLEf/Zkhoe7AQ8nKQQMsF2ynlSQtKs1z4IxF6BKs
         G+ug==
X-Forwarded-Encrypted: i=1; AL+hErFe9U2mNt+H7mS4FaeZ7eT7liBvhdtJviC83bDcIP1pnhAy+0LwyP4XGkm0loKgh8yJPGFAtMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z815ur5iRfqUrY6q9J+rjsg8m0DzNe+gnDmZpVkFhdsc8w1oVmJ
	t+JDkOhw8mi2lwP+Pg56J9wH/ZmrWzRIgBBRnVwVheepz0dXktTUYyPemt4ZHdazoNyM8BTJM9H
	uu16f34C0CCXYM5JtG6GvhjL/+Xg4SoPx/vG4r7FVLVt6tCgoqUmTC7Fosk0=
X-Gm-Gg: AYBFou1WCpwqO9/E//qODe/oMBLpoZsvUBPfP6sSTuG33doBjnbajukmhssLvA/pZ9C
	9brDGWup42otKUiW9WiPKWdrIDB9C7eSoaGGV6GkQ2qadviNlN11bZVqinxExrxZnl5C2AY/9xi
	eJI9W62n9BGNPdOW5v3xEiXiPRLL9viP9+QRyejsJo0//xm/4tL6QU0E+3tsHVcBjEYl03rug4/
	FKEcl6Nbl9s3oWkGR003jbdq3Fs2eup6hMSDtZYEwBo9SU4dUdouzMvMFZEneY1JtI95ogRtLZ1
	CcUup+i12HB7q4bPmX+AK14UZqSJWqINFUaB9Y2Vtpkyqfd4IIIwmOt5WVOhCTveilEnAzzVmiy
	kIoUJ0vQvxUSNejIrCEMndSkzmtmZZFMSRb7J6tA7j7lXT+k0pjngeBfOWeCzF8Xh7VK523k5Ng
	Jt105JYLYkrl+gFP2XsRJFa0sW1A==
X-Received: by 2002:a05:701b:4211:10b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b3b5e25ca2mr80084c88.10.1794243338452;
        Mon, 09 Nov 2026 08:55:38 -0800 (PST)
X-Received: by 2002:a05:701b:4211:10b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b3b5e25ca2mr80060c88.10.1794243337940;
        Mon, 09 Nov 2026 08:55:37 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890584sm323466c88.3.2026.11.09.08.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:55:37 -0800 (PST)
Date: Mon, 9 Nov 2026 08:55:23 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        David
 Lechner <dlechner@baylibre.com>,
        Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi
 <lorenzo.bianconi83@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: st_uvis25: notify the current trigger when
 done
Message-ID: <20261109085523.0000513e@oss.qualcomm.com>
In-Reply-To: <avGKjh7GOtE2tPGt@lore-desk>
References: <20261109025454.1260519-1-jic23@kernel.org>
	<avGKjh7GOtE2tPGt@lore-desk>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af1fb0b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bMo6kmeCR_tHdpvFHWUA:9 a=CjuIK1q_8ugA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: IbSO3HIMVrZfpIYPqyQs2aeJjXgvsBQ8
X-Proofpoint-ORIG-GUID: IbSO3HIMVrZfpIYPqyQs2aeJjXgvsBQ8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfX0WmU2ycafJ6s
 rLFNN7iIoCAe88gTH3jOb9MIQB0Uy9l8ivzX079s4/cGbFJYbmCbLsgfA8KEftveXIJzV8kldYk
 NRjCjGO7fyL+BLJbD5U29sqcOhBXd+g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfX5nZpFbjB9pB6
 khJ1Trgi+tThpVBrPa5cHT4zSom2Xy+luR/GpbqjiyKet0QUY9+e9CpZdAZuglYIKG29r+MTYJ/
 eQwqDGstF9+ogtcIFv/5a+S4stId5LnYIhFpcNYICwS/pj9t4fQ591GeLsq9DBimNxJ/HMOY9w3
 yeJ5lNB/mQpWD1hy7hCsgMPuwoY1/1rRAo1XeXcpIeOzINUV1VtL8gj37ITwyb9rcM+1h3QGC8s
 LT0KrnuyZ4y7gf9eRK1EXgO9zpb/fKfyV3+uh/BRJthZkByTqr1FXXHyFIs44JN4JTTWsdeUaUR
 VbEF+3PrrNMqh/lVDAWRVus48w3lO4rB6dgHs+2NnEWZsOHtu+bam4wJeaPM5SHqarMIBqu6m7L
 gIAgV4ug7BVs3xbIOMNEeBIQjY7kT2kGArv9LqSYHScOcBZmK7AimZHeadqJZlu9EchRsQuQwhe
 +p13fgLwcQxBO3fa0Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090067

On Mon, 9 Nov 2026 09:55:42 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> > The trigger handler calls iio_trigger_notify_done() on the driver's own
> > trigger rather than on the trigger that is currently in use by the
> > device. The driver does not restrict which trigger may be used, so if
> > another trigger, for example an hrtimer trigger, is selected then that
> > trigger's use_count is never decremented and it stops firing after the
> > first sample. The driver's own trigger use_count also underflows,
> > preventing it from firing later.
> > 
> > Use iio_dev->trig instead.
> > 
> > Fixes: 3025c8688c1e ("iio: light: add support for UVIS25 sensor")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>  
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Given content is all still here, rather than resend immediately to fix
the linux-iio mailing list address, I've just fixed it in this reply.

Thanks Lorenzo.

> 
> > ---
> > Another LLM found one as part of refactoring how all the code around
> > triggers works.  Definitely the wrong trigger. There are lots
> > that access the right trigger via the wrong path (shortly to be
> > cleaned up), this one manages to get the wrong one in many cases!
> > ---
> >  drivers/iio/light/st_uvis25_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
> > index 94d5261b2663..5c63a68948d6 100644
> > --- a/drivers/iio/light/st_uvis25_core.c
> > +++ b/drivers/iio/light/st_uvis25_core.c
> > @@ -248,7 +248,7 @@ static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
> >  				    iio_get_time_ns(iio_dev));
> >  
> >  out:
> > -	iio_trigger_notify_done(hw->trig);
> > +	iio_trigger_notify_done(iio_dev->trig);
> >  
> >  	return IRQ_HANDLED;
> >  }
> > -- 
> > 2.56.0
> >   
> 

