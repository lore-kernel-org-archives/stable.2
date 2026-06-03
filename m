Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FB3382F9
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449837; cv=fail; b=Y7mh+PstT3j785+cnWb+BEdFDNBTY350GCE0HCr3A/hYKuq12hYSFhjNsgWaguUTX7tG7Hwkt1OdV++xZ3O/sFFe15nbqGIB7V0yRJcIX5VuUEU4nrpiDllLDLy9Ff3FmVVCZwWZ6xYVz0qb0wxkYuz0ZJ1jQmwp+pV9bc+STVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449837; c=relaxed/simple;
	bh=QNgZBtaYs8tuVeTLptFb0eqyHqo3NT6uqnadwfz6wYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FvvUhaN4C/a2w/9mBjv/dL5pFKwlDTA7/64So0yy31VMJN+PfLglqNSREzIIUiMUPZ1WbrJIwCZLpBNecP3LXeEuJxfN6vjpSVyrCWJorS1LopjnkA4I8ImCdCzDy36umCB6d4HxUMDp+AF+rnlOiI+p79pz8BjXKo2kYUwG5j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=bodhD8O1; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="bodhD8O1"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6530U2552744581;
	Wed, 3 Jun 2026 01:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=uGW2u3gu3DXjoQjG+VXDqoF0R2BD/FnSqhg7mK397Sw=; b=
	bodhD8O1gQPyQzp8l62twhYSMknbV6uLFrvvQiUuQsHv38pwuupd89m5++lF6sd5
	zYhyONtMiDzNol3BN5SF26iHuqkdusqWNePdhMVcDZGq5Q46sUa7UPI9QFMUx0jN
	wMBCEZ+TahY2SMEgysHqKLnuP1QIkXe2Uqw+l7e884qae/xfcCXZgJKjphlTQ2yg
	HT3+LkNF6lcmoBMWvFRkUetSNtj/2bN8xafLTo/UOJV4eQoSkcMI+DF1Yf3cp7qv
	ajWCgttlwhH2VrY3ZTv+IOnkEct/VuCZ4mgO6K3qf57fuiM89POWkeLjb8PByLjq
	S5kyE/WESVfycfZr6P/zKg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efpv8dvf1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 01:23:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuJ/pPGNOotxa7Te1KncB3fC2NP+lY0JUKFEKrwfA9S3BufLLlhrNR7Ui+0SaqdvEZhg6MKI5sm/QLbA3OWrw+Ywe7oasCmZHqOkUOVj9nbHvjqmDwrNbEZxvPUcG4E4M4hejc+dsTjKFaPQ9SgyWIb1J3cMMmlNWunLXXL8zlMX7oeyKHtrgqoKjpWQ/Ng2GaileWGNfgwWddO7V1C+AupFt7UtgycFYJtjKnD9hJ0Ot/uNuoe41CvzL0cTK7twqOJOkPWuQ6BiDJBwhfY7U1gGCt19dvoPpfMcx9EzZ+5fPbrLv3sO8xGAAL6gFah2Ly8Bz4OUL+9u/zGuW24xIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGW2u3gu3DXjoQjG+VXDqoF0R2BD/FnSqhg7mK397Sw=;
 b=CH+SZdjxzvc+Gd8l4dQwJqaIIl+SZ1V4BH4E4ML80Eg2Et0MaeYT5giQEGWA9sB2BSSd320L7R8g/QhonqW/peQcm5UFTvdGzGfP9uIJu/I4lrwu6IRVPTagjuMtLtBT/QKfBJUYTukKBEqxZzLySRHV7DmkNw47j2o8TL4sU3UNg7gRTDq9JGFZ/XCZ5sVw1rocEzmPyqAzxanms4SmYJEhhMDPYM286xOJVq3A+0Q8bpJ7PJvaRdyNHK+iBGYLZcZK7mpDWx3mrDqRfc5xHnvVZbQG+5Db/MDVYawTpaDpAAwNKhYepLRY8IHGuiDtg1Sf3rFHZhIfuMdjWsavsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26) by DM3PPFC89313B1C.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f4b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 01:23:31 +0000
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6]) by DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 01:23:31 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: catalin.marinas@arm.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, will@kernel.org
Subject: [PATCH v2 6.12.y 1/2] arm64: io: Rename ioremap_prot() to __ioremap_prot()
Date: Wed,  3 Jun 2026 09:23:13 +0800
Message-ID: <20260603012314.4100773-2-xiangyu.chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: e09d3b13-db14-4ccb-4af7-08dec10eb8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	IeNMLnULCguys0t8o6R3ZaVvHPBTX1YhOrIay49ob+ndYWZPg6BJxuv7IQuIpPXmDEPKMDBbzmEdWCG0ABJW8KH+mk285AvHzwDfGMB616LBw49/wBJ20vbfznU39HUAtYMYV6tXmFa9lEKARJZWd2A9V9g/Glz2ebQmOL4jfhT3GUZeGfTebEyZLza+JLO7Fr+n0hY9ajwNIApaLPXxNvJrtw8oFHyfZtzJSZmDhUArecX6D5/vS7bfkpSfuH8CkoxyY7b6B+mkKJLF/hpxH2OPrOGZ3VRi5wqdHBsihix8F4Y1iO9PDcwRIh4G8d0v4MH73num0bTDBHUfhz6IXgN7WQ1CHDWDGAEh8DlsLD2/9kJzRnn4AYijAecnBE30HvoGkyZI0o7U62FkDjjL65TbKZtVsnfDtQcVJAo1XC1whafiWLiyzfO0A8CxqHRzYH/0N04ekA/ANjai8WeEEcm88uSse0noZyQXqcXZ/LbZYzQit0bJVNOl5Tg0pFr2VzWan4qAc9Ba5BQGPNyCOash8QdSH81DHHAGA1hkT/9djUDJ/V8/tvTA1QR9lBauIAEc4HvQXlXxfMqILlJV+QIfJFeBr+d6/s7JgDfaEpVrCsYazcG3LymMdKMg2H8gHv+HNkkFMYO4HZxxvXzaMuZKLRwsZBfrJ9pn51Gb92Eemt/gLO0G3dHDwHxmGYDVDBLo8RBvOaeoC82D4UhCAIZTT5wwOu4X0avnJqB5pumwzIAJIIhw0AWRHhDM01Pw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF641CF4859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Dxax1snJ1yf5jvUTg20PzNN5tJfDqmhmJXTOeTFN9ZT02adQv2cwXKnbTOe?=
 =?us-ascii?Q?MgwhUUFz1/BCq5chwZ7GzSNHviGQTLFhrOwOo9ztOO8/afB6FDWQyGALrjMX?=
 =?us-ascii?Q?2MhbhHrWAo0MY3NZT+HrbCUSy77r/k0nwsssMZ7PhhARlQ27hzAc+yc/gdXU?=
 =?us-ascii?Q?bfgynZsPU9oCkRYSNtZglAe5TmNlYDKb7U/Je+Bam28CKH2D0zXg7owqRE/s?=
 =?us-ascii?Q?PFMXvgREmHBYHbJGDekEzi8mbF5uOLPzp1/Xg3iXzFFQgiilO8xkOVsQJvtl?=
 =?us-ascii?Q?m1gccfgHhoZRS5PGnvjg4t3Rfi/9UWUsLz9/CSDBsW7k1u+Mdsj032VDb0iw?=
 =?us-ascii?Q?dcQZZ23ZpVrPmRdV8c2gW0dQNM/gBS5IJuRB7FmnytK/oCcrH0gdNZJ/MPjX?=
 =?us-ascii?Q?FyjsN0w6ajnDOsyrbrS6jwL+i6iHq2zvcykE7FPaHzRCVcc/dtECFzSm7qXb?=
 =?us-ascii?Q?xebBiQLisGpaC9JFDTAvShPNwD21qKqf8vopwaS0ylD26yuetz3mJ1f5g30z?=
 =?us-ascii?Q?SJw8t2CDQun7nqFFRKJppM1Gqu4ZNQZjnvslGFkxol2xXyW6Yy5oNXiRNtR0?=
 =?us-ascii?Q?YSvacuGo1zfPOrVtoOZ+Aq4PQlgCZpPsWodOeHIasPpx9RhYOYw5Zruxhpd4?=
 =?us-ascii?Q?Ms8tdLVJhl62UavBzfdAvXqOkwfGAnCd2wQQo9ymU6dy/MgC+Ifwry2GiNBh?=
 =?us-ascii?Q?mxZIII7sjh7vJNTs28RVYOmPsr5utDg7VG7Q3F38VcNodliJxWHuVyGKqKnE?=
 =?us-ascii?Q?yfi1JXYM8WbiSP4ubx3TPYkmLWLM/9HJLxRr5sdqV6FJCn9K83fa+/E2ZeTw?=
 =?us-ascii?Q?KXYlpMA3sG1mAgdQ7rnCFpjmnyYhtvVs8EBKDrY7fI1JMpTca4Uiq2+EVBxb?=
 =?us-ascii?Q?DcXVUhNh2n9pbnTJ4ZEIjyNddDwaU3MUIyToWkrADej4pwNlIwJLeGu/rIwC?=
 =?us-ascii?Q?Lbie37WyJEoYoAtOvVsipiphl46bzc37+qj1X7t+mdh2IND7qj38MHmehfa0?=
 =?us-ascii?Q?pJiYkjobeIEPAYSs0qoet/N+be7Jvr1RrO+NJlPpMckwAOFzrk1fPxRHVFGs?=
 =?us-ascii?Q?mX5YFXCYWOylR0G8BgEmrPF9paXi8BZp8ncqQXZj5XONfMdAwCAHEIo1SuhV?=
 =?us-ascii?Q?UcPoBSJ1KZIIjf8mnoHV77wlcGtJTMjsqEIC2Vy7YFcWLDv2uL03FcvQzolN?=
 =?us-ascii?Q?h7aMW7k2Jg7eD1c7cVZRrVOfmbYnigL1VdlW23SVQwKk3vbuVZUd0VXaLwrJ?=
 =?us-ascii?Q?p/CUPkm2Odfeoxt08W0rYfq8Reb8g3HrVk9tFOhsxfHKY6F4+/ViOrFYylHc?=
 =?us-ascii?Q?jjccb41qccQz7QrHAepTN5mU8eZ19Ii2dA38CP9ZmiiII7vHxC6SPD/T3m2C?=
 =?us-ascii?Q?k8pSWKcQj32OG8tBjRkFtEFlHCl7Fdpn5G4zYlKVvl2BrighURdv+JmyQSbw?=
 =?us-ascii?Q?0FS+JTNT8wKg6/WddLY3zah9gzygzAyJlVOKoFjH0eMR1spWhLhLHLNOOcX3?=
 =?us-ascii?Q?fJNxvRxJmRwws5cDZZt7lYhsi/fphVb7GlPkRUiZG5UB9abSmTjQMFuG4SvW?=
 =?us-ascii?Q?NxQKjDQhlFB31VU3svowbyxlI2NKVvJri0sFtmtCHDgce4xaAw0eavrUfk6k?=
 =?us-ascii?Q?WZGrwGy35uHDkG9AGnr6eThNOK87ed04UGqNZuEfhseelot4O0no6gYpn9CF?=
 =?us-ascii?Q?/I9JvdOXHcMJ9cY1s+SCHgsaGEQmghiLjD79NIuQJcEt3ByeEfz65WFFf85X?=
 =?us-ascii?Q?OcXrefMPr/JduBnNSEFpeBsjW9/HbW4=3D?=
X-Exchange-RoutingPolicyChecked:
	eTZGOLpzszxwlEGZbCBg7vFryszItZH9GXXQ1l/0IR3fLVOBgToNZHYZYQhx04xfPFl5AhdWpW8nOqZ7ekeCmmjz85pDtLnfwB+2beIQCLJ9M6wJy4Z1WWjDP/KDaB5o6RxyOzVq+9NUEVPkXB9Rmi/SXUd3LE9KOftxpQqMesfHqcX45NubJcwxVivTXa7vhElNGbjBW/q/od5+17AfyZBAIYNbFiBCwNhzv3t9fjW6g2O3g3RASMLUr34dHg35B6lbwHkTy2yfMdWRxMZtrNkkES38IDEs6ka/ZqCLsdOyKTcS1i2kVCjxJyDhs0zgSNdVwIDJ7hM7lyH44rhGaQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09d3b13-db14-4ccb-4af7-08dec10eb8ff
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF641CF4859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 01:23:31.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qp9Ux4wGQE2K3JGdDVv+9D4orQX2UDZshyrdbQDxc9fV0J0KduMvz8/S9iEHevJ+YRDrUx+K2xeYG4OnnEuaRknBPvH1ZL6lW/Bov/Duw7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC89313B1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAxMCBTYWx0ZWRfX3inPqJZgYYh+
 beahYz94BVBLjAu/x2c6fGAlgw/473UMIRzQjIn0twB7NXkF7HFKwb6wGTGXyT2mYlh98lhjMw9
 Pg5ngnVWiPCuW7x4yx5dFyDMF6cOSLrJVEwEDirbCMeKX88WEgLGZbssGQEzVl3tE0mgdm3iuxv
 93Gnaran2QreFS+XLrHoWhf0rgquiuTZtlwGiqx0Zx3BNaz2SbD67f0+wnlGR1gnxiYvuyiJ3c9
 OW4GyTTBQNGyN7TXtTUllnkgWNAncUwXIlGrOefOawX2wpQrfgvfCdRdwkrlALUQM5A5O2sZH1Y
 RM+e7bDAhWW+F/XLVxTvWmhKjPEeurS1LrQ8zF7MszjKNIvhjsosBjJ9HOjFOjaaNulDlrxdQpR
 r8beNBZzAJxfT9e142+lrF8QPinlCqaxgrc27FR7wj+v9SO710btZy1m+fmNMM7/mcT/eZHSS4+
 CxoARZJutxJlYhOytRQ==
X-Authority-Analysis: v=2.4 cv=Opt/DS/t c=1 sm=1 tr=0 ts=6a1f8214 cx=c_pps
 a=z/rjtr9/JqYX5j7IdmSYkQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=i0EeH86SAAAA:8 a=7CQSdrXTAAAA:8 a=t7CeM3EgAAAA:8 a=HVUBJmvu3vXGWR6jOl0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: k-xP4aTrjeEGxPkw-hHSpmYZY80YVMzu
X-Proofpoint-ORIG-GUID: k-xP4aTrjeEGxPkw-hHSpmYZY80YVMzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030010

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
 arch/arm64/include/asm/io.h | 7 ++++---
 arch/arm64/kernel/acpi.c    | 2 +-
 arch/arm64/mm/ioremap.c     | 7 +++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 1ada23a6ec19..e6ad41131d80 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -274,15 +274,16 @@ __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 typedef int (*ioremap_prot_hook_t)(phys_addr_t phys_addr, size_t size,
 				   pgprot_t *prot);
 int arm64_ioremap_prot_hook_register(const ioremap_prot_hook_t hook);
+void __iomem *__ioremap_prot(phys_addr_t phys, size_t size, pgprot_t prot);
 
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
@@ -303,7 +304,7 @@ static inline void __iomem *ioremap_cache(phys_addr_t addr, size_t size)
 	if (pfn_is_map_memory(__phys_to_pfn(addr)))
 		return (void __iomem *)__phys_to_virt(addr);
 
-	return ioremap_prot(addr, size, PROT_NORMAL);
+	return __ioremap_prot(addr, size, __pgprot(PROT_NORMAL));
 }
 
 /*
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e6f66491fbe9..a99476819e6b 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -379,7 +379,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 				prot = __acpi_get_writethrough_mem_attribute();
 		}
 	}
-	return ioremap_prot(phys, size, pgprot_val(prot));
+	return __ioremap_prot(phys, size, prot);
 }
 
 /*
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 6cc0b7e7eb03..1e4794a2af7d 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -14,11 +14,10 @@ int arm64_ioremap_prot_hook_register(ioremap_prot_hook_t hook)
 	return 0;
 }
 
-void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
-			   unsigned long prot)
+void __iomem *__ioremap_prot(phys_addr_t phys_addr, size_t size,
+			     pgprot_t pgprot)
 {
 	unsigned long last_addr = phys_addr + size - 1;
-	pgprot_t pgprot = __pgprot(prot);
 
 	/* Don't allow outside PHYS_MASK */
 	if (last_addr & ~PHYS_MASK)
@@ -39,7 +38,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 
 	return generic_ioremap_prot(phys_addr, size, pgprot);
 }
-EXPORT_SYMBOL(ioremap_prot);
+EXPORT_SYMBOL(__ioremap_prot);
 
 /*
  * Must be called after early_fixmap_init
-- 
2.49.1

