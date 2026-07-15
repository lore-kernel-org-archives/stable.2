Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9E3876BA
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125758; cv=fail; b=Pq8Wu5eL9XAz9+gIz1DcoWVZMzqoe4iP8bBnSzueFpZCMazMwFiqU21FmcXkDXeRuM2wzt+8hbMgbqRaAyiYDptm5sm+spHxVRcwIGMeCOhH9L1GUncFzQHoPv6G+FwEVCPOVNiZx7yNFSqr0FMSu3mtNf5zNXtxz1+P/VNHVaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125758; c=relaxed/simple;
	bh=hgbvC8iDFrKxaV+KfVNZntVp5bmwoVjsoy1QGfZwvB0=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=FpQe+Y79a862kZ0+LWq+6pfvUQ8cJYxzRT5vRGyc6YDnpy9pv7fsg1zHlwFtGol7qLhFXWN9MTMPICaub8bSrpsfCSnb3PhaiSBYF4ATEpfy1lsYSi4GBVr3YECbLwxC6hcMtFr65rdVbv7kaGLIOJzLQx9gCqbU0ph1Jwqfa0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com; spf=pass smtp.mailfrom=criteo.com; dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b=uWYZ5dny; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criteo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b="uWYZ5dny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqhA0m1X3RgciaM5YS0NjWLrAWLU7hojMu0hNk6jWbDbT3R/zwpmpj9CVuIuEDN/KjTmBjhPwRkpC4hlqMHYpWoiO/e5kRZbNvQOmMufjeLlYNcNAVQfBw3xH8SDT06lWfxmPP2qwfO9DtXDrPf+EpcnAqGoGf3JCHYowhPhtWuoj/9dWtZoA5L93ylwGzmdjyNnxCpkzCskNzxvPLeQXf/sSOz5DlDQ2uu5DdqTDXVSLYL5KPO3qreSgjhLOnzbi1zM/goIXJXNpVgli4osqYSRgKTt/gZv5UIjm2FmPRCmRK6/7As/uPxK2T6VpVq4nlUhifMlkKhqCtM9ADtKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxikHiR2JwpXyMRv9EREncIY52DgvHUIda0bIqKNO6E=;
 b=BGWRNb+WHLa339X63GDfI3QSeIT2BSsduQt3gnBuP48PJCSGD07gxanj71+ZByl8swEq3YKK2I8PpAX+prmMHugUItcept2Nmapk/LJdZBooCDmA1AHbtWpk2JCM98UStrFQZe8Z1k5BDm6MG3lbg8db2opso3Weu2ywgi+wFOzaMUIsJ0FfjNqE8LTOYjbrmchaflDfnvN2UKFf0RBqU6lEH2AUuTsjFmik5aR9A9/29pjIi4hRyYwsiDKt/pbOxTrA9AlrTifQdtx0dWEXz5UQZtNBAqWm6N3uoFuIydfjIZNA0Ajy9ge7O3+n77EoHHVynwVb+rEkMADhnVEN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxikHiR2JwpXyMRv9EREncIY52DgvHUIda0bIqKNO6E=;
 b=uWYZ5dnyv1v08cilw97P0UXrt+hDEJ401ytIjP//QkWXqVlS5G1siJPZBHe+zZpPGNcNR2yYBREka8Zi/6EfWVgrzAQjDLAH3n3dzVPyM/gj4y5xE0EHE4X2YQUNhE+J8YCzahT4nqInnT9M6CWA9mJPjU9/cACQuhuqsZaewnEhNzMPG+2Wb8EVwDSZenEiDLwjoDR8yNtzExECmZK9RM2Sk1FJXe3Laa3oAhTHvDu3Mf54eNC1VbckCLi8dcAOBuntf5vIatVvGK3xZe9KZ9+m2slJ2RBSJc5o4KhVgQRXNxP0hj+thnOWFZ2JEye3+G2+Wcfsoekf30EhgFbR8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV2PR04MB11592.eurprd04.prod.outlook.com
 (2603:10a6:150:2a6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 14:29:10 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 14:29:10 +0000
Message-ID: <d4ec6ce9-7c08-4c76-89eb-7bff345d397a@criteo.com>
Date: Wed, 15 Jul 2026 16:29:09 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Adam Li <adamli@os.amperecomputing.com>,
 Peter Zijlstra <peterz@infradead.org>, colin.i.king@gmail.com
From: Erwan Velu <e.velu@criteo.com>
Subject: sched/fair: Only update stats for allowed CPUs when looking for dst
 group
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0111.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::13) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV2PR04MB11592:EE_
X-MS-Office365-Filtering-Correlation-Id: d51a2e7c-1e5f-499c-6757-08dee27d6fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|11063799006|10067099003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	32edryfvB/sJqCDeG1dgYwPj3lX6bLKJ1Ec6ot67JPzJrr8Ar6QxlEVrelpCw7MKjiNGEdpgtiVNYXoHomTOgAdlMXMW2QhyT9Wr4QCoY0SaQ8JThok3Qhh/ugfg6UK6JUBN0E79v/hI68SXLL+JlcnJXrw2aTMwvZpto8jDWyF6SpAkynvDKskhBYfdC1d3zTWotCwYBQcB0pgcx4qr5u2+yIMMZ+QGtCY9B+G7IX3WM8tRy6lEHpo8sKyBdIpvu5fDZrl18b9olznrJb51XW9Ojyu3/UUQWjJavODcxBVceQJCa4PvcIa+5sxxkOTIGqIz0zzKN+pN2dWm7RFpwbfOCvE1gT3edXN74SyM41RRzEq39j97QLih1GM5NEnUEgHetdRCjokhr7TAhx3G6RicPeQLVR7sIvpOkWFn/DESCmHrxDtKq38xmBh926bpK4wZStXX2mKcWNA3CXNxUygOiO0AhpBfc8EvCDZfz1MibtDm3Mnld/IqsdvOyKlcPd+AYrvsPiwfCz2zewJm8uAnyHJOuiEPQuKqifwgpiYnDhQDPpaOlRV+vpngvTY5dXqkjF/V+1/lEVpewx3fP4hBWj7HkQNL+h+0vGj/3tCi/lHNeyh5SStEzdeT0GErSdE5yuoP2uNnfEgJqz+hR1mUBV7MkY0rP2BAgOf2u+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(11063799006)(10067099003)(3023799007)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRIVG9OM0dMakRFQm9jWjJpckZVUXRROVFzVG5mU0lLVVFVNjFYQ254RUc0?=
 =?utf-8?B?VkdmVmJDRmZWbnpwNmVBMll0NGhlRHd1eUw2RkJHaWx1RzRZVDBRdHFvWVd0?=
 =?utf-8?B?dVN0SGdiTS9la25Kak9RMVJxOFB4NU0xQ01pV3g4Q3VGc2lzYW9EM25ibmVC?=
 =?utf-8?B?MURhM1hXTWR4bGlsWllnWElIUkVCdWxMVUMwLzA3RmZIU0x2c1R2dXRJOHpz?=
 =?utf-8?B?QmNQQ2gxbUhXK2RobVRzODVLWVNDTEhLa2c0SnhoVEZ0YUp6MmdTNklJbmwv?=
 =?utf-8?B?N2dkdEh6TEVNbnhwaGJpeGhkZFlJSzJ5V0RuYkZFQ2UrVVNSQnhHR0xYYVN5?=
 =?utf-8?B?UHJIRGx4NnhjWWNVQnowUUJiVW1sTU4rRHAxbjdaUUdSUStaRlFmUjNUZ2hW?=
 =?utf-8?B?MDcwMG41MlRHMWkweHpEZmUwUWtocE0xL0NrTHV0Ri9iNmk0SDd0Ry95a0lO?=
 =?utf-8?B?bFAzNlB4ZFZSZitMWjk1R082YjhnandpVUtHS0ZrZS85ZXpxWG9Wb2JTOU8y?=
 =?utf-8?B?WlkwejBJbzUrTHp1U0dzTWgveW5WVHFlZ3BHaU5KTjN2M01qSS9QbzlONlk1?=
 =?utf-8?B?dk9iSHZzWkdpbXNVZ3E2Umdyb292Zk1pc2J6a1JCbjJDcS83TkUwckx3YWV1?=
 =?utf-8?B?THlySEJiY0RrWlJWekZOaTUzOFNFM1VwblFtZjQyZ1NoRnNVamg0WkJSSitr?=
 =?utf-8?B?aFFVYi9STFFOL3oyUVNJaG9LR0JuWVNqN2p5RXJ4a1RxMFZqTFU1ZGRueFlE?=
 =?utf-8?B?QytRcktOTE9xaksvZ2VKaktPNzZoWE9XWXA1STVWWGllaS81YVBma0tNaEZQ?=
 =?utf-8?B?MkZCTzJSMExORVZvRW12c0tvK2ZTTmJRQkdtcmVheXBQd3M4cW9VOG5veHV0?=
 =?utf-8?B?YTUwWUs1ZHdYa2pWKzZueGJsZ0x1OFh6RXl0Q3UyWEsyWGUwR3N3SzRaRnJK?=
 =?utf-8?B?TW5FMGszSEJNL29HRkdUZDlZMHJkdTFOYXhFb2EydE90R2dWWHpMSDdFblAz?=
 =?utf-8?B?L0t5d2dRRzUyZkJBZHNNYURvUGN1WEx3UG02V2JSR0RVcjVSUEhYQ2hsZjNZ?=
 =?utf-8?B?QkFYOFIxa3cxZFhoSXdMdzRvTTRrZnFDVzFCT2ZNYnlsaE1teE9mdVJlUkFy?=
 =?utf-8?B?SnpGeUZUQlFKNFhpdGRwTlN3Q2VkaVFMNldybTl3TndPTVVKRFJXZllqdHlI?=
 =?utf-8?B?WitaZnRaM1UrajQ4aU96eWUvaGxhaHRTOVh1YjFpRmZJdVVNNHAzUUZjMmQr?=
 =?utf-8?B?aVVvekxzRGtkTzVZdS9sa20zN3pMTFNOWlRzbys2RmR6M0UvcU1hbGhYb2d5?=
 =?utf-8?B?UndmQU92YWZ6UW5xVXBXYVI1cEFzVE45c0lCWEZIUHNEUEJ6dGxwdmRQazZJ?=
 =?utf-8?B?SUFuU2lXZEdQTmRUaWNoU2J2NnFLQ0pGbVZhWmozSFBIdDZrMHR3emprL2dO?=
 =?utf-8?B?TFN2MCtPUHZPOHdKRUFzQnc1STQ5MU5SaUhHb0krRUNBRFV5V3RjUjJ0aWVF?=
 =?utf-8?B?NW5UTnF6OWxMaEpzaDB4MWZYdUNIMCtFdFZPNWUwMzB4a1V0VVhkQnFWRi95?=
 =?utf-8?B?eGNUb1JyOTBNcE5Oa25lVnhGSVZacTFwUWRJZ0R4cGZmSmxMYW9ZYkprclNH?=
 =?utf-8?B?US9QNDM0TlRYMUZZYUlGdDFZYlh5NWVZZTBBRkRyWW90aXNkYVNxVmRCemly?=
 =?utf-8?B?TFc1eFFXTjY0N2M2TGFZY3BzemFZT0ZPa0JmUlp2eGdGZ0dmUGpjOVFLWHhx?=
 =?utf-8?B?ZHZQZ0FzMXpoOEdVaS83OEhjWVFPSE0zb05zVEJpd2NJWEJkNVlPVDdJYXc5?=
 =?utf-8?B?cE4ralYvRmJjelJqMnNtbFFtdzZkcjZPNXUybUdXV2k4aVFSSXJHZTJPSHZ0?=
 =?utf-8?B?eUxxZDJpcDl1OFdseDEvQjVERCs4bTNDNDB0cndIQVEyN0IrQWVqeHp3Z200?=
 =?utf-8?B?OEFKc2VwMmxLWnBvSjd4Nm5tYU9seXlwelZuTmJGa2xvM2pta3RPd0xVQisr?=
 =?utf-8?B?dGp1QkgydVBheHVaS2pXR0sxL1dlMS93MXNTZXRQbko2SEJxZXRSTjU1Smx6?=
 =?utf-8?B?dlNTaTV6WEZCUTZVaTlYWS9Na2FIaEFnRWVIaWMxdGlFOVpoS3Y4a01ncEdW?=
 =?utf-8?B?VjltSUsxNVJJQnpXMFBpR3lIWUhxTE5qUHhxemNwSGRpNllJRmdNRGtQUnZI?=
 =?utf-8?B?QUNtV1RiK2tremlCc1dEYnRsM1p0ZER4S2xCOGFKV3R5REp5cERoQTd3Uk5O?=
 =?utf-8?B?UlRUWDcydC9tRGE1ekNINkx3OERMbzN3L2FwaUhuMkVOVTA5QmNxSTVsa3BZ?=
 =?utf-8?B?dkZldXRxSEhOUnFlRjdOOTFXUDlUaUM3RVExVVovUHh0SXBwVElhdz09?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51a2e7c-1e5f-499c-6757-08dee27d6fb3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:29:10.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sgx3fw+UB9CJt64l9OBjLFLyAscIqxYiyMpqSSIURDIoSX6yT/3tJopOY/utk+FdjPAskTlNGuIOnWfrbZPcUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11592

Please backport commit 82d6e01a0699800efd8b048eb584c907ccb47b7a, 
introduced in 6.19 as all stable kernels are affected by a significant 
performance issue.


On systems with large NUMA domains like recent AMD processors, all 
current longterm kernels are affected by a scheduling issue that 
degrades CPU computing performance.

I've been reproducing the issue on 3 different generation of processors, 
and study the impact by applying this commit on top of the 6.18.38, 
latest longterm kernel at date.

With a very quick and automated test, I can see up to a 20% performance 
difference on the Zen5c machines but if you look at the numbers you'll 
see that the

coefficient of variation (CoV) is also greatly impacted.

The CoV is useful to study of how evenly the workers performed and 
you'll see that all systems are affected demonstrating how unfair the 
scheduling was between the cores.

You'll see that this patch can divide the CoV up to a 10x factor.

Please note this issue is not tied to AMD systems but I used them to 
show up the impact of this bug on NUMA-aware configuration.

Kudos to Adam contributing this patch.

Kudos to Colin adding the individual workers metrics and obviously for 
Stress-ng.


Please find below the details of my experiments:

The following results were generated with
- stress-ng 21.03 with commit 6aeb52c7421897e6156a225f2d00d268bf14721c 
that introduce per-worker metrics
- hwbench : https://github.com/criteo/hwbench with the following job 
configuration:
     [global]
     runtime=30
     monitor=all
     engine=stressng
     selected_cpus=numa-simple
     selected_cpus_scaling=iterate
     stressor_range=auto
     skip_method=wait

     [cpu]
     engine_module=cpu
     engine_module_parameter=int128

Columns (all values taken at this scaling step = 384 workers):
   Trace     = trace logical name; '*' marks the reference (first trace).
               'baseline' results are computed with the 6.18.38 Linux Kernel
               'patched'  results are computed with the 6.18.38 Linux 
Kernel + commit 82d6e01a0699800efd8b048eb584c907ccb47b7a
   Wrk       = worker count for this section.
   Perf      = benchmark performance (unit shown per section); Δperf = 
ratio to the reference.
   Perf/core = performance per physical CPU core (physical cores, not 
SMT threads or workers);
               Δperf/core = ratio to the reference.
   Power     = mean CPU.package power in Watts; Δpower = ratio to the 
reference.
   Perf/W    = performance per watt, as a ratio to the reference (Δperf 
/ Δpower).
   Clock     = mean CPU core frequency in MHz; Δclock = ratio to the 
reference.
   IPC       = mean instructions per cycle across cores; ΔIPC = ratio to 
the reference.
   CoV       = Coefficient of Variation (std-dev / mean, %) of the 
per-worker performance:
               how evenly the workers performed (lower = more 
homogeneous, 0% = identical);
               from the stress-ng per-worker detail.

All systems are running with the LastLevelCache (LLC) enabled in the 
BIOS to get the most precise NUMA table and map each L3 as a domain.


##################################################### Zen 5c 
########################################################
   (ref) Zen5c-baseline         2x AMD EPYC 9845 160-Core Processor - 
320 cores / 20 NUMA   scaling 32->640 workers
         Zen5c-patched          2x AMD EPYC 9845 160-Core Processor - 
320 cores / 20 NUMA   scaling 32->640 workers

### cpu/int128  [Bogo op/s]
Trace            Wrk     Perf  Δperf  Perf/core  Δperf/core Power  
Δpower  Perf/W  Clock  Δclock   IPC   ΔIPC    CoV
---------------  ---  -------  -----  ---------  ---------- -----  
------  ------  -----  ------  ----  -----  -----
Zen5c-baseline*  384  395.66K  1.00x      1.24K       1.00x  568W  
  1.00x   1.00x  3274M   1.00x  1.64  1.00x  63.4%
Zen5c-patched    384  470.31K  1.19x      1.47K       1.19x  568W  
  1.00x   1.19x  3141M   0.96x  1.31  0.80x   6.8%
#####################################################################################################################

##################################################### Zen 4c 
########################################################
   (ref) Zen4c-baseline         1x AMD EPYC 8534P 64-Core Processor -  
64 cores /  8 NUMA   scaling 16->128 workers
         Zen4c-patched          1x AMD EPYC 8534P 64-Core Processor -  
64 cores /  8 NUMA   scaling 16->128 workers

### cpu/int128  [Bogo op/s]
Trace            Wrk     Perf  Δperf  Perf/core  Δperf/core Power  
Δpower  Perf/W  Clock  Δclock   IPC   ΔIPC    CoV
---------------  ---  -------  -----  ---------  ---------- -----  
------  ------  -----  ------  ----  -----  -----
Zen4c-baseline*   96  107.60K  1.00x      1.68K       1.00x  160W  
  1.00x   1.00x  3094M   1.00x  1.40  1.00x  13.0%
Zen4c-patched     96  111.74K  1.04x      1.75K       1.04x  164W  
  1.02x   1.01x  3095M   1.00x  1.39  0.99x   1.4%
#####################################################################################################################


##################################################### Zen 2 
########################################################
   (ref) Zen2-baseline          1x AMD EPYC 7502P 32-Core Processor -  
32 cores /  8 NUMA   scaling 8->64 workers
         Zen2-patched           1x AMD EPYC 7502P 32-Core Processor -  
32 cores /  8 NUMA   scaling 8->64 workers

### cpu/int128  [Bogo op/s]
Trace           Wrk    Perf  Δperf  Perf/core  Δperf/core  Power Δpower  
Perf/W  Clock  Δclock   IPC   ΔIPC   CoV
--------------  ---  ------  -----  ---------  ----------  ----- ------  
------  -----  ------  ----  -----  ----
Zen2-baseline*   40  40.95K  1.00x      1.28K       1.00x   150W  1.00x  
  1.00x  2841M   1.00x  1.10  1.00x  7.0%
Zen2-patched     40  41.99K  1.03x      1.31K       1.03x   149W  1.00x  
  1.03x  2855M   1.00x  1.07  0.97x  0.1%
#####################################################################################################################



