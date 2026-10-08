Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71014D990A
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474056; cv=pass; b=I7vIVAkvJma8D4FpPoqcaJ4S6LD4U+d87ppcRIVTB8rfJRhRJtedBbNMisLo9njR9ZR+5vpOf/Uipij446f4U2yWT4gvpt1hTp1yWyOn7NvOIxm3SOaSNwJyRrKMmjkXkxVAvRZBF72sflYdtPJy+1drfHiEZ7bqo+ZhLbKD+B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474056; c=relaxed/simple;
	bh=slHR1YPhUF2z2kHNvGzhmvIQDaVz3ep5Ayu3yeXEfQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5tvD07cxPnSk9kMTNmU9DyV0mY6wcLcRMtPsb4HFYA6mBjVqB6qpqXOtw1Nf6iYtKfnf8TkNOsTIAUkOh6GvZW/qzUO6QKJhU/8rOM1Sfz86iZ/2sWHX/jnS1PbGVUBgZMtered6EWHj0S+WwdwI8+dgdpMsJVSD7PGfbrjKQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=miALOFsE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dFhwebxJ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="miALOFsE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dFhwebxJ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVWm4070508
	for <stable@vger.kernel.org>; Thu, 8 Oct 2026 15:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Oe6Q4hn8NZbevQHo3HojLMrHaWgWc23jgvVR/zZsNaw=; b=miALOFsEvXC+BHex
	VPS5UDhe+EAl/hpkRBmbgkKUSW3YhYq8c6TDOMQo8yjC7C5QSLKDKsHG2EUShkRz
	cInGnpWjWX9lV8b8XM1uak4uv4P5GoJX708boKAxyHFR4bJG6CFtRQ8BuyTQjAGT
	Bd5OEfn49AmVigZbQ40mLDsGO/ygoOzcGMEDaMw4deK91qbUN1iljAYC2m3Bx22E
	Jox3jhvBnPxXrQbCx1UavRJU8pIfWe3mbP/bG30NWK+0Ts01RPm51/NCiWvSmJ9T
	ncME7QLp0Ln/5G6fib+V3tGHIUneif9gqnZZPLDKdky9xOS85XEAmutg3zQrxI4F
	mzzpvg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h60sgb575-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 08 Oct 2026 15:40:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cc359d9easo904228885a.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 08:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791474053; cv=none;
        d=google.com; s=arc-20260327;
        b=ojU+dDOYy/TD470DfUf5A1w8bSxZV0KAV47BMSm+U0nkmDp4+Yp2ihW+iIg3u9SaC6
         0JN+q+hOKt2HRtdy6ES7bHX5VDRzI4y32pDjEhD1u0B+Esa53IF0+nxm70KUlVnhlGmb
         PDSNWs7ljGes2mh+CQYY9Uxnu4ouLo+VpQc+5Ep33Tq0P4q73YarbaEamsCeQs+EJ3PX
         +pNDHOeEP0EGNldq+9jX0U0o7pTbi38cB7R3VoTd7ifIX5VP5B7tIGiFWIJo4Z5odi9C
         rPc+eZonX0uWoBFdnAHRVYMGFgJhzreCecou7wv15v/I14fJTP+T80BJWA/97IaQ0PUP
         Vc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oe6Q4hn8NZbevQHo3HojLMrHaWgWc23jgvVR/zZsNaw=;
        fh=SUplgZ3Mrb7l66H3/NPws7ex1SYcv9piIto5Le/09LQ=;
        b=QbLtyYnVYFB3EOCmW4yjsY4378D4FwoOt4fRjDowf8G7szKhGyzAGF/EeAc1F2DpmN
         rjvkMnmmqa5B8ORgfPnxL3s95Vv0mdQQyWMHFEEMv2FZwBzTnoJmlMGszLdcDuN+O4ke
         DrgIbED9KqYZqjs92hWXkOmU+LU6Iff+cnSY3pvRt0Xz5oAFDrUQWSU6VQjtst4BEVFD
         pebV65qh0V5vmH+jGHAIgVP8LroNscr2QF08KG4bFNjWBAF3LPeo/zjB90GSAJYpTuSi
         uGNIcb4QAJ1S81bFK75pEtPwefpF0nDjaA0fHDkTn//9yRWNC8deKG1FVDJM1DX+nFkd
         a6XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791474053; x=1792078853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oe6Q4hn8NZbevQHo3HojLMrHaWgWc23jgvVR/zZsNaw=;
        b=dFhwebxJiPe7dwkLsc8puOiJFVNFtfLCW4Svzin9vxvj8ADbr9r/JDf0afbyXUTzNK
         mpn8dxK6y+79rRWttt5P26f/A/2ChKy2rhXOhWMgUVfsWp8C01RwrethiLtg9VXtzOoV
         8g6Ku81rZT2XdTCYhA3tgqQE6ao0thT3X/8wL6E4fxsZ/H2b9QLW+QbzZPSsquic/3h5
         lYSBPL2QN3d6Vye8TCjYoTzoedjNHT1rAFBhRWXsIax3rJF/UXSjwj6FjUIOEErHX6gY
         U9sYZmKhAWjFIVrHrVPU3UUnNKtm2NVuaDOCrNfThcHzGrh0FpDQP8ETT74tS6lPFAYi
         z5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474053; x=1792078853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oe6Q4hn8NZbevQHo3HojLMrHaWgWc23jgvVR/zZsNaw=;
        b=22xifxQVlejIGjrSzDGFwn+kTsxmHdHkICu03RSxmcpB7aWqV8a9ku4CkWweQ/cKj3
         itMGH2D16xYkO/xwp4NFI/yLkcyw3Ou7OFZP6IVrALWIePMKhrYgXTT/BfppnMarQyBm
         P1Kgj1H3LLMb00CoXmcAvpBQyEnINiricS0EKVlh9aWsP08eHHWTWsV8juPy/BtBoyXI
         NsfIy/OfmjIMGYaxLx+eCrutwh/Xx2nY5dtfKknZsl8k/s77kTZ999bFXJo0acGu7WnM
         bwdkUsVJv5SGk15lteZZR4C5tBt0DLyxw1VSh/dg9MKYZMN2MYjcahz1rGNaosqppPYx
         9pEA==
X-Forwarded-Encrypted: i=1; AKwUvBxKU9Ge9ikBCmfAy3j+cbBFFJDpgVMEVrUqNESxK5X+ZSMyS3yj2c8G8NX12DdFUxFxVhQ0Wac=@vger.kernel.org
X-Gm-Message-State: AFuF++lq+t15SPT6ezoL6A0fU1n2RdsUJwi/eQgg0LmGMB9m6wWmWuxf
	z6wpLHfp1keiuLmBsuEN7t199PMgh27w0itlH6Gpx81PA8WHwkrT+6pG3T12owcAOH+afvm3e5P
	yNjHJLwrAw2sMxh1wKj4HJ05KRtlmRFdC7dXupVk0yXl0i0DFI+XHObdo6XT4gabLHtFoNW+zQ8
	TmJ53rHCMii2HtwlO2NLQbcj1n4nCNn8BowA==
X-Gm-Gg: AYBFou3dVAo/V5eT5kwncH2A4GPNd57SZOwBux2Tt95JuQ7EjIZram2+LT3W9t9C/3o
	4hh4F5vPOv1lOiCHSa+l7+u3s8s1yRpWyqWeo5jCRuY1yNcutcspzrgTPyO3YUGWJuaC011ehFa
	eM1/dJlqs7gvsoqsFc2XQRFnyFWJWnaG4OU4XqoGzBTWscUOq9yqBh1kwIXKc434uHGL/Wg4n3Z
	vBfyzvZC8fZkIi6TFLI5Tv5S6GrYrMqczQQJavs35ZumeS82il7tqvZnpbBd7/2RuaZFL+7erU=
X-Received: by 2002:a05:620a:6f0e:b0:93e:980a:2ff0 with SMTP id af79cd13be357-93e9b7fe93amr1059915085a.68.1791474053398;
        Thu, 08 Oct 2026 08:40:53 -0700 (PDT)
X-Received: by 2002:a05:620a:6f0e:b0:93e:980a:2ff0 with SMTP id
 af79cd13be357-93e9b7fe93amr1059908985a.68.1791474052817; Thu, 08 Oct 2026
 08:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008130753.313875-1-dungvn2345@gmail.com>
In-Reply-To: <20261008130753.313875-1-dungvn2345@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 17:40:41 +0200
X-Gm-Features: AclHuK91Ghq1YzJ21SVhtTCbMeYC0aUPIQJSnVLk0PyF10TXbgdDoIar-HRc14M
Message-ID: <CAFEp6-1EHK+H+mvetOvDbQP8CD_JXtt8a-5zEA_bpT581Td-PA@mail.gmail.com>
Subject: Re: [PATCH] wwan: wwan_hwsim: Pin module for debugfs file operations
To: Bui Viet Dung <dungvn2345@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Hl3KM8rbPyOrhyXmYr3Cd5KbpCarPMOI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX0RhA7WtEBOkD
 6fX+wHN9PyNCVGN9al/L7ZZJIjBkqu1N1k8jB5Bcn7l8zi07c6ihj4v8BFULLehpau+iFobT5ly
 nOW2qlpmF7x5HBNb7zBZdTdMwqBhdAw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX4UsyUcLBJllu
 J/tDA08uVUVcOYLB19sEIK+qpy5Q/KwtnVj+hDNvY3W/uEkp3dPRWHPogyOjWrM08FU6THCZNDW
 oG9pRGfV3/uOtxSXBID/9ehozr2+/7r1QBUtR+8oWa/DASrRG1QDtRtWMg7bFi2U3F0tplNJfJN
 xxKPtku9txAqy+Yvw9lMkAtBkJY88d2QPgUUNUYh4xlSrT+KYtkQE00EHvqEXgk4QD9gpCrSLbO
 1+wDG0TbzZMleo4oE9N7fZqx+81DUWqdWgNbqSyK4fNh9RkG8pABexqnnNXgQqLn2bt8li2X8rn
 W12RCr92Zhr63VoVT5TNWkcUifZk+R4hSvWhEUQdB6/cIfxvqisC8gkrmT7de624HXhJg4Yrwf7
 X/e2GLetdGXCMQdK/XCRQgK0iVxWH7KRBAFguQOaEoRGzAYgrF3GM6/3/xp5b9lH47WaIV1xNqq
 jxWCIfqubT4/drdxbfQ==
X-Authority-Analysis: v=2.4 cv=DfWCOftW c=1 sm=1 tr=0 ts=6ac7b986 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ICYLl7Pk4l7hwN0V23EA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Hl3KM8rbPyOrhyXmYr3Cd5KbpCarPMOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080062

On Thu, Oct 8, 2026 at 3:08=E2=80=AFPM Bui Viet Dung <dungvn2345@gmail.com>=
 wrote:
>
> An open debugfs file retains its file_operations pointer in the
> debugfs proxy state. However, wwan_hwsim_debugfs_portdestroy_fops,
> wwan_hwsim_debugfs_portcreate_fops, wwan_hwsim_debugfs_devdestroy_fops,
> and wwan_hwsim_debugfs_devcreate_fops in wwan_hwsim.c have no
> .owner set to THIS_MODULE.
>
> As a result, full_proxy_open_regular() calls fops_get() which succeeds
> without taking a reference to the wwan_hwsim module. When a userspace
> process opens any of these debugfs files, a subsequent module unload
> (rmmod wwan_hwsim) can succeed while the file descriptor remains open.
>
> When the userspace process subsequently closes the descriptor,
> full_proxy_release() accesses the already unmapped file_operations
> structure, triggering a kernel oops in full_proxy_release():
>
>   BUG: unable to handle page fault for address: fffffbfff84f90ef
>   Oops: 0000 [#2] SMP KASAN NOPTI
>   RIP: 0010:full_proxy_release+0x8e/0x140
>   Call Trace:
>    <TASK>
>    __fput+0x357/0xaa0
>    fput_close_sync+0xe6/0x1a0
>    file_close_fd_locked+0x17e/0x2f0
>    do_close+0x33/0x70
>    __x64_sys_close+0x44/0x80
>    do_syscall_64+0xc3/0x590
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
>
> The issue was discovered via manual code audit of wwan_hwsim.c and
> reproduced on a Linux 7.3-rc6 test VM with CONFIG_WWAN_HWSIM=3Dm.
>
> Set .owner =3D THIS_MODULE on all four debugfs file_operations structures
> in wwan_hwsim.c so that debugfs pins the module until close has
> completed.
>
> Fixes: 9ee23f48f670 ("wwan_hwsim: add debugfs management interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Viet Dung <dungvn2345@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/wwan_hwsim.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.=
c
> index c3c2d2a68767..34eea3edc824 100644
> --- a/drivers/net/wwan/wwan_hwsim.c
> +++ b/drivers/net/wwan/wwan_hwsim.c
> @@ -500,6 +500,7 @@ static ssize_t wwan_hwsim_debugfs_portdestroy_write(s=
truct file *file,
>  }
>
>  static const struct file_operations wwan_hwsim_debugfs_portdestroy_fops =
=3D {
> +       .owner =3D THIS_MODULE,
>         .write =3D wwan_hwsim_debugfs_portdestroy_write,
>         .open =3D simple_open,
>         .llseek =3D noop_llseek,
> @@ -524,6 +525,7 @@ static ssize_t wwan_hwsim_debugfs_portcreate_write(st=
ruct file *file,
>  }
>
>  static const struct file_operations wwan_hwsim_debugfs_portcreate_fops =
=3D {
> +       .owner =3D THIS_MODULE,
>         .write =3D wwan_hwsim_debugfs_portcreate_write,
>         .open =3D simple_open,
>         .llseek =3D noop_llseek,
> @@ -545,6 +547,7 @@ static ssize_t wwan_hwsim_debugfs_devdestroy_write(st=
ruct file *file,
>  }
>
>  static const struct file_operations wwan_hwsim_debugfs_devdestroy_fops =
=3D {
> +       .owner =3D THIS_MODULE,
>         .write =3D wwan_hwsim_debugfs_devdestroy_write,
>         .open =3D simple_open,
>         .llseek =3D noop_llseek,
> @@ -568,6 +571,7 @@ static ssize_t wwan_hwsim_debugfs_devcreate_write(str=
uct file *file,
>  }
>
>  static const struct file_operations wwan_hwsim_debugfs_devcreate_fops =
=3D {
> +       .owner =3D THIS_MODULE,
>         .write =3D wwan_hwsim_debugfs_devcreate_write,
>         .open =3D simple_open,
>         .llseek =3D noop_llseek,
> --
> 2.43.0
>
