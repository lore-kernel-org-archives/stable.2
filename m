Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C914B8DE3;
	Tue, 14 Jul 2026 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784046199; cv=fail; b=FNRZRsYhnkTNG8oHDR37+DIqt/Evon0B3ThHXoa7LnGzEEmjNZaAy5znwI5p2pCxrLc68kEPP3w3TdUEyaIqSYtnbJhwVVTBBEPH3hTRpkOJLFhkhlQWoB34sIzv0GlfbIb4fAxl/hHp5BhiSpKX9ZDCoLJZhaTb4rYiucsGHOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784046199; c=relaxed/simple;
	bh=1M2wJEyRjEYwfus1CKXXO3juC5sdNISBcVnYThUB9hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpwsSHUNcsu8qBJqZxfmUx/TG+GdHxRjZJdaDBxDUov0M+GLAW3GMVuKiv2PBjXClmC7ObSMm7IpOTYFqtxhkSoyNP79KRjlwY2JCNednL59XjJpv4s9xdlsKRa/5kcxhb0qZ4i5vZYlNO2UeehqOWQfxLVUEqVD6xTkehS+fUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CGfWanr9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=WmDrEI7R; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CGfWanr9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="WmDrEI7R"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E4J2pX3590165;
	Tue, 14 Jul 2026 11:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=R1/Rrv5RCyyCHOidMr67Vulsh4MZEoT4g1CDelDLQsg=; b=
	CGfWanr9E0zXtjuU6gLFSzNW1eawX1U0l6pdsEYBaAJaEw/6iOM3TvhJNJNscPbJ
	ztEI/HWFcuxhsRx/JKnQ/7LcxSZQgKes3IiI/ayjYpv/FT4z171OMdf60BTO4660
	OTeME5VuPPq/YK0lGC07FU+Axa2on15w/gZmteW3VMM68Vxu2ULMxkoanXOa9hzj
	w/WpPm1GoGTIw4JbIW6d6lHawbLyztwizGdCXL/mfs/hkSOMPyquCp8HQLAWmIKM
	Ehkt+/tNoYrR36JMbQRBAjMOu73FQsgdMJRz2ywW0s4et3ytuZ3PSQpldQomWbk+
	b4cbNlVzKHYq+3PpLWwcrw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020119.outbound.protection.outlook.com [52.101.46.119])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fbj8fm7t6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 11:23:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8pfeESQdUnCGAbanAREKhkLy/hyKIaoHeIi1U0y+7yg1FOOGYYPdxyyd9CjnuuNn0s3vSw5OqHSgGLFnDb2YIVNYPhJu/UYwLzeuj5NSYbJseJIsJScMkJ7By+Ifbbc/vuOKX4fK6GLre58RPdXSbV2ANw0rNOFLfktH9A8eGVmVkT/Ox/95i2KoDiao8jNKIP4k2/jFE4lyFjwP1tSbRBKiz0XnlTqTg3vZdnOgnv2W8s0/iPFQKCZhDpYT21kAogVOUXybIuxYzgBQbvAKaGJl0jXdIrXpEO1WAHNmpXnBLS8D62Kn3xwDsFhjArjPRft+9E497AO+iI3OiM5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1/Rrv5RCyyCHOidMr67Vulsh4MZEoT4g1CDelDLQsg=;
 b=Q8ws5GfsL9QyW7g/zlz2UdKcI0D0WR9lhZh4FN2R2pcobGA6ci3z/0LM3dMQpg7GQsaF9Vqlw6iA27GzpBdfpKv8ozrT9mRA2xbPP3CdAnpy4q1po2/eIXI4dqarTS0cZzi1x44ub9Q9eBzklaZePk2t46YTxn3ZDnh3atwfrmty19IrndRvkVWijTP+BDHQLPwXmOMi9tZDptFaZOGHpZR07qD8PhUi0J2g7EwTo725+i3eimta+u4CTxdDtBzi3fA7nahf2+vhxlU5TzY5GR8EGl4UH6z7FfLLdxkfXFtSnTnmUtgz7rkuJIY3t8Siw+O0ubCl0+bECNJne2Akdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=callumwong.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1/Rrv5RCyyCHOidMr67Vulsh4MZEoT4g1CDelDLQsg=;
 b=WmDrEI7RWQzvhsN1sVlGFucvheFOLiyUMSXpIrbG4Idi3aT7ejtDLq2l22BCLSeBiMnjDZOjA8oTMvwxGo96whe09kFa/sYqksenhxZRbLiN/Cu8VENhljb8QcuqQvuJ91gc/muB/oAbqMxjhzW1gqhQIjml2Cxc1HO9p7gvhQU=
Received: from SJ0PR03CA0208.namprd03.prod.outlook.com (2603:10b6:a03:2ef::33)
 by PH3PPF341685865.namprd19.prod.outlook.com (2603:10b6:518:1::c12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 16:23:00 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::6d) by SJ0PR03CA0208.outlook.office365.com
 (2603:10b6:a03:2ef::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 16:23:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Tue, 14 Jul 2026 16:22:59 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 77DAD406541;
	Tue, 14 Jul 2026 16:22:58 +0000 (UTC)
Received: from [198.61.68.151] (LONNCK4V044.ad.cirrus.com [198.61.68.151])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3A97F82025A;
	Tue, 14 Jul 2026 16:22:58 +0000 (UTC)
Message-ID: <3e90fe96-dac2-4e95-ae61-100f9121b96e@opensource.cirrus.com>
Date: Tue, 14 Jul 2026 17:22:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ALSA: hda: cs35l41: Support HP OmniBook 7 Laptop
 14-fr0xxx
To: Callum Wong <mail@callumwong.com>, tiwai@suse.com, perex@perex.cz
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        rf@opensource.cirrus.com, david.rhodes@cirrus.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260705142535.186028-1-mail@callumwong.com>
 <0108019f32ada4d0-8ff2c576-8eb9-4ac4-803e-8ff4e1ce57d3-000000@ap-southeast-2.amazonses.com>
Content-Language: en-US
From: Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <0108019f32ada4d0-8ff2c576-8eb9-4ac4-803e-8ff4e1ce57d3-000000@ap-southeast-2.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|PH3PPF341685865:EE_
X-MS-Office365-Filtering-Correlation-Id: f52d835c-dd0e-4c7b-becb-08dee1c42c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|61400799027|22082099003|16102099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	5GbedorBOedrI2fdSIUKpyaR9OSIEeeM0D9lPY3I2/PrZAmZzgosBZd16tfvRpmuIorifxk2tu2oa8R5o5jo/lo5YS6wVM9IPFjQN8FnZqk+gZa1mhnvnfYYSQw52S2nXIcrmCYf37sZbkwFj0ppZjbqnhhicRCqGP9nC+Ot6v9WMAnp7eJYv0xfKmK9514PuzkFt2cLwjCPbiBqma4GBZeB10jZaQ4CCoVKf+EnjM0sgIoHjcLNoYJ80bI/lDVAOwvdKIwp2j0vxrJ7Z9126n5CRclsAUcxS2czCg/5Dr1SV/Foufjn6hHsddiqzIOHlkmIpq0/Mwm4YsG+D5IrgNiKyheLJH7saXwJSztbzeGpnxLdFckU1cZRNgjU6E3RHc3/j1Fb2kmloG9CAE6Ksh5pv2aSauYGIAo1+d+HQ+Od7j/xNY7jNJbWdWNQab/+89/KwT5KjqnW8005PG1AOY05O2LUs1ScqB7NP4HmoVJ6cND0DwwqrsOwK+AiONWJz37bU2kzGR6lBzxCbJoWkAo/2dLEUOpBWvkjE5U5UA49vklhEoOEo/LW7T8vaoMrXT760iLBShhAZz4lu9ys+Mm0OwVO4xno1M5vXyqAcw96nyEgDpFLxbQxbaDs8+BvKYAQY8gLZHTFWx93dHsODf1Cp7zf5+FGeRyfkJtu29THOKUuWuWfddLF7sUrIbcKfxVJt+L+DYbjMZd4MyOH0A==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(61400799027)(22082099003)(16102099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n9rqI7XWu44rhtqqSuclVYBW69UN5RRdj5kdUosFRdH26Uuu2dGPbaganQNHqi1DuFWmIheZjyr5lKRIrHnav1sf6i/5tQdVP92QYhB2oT1mGlJBGJcjEuo1q6eOmigYtsGb1Er/coIueHxuzhPlcw0EYP+Za4zsS7kXGIo49/n8P6Xh9qET/68u2dyrRAhKOlZ2TwtCmd/kJ7nPp8i61HbeU6O2JvFcyfrNX6p7IwRQrwU9BYCvVArz64HAK8m+mCLhYIb6lGgrvoOPLl+4JgxjjzODd3MFawc4xz0Yn5/Me9u5D0xH99xFDj1tSkqpSwAmupEN31yqHAIMZ2d1TAINTI4zzbpxgHkcV8YViLnTo03zFn5rbe16WN33Kta1G96LHrYJpuOSqiZ0Nz0/eb0YejVQsDWlrSnbbcaF7XxZeB7q9D6iX1p27HBP3BCW
X-Exchange-RoutingPolicyChecked:
	hXIbpjt6LvTKd/9AYP475ts5DDcMxwaCNZIQlpIPKKbU8WGV6AEK8kfxJtHZJ+qIa0yx/NaHKaOs+I0ASEqOOPROyef092OYU3H3cB+p4geIXGtERwu6I8oliooWPSjQEBuk32Ve9YymGe9kfn5922X778+gmHb47a+h5m6h3qUWznZZp2xs3KDj9GCS5U3VGtg4kEmPfEgK716HArRLAWPjtrAFt4Ml/VO7SNoEHsFjcH/LAujEX4XhV8N9Z9Lc//g4N0wsy6F8WdmBXK4mRUNCq55Ky2X5NqGEFN7MhDqnP2tOOqDv6ScKO5ZcYlm3GzCDOF8RDEHMDLCR+Iqyfg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 16:22:59.8850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f52d835c-dd0e-4c7b-becb-08dee1c42c0d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF341685865
X-Proofpoint-GUID: kRjYEbVvsGChO-PrIsAvgHAIpI5qsgZU
X-Proofpoint-ORIG-GUID: kRjYEbVvsGChO-PrIsAvgHAIpI5qsgZU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3MCBTYWx0ZWRfX0D7+YKg2ysG/
 H9ZD1LKzgNtxutjVTegFYB19rFU/xUDwUZttaWNk9ieibtNCJjvBULem4dGYLWwaeK3yaa3jInJ
 DDj6Ukf0WV/V7K1pyllxIDGMyWcrP8k=
X-Authority-Analysis: v=2.4 cv=M7597Sws c=1 sm=1 tr=0 ts=6a56626c cx=c_pps
 a=dV5UnTNaioTBtvBhj0ZdMg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=cjmvyQrpAAAA:8 a=odvQGuxNvgiL9BEm7AUA:9 a=QEXdDO2ut3YA:10
 a=4T_fOvN0JJhqAbruqPar:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3MCBTYWx0ZWRfX79CuqoPHebHJ
 s22Os+n+V6W5n2Squb8p+bbjfD+T8SeJqerMlARMa06HG8diHJs6AqdHgH7+UKk54Ki7ZGdK5g6
 5bBlD63lH923b3qt8wfpHC4pIFJSfPfR2UQglLJ5K6E0MRMS72o2NYcIArtKPuk7ICNOiI6jaBY
 NRZ1VUZAV9/ESKaWc02rZ3Flva+HYm++9tgsZWZy8vCUwMdljkptAA/DEJChswyYhGk4wq1SIPe
 mpN3w0Hc4cySbh3wATG61HpyXU1fpsx5WVqOxzzkCEsZHYA2k/UCzXfiKXiaegCtYapyAdIv8yX
 +gwtGN7P54pOZo/nUWaBPe+d7jrVRH2XzzF+ud0/nPVFLRzNROPDACPk0GKXrollJNRqG/4OQms
 5y4sa2O2jLerrD0dTAvpbuogkWiCoNU0LZNQPwHv2mEqmViOzBkpWb4hnXfoKFSlhsWYnspyu0a
 j6LNtJhKhuNEnHn193g==
X-Proofpoint-Spam-Reason: safe

Hi,

I believe the _DSD for this laptop is very wrong, and the settings used here are not correct.

Unfortunately, it looks like several laptops have a similar issue, though we don't know exactly which ones.

Since this affects several laptops in a similar way, we will likely make a patch to support all of these laptops all at once, ensuring we use the correct settings.

Thanks,

Stefan

On 05/07/2026 15:27, Callum Wong wrote:
> The HP OmniBook 7 Laptop 14-fr0xxx (SSID 103C8E3B) has two CS35L41
> amplifiers connected over I2C. The firmware provides a _DSD, but as with
> the other HP laptops already handled by this driver the properties are
> not exposed to the generic ACPI path, so the amplifiers fail to probe
> with "Platform not supported" and the speakers only play at a much lower
> volume. Provide the configuration through cs35l41_hda_property.c
> instead, so the amplifiers probe and drive the speakers at full volume.
>
> The values are taken from the machine's _DSD. There are two amplifiers
> using internal boost (1000 nH, 4500 mA, 24 uF) with the speakers wired
> right/left, the reset line at _CRS GPIO index 0 and the speaker-id line
> at index 1.
>
> Fixes: 7150d57c370f ("ALSA: hda/realtek: Add support for HP Agusta using CS35L41 HDA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Callum Wong <mail@callumwong.com>
> ---
>  sound/hda/codecs/side-codecs/cs35l41_hda_property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> index 416d7bf3e289..1d2a83b47cde 100644
> --- a/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> +++ b/sound/hda/codecs/side-codecs/cs35l41_hda_property.c
> @@ -85,6 +85,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
>  	{ "103C8C51", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
>  	{ "103C8CDD", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
>  	{ "103C8CDE", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 3900, 24 },
> +	{ "103C8E3B", 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
>  	{ "104312AF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
>  	{ "10431433", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
>  	{ "10431463", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
> @@ -511,6 +512,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
>  	{ "CSC3551", "103C8C6A", hp_i2c_int_2amp_dual_spkid },
>  	{ "CSC3551", "103C8CDD", generic_dsd_config },
>  	{ "CSC3551", "103C8CDE", generic_dsd_config },
> +	{ "CSC3551", "103C8E3B", generic_dsd_config },
>  	{ "CSC3551", "104312AF", generic_dsd_config },
>  	{ "CSC3551", "10431433", generic_dsd_config },
>  	{ "CSC3551", "10431463", generic_dsd_config },
