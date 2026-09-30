Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A33D5661;
	Wed, 30 Sep 2026 07:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751719; cv=fail; b=SVPOsoPFC1Z0rtEVvsM8THjEkSzajrdlyVcr0BTd0tctE7bKEBNZzx6wEn5x36ZMBZlwRAalbODRS8912j+EFZBl2AaojqY0c2XzXb4dHccNy0IlrSj/SrY8sSf2lmEXsNGDFhpGOPOd01OGqFWvK4/wQaZ3Fv/yF1x1XCJkfqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751719; c=relaxed/simple;
	bh=xAZ4asfSl70hz59Sdm1O5MuRAiuzSqYvR0eLxiwGaUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=am+Fv8uI59WxIe0EqqYVOLqhr+nXw9mpKizV2bhV0/bDsJbg+HTYjsvSiBaTG/IAqWxDTmkMH6+3up0l/xXLGI3pOW3sDE2MgWXzMIx73scoBskgP6oZnljfApUstl6CPX2bvAMFC6KqDx0UB/4ga6PPCmcFlntvu/YZvu5p4Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sbu2VNAn; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sbu2VNAn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpiNhVgRrKsV/aN8ZecHVAwPJk1+jItDs9KaGv6LOWgr9oaIAwnwX6pdceEKD9IeHWN1bmQu00lPqim5O38Tq4DkC624SQpT3OloJEq74uEFLn1jAtx4XVA6dIKPrK7GGmZlDPeA4VVdVfWen9DZRtYkzFCLyNqyJKHvIhmjOshto+rGlhjM3l1F48LRbxdItarfH4+wmSdhVhR03ZNtdvYXeyu8dAZKHSw8BaxsI1d4kkQEseO9KFHllBp9wKqoL7xesK+TJ9Y0hYkhIJ2T+okVNTjtub/rC5ZAhodJ8lP3bX3lyO/tIgLbCPT10AmWyN8bWoXsezakRAz74r3lDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCrbRkiGDbEQSqGjWrb3eBkCJ2jw6KRP5XzeKqYYEi4=;
 b=x3P/1228lkWHTE7v+wYq0F3yd31OpxKz99F7udFiIA718fVjbT3kxAL+HF0dYY0xhMdAYof5USXgu0xIEUv6BQej2giG4vSTmFNKBK+79nS0Zr3mvw9QpeogPFBDeJwvWgBpalr9mu/iA8vj8McZj5xZAAW5YkZkbCe5mCyOYYPGQmiQcGwqBJEdSJNzPmqXWQGAsPTrtVixhKvHwlbzvi2SbZeyI/6OhegWWJVgvFg7wcbNve/HsuSw4ZTW5Emnbn79czx/wPVZWcP57kBH1yhITSC5kZXMDRwTfQjorbyfUDVmU5pU/TSJNVNel3Ke6qyx2wkattvHSjhBExKk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCrbRkiGDbEQSqGjWrb3eBkCJ2jw6KRP5XzeKqYYEi4=;
 b=sbu2VNAnw1pJ/sP26KIddBgco1ZQuHUuls+GDhQj3nZIYLa1/4ni4RnK/4z90yE/Kfo53SUUc4fuvj+Gl8u3QCtQTdaj/L9/hHSAF2G0Jbpkq+g0O0rlPs5quyiUJ1/qDbFIH49zIPFVj/FokGqBJrSom4LRxytp0DkRy7v8BrtpPl4DuUycl/FZmQ5umStV3Wx2JKGqo/Rv0J7y73s/zmVlHGoJyefahcby3cS4cC/i1jkMrebHPfqXyHjsJsa5C6tY3E09ahbi3q+HsBnIWpx5eFh55gIqEE8CV94fxyqwi8e0/BoBqccEitcg+4w8JiEYFgOlO/U1D+ajzAS0Mw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by ZR6PR04MB025774.eurprd04.prod.outlook.com (2603:10a6:910:e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 07:01:45 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 07:01:44 +0000
Date: Wed, 30 Sep 2026 15:06:11 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: hand off fwnode ownership when shared
 fwnode owner is rejected
Message-ID: <ary048HBAkJB4WR9@shlinux89>
References: <20260928-driver-core-v1-1-0846bb8e0f32@nxp.com>
 <20260928-conscious-spectral-manul-19bc10@sudeepholla>
 <arsYvrYaQIr1lwbT@shlinux89>
 <20260929-abstract-accomplished-lynx-3edcbc@sudeepholla>
 <20260929-dazzling-gray-sawfly-cfd671@sudeepholla>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-dazzling-gray-sawfly-cfd671@sudeepholla>
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|ZR6PR04MB025774:EE_
X-MS-Office365-Filtering-Correlation-Id: 762e534b-32ab-49ab-5e87-08df1ec0b01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|1800799024|376014|4143699003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	f8nADEXIvEVjCTuAgHCS77DKnm3xS2ijE02/sN0lBwfA/0FdubTRegI4bFDhJuZherpyRA/Yl8EOl2BUrFy/hc4HXQiPrlp3hSsDukLBA46sS8CqFbBt2TVtO9HX8J6sqSXoUM3CLoLlfhe5TtnKQEiGZ9ZWbAhdvtN9Fq14oB4U4ZPXdysnu2fYw0uWS/eiW/RbmsDBZ+hsaUjXf8vf+Z3YVcuwvhrKnPcG3SCo1wxeJMlXg0nFVIfR2GlsN5OLzWX4Loi3j3uIsHNMjWRjS2CrbaVgAkigRIlm47QDjKPZG/nw5KCiuuKytxQnnT+8EBETSi45iAfASzmOOVWuLAHYyVdl6A5z7uBN95tizYySz2atPT2CciITO64fj2YWCnCOdhUjtQnaU9zXnCEqxvOxesC0atWNK+1gdEIftn8q6m47gF3jOJ/MVt5K4Fs/i4iMxJ+r4d6IZk21qriQGI6wTvpKXKlRJONBOo/W0shQ9VAHbCgx92RQyLQqaQQXboeDsTITRgPDl28N8i3PRoXSr5LySehKRUTwU/4jsV7hSxz12fTvAIE8d7XnJI63S9pYiSFMaGVnf1yC8KbnYXV43D0a/lVmdcAkYzbpmixTO44qx+hon/FN3tAXabg1Th+8VHoD2QvIAxh5IPUPfmAO/KTRGhLuDzUYcrz2VXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(1800799024)(376014)(4143699003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c1wq5UvO2EzDQOEet5X/CgGL0DsCD1f5+eAxQZm4bMvRWgO77Fv4Pw+cClqk?=
 =?us-ascii?Q?oGNxx4vwsPLPTEJBz/a+b9nefAswF/Z6S8w+PAC2D8FYHuJKOJDL34MRySVw?=
 =?us-ascii?Q?zgTKdUsHrmzmIsMzjGP9Qid0hMi1VU2CoQlzLwcj/LwTpFKWbMyC7Fe7hOLd?=
 =?us-ascii?Q?1mTHqnys6MR2qwqtyYEW6XMNv9pqvONpoWeX+1wp8uBfAL1zjqUAaF9I/seF?=
 =?us-ascii?Q?RFza5ERMhV4iDbuM9lWCWC88knZiP4jSA+g1hc2g9cvgHvDsJSR0a3zAoIcr?=
 =?us-ascii?Q?WoJHuCJ5dUlnudDexK7bUO5gJIEKvBRKS2Vpc1OOGzDZRUUcbMy0eGJ6Ubbu?=
 =?us-ascii?Q?Y0Jnj8bqj+zaBPmFanR71npJiVyi7XuKfNl2zM6p4u/8Snwf6GbqHh8X8+Pm?=
 =?us-ascii?Q?sPsHK3qXAnMBW3KwYIkYWTOcXNTm9H1Y3XzKtAUOl2zqAO1Ta/nqEYy9fsgV?=
 =?us-ascii?Q?TfGchynv6G2QqpFMjeg7flkyAZfSjCmRjlXorE3cbjK6uJJeAltZFHPUIO+D?=
 =?us-ascii?Q?D0LjjTyqtC95HM8HmlXg1/M3OFpItZcKJR67t0YC86agZZlDbi2EqBjyMKdu?=
 =?us-ascii?Q?R7xG0dhVkmOFYVe9tCigRtv+WZKvF2zTld5G+ekMZq+Wwc5fbSzvE1psMMKF?=
 =?us-ascii?Q?5ZmVESZRBkvNeWUjvMHC1UlBwhtP6A3H7PT7Or5Abxk6adb4iTciWfqMkBqP?=
 =?us-ascii?Q?JC1f7GkA6H+aneQ1Rr9vlia2gpWdHCGCh69EicdFe5A39LBVEjoVStMYkDow?=
 =?us-ascii?Q?2K4JHUFBpgCQXVd+hPgF39cQxbX4SKYMmmJiu6IqIlOwISvaSfUsuqNg+KiX?=
 =?us-ascii?Q?knHccvKpyNGxyQHpbh2+qcE8EfWGjUTQMBcnAuws5j8esnZ8ckP5hnfsfNl5?=
 =?us-ascii?Q?HfcgYVXqAoRN9QMaNK8hQVpuYu6wd2hHgskZeHJ8BwR1SI4Osxff6Hg9X/Ho?=
 =?us-ascii?Q?vtWRbiGwV0ZzYw/pjeVkvcvzorCLDwkR6jaV2NZqB7Wl1bRG8ybhLY1f30Lw?=
 =?us-ascii?Q?nzjQAjH0GUkwUM5g592pOu9iXwIcJZ3ycL5tR3yo1A2KoVxsjFtfEJVYTZbx?=
 =?us-ascii?Q?u2o036h7ajkS+tQnzPqE4hxi1UnP9gEZ3WKS9jy4ysoeIxSyu5K/PMZiJih7?=
 =?us-ascii?Q?m/8ZeRr8MhfiCKfM7Z3tugQhcup0TwT6k41t52LC8hsHw70Rzr4f2uBSCy5X?=
 =?us-ascii?Q?H4EfKt/AnlNHcNgPOOmxMLwRWyxTRacNJjg70q+PKF5Fq/mdbEAg+6nlfa4s?=
 =?us-ascii?Q?L8ALASH+87EHAoImr3KbvXHYAUd2gbW8UG5+lzwA73Y52bb3ezSrkWZX91ti?=
 =?us-ascii?Q?m0dMszkzFaqp9tCnYACWiNPUZunV2ysXkWBI4pq6LTDDZmDai8cLw//W4v+O?=
 =?us-ascii?Q?rlqoqYpfhHIK57zGu5fNrRfDGNO112wDI2NzuXndvEvzUIpx7PO3bZvAXMCU?=
 =?us-ascii?Q?0qC97qCPuAjfdRWdh2cJj11tWgAwRfc97XTLVVCgbuCoSPP/TN3NhYZfEuYH?=
 =?us-ascii?Q?q3g/W4fPpNteBApbA4oEArnxg7zP4PaBudoYdAp7Ft/c5T1v6WOdGjIkhWuF?=
 =?us-ascii?Q?msOVaVZCqAXZ74dxQ3khBHDtb/YpZUGIeMCI0ZqJK3nDsAe4mH7x833X6uKU?=
 =?us-ascii?Q?CicDTcVzEUWOHgpsWkXeWpMr2ZB7n7EX6clObAhCtfyYO1D7QK+5MJYV75B4?=
 =?us-ascii?Q?N8xRt4p1DaCJZSQdn5TXgbi6t4IqCj+IaE8SMFTeW/4kBmVOOp2eR0cjX8DM?=
 =?us-ascii?Q?LpyD/sd0YlopEdH1laoxo8Ww6gSvMeFolrujSs5rQkKc+u7SvWoO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762e534b-32ab-49ab-5e87-08df1ec0b01e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:01:44.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGQ+K7k3GpJ579EOL2GbD6ZCrkXBss6GdC8/oL1DDaOUdII7bKh4Vu+YAlo7aEI0aF2Z5HjUmoE5sKDlyTkmeoRLcT1oberG4x6oe1AwH5i/a0C/yMhK3Bx4Pgo3QvO4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR04MB025774

Hi Sudeep,

On Tue, Sep 29, 2026 at 04:56:24PM +0100, Sudeep Holla wrote:
>On Tue, Sep 29, 2026 at 09:35:21AM +0100, Sudeep Holla wrote:
...
>> Yes, but this particular device is i.MX specific issue as it should
>> have never been there. So I will discard that in any future discussion.
>> Use the SCMI pinmux driver and get rid of SCMI pinctrl-imx.
>> 
>
>Anyways, I cooked up a patch that may prevent the issue with pinmux.
>See if something like below on top -next helps.
>
>Regards,
>Sudeep
>
>-->8
>diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
>index 25197197db8e..cee7cc777724 100644
>--- a/drivers/firmware/arm_scmi/bus.c
>+++ b/drivers/firmware/arm_scmi/bus.c
>@@ -60,13 +60,6 @@ static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
> 	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
> 		 id_table->name, id_table->protocol_id);
>
>-	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT) &&
>-	    !IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX)) {
>-		pr_warn("SCMI Raw mode active. Rejecting '%s'/0x%02X\n",
>-			id_table->name, id_table->protocol_id);
>-		return -EINVAL;
>-	}
>-
> 	/*
> 	 * Find the matching protocol rdev list and then search of any
> 	 * existent equally named device...fails if any duplicate found.
>@@ -181,12 +174,35 @@ static void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table
> 	}
> }
>
Move static const struct scmi_device_id scmi_std_id_table[] here to avoid
build failure.

>+static bool scmi_device_id_in_std_id_table(const struct scmi_device_id *id)
>+{
>+	for (int i = 0; scmi_std_id_table[i].name[0]; i++) {
>+		if (scmi_std_id_table[i].protocol_id == id->protocol_id &&
>+		    !strcmp(scmi_std_id_table[i].name, id->name))
>+			return true;
>+	}
>+
>+	return false;
>+}
>+

Tested your patch it works well, the pinmux issue gone. A very clean fix.

If you post a formal patch, feel free to add my
Tested-by: Peng Fan <peng.fan@nxp.com>

Thanks a lot.

Thanks,
Peng
