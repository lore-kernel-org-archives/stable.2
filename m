Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EB342517;
	Thu,  9 Jul 2026 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579168; cv=fail; b=hnMMlobyaHYVjDImdal0uaXLWl5X9zgfyd8mYUAPRCGlRJ1FWDpTR8FuH89XF68s5OEknAsb5RuW+YWWYe4wI5s+Kf6svJCyBxKehceg03RPyXMaP8rBhecrMt2VZEVh6HGHLsUrC27SD1Gf8rhjjgMWwLw0592a1w3iaksLalE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579168; c=relaxed/simple;
	bh=nLxAGq02UTAZe7sNUEeF24KGWgjTshi60BEiiL823uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9ZaGT7Cuii/NM/rFAnZgNl8cYYDNXY+Bzz+2cZUJJk+zR1TPsfZVLVhKIVQCopk6J0sHdpK+0FGTz5x+My4wBHo5Daf6xMrhtboqtkKNQp9vu/X7AcwErNnT7pphcliRf8I6diLONw7eYDpsLulNd1LPTohVqynnLrRPTnrXKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gIdNiNBB; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gIdNiNBB"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66963X9E1680397;
	Thu, 9 Jul 2026 06:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=XsuM1kJyT8BXv5Vl3zoBmzHNDjpQT5bcYzL90Y1Mtkk=; b=
	gIdNiNBBBa767MsJiHaCbNvfgAWH7Bw/ifO3LU0sghoKtzu+tnFIdQkBqEha69Wt
	IflHZ8VqZCeEe3UBEmL3EL4nhpPgjidgBu/43/FmEUzh7cikmNCuRprajySEXd9t
	P5uHhTJe7m3e3UX2hKOpORpJgkiF0lVsBmCLmqJfD+S3pJXvSXBJGdKFrkx42Hsy
	cdFmnm+i06RdFWwNNGSjDKH+662emRpOUFukmLmZMHO914ZxvRDB793qizy8mtPG
	CXSgxcT/HbMmhJF5/6fzt6MkKsHjWNveekDvt8NjuGOfs928HqUbLIWc7ETar9DX
	V52uJr6yp5KQqSj1X4qU6w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1aq8cqr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 06:38:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu63pgYRM3sQ+evvJleQL4iMF3Tuo0zsuY0pSpUsPpTdz2YVIMZqWTxuqFcUTjA8Eo4xY/24BppJRpY3E0Jzl/ChhI1sFk3SKMhtIJOHUB4eh2axo24GX0U4Pg04vzDDRBFlJXobv3pPpJ4gHMnvFi9dso2ZpX5dyYFOY61DUuricJ2Ompf6UVWi0xIBwI3z4eJm3v78H+xaqfr4al4698xINAT3KNQfnwbPbi87AaIkTP52TuZ/nLa4+cmy8Q00Xr7dN6dgFFPhw/iVduSaKfIwpQ/ys6MUIXM1j9rn/Bw3vzcmFQ3l1Jt/7PWyFY0/4fVoPvPJeJPqj7EKmeYRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsuM1kJyT8BXv5Vl3zoBmzHNDjpQT5bcYzL90Y1Mtkk=;
 b=fFqFRAStZjD1CeX0rPlwTwJznyDXARqsyTZL8/7mbAO8A10gzddTX8X7acWcSHdcoEH8sao/e2geM3nADxqaEOrzlC2nUB5sD0lxz9sBWH3cqgZfXUbTk1Rdr5nM7K/yntAoz33b1kQcwjsjzdnU59Y3JCtARAjD9C0PS3F+0iKliaqKd6BLX4+EJTnrPNkhi+9dgjEH9B63T9Ij+IoUqR6V3PFSZ/dDFXI29zsZIzdcn62MMdCQGHBRsYYj1kTHcBwl7m8WlmNdlrCzm2OBiiJN1lYbgcZ7KnbuE9L4hK25cRCvG1w5C/rKSDof6HiTPMksUX1YMniguk952aeCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH7PR11MB6401.namprd11.prod.outlook.com (2603:10b6:510:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 9 Jul
 2026 06:38:26 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 06:38:26 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: bigeasy@linutronix.de, bvanassche@acm.org, clrkwllms@kernel.org,
        rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
        mkhalfella@purestorage.com, chris.friesen@windriver.com,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v8 1/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Thu,  9 Jul 2026 09:38:03 +0300
Message-ID: <20260709063803.23538-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709063803.23538-1-ionut.nechita@windriver.com>
References: <20260709063803.23538-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:50::18) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH7PR11MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: beb20cab-6e8c-4ed8-2f86-08dedd84adf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|1800799024|376014|10070799003|7416014|366016|22082099003|18002099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	KckpaHe0Q87whu3Ueox4iq/dIzHbwJwURi/353uANYs9dN7dd16sKY/UTbD8UJNcNyRVEaNLRKAwfZCS/5cVT0PmI9mSWO/KeRkjpWkdaGtsdog1tCR3PnNRJpA4t0iRQScRPUkCURk6x2XmHLZpFJxKyNRafU1QnPMNBZL2ZumQsjrbAFy1dG8PbuXZhdMqt5VAanDz4xnxev/SC5kfMg3/7F5Js6aiy4D/s/3sbXMohUPDv7/bTeEbAFkLspmC4hhTMq1rYNAsILW9dHyJbu3UN2NVl82alOzVii5cyRFdJgqu3J3g7OwJMDxvYS41stAlmPhJFr5hwC3zCqAd2tTtQOxu1rJW2FnE1w0Uf1Zr4GVdhA/bF/dpUoeFOMzbq86ziqL0XdiTBfviUdBK1Oa0MDBmZGWNwfiyFwIbJeGJYvtLlZlQZk2bQh2QkO3SMrt/xVrMWZeyjuzbLS+9xnogvw912bGnaalfNLEbICpS4vgUqk9CYQSLKNa+be1UKGcQ+aD4kbK+jrsnkDeUK8cZLf8rBNtSsDdee7r8tXD7T4OtcDcuPaR3mjNwu4a2yoq52TPt0E0U2h1nndnAB9xKKpJE9XicR5a21DJsRg1oRgCx68nFQ0FHA9PBVkc9xZrGScKSLQAJevnaHkXHvvti8oLrchq38gyqm/34R7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(1800799024)(376014)(10070799003)(7416014)(366016)(22082099003)(18002099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a7JF9IgXBTdQenDWb5OFDZotRAWiZ5faM86SkclQDifDTlA+H7XprRezwfRF?=
 =?us-ascii?Q?hWl3FFFF+wDxI60WsYM7PCO32fqsUEWCrLP13CAdEq3b9dzCfyd/o1YH/dvt?=
 =?us-ascii?Q?0Tlppya2fjAdR2ddVJp38M/lC1EDo0w5NOCVEoMrwUw7psA9YfNz4dN7gjBt?=
 =?us-ascii?Q?wmM0fmCMJscgdEl6yRpP62lcHc3bJPylxPNJVgNgMYizcwt5yQUeRUt0Y/N1?=
 =?us-ascii?Q?KxKKFcL0O06DaEtioICu6ChY3zer4yNth8jb++hDXQabXd3M6jfn2ibkS1eE?=
 =?us-ascii?Q?oUeJRnn+r+lSuO25w08CaU4IkpnSxGPAe0HRXEJBqnhg2D/HpiNSvaWGhvIy?=
 =?us-ascii?Q?wqlRCj095FhA0iguGfxj7RaUvZCfR/2zX9XZ2/EmMqQG3qmNr0X/f0vro2RI?=
 =?us-ascii?Q?c10AwdwjyhbTrd58reFvqmaDKI4sMCHtFWngny7sfzuwAHy2V1kFGLd4W1Bt?=
 =?us-ascii?Q?Bqsj+DrwPivSAeGBC8KjmNPYNXkuzt5HkOeSS7GLrcfbzJjIb3Lak4cyHllQ?=
 =?us-ascii?Q?V7SnSvvAOK5Xx/dB4Xnp57BTMBPaMDrEbJfKEcysZcPOdstgeY+DiElHS/i5?=
 =?us-ascii?Q?GlZzyPpb+F5AV3ttEaS+7jOGQc0QuXNCKP6RrtwIdP3w7YJeNC6CagQXlJfI?=
 =?us-ascii?Q?Jq59SldUkdfWiOVBrAvU/5dkRWvNH/dHoFlcREyKUXwLjyv/oDGdx23GEB2z?=
 =?us-ascii?Q?TvQS2cYMfpLSG/eewAxmnbOQOF1P6kD9OrtwkFeD4QsKCfa4k8g0dro5Cz2z?=
 =?us-ascii?Q?5J45SnmP/3cfwNm3dtDV78CmC8fOrx7KXo9kvSRqcTjY6IvSgNOGixpkdfd4?=
 =?us-ascii?Q?2zQfUXjAiFLHL4klIngHp4J9Lhmy5R5UNS2fA0AIaLBS2HOwOn+PnRD8rpmc?=
 =?us-ascii?Q?sJVsNR8gnEnlIkQ2CRqD+7rlyopVNyH4j5aopkql0PtJ2xmOoOvsmfqHOY3E?=
 =?us-ascii?Q?ZjOYJUHYNmongRZSHsErioKOSp6dSPS30hPo13K3BlGg7fkJTtB8+zeA6Vmn?=
 =?us-ascii?Q?l3hzM12RJyl8QChTPs0MsB+SCeRxiHCfDKjM+LkU9bsKCvZKeqryWPgkisw7?=
 =?us-ascii?Q?ypew/VkPzr4Bd7gu5S3/GXx1gaLincjdBGtCCGU713Xa1wQLHBdYhupS16o3?=
 =?us-ascii?Q?A6fgYMlXrIp/BebFZ2sqDzq7vHMDsl6ujXLnXv7YXxGxp//Dee3z2JMmP1ch?=
 =?us-ascii?Q?pOtuKhw7rziGLuHLxy8EMHN3roVyyCImIzyqC9GisIC0Z6f1Gn8jECIcQGF/?=
 =?us-ascii?Q?NYLYuXDrx0BiRI/X1e2lYesXV/4qhoE16lIgG90CBjaHe4Iu9Pc6QRTJlfVH?=
 =?us-ascii?Q?CVNu994kvfOPxy9WusjevghrmbKQPNa8hAxhQD5B8X+BoMTPMENUDxmHCmMi?=
 =?us-ascii?Q?H6DX7NVnBVPWc0HJFXWcxLcjjBLI/3e7+caUWqMzusT3Dom7RBZ0fGiZQrGZ?=
 =?us-ascii?Q?vACLhKg8LcMMpkvYVrJ8iOkxbS9t6HXOEBoAqFQm1J0qUL2gK4o422vK4Cbk?=
 =?us-ascii?Q?YBfAD0Jjwjhc2xZGkaSB9xbWe1UUF9FLksQeeuCX5oKDQ2v9Qca3Wfgk/gIE?=
 =?us-ascii?Q?+sn+5RySARuhv0+p44AmD9N/xVaM/gtt7PKSU/f27cos7rs3X34425IyHhJs?=
 =?us-ascii?Q?sxqqkrXx3xHjYUNOMOPsvowFarN/avR7nXA1nyVSJMCt+2OWL2u0pYiwsBQF?=
 =?us-ascii?Q?BpEZBRyI7A1TXmwIfppwTdkg+MsbwAQG9mOJkHqp52Xxq+DuQjNwwNktqi2E?=
 =?us-ascii?Q?TyeuGjXbWuR2ec9VcrUI0TaCcwSvXZRlhr0zFAQl9V7yV3PAn6dblbyUu2Q8?=
X-MS-Exchange-AntiSpam-MessageData-1: 7g4E9Jlsk1+xQQcns/CabonufI4wZQjwKA8=
X-Exchange-RoutingPolicyChecked:
	fIUfrBZKygrNthn642l1c0/yP8cu/Qi01MnBqmU17B+93gmbRBhWJ0k68hHgI1UKDah80m6cRh4RpbUXyUEKNRFXvn7w6Pz7xQCWpri+6/90FocakKCtbfiCdvHqfTAQC8k27AdTIKOt5UEWv5K93lOMr20uPOT+Vr78SzeL539UxKoLA7F1ILIbFdxyEm1C0qoSRyNntCr/vnRpd1cqqeEzHipwHmNkhoz6LnmyFLNQnq9GX4LjpKfL0sT+HDifvyXvxORkN/OfUHrOpWqJXmkMGNpHUruE3nNN4DCKlbzjM67wDBZp0VRuw1tXD2dbasp2StL2SfxdLQQnmnhmEQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb20cab-6e8c-4ed8-2f86-08dedd84adf1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:38:26.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sW798PAdHeO7eOpu74vkiLW+nasqR9nNhIwvfxWZpEDAMNF8XajcZvbAAHNFrqSEQiiF1oyDi8nqA4YPswNuI36uU8F23SiKjbR9zRvcxNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6401
X-Proofpoint-ORIG-GUID: bHjRv6kD6u9bO2qZ3dDB1S4wTyPh5xql
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfX57kJvvIX7anI
 4J4DkTF2722n/jZxpgaoeaNl8GEYhsU6ajLZv+TrvZfRrjaKbTWMDnCTWKqQbIKKnEoz/K8ztso
 ARrF6XJTYPJk1RQqZMpYSLPdC1gVbiR/7LWc5u4f8xZ8woq+9SQn
X-Authority-Analysis: v=2.4 cv=XIkAjwhE c=1 sm=1 tr=0 ts=6a4f41e5 cx=c_pps
 a=2EogD3SZGC0twO92opjmhQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=N54-gffFAAAA:8 a=VwQbUJbxAAAA:8 a=ibdQesH5_2KD__BatQ0A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: bHjRv6kD6u9bO2qZ3dDB1S4wTyPh5xql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfX+DqP4Oaf/UJ6
 RTgIyAoNiSb2LUDZASgwoH3aUsqEYQ9NJoVROPy+R83IDNJjuqoWirL4K5iFj0BDImIDMbtG/2g
 NIq2Qy4bWBaRhGdNkZ//m0Q2usAXbArhOjS1w7fXxyAdf2o4Kb2orTj1RlcjH4/affvJzhyxoRx
 54Xy+4mU63Zv5Y+cTBGzRAQd6HnTRK8Nj2V8tp1q0k10hhOyXP2b/05LOTaOc3z5amz+sXcFHXu
 2zr5jhp4fwdGZ0A9GDWpcJtP0O5jRWE9YDpVZarp0eJt+uRn3VNwn+9TI03PhvlaD9EC+w55+eO
 naS8tX8ikQqSb95nlsk0FrNMv0/QRfqxkFpzVNSocCuotaQ+RpEnMtyaHSEOo9k1CBCfabKWSPH
 gl5F9OIin7nJ4aSJ7yke7eCB9fKWL88sO9DBS/8iOn1vLaoAfag/M/WLvC8bIYSymT2F0glXd8k
 QhsgvpN9CI0f223jelA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090060

From: Ionut Nechita <ionut.nechita@windriver.com>

On PREEMPT_RT kernels, commit 6bda857bcbb86 ("block: fix ordering
between checking QUEUE_FLAG_QUIESCED request adding") causes a severe
throughput regression on systems with many MSI-X interrupt vectors.

That commit closed a store/load race between blk_mq_run_hw_queue() and
blk_mq_unquiesce_queue() by taking q->queue_lock around the requiesce
re-check in blk_mq_run_hw_queue().  Its changelog noted two ways to fix
the race -- (1) a pair of memory barriers, or (2) the queue_lock -- and
picked (2) because barriers are harder to maintain.

On RT, spinlock_t becomes a sleeping rt_mutex.  blk_mq_run_hw_queue() is
called from every IRQ thread, and the re-check path is hit on the very
common "nothing pending" case, so all IRQ threads end up serialising on
the single q->queue_lock and block in D-state.  On a Broadcom/LSI
MegaRAID 12GSAS/PCIe Secure SAS39xx (megaraid_sas, 128 MSI-X vectors,
120 hw queues) throughput drops from 640 MB/s to 153 MB/s.

Take approach (1) instead, and while at it turn quiesce_depth into the
single source of truth for the quiesce state:

 - quiesce_depth becomes atomic_t and QUEUE_FLAG_QUIESCED is removed;
   blk_queue_quiesced() is now "atomic_read(&q->quiesce_depth) > 0".
   This also makes blk_queue_quiesced(), which is read locklessly from
   the dispatch path, a clean atomic load instead of a plain-int read
   racing with a spin_lock-protected int update.

 - blk_mq_quiesce_queue_nowait() does an atomic_inc() followed by
   smp_mb__after_atomic().  The spin_lock() it used to take only served
   to publish the state change; every caller still follows the quiesce
   with blk_mq_wait_quiesce_done() (synchronize_srcu()/synchronize_rcu()),
   which is what actually drains in-flight dispatchers and makes the new
   state globally visible.  The barrier here just keeps the helper
   self-contained for the few callers that defer that wait.

 - blk_mq_unquiesce_queue() uses atomic_dec_if_positive() (so the
   WARN-on-underflow check and the decrement are one atomic op) followed
   by smp_mb__after_atomic() before blk_mq_run_hw_queues().  This is the
   write side of the race fixed above: a full barrier between the
   quiesce_depth store and the blk_mq_hctx_has_pending() load.

 - blk_mq_run_hw_queue() drops the q->queue_lock around the requiesce
   re-check and uses smp_mb() instead.  This is the read side: a full
   barrier between the just-inserted request (the store that makes
   blk_mq_hctx_has_pending() true) and the quiesce-state load.  A full
   barrier is required on both sides -- this is a classic store-buffer
   pattern -- so smp_mb()/smp_mb__after_atomic() rather than a read
   barrier; with that, at least one of the two racing CPUs observes the
   other's store and the hw queue is not left both un-quiesced and not
   rerun.

No locking remains on the dispatch hot path.

Performance on the RT kernel and the hardware above:
 - Before: 153 MB/s, IRQ threads in D-state on q->queue_lock
 - After:  640 MB/s, no IRQ threads blocked

The non-RT path replaces a queue_lock acquire/release on the re-check
with an smp_mb(), so it should be no worse, and it also stops taking
q->queue_lock from blk_mq_run_hw_queue() entirely.

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Fixes: 6bda857bcbb86 ("block: fix ordering between checking QUEUE_FLAG_QUIESCED request adding")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8 checkpatch
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 69 ++++++++++++++++++++++++++----------------
 include/linux/blkdev.h |  9 ++++--
 4 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 365641266c9e..79669957f47e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -477,6 +477,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 	mutex_init(&q->limits_lock);
 	mutex_init(&q->rq_qos_mutex);
 	spin_lock_init(&q->queue_lock);
+	atomic_set(&q->quiesce_depth, 0);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 	mutex_init(&q->mq_freeze_lock);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6754d8f9449c..567eedbbf50f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -93,7 +93,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(INIT_DONE),
 	QUEUE_FLAG_NAME(STATS),
 	QUEUE_FLAG_NAME(REGISTERED),
-	QUEUE_FLAG_NAME(QUIESCED),
 	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c850330a32b..186bbcc8b927 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -260,12 +260,16 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&q->queue_lock, flags);
-	if (!q->quiesce_depth++)
-		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	atomic_inc(&q->quiesce_depth);
+	/*
+	 * Publish the quiesce_depth increment.  Callers must follow this
+	 * with blk_mq_wait_quiesce_done() (synchronize_srcu()/
+	 * synchronize_rcu()), which is what actually guarantees that any
+	 * in-flight dispatcher has finished and that later dispatchers see
+	 * the queue as quiesced; the barrier here only keeps this helper
+	 * self-contained for the few callers that defer the wait.
+	 */
+	smp_mb__after_atomic();
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
@@ -314,21 +318,30 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
-	unsigned long flags;
-	bool run_queue = false;
+	int depth;
 
-	spin_lock_irqsave(&q->queue_lock, flags);
-	if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
-		;
-	} else if (!--q->quiesce_depth) {
-		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
-		run_queue = true;
-	}
-	spin_unlock_irqrestore(&q->queue_lock, flags);
+	depth = atomic_dec_if_positive(&q->quiesce_depth);
+	if (WARN_ON_ONCE(depth < 0))
+		return;
 
-	/* dispatch requests which are inserted during quiescing */
-	if (run_queue)
+	if (depth == 0) {
+		/*
+		 * Full barrier between the quiesce_depth store above and the
+		 * blk_mq_hctx_has_pending() load done from blk_mq_run_hw_queues()
+		 * below.  This pairs with the smp_mb() before the requiesce
+		 * re-check in blk_mq_run_hw_queue(): of the two racing CPUs
+		 * (one inserting a request and then re-checking quiesce state,
+		 * the other unquiescing here and then checking for pending
+		 * work) at least one sees the other's store, so the hw queue
+		 * is not left with a request stranded on a now-running queue.
+		 *
+		 * atomic_dec_if_positive() already orders the decrement on
+		 * success, but spell the barrier out so the pairing is obvious.
+		 */
+		smp_mb__after_atomic();
+		/* dispatch requests which are inserted during quiescing */
 		blk_mq_run_hw_queues(q, true);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
@@ -2331,17 +2344,21 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 
 	need_run = blk_mq_hw_queue_need_run(hctx);
 	if (!need_run) {
-		unsigned long flags;
-
 		/*
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check
-		 * if hw queue is quiesced locklessly above, we need the use
-		 * ->queue_lock to make sure we see the up-to-date status to
-		 * not miss rerunning the hw queue.
+		 * Re-check after a full barrier.  A request may have been
+		 * inserted before this call, while a concurrent
+		 * blk_mq_unquiesce_queue() drops quiesce_depth to zero and
+		 * then runs the hw queues.  This smp_mb() orders the request
+		 * insert (the store that makes blk_mq_hctx_has_pending() true)
+		 * before the requiesce-state load below, and pairs with the
+		 * smp_mb__after_atomic() between the quiesce_depth store and
+		 * the blk_mq_hctx_has_pending() load in blk_mq_unquiesce_queue()
+		 * (and in blk_mq_quiesce_queue_nowait()).  With a full barrier
+		 * on both sides, at least one CPU observes the other's store,
+		 * so the queue is not left both un-quiesced and not rerun.
 		 */
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+		smp_mb();
 		need_run = blk_mq_hw_queue_need_run(hctx);
-		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
 
 		if (!need_run)
 			return;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dbb549cdfb77..9e49ab9c78ae 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -525,7 +525,8 @@ struct request_queue {
 
 	spinlock_t		queue_lock;
 
-	int			quiesce_depth;
+	/* Atomic quiesce depth - also serves as quiesced indicator (depth > 0) */
+	atomic_t		quiesce_depth;
 
 	struct gendisk		*disk;
 
@@ -670,7 +671,6 @@ enum {
 	QUEUE_FLAG_INIT_DONE,		/* queue is initialized */
 	QUEUE_FLAG_STATS,		/* track IO start and completion times */
 	QUEUE_FLAG_REGISTERED,		/* queue has been registered to a disk */
-	QUEUE_FLAG_QUIESCED,		/* queue has been quiesced */
 	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
@@ -708,7 +708,10 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
-#define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
+static inline bool blk_queue_quiesced(struct request_queue *q)
+{
+	return atomic_read(&q->quiesce_depth) > 0;
+}
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
 #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)

base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
-- 
2.54.0

