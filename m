Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793873327;
	b=v7oYVdPQj32ehPhowIG4dPq18zUqdXWZKURe1zsGmakOep1YzWCNKGMkguwwdOWOeRfx
	 LyIsoRotzpJYDJZDcx8q8wLrYvqhTcZwz941GIeqSbMCZr5Md1zOu97Awq+QCPCYSsLDN
	 iYT3m/p7043/oHJ6CMZtFvt6TgHG9TlQ/X0a3v5PJcPTXQYH7BKjrPjqO2MLsNdmJ/DYg
	 o53JZEDfnpTZKjO5xOzHGLaZz+0rWtLFv1e2UUinWdApce++hbC+VqJxcNimGwlnMFS4j
	 PXsHRTTPgT++kBye1t4NWimKrRt0TUwVpy6vISuESnT0tYJg7yi2sCTRZJHFTYDLzXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873327;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Reason;
	bh=KXiS+xiqlnk2BdZ4ccYlakbKpqz660K9DDrFaq7GwKQ=;
	b=jUlbxIDPjIBq8H3eP9uyn9pCk0aya1gm56nme+mnn9lxJGUDyBlV4EQxN+onWYBqaYI6
	 lQygJO1yjuLuLrdUA6pJESQkFFNlV41D9AaT4mTk5FEmf5VDndvzGzKPxBMeLkzuCa7dx
	 ZJrdkDN0+IlkJhdZe5sgLjLL60sJJ3HKY45HTGJB9f8LGvXMCVoMeKSv37GkmcqCLJCFj
	 mXF/rw7uUvf1/ZLvVd7ZAHala2+TRxRQINumvB/56/0Qt/S0n0ArLFQXz0RInTviusFiA
	 8bYvmUl/PxBoMEQWwwsgTHXDIvLWPE73ArCPYSRSGiCFwWoEO9miZQnjv/E6V6EsuKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=k5jOCd8U;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=VY7fJz9Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82606070F58;
	Thu,  5 Nov 2026 10:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A82606070F58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=k5jOCd8U;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=VY7fJz9Q
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A52KR613669519;
	Thu, 5 Nov 2026 04:08:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=KXiS+xiqlnk2BdZ4cc
	YlakbKpqz660K9DDrFaq7GwKQ=; b=k5jOCd8UCslK18z0WWI2b0SRYxzf4x/OfA
	NPNM7T2hLQCoAE/AdeB12syJKHDrJA+TrEtsGABTw1GCQXg+cLqvjaeyjEppDFvj
	VU3/EnReH2qxNm05KH45F94YLtEsVvbGu1CdXJQCjvMANMDHcdd3jCEz3ntQS5B4
	xi1h1P2yPqIinkYjHyqjpAXnpMnrmDsN8+p8eMkIB7ClWYDLId/Hc/HOEO5yMyAL
	i2VBNJMY3JMeXQ8i6eJuF1SEp1w606lrAfuKnFcWiAbWf7mYpoa7CSFcY9rt8NyP
	gjALa/XtGKp6hoSibB3FLju92rZg2A1pzhwSG+Pc+PTI4O+wrEbg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020089.outbound.protection.outlook.com [52.101.46.89])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hr73fhju0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 04:08:31 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kttplzkopk369XQrWPdTb0LdYOlVqx9PxmPInTHl3/MqCbsP3KGjOQcXD7lnaiE0ug7uQefl3r9gIrDG9oyDOH4k817SC+MR7wMzKXNRBo3b13mVDwYkZXzBtRXTcv58hBeV4DEaGQP0jp7yItayQFV5vyfXJc+j8APgyt+mO4h85fywdDsUAdxF3osuBok2JrW03Exrc46mOZ2BXVyU5fEoUY6vXfubbJocw6gZG8Oiugb5t9CPsAShYR04Ly/0IgdaKozEmd8ylWt4eXiZf3zL7VNw/i+pBa0RVj+AYLc1XyxV+rC1wWvZ4uox2rM5E0XuyHSh6EoaNjnzX9nYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXiS+xiqlnk2BdZ4ccYlakbKpqz660K9DDrFaq7GwKQ=;
 b=HaGv7QbHXfO/jDGGQwn8zn+kg8675g7Sz3WQFGzKi39DqcNaLzjdod4LKHRBLYh1PRaQUlVPM9nAvZ0jnQCwgrCgQBfnKrHvRIQ1+RiOROfeZVC40Qfv0/lPHDrLoesRKAgUIvqRNH864g7L332iquXQdQNSvvFLkfw4C0/v1Qasf1+UOi1fwrJBnPlsJvkc1TE1H/hI9N8xqEctgYkyPTeMpSsu8oeJsqE3OikdhdjPqgegsihf/im+H/NHTdASSi9z3j67NgZWaT1yHK5uLae1G5j0xz6socM3/pJjvLJ7JHqwrfAajJkIZ4yld3DzVWzHhHxW8ygTn7ekM2x46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXiS+xiqlnk2BdZ4ccYlakbKpqz660K9DDrFaq7GwKQ=;
 b=VY7fJz9Q4V9wX9nEsKz1ZCYSCPgNQUMSQgNlWRNxI7B2reEDCJNkD1AyzG7tTXn5gf4Z4jExPT0tpuwMSSv1cISv/g0hxgecvxIli/nU4wyWPAl9Tuuon1M/EK+0d9bWSEEEzpdPksbkVRpcYRbg1HynHDbw0qjWSqELptmeOMo=
Received: from CH0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:610:cc::13)
 by CO6PR19MB4737.namprd19.prod.outlook.com (2603:10b6:5:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 10:08:27 +0000
Received: from CH7PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:cc:cafe::2a) by CH0PR03CA0068.outlook.office365.com
 (2603:10b6:610:cc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 10:08:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH7PEPF00000016.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.0
 via Frontend Transport; Thu, 5 Nov 2026 10:08:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4CA86406544;
	Thu,  5 Nov 2026 10:08:25 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3CA19820273;
	Thu,  5 Nov 2026 10:08:25 +0000 (UTC)
Date: Thu, 5 Nov 2026 10:08:24 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Lee Jones <lee@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 02/10] regulator: arizona-ldo1: Avoid double gpiod_put()
 on enable GPIO
Message-ID: <auxVmO9JzC7myhxp@opensource.cirrus.com>
References: <20261104182148.1176116-1-lee@kernel.org>
 <20261104182148.1176116-3-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104182148.1176116-3-lee@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000016:EE_|CO6PR19MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fb94dc-427d-4d0a-7700-08df3b24bbc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|61400799027|82310400026|36860700016|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|18002099003|16102099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ie4B/2twktuSWcDZFIKZqXDS2EI/YO+V54dnm8fluZpzym6di6BB3KzYGgP/dcBvG4r2OQZDRGv2nCbmsIdxzwDvh0JR3WxQgNoMsR71+z1+JSGwPBPQTSD6F38YtgMSpT3WKLXzzT3Ap4TZibJiSUv2BV4UKWTl/DQhpbZT9P4cj3onfgM5yTJ9+wVYbKEuBNdEa83v1vQCj1g9BrTIOT3JmFBVju2JtmBbu1fs9MefX281WVAnBHaXfovDblGeUJ/qi5/87lXa4k1YpuV4TNpy37U6T3HX/xmXLBnVj0sHI/s4a/Ees+0yL42hfvt6u4xAlPHyNfigSpxpWjD+sUJyHJXOKxUyQ6J1uDRxGWZdP9HbMQrpf9V4+bfZGo9Vv8v6FiSpE0Bqh/rDYAsH7BByJNONauZ4Qe50r/FqNoSmeDNN9O9s+kC/5JYdCFSlI9pwlptk2veLU+bD1KQ9VqUWx5Iq0Q5YVJ08qTTNdcq3PH+sh5JD3U7In5qZIRpkAyXGBaC3IUU4dtdIOTADbOEas9/MwIzFdk9o9KGdwErqNB7HeKd36A+un2fzmiLv3PR9NnqBsGpWx6rz5n82tPjTm+n23Pc/S5Kpt2xIFRe36KqBsZEkUhSQO35etsi2pS/Jsk0/0bNskU4nyvecPw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(61400799027)(82310400026)(36860700016)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(16102099003)(10067099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vBNobTOqFZoXh2ApQ1btanXErua4DqzPQRmpm1J5CsQIsSSmz6fauqhjaysSiqYT6+WY58vs0vZLUNttpJ1paSlHAVbo5omzMsbFCSDskJuLM5e4rQtgJxc1Ez/KMda4YHdgAovCEb/tYJHnooafjNGdeaMXhpZDLMYc0lGRVZYc7C75pEWlKu/1/+jdYWPTRCyWwFYZxZUhMUDZTWCaTM6QKIZRNg5cHffb+qfQrFSqLMSDekM88AF5y4tQz0cj/5sMQen3ZDQOsapEuAQsBZPf65ikZQDqx8KimK+sPD+KlQ4EHMa6YJFGlOt7GxuT7dUGvtp90PhFf7LRIUzoRGrXUKPVxsAxgFjuAU6wKNDIdwMFHBM+O7YT3xSVlbGu2i3bER8ii0KBZRUwjSRwzFVngrFv6PfJoyFO1dyKJ7fnAMD4HCZ1JTX+2SFkiRnt
X-Exchange-RoutingPolicyChecked:
	enSVQRoUW+Csp/6eZn26Fd7tLlnbxpxfmHgwP0fP1x6XK6wAlxBzV3+GR9r+qCMWK8rjqj/ZPqD3CWJrOTsWdz2fD6FImvuQxgdu+Adnt1n9s5RPQnvDYfKLecN4AQ9XvE0g+c7Mtu7yioZgKDIL4CnmICDEY+v2QKKTHgPTxWGqzx+bOtPQrarZ18v1aZfSEwk9lrmKlFGOIzbGgbcNMckdJmA37BTEWPifs5qMWpmpAHfFVFSsOXpBzlgljJG/1xak2Cfmc3Q5JaftPM/mT7vEoxWr8iwIekKGdS1YCBW3xpgywZpJv3dAZvIBpzuGNtsLltv83LbF9K87MeHwkA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 10:08:26.2859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fb94dc-427d-4d0a-7700-08df3b24bbc8
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH7PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB4737
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MCBTYWx0ZWRfX6EwA2SywIyFy
 RUzTPnQd7cwKmgYUYpMIBA3MZPKUfFwnelE3+vJLjKbh6G9rgklUkmv4pa38Mo1Cu6ncfLpdKBE
 R3Ghdyc2Z6bZxQ0kObw603EmZhPzDzw=
X-Proofpoint-GUID: scx2B3REuiK95F__mQBrPHALCE3mwHwN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MCBTYWx0ZWRfX2cM1921sRP6x
 OHYFL2AgkiFiA0vbpLwB3tJLOOqAXGjYJ7+aL6hyj0aRR7+WK1o89afc1ogu8++3hQZmGjOyjAU
 EvmWXb4ORfWU27peYgfK4DfR6khIUUTT3WBLBWOxI3GLoCnS83eO+He1lYqsRBp6BsEGAr/hD/E
 rTgzlBm+mKGmwz9LpwTjej1dOQEqEm7b1O4Nya6fVYWRiMVWhqQmPGg3c5HSb32hWbk0C9IDUvz
 nQ/aILje92fG4DPHe+YTdinASeP9TVcd0SOtvmRLS45CIDzK/ReYM/hiZGrC+L6H1rAmwF0izo4
 qg9x89Zx58pVJbCAAemMNCpCZQtoTszcgUzunP4WXCVVU2Gou3/sTl3yvn26sIPb/d1jTZCsl7G
 zXYsV8auUnxCqblEiwTmfuU8mHNvqUqjxxAzFolnxvgY+agEyNpZAjGmeyi7RW+n/CSdjd3e1HN
 xHqC0Sn3EdagEOJ7hQA==
X-Proofpoint-ORIG-GUID: scx2B3REuiK95F__mQBrPHALCE3mwHwN
X-Authority-Analysis: v=2.4 cv=K6S3jCWI c=1 sm=1 tr=0 ts=6aec559f cx=c_pps
 a=IMEwmUWWSCLuwm+xmU4zLA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=oRU8B_dLDCcqgMpMqGMA:9
 a=CjuIK1q_8ugA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Reason: safe

On Wed, Nov 04, 2026 at 06:20:52PM +0000, Lee Jones wrote:
> Passing config.ena_gpiod to devm_regulator_register() transfers ownership
> of the GPIO descriptor to the regulator core, which releases it via
> gpiod_put() in regulator_ena_gpio_free() upon registration failure or
> when devres unregisters the regulator.
> 
> Calling gpiod_put(ldo1->ena_gpiod) in arizona_ldo1_remove() prematurely
> frees the enable GPIO while the regulator is still registered and causes
> a second gpiod_put() when devm_rdev_release() runs.  Drop the redundant
> remove callback and ena_gpiod field so the regulator core manages the
> descriptor lifetime exclusively.
> 
> Fixes: a9191579ba10 ("regulator: arizona-ldo1: Use correct device to get enable GPIO")
> Closes: https://sashiko.dev/#/bug/linux-7988402e-ca08-4bd3-9488-5779d6da0450
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
