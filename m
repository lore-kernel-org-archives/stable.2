Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525823385A1
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449837; cv=fail; b=KzZb4oGQ0/JUL+9SWeHnkBhoUgl/yw0CNVzLAC9DGPqlRV+djYwOsuZS/3BgTFm3CyX7H6+W78e3rrs7cPDQC9R7NE8AVgdwBD6JwuNDVkZIOVH3iuKNQuLovJCYcpUxm9We1EOUHhLnn7A6rRn1JFHmXxxuEPcmlHEOyYUSC9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449837; c=relaxed/simple;
	bh=zLK0IftujFIJ9kMjzgX3p2MAJWN/6JVyuj/WEg9iFaI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MB6VhVriqurYHPAW/7gt+jr7Ah/ydfayduFw+N+qJKswxMh3gmdxiuVov7qt5tUwMKlECQPwsJhQkQaLPxxOOYzX8eBPjDGYUReDmT6jyGfKZjxsn7CfgErnpIUqY4heKQfmhfgVINRSS7Iit3PH6SydeImh49upvvX50OCLva4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=lyg/6pwr; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="lyg/6pwr"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6530nEdk2777508;
	Wed, 3 Jun 2026 01:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=l6GJfFN1J
	WB7iLXIJpdCoGa1yNMEG2NkRS3oGlMYiCs=; b=lyg/6pwrymHtls9mNs1AJvHP8
	/gYbEn4awFHC75KCFV6EnGwNYkFx3YB/mXhkp2Y2TCMZYmeeqzg3CT2JXtEkVzzX
	IxKfEgPKoZZylt5zKzktiIm+FS/5YP+t4ng+RvFftjLXuynLLPsurhP+a9Jc8tyh
	syBhSyY54nTik3tm3q1q1NdoS6xnmFzLh+9hw98dLeW6YSfei8L71wYLrB6A3DI9
	+DUHfzz7N6jw/8euubAf5DTFv2RziE8wpltdCvwR61gBs/FZvQYZ8Yl+MstvDm0F
	3quiU04rw8I815Zo/xKScutTGUqlIRzMPjKEs9QK8CwE/GS0jHMvqo5fNsFug==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efpv8dvf0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 01:23:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLmKiffvO7Mrfsvvjp24yz2GmiXptOF4Z2UusLgXbs/Js41BoEQFcJv7VjftU40fNjPZ6jq0eFQIH6IQtKOLq6fS0eae9fUH0yUcLE9Cl63uC5XAE2xLRDigAA8nscrRH2kaw0ht8z/SmwtnY8tVMk+CiJoMgZnPmkon2NAbnCX6IWcSKTLEDfISHBkuzhQdOrsu3lIFssoqrqk9eUPkW52XBAoFPIaHVbj//wSu10BC+XtdYF6Ll3OVHi1/U2OiyfociN6CtKowSmAUnXViyyDjGpaaWEtW1HcAhpcQtw0er6nTnCPmXFT5WhsD0wl4K/sQc0Nnk/+Tv2hA4ZcsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6GJfFN1JWB7iLXIJpdCoGa1yNMEG2NkRS3oGlMYiCs=;
 b=DshjDZsgPjLsjO0Ane0EB5y8ZpHHisKuotn9TrmnlViEVyKM3K4lXTu/e3nKi4h08Aa7rdzmB+xHecUkqwSReV0QuoOlax2emZ/S0Ecec9hIBchk05Sv7Wjwy7eDjIH10gro/6T+1mXwgN4LFjZ7cLmGXqz2R9juzAZ40KsFQrykK79xgqcPxR1PW5UColq57wY/m8oSr0AEsKObQbdB9dKpRSK8tv3OSS4GyjuhpFrEpYMDgOODWbpUEbgVj9yc0bfuJikaqSd7ZkBWtJkgKM1oPmPYnFugqj9PyMP+E6Zbl9QbnkgEfYEKgQRB8ukvzuz1dO1b5cD0ti/3/z/fXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26) by DM3PPFC89313B1C.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f4b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 01:23:29 +0000
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6]) by DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 01:23:29 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: catalin.marinas@arm.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, will@kernel.org
Subject: [PATCH v2 6.12.y 0/2] proposal to fix CVE-2026-23346 on 6.12 or older kernel
Date: Wed,  3 Jun 2026 09:23:12 +0800
Message-ID: <20260603012314.4100773-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.49.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0125.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::19) To DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF641CF4859:EE_|DM3PPFC89313B1C:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1d4593-c5bd-455a-d150-08dec10eb794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|3613699012|38350700014|3023799007|18002099003|6133799003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	5DzMzS607TF2DHUJQYADfKzO3MmdP2vbwzrMv6Yqzf5UHGD8u5vk4zF40zM0zSFD79CKfj7SrohJKfYgmnPcE1Ba8zre0IF2pH3rcQlwTG514yUwx+BnxFmsOkSIAH/Zd3M08NzYfY72tSSvnH7V/rhm79Bm+W3NymFQkkadDQAI+yLIHSRNUyGgefIPdzBV2rhrpxVo6RgGVfNGG3PSkx3cDHtTRIXXKHoGeYcpwyx1fXaWw5F+VzbNXarip65GLNn0Qtw2r8do9nVhdVT2j/8FMkr9AvYQGQKjcKRad/oE3gYXpB6kHlgQnzbbpWctNHdRHnYngaTcGY7mWU+qPUTGzCsnvQ/zJHX+drpnICa0gRl/nT0Zs/gdJYFRAcNTxl9aCiGbhaJyQhGe/+IJ7bgFvWeeOVw+vV7lbXsC9TkzhZyhPDKAe5qSCFn/8Ef0FndgKYvKphkvGgRmrRmnne2xF/f3DQf+rOCnDKxAH5Mt7mybfPK8NEzivsqHKJgAcLcuAaiT9YWHqIMm3Sc2/IksFhkxNUSbFZao1sJ8cpyAkrBWsUHgmX0ROCEUr14I8L8uHctX5Aesl6AvuvPjc06VYXc0y1lq8kt/tzxbf4M68qTcaAHWONtDFM34//lG7f4b0Kpb7vA/Vv1G22Dccb8soorTsvuUNK/ysF/1wAtTb8U85LqSwVecw+iv/IHPBdhWOo9fF2ATNmGW93+/2vH+qr0f5Us/d4W4tuM7wxYpm15CxRqwzAQPXXo0dFf68aFduXliz2w1qFO74Y4G6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF641CF4859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(3613699012)(38350700014)(3023799007)(18002099003)(6133799003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQ9aCGumLYIqUS62yX1yAsvfP4OFKR89soAVJG9OnMrbCu5iI8A5tZGGSo09?=
 =?us-ascii?Q?pBQLaFddGI8jdbyM2Ih2XciIKx6D1xkiiJG0JIE70N9gshU6n/qOgFrWejG7?=
 =?us-ascii?Q?8k5ErSR+YhFHXK2/BN/bkZPeI6j/+u0xa8V++facPBfYQ4aSIky9RX0ZnnrN?=
 =?us-ascii?Q?kkyCcA2FQiV9CHNxjigepBtQc36ZWIAyScqExUFuOPx2DzBb3QtvHoLub7nH?=
 =?us-ascii?Q?m8rXGN7IgTL0r61HHujkjyWS8c4kEOmMciynpTSPnjomrZgJTd67pNwNTj6C?=
 =?us-ascii?Q?fd843iJ9u6mH8up+I2mwUxpE48mIsD50WKvk3qQscYHjesPYAi720t9nxN4m?=
 =?us-ascii?Q?GLvAUzOxZne+r2pZ0/QQs0f8qpS6Ia+J4FSffJpjbbEc9cdEJUJ7mYn6PqX1?=
 =?us-ascii?Q?Pmamv+YBw/rRrZD77z7XyuzLL4mHJqrty9KK0YWMap43IuqHeda8+R2szoHV?=
 =?us-ascii?Q?7MW7mONehUKqQ3/kd4KvEAKgcQW7Yz/XkywHKxnuQqu9k4NFg0AvGknqN2V6?=
 =?us-ascii?Q?jrISptHg+nyW6J8W3IO0URNJWUM5v2uwiB7xBHXXNnVSRkxsSlTpfiR5d9Oi?=
 =?us-ascii?Q?KRtwaaxtiyXDR3XESrQRLvw6okmIPWqckxQAHArtOcuXaQKiC3Q5Avvd//ZX?=
 =?us-ascii?Q?CdaPxkBkAOHycfHry/ZpLgTxsOpFy4K29ncW+YbCJWq/wjCt8r5Lz8Vjx6ln?=
 =?us-ascii?Q?b42An+jUlyhR2NxL8YgRT6SRrTjd78suq8/eVmpp0yILj3YCICTYOAIOohlC?=
 =?us-ascii?Q?DlJLWo2y72XZgTFv5W58BRdzja1LujaIcWsRQd4s5t6XexcFFsxBfvuiVsui?=
 =?us-ascii?Q?cZCOIUUPhy5SlZX/LGEe7vuaH37vWgZ9j4ZvKGXYh1O2WExs14k7SfivXJ0y?=
 =?us-ascii?Q?7a694K9ocm/u0OGlUZTkdnCUKZ8XQxG108rAyQk0dTtWF/U1eFjKoV8vrES3?=
 =?us-ascii?Q?DfU++GIer5MdtV2Jn1J0d0iP0D2QIJBb40t8zHwkFGcQ7lrZH7xyc3IzOWrU?=
 =?us-ascii?Q?wk3DMSFS0iElQ/y0JySIvlXjgQFj0Dz+vADU8XUWcFVPUA8mngSoESshsmXL?=
 =?us-ascii?Q?bG9RZAieCQh4Y9vOlmVncv+UAkrYeXdnIZhjmo2BruvF3FqMEW9mj/55uUIw?=
 =?us-ascii?Q?DD79ZEMiJaub8fqaiXppjlkO8HH87ogqeGorgFs+wWvZaJXUukOVN/4UnDt9?=
 =?us-ascii?Q?VCu8YconadSd61O42pWttRVS2Mvh4z8OqQzEjDPn4ukyuOTJ/7xA64pFIZJR?=
 =?us-ascii?Q?kk2S4mxkjcgNu9GC5rsm8xqkH34Y8NF/582CJS5htqzphbSuT/0vqMPILBnV?=
 =?us-ascii?Q?PBiZMa8XYLXg8UE6LTFwXH63YE+PQ5KLngofg+bP1azo/8sBA4Rfk8dnF1UX?=
 =?us-ascii?Q?mNQ7WqfVBY7HYiJairNa4YPvhMinvt3P1JJCkrThFZNX56KD6Ktvc/SswZOW?=
 =?us-ascii?Q?Ej/xaWWRW3HSEbzpxca4gExwBS/w5xcheH32KbPCxfSvVA+uCnxmuR3y55df?=
 =?us-ascii?Q?tyOEZeRVppzkW+IDgNPaK0NCS5eX5DIRPvClQBWSDdD6yUKB+fgCbMWM7mPG?=
 =?us-ascii?Q?g4yLyLdVuqZlzdjQjCpFbrCXPQCFd5Jy9+vl8Tqznjgo6EohUNwykV+yYp1w?=
 =?us-ascii?Q?bF5HQziKzO/ufBrkBoFukoqWdBywKCjIJAb+r+3zOD/KT/oxL61nJKI2cny0?=
 =?us-ascii?Q?F+J6M2qHXitMKlk0+n05sx1zFJ9diD8fRIqhNYTOxp/x8YkAxw2NRwNy02t2?=
 =?us-ascii?Q?pHtbWmqrKr4kmdkkOIg6vkGAw994YhU=3D?=
X-Exchange-RoutingPolicyChecked:
	VPIXmndrLzHbRdcO9FLh+JmHA4ufnR4mq+DlPnB8aFEAAs1/O5LXXZT1ljjRmI7kAnKEKSTG/fGchXnREdBP30dT4yJu4qyLRf9/E5tqs2tjFZnLnBN0alTBTS82+pVh0HoqOLXeJymlu9vUZXC9dFT8PicmocvF0zEQpRZenIFlqqOlT0qpJRsHngMk1We/4H3ozk5lW/KYNKa3C4tR2LFR0oyMxOZcwdJKNi5t7v33ObaWvWICdneA42zoFzNsHCBXe/uzlVBeiftqu1a1abDRFdPDPmxwKWe+9fdy7vMsusZw9gcQFHLOh4svI8SWHWH21EG/VAjA46mP1D3SaA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1d4593-c5bd-455a-d150-08dec10eb794
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF641CF4859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 01:23:29.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlAR+EmcmLfT/l++DMvAAW6Lx+rZ/Nlz90VsFLQ91zrj7lVoxoWUea0mC4BMQQVolvyjeq8yOMdVP/lBm9aUWT1/WIOHLmmz8HMliH66KTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC89313B1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAxMCBTYWx0ZWRfX1zE5opngiUH1
 hSpxvnlk8tQCc2uRkv6WdtRYVgfmR/aNc4AJdC7YW7b+1i/sPnGZUZAzZs+pWZH/P67+s1ZjP0c
 +Y43jLXYpizZw2DGU+qoWyFnAn1XbPadLLg07lYiP1UM+ouXYNEFLj5DFRg5QGNrF7o8nZ4ywbx
 LRk49KCfRIVY1rdG1EhimFWT8HqRIPGe3rMtN2Wp/kolgMJkpwOZ0hAOQ91nYycCC2UX/SpQCGC
 pOyLqMiIHXMFMPnk8P8lDXbhO0W9mCDrnCh1Zood/NT8W5PpKCvQiXspsPuthZhuirUo6VzGSsS
 GrUBKT/vROPML47ATf/OO3V66HWMfT5YkTOwSwcIJq2oM0V90aqnewL3CIhmmAXPz2dllF/iFi9
 UPQn4s5KYra+4PHZn+wdhbeTHBkGKksuINrs3qA2lxunEeXdMb9MjjZfcszvHk3+oQroyclATcr
 HJMncjfzONFpxyQ9pOA==
X-Authority-Analysis: v=2.4 cv=Opt/DS/t c=1 sm=1 tr=0 ts=6a1f8212 cx=c_pps
 a=Kwamffe9LshCGz4O85X6AQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=ZiW4gd6GgJFTmXDxjQoA:9
X-Proofpoint-GUID: YHDmiPY6RzWv8Uas4r48FmjLAgVohyZD
X-Proofpoint-ORIG-GUID: YHDmiPY6RzWv8Uas4r48FmjLAgVohyZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030010

Changes:
V1 -> V2: According to Catalin's review comment, using backport instead of reimplementing fix.

Verified on linux-6.12 with Yocto environment.

Verification code & script:

C code:
------
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

// Using QEMU RTC HW address
#define PHYSICAL_ADDR 0x09010000 
#define MAP_SIZE 4096

int main() {
    int i = 180;
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) {
        perror("failed to open /dev/mem");
        return 1;
    }   

    // Start map
    void *map_base = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, PHYSICAL_ADDR);
    if (map_base == MAP_FAILED) {
        perror("failed to mmap");
        close(fd);
        return 1;
    }

    printf("Put those info to script PID:%d, VADDR:%p\n", getpid(), map_base);

    // Keep running for script trigger the issue.
    while(i > 0) {
        sleep(1);
        i--;
    }

    munmap(map_base, MAP_SIZE);
    close(fd);
    return 0;
}
------ End of C code ------

Python code:
-----------
python3 -c '
pid = 506
vaddr = 0x7f9de3f000
f = open(f"/proc/{pid}/mem", "rb")
f.seek(vaddr)
f.read(4)
'
------End of Python code------

Usage:
Ensure kernel enabled the CONFIG_ARM64_PAN and CONFIG_DEVMEM

Start Qemuarm64 with -cpu cortex-a55 -M virt, e.g.:
qemu-system-aarch64 \
    -cpu cortex-a55 \
    -M virt \
    -m 2G \
    -smp 2 \
    -kernel ./arch/arm64/boot/Image \
    -append "console=ttyAMA0 root=/dev/vda rw earlycon" \
    -drive if=none,file=rootfs.img,id=hd0,format=raw \
    -device virtio-blk-device,drive=hd0 \
    -nographic


After enter the qemu, using cat /proc/iomem to get a vaild MMIO
address, here is using RTC address (#define PHYSICAL_ADDR 0x09010000).

Build the C code, put the binary to target qemu system and run it, the
C reproducer would output the PID and mapped address, here example pid
is 506 and virtual address is 0x7f9de3f000.

Fill pid and virtual address to python code, without fix, kernel would crash
with "Unable to handle kernel read from unreadable memory".
Based on crash info, pstate: 20400005 (... +PAN ...) and FSC = 0x0f: level 3 permission fault
Call trace:
[ 678.563102] __memcpy_fromio+0x50/0x98
[ 678.563436] __access_remote_vm+0x294/0x3a8
[ 678.563901] access_remote_vm+0x18/0x30
[ 678.564308] mem_rw+0x1e0/0x370
[ 678.564534] mem_read+0x1c/0x30
[ 678.564754] vfs_read+0xcc/0x2d0
[ 678.564975] ksys_read+0x7c/0x120
[ 678.565192] __arm64_sys_read+0x24/0x38
[ 678.565450] invoke_syscall+0x5c/0x138
[ 678.565729] el0_svc_common.constprop.0+0x48/0xf0
[ 678.566038] do_el0_svc+0x24/0x38
[ 678.566264] el0_svc+0x38/0x108
[ 678.566514] el0t_64_sync_handler+0x120/0x130
[ 678.566823] el0t_64_sync+0x190/0x198
....

The behavior is the same as description of
commit:8f098037139b ("arm64: io: Extract user memory type in ioremap_prot()")



Will Deacon (2):
  arm64: io: Rename ioremap_prot() to __ioremap_prot()
  arm64: io: Extract user memory type in ioremap_prot()

 arch/arm64/include/asm/io.h | 24 +++++++++++++++++++-----
 arch/arm64/kernel/acpi.c    |  2 +-
 arch/arm64/mm/ioremap.c     |  7 +++----
 3 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.49.1

