Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46237397694
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480248; cv=fail; b=MFiAbtNvFzVmamCarlyJhVPyyaSXMYmX6pKifcmlly6AkxG1Jf+t4M3CGTe9NPWWB839QPMYyYEbSxZbmO52/WGXo9+AIwLKHKg0QX0cS7Ng5oB/vzg47l16UII+r3OFeIyrKBQIBBRAPQMLZj7sOj1S17B6ww2p2aMQIIO4uIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480248; c=relaxed/simple;
	bh=b9dF2lhTXKf/8zSZnlly6hpU7crrEqVxy3fsGPwnOks=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hl+d8Ntc0EAZEGNH2rYugiYEO4kDX6l7Fzd7Nzp1GB5/DKVi2OeMdrfByB6bmx715/k2S2kciRhtWyqecKYjXNS3Lf3VfjpLR7TnynK0npFAVM8eubHmwt9429M/ZIH2EWxheIJf3EhIxxLjO9eAkjz+7aI8dHa0VwAkgOoGX4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=PLwBewll; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="PLwBewll"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537J1iO3578627;
	Wed, 3 Jun 2026 02:50:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=kWiDYx3HN
	CU5nZSXCBgxINrF0DRAW5IRFbqUyN3Fgcc=; b=PLwBewll7InHhQ51IB92mX7nY
	LK7U0HPG5Zbltr2AwOwRD9zI95oURWvnT1HNZGsR4CPbkPoeFMNLjYaEP1Ije9nR
	twfzQrTkLeiTBebJCl26LAa+EUuoeTilRNMkhSEXLDvjysAisarGNXp+5mdNKEq6
	R44ZH7B3/w/05L7t07kWh+eTA1L3nLPwZqS/SQwnUhg2tSbw69jmgHXAi1NZ+5Np
	D9buvpAw/ABIRrC/wOSFfsE060cC1/wGDmwKY+db38ecL1mIeabiDuY4jrf4B/cG
	srTlbgUD/C8ook1piZUvvJKA3WL/iQ682d2lftS9hUeKsnvJ1V9HQSOflv4ag==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efu61xatd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 02:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fm3YxL4NVGXwYK50ENJDwDvkbxiaVcOhoUMcinBTI4nwA1dXF3g3E+O76zzwObfVq56bv/Xec2lZS5asrPcx/GXDaSeDnc0jWxzS9rCcbg5KrU51eNVyR+Y7AHxq4ewks5QR3MPN6a5v4mQNcW67jefgJzm7Qz3oOioN7FYve5qtkmabWEvLzwgLd00wx0eIc78wO93eOhgsVxnNyXPkeCyrjJGsXCKUBA99213xerRVYwVtr3+Ml+Yv5PdF2NZ3VnCB9VxdNYnSnuIJsMry6Jpn2TDXVQBGyYhJRyUsNLqCPJuALuR3Ivca0BslUC+G1gvU/DEYc1MSY74Qumq7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWiDYx3HNCU5nZSXCBgxINrF0DRAW5IRFbqUyN3Fgcc=;
 b=NjKhqXJgmHtuSTSy6PzKLbcAgvVuErNpQiU8IhZZYBCTSP1srXHeVdL6NiNKxE7t783qY9jxT9CTFb0Ag1pyS5VAw94E/giRIfp04pgHrY06rpq108m/nWNVyN/q4/pNwjRyBBWqHX57hCL8cqr6qfwhGf0cGKPqXDsOdGx9NaTv0DWvG3eFEZiFEJjF3T/D67aaEEyXqHIHJ4Cfwk4uKkIxNimlC8TjbyE7KCy0OEY663z8B5QiWEejCC19mumWAUMy0IUCufFyVvX663Ibg52v6XBvXsyV1otLmDrpfw8yRKOivim3yqF1mMESowy8J3INAxt4DMTJcvrI65bXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26) by CO1PR11MB4771.namprd11.prod.outlook.com
 (2603:10b6:303:9f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 09:50:37 +0000
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6]) by DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 09:50:37 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: catalin.marinas@arm.com, will@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] arm64: io: Rename ioremap_prot() to __ioremap_prot()
Date: Wed,  3 Jun 2026 17:50:24 +0800
Message-Id: <20260603095025.4121308-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::16) To DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF641CF4859:EE_|CO1PR11MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: da7a21e5-566b-4f38-3c74-08dec155902a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|6133799003|3023799007|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	OJ8C7IRAX9wL3oRSSCscH8iECSi/ymC5cqPoE9FKxQTBMA24kqqS8R4SDucA3x46rP13TuFd/mGmiaG3cjgPfho7gQ2vH5JS178pOi8y1nmOLYuAGoIr4EZJYOvpvU3HjJjACMyuPQJ/gvYFPL0JvTpmm0eSVTDdlILdarNOOou48v3YuOPQs7rz+u6l9eKzxmqiExDJC8C840q3KGhe6wtoJ1iYNHGvO+NMXU9gysrM9AeWbMJBG0AsZa6Zj1iX+YFVCOcOeGMO1RB30k/sxdkrnw3kLmAxP4SonLVlzbalmgZt0TyrSVPIAFItYZEcGWRZAcxYFe8St7lBGrrXh/YcB7hzzA4Nz6ELxF3RAGf2qTCmrr964Dm8mwF2Cv/+snOJXW3vqFEP2hLollCBMz8d36zmBTrr59OC/AgTuiyysnvd9krEWSgRaWttvQu9qYM//jrch6mrvbBXWT2y7Pnyqu4HB0kXNhNk3/qZYw/s87jKaSUPpIKoIklFTb5hrsjJg+ec5JAEfyynUoJ61EOyxqqqGdTeZFNVuvZhn9nhxBkM5FW6JBYFMn79IK8e/CDa5RskEVerfglEVri7F9QXc3GL6QxE1h2r7gv7YpKKCpm+JE9/FGMXQ7rGBgVnHcGVmhquNVqAVt5HM1YiYv2L+BVEBq/T1h6J/rpyFv+QE2PISknAekXmLM+661a+KWj4rrqLsEtXBQ/GyWBxlCiAZh/tx8w8HyiwG/vSR/5VVIT28NUPzLvZ/waDPbeA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF641CF4859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(6133799003)(3023799007)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2nWHrF7A4VbyK25Mp2c1Cu5cJBMoQcdcySUJ0hyjYxDpZ4KS6Igk2TOJTZC?=
 =?us-ascii?Q?EZeAVyo5oHRahLAky2voQvfFsMT5lIGcP5qIhUGcGxVY4Eei06Pjny/yd0yX?=
 =?us-ascii?Q?SQ88VhsD9bDLacpNUyMumZLr+PRTkGs4aVYPGDk+dweW48jiuisAAI/Tk4rM?=
 =?us-ascii?Q?pYocJrD2s1aQA+UqOE/wkIWnWEmidHfH4QYUejEiW3tY2G/S3gU8Le8H98Pj?=
 =?us-ascii?Q?tEruaGP/uMPqLPL7Bn4mfNsQ2O3QcTUlSUDPZjHVs0XpcQ5gedJtmBkGcUKV?=
 =?us-ascii?Q?KwzXRjKvgPmL4X6vjNQD8CK7oyEAkmZ3y15NtVNuutxqU0iBQ5KFrPcaZOT6?=
 =?us-ascii?Q?J/g5QHhtFV+bTIMOja5k4gxVqqvu4zNrh8tQhhUFzJCRey0deJCGNBx2+WoW?=
 =?us-ascii?Q?LPmlCzZBryf5mwklBy7CiIWk4C7uWrfGu5QqJCxlJpUzhHSyFp3ZM/KQhI54?=
 =?us-ascii?Q?rzNu6HAwWhlhja7xlFSh7jWsZ+HAb+KoilQ3TjQvyjDATZiaJrOQDfVrtpKh?=
 =?us-ascii?Q?k41vtrUMbkwNWYfwPEjuTmbJR+osFpCAgwHF7jmnmYlgQjW8D/dLxyX57PGJ?=
 =?us-ascii?Q?Zs8dkdEkzSZZr9lgyQPG9s/gIf4eLJQn5+FqS1K8kJagT216h4gRagsq1lzX?=
 =?us-ascii?Q?ezPjsGwEtoOfRB92uqzNSQWZatYUOOIizsmqY1n3jd+llsOTmzci2Fa941b3?=
 =?us-ascii?Q?0koDiChnj4yaR7wHK9h8SwNOKoYz8iXhs+Mn+kobBuBYTnYXzIMfFVoeLErS?=
 =?us-ascii?Q?0B85qxLVQ4L3T5U+NpWqTjihbkWBcU4Zr1e0Adpj1G1FsA9xv9gmjrODibXb?=
 =?us-ascii?Q?W5+SQyRnaNL5kEJRZ4TOUN4FkH33LLSDg1PjXVEgDEaUUsmZ5x9kyPa5LL/p?=
 =?us-ascii?Q?LihGvNfOL35PQnNc0nB8S/l0cZOmx+kZwE4IwFsFjLi59HP7fsgRRe2LASo8?=
 =?us-ascii?Q?6uFwszTPta+ey86JDLPJ0IRVb+nl0H/V+9UxhyJ5C1vO1Ffwl9S37kFsj/Jm?=
 =?us-ascii?Q?Fo7jNDoGKRyx3T5ndOTZBbxfT+nAHun/s7Bgz/oUzApdlM8GkY8KKU+QPSo5?=
 =?us-ascii?Q?4LmR71k+3LVLM1Kke9nrBQIXRMQPTMVSyyGuIvUfEtNHQQVNIWf19oAG4iqg?=
 =?us-ascii?Q?BX/jx13y49rZLNviO5iiMeNbkkx98Wr0N0tYDDNzMg35d0g2OJ4pKQH2SgVY?=
 =?us-ascii?Q?CQ7dR7MNziVST01CcCLiXsawm4vyx0jGqzExE+dNhQ24csipCBhy2DdYSexy?=
 =?us-ascii?Q?24AQ2MORavsAIu5ngS5MbWleDjAtIgHUh+4j6xwSd67A/XBj3yj5hsfx7Z0t?=
 =?us-ascii?Q?/jjhS9qqaRcaHGVHvmsat3Ew7CqBaVAySfvHPeRDwyfWobyZE8GUstzoNi4c?=
 =?us-ascii?Q?R5N6QETQqy0z55Z29tRuw6qGijjaij12Bx3C4D9VfsMzixSL7ErS0DMZqlgy?=
 =?us-ascii?Q?20m1iAQaUWxbq/bmpQYN8Y5ARylx6I/Bj5BcjgjwtwwjSc2lFjAPxDjA0eoE?=
 =?us-ascii?Q?wSRPVqVitSJzf5+L6xbvM43BnrXY3oXhu+WVwRsoU+fKnSah5Q4vfhcOBEKS?=
 =?us-ascii?Q?rkImtux2tcdwfuUlNucYkuJk8LAhyNPgRtq8xEhSWlv7Ui4HHKtMtrPHrKEH?=
 =?us-ascii?Q?GwhsMDFAaMf/3fyyyzP8XeMIWIxlB+CLh1v5kzTdj/oruFKzsnS3WaEgbQfO?=
 =?us-ascii?Q?hMohWNkeiIJ/GiAQ9ViWDS8xtUqCdop91cKQJpQSS+W0MNK7wsRICUdEGFCZ?=
 =?us-ascii?Q?iNAWJOmcN8Jghu/GWx2RcWi+da+zf4k=3D?=
X-Exchange-RoutingPolicyChecked:
	RHtYe+snvSrIA5u5DEC045D2pijEzJf4S0lFzcxOtDglN+dDyaTwodXrQIgOHR06Cn/LtGvZ5G/WwnI3tO0VOjGJB622reOYyLe3kfIYagJX+1l2uPL7jbt7TtCHdnXKUhcmScR6bRDvMbqWFX5HecCsOv3GvV1hmj5pMlcOAVn7qmXY23CS3J9Ds2G9zVURZOmjoFSmjWv9OsMW1ThDLBDAv3+AOsWe80tLDUr5caXeKfG2EwgGWFTBC8HKIqkseWzgILw/j+iQbYA2DeWdfslKXVDv2WUhRRJ/GOw4EVlTSmRKozXpmDrcvG1GESvwmoH8J8+xWqwFS94nzwm3Ig==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7a21e5-566b-4f38-3c74-08dec155902a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF641CF4859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 09:50:37.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdx3ZARVbw4YJ7PHG7HQg4dhf761BKx5UoVRxg7mZlTEysUGKgay4EugYHoVZeHrQvAjYWlQWR7k0EssMvrCDKEbtnCTqCL3oo6oQLLIU9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-Proofpoint-ORIG-GUID: CZiiZTcT_JdZtqomgLWQ6TL0qijLNuSK
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a1ff8f0 cx=c_pps
 a=pvbKGUK/Si0pumwNLfsG/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=7CQSdrXTAAAA:8 a=t7CeM3EgAAAA:8 a=HVUBJmvu3vXGWR6jOl0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: CZiiZTcT_JdZtqomgLWQ6TL0qijLNuSK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5MyBTYWx0ZWRfXyNVoYCHw3ZYa
 SpHpDe5FhAti8jAkf2P4ZjXMwVIWP7il2u6RtInQFPCxFDtL3IGoaMmhxtxqya6NEHX+5AURaEw
 uZOEOP4/jzj1+z22bMHM81CmRbRlBMWCW0vwWcDFumFdz/tdk2gDpHOd3vYdgwmYkNS+c/HBKUz
 DdltIhYNskP+HUJYSpt40qZrnAFzLx9XQOr5NIIU+bchmejOfVOdQjOS5/ODlw4+7kbhff8nTst
 DpE/wSTHmaPOU4JuPZ5yEjC8YkXCiMwc826n5rdzMf2OqRUtulM2UQXg2FnM5R8mFlSKkkzNOXl
 agQ2q2FOWnP7WTZyBxpj34REPm80WUreVaYbrLpTjRrtOUwpvm01Viu/3QKP9mwGS1zMe1hkyiD
 atmS3ge+TuX4zJiHwp6HZux3PJGWWeM5+A5E08ziXinIIACLwv7CbChEKj55MrOZxU715JfV+m8
 nYpYnN7plWjSpZg6SDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030093

From: Will Deacon <will@kernel.org>

commit f6bf47ab32e0863df50f5501d207dcdddb7fc507 upstream.

Rename our ioremap_prot() implementation to __ioremap_prot() and convert
all arch-internal callers over to the new function.

ioremap_prot() remains as a #define to __ioremap_prot() for
generic_access_phys() and will be subsequently extended to handle user
permissions in 'prot'.

Cc: Zeng Heng <zengheng4@huawei.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 arch/arm64/include/asm/io.h | 8 +++++---
 arch/arm64/kernel/acpi.c    | 2 +-
 arch/arm64/mm/ioremap.c     | 8 ++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 3b694511b98f..46d9f3f82908 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -139,14 +139,16 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
  * I/O memory mapping functions.
  */
 
+void __iomem *__ioremap_prot(phys_addr_t phys, size_t size, pgprot_t prot);
+
 #define ioremap_prot ioremap_prot
 
 #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
 
 #define ioremap_wc(addr, size)	\
-	ioremap_prot((addr), (size), PROT_NORMAL_NC)
+	__ioremap_prot((addr), (size), __pgprot(PROT_NORMAL_NC))
 #define ioremap_np(addr, size)	\
-	ioremap_prot((addr), (size), PROT_DEVICE_nGnRnE)
+	__ioremap_prot((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
 
 /*
  * io{read,write}{16,32,64}be() macros
@@ -167,7 +169,7 @@ static inline void __iomem *ioremap_cache(phys_addr_t addr, size_t size)
 	if (pfn_is_map_memory(__phys_to_pfn(addr)))
 		return (void __iomem *)__phys_to_virt(addr);
 
-	return ioremap_prot(addr, size, PROT_NORMAL);
+	return __ioremap_prot(addr, size, __pgprot(PROT_NORMAL));
 }
 
 /*
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index dba8fcec7f33..0b06e6c2ebc4 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -352,7 +352,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 				prot = __acpi_get_writethrough_mem_attribute();
 		}
 	}
-	return ioremap_prot(phys, size, pgprot_val(prot));
+	return __ioremap_prot(phys, size, prot);
 }
 
 /*
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 269f2f63ab7d..49fd31e33c31 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -3,8 +3,8 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 
-void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+void __iomem *__ioremap_prot(phys_addr_t phys_addr, size_t size,
+			     pgprot_t pgprot)
 {
 	unsigned long last_addr = phys_addr + size - 1;
 
@@ -16,9 +16,9 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
 		return NULL;
 
-	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
+	return generic_ioremap_prot(phys_addr, size, pgprot);
 }
-EXPORT_SYMBOL(ioremap_prot);
+EXPORT_SYMBOL(__ioremap_prot);
 
 /*
  * Must be called after early_fixmap_init
-- 
2.34.1

