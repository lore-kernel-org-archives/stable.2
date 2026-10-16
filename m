Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095543B489;
	Fri, 16 Oct 2026 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136850; cv=fail; b=UdGAIUG5vr/kNs8EeluAfLOyz4QpG6IC9Gm/5kKrxUKPKnFWJx13Af3/KihU7tkevDT+TSKuEGJPGdCBYL5fryWtLSOGWVzAcDcPQy5wNWXkzCXbD6GPNLN4Po5ZjTsHUeN4CyMcZ0vm5q5RzUNog5BBpeY4CtHCqy0wpSZGVzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136850; c=relaxed/simple;
	bh=W6vsPBvFTL2rRCM0AecXhJIy0Un82o7i8dgRHddypO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQqBVUpNkht00zrwQY8leHdxTmie12m4PCoEECqD2heK0QbbRrTq1oHXXGoPTpwirajtRnFSczujviCyRX3k8+V9w42Fj06waKcBgq4t80ki3fzfL44u+wjpELKMYdo8zIIQd45TMyxvZ73V14g4Z0fS4dBEEv0Eqk65arOl0I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gI6VxnQH; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gI6VxnQH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4lr5BsUxBX8jLTUcipF6+HmyZdWEXdVy7dj52CRivBlXb6e4QTCE8VDFxA1ybMp3Pi1vxdt4Yb5mQ1kGx1dWPr5uSwdxO9aDV42dmwmXg0CeR1+XYXJFoCVvzYk91uC4Fgww2XZRtVBzLdfIpqFKN4/WsfCYbMsQRL0kRVuKRcGALs2UCITJvJpa9JR5zEPkElXvzkMiadCXoyWHJveG3iwuYnRJa67X2ZzAgFBlz0o2GYbH685nFusup8Y+ezyRBhlLUObNjdvylUs0Q8OHf8G0NwkWaqGY9acETAJQ7g1kjtqsBIITOhoMcqwcNdqrDlsjKB0QJW+7xNIV+x5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsjebrKib+0+x2zlZxj21KZTzI6GPrJ/pEXrFeDq7ps=;
 b=Fw+/FKmv7+zuIMuY3YBOJz1sMnQgTf3Fyg9SYiQAdPgRkN5iI4I+VccL0vCLF4BxdPTO6D3HxAdHWjcPqZJeWZHGK6B3XkF3yspcJr0dTWEJeRPit/uxuS7BOkGYu5e4JLPXzbGWknM+D9Os0iHiaKhUVEcp9HEmuKxWSkUnKoQ4nxk31J/Isi4s9uS8/iQCFVaBvkyz7h9kjn2ufoBdzkFd2Y1tkMswvlUjhvphjQVm9Y2wxLF7vcVCwSck2kAg+dbbSkHoxv5lbGf6C+PUSLuRKuIOGD/IL7IHVUlsJ4dQP/r4jAC8CXtIzJhoNHTbFYWYI5R1oOWJfLzs6Opuyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsjebrKib+0+x2zlZxj21KZTzI6GPrJ/pEXrFeDq7ps=;
 b=gI6VxnQHru6CbVW6+ANkKHgJ98zUxkXntLpJsfURIylOx/agUNPTACYFQSvu/fZOywuZ1buLQtHisry+mruGZciUmaq13PIvGV77AY9bsnZLP6D1eOep+UKcPTNO6W+0cMj0+KeGKANC1jXKkJf90WNEuEtDEBQ0L1MISEbH/YD7EXHseBUwadjbx14bA5ACV1hXgSvC08d9o+drVIv1HHwQu7cdxwhXJ8FocMBkyUkTxV2ewGqGkas58g4N517v5aNjCFa9tMooTF/tONyJ7ETvu3DWEJeNdI1Oqs9asphkPbj0rQCMj0w59ngkG1a8qoajkuXd+0ByIC7JQNQJUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:47:25 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 07:47:25 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/6] gpiolib: free the label of lines released after their chip was removed
Date: Fri, 16 Oct 2026 10:46:50 +0300
Message-ID: <20261016074704.1860749-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <as5QfrAaQQO_q0dr@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com> <20261012-gpiolib-chip-removal-v1-2-aambrozewicz@nvidia.com> <as5QfrAaQQO_q0dr@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: f131370d-6822-4092-4df2-08df2b59b812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	aiyuW9RK3dV7g4ebKhpSw8wSL0Az9zdyp1QaKA7nAsTANCpD3gH0vLRDrTSrMsykY0xqIqWajQeraTOBK3XlEnlirQAGfu1GKjoHdLNhnJGxifsmyZuOBdWwXdhzivdzhPC6CHPRD4sHjzJsCrrRsHA2kz0HE6Pb3seSNsKZ3tbFwPuG2KJLAXvNrsSb6Hih/1+hV1Id00o8i5OYIaBr+KXq6GeqaR5Pv+F8twKqf/bNfGbn97x1HtuOK0jpsvZTF10Uh3QfXxMoLAB/CrarYwTLv82kTWFi2ivPna3T+PQMkVJg4GG0I2vib/pakxBp+6gfxyoic6utf7EZcCvQ63NJYHwxMmW1IsLBpYKeSTwgK7XhLBUWRdt/PmJFgJDwPCofrYyxY6Us/OupDF+PS3WY9YQ75KlxRglpm1ftSeBkvYYWlb88rnBxt6ByHyjot7UjvZQj8XhVZEu/zAzbWz+DOlYPo3Ah7x83VYhD/WG75t/XdUveTmrHNVRU2Y9gpusQIZjXcthfZKiUsw+E68cpCn/kVBfW3EkQeZrNDDRJJtapmzyI1v3CN+G4ZQGpZDYMDM18h1yYldFERkkzKJcbyE74GaEWXYuHe/cU8SGv/0rnuMUxdU2aIO6ooGxRihmy6EtytFYuhPHJ55+bjao3PJBKpMFnR2cuX3PGhmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o4mKvPAFEQzoHjq6RD5gsDKL9xf1tJgikM9d7zX3ZMd8m4yMSFmeGHKuk5Ht?=
 =?us-ascii?Q?wkya/Ggs1iYAUO9na5ZzbJOQ3Ic/squnkdr3nS7ykIyqkTwcIMiq8K0gsc7/?=
 =?us-ascii?Q?onQBm6ZLnAkqjvN3XJAUnZ656q7CRKiibQ4nEofY1VG2m5q3/JT1Xkxlr092?=
 =?us-ascii?Q?SJmAJca9NCZ6H482qg/uys+4rScxJt6w5ewFz1tY5V7piZFjgzgA81gsknMt?=
 =?us-ascii?Q?Qfv+Icr+WLdFujLXkPNicm7EoKq2/hPr96kzH+hD3oO1bt5uLwc2NCq84Ts6?=
 =?us-ascii?Q?KCS6vdFRbGmhtoxn/jSmVtDPN1tLHoNHbo99a0m1USxyM9ipPqCrhtb3m/Ti?=
 =?us-ascii?Q?xLEIrGRIkEdgshNX1Y1d0qu+b69UF9NN73BdXB4D6NTxDIHteO6Y9UZsQ03u?=
 =?us-ascii?Q?X3b9dQFPEeoDPaJXPrtmflIPK+i3f8f3KW2DHPS25mG1B6lb+/mgckI49ZT6?=
 =?us-ascii?Q?8suR7efPmKMUWPW5sq+dFJTrAAd5vpfpSc4gZoS7loBT7cbrsPdP0UwDSrkF?=
 =?us-ascii?Q?6AfS08In43SGfD0DPnfU1wo6HuBe+T3pyHlUZKRZW4oR5WTACJmqwW9hAY8n?=
 =?us-ascii?Q?dfcfEZYkC8osY1oRki1TcQ5eupcvv2HDlUlIVApGQ5Hxk8D/I0zMxSEyvZzN?=
 =?us-ascii?Q?lk+T3sZ/uLDwiC09HHJnDjorMLU/5BzsP8ANIAv6cUIbk9yFLd2QPhhgIYml?=
 =?us-ascii?Q?bPuh0vrsJ0uTzVikFAVSwIYjKi4ieYceJOjJd0p9AcW7vg5UuCl7QN24A1vv?=
 =?us-ascii?Q?ZFRXWpYirnUPVC92TOnyUrGNvMSp4p6XALAhFxYck/apcJ5OF6Fq296PXl2Z?=
 =?us-ascii?Q?erGgcKtW+5HMEyWg9wF8nBNSeHhlN6PXK34qjPMsz8hUJUIlv2aus8ogT3ae?=
 =?us-ascii?Q?VlPEIPy7rrObFWWhmv4g6uvQsJD9uet3RKYBHAyavt9dKfnb0QW2f5A9Ukrn?=
 =?us-ascii?Q?Fr2RCLrnAUS8jC4Z3+DrKM2Q+oT4PobkSiAdcJz8lBW2JW/9JZN1ywpZg2JZ?=
 =?us-ascii?Q?Za+NGMVEBOnVOCE6HXHTAFLYIHvNCfeiXoPshF/elJe7hZsPYEJmIkjeiLcJ?=
 =?us-ascii?Q?x5tX7xYTkivp21YmMAMqEM5Yn+5w5wmoIRJR0PDzN+1qZtjehZ1KlanyT9Cw?=
 =?us-ascii?Q?DfXtg/jBmnnbmEXzWNPAcBo7JeeIgfXDOA4oxd0bZgePF47srurW5U+44Jfg?=
 =?us-ascii?Q?8nMwDDtlZt7TMN1ic7hiP4xJOjh0HZLEheHfsUkvR9EyK1dy5vka5vH1WqLb?=
 =?us-ascii?Q?s5LXnFp/8rqPJMk2zgoS58lbqVbnz3TL+vkstt51vWZyQSCXsavy6yrkG1kQ?=
 =?us-ascii?Q?737sB618PF2wZehW0HKw7U/Z2wRUq2BRqsiyX2jOlAWA0FYnWP+HdG7FHkPe?=
 =?us-ascii?Q?CizEOq6ne6XRoB4d558nTgl4hyGw1BGw3qb0g+lfdKgH1CnWPB5Ssdc7Wq5Q?=
 =?us-ascii?Q?uJE12gY0ZRk2UJ4bLP2xvfJw5zh4AZRxcgiSFpL16uMJ4XiwI8ZR1xr8fyI0?=
 =?us-ascii?Q?VsOGpocyiJy5nIfjTZfPTxibIpw3WMsTd7FX9VZB3+XCKVJ8021zpBvkSA8t?=
 =?us-ascii?Q?nDLNivTYOTKGrXyva2aPbcsCKbVL4H5q75aQpSISTeqDN40gI3SR7VXzw95p?=
 =?us-ascii?Q?r/HKH2+jZ0j5brAfmj8E2ZXhnZvOWFVrH5oE0wbt4Q6FmsgvDBDxDGi+emvA?=
 =?us-ascii?Q?6jVwnRNV0eaJpxj7tfeF6itL6Gz1P0lZNmgbLyFrdXa7UCBpn/QZlbvEg2uD?=
 =?us-ascii?Q?qOWXvmef8w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f131370d-6822-4092-4df2-08df2b59b812
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:47:25.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUd5PzvstaE4vrtey7/lVPleOzsrdE+F3TkT7iW1Ppwgn5ifaOm1dQCN3c/UUZc1HvFOJeoW3nafSFxX39ctSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

On Tue, Oct 13, 2026 at 06:38:38PM +0300, Andy Shevchenko wrote:
> I have two questions here.
>
> 1/ Do we still need to notify user space in the case of the chip gone?

No. The notification goes to the chip's character device files that
watch the line, and once the chip is gone read() on them returns
-ENODEV, so the event could not be delivered. It is not sent in that
case today either, and the patch keeps it that way.

> 2/ Can we write the above as
>
> 	if (guard.gc && !test_bit(GPIOD_FLAG_REQUESTED, &flags))
> 		return;
>
> 	desc_set_label(desc, NULL);
>
> 	if (guard_gc) {
> 		...current code...
> 	}

Yes, v2 will look like that. The label is then cleared before ->free()
rather than after it. A requested line already shows no label for a
moment today, between desc_set_label() and the flags update, so I
don't think that matters, but say if you would rather keep the order.

Adrian
