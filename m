Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794319421;
	b=g9ZyT52q1QjjPAhzc7cVXxA2v6z4FzZ2m5UhYTO8BX2u3W80XGXNZMnGNmCjbNpr6+nW
	 0cM0n1T/Nvi+m5qAJqF/5Zn+C8Aq4xQP5nYVdZg+zzD1gQUMF5M/rfMXnw+q9L9xQeSOG
	 1IEGMKF+3JKP9Ne6xcx+We2tjzofcLoMjw9VqgbTTHaiF17rtTWTxPIbuZKTWUEkvyskg
	 wspQNJThgy9bU5gTwbEbiliwr3khjBNH6XrsLJ0i06dIAgIhi/OI9OFOeBLCnYgt7QYuX
	 rzKse4TK0k3GhadQr2Qzz11jUgAk4DeA+TACVXwgfWGjOCikooS5fjgvtSEheV6K5iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319421;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dDX5RY4IsH57J/4XqqE9KKM+HkzFDQFjq5zuAjcxbQI=;
	b=tdORF3zJ+Yn+WR5WUNsj3FzRGayU5SwdX0FFG2xCh/AICtshIyCuZk6zWZ8prjVQ56mE
	 s8llwnLT1XAAuUIjiGKkR8uFxmezgnD+3Bxz3w/SYPwSzUzT5jHYdJOo4UMC2IdcGrz2J
	 3Jr2/SIRxmz9CUrqV1PFzb1I038Jj2jCK3HQJwVSfd3kqFWzr7KV2DYqAy7zhs9JnYV9X
	 mAEzKcNNuJhDi4GXz6v19xR+eD4sGAdi24gMWBpra+ktX5xLQZb0YFiN8GIaGec4g0sqB
	 Q8ftkIwZrtgkb774CSc1t1FE6DJWLQSKNdNfzASOtXptbPghu38BjvvA8N55v/j8hJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KgXOUwrI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TRgeo6Rw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003AB60A261F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003AB60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KgXOUwrI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TRgeo6Rw
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAE3Wps028683
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dDX5RY4IsH57J/4XqqE9KKM+HkzFDQFjq5zuAjcxbQI=; b=KgXOUwrITrNNU6Dj
	/Yvq+TrAEK8YKXw+BevwJlstrdE99zvrKFLzDpy8CbkA1NX7B+2G91rwfRmXqPQL
	JnBY8RsWq4K2koAAMPHerYnf59uXqkU9f5ir7uppKQ66lXEGzJrw1JGH/rtBU0LM
	oliZwED9/Gtpe5El2/JmNAaoMIY/sXP396QBPsZloSRMy9p45P6ECsV4OYXTCZSv
	xURwlcr3ghHSjdIST4UWCGmoK8aXG1QqJFKHZDMd5SK+iti6+FHzKJZKVY4N8hzS
	+1Ezy93APlrNaAC7yJ89394ZUMtu2pD7mIi6JhPFfvxTO06zg5K5+B/lSa/nUhIZ
	+g0mMA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv4pv801p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:03:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eaae8d29e0so28677085ad.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:03:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794319419; cv=none;
        d=google.com; s=arc-20260327;
        b=ja8Ml+L76IML8vtQcMQ87a+jbhe33dQSGblu0SxhiIz0ccpiVa0jq42rTHAG0zX0l7
         sbYeWkjA2p0+JgpiefZMBbYGNVgEDLvFxSho4YNuTXEk6WeSeImlK0EXZSI/fOjszcSf
         1amlJPQyUh5lGN6Y4TZjOms78EhmxcXYOW85B38HdW0mLfrNQ3f2U1zEFTlxq9fIE1U7
         RaAy2Too6p3jLMCbZkwlvvgU7PJfV0xeILHM9IL0jcD+5uxzPZmRpqaIN2hXA+a3VM7O
         y5u/K6CLVMRGt5IZSOOFtZ7od4qUV10pl8slEl1BIoButJKCsFyA67eiVz9E0N9YWTUU
         UgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dDX5RY4IsH57J/4XqqE9KKM+HkzFDQFjq5zuAjcxbQI=;
        fh=rNIJwnp+fAgbk1QHyLacoIAInI008dKw0V36eg0GWig=;
        b=nrOBcVYf76ZpvsGAMbQVEUNTaTJKiZJnFKf+n1E6HRMgA7W7DI4A9Nid0phT+3Sk9e
         sMhHVA4AStgwkpHtlXlDbQVVQjSEnvGaQXfjknxViHBlp9RBKfqsA8xhf/jUX8Hl37fN
         JBFNlFPY41b/2THpl7MzPK1LfWkJO+XSQMARuhtMvnbqoWKWc0eHiERtIXVEvfbip5yL
         WcPrbJnYVZ/7t+0yT+lrI5dRIMrMbGqJpS4JHaBXVUiJAknMlaUTzsJERKYfuuMY98AH
         Uro4sLgZyj0rwMMCYGv65msqwCjMhBRjsnqACaDxMOAjYZ8ZgV1vYhGqQ7IuEJKwFW9u
         VJoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794319419; x=1794924219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dDX5RY4IsH57J/4XqqE9KKM+HkzFDQFjq5zuAjcxbQI=;
        b=TRgeo6RwEHSsA2/xwLMsO8yEk6Vm/2bcK5XT3poRWGF+sKb6KRfMm5tAg90mxLiJ4Z
         +CS+Ku+3CUnLMopKYwyxdXUu8jl7K2cJ/aytHhu6XEPN2OnZxGvqO135FE2VeFB7jacg
         qlXyI4T11RbFO4M8BQQFCzT2SQ4gd7sl2PaRXFMrtg4R7Q8OeEIKKVmiXV7JonctTC50
         ljsFCBPgYvggl2jHRGTgT9aBxAHfoq2nmH+b2hzZwAZHP0h03T90l6GedY/C8pxEScgU
         OG5XoTQM5HRu9S4/dvq+LxyfsjbHoMMIf7+mXH1FnOwwenCoOVjir/gcsW/HCo78UUYw
         kfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319419; x=1794924219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDX5RY4IsH57J/4XqqE9KKM+HkzFDQFjq5zuAjcxbQI=;
        b=Agpwo8S519eavtE2TXkqrR8h24hVEUyaEpY52I5odZgzPB1jSE5vDeyoTAbJHkThd/
         fDUkZTmWdAizfQNbdvkIIBmrKmYEqdzEy/Ru77lTBxX53DpIUdcJLaUy0RpwjpXIwXzF
         PKYeliBGRCNjKg8YX1EgDQmgIA+pwP1DhFY0lGyWi068Yk8UwTPPfmZEZ4MMBv+uTk7D
         azKKaIiEsNfmh5UhLom6xnuRp/A6R0ruX8Ui6cVg4zCNunryWRfS9vTMQWnOc2mfdVnW
         nl45hFIFRIvYz7GglVgPQSLMRuQ76Wk5cBFkeRJTBoUU/inuU6PlQs9rtT2wOCKEPDws
         dh0A==
X-Forwarded-Encrypted: i=1; AL+hErFbGgmdHZqonT3GvqmgYXcMxLu2+eSxKTSc3mVJhN4adyMWVKot8/RKGduhlgGe8eFArWc5xo0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ae4JiK4x0hBFWU47ZtmzRVtAJLYyB7xhcTU4orzRY9pE78lrX
	sontsiKmYwTzm80xFjKv/z6U3FFKFUYpQEytj+gMo+Xnv/J44I9qZih+qU887bce90PFgPc/MKy
	pyyU35d7jea4iqsWOdTpm1q/OPXvdf1SVT6DQKqA0ulvoDkT6ojDPL+VchK7elVqbgcd925+YjG
	wuC6GnavazQ3mJHkMxonFC/aIDGnN2RKGO8w==
X-Gm-Gg: AYBFou0RdIoEreM1vVQAQl3SPs82jtmJNy+ftsi0C88hKmjSFeTIw0Cdrgfh5WXb/x5
	Zb3sZROoFqYmYA1SKLwpfxbD8X2VrMGeP3E0rkIkR37Pp9bj8wEqbyemJ4hTZJP8uqGBoa+N8KD
	yjZbihjA+r1xbmIOdNXhyyzE+Uj66Rlc52FwkFhsMTSNI4ki6TPiyoj8ZCYw==
X-Received: by 2002:a17:902:d547:b0:2ed:218:6043 with SMTP id d9443c01a7336-2edb93052e6mr21107295ad.59.1794319418787;
        Tue, 10 Nov 2026 06:03:38 -0800 (PST)
X-Received: by 2002:a17:902:d547:b0:2ed:218:6043 with SMTP id
 d9443c01a7336-2edb93052e6mr21107095ad.59.1794319418328; Tue, 10 Nov 2026
 06:03:38 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101063719.88570-1-0xbeac@gmail.com> <20261102022924.51343-1-0xbeac@gmail.com>
 <20261102022924.51343-2-0xbeac@gmail.com>
In-Reply-To: <20261102022924.51343-2-0xbeac@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:03:26 +0100
X-Gm-Features: AclHuK_Jj5PX-_n156Je1b1cz-aHL6EQj5fE_4gj1noerQIcKZbFTd5LaBqKoz8
Message-ID: <CAPx+jO_-6R2N_Mf0AjsqVa==4fQAf2hoveOsR6RyY8zVxrPbSg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] mmc: dw_mmc: drain bh_work on host removal
To: BeaCox <0xbeac@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=XqZvqlF9 c=1 sm=1 tr=0 ts=6af3243b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=J95AHcnkyf1SBl47ZhgA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: eP5WhUJfs0uo9G1ZvQvseIGkK53Ax0on
X-Proofpoint-GUID: eP5WhUJfs0uo9G1ZvQvseIGkK53Ax0on
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfX4+K5XNBvJNRr
 1xQNe7PVHmO15kk7t/MYG9nSI7fFZgWQY6WZzrpkB67C8OTcLQVzulOcbkQxvFob+4SS36P5xop
 xNNiQNp/DIdiK+h0chHoD/8NUAHdoqE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1NSBTYWx0ZWRfXy8YK/ua4Tlt9
 PLqMcj+iEOPTp53mWuJANb4/FhIvihJZWp+MhLw7c7t6z3lF3shy8KRAvyq8q6wvb+6vIMbrlve
 LlCP49S0PXYey8+dTqPxO+nL8V48Rn6ugql0tVadQNguF+SnQRKaZJ1qTM64NddBJewyeKBU0zX
 +MNgNG/VuScbukB2YDo3iNKe+PECfrOK2PYe+qvjw45mrWkWhByMngxhAfQvsg/qCbvTvd6tKWN
 WoIgKehDUIB2chRZnElItzDAKN1v1z+NAP1XO+HPfnHpEZAwwlkXFB87Sxa3RQT/7kXpuZAz7fU
 uI+G/iTju5nI5llG8s3UHN8+64fDcLwD6Eb9j2wg0zU3qeP5DZXuUivrHLBuHxqdXwPAyEizNcG
 Bhph0LUMYWtLrXjP8xXqoN8kRPieXUyj6t5OTTSE3LJ/W5gozJDJvLzBr0mzRjWnn0M6D9VXzHH
 7IXPlY9b3D66gVT1sIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100055

On Mon, Nov 2, 2026 at 3:29=E2=80=AFAM BeaCox <0xbeac@gmail.com> wrote:
>
> dw_mci_remove() does not drain bh_work before the driver core releases
> the devm-managed host.  The interrupt handler, the fault-injection timer
> and the DMA completion path can queue that work, and its callback
> accesses the host and MMC request state.  A work item that is still
> pending or running after remove returns dereferences freed memory.
>
> This is not a regression from the tasklet-to-BH-workqueue conversion.
> The tasklet that bh_work replaced was never killed in dw_mci_remove()
> either, going back to the original driver.  Commit 921c87ba3893
> ("mmc: Convert from tasklet to BH workqueue") only replaced
> tasklet_schedule() with queue_work().
>
> After removing the MMC host and masking controller interrupts, drain
> the interrupt handler and disable the work synchronously.  Disabling
> the work also rejects later queue attempts, unlike cancellation alone.
> Stop the fault-injection timer after the work callback has finished so
> that it cannot rearm the timer after teardown has cancelled it.
>
> Fixes: f95f3850f7a9 ("mmc: dw_mmc: Add Synopsys DesignWare mmc host drive=
r")
> Cc: stable@vger.kernel.org # 6.11+
> Signed-off-by: BeaCox <0xbeac@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ff0b25d..5b47643 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3406,6 +3406,11 @@ void dw_mci_remove(struct dw_mci *host)
>         mci_writel(host, RINTSTS, 0xFFFFFFFF);
>         mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first =
*/
>
> +       synchronize_irq(host->irq);
> +       /* Stop the work before the timer that it can rearm. */
> +       disable_work_sync(&host->bh_work);
> +       dw_mci_stop_fault_timer(host);
> +
>         /* disable clock to CIU */
>         mci_writel(host, CLKENA, 0);
>         mci_writel(host, CLKSRC, 0);
> --
> 2.43.0
>
