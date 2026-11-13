Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592082;
	b=x94X9d2sDptBg7AS5ezT2MXfpvV79jdAmvq/BMVbGttUnxqrOjRQPUNhBFh2aS9ac4Gg
	 syej6am28rcLbbKT9PAMxYCgZ2XPipbFoqLNf8SWjz+Xyt60GRuGaejcN1LZuQy/1Cf3F
	 TUaL/CBFL9RFrrIsdhkfOhjsIPu6ygHjEhhbIjsnrSwtwzOegU/8n29tOLYyjuNRdH46P
	 GsaPIKBqRZ4UzrYbSRZshDYzO1jkDGI1QLcjGA9xfr12LeZU4fFv/UHAm4AEj1u5lIzpq
	 DecRUAU55qjAigXwB2fGTJSA3rDXesKzLXN6IgbO2469RnuMXeSvniWL8P7SNIGcMHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592082;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KsbltrIyDurmJRrLTrle+sgoNwKMPVf5IZ0hW0N52qc=;
	b=cfPQQMIYp+zmGtccM5kl5s0PRb2Nw1dsMZQULmEnjRiOuRUQl2i5nM1oT/K3xxWB22MK
	 ZRvB6a8cH0elTfQ5bQsTJ2OvQulguRv+9UbpsCyUmqBV9o5Y/2jpVs92Zc9PNZtBKIMj1
	 fgvfCwMeMLAZfVObfo6vqlj8kQb2hkVHRCNH1bvkfjmvmx2fEYrppoATTfEFThPahQErc
	 V004TRkbwPe/5LSVi7+2Kw8lYA5t2uA1CsxzsK4fVeaNo1dodD57iQOdv3OzzHymIYAZi
	 iw+JJ3YwglqL3dnW/HrJBYQEOfuCObLFs88A/DYc++NvLR2EMPTAiPpTn4ncowNtjzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UQ4DHfbe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M0EVrriA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587C606B225
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7587C606B225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UQ4DHfbe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M0EVrriA
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFQwcp2022392
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KsbltrIyDurmJRrLTrle+sgoNwKMPVf5IZ0hW0N52qc=; b=UQ4DHfbertQuo5VT
	BxZj/K3jFfBkDAEPaBojSwCJlYcpw0G6QfBFjSlmE405V072a1GFuXhx8dps8MTB
	PbAh5uclUv2E06ayHhKY6ehgB6UBp0kwIZRflEYqwcxwiMFnSMAIIOwuCRs+3mcV
	9/R3tv6iYbO5t1kNJqzLWaCgSa3tLnlGYL5h62t3ykUdrRGrzyTHjKD+uh9r+mU/
	dG7krFlKScrfjGx6wBxff0KT4Kx/zjlWQV/hOIO5rtO5WMUk9C8QjZUzUFJHZn17
	bKQxk852B8nReDUO/HbMi2QDzzqbA2+LM6+bp+UKsj/gZbhOEDrafN70tJHAHqpo
	jfn6HA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx0g21ms1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:48:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0f667a666so1694935a91.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:48:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592080; cv=none;
        d=google.com; s=arc-20260327;
        b=WsnfkRad1M88qZ9SYVzYgZoBZTuNZQWfQt70Qk1lcfeHTcG0ammDQ74ilbk0bJq5hL
         tjEOHBEaZaeLN+y6LvzyluOt1mXJSI5VVTd9dPuh/3Ey+JEF3R/SjvxYjq+Ic2/fb2bD
         dhPa0IHwJSJFoY0d6D060w4w+p2RV2wBNB/c8O9d5TJ7PZL5SE1h5WBs4Q+0obog/pU6
         FgJDgG43A2LQbx2qfbl8KJTxTw62qlJCZ8EmMs1CcV+P4pVn6j3GiFl26G+V5NLzYrMg
         3EC18TzxQj4uBesAJFT6vCe2foK6BLPOZvyGSoUg0RstBoq6h/3cWrXnZTuWrIM5Zbze
         pzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KsbltrIyDurmJRrLTrle+sgoNwKMPVf5IZ0hW0N52qc=;
        fh=RaeqQdwJibQXlP2PFcGOD8WJlXUN7Etyl4Xou3mZGOI=;
        b=Mx+7/xSc3B2p1OV7X9voq9QPkmm1HOkxZzHRVGiRKvDtsdS2SErILHMuIWsMWng99w
         ovzJZweNdaRgYI+6G3BhddT7GHEO8jFKBr7HW1esRc5gPXXyR9Z0mzaXH4c+HFOoqQ/t
         65CIaFhskrI9PbI+lwgwBUIkFzg5EtNqWUUYxvDEgx2oP5C8CLNXcIYRS75++W99reiQ
         8NR5Ojzp3EEjJTyI5HIJbCJqlweufnMeq+Mfog232ZypZbbfV39ovCVdC6fVrqa5egKX
         YTzUrk2hJjuR+8wxQWZiELd0Q+hMM+OqIybnq3j9lv/FvA5fMhB//nksOTMGc0Z2g9up
         YJWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794592080; x=1795196880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KsbltrIyDurmJRrLTrle+sgoNwKMPVf5IZ0hW0N52qc=;
        b=M0EVrriASVl4BEUn6glnS5ox3E0QgX6PjCKNlaqDj3ym8AQsQP/Gm8udCSFQt0kCw+
         ojh2802Sz7G7infVLgeh9vT+7+ibuFMUycMkc158kjYEM/38rIgRwjWNPnCOWnzREcWu
         4yFPtRBAfLdprTfsG4GWSeDrPqcB42qk2zsllrrMVSRCzfadNQzNm8NY6Uxo5Yx62IqQ
         rHqSkD5+fkB2G1ZAV19sTN8Rz/u3ykG1nYUDmSau4jUO9ED+xuDPOvfH3/a41UedMV0s
         HOkoS3b7Ll6B+QQaMQrM9/5ZkPpCYbAbad3hF/OLQtwMT56Fkx9KsC8XPxSznK/Pla70
         RYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592080; x=1795196880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KsbltrIyDurmJRrLTrle+sgoNwKMPVf5IZ0hW0N52qc=;
        b=RQm9vFYnvCc/A7F7xn9IISBg8wfj3LbA8RaxwFojyA/EVHZUK1sImaKhoq9JYfsQ+P
         lMQQEXN9c4PJxXT2wabEgJ+fFoRxzIdnVtusGOg2kTLHFSb/AbNiHsrTCGJI7Vm1wlpU
         TJD5+5q6Vm37vUvPvZpD3jnaJvocvFZD/+pbrrFTMUtZWxsBUskrIWETFDGTQmudkS4t
         9VvLdfQGtZsPoQBMn35wHIUhSnmZbjDcL/U9HZcYsBkz53qkHLqePYKwrS2geb7r0xkM
         CdG5hB68/RYpXYqQADjTUKVJSFfMzBz0GgR3lUrDOkKNztNyXpsYRDTQSew7mcaaj9sR
         2h3g==
X-Forwarded-Encrypted: i=1; AL+hErHWyD6g4WIBbTidlcTROHRfHqtjz2+BbEJJgA3YnoIqfrWzv9/YneFNqSa7cVPrr3DTyqhjRwg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ah0HUGBrbdjsl/QTXRZHorURkMOVcBKpt2fO3e5gvUMykb0jt
	X8pY4cjRBr0EE4cG0RBXhbum0XVzHMSBhXa4LLg0wHBplqo07RSvQejImWuBENdMRClPpvM+hiA
	t/L7NzIJvBKl6P/swsedtM2NltiSVfvW2uQDd2nlLMLJq3uBngfBwf9Gi8M80adtFkhFwquapwZ
	qyRXfMxODNGqDbXIEilk26o+hV7HmBpI+6BA==
X-Gm-Gg: AYBFou0Ej3C8ejK2mhBtuePg6uxBImSv4L9y+grwKFHeG6V5yATic8EHSIRM9zpEuYi
	RjAQynVOM/fXsF5/yEpopjG1AwE4Bmer1FEqrHPfWTg2iKY7ubzsUuD+/tf+HDIGITaBpBSDjVU
	9SZKA+dTW2eAy+x04OYrWYARn94r1sRlmA3vcZwIlbZHNmvhc2JW+2o124+g==
X-Received: by 2002:a17:90b:48ce:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3b1b0a4e8aemr2984902a91.57.1794592079865;
        Fri, 13 Nov 2026 09:47:59 -0800 (PST)
X-Received: by 2002:a17:90b:48ce:b0:3ae:5572:c4e2 with SMTP id
 98e67ed59e1d1-3b1b0a4e8aemr2984886a91.57.1794592079412; Fri, 13 Nov 2026
 09:47:59 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ivkwuomer5vsajf2lq6otpgxwqljkwooh3p7e5ne23j37pv22t@iluamo6gxmq3> <20260731131002.142671-1-linux@jaseg.de>
In-Reply-To: <20260731131002.142671-1-linux@jaseg.de>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:47:48 +0100
X-Gm-Features: AclHuK_ZuwtIA029trmw5F8DdkesfBzk2SXLciir6o9jwwGKO1CXPCiGSeJhXdk
Message-ID: <CAPx+jO8DKyuNMEKCHyKzw5DS62U2Xu6mcL3BtitRwrYP0gad0A@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: core: Wait for device link removals before
 dropping genpd->dev
To: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX93XJHJ7ZJIa+
 4UZ70lo1MvYO6OAeg+Svyz1FHhVyYumzsTINYzseIQHJJUclkC9H2n8v+10rA5JGQIIsziVBfdX
 25CTu43b6Q89gtR1od8AYxcLm/F5kFaERw1VmBSameZfP8bsYeGXAnIBJo95zE78pKvMX14xl7A
 hvqenY+6NHFTCZS0BpLjflysXs0V39GrXzs9jrUXa4jU2Y0KNaPRIdpTkio6vmjpcM3DlGtCjIi
 8W+bq4d+bkCgLWbRizldTazQUM5gzU8HvcN4w7R/JuNSKadLQedhiGH+JYh+OVr9GhXwA+Vype4
 QbaEC95apGyixEpIckBf3epuC8cadNJLOxXTBrv6sAAjGDHr6xkM5mqf4iKlPOEWN/Da0csqATP
 18Ho3fp9TDqXOkI4wAOcSNUlZ/dtIZcZWf9kWgfC/MeglhRztTIqUgrEjlndJGpU/Tes5Msh+Rr
 xjKQB729KCGan4T1yZw==
X-Proofpoint-ORIG-GUID: dWNWGVtOCREWh60q_abT7miYZITJRGbi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX3Ir0cF4TSXnK
 tBJsfAQoa77dZ3BUQn/CtxvMQBkfzFatl2IzyXLYj6RbLBiXIprJ/su+IKu4GRtvij1GvxHtj4J
 lcoVB5NzsrskHoyPr8Pt9qhxKTRB5UA=
X-Proofpoint-GUID: dWNWGVtOCREWh60q_abT7miYZITJRGbi
X-Authority-Analysis: v=2.4 cv=SpIFe/O0 c=1 sm=1 tr=0 ts=6af74d50 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ShrK26NZXz4ow7qFTikA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130070

+ Loic

On Fri, Jul 31, 2026 at 3:10=E2=80=AFPM Jan Sebastian G=C3=B6tte <linux@jas=
eg.de> wrote:
>
> genpd->dev is embedded in struct generic_pm_domain and its release
> function is empty, so providers free the containing genpd with a plain
> kfree() once of_genpd_remove_last() returns, ignoring its refcount.
>
> Since genpd->dev is registered on the genpd provider bus, fw_devlink
> creates device links to it, and those are torn down asynchronously.
> Nothing made genpd_remove() wait for those teardowns, so the provider
> could free the memory backing genpd->dev while the queued workers still
> used it.
>
> This is reachable at boot on qrb2210, where the firmware rejects PC mode
> and psci_cpuidle_domain_probe() removes all the CPU PM domains before
> returning -EPROBE_DEFER. The bug is asymptomatic on defconfig, but shows
> up when enabling KASAN or INIT_ON_FREE_DEFAULT_ON. In some builds, it
> causes the kernel to crash a few hundred ms into the boot.
>
> Call device_link_wait_removal() before dropping the final reference. All
> link removal work is queued from device_del(), via
> device_links_driver_cleanup() and device_links_purge(), which precedes
> genpd_free_data(), and flush_workqueue() waits for it to complete.
>
> Assisted-by: Claude:claude-5-opus
> Fixes: 18a3a510ecfd ("pmdomain: core: Add the genpd->dev to the genpd pro=
vider bus")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan Sebastian G=C3=B6tte <linux@jaseg.de>

I decided to apply this patch as is, for fixes! Apologize for the delay!

Let's try to come back to this and see if there is a better long term
solution, along the lines of what Saravana suggested.

@Loic, if you have time, can you please have a go and see if $subject
patch solves the problem you are seeing as well [1]?

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20261020-cpuidl-psci-fix-v1-1-d8ab9ac3b56d@oss.=
qualcomm.com/






> ---
> v2: remove this note from the commit text.
>
> Note: This patch was LLM-assisted. I reproduced the issue and tested
> this patch on hardware, and I did my best to verify it by hand. However,
> I'm far from an expert in pmdomain, so YMMV.
>
>  drivers/pmdomain/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..4eeb980e5a40 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -2348,6 +2348,9 @@ static int genpd_alloc_data(struct generic_pm_domai=
n *genpd)
>
>  static void genpd_free_data(struct generic_pm_domain *genpd)
>  {
> +       /* Pending device link removals still reference genpd->dev. */
> +       device_link_wait_removal();
> +
>         put_device(&genpd->dev);
>         if (genpd->device_id !=3D -ENXIO)
>                 ida_free(&genpd_ida, genpd->device_id);
> --
> 2.53.0
>
