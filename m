Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011033.outbound.protection.outlook.com [52.103.39.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205373D1715;
	Wed,  9 Sep 2026 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788998162; cv=fail; b=VdFlSDaIo0Urgoty/EanZjHCBGFZWLF4Kil9CpYrdHHcX5tHDNscOnE6gxeoVVpY6YThAlNLXwQLHlkFwuxyQmwCJqcXoZJzKkVaion9VsM9VpjCzQeWldUaRVrtUrC4iZGdfYS30TDLOdS9oq9igkPuRRr2HokVmGpyHB88m9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788998162; c=relaxed/simple;
	bh=q0NssAvtPWp/zl7EE2Y9ySyRW0enkvt0X0jNq0Xeeao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CFkEo4C5k1mgiF09o4+Jl47GTa0BA7EdnhONWhWq+kDhN1g98Dp6U2BTIN46N4buj0HDlt59CJcsChU4Jh17+zVup/6QWvCptfzvqDK2dlB0A1xnAst70zEpdSZSCyTdlb4jo23+q43A2PcnkoeJCZYF3xMpQeCxxCbPz1t2xpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=oHmr/i1k; arc=fail smtp.client-ip=52.103.39.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="oHmr/i1k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1KbAETRnx39qe4M5DjZx+y2xX6Xx3HEMAdDYFGFbKuAhHdioOlGeO3JiDAqLqkv84vrr9A9mN0OG6d1KLxP5XhAmqj23hmKQ8ZBxLV09lK4V88FdmfYfpk/oAi+vEbVnQGx8i+2NY/gEdFmkjSq2MqMuzneijyCw3iIjY5jdJj/+iSFmCE9lyH/wviMjzASGcOzlLcqaR8668unEnvMGuNOuzsHMLMyAKZY7DV6QBdlK10EQNb86nUOKwTkfkgPzAC4DGCUhaceHALmkdvz9Wl00a5ok5+I1frPc5PrwQZkZ2K9qc5g+uXXWRXGdx8aYA8XDqqC46Zda80aQTTCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0NssAvtPWp/zl7EE2Y9ySyRW0enkvt0X0jNq0Xeeao=;
 b=MhvaeMboXrAF4TSkbLRpDuBhf55xjuPrIG+B/iPTACMyuXaHpZ9Bp/FUp6VUxeVOQQhXGOva/4jYVBivjpVWDCYszB2adckuIj5vc9jRAkF/F+eyuQqeSOz8RV7eKuR5rwaf2k6+4vSqRwmyCUi9Qm5DcFBeRVhWfxTonYJUCV08doE26WJ1b2SJR0eRVQn2TE0M/GDFwQfElLhiOkn3dy50QoIhVGBpJRt001cKuDR0lfUzC0eykC2Pbi9Tf9mfpSKQkkuqELg18dI+ccGVfFFWXu3KoB8KEgkWqPht2ylW3YTSgqkzGLBAZJ5bWSZ5OhQ5tIqCiKE7JGSyiHKQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0NssAvtPWp/zl7EE2Y9ySyRW0enkvt0X0jNq0Xeeao=;
 b=oHmr/i1kzlNiefM9CH4kSLRn+iK80JT7ZGgmU/ESGmH6lHEBAj4vmVwFeTwQqAAyiQtPiMJl5VzPkP8h3IqD64wbcu634NTE1+T6tg6o9gtX1ZI/PN39Y/3574k19+IUbuU8ZIBXg8cUGSqO6hBxAjq9h9K/XIuHUgo5pasdZcFmTviN3vXM6e5V4WYzA4YzJ/3m/9ll/0d+fnEQ/EimMamjIKmnNXHYYawCyd0bchvlgdCwL8HuIQZ0sFHXlPR6AapN7W4/V3Mr0Jtz/jiKERR4POQA+7r9uM4F3aDKaWPtNh+4KtNjbZYYZhPqlGZtnED4YtBrqvlLJVMISCB1mg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GVXP251MB0792.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:6a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 23:55:58 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%3]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 23:55:58 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>,
	Jon Maloy <jmaloy@redhat.com>,
	tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tipc: validate data size before reading Gap ACK block header
Date: Thu, 10 Sep 2026 00:55:52 +0100
Message-ID:
 <AS8P251MB0001F5A484C7465493F8BF1DC8B02@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <DU4P189MB3750CBD6A79FFD1255DFF593C6B12@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <AS8P251MB000136A75E6C720544CAC017C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM> <DU4P189MB3750CBD6A79FFD1255DFF593C6B12@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0103.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::18) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260909235552.31475-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GVXP251MB0792:EE_
X-MS-Office365-Filtering-Correlation-Id: de8b06fb-9bfb-4f0f-aece-08df0ecde49a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|15080799012|51005399006|8060799015|25010399006|5072599009|23021999003|37011999003|25031999004|24021099003|55001999006|3412199025|440099028|26104999009|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aFuIX91dK0B+y8d0cIllnuZLTJVmPdHRm5dX+wNUUPUPIwEpAryH8MYj/4pH?=
 =?us-ascii?Q?Ob6S193dPGEBFF/lY3A3yxPPEAAitVl9fw3yAWOhvgHPzoznE3VKlsr3wCLV?=
 =?us-ascii?Q?inQ4h73jXIsJVpW3zKOg8K2yTWgbVh42iM+O9gIc2mN7pmFiFQDhDS43lbFA?=
 =?us-ascii?Q?vwMkV6JjdXSm6HdBJO6QH0rOnKPQ9/AAy7cQP9OWb6wpIp5gX0pYPOQ8s2UA?=
 =?us-ascii?Q?w4T7ekf3tO8Me4ddxuumVT6mi7uw6KHMcy/EH9Gy7etPlGO3i9ZMlM0IP9yq?=
 =?us-ascii?Q?lLJIKQCMzlUKcG8tvWuQOlKTueR3R8e1zVOr+DePSBIlKfjTOnB1kOQLvw3j?=
 =?us-ascii?Q?DXtnom8iVfYYMEv10QijPmCRwqWBh1icj6HmX7U40VtUPZ/OqWrMFrCbzyKz?=
 =?us-ascii?Q?+HRh82n+uUu15PG3cFdMdljAizI6ZLCVSCse1NeXbDH/UutBe7GkkqMIL9yY?=
 =?us-ascii?Q?K9b+soM1azF5qm5h876yyY6x5gutjfVr9Fbti5Mz/+h9Kl2vx5nQX92+QMe3?=
 =?us-ascii?Q?+eOq3cnvB4LE6nSTqpANJ/18aUG5ZPnIZpsCKJXbWt7AbuSMBNDaZM2wW8X8?=
 =?us-ascii?Q?7pjeNHD8UZsKGpi2H47Zc5Yh2Ug57NssPP4yNZIdZto6hgu63VQEQ7iPSZYt?=
 =?us-ascii?Q?2JgaPlctzrzj/0rIvLi6fE5/eHBR18T20xBoh6/UDXweyLl+h1Ra+wXYBu4/?=
 =?us-ascii?Q?wN1Nb9cwpDGUdNs0DjaqpojqN3L3Gmt7bDzFqdbWkr7LzNteC8I9EOSjC3yL?=
 =?us-ascii?Q?mW9oU0PpVbDQoVsdLAUEoRyzOzGmBO2PTxsqjB4ZJChfn2KgI22FGBFONCGv?=
 =?us-ascii?Q?R5OOaAGGxxizFFVuGva+QjZ1IwOtf8xR517msxk/lpHVRpSY8/mMDiOkOEyh?=
 =?us-ascii?Q?l1NzrfLzQ4GGZMvM0IvHFPGVy7k5YqDyBgzmM2rJNpN49c0lYWiyWYRZVSBd?=
 =?us-ascii?Q?+ocEcWgQengoeij6fq0v+OADOL0X8Wra2aNIr7uLi3CleK0d0LoxdXUD8Yef?=
 =?us-ascii?Q?fve0xRyxvoIXR1Jks4fPNU+KVA863Yv5Y5qkYrDZF0/1AeWopFcLKRRd9a1B?=
 =?us-ascii?Q?YRFTbqPv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EfPGrp6vzJ2vV98KtrrSp37WUREIxrycYobvKJui9JHaJ+WPHp4CSjZtuEjQ?=
 =?us-ascii?Q?H1+pznDPQ8GUD4AOmBIVfLv1gG0zHeE/knXMkRAcmd0Dr/ah6myWvXGiMmxG?=
 =?us-ascii?Q?RbjVYqKvTSTD9ZfUpfD5a5A8e4TmJtxyb/25p3iG6+fx2gAShycNWfEyJHdk?=
 =?us-ascii?Q?DuGSr3T1Jox9HxFCOj0jMqLVICvbdNN4ochTy5JKwqNs2dmY2+kg2D4D5D0w?=
 =?us-ascii?Q?iIeBJIY9Jd0JHAjVL++JQ4PJMJiOxJaNjiMCTmck3A9Mhu/xOjuImyfMX6BG?=
 =?us-ascii?Q?+dN/mW8+KOgmG1oH6QCvRIQpymzkRBK3HrD/L0iupdftIbMWCSEF5Da2MyHi?=
 =?us-ascii?Q?6hPnqi4+54bcOwDjp8kmOKhVZVreYmeVC9S+OPPjo6x5xBkFHxELD3HW5YDc?=
 =?us-ascii?Q?orcp3sOR7kTiNZOZmzcMPSuS7HQH9muDL1Ev83bpiYmUQamSwUlPMUj8YZDf?=
 =?us-ascii?Q?V3/r+0GWBDeR+DXcQKempUSMHnpDG4ao7CzNiVRulOd+dv0qbiotEf8SRkqP?=
 =?us-ascii?Q?e46lxzga2ON6YyVRuZvehQbko6xKHm8Gjg/r38sYFKHDrd9eYRO07ki7n4l+?=
 =?us-ascii?Q?wfkkB6yCfofFb4sESDxF5KYkg6B3i3Nkyj6F7pXcvre61zEGKWPOM+iyfwBa?=
 =?us-ascii?Q?gI8Obh0wJKFQP1rdxV7WNsvoi40xY3cDEqIcIXUatDX61bGX48B82f/S+Dqc?=
 =?us-ascii?Q?P7FflKQAT9O+SU0tYDrAFPst+fwkavk6vkEkmKr68R93iE1lYiNA6VpVvkVW?=
 =?us-ascii?Q?C94m4GrJIPKvb0y4CfMx6JvnfoAHnzmZ2qKL5en2n4MPqgnpbOTN1nEOW83/?=
 =?us-ascii?Q?FrHAcgLlVPmio7RTOhcWX0t7UZVnrdSZHwC0ZMovWM1huGL/1bWSRYXwshdf?=
 =?us-ascii?Q?ohrDTLLxTrsxn+nWuy66hFKzr4jaCbpDZpcCdFVl37DWHRSyEWwxBaqTTVJr?=
 =?us-ascii?Q?RVoNQ1YVOC5+jOhGgv6YUgVpL9iRrevkQAI1o4oMyqMgpHMK6/xdmUBjd0As?=
 =?us-ascii?Q?FD59zB29IHswAOVToNDCh+M3tiNepjSC3mId1SouO/VtCqgQuXixepfxZHBI?=
 =?us-ascii?Q?Zqo6nYGye4A7lbQS35bkp44BncFbJgzs3vFkVFy7NGGf+aEDzx8Mh3qVlaCM?=
 =?us-ascii?Q?GOfYJolv2LGybuqNCwVlx59be/3eDYl2sXecC3i9fPy3+/HstbaBoKQ31RkV?=
 =?us-ascii?Q?Pd2YDJI5RXmaZabMbOzoJskoBhxvkwkDTMhvwreBDDH/D7Xk9Mi4weA+J1ti?=
 =?us-ascii?Q?TQOxAQeAxVNwu9tg7/6tAMUstQ9nh7rg0xtHp+AZFie0vmtWIpdkEUijwOD0?=
 =?us-ascii?Q?pyrqSWzEWdMzQmTleIOyOVLPyPMRQsxUGhZG7m3CgcYf33jSRKDxw4j8qX8p?=
 =?us-ascii?Q?2MWHur+GKdfNaEl9DGs69kOTnM42nbVkMA+65N/aMWCH/7uLEn0fPUHkyhMv?=
 =?us-ascii?Q?6rn/2ta+s+QNiIEPyoL+CT08JxDy/2q7?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: de8b06fb-9bfb-4f0f-aece-08df0ecde49a
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 23:55:57.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP251MB0792

Thank you for reviewing. I've reviewed this further and there was a
flaw in my methodology.

Reads stay inside the skb and the result is never used, so there is
nothing to show. The commit message overstated this as an
out-of-bounds read and write.

Please drop this patch, apologies.

pw-bot: rejected

Kind Regards,
Aamir Ahmed
