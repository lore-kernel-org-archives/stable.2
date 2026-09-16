Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C33D4BD782;
	Wed, 16 Sep 2026 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552830; cv=fail; b=pWnMN/DXU2m9fBs8hBUWqkVEPdp6V5QybdCklq9u5U07waMsUzn7B49DVxHie929jzR609HEukkePBbXKuJNyuQQYOQ+sJ7QyDSBPsx+9/Sfpuig3YFXKrOxg7TVw0EG1JkVAmzq+KLCXhobOHHjMW8GKx2k4PRbbFh+H2kYOBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552830; c=relaxed/simple;
	bh=abNFsWkUgFBvkRwqwUUSCoIhW4WdXycCyvCPMswfaS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgK2thJmAZmieb+rrpqPdziJTjVKsW+H6NsHl0hwg3ZrEvyB849HnKIV+uLXfrXJrXYTGUGyhzV2bQYMyJOP6YpX+8+S+6rvyykJQ+IIsS9XVkYJOaGor1wfSiKvnCpqoRCGDNfOfWm8STAceyjE+ZzijfHdZzK7hO0ECy6vUH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MNtB6Xfv; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=qPr09q+Q; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MNtB6Xfv";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="qPr09q+Q"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G4E8wU1312893;
	Wed, 16 Sep 2026 04:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=TlEku6RErKv0IJKbIv
	yTjNz1rEI+M7gxyXXg+7IEsyY=; b=MNtB6XfvdYoKphCXweBMM29nKWofW7Bkni
	papwYGgqafFY3L42yN6Pb+z67qvAK0tMWEWkubv8Ps8L0Rcq41HdBcSJdVW7za0x
	1PAL8JQ41v+k5LEa1y5tbnDdvOb7l4M/IeB4off123buMPpbDPGtFUCUfm/P7rZR
	5Irz561/MxHzsSCuipTEzy2rpJXZJSGEUbTlHZOifRlbfMyOP8QlzUj8vWgbNjt0
	KukZV7+mXwKeAol6pzYVTqBxskq8pHUwFMavMvFM8ffHzY/+tz8nYDENppwPBiZ6
	XaKflIrvJY8LOhDo50U66Kjf4NneviCiyArXKcfsbBQKq8GoLRdw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020072.outbound.protection.outlook.com [40.93.198.72])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gn44wcwf3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 04:59:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+d6qIjnR2YMMGqLiVCjR9qcKDv9aov6+NkFTB5HZhsibzlllegwNAoDqlcz9jNl66fzH7bjh50i+LIWrEByEmFlWYtiqAGuBjupOcmugeB5GVyas/WicosI+M7Wg/RtQrRkvyYOY+U+gpgbUJCR2Wj2RYdxxu+kDCjo+DS4kyl5SABR345Fqbo56qJuXSP3HicZb7dkJ0PwIzzxg51ldPq34PENkVjTfjPnCuPKPRqPxQiiwDX0m2Eyq0RmUjz2xS0axCv43nVjAd6xXW+8cBhk6D+vB83wCBZIfyVDh67ySaAPLMVNFXTllhno+AYoN1cL6FboybV0TAn+7ECgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlEku6RErKv0IJKbIvyTjNz1rEI+M7gxyXXg+7IEsyY=;
 b=aIvQkyAv6Bdzk+CG4b4Bp+skYbU6YwHDjK/QDXNCKPi1fxj+0foh4U9CM6PVeCaolvrqwyQEcl363aPT5378PBV6lR4mLf9wV4F+xJoK3Bb7goP6zIgPnqJcRwZrpB/2PI+Yh2Qify+VMqOhxyvaaRvg6EAoq9+6L0pmJgYAbrhr0Xxvjmhp4bSdJgSDaBv0DZQZtonIEEHJM1spxtByfsTEshFGawAN+lD+On3nDFTbGGAspjCNCbD/KSQyoZQUxIPH3cAh8+aiS8n9yf5R6OTcoEg8gyfxNZzTlManCihIHR518WZQ4HcrVuhH13pXVkCMwvLr89CTCodxXhuE6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlEku6RErKv0IJKbIvyTjNz1rEI+M7gxyXXg+7IEsyY=;
 b=qPr09q+Q591aJtWX9fBR9udI5sQThLEzz6VzjLm9hRcClUSe/eHrWJvqVpVTYJ36levkdb9M9QUfVPd+6rHXS0zrWvoX3mVhqfGwu/7S96DdM58tcGRErTdXiaNRzFgY+FNjmQFA14cFNHQyMhwzSH3V7FMA66kEZjuAa/porNQ=
Received: from BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::15)
 by CO1PR19MB4950.namprd19.prod.outlook.com (2603:10b6:303:f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 09:59:49 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::76) by BY1P220CA0004.outlook.office365.com
 (2603:10b6:a03:59d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Wed,
 16 Sep 2026 09:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 09:59:48 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0FA66406542;
	Wed, 16 Sep 2026 09:59:47 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E1CB0820247;
	Wed, 16 Sep 2026 09:59:46 +0000 (UTC)
Date: Wed, 16 Sep 2026 10:59:45 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        perex@perex.cz, tiwai@suse.com, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: arizona-jack: Fix runtime PM imbalance in
 arizona_start_hpdet_acc_id()
Message-ID: <aqpokSCAdacoqu1M@opensource.cirrus.com>
References: <20260916072900.1971595-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916072900.1971595-1-vulab@iscas.ac.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|CO1PR19MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a7ae7c-ff6f-4742-b0c4-08df13d93ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|61400799027|36860700016|82310400026|16102099003|18002099003|10067099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ruKm9mEeVnuEaK4z1qqzcMbzLB+c5pPjLYWjniS4JJo/UWoopXJSfEN4ot1JTzRluP183Ft1jL8f6UTe0p/xbhgl5Z2HUwT+NScWUCgk8ywp5lLI7urFhI3j3W5KeWIfpK/yV8s1Lg1wOBuWER3FsRIxRx7phHdnRAJOfLQMAbRjBNLPBbj+riW7aYeGerpOauNa1Iy11ETvfTC7t4TYoOdPlSbGTH4lh2rhjJfFF8K9lfAGOl9PSwEH9QCZY7bZa3Fon1/aVDpXGYr9z8bSy1HyhI/DDFBE0YT0+w25YCh1Ku4O/XsyTjA+rbTzzUpWbGvn17ziwCO5FMOq9cjvAlnxKn0DnNMIW0zkl/o3kNHBP+kljmWP+U7+Ponwx7lYjbLCGNw0B5GT3gG4LIa/uzyCwA3ZTQ/VSx/EXzumH0MmZM2KMTJHKGFHqZje/b5YrLbdnqUEltY1ZgT+GFrk4eWyiDnZDa0ltyiOfbDwCdmLX+b3vmwmiFwCEYLKgfq7sVJCJ5fECo+1LLPTvTGsoO2iME4jKHItKmivMRJ070x+1aiz4942JvP6yV3dYoKI3JHm/zyjYmVURTURxIbKWDIbPgBnCE7hHHfl1iLvFjq05JHB/APYD5F5c1By1LWJmHrbL0GNTHYf+FbdjEqzJ9rAV14GIM8t7NG5WRjfyyr/MGy4GoyjueR09XMbDk6TSDrKlmpqAAC3b31Pf5i7fA==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(61400799027)(36860700016)(82310400026)(16102099003)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Whj26qaF9vPc5vwKU4zkqsKG3Z0w+djBpJCPp69XrwbqrP0N/wrfHUdiSZKOt9A8xtIgnglvrku/PSxqufOw/M4EkmP7O8OMy/9lkawY2wjDyEv2/dEWG0j1EJ5h/ON/mBiInYxPCBl8YLAOa7DmyvmARjIpB7pzMG1JPkHGfbO1HYEMLShxzjgUqoGTwyvScHfTUiUdPvUB7HhD0J+nUv3c8s50hwjGKLJUvdrsVG9nZqKdupLWGz+lp3unTOxpUaSoIMWTRwLBU3rfxknjdoRJ2xcZApmFumOYqF4GC2o56lM+txZQJK2wEdixbZlsu5Fd+aU1iufR/7QfLjTq0el23RJDh3kZ25Eh+Ykhv75iJueQPvY4xg0In5b2rs+iwOI2MpSGAolAt8Ay8iFYyikdNZ9fLJjToTL8lzPqdnfsRiKpP07bnAMt0wShBmB
X-Exchange-RoutingPolicyChecked:
	Nbje+uOhEu7kk4i6xxHSy0gglu8/XLCui+uc+zPjtj+liiYNOs6KgbmZRuOs89Mpr66aKaILo2tOAybvuRl5RwO8G5xWPzgOiRmUek+Kx443Bda0OMezf+OfCt8oTSbGofZiukd3/nezvQItm2rpEWr+TDuQY8mVIZsPndiwOYHI8dCYFqR7Yulk5S46eDPBHIWrqaLaPJioaHsrbKrMrScXGRLv/4AksjLefPyosjJXB8qW3D7x3z5VDOSd5t+JYHTNGBXwaNiEkQfDFgYKwcFStwlZJLrIs1i/9MzVAi1kIdzgGBQQ3k99nIwqyQ9ARyCPWTdMGbqdGMIFYGee2w==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 09:59:48.9100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a7ae7c-ff6f-4742-b0c4-08df13d93ecc
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB4950
X-Authority-Analysis: v=2.4 cv=A+T5rKWG c=1 sm=1 tr=0 ts=6aaa6899 cx=c_pps
 a=0/0ATQE1JRcUx1QjezCFVg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=OxS163MFxOWdaxgKenAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEyOSBTYWx0ZWRfXxhf3/1sfUq1X
 OrzDhySZe4GpLflYwNw8VXVnRV9hsrLwLldeGZkVN9SRgAY6PwfDMPvxgzdSGZMV+ZQ1/or3xUH
 NH8ILXUN4XMjC+EWzzB8b7TsHcTrDJrDTnlBt/Z7WQeaN7QIBYjH6FyBztkHCn5APcN73/WjM3J
 uYgkuXBt8vlMaraV5L5h6p8dCYz+uNa1JJJu6jt0BbpwdCuK+jQ+vKQITuoQ6z8xR1sIqLfuS21
 VFnUnTofsVM7zr5ZljOvf1jkqX9zvDHHLbW6ut1udtkot9N2WNEUHAzx30SVwifKDp5yJG5FfT3
 T4wQXgNPtvQH+SGlNDQyjZ6Wrqlb50sz+/dD8Qx0vZFlU5zVmZF/ZzQx75hkC0NRa/OKSqv4CPI
 JPJuMNWaaaK80wemmmZPYvJ7zhBryzvroHGPPquR5zscEvngMAPqBKzQYVjuQn7pOzmf3kCHS6g
 z+4z+TgBfDkUzKNTF3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEyOSBTYWx0ZWRfXxzo35CKm0/9P
 rRyaI7/832X+ECAMS5x05uul1fkXv6ojgFza8iYjkwGgHFCmz8m3+3ukKM6+GbLdV4hDf8b5OF9
 J/nd3lDCynal28Sf9ZDKN/Ux17JHWko=
X-Proofpoint-ORIG-GUID: xtcD0vmUbiXjtUFO7d7r2035GXv_XEhP
X-Proofpoint-GUID: xtcD0vmUbiXjtUFO7d7r2035GXv_XEhP
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 16, 2026 at 07:29:00AM +0000, Wentao Liang wrote:
> In arizona_start_hpdet_acc_id(), pm_runtime_get_sync() is called to keep
> the device powered during headphone detection. If setting the HPDET mode
> or starting the measurement fails and the function jumps to err,
> pm_runtime_put_autosuspend() was not called while info->hpdet_active was
> set to false, resulting in a runtime PM usage count leak.
> 
> Add pm_runtime_put_autosuspend() in the err error path to keep runtime PM
> balanced.
> 
> Fixes: 9dd5e53d9d2f ("extcon: arizona: Retry HPDET identification for high impedance")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  sound/soc/codecs/arizona-jack.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/arizona-jack.c b/sound/soc/codecs/arizona-jack.c
> index a9063bac2752..c84e4961655f 100644
> --- a/sound/soc/codecs/arizona-jack.c
> +++ b/sound/soc/codecs/arizona-jack.c
> @@ -698,6 +698,7 @@ static void arizona_start_hpdet_acc_id(struct arizona_priv *info)
>  	snd_soc_jack_report(info->jack, SND_JACK_HEADPHONE,
>  			    SND_JACK_LINEOUT | SND_JACK_HEADPHONE);
>  
> +	pm_runtime_put_autosuspend(arizona->dev);
>  	info->hpdet_active = false;
>  }

Code is quite complex here but I think this looks good to me:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
