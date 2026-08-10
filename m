Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3C368D78
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388739; cv=none; b=Py5DTmK2wr2Br8GGeryZpOZUhCfasUfCug5/zo8ejVPVJsssSMdV9abMLbGGuaFfIw5HVqeQ2w9HFaxZB1ErCuXJwq8HdNc/Zy8Tkoq3oYpfGT+HaoeKxFZFRa0XW/fFnHnIdTUXA1XcLz8R2FRTURCMoexqSnZcXqW+m2c3FdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388739; c=relaxed/simple;
	bh=zskFWdvfb4X6iT+rFndb++fEi4Q4xWDj17P+6vj8CeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pa9OhsKPHd4sZCheJia2utkmaNdhsAXRT65IglHNqOhFkMw98cGWS9w8SSftCsoGeCC7TMiczPEQW4dnbZXqmxsKULUXN2aAo83Qp1iGOCquQMJ1VLp1/AnC0XKBEwvV5+ATcgrv/izhNkEHei/v4VquwGRgYWTjMh2CWFEuGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PzdgkBfX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bDHcxHbR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PzdgkBfX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bDHcxHbR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AIwRxT3660031
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K5uRF4apvDG4n26t0qi0Zot/rx+YatnhGdz3MSqeY6s=; b=PzdgkBfX1N0CFsoG
	tItC9EhvBl4tPbr/T/Bq6Oi97AQY7PR9F1/kXyqSruc15myEyPzAir9iAT8PsXLH
	vajjS45lChNlppZDxEHsAkVJ8ZGD+gXbkQseRcOU0IchA+bRY+tqXk4qO+xkGTWN
	OijtkgFWsbJSHL76BDe7yTb5bO1wOs0B6sDBR91T5PS2cAG/6tyva/V0GwOPXVab
	pbQ9T7MRP9nLqM5fCr21nKczLRNbXtiINzIdOZM1lYYCz3xkpYCIMboeCc1USSb9
	Hdf6iEeB/Km4H0/rGt0l5PwttHoTD48tuos9iu5kHfROkm0lN18TUBcUi9nNy4F7
	XxMxxA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyhp8gw6g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:05:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso3415899a12.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786388737; x=1786993537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K5uRF4apvDG4n26t0qi0Zot/rx+YatnhGdz3MSqeY6s=;
        b=bDHcxHbR8d+WFSGyJuf14YpcFHwBC7u8gAkXzv7KEHjLkX5ZSz3+ubJ/GB21rDsjoY
         yOYJhJyLkq/p73DT1cpBe4E2XenFphdI21NuWuLWIWhwi+bQOlZyJr3bXmiFIjme38zP
         Tk47VQBcFLh0eKs/uesmHC3UtssNPI6cymAu8cr82SKGB7/D5PSkCkqK8bIlCl8GmNqu
         StBJHtHCTDeNgu1HNkDFYdvSQ0ODczOT0RJZZ47a6IASESHo7aUO67ayjDzYw8mBmtZ4
         VnBFxRSf26+3vw6ayddoSDXAg9bOgtJUihoJIdSFmewL3M+T+pPfLkaTPCh+ssQT/ATS
         a2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786388737; x=1786993537;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5uRF4apvDG4n26t0qi0Zot/rx+YatnhGdz3MSqeY6s=;
        b=c1hXYrmkt4sL4KMaS4Fq1eqdcV+ByOE7z0eVr14wNvn4kKI63OLEhNox+/nEttemD4
         NAjvNPnyL//VVhxyJYvALZr7FuOeT3YurA3iiHsTNnQ1KqgkbSKShIEL3kNZ+qMIPO86
         U6s4B3t/VPggLP5eLMbb3mrPtTVvI+iATNueACtbl0cHFE6DrK6z7PpjA7opEHtNU33P
         UymWni2utYfZn7oBKStgAuIO2TIcRrFvZBG3aFkGHDVL+puQAa6FzEcvB6q97Li9tYbt
         srdhNura/yOZ3T8YlrzNWkKl4KgYDjDwYvKyKB1q5uulxREHMAm9CpFyBHglom5xTp0w
         600Q==
X-Forwarded-Encrypted: i=1; AHgh+RoeCc94UYwufe6nQUFY9/ppfqC0RcAaDM68cMTjYvHsjbL+PbrpPFTIHr3MlAwx3JL4xYYpEYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJw1qLkrTDjTLrcMy6W1adUBd+c60JqalpJ8lFF+O22nhwZy2
	2oj1c0uf4NCQ08nzIJxuJm0DQXmA3EXoVQKnEhzUcLxCJUFVxJ1cT8SYhfGngMNx56Wg/7+S1Ga
	/JrY0vUbS4HSiDy+i3GyhOoxm7OH6lo2045MsLwQIwR/Ty8Fbf//gwdkDwwY=
X-Gm-Gg: AR+sD12JpcFVkB/p6CtOuNq0Z1Q/HEgS/o6nWTdwsF/5URzfiHL+fPsr15H6Q8KHCZC
	9/Gex6qAA1p5ArNjBc9EbmoCbXLJMwf3eTXaoEu/4glwVAD7ga4S1Sf3wtlZPBwGJlAZASKKkdG
	PsKukWaZ1m2H36JNQAsjcJXUpIdAbA0cS2aJC338mKzqh6E9VkxmZQ6ypTRn2DlOARX6cWvhYM4
	K9ivScT4AWdVnKS7UgQFm0oMRO4FDxYdMIxqmLOHzX2K3kTKv4te77w+9XGAkZpTJEB76dklVfX
	X+EXXVi7wjzS2obd75CakzMPm41bqAE5JM00I1RnM42T+3yRX3YdZ9HiFFOvdTK5FQHQc6hFJxv
	YW8wHSCSzes98lgAxcREyZL9Ny1pjT143uy+XSKpDDdch2PzixYd4hPKIWatH
X-Received: by 2002:a17:90b:4c8d:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-392cc9f4517mr3371863a91.10.1786388736447;
        Mon, 10 Aug 2026 12:05:36 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8d:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-392cc9f4517mr3371769a91.10.1786388735541;
        Mon, 10 Aug 2026 12:05:35 -0700 (PDT)
Received: from [192.168.1.20] (103.sub-97-215-187.myvzw.com. [97.215.187.103])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141018f18d6sm41432625c88.0.2026.08.10.12.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 12:05:34 -0700 (PDT)
Message-ID: <33165600-be3b-4faa-aef9-97c0b56e36de@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 12:05:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: run ahb shutdown() teardown only on
 WCN6750
To: =?UTF-8?Q?Andr=C3=A9_Valentin?= <avalentin@marcant.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Kalle Valo <kvalo@kernel.org>, stable@vger.kernel.org,
        Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
References: <20260807094858.1548216-1-avalentin@marcant.net>
 <20260808213551.4169863-1-avalentin@marcant.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260808213551.4169863-1-avalentin@marcant.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX1iTCUQBulbUx
 5P0ZUc+M6oHmBU0O3VlsVe4LoTxX5hoP/UZqZiaduSxEQmg/wVtBnd6VuUycqCb+OnwCI/dbbqH
 ukB+woHxpfmMC+0p5a3b5VyD/itoels=
X-Proofpoint-GUID: HhuW-Aty-DdJ3Wc7ucCjjGOXhkwPsNf4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX0eSCAhti1Zf8
 1W1AiBOm3g3iVHoYKiLPYt0n5QVGYvpRNh4AyABGpUH7V9d8Xpj1ccYybY5MV1zPW+IVEInxZXt
 ldV0DJ/hvJ1g+42hX8nKGnUbIFjOGbzPz9ZBvjSbkFeLaOaRvGyGwYIiXvfSGLTow3H9H+5MHSO
 JDyX70t3R0eqECW6Uf3iXG45GfGcyBTdW8dstPEpgYROFUnKedQVpyebgwdYz9JFG//p7t/xlIj
 Rik7O6BgJYVfCzWssgvz1WUv9JHF7UEJFh7NGAlMAcKo4H1HTNTfdKZW6M6dsDkoX8iCgDL/Zfd
 lOfoh9M1buO7T1g4W+zAGFFAVcNx4vEQU0B8CZO9wxabjy+NSGYNTHMW+huh5Dq3jGsSgw01bh8
 kCIG/aTstzD+fGndmghiYalKAwjmqMBeuXnjevGWWG433BAw1FSXj9r2QKm8afLOkpSCYFxAotv
 QmbYYDxCuyzo0dxdWFA==
X-Authority-Analysis: v=2.4 cv=RM+D2Yi+ c=1 sm=1 tr=0 ts=6a7a2101 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=UaEkX0D7FlC0tWE/LoNF7Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=7bAZdoCWAAAA:8 a=EUspDBNiAAAA:8 a=uQHCV-ZHde5g8KG_UQEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=7DsIbQzYVz3x35o7bboS:22
X-Proofpoint-ORIG-GUID: HhuW-Aty-DdJ3Wc7ucCjjGOXhkwPsNf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100162

On 8/8/2026 2:35 PM, André Valentin wrote:
> The AHB shutdown() callback was added solely for WCN6750, which must stop
> DMA before the SMMU is torn down at system reboot/shutdown. It was
> registered unconditionally in the shared
> ath11k_ahb_driver, so it also runs on the IPQ AHB targets (IPQ8074/
> IPQ6018/IPQ5018), which never had a shutdown() handler before and have no
> such SMMU requirement.
> 
> The commit message claimed the change "will not impact other AHB ath11k
> devices", but it does: on IPQ6018 the teardown stops the WCSS Q6 remote
> processor firmware, which leaves shared WCSS state such that the boot ROM
> hangs during DDR training on the following warm reset -- only a cold
> (power-on) reset recovers, so a plain reboot never comes back and needs a
> physical power cycle. This was pinned by bisecting the teardown: skipping
> ath11k_qmi_firmware_stop() (i.e. not stopping the Q6) is what lets the
> warm reset train DDR and boot normally, whereas none of the q6v5 power,
> reset or clock steps reproduce it on their own.
> 
> Restrict the shutdown() teardown to WCN6750 via hw_params, restoring the
> pre-regression behaviour for the IPQ AHB targets: they simply have no
> shutdown() teardown again, exactly as they did for years before that
> change, and on reboot/shutdown the SoC reset re-initializes the WCSS from
> scratch. WCN6750 keeps the teardown. Module removal (rmmod / remove()) is
> unchanged for all targets.
> 
> Verified on a MikroTik Chateau 5G R17 ax (IPQ6018): before, a plain
> reboot froze in the boot ROM during DDR training; after, it trains DDR
> and boots the kernel across repeated reboots.
> 
> Fixes: ac41c2b642b1 ("wifi: ath11k: Register shutdown handler for WCN6750")
> Cc: stable@vger.kernel.org
> Cc: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
> Signed-off-by: André Valentin <avalentin@marcant.net>
> ---
> Changes in v2 (per Jeff Johnson's review):
> - Drive the difference from hw_params instead of comparing ab->hw_rev in
>   ath11k_ahb_shutdown(): add shutdown_teardown, set only for WCN6750.
> - Frame it as restoring the pre-regression behaviour for the IPQ AHB
>   targets (no shutdown() teardown), rather than a per-SoC quirk.
> 
> v1: https://lore.kernel.org/linux-wireless/20260807094858.1548216-1-avalentin@marcant.net/
> 
>  drivers/net/wireless/ath/ath11k/ahb.c  | 11 +++++++++++
>  drivers/net/wireless/ath/ath11k/core.c |  1 +
>  drivers/net/wireless/ath/ath11k/hw.h   |  4 ++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index 1e1dea4..5d71ff4 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -1288,6 +1288,17 @@ static void ath11k_ahb_shutdown(struct platform_device *pdev)
>  	 * remove() is invoked during rmmod & shutdown() during
>  	 * system reboot/shutdown.
>  	 */
> +
> +	/* The teardown below is only needed on WCN6750 (stop DMA before the

1) incorrect block comment style, /* should be on a line by itself
(at one time networking had a different style, but no longer)

2) we avoid mentioning hardware in generic code. that is the whole point of
the hw_params. mention the feature not the specific hardware (since there may
be hw other than WCN6750 that have this behavior)

> +	 * SMMU is torn down). It was registered for all AHB targets, but on
> +	 * the IPQ SoCs it stops the WCSS Q6 firmware and leaves shared state
> +	 * that hangs the boot ROM during DDR training on the next warm reset;
> +	 * they never had a shutdown() teardown before and the SoC reset
> +	 * re-initializes the WCSS from scratch, so skip it there.
> +	 */
> +	if (!ab->hw_params.shutdown_teardown)
> +		return;
> +
>  	ath11k_ahb_remove_prepare(ab);
>  
>  	if (!(test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)))
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 8dacc87..c6df829 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -578,6 +578,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  	{
>  		.name = "wcn6750 hw1.0",
>  		.hw_rev = ATH11K_HW_WCN6750_HW10,
> +		.shutdown_teardown = true,

please add = false to all other records
we enforce explicitly initializing all members

>  		.fw = {
>  			.dir = "WCN6750/hw1.0",
>  			.board_size = 256 * 1024,
> diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
> index 4996536..8279eb4 100644
> --- a/drivers/net/wireless/ath/ath11k/hw.h
> +++ b/drivers/net/wireless/ath/ath11k/hw.h
> @@ -231,6 +231,10 @@ struct ath11k_hw_params {
>  	bool cfr_support;
>  	u32 cfr_num_stream_bufs;
>  	u32 cfr_stream_buf_size;
> +	/* run the ahb shutdown() teardown; only WCN6750 needs it, to stop

again wrong block comment style, and should not have an explicit chip
reference. describe the behavior, not which chipsets have that behavior.
only the hw_params initializer should establish the correlation of the
feature/behavior to the chipset

> +	 * DMA before the SMMU is torn down at reboot/shutdown
> +	 */
> +	bool shutdown_teardown;
>  };
>  
>  struct ath11k_hw_ops {
> 
> base-commit: f9a2394a23482bfd330911e9c8295b71724feacd

