Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43F325701
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449837; cv=fail; b=LDUZW7GQpjP8JqXaw20eiwFhWt/D3nhjXvFpJh/doa9s1KpBnW3fpy71DKmisKKLrj93Yyyc/v7nXN4WWz7cyJrAWEDFTvU/gZiBWzZ2OCmeId5UuQ/RwW0Tll4HTJysuYqgf+3TAdLG5NGmMg12ad3dF7iVJDC4tC1XbGoKibQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449837; c=relaxed/simple;
	bh=wf7X18yrs2EL2t8gMdZhboTu9HHOQlBtH9Vun9wnNTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UN1ZA9n7CYet8+FBHhlHjUTqbjXiNTCOE7knvadm/Omnp1Oy92zJNg1FAf7JuRrqhqoh1gEIMEzIcVz7lzkdwaCAGnHTmgilVKlTiEN4xDV7m8yF5VBinGXVMQHcv3db+PsaOsge/TnXk90NilL8aq5f4tOWVpRY427+2T5y+1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=WeaGsVvK; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="WeaGsVvK"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6530o3l33054775;
	Wed, 3 Jun 2026 01:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=MsErWodfimwBQLyZu2eBFejvVv0GGcVTb1qD1ttpvHk=; b=
	WeaGsVvK2CDFjJOFqmuX8906VbFD+Tfkneln/zbG1syRIl8HgGQq4jTUoZR4t/tS
	d8SCCfBAWqB4WHii3gSB1dknAkVgqkG1iUIOw8+I9FGqE2rupiwKqeJogofQ36pB
	lU80i2CegNplLScov12Kuv2ku7CzNTiA7IN6sKeVn4NQzcnqQIYLx09mvxb+DqaZ
	zjCKL1XVwq5SFoXoDy4FXqNyZ+BFB1uJSI7RLwA3a2PT1BiD4n9huRgGIgN3NsZQ
	ivuxf723kUh2i7Q4Je1zFFwkyU2RdM/yHNsD1TUdnxYOkgTo0BYJJufGAnde5R6R
	6ElivEqTPYxVULt8zro+HA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efn405yp5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 01:23:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPa4yzOt+/oECuXK/U11Kv75yGYA9NPljBKANe0z9yI6Uy5bwuFPgkcfBqyeVci0Ko13uOhJn4tnEm1Mqqubr07fskAwE5fAqsauBxS8Qf7P1aZan3Z3Ar8v4bedpIQItIfspwTyGwy0gGfgEyDa4c9aQTavog2wRWNRhmBz/p1q1fhtk5MNoZRRrQdiRIzddLL1eCEY8lK5ChTN7mG88vxm9o+z0+nHOBb3BNwZQN6VmU750S/EL3oaBu7zY+y4lhXG8xOh1r1o1grRCuvgrHIfqsoAyX+L4MQOL5wA8a4ku8nL5Czob0iWYm6WXFz1n4J9eZtL0I3CSgfdzpvzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsErWodfimwBQLyZu2eBFejvVv0GGcVTb1qD1ttpvHk=;
 b=oSvx0OUSwxBcRDn4Yyp21FiW25KlgeaKimyGvOpBpiNmaneCkLntDH+QWERD7kHEvIZkPAlLTID++OvcdSwCHiBZZQg4e5JWCpmhFvP4gSBk0VCENEoBjNjXxAzMyOjsJkLLHPN88MLvYnYQGKLpDgJcxmTgPPU6ga6qkJNE9e71IUtZsdmaXaRlgavAiF8kpvJXP9M5ZMkyxZtLOuub/Yd1JoLP5SkyfqlnSdx7sXYdVqs7b8zgiJ6IgKFBjYW4Cr5tV8RFzXV1UQOOc/listQRdyovNU4nAXGYtiGLfx7T3PA+q13dTIrg4kiRDRbWd43/eKB9Ez9oHt0B2tn52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26) by DM3PPFC89313B1C.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f4b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 01:23:33 +0000
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6]) by DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 01:23:33 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: catalin.marinas@arm.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, will@kernel.org
Subject: [PATCH v2 6.12.y 2/2] arm64: io: Extract user memory type in ioremap_prot()
Date: Wed,  3 Jun 2026 09:23:14 +0800
Message-ID: <20260603012314.4100773-3-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260603012314.4100773-1-xiangyu.chen@windriver.com>
References: <20260603012314.4100773-1-xiangyu.chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1d20cb8a-1f6c-4e73-a451-08dec10eba56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3+m4jytbQzv+Tz17Y+nA27PsJ2vzk2gpLcLgjDRNxy82yPlKrKL84OCVWU2B1Wo/7/3I6/EcHlDARweS3+kQNm78hTDylyyJiZSBQk6cQRwNfhb03TCW3um5JNdvqosBq/b1vi37lD83OBiRnKomiVEwvCvZTRtMFlROeDCCZsUa1RaZ5yJTEQKOFRd+2PCb6N+xiolOKJCsJmDtrBolGChdShMnWqZy/x03I82Xjp7B6dNQyrvQvEoIQj46t7O/T370VlN8irju27D8yMfjt0uZgOJ+hvvoi0cHMuCsPLFWvbIB0LvOl9zngXLXD8ehi3AoG1m4zF634nSFXJH9OeWl82lNcQbiVIMdNJtaRxZUtPFJW7EJq939j2R2tXfk+S1E5Hb2AK/ClIY57fgzdWHOkpoFy9sv8uesr8ik5YMWThf0uIF+ORW+LiKGxYAlOsVTYYpxp8VXTsvg2E36icj2o8X+PM1u4b3KPx74Y2+0ZELMIiSHQ1+YsBboRK7rdk1/4EsqOUHA6UDkAPGwGEcF/HbmvanJ6tBiQB+KKRn5C7KwjqGov5DN4j07BAWztQbF+6wQkddlCwt66BRmuvE/WTD3Ge3DyA7hXKKcfoRrzMTIvdoX/6l+rdgbhBHEXhA+38jftqYmDG6Z5JRrOqw9pgcXX8pCkqUHPhjZB6Dmrt3/XCc9G+dki5ICQ+IT1Z9Dgk/XMgoC9gmm2hcJ8uWE3RaxdN9O1UQyyDfmN45VU7sjLDo4/OATWgHxHnQw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF641CF4859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cnPc1yom1mvlkiskXwYMoJD3XXbIFlnWRDywNfvLS78xjjZxMtsYcxujSbN7?=
 =?us-ascii?Q?tuTqAXQX1m2V2KeZaGTFyFKShBYvKWbwwnpb+ACgOZaVDesPqFeVWK0mRVuw?=
 =?us-ascii?Q?Luog9Y474IgQo7Y/79uzVBrePhTX/Ombg+vbRWhyfJsd0Wqi9SuGN32aWLwA?=
 =?us-ascii?Q?F7EWT1xifODzykhj9jwXbwlU6H/vP7rqSKx9wmPfDlUuHfRQtBi/ePEEDKox?=
 =?us-ascii?Q?j+LtG8pmDSoTayoL1X/EeAzn0w37/nzzRGr5kRDNUhfuufwTM2pleWgPVJdr?=
 =?us-ascii?Q?Plp5C8YllAG0re0uG5lfliwzrx20K1EjjRn6Ej7Tfk8dvLG2tS2G3Bj6qx1+?=
 =?us-ascii?Q?Lgs33VMTVnx9gSEj9/P4ypsEI0DjYXznk0aqpMEg3FReXEvpZpZNGrNLvbzo?=
 =?us-ascii?Q?H9H+iR6SO5OEBtJqSPFheThCtcTx32oeYDyc/uQ39JYvEAcggVWydc3UPWGT?=
 =?us-ascii?Q?0PgkdG9Cle4EKvLdyhMnKIdaJM7MDslcJ+KvMPyHnVUo6bJCVCcKeKhuFJNY?=
 =?us-ascii?Q?EMs7tbVNIDqWuBu+erL1FsBAE9aDk4QnmL4RIvfgMyq4B8ZCUXS6SVWOu011?=
 =?us-ascii?Q?seBCGPZjjlxUt1CIg5raJIyqarOoM5ulJ063j27yQTjQ0aHxTc5HlhPaiiEf?=
 =?us-ascii?Q?1UPxAVPQJcArdW+zIR5c1NFBd0CczBtLAXX4JtucRw15HMm2qB3/JPTYvQHK?=
 =?us-ascii?Q?adhdgItCi/txrVExUTbWUbSfjK8Sp8PMg8LZrDvWJkGII1eranOK3XAzoIkV?=
 =?us-ascii?Q?aQHzX/MJX26/n+T+cmYtpNuHruPZROAJUQHtpKyEUIwaweSAzhUnZCF5jc0B?=
 =?us-ascii?Q?qVKNVr7qFtobBdKif6kJINCuESFB8fhBrhfwH/EJL3+9OVypd26EvV5xfg/0?=
 =?us-ascii?Q?Ai9UFP4l7oviCT0bUB4xmbYBUjwwDKlFIDuddR/rvQxO4hNyE5iBljTYTphR?=
 =?us-ascii?Q?9noru2SkPmd7JxfXR8x4Q9ECtCxMRh07ediUaxGvE5Dd0vUgR2XXlC0pTAHo?=
 =?us-ascii?Q?cDrMMqc2bbOpq0GdG5TNEaTJKJoO8oAOZP0Vtm9wTIqrt7levwScsqBARcD/?=
 =?us-ascii?Q?j43HjyXEF7OZiZKA7PrbLNzlGWUoZCfAuPHgpYw5hYn259LFVp3dn1LIPAtJ?=
 =?us-ascii?Q?x6Hd2KjzYVNf9BdH+vG+pFrcD47jyUplkazPoQa18gCRiID+XjAL+aeOKxcS?=
 =?us-ascii?Q?beYZRvpGcAsK8cXP6AtFXo5DwKscJSAew8P5heq3147GZfDybm/kmwyftHpp?=
 =?us-ascii?Q?XGS9jXO7rusQr24gwnzoeQLh5dz7hhWt8d8kMIFiT7AgY2jMXsb+1/1sAqKO?=
 =?us-ascii?Q?kOxBhe6QlXXWveGhLtSj3mC3VY3J+0riK4JHnqiqeqCVEUSZto6ut8l6Rsnw?=
 =?us-ascii?Q?95TbBHtzpYOqchi4soVXYcb5k4EnGxGkU9FJyFd90odbCgmTmt3S4QRc0665?=
 =?us-ascii?Q?8GoguHrPQDHfN9VvPUkoabuT1/ue/VnXoTyuKHhhQWN+8p16qXqXwrNYyEpn?=
 =?us-ascii?Q?QSIyjckryjlUAc47DG7yo7Swm/stcf+zDJ9z0RfYvj/Aia2e8whzGFkGz/Tk?=
 =?us-ascii?Q?mG+MFZ0hrodWXgRkRf+PMaF/TrJeAQ4UoWJ5PTJddqyVPfKURjxD0DVIO4ie?=
 =?us-ascii?Q?JMQvEmZZSoqA5SSHoiKretpUT9wXQgjb1Jts6DehhrFz619K4fZRhrRLj7dG?=
 =?us-ascii?Q?HCjg8wEygDtq3LeM0DfArswnepzvZjfqrEvXf6gLsRHe+SI3Th0QQ1NpYQaA?=
 =?us-ascii?Q?D8Bw6L0U/pLmLBYFQgSTPgVPzm3fO54=3D?=
X-Exchange-RoutingPolicyChecked:
	aCLxT762GXv1OMHcCi3TLDH019apf2NsDi+DdD8swXxPylUc/XOi/DzSi/cyGgE0PUYQrCgJ2z89sAIQtsPopAlWWCANKvWwKzB+x35kivWwYTogXB7waAdPAngIo4tf9wxaMhV0gzxguByqa1KLRJUeR94mt4FaFPTeu1x97M8eiu2p+1KBkI60JOlk+Hv87ek9m+aceaKq1QBujfM3kyQLdSyLWQpOSeFaOd5M0VIxne7K+JysdLRdXw3vzCOWd4KbCXT+swccCtLqGboKbbl8CnkJrT8q4EHHk1cUvdnZlZBklIrGQkJDwYPfZAM7Yzk3tARgt5xOouOU8WiXkg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d20cb8a-1f6c-4e73-a451-08dec10eba56
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF641CF4859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 01:23:33.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnYcm+G0102SmQtdpYv4iMb1DkCXFtYV6bDQHPtMzgWPz3U1/j0GUzTVOwbdeEk6gY0PtkbApBx5Fshd5mTzQgxXvEE4jnavMUo00FbXPgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC89313B1C
X-Proofpoint-ORIG-GUID: wMJ9QFk9hV2bc15ID-nWT1EpXj8l-DiV
X-Proofpoint-GUID: wMJ9QFk9hV2bc15ID-nWT1EpXj8l-DiV
X-Authority-Analysis: v=2.4 cv=GI441ONK c=1 sm=1 tr=0 ts=6a1f8216 cx=c_pps
 a=mt+QW+PagoHSMqpqf5GGBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=7CQSdrXTAAAA:8 a=t7CeM3EgAAAA:8 a=tSOKoFa4O48s7TcIx9oA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAxMCBTYWx0ZWRfXzSRBe8wO8/+k
 Q1z5aVQj0C2sdlQ6r04HI0BRm1S544rPLLbYBcaq6C4kPec/ynZIeg33q9f0F+ebAw3Be+WMo6s
 e62QHbD4UJUHQ2YinVqmpjwlaXRe8sU97P30rMYjJR9rcM6IW2fi6NuSfLrkoHgy6pU3BTX6eeQ
 15tYenngjsbDLvd2tR1DbSKeEbVInJoYw5GCp/iweaOo53IMD4DVZcXvRze8vy95n7pWoNIZBsa
 h1TaIG6T08uewh9uvfYqGINiSHdv3NIzMeG9ZnEqQfZCsGj7Fxb5vQVPPnjjDHFBPBNMKJxDpqU
 +rosQZxuCzQ7DkB4JYn1+gVdGdBoMKgsoQ/Ses8a+uCz9GRh+ZxCwlilr2/lV3F+6DRPdmDBLY+
 09NcLmaZRmNIFFSqHW1p2vKLw1ANHliZJwAfsdkXSLhtR6GPXYKeYmgMvmMpP3Zc4KMUlHaNEkw
 zYkX5QZrTQ+35cmgitw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030010

From: Will Deacon <will@kernel.org>

[ Upstream commit 8f098037139b294050053123ab2bc0f819d08932 ]

The only caller of ioremap_prot() outside of the generic ioremap()
implementation is generic_access_phys(), which passes a 'pgprot_t' value
determined from the user mapping of the target 'pfn' being accessed by
the kernel. On arm64, the 'pgprot_t' contains all of the non-address
bits from the pte, including the permission controls, and so we end up
returning a new user mapping from ioremap_prot() which faults when
accessed from the kernel on systems with PAN:

  | Unable to handle kernel read from unreadable memory at virtual address ffff80008ea89000
  | ...
  | Call trace:
  |   __memcpy_fromio+0x80/0xf8
  |   generic_access_phys+0x20c/0x2b8
  |   __access_remote_vm+0x46c/0x5b8
  |   access_remote_vm+0x18/0x30
  |   environ_read+0x238/0x3e8
  |   vfs_read+0xe4/0x2b0
  |   ksys_read+0xcc/0x178
  |   __arm64_sys_read+0x4c/0x68

Extract only the memory type from the user 'pgprot_t' in ioremap_prot()
and assert that we're being passed a user mapping, to protect us against
any changes in future that may require additional handling. To avoid
falsely flagging users of ioremap(), provide our own ioremap() macro
which simply wraps __ioremap_prot().

Cc: Zeng Heng <zengheng4@huawei.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Fixes: 893dea9ccd08 ("arm64: Add HAVE_IOREMAP_PROT support")
Reported-by: Jinjiang Tu <tujinjiang@huawei.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
[ Modified ioremap_prot() parameter, using "unsigned long user_prot" instead of
"pgprot_t user_prot" to fix conflict with generic header ]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 arch/arm64/include/asm/io.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index e6ad41131d80..46bd37707e08 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -276,10 +276,23 @@ typedef int (*ioremap_prot_hook_t)(phys_addr_t phys_addr, size_t size,
 int arm64_ioremap_prot_hook_register(const ioremap_prot_hook_t hook);
 void __iomem *__ioremap_prot(phys_addr_t phys, size_t size, pgprot_t prot);
 
-#define ioremap_prot ioremap_prot
+static inline void __iomem *ioremap_prot(phys_addr_t phys, size_t size,
+					 unsigned long user_prot)
+{
+	pgprot_t prot;
+	pteval_t user_prot_val = pgprot_val(__pgprot(user_prot));
+
+	if (WARN_ON_ONCE(!(user_prot_val & PTE_USER)))
+		return NULL;
 
-#define _PAGE_IOREMAP PROT_DEVICE_nGnRE
+	prot = __pgprot_modify(PAGE_KERNEL, PTE_ATTRINDX_MASK,
+			       user_prot_val & PTE_ATTRINDX_MASK);
+	return __ioremap_prot(phys, size, prot);
+}
+#define ioremap_prot ioremap_prot
 
+#define ioremap(addr, size)	\
+	__ioremap_prot((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
 #define ioremap_wc(addr, size)	\
 	__ioremap_prot((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_np(addr, size)	\
-- 
2.49.1

