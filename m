Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245FA3D0C09
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974732; cv=fail; b=liR9SJibA/8e9pvueDP5PklNnkjSrY2p9nrMc2Wrvry+14VThML0wzC44qtXmCcOa/0JIED69zWciphXAbEBL1S4DmKxpTHYfgiG391zVUnGR7kXLB5t0qrn5lndvD8Bv5vm5J1f/HGvagqMCJ4uHcC+cX3m7kH7XAitTXTTqiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974732; c=relaxed/simple;
	bh=AaTmM9JBCflwJ/b6vFEfq/nnXk7Ik3NfQOU0xpWk0uE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O1f2LK0MaodzP+M8lc/KKGLcsu/5pGTea68LKBEcSPZxb13z1vesc12ybRYNhICwUnfQeGNIVNZakNFRNCqLWSOQMXY/4Yoqo5XfcYy152b5PW8fe79mx2QONCR8B/24KfS3ojUdwDQJLx4QZqdumzIqN9dyPr3tsso9x2MyFuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCyIawuT; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCyIawuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790974730; x=1822510730;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=AaTmM9JBCflwJ/b6vFEfq/nnXk7Ik3NfQOU0xpWk0uE=;
  b=hCyIawuTf41YCj4vKInzI4Z8RQZNSIzx9N0s5+L7iyq52NCLZq4ktMbb
   y+kF50s+TAro4iQauJHX3DKjC5/C0fOGHtvbXq7hxa3VIu62NT+rn+CPS
   Srl5Zzlb2U/iEjZ8tFmygvSQoZsKWvWhxYf2gpr5mDSx9D56DIAHGZ17p
   kqpIWKaery6yba8UHFajl/cKZt1nXzIJRPHSI0KsynCYxLiA1HxWaAcuL
   uwIO8AZv+OjzWwjS78lzJnF+DFRduQ93ZBFn/2t9OwApz/RK13UOymJwR
   sYQT95CwndVI6+70J/QlzogZGZOuoMUM2G6SQpLFFvYmUvgHRt25G7sui
   Q==;
X-CSE-ConnectionGUID: SC4oWn4QSIKwp/ZWAWkyEw==
X-CSE-MsgGUID: 6Pf8qBBvTkKS1ht650GZFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="102419662"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="102419662"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 13:58:49 -0700
X-CSE-ConnectionGUID: F7zxqqZASK+lj6bnlgI5Vw==
X-CSE-MsgGUID: p2pHxLILQaGNx/ZQjnyDRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="280069608"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 13:58:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 13:58:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 13:58:48 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 13:58:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HODBxEVHOWpKcWdSquz1hFmyzLFvRwyW8teEI6pQh5PU7gSCs7UxgJTOEl0BEmkpvWknJ29XLFYD910tbkd68qZe8T0CTCTxwUQhfxf95hLf6rGyTMbvQibty5pNQug+eGmy30Uj1QPqpwQCeFSa/9dUdOkCGTksbx72IrzP3b8DnVJ3stEZUYJEPCASx/p9fogAxlw6b/RtnVIPqB8H5zepJeQxel5k5XWyy8kMStO7ECHSB7V84sd9zCCa/QcgHWcfgXk0f4e8qDQTHNVnrNhP7uKtJU1Hh3A2HBsWH8YdTSwqbFAcoV0nTa1e8xGDI4hE+WSotnvo+z7VsKUXlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GY3k8rlC8rfy/FEhqC0/kHWaMyfnr3KSc0rgiV6g5vA=;
 b=aON3X6+yvLjwtWNEUrgeDTRP2+yb1NiUPE+9GL3nS14ukkbMPj7C8q6ENidTVDHT0W86rBYLzZ7wuJw9/T0tRRzHOQJoRU3QdJZ/xHDn8LVZqY2NZV7liYpdd7lEcek1tzU30l3gGismly+FShlWcNMJ5iQu/1G32/+GfXy3CHxto07+/uw03x97rUyHUCjywzV+OUlEMhqNhLM/7mymZpAmxFnF+BAHom2yQzprER9wyOAv5u9HpzXdsAPR4aKxXbESIGlOYV0pi2vbegNkWR8MJTTq08MJzf2ek3HyBkTrQ085C6gblj9XyQ7kYtsPFD9tVibVXe42aO+mq1TvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by LV8PR11MB8746.namprd11.prod.outlook.com (2603:10b6:408:202::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 20:58:42 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 20:58:42 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: Fan Wu <fanwu01@zju.edu.cn>, <stable@vger.kernel.org>, Song Li
	<songl@zju.edu.cn>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [CI] drm/xe/i2c: cancel the client work on remove
Date: Fri, 2 Oct 2026 16:56:21 -0400
Message-ID: <20261002205620.211113-2-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|LV8PR11MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 86291062-3ad0-4439-ef08-08df20c7f07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: MUM2wxjnXrob/9Iyrw2KAioC/Dllj9Vq2Y+GiKPjOitsPzARiWckpI07ZpdHdtd6kyXKeHl0oPGaktAIm3S+jeTC1pvS2RcsNVoDmilX8PiK1DbQ2SKDZnerrGpd01tcPuFascgysuAUTIdEx1vHGf0ncwrRVbda8BtyKcho9rK/z9NnKHabDExZ8fIBx6dMh7IW4iZxe9BiWVshTEEIht+E0ca1Qq+1dHg3kzsPUnvdwx7zhe39U/SoHxKVYxMYzugowYRBM5cMG5IKuAvrN4FNWZKtiEOlf+fKbO00tA3twAKKlbohCNbejRsktcw+O4+TWCqOgcDx5b9yJF+5d299539F62lbSVJ3JqItUIKWyr9P3PAWu0HIqE0vLonSVBI81jE8VvVJobNgvxl4RYunOfBTioy/ukfNvxLkn3kjsKlKKMuq7z+QnxHbCWOVDjbonh/ulR4wRkhYGkGgjtwVanHDzx/VkUXM2BRELflMWAyKVvtN0oduhEg255J3tbxfTX1C0nBythxNpaUpiW+FLFibJj6UufHd8FWv3LAUuFUPbQZpz5NXGO/3Dm/GYlqanTmbHSJ4C1QOx/MsgsJbOZiySsJaJpIeyUg0lkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7187.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x/euFaJOuq1dks+/Ke1lAwq4WyNNq8iRCu4Sb1zuIOmIPoy/KhOWMV+1xd1M?=
 =?us-ascii?Q?butqkZ/fuRZGGsaJn7SuFTZ+7Rrpt/w5JnlhTJgPligsYkDjsH2gX36rPZk9?=
 =?us-ascii?Q?VRGx6OKsrkOEbQwqFrMjJzp1PtV3WWbG1PpgIANlVz04Q2le3Q1QQfzS2X55?=
 =?us-ascii?Q?B8tDuQTX5Pkd6HQCkbvTAE+3B3hu72JrDQ+Jua+BS435XUxS/XNouFM5I8d5?=
 =?us-ascii?Q?oOSjURjQaCaHfvGrEk679KwfzQWP3XskT0g3D4rbqaU5ORRrpzaIfaQcEu/7?=
 =?us-ascii?Q?4UCgpVStkIw16RNFvD7DBTXqYvrlaGs0OHDlGv9+9iPvk0Z1vUx0Kts2QPBD?=
 =?us-ascii?Q?6Wl6syyyXw3FZtFeBpUkvyW/WBnVglmx9M3i5Mynus2P2AiBhPt3VS9Cc3z5?=
 =?us-ascii?Q?gqJSIOtSJDIBmdHUKQPYQoFrOXEckdiyHdILO3mjLzjGKhyw1D8wepKItBA2?=
 =?us-ascii?Q?KfBOnmFgu1tzwbshjf2J3GTup7OEUzUxRY4HgD/SAud3euWOBoAV/8DzApC7?=
 =?us-ascii?Q?j3eCdNo7IwjlfRp9cmaBEEb2zdPUXIK7sTv3X0SE6ZXPPn+59DHoMDSYH2hK?=
 =?us-ascii?Q?KQXkQ23f1peZdOgxT4efXphpq83SQZurIvwgbGs+GUPc8BA+5OmJ51Zu7gVy?=
 =?us-ascii?Q?DPvLC4EYcAFW30XsoID7MBmE59TGGfaUG/DGcuCFYMOpQPx5HmTchKsbB/0Z?=
 =?us-ascii?Q?vs2z81vIbiviLKE+5vAZVXMuLZ0w4UUqEkWOIcSQ/MhdbhOuqOOLQ+yTW9Ft?=
 =?us-ascii?Q?r6TJXaPVVVzcp0gFlxJLqDDFOnAkS3kS7Pvnj4AmDhpyRzE/e5EyuhFo7P5m?=
 =?us-ascii?Q?Inu4cJqvapkCyphTgZLpqfFbTtnBlzRUyPCHdJENT+lF6TU11RQYlZG9JJIP?=
 =?us-ascii?Q?OSwxZ42mMhhY+fdMpZTpgZqiCyOI28+8guDfT71T9/ozN3x2GGaaS8GvlToO?=
 =?us-ascii?Q?MVztkXFHAluyd2VTPTzFfWmDGoGwNrCnt9/v0fuyC+8CpUOKjminJosdtMZF?=
 =?us-ascii?Q?B9HO61UnY4Gy7jqgSwoFaPASHqUf4HzXeCgMSnA5rr+m5IkFvGwt+QQB7GLz?=
 =?us-ascii?Q?NaBE3RXoqNFV5a11gtNGNx/y4Ev4FweUkSlMjlX+h2vxjI34O5w+ac7w83lJ?=
 =?us-ascii?Q?2UuxXuvuFG3gT9YFFTUGRaRM67uW3WmbpqSuRcRhmc2pxmwcoGyKHChvk4XE?=
 =?us-ascii?Q?63sxnFqSFZC9125TRQtSAL7p6qGjLVknvq4pi/B8784jWTlr6+SY80pSqtMj?=
 =?us-ascii?Q?smxVKrNBm/yI/Hb0zyZKivC+QU7coTGlYUfHc0AUhgtdWd58FKHE9vf+m2Mk?=
 =?us-ascii?Q?sTmvjNwVUGWOVn6NlxsHBHXLXPKhc4mVon0AojWGrZxzyUgxVtvyMDD+x6L1?=
 =?us-ascii?Q?NTwB7afO6Acqkc3IJOIXsm15JTbNrlzzbHbzlvTUjVx916+ulSAFEM7LniZh?=
 =?us-ascii?Q?fBn4P/uTKwXDpY5kEh/rHu2EnXXHCKq6JKzrxeD9JRDXUAlWf1SCsS6vO/+Q?=
 =?us-ascii?Q?P4scNgzeSLuoKrm0vm3BL3wrCLWfz/C6EeXAnCkTJJAgrgCZMmaXy9/2qEFz?=
 =?us-ascii?Q?cDUJ/emBwm7rvlhZDEZZa7KQkzSQO27Ns2mreNhL2tmlaamR8UX/J9mquA8u?=
 =?us-ascii?Q?v5nFbti8SJXOI9v9jAY8mXzH8rmKVW9LBKhUuVneNz+8RLm7RfaO59aSOnU1?=
 =?us-ascii?Q?8RZWubExduuXpUV8DGUyyKVOG3toz7Pck2Em3U2fPbW5MS/qy0TUUHAXI6aH?=
 =?us-ascii?Q?TAQmrq1LHQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: DTH4SIXtGROsrK+cp7+wOc3vagX9kf/v8i+dH2FFOqj9RkCieVsEOsCgmb7KgK7pr+NNOxVxXVO+IhwdcCls8G8rkfKSG5eCTOLcXgEOgVcYKTWDNxK4FFrFmSzNUK9R7HSQ+oPcOl+fhYR+OaJmOJaPG3xK8Fm6sn0W2AoEAGdabxjASYjV0r4LQyxX8vIZvDIZETC5pL//bfW147emjI2fmiWsTDdZzv5Ynho4HPtW+ukUjR5Qo1ZyYFmX1elMvvXSHdg48dNZ4C/JIwwo/6oCpq+StfSdkbsqffiH1FSZ6YeZLyKrTe96YYWu++2qpRhYmI42PPACa9jMtkfeXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 86291062-3ad0-4439-ef08-08df20c7f07f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 20:58:42.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0KFNpLXvkdhu6zgb+2KW4kZLibkaTjil1VrrGJ7ZjiKmowOcBj24MXrFQ7ER/sZyw//OQJCy0I7ewtBr8hzPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8746
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
[Rodrigo: Rebased and a small cleanup in the commit message]
---
 drivers/gpu/drm/xe/xe_i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index d8fa68206f41..0ebd708b537c 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -328,12 +328,15 @@ static void xe_i2c_remove(void *data)
 
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
 }
 
-- 
2.55.0

