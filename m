Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2352CCC7;
	Thu,  1 Oct 2026 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866330; cv=fail; b=W+dWZaec5/Ve9nVcab5CiWXEtJuvIIWOgsFm+gGoJ0kzebf6JbCrYhXwz0y5jrbtDKWOqdx9XeqqCYg7Kyhqjs8roAqlNaVdTYjd7Pjp1a7ax2S96Z3PGujX5FbVdUZm9kDfLVQLpC1mk8WPxx93iJiNk8TIOpKSR4azjFoJROw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866330; c=relaxed/simple;
	bh=qGOVKQk8/3EbtkqcbI3Qj2e+dq5U4JJvqvYjdUVtuJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNZ5D71ZJ+xFK0mLUzwCKTo4DdJXmj1K/0G1z3OPszE7KaNxrTpb2TknXxN41GBz1Bqr+9e3+Eof+56c/8fm8VijMZRPzHf/aYieHGXzi3ocJNKbYP93qxouAyCCoXxPhsu2XP4PLAf1aPjXEsRvn/lzMIm/dWGpYT2u2jJp7ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r4lqznV3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ExUhBg5+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r4lqznV3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ExUhBg5+"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMjVV624459;
	Thu, 1 Oct 2026 14:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wH1sNtSfkQBExCP3V6cpGCj+33hedt0q4U67iweKDJM=; b=
	r4lqznV3t/Mfet1X69Mkoxh8UidnTvA6qvMKX8GSHKYkTnGmM195CagWF8dAGCDT
	U1cwp7Gqf6WrYg9Zz9C9lN614fzi49FRR/6/JBQjub76o/9Fzsjxuhfzq09SeAcr
	GiPQ8J0Jc0JY1f12+U4GfFLTQCD2gNzW9MmFN5J903h3ljDdMRkbIT96hdhL6f1h
	h3rBK4HTJtPb5ZB9+PQ5U6xed17fRjFkHzyHNMPXNIQazBiYzqDAruaEfBFsj7ou
	1FhZADKGTdu1AGDW2nhmkjJhgu3U2wS+ODjX9kkqXlKtxovmbyiKTZJuc73bQ00a
	saoHXcs9HUAIYBVYDlKYSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns104u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Eo5uS011845;
	Thu, 1 Oct 2026 14:51:59 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gdxsdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqluhvN1hIsfFea4kEikdVShu3mPrgXZMEi5LyxhmVMSraDdhqPktr+gid1eNLUy1FHsGN5XiChtEBPlPvA/5BM28UYmw7cS96jPH/U6TwAvAk5ujztx6IXbsBBuGzquhmx7KnstTvz/V3ht5TAcyI8ipI5YHrH+Lwc9VoBwb5Qbwfw2Ns3xjvgplxu+578TFQe+pxqfLrEVHy2QsJnE4WcwVbYOUxAFib4lMZ60PekrVr9Lh3LlZT2MB2H6xZ90JsekOZwePSFaZwZzr4+qMwApHTsznpXZEm0wVdrldE18eKyQl8qoOn+BRJzPgJ3QM6/BEH9R/QjYY/iogOHLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wH1sNtSfkQBExCP3V6cpGCj+33hedt0q4U67iweKDJM=;
 b=dCZJwVY0Xn0q2bmpEc1nyWuyl6SkxFJ8BLHgiKvZNi1aJz1UwSAaftr3o8e66r9oH2y/VaKpoHmyMwz4stnKqFOeWZ0lBq4rM4TOWncxRSKvEWh1Wpg8ofjMYA3jtlPtAbgDZogVsSumpqNl6sSIMGP1D13Qyb39Qlcljy7D6i4qRJbyXfFFWaRQ6Z1V1jMbwiDaLkRT+MxTxfSJWMqDYaNf4hGLN6QGFRNidLLaWGV/hAMHoU9wMT0FtyI/s9/Rlch+4Tn63PJwblYaj+fu3mwbdQyNFt/7+NGG7R2gkBOiMif6WefqBCIvTIi19KcK8AWU4cT2ZGqeMVPySYEB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wH1sNtSfkQBExCP3V6cpGCj+33hedt0q4U67iweKDJM=;
 b=ExUhBg5+9FXEP2kA0YeMIf/+MFgtCzHZNXIIwmVD/en4PD84ltVVFa+tHK/umxaqP4+z9KlHiSQKlHmgf9kK1Z9clT/8h4dftzNUG56Okllw0gDaCSm3DibZTLdWIw2uUrKyU7e+urnLg2nIMAXC/VM18f81rIelXovdOTnQaXk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DM4PR10MB6231.namprd10.prod.outlook.com (2603:10b6:8:8e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14; Thu, 1 Oct 2026 14:51:50 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:50 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.6 5/6] xfs: factor out stale buffer item completion
Date: Thu,  1 Oct 2026 20:21:02 +0530
Message-ID: <5f5505bf568c70ceb96f1e33e289eb4e153c4eef.1790864521.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864521.git.siddh.raman.pant@oracle.com>
References: <cover.1790864521.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DM4PR10MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: df469200-fd84-41da-22db-08df1fcb8323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9ehNxc+kYommbQh18b39LKYNcLGpzMuKnhM+YQUT+C4P5wX4oriQWzwz0NsdnirYR44Tdw27hFn4ubYepsCRgqMz0GEenPGYxnevwbwGOIhLYaKZKp6rJDV6wluK1gW+904dGYu0zqZcxU4/9wrl2OxU870we9AhWr9dWGEWIsEQz0JsO9QfzeQATGdPudxNKI2mGxwdOWD+vV35OVTo9JFbx2W33vGNPJONjNLruHGigcZb891NrYwg5TOq5CwwNIXAuD+RVv9T/u1vmdmhJ78xLPZ/NqMFHcgTWbdLqtpgk0NWWGjSOdoUYLEbRveNyosqqf4BQTWXgTIEzhHxsCQZcDTWrycb89CbRiCgG48RCWQDuDqS/5HFw7lla5Em4EOqqLW4GwozUw00NtgIVOaD6igxy9ebxd3dmtcL30DG2uOVLHkIIyLwdfbgzSgCcLGtSjtmxp/13imYEi9PqXEinL2gOgV5eGBIUpjOmI3UvyVPEREjys2rnJQpYe3uQUctjeAXUxKHdOQhNp9FthsBtofjorsOuATa5bbXMXfyqW+58T64vERY4ypvwa1jj1m9SZtKLu6vcgP738agvFnjVxIqcJGqsELvfaKdYyJJDj4c0AMwRrfy3fZeUVqmhL3X8WxazK2Vy5/TPQ17/vCDKd9vrIbReqFV6CCqZbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VGYTokz2j0MvQ2cF6SSeo+C5AkmGSZWSePqDFlQfKkAeu2wfSPntdoLGLJdw?=
 =?us-ascii?Q?UWFvS9yQLrs1dvDtanNvYPl6MWMXdtiylJUOg5BC/SckuiFG/9keL+Cp+ElH?=
 =?us-ascii?Q?ob5T1QxUmZkA5PVRkb3nh4ABUsUjIOdmXIcgnahArZx2//IX7zuByF2Kf7ig?=
 =?us-ascii?Q?o1CgAWOf0udGg92G+I9cL/+E+3EIPV+vSCqoC5R+8Kk/z/QPy2ungnV8jIkC?=
 =?us-ascii?Q?wflzlhuO8gi8YQqpk6WD1y5FQT7BEK7s03wYy1FR888qxO+eBGXDhBkrEzAR?=
 =?us-ascii?Q?LOyw3PIe2wRDkC6Aih9L6igayVCkCGGi/K3Vj73aELTb4A66acMsrHGIL0OH?=
 =?us-ascii?Q?ep4o5F979GEipJbpsWiyX+thq/h9D2txKhSVqReotdB3JT/KX2HsT87zHV1F?=
 =?us-ascii?Q?TEtxHDwC15cDzzpEehIF7YFznH5afFfjN0d+z6kCG0M8LcHgTHR/NGBr8b7X?=
 =?us-ascii?Q?WfeYZHDpf9lVCBwKyWOnHVIvghv95E6yoej2ZO3cQeTQw2lpV1ZTaGS9aIVs?=
 =?us-ascii?Q?uu/3i0jdTT80eFXBytnWKRCkQGnp0lH0Vjg3yxr3QC7z++xOWL+56GN6Qy69?=
 =?us-ascii?Q?bG2vlV7UUnhjjwDSvoJ/w1u8NFflyyo8itfXf29XTZUOtRXKLKRXz0rUWkgz?=
 =?us-ascii?Q?4CGPn/cvz2VtBHAFtYp5cFQmVfDRGrNxALzo/RTvU+T/KQQVEdCm8qpwOVlw?=
 =?us-ascii?Q?K1rzy5uusho2eocfYp/mY+j9T/ZN1HvvlGcQbMf3ZCri41PhnWos7EiU55tz?=
 =?us-ascii?Q?FoUoEMB/rFvH98CjseLsFMEJ+Tm+H2pKksot35koMQIYWEtfIsYn86LupUWQ?=
 =?us-ascii?Q?0E4Ch0w6zh3mQOTridCyfkaS7qfeinCmZa68QnG6dDzAAknfCpw+nesIxGQY?=
 =?us-ascii?Q?cFW/i3lmILA9CXUrnHjW0Gflv7mBIK9SmQxWyEzd+jwf4pCcDyczMpFcyKgu?=
 =?us-ascii?Q?8D/eWNSh+rabG4g/kWNCSRb/o53AVGFvmTpFp2DmwCLIxCf28KH+CukR3ay+?=
 =?us-ascii?Q?EbBLUCdVg9Tixq5BQSL2XIp/MQQ60jIX/Jx/rHcRLsmll8OpVSR7QyLuH8I7?=
 =?us-ascii?Q?eMt/tOL1gBr4G3yG06Ly4HnhqFGM4HMtyHAHDpC3humvv6eaJx/31VOX6VCx?=
 =?us-ascii?Q?WVFn60xsTxwLbHHyKkGVT+YPiq/+kCcNt5hhD6+oHxzbcNi1KW1TCSjRV1Xz?=
 =?us-ascii?Q?ezlT8a0hLaw63BWL8BDG6102i4JgKZKv+0AIkK9FuFWov+zulhXYm2DMcX/M?=
 =?us-ascii?Q?kfcs8YX+Bpjb6RK0Admu7x5qHkwxnaduPtV7OfgJvHUNvsV/SLT8mut61Rio?=
 =?us-ascii?Q?cx5FtkiBzZVBt/dJu3/xqwtrDlwklGoOvrnhoJPMgQkuTN6/FSWpOEW6QI4j?=
 =?us-ascii?Q?Zr/JlkAfi2VdCw+T8HwDSoGE/Z/GBxnPlOWA00ueI7ZQsUFO4XFY5bUVxrpz?=
 =?us-ascii?Q?boneaWH6rPX8VRVgatkU5GzNzWuhdBineBmFnOkyNS4p59HHZRGghBgkbl8X?=
 =?us-ascii?Q?u259hk40J3K9Ym3FwKYF6USISTA9TrHnOR2IQlgoR9y0VBAUR5N34SK7UmVc?=
 =?us-ascii?Q?kizpzHQt8jCxj4xD/rPCjoCNdcQvDsOnQzTIcfRC+QGuuWLAdxT1ARjx4zLs?=
 =?us-ascii?Q?L05ThD5UNSz1F3VcZuZiHfWwyqrJeyK/aFJq9hyyJqK8QLXrS1BMMU9TtT10?=
 =?us-ascii?Q?bvsYMmRuZbObTGnb5MMRURRFtbM0nDwm1cQF0Bs3l4ZF9mN26bhYTDJ9IE8l?=
 =?us-ascii?Q?Ua9G2qHUiT8TTHByPG5tAbCBe5rmhRHoQv+QPwU/CzVbgUAzRjeP3zjb1R95?=
X-MS-Exchange-AntiSpam-MessageData-1: I8h0hLf5rRqezmtooZWnsbmSBXhV3GGisu4=
X-Exchange-RoutingPolicyChecked:
	XCNF/UzMXihUApbPA8nBBIvXvinUO8om3JSmNdiSbBVvr1q+CcSHYDsBTaAOI7/5LfbYpQX/I6xP+Ycj0WgVOVC+R0o3Udh7V1Q+jVVjjLYKDWBR5oweLb1r5AUk2g4jzIZOG14206zWjprKtsmEg2fAM4Sdbc1AbWILUhJaz84lnO2YEZ4mDud+808jFLUlZOEqX3RLoeSgt0h5vau1T/PxB+0q7U1Ucmhnss9QyW7igkgPQoJ9Q1HUI7Xyf2JlYh4JtmnuieN3XkOPVr68C9ahtoftSx0957GiBwAj+6nkUowP9XKMFAqS4AZTiXOOxzphjFGJrjajmFzb1LuR8g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JtGIAX6lhN6bqVvI0vWaJn6F68ApQ0U0Z0EIKSSNKxsNICA8Q0aP4IxsKgg+8ThOxmvd5z6JOguE1hkLm+B4tej8hlgsAYxULL5dS65ayL4qVrEdgWsuuQkMq+gDtf/vdtoYlUJQRyHf4hsi5z9gPruOI6NOw/mWd600q1l5AkeRFsmHLKrN0tlQ54CNyDxFxA8kfUFMo/5SJ7nYDqY1lH3cFxmy1H0U3S/cScHG7+CESOvK/qoCi0QqRRqSiU+RhQjsM1HMzVk7BFP8TbuembGizeJG+UYIbs0En4Iw1mtQUhQ48G9AfbeY5RCUyl62hTZt5X8jHmwlkMgGLCE22YmPkwDJBnuD0mqjZXfU+XEJ4imujkKchdF+TLIFPqtUA9fCWz6aXMqSS2AYRZKARW+iqnjz7MR3+ngPxxYA2A8zZ6h2/9Zoc/IVtdfpxxBIgNkRlmsF3qukxL2t19i3Es4C9+D++Oyp7Hn1tXpSVd6hdLK7Uu5dX5EtfWp72YGyz/CpZ7pZ4ZRWMD1K7Q+4XnuXtXnVU4vwfex5LJEUDwGoKFnuaeWdgqHjgy6QEEdhpLhoPL/9CL0MdAFj9rhcb1Dz7USe6/4qNIN/srxhIHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df469200-fd84-41da-22db-08df1fcb8323
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:45.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UnHE1tnRE1Q9wtnE5vyW/saThkJ7xPUrfy+AvN0iulnj3x7v+kWYaZG9ugAbH9kUMe1OP/RMBbiZR+fMxV2pWJOKSw47ukEmN/XguuRiPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX0WcwnUpqoPVp
 QYQGB/e3bxj/3AyeQWJ+sPSv/uNUX27400E0Paczu/VH+0iHDEEb0/GFJK8Gjwz8e4Ak1yV0CZ3
 8zhkolZXAEheMmJPl8gZDKyFKT/a4j+m/O6ZXEgwHca5Cpe3YOWkd1p8i0cAB8HnW6t5FPndXoP
 Io8GaRviGoRq7SzaqukEiVzyzo/15P7rAdpeo9UrwSw0MRr1yzNPgYk61CuCvTw/HejLvIL2Yng
 I9cNclPCzMajAH4hgfpRlV9UQWSlCFsPHRPxTCns0ULNCLehnA+EW40L5CBwZc8rFIp3DuoDXiR
 0ETiyfOBYOSEG/a9eIGRh0IPge9sruehvsUojud7FnOb0hD/hEIyUZKHqoFa81/bghcwIwii5FI
 e0yFGs2MjuvRZ4rYSo7J0ik80uLRjStguPHEDTr9DdMLHBTo9Ap7OXs6+p32T1Mt4v03TuV3m1D
 uPZEdPtD48mRFiipsdw==
X-Proofpoint-GUID: y2ZpbzLyFwUdwXo0ZDEBgGakpW5Bc5qB
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe7390 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=HRhzHcoIBzGTXiVGymcA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX1erwprsAe5zy
 FrTVtXOKx+jO3/Maa7VQeCRVxerDeiJTBXGs7Pe3uUDrZKsXRShMjyLBiZSsSaKqxpWt8g0wO4L
 Msbi78DQR+MRFuWA4f+u3RJE/S26rkpg0TJpmUxDXwCN2zT+KOUd
X-Proofpoint-ORIG-GUID: y2ZpbzLyFwUdwXo0ZDEBgGakpW5Bc5qB

From: Dave Chinner <dchinner@redhat.com>

The stale buffer item completion handling is currently only done
from BLI unpinning. We need to perform this function from where-ever
the last reference to the BLI is dropped, so first we need to
factor this code out into a helper.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 816c330b605c3f4813c0dc0ab5af5cce17ff06b3)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 60 ++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 033ec1e2f2df..f13df8adcf4a 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -539,6 +539,42 @@ xfs_buf_item_pin(
 	atomic_inc(&bip->bli_buf->b_pin_count);
 }
 
+/*
+ * For a stale BLI, process all the necessary completions that must be
+ * performed when the final BLI reference goes away. The buffer will be
+ * referenced and locked here - we return to the caller with the buffer still
+ * referenced and locked for them to finalise processing of the buffer.
+ */
+static void
+xfs_buf_item_finish_stale(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+	struct xfs_log_item	*lip = &bip->bli_item;
+
+	ASSERT(bip->bli_flags & XFS_BLI_STALE);
+	ASSERT(xfs_buf_islocked(bp));
+	ASSERT(bp->b_flags & XBF_STALE);
+	ASSERT(bip->__bli_format.blf_flags & XFS_BLF_CANCEL);
+	ASSERT(list_empty(&lip->li_trans));
+	ASSERT(!bp->b_transp);
+
+	if (bip->bli_flags & XFS_BLI_STALE_INODE) {
+		xfs_buf_item_done(bp);
+		xfs_buf_inode_iodone(bp);
+		ASSERT(list_empty(&bp->b_li_list));
+		return;
+	}
+
+	/*
+	 * We may or may not be on the AIL here, xfs_trans_ail_delete() will do
+	 * the right thing regardless of the situation in which we are called.
+	 */
+	xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
+	xfs_buf_item_relse(bip);
+	ASSERT(bp->b_log_item == NULL);
+}
+
 /*
  * This is called to unpin the buffer associated with the buf log item which was
  * previously pinned with a call to xfs_buf_item_pin().  We enter this function
@@ -588,13 +624,6 @@ xfs_buf_item_unpin(
 	}
 
 	if (stale) {
-		ASSERT(bip->bli_flags & XFS_BLI_STALE);
-		ASSERT(xfs_buf_islocked(bp));
-		ASSERT(bp->b_flags & XBF_STALE);
-		ASSERT(bip->__bli_format.blf_flags & XFS_BLF_CANCEL);
-		ASSERT(list_empty(&lip->li_trans));
-		ASSERT(!bp->b_transp);
-
 		trace_xfs_buf_item_unpin_stale(bip);
 
 		/*
@@ -605,22 +634,7 @@ xfs_buf_item_unpin(
 		 * processing is complete.
 		 */
 		xfs_buf_rele(bp);
-
-		/*
-		 * If we get called here because of an IO error, we may or may
-		 * not have the item on the AIL. xfs_trans_ail_delete() will
-		 * take care of that situation. xfs_trans_ail_delete() drops
-		 * the AIL lock.
-		 */
-		if (bip->bli_flags & XFS_BLI_STALE_INODE) {
-			xfs_buf_item_done(bp);
-			xfs_buf_inode_iodone(bp);
-			ASSERT(list_empty(&bp->b_li_list));
-		} else {
-			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bip);
-			ASSERT(bp->b_log_item == NULL);
-		}
+		xfs_buf_item_finish_stale(bip);
 		xfs_buf_relse(bp);
 		return;
 	}
-- 
2.53.0

