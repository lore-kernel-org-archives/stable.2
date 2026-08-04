Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1171746A60B
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851002; cv=pass; b=HlhRBO9TKhIyUgPr+P9md+NnKB9bJdTwQ8XydRK+Iy7cCA0zmHUPEaYS7pBhYmp8vTgobUEI1lxRRWQaoDS9Xlcx7v2wsW3+AFnSYngCySSvPtA/gmQdCziaEXGBtC83qP2OioHW/KN5BVfO09cz+IOTGp0IPxXOn8mh15fPv+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851002; c=relaxed/simple;
	bh=TjY3JwvN0KkY4QTihEcPkyfz4jaDpiXty+YBU5vi8WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdausaH8b+79qTQcYVhBhAMVX7kunyTXzRY+gHFhR/EoS3KmALftvOJheby4gEzbSuqpiDS5Ia3g9cLi3L3dPnCUWM/SW4nBgcCgPYae6ika6N9OK0ytMglGUavlnHRP720QWUgpCjlM5RwdvAKjF7pgRhK+oIUANW/rd6jdsNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4jUvbaO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LWTELEjP; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4jUvbaO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWTELEjP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674CWw0u3211655
	for <stable@vger.kernel.org>; Tue, 4 Aug 2026 13:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=; b=H4jUvbaOV1LrAUlY
	3vwxDgGhDrsObzJKOQmJNSyj3CAEpXUskFeT1UeP8PeJd3TVpV+t98BtVgJ6VSvK
	L2ReD3uvsLlWnO7lAMVRWAnBX3Te2G0ftyx9jxp7V2VIQ4d5zFNURDckw6xo854p
	KPJjef8fqQJEcgV0udrbnVj/NqRHwDL4p3FDZumpxpdRi1t1Gnufz4752luSAb0O
	KowheWDi9xDI0bq8u3qr+SXPMJIICh5xAhrTHyuJ5woHN/omiqzgbg7o3VVQ9ysW
	ciuqHO+aUXKd+XHo4uUJ/BXYoygE+Mg6wd415MB/eC4h+xuY5O3npy0JXQmQG3L0
	3FLq5w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fud23h2q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 04 Aug 2026 13:43:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93494527488so771424585a.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 06:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785850999; cv=none;
        d=google.com; s=arc-20260327;
        b=GkDanlwZYG1jzExl2PUsM6dczfWG2TNlM0dqKgtqLY+iPCjkjMC3PnOLKtzY32TuNx
         Mo7TZerBffANcY7WXamnErg1H8HnGMIC0UPQssmhc8o9rzSGpfcSKkfVDLId8SbL85Z9
         kZP+E96iqqv5sfsdUNt6wqmiqQXsGQYiW0/hNHkb9hxKY8yk0HFBgm2ItyVKa9VQelOx
         GGC3vg1IflymOxhCas1AVU8qjUv9m4o5hCYsmmbLXCAtVKwvjfK6+Lj9OScp9CSnehzH
         nVh50arbRomhEGx6683HP0uGEjc2k9HJ8rFam5+Z8MWpw7D/hlfDUa7qJZugs6qv8lzh
         k6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=;
        fh=xP3dS6wtm+aEiL2Aq9K5MOcZMHMSw2rQ+A13bv6qemY=;
        b=N2AAbWtL/9GtFM/OY7tfnDrDjAQzObloPpNT8KmStNBslvgmibtiQqOEMe08DHZ/P9
         I7XSY3wJRW9fa/AxLqoFqJzC9q8drP7q5IfCJkwqIIV0CaylHdwkpDBSbXeNYPrMM4Gj
         UTzZfslv+hJ9d9YKgtDtUJ2Ww8LqkRtYK7FKByHfD7gZPpLNIc1VWo/IYKQViREqgVt4
         Lfu0NiUR1AGXCQYFf1h72bn/ogiYUlHSoftAbg3NFlwDfIGjbl2GE2ZhPxHT968/ClMg
         eMOLG+eBgBu3JO7vCTKwcXU5VqYVARsptuhaiMuctHULX20YtnKBAIM7LwGt7eL8DV3G
         7Spw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785850999; x=1786455799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=;
        b=LWTELEjPj5bx+0sxeV3csThFcUc8P/zk92IMiNytIDYWzLkS6X7a0DWrZ6CBVS3oro
         H3+Ok3pYp+LGhCRdYc7ley8CkaDFvc8bPPtlO3IDL9fRJSrcrLt4Xxrg7JhgGSjqL/E8
         6JCnoZ37TP0tAgdLCcgoRrm9pHWTN0XGqHuqXNC8wkEIsKO58A7vN8fsF9bUYP9UIUEH
         4lQqfL0AKDF5PdDPxIqD3JLb1MPVuUu6e5YYOUTp+VBhDIeyICC8eiypw9LCCu6/aW1W
         E755mlYYexod5dT2FdCtSJEm+S7WbSXvUKP0k0YUKroQubywms66tKj3PlZnwEIbViiQ
         d6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785850999; x=1786455799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WdLP9oHVnpRBg6AvyyfpL7x9ueh+h0T3QrgvvbYu0zY=;
        b=DGY1VdJPtn6jRmxgG85JP9jPdtyjHi4+anVCNcV2j61lRXKSxJYTq87/kDjn3U7ED9
         gU4dAMtBRn3n/Dd5dY2LcfRISIdJ2+Mrt5rlUm2mwtK06FxwcbuciaRlBzEzS7t7V3n3
         bBf4zrQnpmw1pIYUclAok1wcrtjsWI73XXNbLBPI1zKhlWkpUNvSxquXRQOpfLn2lz59
         fMdLJPgQAeO3ZHyP0nLMHfjYA7IydXZdBRTUIhQaSEXrGeOM2k40E7hs68fKkYuUA0BC
         gty178cZbGgm55Q/w0fOUY3QnnNsTd5ErvCD9WD0bK0Jv9CyQHhYLZLginH03QLx63K1
         bRZA==
X-Forwarded-Encrypted: i=1; AHgh+RoC2nSqdK1zbWwzPbvPYJxrRpoIn9IU1m0I4nv7gGP2DcsVgg28ytx1CyzuFc2i+Hxc18vv8E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgj+hZ7Q/Js6qFeLzNu3Cm3+4AQ7JO67EnqFKx0FcrJXAXO30
	z1cSZOXVHb9vNPlozFXYqqnlh85cNyZGnS5KUBzhWanLjuzOrxhPoR48ec2N06KCy9NJMq/NmnN
	r4HSqXh6Mo7j4o3t9HiE6+0RSocf3YxZPx3X4HFHypVPpByA4X3f/aEOlsXp0i9hafoCAFBb+LQ
	SdQJQD1k4C0sHmixRfY12q7amAYBrIUoBOnA==
X-Gm-Gg: AR+sD11OzI3gCMA6B1PS3uILAEzqH9VhDdADooMCIkK80PK9lcJIqqs9M6+c4cW0Z7m
	FJIiO9/VN3BwUeCKN2GobO6NFkBbLlB98ie72e8WkXDjkk7XtOez54EqLpSa1gl60XJT7D+DlAQ
	PwjY52ylL+oxuUb3mOqxh7pX/255hRVu4ZXjimwer48j8uMtvgvs4j2748hA==
X-Received: by 2002:a05:620a:4e7:b0:92a:3679:7978 with SMTP id af79cd13be357-934a078e708mr2148996885a.18.1785850999387;
        Tue, 04 Aug 2026 06:43:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4e7:b0:92a:3679:7978 with SMTP id
 af79cd13be357-934a078e708mr2148992385a.18.1785850999028; Tue, 04 Aug 2026
 06:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804022500.3768116-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260804022500.3768116-1-zhanxusheng@xiaomi.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 15:43:08 +0200
X-Gm-Features: AUfX_mzfzUVmf-wXZLSEXAVMnWXEdM45wmk6fU0mb5Urir6FFQzHUYENgrkAI0A
Message-ID: <CAPx+jO-P-ytiN4XHwiDQKftUUgK1-eOw3ristbL+r-WV=KSfcA@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix busy_timeout overflow in ns
 conversion on 32-bit
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Ravikumar Kattekola <rk@ti.com>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: P3yBMN7yCkNeA4iJ1pFx66-37j4CvINy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX6kvu43gTVp67
 0mzHwGkCOS2g+GQ0kGdqRnarkmRJyIpOzKRR+Jo34XpR6hVBV4V13pz+F/k6mIXsN1v/JBi5Gg9
 7mFCbYgT/Sobaqy4Bgh54g+2T+NPTqE=
X-Authority-Analysis: v=2.4 cv=XIkAjwhE c=1 sm=1 tr=0 ts=6a71ec78 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=IeNN-m2dAAAA:8
 a=k1ldLzYygzB-qbcyhXgA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: P3yBMN7yCkNeA4iJ1pFx66-37j4CvINy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDExMCBTYWx0ZWRfX3Jyqk0gpfjTD
 Ccboe0ZbQYfvmwFsS/4n+DgNm50pc+oyVIYq8lRk7EjPj3iy9EEuLh0SSh8FVdmPKIW1q911txG
 8iQ7DlEA7YHjnDMvJjP5OTHsajcfj3epoKmv+76Y7YOAG2e4X2bWQOIJGRUS13CQWTJORQ6myE+
 mwcsrm2HMyFAHpZQxjvhFeC+M88oe9jtYWgDGx5MR7mErnC4iCGBJDM4Gk498lN+x68Auic7P5F
 sEf8+26xuVFI+HxP2Ol7E3NIGueK36yzdzn4lftV/no/KZLnDgsctNLXKatm5CwXKsE/Ba6+2tM
 fp3OtlXuE2s4qbhTU6xYLZgHHYaB8/1t3YLAGy7iGAIDP9ISp3f5H3cscl+SpbJpf7evBTZzJ0V
 UTV8u/xCXu/OyerD49KZ9sO2OAsQUPCR0zm19oFdACaBTtTniUDeDBut7LBwqZwNjShzLenxwPE
 lFR9rzX7Nk88EzUVYcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040110

On Tue, Aug 4, 2026 at 4:25=E2=80=AFAM Zhan Xusheng <zhanxusheng1024@gmail.=
com> wrote:
>
> omap_hsmmc_prepare_data() converts the command busy timeout to nanosecond=
s
> with:
>
>         timeout =3D req->cmd->busy_timeout * NSEC_PER_MSEC;
>
> busy_timeout is an unsigned int (milliseconds) and timeout is a u64, but
> NSEC_PER_MSEC is 1000000L.  On 32-bit builds the multiplication is
> performed in 32-bit arithmetic and wraps for busy_timeout values above
> ~4294 ms, before the result is assigned to the u64.
>
> The driver does not set mmc->max_busy_timeout, so the core does not cap t=
he
> busy timeout, and commands such as erase or SANITIZE (MMC_SANITIZE_TIMEOU=
T_MS
> is 240000 ms) can pass a busy_timeout far larger than 4294 ms.  The wrapp=
ed,
> much smaller ns value is then programmed via set_data_timeout(), so the d=
ata
> timeout is set too short and the operation can time out prematurely.
>
> Cast busy_timeout to u64 before the multiplication so the conversion is d=
one
> in 64-bit arithmetic.
>
> Fixes: 8cc9a3e73de1 ("mmc: host: omap_hsmmc: use generic_cmd6_time to pro=
gram timeout value for CMD6")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap_hsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.=
c
> index 58c881f2725b..3356ac5a1fa0 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1357,7 +1357,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *hos=
t, struct mmc_request *req)
>         if (req->data =3D=3D NULL) {
>                 OMAP_HSMMC_WRITE(host->base, BLK, 0);
>                 if (req->cmd->flags & MMC_RSP_BUSY) {
> -                       timeout =3D req->cmd->busy_timeout * NSEC_PER_MSE=
C;
> +                       timeout =3D (u64)req->cmd->busy_timeout * NSEC_PE=
R_MSEC;
>
>                         /*
>                          * Set an arbitrary 100ms data timeout for comman=
ds with
> --
> 2.43.0
>
