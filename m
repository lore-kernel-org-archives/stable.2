Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C554704E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 00:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245098; cv=fail; b=oMHzz44KNF+HevAQcFo0DJc7HcS5UgRVcEAH1SwvD6xgJlpzeil/Nz5adjyWRRVVc+t8NLKmVvasQ/0SuxlO7Tw/TOsgqW/f8wZj2pOGpWivvuKJ0cGvQvMjNlZ6GnWov3GccsyF11P/3InG92HY3leWoLB3ZCjL0fgqN1q1xuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245098; c=relaxed/simple;
	bh=4rzZCf/vrKR1XmrIarZejgqpCqzWg5ADIlA+WC4uDuM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i6xYILg1zSvk+OYowdsBxYvwWFGKOCSRVXbO03BmNrhg8/1UB/Dk1LbzeQ+a7+FPKu5sxu4rWaEvqfEP6maLoIBzMcp0dYLEtQ/iTzgj8prREisFBpipPjw9li9xk/aQlj4Stcm1psda+RtNay4M3l79NMpw/c2hMeYkQH4R3JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGvuS6gp; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGvuS6gp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791245095; x=1822781095;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=4rzZCf/vrKR1XmrIarZejgqpCqzWg5ADIlA+WC4uDuM=;
  b=bGvuS6gpOnD/CzPpEHUoTlYRbfWGBgttTjqMjT3xD9r9QAapew3aU7Cv
   j5gxSYUnqVEBmPCJa8P+yHfj7iJH2vp1OUeYPNdmXrI4kz8isYOrq7FLM
   jEH9fZLSdGIRhyg/3tGHOanveR6TLMywRxDbymPr9YsKSK6eaASGsMbGf
   AfzLEUMPPg4AIszWAvtqbNoMVK+JeBH9D0w+QhzhajIwDmpdVpucCRXCS
   JyUGXzX6ekZ/etqwE7vv768dBzx5F6kR3PvMdDjKqIp0le5Ljcj88FPZ1
   UsSLGm7nrGoOK3J1MgAhAFt08vbnYqodX9woQ/WXNjetWJUvat7o0rK7k
   A==;
X-CSE-ConnectionGUID: wTboAOgLRdGqR7DUOMRYXw==
X-CSE-MsgGUID: sApS/Eg1Qb6+/x0BtlutPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="92037212"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="92037212"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 17:04:54 -0700
X-CSE-ConnectionGUID: dc82a6BTTt2x6gdtjilVxQ==
X-CSE-MsgGUID: rb+UtmCiS06hmoX2Tjv6rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="280694784"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 17:04:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 17:04:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 17:04:32 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 17:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbNNKZnDwEPedOPRYITE01Yny3Xp8n0D2RzHeFBPg31CHgWcY7PAHWoQN0F3+W7oBw4eDK0jHZxri79fJKaVZ3GCgWaHsIUsVuNAlsBjvVC9bu1hNzm8x4WYX/dReQO2dKNDMnDNiPWwoEWB6FiacsdhLLlGUZDKA23WXrOnO/wxpt5XesStgMFLyXJHm4XPwbZIosMGi7LhyWzasZgJyRZh2e9mPmA2Xk6ABfug40VxjHxuW5ofjxNNSZGYeUJTlszNTPxwT1QhGz5Q+acwqNXUGB0RYW61fQDXMp+Q0fmurMm4cABxnjFRHtE6v3XntNKmLosKUSY5hAUt8oJPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Klz+mfShCjtcDdfuMzO0sAoMH503E70SOHM+rqYaK0E=;
 b=KCi7q79hzr9WFWhCD1UgCUucQpNAqGZipl8SHe36R6n/aNRwxZEhc4dw7KmXpYm49cijPTisyjHAKfnkZxpOLU8O6F6MvOw36DMGz2dKNgsEguCK4Zvg3bbOrI67aZLRJ4HkG7HLyt9LGOPW8grQl3Z+wqNN3ATJ2Ln+XTNfuvAoWflmDEoU9xhRE8CJ6HFNFU53BCJun44ozxvv2el5s8S2dVFR1TaPuM9IrWvtYhutewi+UoBD2JHKnyQ/dqU/HJyKCtM0O8DNMfBejNGTDen3Qx+GHp8njjz0+ZIkz6/DIz9oSiguNrfh4RvhEaBlnB2NMFjaXjxiWQXBvenyng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by SAWPR11MB9760.namprd11.prod.outlook.com (2603:10b6:806:4c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 00:04:29 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 00:04:29 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: Fan Wu <fanwu01@zju.edu.cn>, <stable@vger.kernel.org>, Song Li
	<songl@zju.edu.cn>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [CI] drm/xe/i2c: cancel the client work on remove
Date: Mon, 5 Oct 2026 20:04:14 -0400
Message-ID: <20261006000413.318561-2-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|SAWPR11MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: e38fe3d4-f32d-4dde-5a07-08df233d6381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8rTJA4y3v7AljaMLkf0HCd5LCcC8HFAib40QfiSU/hOZoQv1wHUGBLuDM4aSKDBt/TR3HraCEGMTTdVzsozcz1uggs56/vXQulECuwr5V88Ffor/oYFS3U7VGGncfFY7BpzAz6OeCdq4EWJzuq5qEsXjY2zp8jgeYMZc7rvXbRvKtoWO7QyfHNLNel5r2X95GHgd9Xb0sL5YuB+d0y4sCxcKY+ij12QPIcZ7dbzdUxXb04dU/cIfPw2L1x+aioXu5fZrTK6b3MCQ+t+qSMJL6HTfqWJDI9Wpz0qjMHe7YR63F8egu/5bxGJ4C7bwPKJYexDq1r9Ca1ySRFJqoYoQe5oUJ3hroxg6oT/YDleLk11yRuf7V2htxnJiP7ciQKvZxtoRVh9DwkoEhQuTWcQd/QJ7z3XTkaWgA5X7KwinQVp5HUsHVgpoiyFRpOEbegYW+gcv25iRJ3y5Uqv25/Qrc09rt7Z2A2M+oAASBLrP0UrleSf0wJYWDZA2hxQNhb2WMcXoFlvc/XvxZjK49BPEZKeeYet2vsinzR0KTD7++B5nLrZ5ay/5/UJmS05QlgeAtqMdSDUDYG7Ar+bUkbuJOxbQJwA6ivDO2/2LtSQR88WR7O98CHL9p2cup3Sc4Aeh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NLvRdFtat/rqF7/pSyQl45JkFq2LgBGNyGDaIk7eMyRirhkRDsBz8Z/4c/kP?=
 =?us-ascii?Q?t2fR0dQ+dBM5FgF8FHL8lhv53OOsku8nJ4O439icvrmpC5QKDNoQmLBgIYVd?=
 =?us-ascii?Q?zb62p5ywCNDoBGnN2LEGyvyNmM+ZU0b4fJcBeKNQtTF+QqIfqb/wSsNZEEyh?=
 =?us-ascii?Q?zfK9XqUoukl7CnneGBkIVD+Vet43O55yPSg5+rhtjAFxpv/Ax3Ysa67ooHtt?=
 =?us-ascii?Q?icdeK2EpT0HN/FXMy51L1GhwrHChlqdxJnUAuKwlC/Vq46zpuvGwNffRpkh7?=
 =?us-ascii?Q?VaFHBqe1YZWK9wnjkvNdWTur1b3ZMtPsw8PbPbOGc3Uqxy6eyZ2SgoTC2+zA?=
 =?us-ascii?Q?N+fZ46nzLvnlRUpy2HQW6euFYfHo8+QOThKXTApLN6z/BGFjhk1Pb14ci9QT?=
 =?us-ascii?Q?dX+e3HHRCgdUOsMHiBUy6L3EOVTWLx14TAvwUtui74JTeP1OlJ2nUIWiiJLF?=
 =?us-ascii?Q?fr+zVcG2AtcEHiGzsQvCh5SAUYvX8+Ax8mkV9bRQEUm1NSzaW9XaqZiUZ7hL?=
 =?us-ascii?Q?tTj6o1Ug7bClrcKb2BweZ4eNRUNpUwWLhOHxsxhw2c/QD9NxtV8pZkPxGpHC?=
 =?us-ascii?Q?No9JKi+BGfsevfVxyW4jRIIbakV8GTVjaq6PER/D9Y1ffVUhPZU0UqqqLuno?=
 =?us-ascii?Q?YI2DrpZ3G9kEowQfFiMdlpyLxfuC8c4F4YRaF+Ks31CBUmVkN9Se0bWCbFWR?=
 =?us-ascii?Q?WsPaT9c0tAL1Y2wXQwgxFJxxg6pgSqO077QumRrnhE6rmZtUPxljkngGNFFq?=
 =?us-ascii?Q?qjfu91mfPCSlfD+MoNcSVLZC1mMwF9A3ePacaQdYVyv1wIeY1cDZ5utp0Vjn?=
 =?us-ascii?Q?nzuJ2lDSM+yQ6TWVjcGwynccMoyhgVwFtj6MukTiBJDCXL4J1+7qol8Qvgn+?=
 =?us-ascii?Q?50ZMs2Hi/m47mUmcMee+LIsTEtSZ3OJgyAFNFlUe7V7fvFBKsyE0ruNf+6Br?=
 =?us-ascii?Q?gpcJYyWAcecHp5bVt/K5ou1jwlqdVA3UueWNQUf+w61KmiFNfT3tjXtc6yLh?=
 =?us-ascii?Q?L4CXFiNy0q0efkhK4fXpqRGx22XFdRnUJbEYg4/tLValJliiOTKgbHIYyPKu?=
 =?us-ascii?Q?aAIg6vcXJ7RcT29tD0369c4E3MZgcMIInpn4qnzxLlTWMpClSaeeTXoSf0YO?=
 =?us-ascii?Q?LefJhfNBcmayzZJLZyaw/MRweYArUBQP/nEXdeBcwepSkeS0NbuYFUNIULWb?=
 =?us-ascii?Q?X881o80NrYBmyo3+lDfyMqwKsRy+wfmLXrMRq4SW+tFW6T3n+j/tqKweCxl4?=
 =?us-ascii?Q?G9QZPQX1qQyoJ4tBodmTCGa7rIpmYMOuCVnkm1utMYxlDKPuBNpwNXOsifRd?=
 =?us-ascii?Q?vZASer3VacBfbyjudJWZ9lbH9DwUP6qYAyZs/3nP8RCDgwYI7TGxHS4GiYZC?=
 =?us-ascii?Q?FNkFQP43TFmPgLOiMC9bhQ+6T+4breo7arQu91ejlMSQXjMmjeehiQt8nHMs?=
 =?us-ascii?Q?NkD9INGdebmL+xV/KchCrTl9zyIH5bzTMCbql52MYPdzD4jw24IMLo/VhZkq?=
 =?us-ascii?Q?dNbihZIpgvaQogTtxzAWw5e2NC/URVO4cHZ+gBnLC3VtmqAsbMlm6NrfB/3E?=
 =?us-ascii?Q?a7pd2OfE6Z9VLuVkFL9opepqO5WX5F8RCOzCiCixXEYTINCm55hGF9N4g1G0?=
 =?us-ascii?Q?iHqeTJyqPfnwiq7oo29BYGiLuWiOn8Tm6JpLZjo676+3x39L4FceNlevU6e3?=
 =?us-ascii?Q?+ciZKrvVz2KcVpk0pE3Ykw/z1Mzno6oUlEMYAmNH4l933wVcZPpopjj8MbQ+?=
 =?us-ascii?Q?VQydgexjI0gPM/9CQ1dwvuxCHWDm6jc=3D?=
X-Exchange-RoutingPolicyChecked: o9XMRkMLFKcduEumwsildsbzAqiPzms+IE0IETrnjT5U2guG/IWWGO5GYbk9PIDkNWJ9Aguo3NQ6tPaMav6I7J1d29U0dzsEsveZe0VQyfurKOQYp7KHuIV35Mtx8Kx3hoSnsXqze8KVl+uRjUqV20Tjf7FagA8io5kLSZFXMvYRDY4srb0PY7O0XO+eyGOsC7TjSzswo3RUr6xd2a6QI5EkhPeBkLYwYoF+upfbSmbisW+qRfy1TAjFGjv1ZghWhdTVt+l0kSxBCYYiJVzMZmL19WKL8MtLsTPgY6UpM7AeFAitPHj09b0LMtUiWGTQoVNzD8k7V/EqBoTcNdTQKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e38fe3d4-f32d-4dde-5a07-08df233d6381
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 00:04:28.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxxs4USbgmQ5CO8Fw2JKudVnCo85WjAbsF0RSHIMlrTj4loTEyJGUv+5sYrL2ClQTMkf8FFKDDLW1k2dQ4e0UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9760
X-OriginatorOrg: intel.com

From: Fan Wu <fanwu01@zju.edu.cn>

xe_i2c_notifier() stores the DesignWare adapter in i2c->adapter and
schedules i2c->work when the adapter is registered under the xe I2C
platform device, and xe_i2c_client_work() then instantiates the AMC
client device on that adapter.

xe_i2c_remove() tears down the AMC, unregisters the client devices,
the bus notifier and the adapter platform device, but it never drains
i2c->work. A work item that is still queued or running when the
adapter is unregistered dereferences i2c->adapter in
i2c_new_client_device() after platform_device_unregister() has
released the adapter. The work item is also embedded in the
devm-allocated struct xe_i2c, so a work item still queued after the
drm device devm unwind frees that allocation runs its callback on
freed memory.

The bus notifier is the only thing that schedules this work, and it is
unregistered after the client devices. An instance that is still queued
when the teardown runs can therefore write
i2c->client[XE_I2C_CLIENT_AMC] while the loop is unregistering and
clearing the same array, and an AMC client it instantiates late is only
cleaned up by the adapter's own child sweep in i2c_del_adapter().

Move bus_unregister_notifier() in front of the client teardown loop
and cancel the work right after it, so no new instance can be
scheduled and a queued instance is drained before the client array is
touched. A running instance still finds a live adapter, since the
adapter is unregistered later.

Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
Link: https://lore.kernel.org/intel-xe/20260912085932.101598-1-fanwu01@zju.edu.cn/
Cc: stable@vger.kernel.org
Assisted-by: LLM, in-house static analysis tool
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260928013030.612592-1-fanwu01@zju.edu.cn
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index f4f381988289..b82caaff80d7 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -324,12 +324,15 @@ static void xe_i2c_remove(void *data)
 	xe_i2c_irq_reset(xe);
 	xe_amc_exit(i2c);
 
+	/* Stop the notifier from arming the client work before teardown. */
+	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
+	cancel_work_sync(&i2c->work);
+
 	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++) {
 		i2c_unregister_device(i2c->client[i]);
 		i2c->client[i] = NULL;
 	}
 
-	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
 	xe_i2c_unregister_adapter(i2c);
 	xe->i2c = NULL;
 }
-- 
2.55.0

