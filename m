Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794019408;
	b=uAwqWiypuogNLVhyXKpNf1BYpnKaiP9WcdjTGiB29yl42cszcuATkCvnF1Ps/RIpQOBg
	 AmID9mt0Cq5WsBj0nzrgxZsqvUNWkHg5k5aUNcplgzMv8Dg23jcbM2l359gvNdI30S+g/
	 bg3v5PQ9UvAR00I5Hdq3bNqBeHiI9FwYHDPZzsIBI326LXdSoKzsT6kxFLabjRhHBsWIl
	 X2zazCyKnC0709s4Q6TgUupn1ovaMezA0d6TUY05hXiVUkf8P/f9L8rU4FRZoI14zH7vA
	 JYSBdh4zaXpbBkcpZmgyWpHvOyGQ4JSNF66ZipChW69kDPT3ZyekUchc25UMjkmDsiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019408;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+XWW7PFKZXZGqB3OVbBsJvy380LZfgPaj1X9yMI8NyU=;
	b=WyPXdIUl/0dFiOiq61Z28aHntNebWnBZoepv0Ntidq67i2Y0B1EPox5MitXA63K7Mu8v
	 QT3/yL04e90rZ9aig8qFpuzqBDGJxcjwwj2PTkcRYiL3v/noggIIzouASubzIKPU7jlpg
	 lf86pU5DkqqC/LzvxAF+dFVkv8b8LWfaRyJU/DAeXpvN9Saw9RczANOY/1ux0z8iSDvLB
	 cQVOzmCkmr9jMGbrQmAX8xhcy+VyX375ADuXxsLjvftG7SS//p8r18oiO+1+s9D22jZL0
	 X5Yo/Z61ZV+9Yue0r+B1xemmNGbVwRraqSnStRdyWRV41enQY6m+kSz8KrcUGlOuyqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia.com;
	spf=fail smtp.mailfrom=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=r1cI87f6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.0
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010000.outbound.protection.outlook.com [52.101.193.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6012606A333;
	Sat,  7 Nov 2026 02:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6012606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=r1cI87f6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8jvh943O92Sc8IUaG6ySgMEbuDpJFiKMQA0PwXqwlew+nfTHp6ZXdnYQF1+Dth/JZCK2ur5DklZCI2Lu4MjVVRDd2QDVsb3xS9bkBhxDlzfm/LyxcJuiYefSoPRvh0IzrzHQrzb12RlUdkGfk/WmYAbu8WrRLbfBd9vGZH4+TdAfr9NW7pLzvN6XspcWRra5NnEy27ARl39zNeCBCZ0vzar7gUlXZpj3/3iTlMKg4BHwQhCogGYYMrrr4nz7Cc8uQ7QJjukbw2/0Gzitc0VapixTUmKIbaTsSAnGHa5QoLL+KTpejM0bgs4H+IQ2TaNtkkMhx43ur8LEtggQ2gN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XWW7PFKZXZGqB3OVbBsJvy380LZfgPaj1X9yMI8NyU=;
 b=fsRjU8Gev1OD/7+7h7aOPd8q7OAC9Xmu4Scs5mUAm4wb7lWlv3kYo+mx8kSMGWpWd27xM6iP8fO52j2AcJ51YW0/8ipaWAGvD3rfWP4NdlESCdCL8Vnt6W6G2keNbliqU2eBB1+1AUmRDt2U02AY5N0vBjXSkPqxzxZK3zbYzKPsVuC/FeP07kMzhxXLwfkE/m9SJA9RcIKs4Kh8Xky9Nc1CITGvOb4TQeLxw8FXNUktcUGhJ9S0TGuyc+txfX2PKkhqhEvYTt16v7B5YjYdDzUoiWm5NQ64cn1nWftYkIPfC6W63/Is0DD/a/9uX0VJdPPY4hclgEG69Sjg6wElQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XWW7PFKZXZGqB3OVbBsJvy380LZfgPaj1X9yMI8NyU=;
 b=r1cI87f6zMgX4/qZUc7rqfwxcux/njm8YSFzDi8soNcjLEGjF8K4XwqlQnWqW1krUp+LVGj9Qi3K9WaKmWAr7VgwPhYPYePnYmLQPULARahmL0Tq9mX187unz4jlZaItmoeghUUAfWz3uByp7bJ6lKgaU2slEIFNjwZW6TUD+PvC0WHYqcYerqt3YMZqzM7XY+HQxM1fXrgjozLOWpiNOS11XsxsSPRmFLodr0i6gfawa74uJIqwDviljb/tHOE5niw7eXsm2iRcgoubNfSBgYXPkz+VVGvusknztUxGZ6jxs9MH5fRsqi3UG2RnGvx/nqvWG/lTZxeevHLrYT3MsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by SJ0PR08MB7781.namprd08.prod.outlook.com (2603:10b6:a03:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 02:43:23 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%5]) with mapi id 15.21.0569.011; Sat, 7 Nov 2026
 02:43:22 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Todd Fujinaka <todd.fujinaka@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v2] igb: Retry the D0 write of the i210 PLL workaround
Date: Fri,  6 Nov 2026 21:43:19 -0500
Message-ID: <20261107024319.103771-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:610:4d::30) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|SJ0PR08MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: bc267e64-4622-4c62-d6d3-08df3c78e39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|7416014|18002099003|10067099003|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SbW6Dvpy3UnbeuZNuF0N8NgW544vOF99DIl43rHtE9Z6Tj1KECMwNaC5Sj9/CSXYazoPoy0AAiA9aexqc5PPutm6JhahymfS04Whdf4aWN/egb8QbQ/YebwDLVuJsC0ugwbNVlb+S3N6GRFJ0y1MsXG6h3aA8C0PYu8Dac7oz52PmBaOjw4SU/y+Yr9LEx5dnqJ0Bmh3BmwgZbK6Nrb4EoeSgSKD9LrNRAKACdV+pt7uXZzY1ztYTcs6NYKQ3EC0Q3kwnQ5y3YlUBpMY3NaIr7xSOAlGwuT3rF8Z3O1xs33noEDuEEJKkcjn7hypjkzXy/z7MZysBAvjPUgqBga/R9azcPwZeNKndqX67tuwvuvfke7arqbNjpkhQXn1xBRWgV88jos8gRKtpInHPmWia9pN3hacYm1poyNQiT69udtVWlindo/gqtb/RA6A6nc8W11yOxuIKY4/eXyCohVmGzLo9MPQ4LCMHzxtJww0Qodi9mOqWElfqsKPqIXiBgrTqbvdk6F7e9f2IAnFtI+Z4vRymvZhvRMeJMuQoXCHbcFAhob6LQ1am/+kl7cP85k0Pi6iPJpBnGyCYim6SHw8xlyx7acKmTdEW/YfBzLWzFxsXmQT+2tKXYFpmfdPazKx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(18002099003)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MEzjb+GneAKocUOOYS3Nh9Y5CJtikxPCAySbKSh8lBRoFtGe0nR6Hp3ETH9j?=
 =?us-ascii?Q?lEYvG/elOxpy2NKdlG70UgSgdKm2lKdModk5SHBDYSfZ67EU/m9Rdyj+G7Zp?=
 =?us-ascii?Q?snonV/V67bCJRQ+RZNPA6p9cNvm6F+VbJxEdwfxXJ1UoIafFFHKAFdQup/8o?=
 =?us-ascii?Q?fXxnTmgXnv1vpmCHDT2/v50S+plBijlreNmwEvmlFGch+zSKKzYDuiXE4Ecy?=
 =?us-ascii?Q?IgGW/Km3A2VXCzMpvPvmgE1kjESzmj5ZbhQ8cfyy32FdNfrG6vWUsnp1YHq3?=
 =?us-ascii?Q?moZHVMk09Dz421xvlu1q0OCQadO+NJKyuWKUENlhooqG3Uf2bPPHFzB1IdFl?=
 =?us-ascii?Q?7+RrGWfL9jD/rGbX/vxb4X+BQ3v8N3nk10NW62j48hv2gkuIK8PiMExt+ZBC?=
 =?us-ascii?Q?hLqOA9A/tzPgkRmxbLOuMD+SbeUGE/oMsnWkxV/QRyao9MpDDI5WQ3JagcuU?=
 =?us-ascii?Q?8OG+wd3iUYQ+JeFR2ePQT71/DA0liELqO5ZV1U2bYGCDBXJim6VEH/hz9WAi?=
 =?us-ascii?Q?h/qLlwmO0jjpNDEZQnjOBehtSCUouoZT94Pv0+afCiyLmxxKI+nRygnhheky?=
 =?us-ascii?Q?f8yrVttJ8RkJHQugD7ZtR/1R634ImIhyRIPKYCQrYaZUZV4OY8/gzqNCnM7P?=
 =?us-ascii?Q?QhvP6kK2dDcT/kWOlWmkFaWrs4M9zjWafHTi+dlA5Ng08mzCLwI7mFQvrn3l?=
 =?us-ascii?Q?NpK+CDyO3GyPw11Bj4cvFNuqvhUbdfCs9HfG8M9txVBtpMhCl6kcC29hyZP5?=
 =?us-ascii?Q?j37hC+AfhPJeMaqmeSpeYFnJvzzgYOwMQDsGNuvmF6Ctn6wlzihWpSR7t2yT?=
 =?us-ascii?Q?bezW5PL+OtL4driIGPJnaXKeBHCfHEfqFhRbwM+dZjXwXspzgm67AhB232/u?=
 =?us-ascii?Q?W3kONqCxZtZtipvQrQjpIfqzOrojYz9Uj5DPhmMnjfpdUdARnj0JAHZYuAB0?=
 =?us-ascii?Q?ibOKOLSlwlLO9BvrygBeWZ0/h9iZaIdKTbIzEmjbvss/FXDZJMk1wrji8RFH?=
 =?us-ascii?Q?sMhMuhejM4iX5DUMdhBJ/xiJi3xHumU46fJY6bh81xfHszJVI9dlYHNV4Rhe?=
 =?us-ascii?Q?7KUMU5Etm0YYQlCUS1atwnJIRBtGJc/lhAgpViWJ9amCxTeqho8nQDnZO/k2?=
 =?us-ascii?Q?F+nkQVwQ44cdgTjSz9gSB6Y64bHXGNZ5AoGgrE5vNJAZPEI9Udvj88xUj/Mq?=
 =?us-ascii?Q?g3FWwOgaN3Q/tZ3wYFOcasEfl18S82529fBQ3bsmo16ROOQPzftB1JpATNf1?=
 =?us-ascii?Q?CcNoZAFifUhvzga/1PCCMoCK/25Qwr5Wua45+UDiKgdpjaducRm9JjeAIxO+?=
 =?us-ascii?Q?Eprl7/Xr4y0ysra1fjutA7W7KFtih23hGresaOkOWxJ/py0SBL4AslfA59YY?=
 =?us-ascii?Q?DKpxP+I4iYiskEN1p7pWV+t4UmJuIXvizrH7y5pT4drgzXeCoP4FEDQU9RtM?=
 =?us-ascii?Q?q8CdRpkGwjH4MRIgpDqhDD3V9q/N4m90sY3mcC8ZmhyuotfYX3/qWBrqtFYt?=
 =?us-ascii?Q?2m3bf2Q+A+RIVkF6fBzpkVbS3xkbXx/idlkc3uOP7HGWrfuQ8YPdV54qUKFJ?=
 =?us-ascii?Q?I1lEvBSGNdmVUOtBwRti0+KrHjJ+Zd/tbbRmPH2CZpZu/XhOSaToRLtVJ2xA?=
 =?us-ascii?Q?TSEQINiaNKajq7vpdne9o2QP0/mISfHkQ1M6fU9cREIlKDD1hBpuCrhSxwQ2?=
 =?us-ascii?Q?n0DpN0XTA+DGlqvnY92jJaYLqyAfTICGs4ciI0i9B7ZsjG6l78YJUYx+XU5W?=
 =?us-ascii?Q?XnSIKxr0GQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc267e64-4622-4c62-d6d3-08df3c78e39e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 02:43:22.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OikDFBoj3pIrYQLzweOU1OvxZsXKFw04LhE14AiFJtEAeIG3Lk8c+0chvJQYnatRNKKhOnsnB/2AJQS2GpUyuL2/yEr4VWsoYos07yXj1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7781

When the PHY PLL of a flashless i210 fails to lock, the existing errata
handler transitions the device through D3hot.

On some platforms, the root port frequently reports link training
while the device is in D3hot. The generic DesignWare link check
then treats the link as down, and the config access is rejected.
If the write that requests D0 state is rejected, igb ignores the
error and the device stays in D3hot. The next MMIO read fails, and
igb reports "PCIe link lost" and detaches the device. Every later
link setting fails.

  igb 0000:01:00.0 0000:01:00.0 (uninitialized): PCIe link lost
  igb 0000:01:00.0: Hardware Error
  ...
  igb 0000:01:00.0: Cannot change link characteristics when SoL/IDER is active.

Retry the D0 request until it is accepted, up to 1000 times. If the
device never reaches D0, stop the workaround.

Observed on LX2160A systems with a flashless i210. To confirm it, a
test build of igb forced the workaround on every probe. Without this
change, igb lost the device in 15 of 20 probes. Reading the root port
registers during the workaround showed link training reported while the
i210 was in D3hot.

With this change, all 500 probes on the same systems reached D0 with
no lost link. About 70% needed a retry, at most 21 D0 requests.
Tested with 6.12.92.

Fixes: 948264879b68 ("igb: Workaround for i210 Errata 25: Slow System Clock")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---

Notes:
    v2:
    - Cast PCI_D0 to u16 to fix two new sparse warnings
      ("restricted pci_power_t degrades to integer" and "invalid assignment")
    
    v1: https://lore.kernel.org/all/20261105205325.2624892-1-anthony.pighin@nokia.com/

 drivers/net/ethernet/intel/igb/e1000_i210.c | 33 +++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 784f9a7bcbed..2de9ddc46dea 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -7,9 +7,11 @@
 
 #include <linux/bitfield.h>
 #include <linux/if_ether.h>
+#include <linux/pci.h>
 #include <linux/types.h>
 #include "e1000_hw.h"
 #include "e1000_i210.h"
+#include "igb.h"
 
 static s32 igb_update_flash_i210(struct e1000_hw *hw);
 
@@ -812,6 +814,33 @@ s32 igb_init_nvm_params_i210(struct e1000_hw *hw)
 	return 0;
 }
 
+static bool igb_set_d0_i210(struct e1000_hw *hw, u16 pci_word)
+{
+	struct igb_adapter *adapter = hw->back;
+	u16 pmcsr;
+	int i;
+
+	pci_word &= ~PCI_PM_CTRL_STATE_MASK;
+	pci_word |= (__force u16)PCI_D0;
+
+	/* Some host controller drivers refuse config accesses while the root
+	 * port reports link training. The root port can report link training
+	 * while the device is in D3hot, so the write that requests D0 can be
+	 * refused.
+	 */
+	for (i = 0; i < 1000; i++) {
+		igb_write_pci_cfg(hw, E1000_PCI_PMCSR, &pci_word);
+		igb_read_pci_cfg(hw, E1000_PCI_PMCSR, &pmcsr);
+		if (!PCI_POSSIBLE_ERROR(pmcsr) &&
+		    (pmcsr & PCI_PM_CTRL_STATE_MASK) == (__force u16)PCI_D0)
+			return true;
+		usleep_range(50, 100);
+	}
+
+	dev_err(&adapter->pdev->dev, "Device stuck in D3hot\n");
+	return false;
+}
+
 /**
  * igb_pll_workaround_i210
  * @hw: pointer to the HW structure
@@ -866,8 +895,8 @@ s32 igb_pll_workaround_i210(struct e1000_hw *hw)
 		pci_word |= E1000_PCI_PMCSR_D3;
 		igb_write_pci_cfg(hw, E1000_PCI_PMCSR, &pci_word);
 		usleep_range(1000, 2000);
-		pci_word &= ~E1000_PCI_PMCSR_D3;
-		igb_write_pci_cfg(hw, E1000_PCI_PMCSR, &pci_word);
+		if (!igb_set_d0_i210(hw, pci_word))
+			break;
 		reg_val = (E1000_INVM_AUTOLOAD << 4) | (nvm_word << 16);
 		wr32(E1000_EEARBC_I210, reg_val);
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

