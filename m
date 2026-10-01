Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCE51FCB7;
	Thu,  1 Oct 2026 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866280; cv=fail; b=YiPrk6tjyjXFiAfxln1hRdoqYxKMJn0lfCbQ+V0TOs7J9ptbD4Vu4Cwp9zAGYTDlcCrva8sH/fCjf+d5OdQPDT40CAt9rn0QIOVsRmPlydieRCRz3qvuIZRYo5pdz1L74OEHYLgiTNKNJiZ8M8Ef+azRfid3NxXbp7TglEc5AyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866280; c=relaxed/simple;
	bh=pRjzAAQgrk4T+pTgQQkm/FMlZOMeWfSr0j9fviReyiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USx0wxCzJOeqPue3xiKyPhPo8cQIuKy5MZE3i7OKcWEEeHetqBXgn0qIOzcIX+vCYGXdF7P0JrdStU/cnmfOy+S6p1haTrGBXRLjKpawnmJIqKMwZDD8Fq0U4Tklnsg6frvtiO2sNKwH2x5mWQaZlvxQBTBZ6bG2U0Tu5eHNP/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hb0xciKZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o+kuaVI9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hb0xciKZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o+kuaVI9"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DNAbj2257464;
	Thu, 1 Oct 2026 14:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bAvzOLo98/f35npuTjGouuNBTubi4E1cQJTfqrs+WhA=; b=
	hb0xciKZMVTPHOgkJyCKObcH1nnFl/IcAtJbN2Ad9vtX0mOgWM9d3JvIySTuxWo6
	/3FWsweNYemqXftmCTFXMJf2G0ytZtx7qh1sszzA0PkOM0gd32L7eCaOcGaNeRGA
	fdR04ijOWCvy9poiNY6NAUNbpEKQcNzN/7qlfI9cpUlaaCLqg8ulkKGmH/Hcrlqf
	YqZc/6/Bs/43vQFIDykYKCQwiB9pgrV7TX1YFn/6SBfROl9KBIeXXGS7LGYtuTdY
	ffev9RqMmEs5tPYIbwxX8z1jzUcBDJlR1omKEqkH8CElr3tYKkzWiGRg5frTDLQ+
	UVRNFMYV6jeWRsoIGNEzCg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoSkg027827;
	Thu, 1 Oct 2026 14:51:12 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsnsre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8l+JhRzO7U3NoKYuZqkgCYpGqq/FlD+0WLrNFFHu8LV2bxCv876XfIzzoMwPYgfx7OEPk+a6hlGBKridaRz4JEbttj9xXNYrHRjFJulYGrzAz17y+fkWFo2D4A49ItDaipbFjm3Shc1Q/Rl8AQlfwteYw1nSM7Vr631aASVMJ0TWps8lYHwE/Uw3HoyytyJl4C9Z1ExI85nlG5UIZxEDZMhB+NI1mutISMJZzkoT4FnCe7tPNftWr4QRlour0PWPhJwNlcNQsJmV5xFAtxD4ukBu9vJqUflnWHPM9Ey3aVJen/PD3ryqvji7GWodZmaDqLuWZBAzXOsfzboKat1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAvzOLo98/f35npuTjGouuNBTubi4E1cQJTfqrs+WhA=;
 b=AzZEcK2vgng2711lUnrM+RtTHu1iCw4mxCeflRHKzLRizVinSyuXIRzvSK/l1nJrZF6UpakePYpzwQ+ePl4Dd0+giQ24njy4i1Wwxd0OfdTDYhzrLledVlLHKBdAXAHV0ZRyP+FtVTpaPyS1d8xpaZT2+pXpQFL5sk9K6EkfelgeLKGAXZU6AVjAXbDYpUWSvLBQftc4iKTEgBmjoiFnBYVLoFPF6Y3L0Od73cLUKwfIDDm+aIe4CSnLilzxSGJDJ77kAOkMvWh3zdZv0EERlhAgFDxsENeTA82tyIB4oSaXpYq+FKq4x8LXijQIKLP6zK0bNWmP5bv2RMqcwf83wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAvzOLo98/f35npuTjGouuNBTubi4E1cQJTfqrs+WhA=;
 b=o+kuaVI9Y4r7i4Nq1e85AskUPO20L0gRs1bNxlWV1AJiayPV1VdHYW07VRDdC38fkQO9bz+L9/FTQwGaGndn2pgk8789L1b6Iet7/R8DU5/sFwWxD1JVmPKE+EYrDO144P3/NOHnxJfciNb1qpMYyjMNvH7Ie7gfMbbULfcg2sY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:51:04 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:04 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.12 1/6] xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
Date: Thu,  1 Oct 2026 20:20:47 +0530
Message-ID: <54bb880296a6127be3107deddc7117965eed11d0.1790864403.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864403.git.siddh.raman.pant@oracle.com>
References: <cover.1790864403.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:295::12) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a01c378-bda1-440b-8ac0-08df1fcb6ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	KdpxyQjfB/S8FbTUBEbxp4xx5WFxUYHChLQdC9N1b9C7ap/22vBFC1Psy0fSWkVb5UkGZGbiGQJ9GUY6d/gZ8yNMYeTRrVy7Pj/XZzOgTUy2oo1j7LZQqZavAF2zds+/3lGsmCtCGCwZp4D6SBYs8W+X1qlGPnIrcJjCYDl7Yi91jv0jaYNTcFX5ZMxb0OpYcpcnSU+3e1x2GnQA5fQDXp/oooG5dTAMRbEIsBqtZZBtPPuA14U3wyb7U/FmzB9X6sb+GAb2X0FJ5gWfrOQYPaMSh+hpeH1+ORAYVgpk2jpxxF7EirJF5fqLI+q8aKicy6llYk8kwMUCdHushoeUDzLKdR7K5Fh12E36Cbnfp8dsYd/nJxDZ+yf9SdZXQ2EmtC/sSAA4k8mXPiZO3ivXZO93zXmluQmXFJ9gHPPSkALWiEVM+/B2z+WwL9XPU4fn9YqJEEnyLSkJ9arehoTuRjnJq4JBzkctQEN2qlSZjcPhzf6raVFo8QQFzjMFFtIutlNMY5Rpetahe+iTOZiXmT28dwbkljoQt6bbo5X5dqQ0wY+QcqBryFtjGCUWf1HrJVyTJJL9HzTUYkflaX90QbTGhquy0TH0eAhTBNwljxy9F108C57NkYpR7PAAmwl/iet45YvpDE0Py69hf5d37wjeehUSiLY1D6TiAssw+Ms=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HtjdIzg2Y92jLO9xhnNpUMvLQX9J6iXYUvHHg/2Xf4tIc19OaYJEb5H/f2+m?=
 =?us-ascii?Q?K0JMlCu+WGfv+lSq9hzpQB5MbeIsygUPDOD6FTdKgoTJrvpTad5SpBWV/Vfx?=
 =?us-ascii?Q?+1XFwG/d0CCU5sjA9dSwoMwhSfPo7nT2LQlnKr14nQKjWrHC3kIV8Ze+icvX?=
 =?us-ascii?Q?u5Or+/5Izxa2rjIS3iF1LKGEVvT00r71gmg4uqRpZHOIDU8tFjwXNYshKp7u?=
 =?us-ascii?Q?Aqxw8U0kqmOj4SAQN3Am6ntGtWjSCTQVLjUTQEFa/8bNvpRXVTFCFCWG1xgF?=
 =?us-ascii?Q?bN7eaTLWcT4NsYV9QZmvLN8MCiaxMrvkp4iYaEX6qv9Zd+c06Ypl5oMN3Q/X?=
 =?us-ascii?Q?IC4GclaFR3TOd6vTSRgt1tF9cYGW3JYqwkeN9awe2Yf3q5rjYY1XsIrT/Pqn?=
 =?us-ascii?Q?WIoxli4Re/1vztsUH1vOfv1KNfIpoihv0BcIBXmuRihu3k6M/HR7O90/Th0l?=
 =?us-ascii?Q?0pZDXkG3ukmRJj6OQmb8QoVu+c7vit06NGnbkYWlUiezB1CdOac2Fp7g0q9F?=
 =?us-ascii?Q?d6XLE7RBa768T2Y7nFVqturnC4PF6Hql21Z57W8NM1nDdn09dhlfnGjDBKRC?=
 =?us-ascii?Q?qW7gz2e22aDMtByrnLBYE6C1peIBaqMCbu1HudSxyEwIZntHCoqLB8MnsC8/?=
 =?us-ascii?Q?ceHrIl12Xo7mCFvu2Y3GXHCh2CL4hRGLWWdKtb23qOAkoys5B384LQn6HlAz?=
 =?us-ascii?Q?21WuV3jNq5cCuZ6e6oSBc6B+yjAXoh0N/RT+Q7jw8AE9NfzHzJEYaD7e5hTS?=
 =?us-ascii?Q?SfYmWvexqQ5FLuc8W/mtDCBS3jTde+bppxx09mKNsIZA6awT+ecK1+vihTLe?=
 =?us-ascii?Q?jAgrE8xd66vuAl6TibyBWhdghzTlzf6a6DrqthSoJeCNp+/lSbi5Ffgy2Q0J?=
 =?us-ascii?Q?ytgwa2nygm0DlmmZA7oKoxkDQowtzNlHEhwDYnCV/fh0cuTeJhWEH/Wh3tvw?=
 =?us-ascii?Q?FOEvuRIqDDF6GH+enm3baN95hoVJVs0AdUi8eE/kRTrdJYAIkvyimWnWqeYN?=
 =?us-ascii?Q?TT0k9lgYje5gMNQuYIA4222wbsQigoIhMwPTWhdugnPSDoOqqvuQbD5vYbIP?=
 =?us-ascii?Q?o8QODU2wMqf4YNodVMcVgl51EY/+rLlyBwZzi5uDFbM09DatBnkXpqhzIdBL?=
 =?us-ascii?Q?XG/RA05vlmMSeJVmnW3WmviSWzLWXdB1st5pQIyBvvEKvNdhZq+fIeUXfKYY?=
 =?us-ascii?Q?uL2OILkECmE8sMtYOVQMfNZtZ9DwdEWFf/yyANfGPx46Z0dO3ESI/OyXFGJQ?=
 =?us-ascii?Q?iEYeC38dlV/G+Sv1j76SfV/L/2Eve0Ly2pZoES++n8W1mP665Puvqq8PQvdk?=
 =?us-ascii?Q?EqQyOugjIbKqeF0kMTM+U5y1orih4wm7IPKIZmMvHQbCNt1mFEj/1AFipeSS?=
 =?us-ascii?Q?3+Wex6kRfoMWH9ig6eB/tFnDtWUwmQstFUP3pJR0uErpvxDuwPVl5jclswzw?=
 =?us-ascii?Q?+TZ9r5/Yx8tiO6eyDyC7NepRkh+Dkweftk+i9BZWbc6Zpvsg9JQyhfJAtXVE?=
 =?us-ascii?Q?qbH2NuOgB1R5LuAv49UK/IeTeYq2OahD4PjlnLMoAMz859lqcetoHTgqEgwa?=
 =?us-ascii?Q?WIlEB4uM7dEZmnLum8rjLSWKrWA8hbh3DNIvbna+2S5jzMoLH1d56s88MDd2?=
 =?us-ascii?Q?RAnx4LQT+1wVU9slqUgyh3zVWmFdBJqTznB6+XY6O31fjUnks6xsGoqLF3Jf?=
 =?us-ascii?Q?zzgbmXaoR4WycIwa7jh/d1Txv53D+YIqPLh5ZYRFKT4jItHjvIODC3vMfNVN?=
 =?us-ascii?Q?dO5dN+od6dCabnMcmXweJ9deBBPyQwOQo7A8ZekcR1qfauTGzC2Zln2SpwNp?=
X-MS-Exchange-AntiSpam-MessageData-1: Wb72a27TcAmGuxR4OGphf0mm5B8G67Eyu0k=
X-Exchange-RoutingPolicyChecked:
	tbnzks/QiQyiytv387mpDxPClx6rUo6Q8SZwZKS0C95xM1SmnUbCQNS1EA+Jro1SnB96j9rmurhAYhJ673rM/5WkW0nM64vcI7iKkYsyR5DO1vLxOp5jgP5+xei8bJRuARBG4oH6taOiLJFmZfHN5VQTFCf626GEpTSftBUBoWX1AsUyJazy6csegfZZtcDIBGrQaDm6x6U3KFkGCHOGyxjM6oDBypdYnRMSYDqg4n2jW8OtevhQELp5rU0rETj0Wz+VJWaA76UW6Y2iWt++a4THOFd1Ha78Sf7tD30RICn8F4JCDT5tQ9VX4zpuoHqh1N3WcPILNVE5QUaja2vUDQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+8LLnXBOyUIqBXIMKyVYd9KKlZHv5yC3mMQPnxwpH6op/mMfRXn8B5YphAvyhATcxti/Y7EdCvYH803sqlTC1dQ5lWtI3bdkU6N0PouFNFRdyOKfR5jBZyzyfDNIoH4nv+EV5O+J+AqqYSBdCtW3XMfP8juRknA0ZPkibqkc8b45yWabWpxGr+aPDN0fN12U0OqPWyDa2YisP7fkf3Fdnkbj6fGM9ryurDE/XEETNlcCO90oESNSKzoDfuK3RON0WlNqZk2TQ4pqZv/AKKotjApepqwMaSKW3SXoU8jWxoSRWFsAFCAdgzzKvFCFV9fIPSHKtEB9NHCa9/Bztrb63Bg0nQxs9FX4OrEfLXs2FTyJLjvlwaBcs2buG28IdyMAeDTn1PFrkhIm78FdkgGBC/k6SkBaI9P5EFOCqtud6nrvb91I0bHnCIxIyIN346MgUzVzYE1yuRN3ROW2iYEhIid4hL1bZeqfN/bjoCrl7DpHlQl7gBclYUZg8WNyrar7lMLxContBxyDKkVQSZEWfSlTWWtMkpfQyBTFXn5QLH5e9AT7L7knxoMt2bGa91OcUc0YqXrtMCqGRWRJJme/pKcMgHoB00mwVYDltyHO1Ig=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a01c378-bda1-440b-8ac0-08df1fcb6ad4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:04.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CXgdhDUzqNE7+QWK1EYylAXRZSvi6hkFXK8Ya/y4Q+SpqKGf2Gg8jOXqFleoHJxBUd0dTaqLx5lJRGZArBTHtbmufx1NKJ4A/WMgU7HFMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXyJvLNU5fD5vL
 jxLa7SWH35bYz5JITcwEZgaVz05HoSMan/HMe28+r1MA6MsGZm32/+xhTEpprTEjXbRlZlQ3BY1
 Rt0NZ74uCRsEbDkD8KhOkkqxcA4twdfTC6xxto+3nb6Yl3NQJtkA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX7YF+1VEemD1M
 Sfl8pCBLgYqrsLIwB1Lm+GdkM3Z9ts6yuEFC9KCNCV5BPpOZrdOetbZCOUtX2SFnLDO5GYl0IVq
 BX/ktwaRJso8z/ax8igMyBv3seshyAa0iSXyG0z0y0+kucBmimyGR4+PDBS6KPEHc9doCF9UUZv
 fQF2a6pVO0yalxFHbsN4TQjw+iMPLU/bLO47SL1CPEks1iMaX963h4AvQzQ1f2c9QOO8mOlDVMT
 vzfLkkKraCR8fzU5Dt/kISLAGjQoGm0cer8ClIS85od8NDiImxAn1HfFhJ94AiYemQX+kdXeyRF
 fXxeZKBmy3EEDV+SANpNJMkD4W1yg7EyrCghi+nAJMSbrd+xmkGkzgZ0Eruve4dBrAfi61XW2Pn
 AYeEdMsO09C7GLRUM+j60wtdT+xGWqVY7w6UCjG891ncMMXQMfCn2+8FCPD8KaoKBp11sRJprde
 EmTV22YzhjOMpuATiszqkL0suYY1XzelZ+yfGta0=
X-Proofpoint-ORIG-GUID: oDCV4nruLSr4O0r_yXQM7ZdXdWDtzw69
X-Proofpoint-GUID: oDCV4nruLSr4O0r_yXQM7ZdXdWDtzw69
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe7361 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-BFCJ2bJgao7vN__fc8A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12108

From: Dave Chinner <dchinner@redhat.com>

Lock order of xfs_ifree_cluster() is cluster buffer -> try ILOCK
-> IFLUSHING, except for the last inode in the cluster that is
triggering the free. In that case, the lock order is ILOCK ->
cluster buffer -> IFLUSHING.

xfs_iflush_cluster() uses cluster buffer -> try ILOCK -> IFLUSHING,
so this can safely run concurrently with xfs_ifree_cluster().

xfs_inode_item_precommit() uses ILOCK -> cluster buffer, but this
cannot race with xfs_ifree_cluster() so being in a different order
will not trigger a deadlock.

xfs_reclaim_inode() during a filesystem shutdown uses ILOCK ->
IFLUSHING -> cluster buffer via xfs_iflush_shutdown_abort(), and
this deadlocks against xfs_ifree_cluster() like so:

 sysrq: Show Blocked State
 task:kworker/10:37   state:D stack:12560 pid:276182 tgid:276182 ppid:2      flags:0x00004000
 Workqueue: xfs-inodegc/dm-3 xfs_inodegc_worker
 Call Trace:
  <TASK>
  __schedule+0x650/0xb10
  schedule+0x6d/0xf0
  schedule_timeout+0x8b/0x180
  schedule_timeout_uninterruptible+0x1e/0x30
  xfs_ifree+0x326/0x730
  xfs_inactive_ifree+0xcb/0x230
  xfs_inactive+0x2c8/0x380
  xfs_inodegc_worker+0xaa/0x180
  process_scheduled_works+0x1d4/0x400
  worker_thread+0x234/0x2e0
  kthread+0x147/0x170
  ret_from_fork+0x3e/0x50
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 task:fsync-tester    state:D stack:12160 pid:2255943 tgid:2255943 ppid:3988702 flags:0x00004006
 Call Trace:
  <TASK>
  __schedule+0x650/0xb10
  schedule+0x6d/0xf0
  schedule_timeout+0x31/0x180
  __down_common+0xbe/0x1f0
  __down+0x1d/0x30
  down+0x48/0x50
  xfs_buf_lock+0x3d/0xe0
  xfs_iflush_shutdown_abort+0x51/0x1e0
  xfs_icwalk_ag+0x386/0x690
  xfs_reclaim_inodes_nr+0x114/0x160
  xfs_fs_free_cached_objects+0x19/0x20
  super_cache_scan+0x17b/0x1a0
  do_shrink_slab+0x180/0x350
  shrink_slab+0xf8/0x430
  drop_slab+0x97/0xf0
  drop_caches_sysctl_handler+0x59/0xc0
  proc_sys_call_handler+0x189/0x280
  proc_sys_write+0x13/0x20
  vfs_write+0x33d/0x3f0
  ksys_write+0x7c/0xf0
  __x64_sys_write+0x1b/0x30
  x64_sys_call+0x271d/0x2ee0
  do_syscall_64+0x68/0x130
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

We can't change the lock order of xfs_ifree_cluster() - XFS_ISTALE
and XFS_IFLUSHING are serialised through to journal IO completion
by the cluster buffer lock being held.

There's quite a few asserts in the code that check that XFS_ISTALE
does not occur out of sync with buffer locking (e.g. in
xfs_iflush_cluster). There's also a dependency on the inode log item
being removed from the buffer before XFS_IFLUSHING is cleared, also
with asserts that trigger on this.

Further, we don't have a requirement for the inode to be locked when
completing or aborting inode flushing because all the inode state
updates are serialised by holding the cluster buffer lock across the
IO to completion.

We can't check for XFS_IRECLAIM in xfs_ifree_mark_inode_stale() and
skip the inode, because there is no guarantee that the inode will be
reclaimed. Hence it *must* be marked XFS_ISTALE regardless of
whether reclaim is preparing to free that inode. Similarly, we can't
check for IFLUSHING before locking the inode because that would
result in dirty inodes not being marked with ISTALE in the event of
racing with XFS_IRECLAIM.

Hence we have to address this issue from the xfs_reclaim_inode()
side. It is clear that we cannot hold the inode locked here when
calling xfs_iflush_shutdown_abort() because it is the inode->buffer
lock order that causes the deadlock against xfs_ifree_cluster().

Hence we need to drop the ILOCK before aborting the inode in the
shutdown case. Once we've aborted the inode, we can grab the ILOCK
again and then immediately reclaim it as it is now guaranteed to be
clean.

Note that dropping the ILOCK in xfs_reclaim_inode() means that it
can now be locked by xfs_ifree_mark_inode_stale() and seen whilst in
this state. This is safe because we have left the XFS_IFLUSHING flag
on the inode and so xfs_ifree_mark_inode_stale() will simply set
XFS_ISTALE and move to the next inode. An ASSERT check in this path
needs to be tweaked to take into account this new shutdown
interaction.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 09234a632be42573d9743ac5ff6773622d233ad0)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_icache.c | 8 ++++++++
 fs/xfs/xfs_inode.c  | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 6b119a7a324f..55b3b990f217 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -923,7 +923,15 @@ xfs_reclaim_inode(
 	 */
 	if (xlog_is_shutdown(ip->i_mount->m_log)) {
 		xfs_iunpin_wait(ip);
+		/*
+		 * Avoid a ABBA deadlock on the inode cluster buffer vs
+		 * concurrent xfs_ifree_cluster() trying to mark the inode
+		 * stale. We don't need the inode locked to run the flush abort
+		 * code, but the flush abort needs to lock the cluster buffer.
+		 */
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		xfs_iflush_shutdown_abort(ip);
+		xfs_ilock(ip, XFS_ILOCK_EXCL);
 		goto reclaim;
 	}
 	if (xfs_ipincount(ip))
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 266fcc789098..3b487341348a 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1624,7 +1624,7 @@ xfs_ifree_mark_inode_stale(
 	iip = ip->i_itemp;
 	if (__xfs_iflags_test(ip, XFS_IFLUSHING)) {
 		ASSERT(!list_empty(&iip->ili_item.li_bio_list));
-		ASSERT(iip->ili_last_fields);
+		ASSERT(iip->ili_last_fields || xlog_is_shutdown(mp->m_log));
 		goto out_iunlock;
 	}
 
-- 
2.53.0

