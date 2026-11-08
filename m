Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123133;
	b=oTm8fawwe9e0rAIvKGhlCENFA92wUT6rxYgrv00snLbE4FTT4G74pXEQsNDEY+gB1LmK
	 38b0jyHWcGGqAIbGTBrdFj4N1QDySxpoOA/FAU8EHZj+bEkneqMTsdx2xCJ+4HFQy5ve+
	 MTDIFg9CW5ljU/a2ztuJcc3wV9HG/jNMpgK9EKZlSiPzcJ0NOMmgqPyPyK++bz7XlDs9V
	 guxBjUbt/IzWDW5wbUCMd4IUVm9uOhmycZ9OUuu9Gv2Olewfgad0by/LjHWJNuZU4mXAY
	 MuydYLImFT/BjZcCLvbE5u2nG/pXyAjXGxRJHdATNGFp/QIop6J8zvdcCH5LT5LxQ/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123133;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:
	 Content-Language:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gxiJBm5NHRze1wOQWiUuvxPhaR3l7aCkihnUvorIFDY=;
	b=QILp4XWD38NYdalweJZxGOnbfsi2vBAuKocAoEcFDJAFHM5OwOzI3R2lQjztKdBesccm
	 aNfJiZroBHiT0knxh6BrOj5IAzsPg9l2qRqG8R0+ADFmpBWG+p0P7Pd6QvcY/FpRas8Wo
	 rJUFyWYTPCL3KcCNkWQYZ28SfGbhsLjAgKf4kGzYOyGqdXbEsPzS1BVgo3bWsctFK5QwQ
	 Qm6fnhCZEegPnZkdirfhr/IrENSspnuvCVvEvjhphblrHgv/oKk0jWvwQhikGT2viSplX
	 OMcSjdgWLaNxOC5/Y7IS7ITk7mDKi1keOakjGHmbo5hgoIvvXLSjI1hGNk061XksOhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ifk4dFYD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CSRqLQly;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D5D606A321
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 07:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0D5D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ifk4dFYD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CSRqLQly
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A84K5uH4142744
	for <stable@vger.kernel.org>; Sun, 8 Nov 2026 07:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gxiJBm5NHRze1wOQWiUuvxPhaR3l7aCkihnUvorIFDY=; b=ifk4dFYDnT58wjpf
	MjXdboe71nqyIWFSqu9O76oUSUvdkmhwLM7mBv6O0dk4XSZcQukL20T4CwKNOAks
	CbYdZAarm+vggNFd6vzmSUkus+1IuWgH9O+U/pEXED/cDZuNEsKZ0UD53oIcqubR
	qsIvBSvwycrVXoCyOyqnG9miA+3f/F4+9OwH8pGlHyLbljMgKR85f+asA+QX4B72
	6Cy5dd2wWsLfQd6fsiQLuYAXsaUdjkg22aPf4/RhGaemKw5nWgIc5meSPnd7MHKl
	8EKN/Lyfd7aTz0TtpB9d/zNZTeJzLghc89xPTAaZHZDxcXKwZY80tAeBPqMgPkUZ
	XZshyA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvretd60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 08 Nov 2026 07:32:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36f26e6abe9so526707eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 23:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794123131; x=1794727931; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxiJBm5NHRze1wOQWiUuvxPhaR3l7aCkihnUvorIFDY=;
        b=CSRqLQlyNrDLgFtO8o+8nqfxlpIdVEPDf5vpOdkUR2t+f/9YTEATyckCIyjmyQ1NQe
         JdL4QQCvkXefGZ7rRXXfgosJvnJ94LPO9DwR2+qfy9s39I0Z1yS6Sybgpj6k1+SD2hi9
         M8isAxXxM4Rjay9wOJjmwOj2/4ggxsOOi/hWpJqB0dT5PAdThR1/OIkAm//ZTpPWNrzS
         AZZNgSY13f8KX+peSS63g78pNKqMvFPnvmzK9t1CsqfsUNn6iezoxsulN6yvnqU+y3/Q
         1/T6MenuKcan8hmjTf3qgQNuHH/k/M8eIbwIFAAMopgAvPboUY5vbrxmpl1CIocSgzla
         Fmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794123131; x=1794727931;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gxiJBm5NHRze1wOQWiUuvxPhaR3l7aCkihnUvorIFDY=;
        b=Q7wQh60hyhW1M18NoNFY+I5d7AoS9m2ClvkhjrcWvA+byZtTk1ZT8Oqv06dhmEbDRB
         Z5bvd+3d0t7/sYm/KpyryAQ8vF7pJvtx+nzRSdsik02xomqOBZ2PPKWG/9wD2OCDGVVg
         dxZAOtspFR5zN+rrLKCGuNE70CoYD7NkPbQj1XIpWWwPS3MprRmcB3A/ouo3Q9g2z3sB
         7nSl2NSFnxDjsSDYqV7cPLIEeeum7IOrZ81bpTZ2Nlt4Pn4FAd9MO81fUlVWrCz/KvB7
         QKI89PitYa6IZrV0n1qmktzCT0VqetklqV2V5qMVsfA46c1v5NPOEreUUcOnaW1qCJb2
         Yvnw==
X-Forwarded-Encrypted: i=1; AL+hErFzasU9NbXheVzWVpKixQcMCVonBVYOirFT5PGItx6CG4O2d2u5A7b5xPksq0F0JM+u6s4cNrU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5He8ZsSmGpZc+gJz4KLyO0XAIuaeafg+ZjfYSws2TcB2sUeGj
	mO9NbbVRgmCijxfU7uzLitrNF36tkvKkJBROWtTziQSMFdc6eV1eNOybcCf3FbQg523fEcrIDM0
	E0nVR6i8a2ZlsgfH/kS1rNbvHovlvRcUcRn7l8WiC+akTQHqvTkriUD8ZGizZD2cQ2y4=
X-Gm-Gg: AYBFou3MSjKG1G8fo/oma8otJC5faeL5PYdXS6dePwWgxYHO/hX1QeTtzk/2S2WeOdc
	ylEIuq6K8jNtIAdpxrmsVDkgwC9iDZy86I3G5F38KyD4JSs+YKOiPL8ga2Y+oLGm47NgREYeT1l
	y5LAlxRSJVQbSH/rtPCIqwaG+K/rx6za/aauZIPZMR6XOPIJNCM4rSGZc4bRe6Jaip+Y1TPU/Z/
	td5n9jqHdplzimeDH1MbONT9C14VTc1463Tb9BVF5Hr9UpC1aIjhCoTPOh93vs2Cbd3MmfAMhpA
	2N5QL2J1eGqDhbHkZNUDD9ZhQuVZaJJOVAaZV2gAFjnlK7aktXCT5QeHr+XbXNXHc9+g0KuRHHp
	RXr/FddiLUHxYixxuT4Mra55vZTYuazYczpqXPj4yxcttBnOhcXON9H4Gvc0MbRGzzgLIlW8xb+
	NG5hKIMBoxk8CBcPxEtUwCoq7sOWMuVahx1OoHwuWik9zHrBJCQgE1uinS
X-Received: by 2002:a05:693c:26c6:b0:36a:12c4:8bd6 with SMTP id 5a478bee46e88-3725807c441mr2104196eec.22.1794123131009;
        Sat, 07 Nov 2026 23:32:11 -0800 (PST)
X-Received: by 2002:a05:693c:26c6:b0:36a:12c4:8bd6 with SMTP id 5a478bee46e88-3725807c441mr2104172eec.22.1794123130329;
        Sat, 07 Nov 2026 23:32:10 -0800 (PST)
Received: from QCOMk1gASIiYhG (66-33-8-210.colorado.intrepidfiber.us. [66.33.8.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d6088sm3933263eec.25.2026.11.07.23.32.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2026 23:32:09 -0800 (PST)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: =?utf-8?Q?'J=C3=A9r=C3=A9my_Jean'?= <Jeremy.Jean@oss.cyber.gouv.fr>,
        "'Sean Tranchetti'" <sean.tranchetti@oss.qualcomm.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: RE: [PATCH net] net: qualcomm: rmnet: fix TX aggregation teardown race
Date: Sun, 8 Nov 2026 00:32:09 -0700
Message-ID: <000101dd6f53$43952740$cabf75c0$@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGbpdxbh/nRSzqnN/vaM8uyj5zlKLenWosw
Content-Language: en-us
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDAyOSBTYWx0ZWRfX8805uxxyaQkQ
 iU86aLg1Zzojv47mRNkTXB8BL3L/ImeAVA7tYkupaTJ7GLbOMJ0q0UxZUDYs02XjRSaL+8LPc7L
 5lT+WYgWsuwLPNgxRYvjcchmmu3npNQ=
X-Proofpoint-GUID: diK97qJAyaIJoWSsMEVKEIyykp1GoKpG
X-Authority-Analysis: v=2.4 cv=FrKQbGrq c=1 sm=1 tr=0 ts=6af0257b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=OltkOWFNRHEXGe+8VJKHzA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=gUkXs5wQAgBOA1n-_pMA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: diK97qJAyaIJoWSsMEVKEIyykp1GoKpG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAyOSBTYWx0ZWRfX7un3V1nrsvcc
 Zx0lGcarSMpGYdUv8YkDXe82JvS/nxG4+qv7w0mtlUrJDl/6GHau2Y1j0hBD68RzEn/nA273o5W
 H+lYjKxsPvGRhhPsRYZY5xS7zfpgyoKKcHuvziTt9FTsEsWT5fR3lwsDmXmL1bKDhFNCMSxi+yT
 6n3CcdMYO/d9szbyMxG6zwnKQ6a3DwHV9c8NFPcBEQDFSg5j/0fvI4RUEyVDRKlVLB4BNUvutWG
 YzeYYtliwjsC9/XTSz2hSfC1l14nWTXOxrFyX4rhYAh8gdqQJkCHjEfZPu2iDHt78MaNJzULYEA
 TnZchdFCoidyyZRmozTDA8jOy3jD+SKmhzv38JdQb8W7D7yamTMOtd3ALXna7hhDxgBfW4eiqBv
 PKxdV2027Xq8Z4OtuKCFfNtwwmX593gqZ/Dn5pi6IZJShVWq4Km7qQ8zyE0iLHbEB72iQoMi9ds
 m3e28oJNV3QGKrOa0UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080029

> -----Original Message-----
> From: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> Sent: Sunday, November 1, 2026 4:34 PM
> To: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>; Sean Tranchetti
> <sean.tranchetti@oss.qualcomm.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
J=C3=A9r=C3=A9my Jean
> <Jeremy.Jean@oss.cyber.gouv.fr>; stable@vger.kernel.org
> Subject: [PATCH net] net: qualcomm: rmnet: fix TX aggregation teardown =
race
>=20
> There is a race in rmnet_unregister_real_device() because it cancels =
TX
> aggregation before unregistering the rx handler. A transmit that =
already
> obtained the port through rmnet_get_port_rcu() can wait on =
port->agg_lock,
> then create a new aggregate and rearm the timer after
> rmnet_map_tx_aggregate_exit() has drained it. The timer can later =
queue work
> on the freed port.
>=20
> Unregister the rx handler first so that no reader can rearm =
aggregation after
> rmnet_map_tx_aggregate_exit() drains it.
>=20
> Fixes: 64b5d1f8f2d1 ("net: qualcomm: rmnet: add tx packets =
aggregation")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index 61b04c6c0390..2ff4b9519139 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -40,10 +40,10 @@ static int rmnet_unregister_real_device(struct
> net_device *real_dev)
>  	if (port->nr_rmnet_devs)
>  		return -EINVAL;
>=20
> -	rmnet_map_tx_aggregate_exit(port);
> -
>  	netdev_rx_handler_unregister(real_dev);
>=20
> +	rmnet_map_tx_aggregate_exit(port);
> +
>  	kfree(port);
>=20
>  	netdev_dbg(real_dev, "Removed from rmnet\n");
> --
> 2.47.3

Reviewed-by: Subash Abhinov Kasiviswanathan =
<subash.a.kasiviswanathan@oss.qualcomm.com>

