Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDEF52B1D1;
	Thu,  1 Oct 2026 14:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866325; cv=fail; b=LhzE1W8Wpa8RutgR/zvnzS9QT0Sz6VsrF/PKJ397mrHE+o8uHoNi/r3ccZmUbUvvjLkgR8AZd9LZWwAZOh2ZAERZqiQhXaHrtLRnhSZ/Arkl52GrbL7UeUIOhYYZmg4l0siiLAzU2+NiZrOU8O+OJjSyPrUZ99NnDAeQtmZZPII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866325; c=relaxed/simple;
	bh=Ax1wPwJhqWmI8xRXzz5C9og1P+XPPakUj0Nv8GxYUkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYDk7afR1rJh3Db4gTaBj/rdd3ZFUdSNYSGHb5crFJWMZtRvlC9C+W+MeJd8ehtMgYuMiCR5PaGtvk1OjkeQCkjLoq5gNbvrPT0XdbyxMUIug2YgbU5lpuECQ1y8CGQ9eWFuAKXfN5TIyvrCrg/2/gva6wVieKdJSqRpE4rN3os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KMqor3vu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qpcDLa1A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KMqor3vu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qpcDLa1A"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMgrX539355;
	Thu, 1 Oct 2026 14:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MBxFabIvCNoOXDltHCWZ3xKg2wuRDSGTtbyUrgEQnW8=; b=
	KMqor3vuDI1Ic4BCngw6zjCIXnmHCavkP4SAIdcx2OVM8r2zs1WjZ+JNd4C3CjO6
	R9Xk5pY36em/gFYs7zElv8/iRuva/8XYqXCaRJQSD5X2A2+EttI+KVcWFDfnR1Ca
	147wV58sMLH2Il5uvaKX5ZlW8nx0g0/gz6O2P22n8AkY6g6A/9FlS88SpzH8p9kH
	f57rEOuci3aE68icOsU+1jTWC91lBXcdHFjY5YQ9ELTXw4cuii76VttYelMRgO53
	/O65FCrEqOpQ/YuY0RMIbD4Fg9lMmhuYc88GFQiOheSXrcRLKmOTXn2uErD0RoUO
	e3E8md36VmaacbnEHTcT+Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbgym5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnoYg011559;
	Thu, 1 Oct 2026 14:51:52 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gepjcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hM7eVZd4L3VLsgDXlAacrrQuWCMFR6HGHMRnK11hR6JsW1P0NHq1Uc8gPDm0BqpDV8i1fdZRXCFY7td/70LCTgy+Sp/6+gjqZQKLdzo0kH1KyzKVMwhhBx8YHIrMAB7I/xEzcQAyHqrElgtOuZ8UBmcwIRmT+7B0V4rlpIzQllETsBw/VTNWeHOJWOdMTtGnqgt0cFeVYKRqtRj6YB8pjK8xZJaWiyoOUZ1YL2BztNpLU9Qrh9UE9KoHJePvX+jf/8u+CcAXiOEgXPTCfFHJaPJfLWVAh0H+PMiEw62QC4CKgk62Il2hUjvVA9xz1z8xExul27x5xPD00goZefM4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBxFabIvCNoOXDltHCWZ3xKg2wuRDSGTtbyUrgEQnW8=;
 b=rDFHr4LI/qwsbqBKRFoL2V+YPNX74g0K1Wo1K6pVlykbI6wWiC4YXcEiKFb8BxmRIf1kfN5ToMGXWVYSqfKtUESHCTZTiVlcB+GRDvNQzqh26iOVeM5agIXqLs1IJ782rIbduHAez0DuH3s319XVEPQlaFCJuaE3weEbpHnWK4DT5Kcdo0NryraCLa8KwHEdczdaENC+2fZkVdarEiiHcJ3U1bKeTlpCL7orUjM0a9Pfz3CCvMFuSFga2n4o1pK0/KVNTkmQt7RwL5Jv8WlJOzAqQnC2mbM4H0r7Na/M3lpspB8MT68pjDoKY5mW0bBYLW2clviuisa25wfhPv8eQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBxFabIvCNoOXDltHCWZ3xKg2wuRDSGTtbyUrgEQnW8=;
 b=qpcDLa1AwbUur1/hlRX1pVgcwe6vsdaLDMzP7FGrj0KB3MNqTtoUFEybRqanA26fl9f376bB2T0GRvDuxWYKIAx8dazww0j+e+wiBfYLulN9r7dUhfUdg9FBQ1tr+zet1f5A7e79C6IimMTYgTqAl+8C1NypVzT3IhJ6lZFg4zU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH3PR10MB7576.namprd10.prod.outlook.com (2603:10b6:610:17d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 14:51:49 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:49 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 00/21] Backport of XFS umount hang fixes
Date: Thu,  1 Oct 2026 20:21:13 +0530
Message-ID: <cover.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090954-revisit-dowry-37ee@gregkh>
References: <2026090954-revisit-dowry-37ee@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH3PR10MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6549fe-bd8d-4490-3b10-08df1fcb831e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|10070799003|1800799024|376014|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	eOKIDuq77T5WH/gvihOihdqQXUWm2aCJ1FsUoxj3L8aXuyYuggeuT9WxytbmTFXsupV0ybyFSjPIJDJckc0e/vxm+s/I1fbuYMO37okf+RVLjdlSVYdI9j9hOTDpYNolNwb2w6VCTOKLloLfu1BstYqHUhauPypE9/9UVswzEcDcjv19XChJyQDT7IxCE0BghJdBjtuyEEyJ+gAT12pk6t/gMzGKoaT3W0lIBihhRMYfz8xzsvH+r7JmNCIp97BuVf5dy5p9MCA6r6RJGUq413oJlsQExeHZUJQDRhZ9DO7dlCq0IVECKagN/LNjLtAVnBeyZtXHK9OluLzpwvc/mT9SRANe7H+SGjda7jcbwYeqZ8b45RHElRHpaZxbhiDbnvUFUsuJO7tkXRqv0aVgBY+ALmbbJAlup0A+Gf96qB3U63aiDGab75AgOQ0scosOImg70QVuYn06R+EgyyejVmsIxNzVkeUpSF5HwsGLfga9sVFN4EKueikx6CQDYRcZ+A/FT4PD4XL0vIU6Jv9Gko1atqS8/hiFTrgatxB5zI87UiROqUMvTpYR391QxFhT0JJ2Wlzpb8/XZApoikEbzYmjsWmFfHnqxCRYuMfXC96o+5YpBQYjcT4SwEqrU0HuCYC0IlkwCActHUhQNTwudJy9RrbE0HTamcK2fU+AXpU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OQm4nKR48YqH3Im4BwEZAh2w1GbBbmpX9cHQ6obxXFmH2UgEwvKi5kzOsxkm?=
 =?us-ascii?Q?yhjc8KgcCI7EEykBo7MTtX1VNzpje3Ui6X2ATTA5Dm9/nVR+Jcx+52xCpVQ0?=
 =?us-ascii?Q?7YdN1QpKfNJ9+raIAkCHvQAIIW3l8SMe/0hmXE4EWs0jxHVsVMMe0KxMmREv?=
 =?us-ascii?Q?VDRsvG90nVx6v3srNgBnPn/0EZdw6TXi94qmkXydmwHW29DpgvaoLnPuYvjt?=
 =?us-ascii?Q?C63maxwMNTze0o5x0Cra7QI9Wptjbb/JDEMqj6EaSUrBuVVBE2vYTy0iupGK?=
 =?us-ascii?Q?vgLwIlfa++WvJn6TtPC8WxLv3AJ8IEt+bCHshTy2inlt/84QEAoQvbGfPOe9?=
 =?us-ascii?Q?8KYHmibhYqSm9zI/Ff3Lg8yuX/795cQxCCATFOvatWb5XLg6B7+1q8JeZd+I?=
 =?us-ascii?Q?pG1KW2Dt0XeKRiJ2u7Pro3iwhCkh5dH28hhP1jhlpVL/zfOLPly9RY3X8VQP?=
 =?us-ascii?Q?fLJsBWv+qmwGHE6qWvkWdlRPAkaUInSfhrq7PnsYXYp5/tk/4T00E6946LeD?=
 =?us-ascii?Q?3hEOEf31TMDlBGyi3duttqsaW0Fa1Jz1vlRr0u3OfYPEcCayeFYii9pHiqvW?=
 =?us-ascii?Q?ODHOoKJIYvq0+R7eX/26pS6MLWDrQQmscFeF52PozI9yMumQYCbnGvbajl7y?=
 =?us-ascii?Q?GHLRKjj3pbeC1nTnTgshiURs0l5MD4ksNo+8ont3jmswrT/zTvQoKiLs9QZ1?=
 =?us-ascii?Q?ykQTQ2LN1+4vY+naROnqBR49j1OtU6bDa2ykM8wNkbKsFgu099FADxhVUK49?=
 =?us-ascii?Q?H/g89XH8OKOp14YuddkxWiVRWoYV63NJ9YkVbhbcH9NXwpM+FjsksDQMx471?=
 =?us-ascii?Q?oBrumqIQBkweiOgtB4S+5t/hR+im1M3jhmAcv4aC41GZUzWJfn7yDjTspa0j?=
 =?us-ascii?Q?vL53m8DDp5T6wnYj/ZPLSswCnacR+yv+0lVBuM7GwQfHEZevGbyhW0J0LgIn?=
 =?us-ascii?Q?20z2dft1Lb62eOBeQjCtZAGNgIrvn8xzTX7q5JH5RQnrSId93f2ZsFmg6jQs?=
 =?us-ascii?Q?E6zZo+4iKkWEYQqUEzw6uI5Pp110ptiy13XX8ytFLf/JnAoiNOEjCM91pqAn?=
 =?us-ascii?Q?OGraKT6moZINYBY0C4OyhQx33LKZQSL7IoPB9v3pbIcfOmhaeX0vMsgU//7a?=
 =?us-ascii?Q?CVFoKUEY80qpFPS4UNlaLjRASgTvJqmyp3AgIBHrI4LFdhhKsylfYQ7rCWHA?=
 =?us-ascii?Q?vlH4C7ASvOHuYHdKNZd5UrMuAXPeWZg0Hunwh8ObDKDrw+XF1AjLEcl4+cRY?=
 =?us-ascii?Q?/JuQSfmex4HRHhsxPHFNYgMiXyH+SGi6f0uu5W3g5Rv4vXwFV+5n8mjyVoq6?=
 =?us-ascii?Q?LFZZ+Lk2QGtIYrTeugIbjuj46WpLfgRq00v8aw1LimqOOw14QFSgupFybHBn?=
 =?us-ascii?Q?p2B6vahfVMkEV0aRLNFPxpCE34pimVqkEM7gp9zrADMGOLwhd85NA+lT2Rsh?=
 =?us-ascii?Q?bnJsv7xrYguNudLdgiW7yZBXy4k3NUsiUHSIEkTT6+1G/jmvcrEHiPsH8MG2?=
 =?us-ascii?Q?OEUb8YXV3rQ95uQSEcB9NuBFSNmwvGVraia4o4Q4U6ENZ2KgiwDZc/NmMFpp?=
 =?us-ascii?Q?NIS6h2hx9x7OquECNLVAdgKrt9oeziAVFseSK/Yb2yReVJVHwy8S1/jdeV3V?=
 =?us-ascii?Q?kq+bsfwh+XA8r7wNkT/k5kRnO0EcW5ueOjUB7V386KTnhHE2HKfuXwzYnAKh?=
 =?us-ascii?Q?l5+eGzGrDpmxadNJH3jDKSrv+PZd4baMlPypQX0CZLsfIhPXhpntjwf77X7M?=
 =?us-ascii?Q?HqNvFkp5dpXie1EBwtaMt740wK0ULYrUiMM9w6GTio/ndrPIjxl0Q2m8YPci?=
X-MS-Exchange-AntiSpam-MessageData-1: klrtZjJnns27VyRgi6sNmDmmVzKl3ufZme8=
X-Exchange-RoutingPolicyChecked:
	EZOgY33xoqfEKKkFoZ/nMIdTWkz5C2y2XaSFkaUcxHf+Hfx610cVkyN2wnWqPt1HsBBH+BQq6SKd1hv4bzTzlR0dP6LokEZ4ZbailoL5MxMS6NezDWpHZCniqBEIIwQbWEUukHqOyfmvDYG82pk9gI0ZiHpU5uK5W1Sj+16JH17wC5plalzalSXXcfCvWhgFL29Oz3IqTrIv8DPl4Tp+LoOd9Xwc4d1ItQJVDqtNFpBVXeWMI57JtD/zlJq19DlvrOPLvbKK0WmEHqRfkkK54iu4NbAM+X7uaMojIedBGFWjWCKWRuorT32jIwuslsBgpBRTKVAVnitqrh5AbLhxJg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ckB3CHH/iuTkczVUstLOw184xXHpd2Sg2DTkPqjYxCUJksSYSfdm3TkEIlB7+nO6QS/fbdbLFjgUTeGBvTXf/M9wri04u8Bp4hu3MkC9qq6DwN+IBtPzgYbh7Y0P0fOlgjmgwFld/KxZJL0/ws7LfhdHHPSvAIXYhzBZZBJhBVwcHAhNFo+MkGFa+pg0vXxRWklcZolUCBmkmxnSYvu1ntMB9pVOmG2tIrL8k4D5y94lfChbFn1DZW144wTm3Qr51tv1WhlCWvs/SFWvrFb8QmGCHtr/427gfUtAzWf2k31CO2Bb0tTeCu5bN2o9TlyzB0eCYJGYXHh4vHrSPiRjxkzd5jEIoyUWjXvHHv3D6quSEisBNxY2rzCPqlOxCgPb9tT4s56L0G0nnuqNoeQkuSAeMt6bhd9JIABHh4cjKNlOaUBsSEPllAEVu4NnoOPNNnG75CsfWebHICocrn1kk4cO7N2jL3fVHGbXUPMk9s8PVBHcnJIeUi10eaMgC5cw9pnShn0dKt71W6BlYVxk6OwSoizCf2iL+Z11vCaaedRyAbbtcJVxCPFmVHCn7d/u0iHQw6Dj6Uwxx7V43tgP9RgdUgIEW3z6pPs44qZq+gA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6549fe-bd8d-4490-3b10-08df1fcb831e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:44.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMLzEyiatxTaEIrd+Ij3YXIM2zVyX1h9KWvS4MSxYo2yBhl9miqFydERIqz6FGjQQuU9Co7y8scf4ZHsXBAD9+R4GtKuHe378ywPjR7cxLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: 5WRrbLMow606yT2gqxuRMe96VzOcGriu
X-Proofpoint-GUID: 5WRrbLMow606yT2gqxuRMe96VzOcGriu
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abe738a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
 a=ONJcZ18tqKTzyd6mlaMA:9 a=biEYGPWJfzWAr4FL6Ov7:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXylo82RWcf/NY
 UFkUjLNBTthnqpYDgb2xCTG6fhO1RJjbTQjT9onwK7yYyGJU81VkV3JHoP3JVU5ohrysGWP2jjc
 55r7j5XHLKn0FOq8B+F2mxOsNXiMHgjfP5rv7krlf+Xu1T0eR/H+
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX4MqSHMlRXFaO
 FcvxFPVF715oH+F2iNridFMaB7Nl8vNiYYTVnGgtBlKvtxzNd8uTxWZj+8BuulgGZBQxX2mLszy
 PsG93aK14pAJ70RY3hw5ikyYOtY76wI2hU5BAIYs3YDI2ByHKe+eaU5DD6UzXal0J5SFJu5J+K2
 s+jqSuSzb1mSqdQwKNijbFRA3kJKlH/0Y00hWIGfspgWOxNgqvSGoiLxC+4a5stH34lsmqLFiym
 vpfl9lvAE6VOC7x/AsRgv7LTJJl477Vn4uf/qEe0UkvdjlZVCTPsdBIe5pcbA9xDoIqOynZattQ
 nq5zJYoSculEBxDdDLGFCWIFqVb4dR+f7nZO0wTA78P0sqclx1zz3Zja46khKFU79jSZso+5e54
 RXYVIjz7pfmcJbb5xiWC2QgpUQuLHcw3AmmVx7cRpSu+oAL68pZowSNj4mb9pqMPvFeyuunfucq
 /ZsuYAtuct3XvDPeAug==

Backport of this series:
https://lore.kernel.org/all/20250625224957.1436116-1-david@fromorbit.com/

Along with appropriate pre-requisite commits.

Previous stable backport was used for doing this backport.

I have added information in commit message upon conflict resolutions.

Darrick J. Wong (7):
  xfs: hoist recovered bmap intent checks out of xfs_bui_item_recover
  xfs: improve the code that checks recovered bmap intent items
  xfs: hoist recovered rmap intent checks out of xfs_rui_item_recover
  xfs: improve the code that checks recovered rmap intent items
  xfs: hoist recovered refcount intent checks out of
    xfs_cui_item_recover
  xfs: improve the code that checks recovered refcount intent items
  xfs: fix intermittent hang during quotacheck

Dave Chinner (13):
  xfs: don't nest icloglock inside ic_callback_lock
  xfs: convert XLOG_FORCED_SHUTDOWN() to xlog_is_shutdown()
  xfs: log items should have a xlog pointer, not a mount
  xfs: aborting inodes on shutdown may need buffer lock
  xfs: remove xfs_buf_t typedef
  xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING
  xfs: buffer pins need to hold a buffer reference
  xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
  xfs: catch stale AGF/AGF metadata
  xfs: avoid dquot buffer pin deadlock
  xfs: rearrange code in xfs_buf_item.c
  xfs: factor out stale buffer item completion
  xfs: fix unmount hang with unflushable inodes stuck in the AIL

Guo Xuenan (1):
  xfs: fix super block buf log item UAF during force shutdown

 fs/xfs/libxfs/xfs_alloc.c    |  61 ++++--
 fs/xfs/libxfs/xfs_bmap.c     |   6 +-
 fs/xfs/libxfs/xfs_btree.c    |  10 +-
 fs/xfs/libxfs/xfs_ialloc.c   |  38 +++-
 fs/xfs/libxfs/xfs_rtbitmap.c |  22 +-
 fs/xfs/xfs_bmap_item.c       |  76 ++++---
 fs/xfs/xfs_buf.c             |  79 ++------
 fs/xfs/xfs_buf.h             |  15 +-
 fs/xfs/xfs_buf_item.c        | 380 ++++++++++++++++++++++-------------
 fs/xfs/xfs_buf_item.h        |   3 +-
 fs/xfs/xfs_dquot.c           |   3 +-
 fs/xfs/xfs_dquot_item.c      |   5 +-
 fs/xfs/xfs_extfree_item.c    |   2 +-
 fs/xfs/xfs_fsops.c           |   2 +-
 fs/xfs/xfs_icache.c          |  10 +-
 fs/xfs/xfs_inode.c           |   9 +-
 fs/xfs/xfs_inode_item.c      | 162 ++++++++++++---
 fs/xfs/xfs_inode_item.h      |   1 +
 fs/xfs/xfs_log.c             |  50 ++---
 fs/xfs/xfs_log_cil.c         |  12 +-
 fs/xfs/xfs_log_priv.h        |   7 +-
 fs/xfs/xfs_log_recover.c     |  17 +-
 fs/xfs/xfs_qm.c              |  88 +++-----
 fs/xfs/xfs_refcount_item.c   |  60 ++++--
 fs/xfs/xfs_rmap_item.c       |  75 ++++---
 fs/xfs/xfs_rtalloc.c         |  20 +-
 fs/xfs/xfs_rtalloc.h         |   4 +-
 fs/xfs/xfs_symlink.c         |   4 +-
 fs/xfs/xfs_trace.h           |   5 +-
 fs/xfs/xfs_trans.c           |   6 +-
 fs/xfs/xfs_trans.h           |   3 +-
 fs/xfs/xfs_trans_buf.c       |  16 +-
 32 files changed, 744 insertions(+), 507 deletions(-)

-- 
2.53.0

