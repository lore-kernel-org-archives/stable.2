Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC6C3FAE19
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661666; cv=none; b=UM3xZQ8wadyyiBNjm2pu7h6+c0DMr6GeTQZ7JyIDxgvFqI9q5ZW43Fbd/FdiXDSakDUWtSbbEGPSGOErsO7Zp6Mc0AeWgVWb/KM4m8IdNIHI38xRGFba9mfNdLKmQ9n/r/8XmPCanZFd5zMljRSqTViK4TVoUNWeJNKc4vCRYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661666; c=relaxed/simple;
	bh=2T5xt5xYrpTJyBgK2/2s4xYsC/gVfV/XaGADRVOUklQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwBAkuHWGRS/NxRjSeRi4d9CGQMuVaUjljRQkliYa/moW7KjUqvZBIjpw/GvtmPPuBlHnokXZZvubyUBpUnOsRSqgCFIAFCV8jLGY6rvdxMLv3jhRNs3PT8/7X0t9dRmco+97FOLB/NrGixbPqAepOYzOZzJLtTt5S9A/4F1C+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lS95z2dP; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HNAJGtAq; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lS95z2dP";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HNAJGtAq"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAXsI91168495
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=lQP/
	Qacua2ze2fSXiT7UWYPKU3vKsxnZs5GxskwVoY0=; b=lS95z2dPV2Clg7Jkme23
	2kncIJBjzQyE21m3aB352V4jF6O5aTBDwhyl1DCecWFBRVBvi5+dM0oYImpzS9Lt
	eQU0hdTpz3//8FTnjcZAMXOG1dvcY91lihf/te76A/FR+PkL5DHPDLEjuPjX/fzS
	4oDr9F4n3jSdmFUVOHKuuQtI4a/SbQo+8bhPyiu87FbrU2kX2OPj4H/vQt/1wVp+
	ZbHkddkH+z+Y9HpObyRqKJkhzun912SjG0lJawS0J4rqvpVk9IHsoCLZwHuqGuXC
	SClWGqMqhxFDiO45GjXRpdHjJOSD334EGsSknHd7d9RFi3bJWBxXq8l80rHze2D/
	wg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g8u38464m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 08:29:22 -0400 (EDT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-97cb18cfa04so355086241.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 05:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787660962; x=1788265762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQP/Qacua2ze2fSXiT7UWYPKU3vKsxnZs5GxskwVoY0=;
        b=HNAJGtAqJuJ5R/PnD1lUPsxT6n9QHqxfYRVg0DuOViIM5KLS1ODjjvAh3ijIPNSvio
         /oInS6NxNgYVwkU6fc2+a3YCz+0+ugozDhf7bG1w4kdCSZJs5TP7DtIjL/0RSIBxBH7+
         vAM9QdJ9nWYdrkdoGtVqagPsgclQbvUHX30Ctd7ZGp7Monupv/5OCD7XHOarPjcAm0uj
         jjtqhhId3Zpv3WNIRIfZJQJMcYTcN7gYqe/I5Jixkg65S5bvGJJCK67ciqwy9L70NLus
         WhHXcmS+SgCznIzpparKGm/l3YzEHoTuAWi92S2lEDN9zZTMqOWvtCU2dAFpAJ/qoqQL
         eBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660962; x=1788265762;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQP/Qacua2ze2fSXiT7UWYPKU3vKsxnZs5GxskwVoY0=;
        b=D+8mV1xQGxqcT8ZrB7drDdohfB/BL9Vw3jJs7U9ddi/K8tjRE4DcpTAij46Dku++H7
         eMWhfwT3PWyUfSwUkOzsFiLVBbK01wVrcBEA6SzFHY1Sh2HU/U0TI5lwCSobYCRyukl9
         y4xycm/p8iknY1L1Ekkz0hDw4ociOqblsYOxhQTSUXzkuACc+MwFdltik5LO4a/+aiE8
         vH2LpTPguWwrjzAwFCLpJIqDoj7tAPXnCgJ3OLtvRmzrJ8IoNEYGYai+2csLMUluBhNo
         Lw5u5x6xk4eJHiBc6kscSp4CkGDxwHyI1nzEfCmGe+8uR/bMeWFD8dJD2r6Y2K4H0TEu
         ygKA==
X-Forwarded-Encrypted: i=1; AHgh+RpknQRrYBOr0jm6GdmXbHCu/XWpvL0lJEC9a8uGRCBG8xCJK43QX2CjYpGi/W8aUPKFV79nDk4=@vger.kernel.org
X-Gm-Message-State: AFuF++nfTSaK/W5P1mBouAydAg2pyruffiHW4AOGUbrushlrPRbmYR7i
	6kojvxGzb+wzirqceo7UR7J9eCij/Rw7msyOdlqK0RuR3GPdO8EwNy9QqDkhUvNw71S+ehsYdAo
	VHx/hQOcQT21m0D9hW4PvtJ9nI6JNVnLqNer/v1HarPxIcNSawm6sRw==
X-Gm-Gg: AR+sD10IWXhGTnhmIqhtBFdkiAroVWjwVL5KEQ6/KR0g7WwTXbeTYMqc2kWaBc2SYSQ
	1pjZ2owoTtlg+GxXugsQSngOKo8E83XGwEBv7uAun52YelkScJhDR+xvoXvkQ1iGC88lijq3dV3
	a729P4i8q10hSt0ulBcD8zZD3I0bsWI/VzenmpHL2uJZoCO657knRmnnzK21ua0wT+KBo3jE5j5
	fNC+LB0z243hyGs+AcpP6XzAwtyfxfAioiN4RnWZW85UBfDV8R84lDQopknXvUtAKXEgMLBg4ud
	2p5j0CPmWk0Fa3pdbZGujoDkmsJ7rAajGYnok50W1JunUxnUEqTY/k0E9re31qbO5VUxGr6vl45
	Zlgelor9L29qNY/Yu1qb6CkONoYoRe+CVT1ug4wMgIIHCwBySyH+DHCn0OpUUHIY=
X-Received: by 2002:a05:6102:162a:b0:77b:28c1:210e with SMTP id ada2fe7eead31-77fe6152fc3mr2320069137.1.1787660962337;
        Tue, 25 Aug 2026 05:29:22 -0700 (PDT)
X-Received: by 2002:a05:6102:162a:b0:77b:28c1:210e with SMTP id ada2fe7eead31-77fe6152fc3mr2320053137.1.1787660961894;
        Tue, 25 Aug 2026 05:29:21 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:85d9:8007:d045:f143:2579? ([2a00:a040:199:85d9:8007:d045:f143:2579])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1aeab9sm15243570a12.22.2026.08.25.05.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:29:20 -0700 (PDT)
Message-ID: <2de18fd2-08e2-40e6-ba97-4138be672cc9@columbia.edu>
Date: Tue, 25 Aug 2026 15:29:19 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ceph: fix page vector leak on encrypted netfs read EIO
 path
To: Alex Markuze <amarkuze@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260825092934.2605898-1-amarkuze@redhat.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260825092934.2605898-1-amarkuze@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsR9H2WN c=1 sm=1 tr=0 ts=6a8d8aa2 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=IK5w7ozgSBlwG0T9EBUA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: mGV0Se9OIFfbmT-jKQ8VlCxG7qlsAjzR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEwNSBTYWx0ZWRfX5vgBz8rmXUwp
 A2ZxbE7Jdl0RhsYoX4SCMARBRhBW4y/7mEUstSSsswWZ13I8bDSluSr7zdy6yoXHfDCVbNCwcmQ
 SK1y1TFW0Ce4U1CqDUP7AUcOti5+3NfwyD11jSqTofVNpmM6CX/pTypbTgAqZKgtYQWxG4t+MU3
 XHBlNa0E5auYcyUbpcRGh0JAj4C6RS4waeieoQk97zSO6iE4yBgPgp1cHcPXdw7VDTImWrNvdWj
 jZAMVIntL4sZSkdJDl1wGNqGbbW0XHWA8BrOrYvqeeJqaBIT7Fhp2xiQQT+GyJUgD0HXKh3mxTc
 4MfjjBB8fncR88OFE9TtHfkxfbL6B5no8TOMbpULILVOxP1hTmWrwVfmkE7550rGDRMdri/fPaX
 vO2Dxfl32+7PA1WWGxKfq/NYFpscc2G7Af7s6WA3VfTtDUH4+MQNHyqdJ6UKN9ths9+16p07b0D
 zqcnQfN/iEglCRazq2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEwNSBTYWx0ZWRfX6B8QRLUtnv/z
 sBo3hIgKvUKJIkvyI1Ge3PGchw23D36uHJRRMB7n2x5Yze3slPjrDQc2353egZUUbIs1YLvAwrK
 OLICIr3eJh4ay/gSRkDPygATaYtcPipesw4/xp6sa1KwFknNyW42
X-Proofpoint-ORIG-GUID: mGV0Se9OIFfbmT-jKQ8VlCxG7qlsAjzR
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11885
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=10 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=10 lowpriorityscore=10 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250105

On 8/25/26 12:29 PM, Alex Markuze wrote:
> ceph_netfs_issue_read() pins pages with iov_iter_get_pages_alloc2() for
> encrypted inodes and attaches them with own_pages=false. If
> ceph_inc_osd_stopping_blocker() then fails, the request is dropped
> without calling finish_netfs_read(), so the page array and the
> references taken on those pages leak: ceph_osd_data_release() only
> frees pages when own_pages is true, and __free_pages() would be the
> wrong destructor for GUP-pinned pages.
> 
> Release the vector with put_page() and kvfree() on that error path,
> matching finish_netfs_read(). Unencrypted ITER reads are unaffected.
> 
> Fixes: 1464de9f813e ("ceph: wait for OSD requests' callbacks to finish when unmounting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>

Reviewed-by: Tal Zussman <tz2294@columbia.edu>

> ---
>   fs/ceph/addr.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index c05bdf5d7273..8b009e354d30 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -442,6 +442,17 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>   		osd_req_op_extent_osd_iter(req, 0, &subreq->io_iter);
>   	}
>   	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
> +		struct ceph_osd_data *osd_data =
> +			osd_req_op_extent_osd_data(req, 0);
> +
> +		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
> +			int num_pages = calc_pages_for(osd_data->alignment,
> +						       osd_data->length);
> +
> +			for (int i = 0; i < num_pages; i++)
> +				put_page(osd_data->pages[i]);
> +			kvfree(osd_data->pages);
> +		}
>   		err = -EIO;
>   		goto out;
>   	}
> -- 
> 2.34.1
> 

