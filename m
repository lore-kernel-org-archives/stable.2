Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F033E49C0;
	Tue,  6 Oct 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283508; cv=fail; b=o4lCWSWPWcNa1lZDu+wU2pLnrg8tQKz9G/HLtsxiCT72QEuZyWWfy1cfaGcwSKsGH2qgzjE7lmpIXDoBQpNc176GaD7cjTyfhEU+/sTzaZ6o+/ecFmGi7WC5ugJb670VJlezkS5k8Ad/eOE2rRMQe1YFAPPSovAcbz67WLb66eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283508; c=relaxed/simple;
	bh=XIohklggiPbJYiapBBVtiiGPjOyWekNkx2A2AYXcX6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ9oBZ73jBbS2dn4ieDCiqx+Hg/53IhvK70qQL4JctNkadYyiYIEg9laNbHBDwuZ3ywkeFAquS6qg6TzJ/rS2sVVmsBBDkmbzWrNsIChaQT7KU87YX0s8MF1+czdXnj9FNGgWWt8l8n7tFrrptxBd7JpCgVena6rRSCH/BnZ+u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=mRvuwAkF; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="mRvuwAkF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IutqDVYUKtWKjikPbsXn02I9cUkyc1A5iqcpB846XxQHmrNTRNUSOrMn88vfHGYH7EaYEnQaILAXN+da31ZEonr0Ioh0OnVcpDMed2PhuOllClmhtAVTFMdjiMugh14h9vk5+/0UanZScidx0YuQEwtflQVzEjz7Lxzy4szAQrX2lYX5BHgp+9TbtkZR4qJC5yvHndc3byqk2TvHw8/aW0JuVCqORoiFxml0ZXDsiZtruEBpuo833U3iPYRCh0UZUwrtjadm5RGUAfo19+25eff/4QUtANM4Zt3PnO6KNkcrr3NrmQbBfwCha4TTNKh0gx7I62wD0Hq4H5Omp84HkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiwQTIRJ3XkIz6//JAsVmsRphAzJRCsXm3qcWbIGvAQ=;
 b=HYkV3+2wzrLGTklC4rlcSb59fAhXedfqoNUBKeCHob+hFYUtEJZ4szNuKOjbnzDSxINukj5CJyqHAEVwZI1UNk1fPTG5ITx4W7XTsmSsQeEJ78dORJXYZyICyTq3miiH5RYRR+9Y6KfwHNn6YmiurHImhYe0Nw+rCQPPIgXKsoVahdahOieTcz8AzziXtqUWp4UGlVTO1Nr71KEyasTt82/6TPlbrDQBcakPG/JBaCw/bMiyzmVtBDChWivpjRELS+1FtPf+AHDmUa/lyaTBGGM+1E3BmPp+pMEqIHix72R/xoQb67iUG4j8WyLhHXO61d9BY0XkhH2FThnuZMyG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiwQTIRJ3XkIz6//JAsVmsRphAzJRCsXm3qcWbIGvAQ=;
 b=mRvuwAkFeVRYScsPgWq44v3kQTIwCeb8vcSU8dmYa7B52eNZb6WeXI0jqTn/xNBbe4RIg0X0ajLZ41mHuQNbOKJ3NcMzyorDKA13Sy2rfVOJD7e7opItnbhYncGQCLf+fu/SmpqvO7N/yHnMHLXVYb4zl58K4/EAHPadkYGdS0p5I7yXdxfSm43iD/QW+sG+R7SzxCszvbR8QDdOOPdv0u7C+OGibt1KWZXxy20vz5HrRq58AhTmisVjCfWjvRs8FctaMVakVtDK42Bxl4+Z1bp+voXeOwFJ17PPMczSFsx7f/02dd82x8zfTnC42/KR/hfGOJ6S5LiYT38JL5kSpQ==
Received: from CH0PR03CA0099.namprd03.prod.outlook.com (2603:10b6:610:cd::14)
 by LV1PR22MB6016.namprd22.prod.outlook.com (2603:10b6:408:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 10:45:01 +0000
Received: from BL6PEPF0006C3DF.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::8a) by CH0PR03CA0099.outlook.office365.com
 (2603:10b6:610:cd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 10:45:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 165.85.157.49) smtp.mailfrom=gehealthcare.com; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 BL6PEPF0006C3DF.mail.protection.outlook.com (10.167.249.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 10:45:01 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id E1ABD1A2D0;
	Tue,  6 Oct 2026 13:44:58 +0300 (EEST)
Date: Tue, 6 Oct 2026 13:44:58 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>, stable@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ian.ray@gehealthcare.com
Subject: Re: [PATCH] mmc: core: Don't program invalid host driver type for
 fixed eMMC type
Message-ID: <asTRKmmNKIyGw_PO@zeus>
References: <20260926122908.866-1-ian.ray@gehealthcare.com>
 <CAPx+jO-59V8bg+DB4pOqEmdPZrfLi098YsyzkBRnf2Krb7ufVA@mail.gmail.com>
 <791c00cf-4f25-423c-b2f3-4cdc2d2c4a2b@intel.com>
 <ar5-udUwk8JeB-ut@zeus>
 <ae9b702d-6a19-4f97-8117-b6626e69cc9d@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae9b702d-6a19-4f97-8117-b6626e69cc9d@intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DF:EE_|LV1PR22MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eff6059-a741-41fb-847e-08df2396dfb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	AW4qiv0+ZWY02X5d3/e3lTDe+c3V6JkBMCfBPWbyjSfrlmFuzX61peaFUsJhcF0aRypZbfvznTx2esMrBhQcPHeSGmLF/Hh6hivffZWkRfcGnG1OD0fqApzWCiZz/h/OMHjxNRpPGCn8VNWe0w7xG21HO9mNS/2Ti2iwNS8dQK+3l2rK65wtdCgrAkhxKoZILETyhDG65+iyyNQGwqQWgCpjjCGoT0VH5P/rZsVqZdxOkfsFi26tIvZ4tuWVibkF1OtSymmOHnP9mcqzAc530wFEX1YEnZF0squ3ndhXU1uLe5sajlbz7gIiIGhMusigD/RWwWJi0zyydG6TtV4pmZcHJbRBQOjkm7/Qd7jZdlrWcbmTMhpMG4q5xW1Tazm07yN5mC6LJOTmVIpTHgfReLQsGPglxeQ8T84B5Eknv6GAj9AdZ4LFagkDisZ0AftqV2Bq9D31Ia9bMsN4cwVWKoe8vRN6MaOcaWf8+JidtzYxLMV8L+NbA5/8pp7DuP0r07KvX2ldMGxX2HWOC6AISbsJPl3HoATOcxj4v9CcaCc3H6balurv56XKeg5U5VqxOTmDKvrh5kz1w0IqZttlN1CXuYvLnR3s3NWl4BYtXaF+/WRdnS8mpPLJdFz2HhxeBDcxeDiBAH3l1dq3JnMxTRSnzNg7j5qSLY69Si0N9jpmzBOn78kU11fNSa/cosUGMXFMl6MfwGlpp5061fdS4Q==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MWGRjGtjgB/HDY49hUvYwOG3SAxX2rBOX2geBofiFpPvVyPMdz4J/EX67Iul3BxZ92ljRhMrDrbIgNPsAImzNWq9CfiLL1WUvsyZpFVSxD8Gxh+zY842ueII03Pl6FgZi2TaIcvm0VNl1BzvyBGLV5rZeTPccYaKPsvHVGVSRo2j6agHvXhHInCz2/CR+4BSXTxCvfNwGNERre2dqGRmNTXzKqB0/vo5SgvC03/xXtUmXRSnuOR4jvi1QhlLFk+pA3UkCUTxTu/ZqWdrT3cgcZi6r2JSxN97qXPEhq5p9BSx+AvqZuDiH+B6UE0G1PRqUQ27t0OjdqzI6FsjiVVvhW9tVyhY3lqSFGQKWa6gYhf+LNnLg/i7usPjn9gBwj/Sj3ad3XrEq8XsVOln+4snNfc5bXrJbgZZU9REckCz5cmH5IvJSekEkylu1ah+mQRm
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:45:01.2401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eff6059-a741-41fb-847e-08df2396dfb3
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0006C3DF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR22MB6016

On Tue, Oct 06, 2026 at 10:28:23AM +0300, Adrian Hunter wrote:
> On 01/10/2026 18:39, Ian Ray wrote:
> > On Wed, Sep 30, 2026 at 10:00:47PM +0300, Adrian Hunter wrote:
> >> On 29/09/2026 16:06, Ulf Hansson wrote:
> >>> + Adrian
> >>>
> >>> On Sat, Sep 26, 2026 at 2:29 PM Ian Ray <ian.ray@gehealthcare.com> wrote:
> >>>>
> >>>> The host controller driver type value used by the MMC core [1] _mostly_
> >>>> overlaps with the eMMC device I/O driver strength value [2] as shown in
> >>>> the table below; however, there is _no_ host mapping for eMMC value 4.
[...]
> >
> > The "invalid driver type" warning that I originally observed originates
> > in sdhci_set_ios_common() which is shared by all SDHCI hosts (IIUC).
> >
> > Thus any SDHCI host configured with `fixed-emmc-driver-type = <4>` would
> > log that warning.
> 
> The warning is valid.  SDHCI does not support value 4 and doesn't know
> what is a valid alternative or even if there is one.  That is up to the
> driver to sort out.  If other drivers do it the same way, then a
> helper or something could be added.
[...]
> The objective is not to avoid the warning.  The warning is valid.  The
> objective is to provide a valid value.  4 is not.
 
Thank you, I will send a v2 in which sdhci_esdhc_imx_set_ios implements
a bounds check against MMC_SET_DRIVER_TYPE_D.
