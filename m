Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CF4FD293;
	Fri, 18 Sep 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743978; cv=fail; b=PpYPa5cB+Ie9KvlXPvB6a1Cb8qyhEhh5aeKWIpgHjR0o59VHQ3udLe/+dm+ZqShL52BjwCdHSzYV8wcD8ogTXm1kvMHdvjS7ue/su8wX5c93IBdvlTDbvRjlTyP5b8GY0vKXog7WV55kWSFX4t4/ZZcdz4SsXO/bYbL6NxuLpMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743978; c=relaxed/simple;
	bh=AfE4uyiV86W4Y0DZ28TOdTyase10/iXMDWz//Pqddyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na90sWdJW/aJsJZQl7SeolxvEZA3IAC2hYN+IO/zHbJA3Elbisd8SgtCNzv+08xNZXS3npdMo6UP3gaqkhVfRoTxXQf7PZhw/N7qejPCb12RgBNoLCJ1wYRdvwwWpnujgAGbZsAjEukSKAXz2/u2syf2iMf+PPoLv8XL6oH16NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=c9MSrzSW; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=eiTa96ge; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="c9MSrzSW";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="eiTa96ge"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IEDlHh2648389;
	Fri, 18 Sep 2026 10:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=NJEL/1Z/3xzstJqmCg
	51Oz504KwU8j7hxFtHOMB9mzE=; b=c9MSrzSWKStGrIVqX8SUWqMcqRmGSOSIV8
	EZJCwB+tQ0yB0ZPQXw4d5yutR7Yjdh9cnlatIyej/puT88Am3gl/d5fuRrrijwLF
	gQ/dvY+8adty9oz0uiKX1ZTbMfsomFTqEjFo/6JRJx7WjnssUBDz2btWS3VkEfxo
	bJ7QnbeCCRJ4JGVJsVGQjTIMt9aO6y3kH7nCW6phqmNwzG4b8bKpY4GQ+7voJ8Iq
	2pQ9IVeG2RDpRipTkYh96dyp3/h48S8371ki9dhxC91C7kVVJlx+XP1Ijw7EMX9g
	nPfQ2NX7xUgNO0IFLWK1h5/dRXYv6LhpJaN6bclSC4N/M7BfbaDA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020085.outbound.protection.outlook.com [52.101.201.85])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gs6vmr38e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 10:06:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UacnIysRI83E/YU7F5UVxxgBQbY0tbg810YHY0LBRaImwOZhwOZYVLYURVndEqC6XR5p6VsD40p/0cOv3/juPRtkMV+5jWQktJFdyljn3SqQF3CZLIxWO2cMGuhgcSu/DZKF8gqN6+FYAs25AE6SnS5SEoPEkGH3I978XzM3OAfnn9D2+oGjbcnOKxkgACi4B/3G7am4o+xrXdb/BvNa/N3JnCdPzAP1GgS5yFJ3bpCzew3mexWw4xaRthUwvOfR4ZZ8EXx1ki8WrdIRnwpcfm1d7h40xHFkuGllGc2BjDfyokR4/wZLF7UdK/gkqnUsQTGLEnUfQJx5ppGMj+TIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJEL/1Z/3xzstJqmCg51Oz504KwU8j7hxFtHOMB9mzE=;
 b=VDuIj9mrFPcRL3jWxplKdKXAK6AYVNmu6PDi9lgkiVFfn9H5BMAFP05k11L6J6yqxy23tKVE5TnD02cNzR/qhxmnz6/KP0VvYSnTdiJEtA6acIoKWRz1EvOtnJVpp+aNK4b3Aa3SK0FFQrzpWwt3UUTkG8fGNsvhZ3gVzIRu+Bf7mBhAExeiIK/p31NqFceMafRS1zRuwJ4aO19RWCN5S/id4pI7kOd95tvFR37Y+wnY5DDNs5eiEbY9p7tRya+xh0N7t8M0C9glCQdIfFvptnIAUZYX6aA85r/cKKu9hT28/13x4KShr6di2ZfrxX4Xkc35H9OzKc25hV67oPP13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJEL/1Z/3xzstJqmCg51Oz504KwU8j7hxFtHOMB9mzE=;
 b=eiTa96gebE7DmO/DqfZQ8ydz37B4yD0H00L45DEcd1Doeih6llVf59HSHQwIml/3dTOKVxcfF0np7R3PbIoeEhyjyzJRKGc1HMynjPB8l7XH1i3suW2Lqoez58zO7JL2IDnNaSOLdrdqUzzua9m9fTVacxadxRl4Z+cScudQN1g=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by IA4PR19MB9187.namprd19.prod.outlook.com (2603:10b6:208:555::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:05:56 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::64) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Fri,
 18 Sep 2026 15:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 15:05:54 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id AEE06406543;
	Fri, 18 Sep 2026 15:05:53 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 9860382254B;
	Fri, 18 Sep 2026 15:05:53 +0000 (UTC)
Date: Fri, 18 Sep 2026 16:05:52 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: broonie@kernel.org, cw00.choi@samsung.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: arizona-jack: Fix runtime PM leak in
 arizona_start_mic()
Message-ID: <aq1TUA77ukvvBjso@opensource.cirrus.com>
References: <20260917164625.2163097-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917164625.2163097-1-vulab@iscas.ac.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|IA4PR19MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 115670a8-025c-4d31-8e97-08df1596564d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|61400799027|376014|36860700016|82310400026|6133799003|56012099006|11063799006|16102099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8a+zE9c+Oy+J/NYUEUCDkGaMPw5dPHxFNHkIySTJsBQE1SdUewPbFlQWZ5yei5tK9x3wkeRnaWu3ggsnrqXZlvKcvMnLHGtA1xMqfqAjAjG8jxh3DCyp0cyBOTNXPxcz2zrD0W68kVM0wRaj+KO4KKs49AqzCltSHo/n7MV1ZMprTpo2Tmsx2xdp1OCKnM10lgxa6kzxHBKsNRc1+SAvjgBbXIUlhEf9+UsOOhywBwEcPMWfF93eUlZQKzIOALFGDihIvLbKRnjQERo530s4D/0J+4xFY4Bqi1CrqFGCm9Yxow0NKOhpocD63bVncntbi1S8vLT/BO3OfR9NHq0QC6w2jvFVF2O4UNB8/Mqdp/PC2vhoqIhxehASk+puC8KTmflciczR9ki4inRoQ8ALWbH4Evs62Alzmf/U4LMXbGJ3zkfMAjlN9kxpSxs6CYrnbpXD0Xm4Y4uEPUjDHbrgscgSjmtbDdpBznSB4XFZBEYxMSHuAe7jRfzVWD4wfWTRCBP05urFiOvzqLIVKLV6eRR820oy69tupXUCV2bvJSfpVLH4156ecNi+0K3nhclVluHzza2Z85gZhr8c1AwFoHjRyKHW6pcmFFe3KB9S/Bv/cCUg/FpscnjTSCHEcolDD5ad4x21uwf8K/33ZfadHw0WEtIgVHYRGfqFyCCDHr64H663r3mELzgzDgxMu0X9Hr4N3Mmn6nfdfBIoMiTBGw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(61400799027)(376014)(36860700016)(82310400026)(6133799003)(56012099006)(11063799006)(16102099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R5+S77/CzitwbkKo4lwyXCUVw8TZrDJu0wfSOhgBLuB09QyKmWrsME2tpm0+UAVVnwdCCYzinAvOtzrvdmjHFAmjsIQyBmcAFAjd3OcvONhZhM0bVPymMzxwTLjxh9hphQVpCRTpfLJ8Xjby4R4/S+qbKtV7A3l5NKZtUyDUvTr6SdJH+A5+WcXDDk2K2exCj4f3Xkdj3YWpYxWXvsvNrJSe022uOYKXxf78SGX2UwYVkkCW/JhOyb7m7ZwvDZ0IGV+t50Lq5mFSFCbRXDsBDg76IL3asjrSJQSlAQaB+vysmVv8/3f5ToW/64bobls0YnaCnlZlUh5Bn5IPwQjriPgcZHtqqXmEfCeDig8Ue9iu65wXmNasBHoplayXmzmZip6xJ20ic8HUByt4uHyZG0A/twTI2ObJj6Ai0smCTiTLLcS59pEdc/NEWCoB3ZHs
X-Exchange-RoutingPolicyChecked:
	gXtdKX5rllQFFXvcFX2U4Xg4vq90O8tmUNQMhyWByJPVRvE5auL/lZqJaurB0IySpw5NxanPZfDpyMAV0sgcdwsb35mo4U8BXYYDpZzSR+wUuc5l40s3aHGjNqSk9rs4rkMAnJ7dq02pdNmpqtTvwNdYpv+4d/orDLe+9cVOrKH9mQBxwV9jInjNKol5mlezGwVFAyEJir2UsjIueFL85XAX0paItFxuaDVEXXZvXdhmYLVQ75A3fgB4gLPQeAAdcYDYNgG8AtRX4Buec3DXkHUPAZWMypLF2mEKJgW6Lu0aeNVmZ5uk48o4NvWYRPyUEU6Hyp831lzWltaIhzRxOw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:05:54.4984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115670a8-025c-4d31-8e97-08df1596564d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR19MB9187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNSBTYWx0ZWRfX0KS0pdDJdk4J
 smqYSL+/+VjHW2Vj0h+T4UpWYtbYJ9EfwdZeCjpBUDPA7g+5T1H+TW0KnAu1VnHxY0ajJMRyNuQ
 v8Pif5+1W9jRUXoZ5yrPDzT9K1BtSXKCcjwkV3rd1SqtIbAVr7xs0yUcUat0SEx6jx0C2YS0Lxm
 CLkl7nNgloKcD02fzctufikU1zfZTMs8ArqYsItVJo1DJ6bmbm3RrFNCsDUnkDDQD3TISk4p+i7
 RSsZce3Ydsz+O0IFatxgANnbtZdb9jCrYEPSTnl6uAQkAaQK3RcIAf3UHnFc3V59Ob+LUDifgDx
 oa8hp8FDY9m/cyckiQDW0Y890Hc5F3vEv6s88TZSs1SGTGSIOyl3e7cxL8wzegrrCAaTDa7AoaV
 S8fPUmYuk/hOFSOS2AGiypdalPxguN7+Na4bvG2AlDKJNezJIvN+0ojUxvJTYGs63Kcmi4Nzmir
 9sKqZuS4r68OxjgfXog==
X-Authority-Analysis: v=2.4 cv=YawodARf c=1 sm=1 tr=0 ts=6aad5359 cx=c_pps
 a=H3Na7JgWheL2EZIWx/c7UQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=zDXvEM9X1j2yfY_268AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNSBTYWx0ZWRfX9OCJH6HZ0qoS
 oFe3Ud35SPqh+klszgLjW6cJWsrM6ToND4rqTxr58vzhtSJd/UJMGQXGyRISIEYR+vpNKGuE41w
 kQ0S3BqdPewUy9GyItnnBBRHpianUlo=
X-Proofpoint-GUID: a8OUJPaYiGUSIiXQXVNr24aBr6SMuEbf
X-Proofpoint-ORIG-GUID: a8OUJPaYiGUSIiXQXVNr24aBr6SMuEbf
X-Proofpoint-Spam-Reason: safe

On Thu, Sep 17, 2026 at 04:46:25PM +0000, Wentao Liang wrote:
> arizona_start_mic() takes a runtime PM reference before enabling mic
> detection, but the error path taken when regmap_update_bits_check()
> fails returns without releasing it, since pm_runtime_put_autosuspend()
> is only called in the !change branch. This leaks a runtime PM reference
> whenever the register write fails.
> 
> Release the reference on the error path as well.
> 
> Fixes: fbdc60b2a787 ("extcon: arizona: Correct error handling on regmap_update_bits_check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  sound/soc/codecs/arizona-jack.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/arizona-jack.c b/sound/soc/codecs/arizona-jack.c
> index a9063bac2752..09a100846fdb 100644
> --- a/sound/soc/codecs/arizona-jack.c
> +++ b/sound/soc/codecs/arizona-jack.c
> @@ -274,6 +274,7 @@ static void arizona_start_mic(struct arizona_priv *info)
>  				       &change);
>  	if (ret < 0) {
>  		dev_err(arizona->dev, "Failed to enable micd: %d\n", ret);
> +		pm_runtime_put_autosuspend(arizona->dev);

Not sure this one makes sense. The current approach appears to be
leave the mic stuff going and just log the error. If we wanted to
drop the runtime reference here there would be more teardown to
add, such as disabling the regulator. However, the micdet ena
failing likely means the buttons don't work on the headset, but
the mic record is probably still be working.

In general be a little careful with fixing these quite complex
processes this and the one from the other day on the
hpdet_acc_id() are scary things to be tweaking especially if
these issues are being spotted by some sort of AI/automated
tooling, and not tested on actual hardware.

Thanks,
Charles
