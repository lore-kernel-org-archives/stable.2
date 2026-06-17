Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6848B365
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710111; cv=fail; b=PO4ARCgoIEavPNGgR2ja6Vx6HHGIL92SKb4AndvKtyxefOX0hzkPvpgddrxvNxgRqkQch8k6VWVRwjg35kcTuYbu6VqNyl3JkDPJB7JCmdsPw6MODRhf6+9pS+D28N3OLYu9OfI6WX3SiWvkLDLxJTNurBB6QPX+ed3NnxE0aqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710111; c=relaxed/simple;
	bh=lwVwfirAAXDitvV3HqQKpyrNq2/bz9+wjrecyrF0t5A=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=F9E2cMaZQQjr4nGAAdSm+lGc7rvX1/Qu9HhUHnd29il66U7/vUpDQb6DkUShXxA/GC7xp+dL91X8yKNUWDS731QPGm23XaFfZ6yqVcSxgxE0jLetjvhTDJF2GisRemnQG0/TVP4oZOmWcSh4h9AcsPQPQdo8keJr9BTWUn3bRjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a2tEvJWw; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2tEvJWw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSld6D1zzG2KpaNr5qmfKp59B8wGQig6Ty32f7ab1VNp95uhKR4pY7o8AOo8gOQvHp75uuySGXDcuYwgjkidD6un5bk0jqObe3UTEzYviJg8fG6qSPmQnEohsYRWObYd7uBaMMToMatsDzZ9qamTZpbdCupsRgISH4IAzn6R7/yrVezelJe7WwOhRd10ExNdWFNSlX7xTPUDxZ4HdueMnbT4JVLX98++FKGGQixl2piUf8Hn2stcYsuAGXGJV3wD/ZnzhSwzNH/h9jD3ivJCkph+QQkcSLuj5f3gnMUWzNYxJkMypHjOfE7WD7EDqpxXqAAUNjBvYa7NxfjAFbAn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taC0a4uTTpEDVdz3vAynTgNpmPV85YbBKlgZXSqMfrk=;
 b=gt9/8ipnD+U1T07ZRI/rhLaWYSnYoAdKCgO3iQPkLwgNCZzyjiAunqbWE803BFWu04aeIbHJXoM89aEOmVLTaIeYOBOAk5yPzcl+2MXR8ImftZmfU+UmKK57+pZYCxWS5N53Upm57At3HHW/+fMg+Z5YyOl2lQ9iEnwlNeLvsQEG+D6DpRnez6B1ymtOP9e9S+5em30yzw8CCTwae7mN7TxpJUrP24TXEYFeyuit55GpMXrx732yN7hQ2PHZAjWG+RlZhTEkASFhJwaC6fxjlKsQjZTZX2+MI57hYVQxB0xP24r8YblCfJMD/WkICILirq6AhQjEODyVS309e78ODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taC0a4uTTpEDVdz3vAynTgNpmPV85YbBKlgZXSqMfrk=;
 b=a2tEvJWwc3Mf+F5GQAeVtGZTDEOlH/ctZFgyQ8gb36Z8i535GyL/48dLDYymLsoTxKIsIJu7+qzAooifdrk5sRyDWzBfIH8YncF1lGha6NrtX5gwk2QBNfIU+c2Rzrw5IX9Z19KbqzFaxmU3yH4coM8rMoDZH0k6bTsHNZQz1I6xEioaaWadAX7XyjjieAbBc6LCafXo34qBGMNEJzzngpCtS7Fd+opY/wedKvvq2ds46jYS4bDdvhaAOtFoMhlJPiaQhQ2WoPhh95EvGLPCBNke04IO6bE94QjtTvjsldd0MJC3pq/9r33EK/JRSo9yDXJHfNtuDaHUowRqep+vlQ==
Received: from CH0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:610:77::33)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 15:28:19 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::aa) by CH0PR04CA0058.outlook.office365.com
 (2603:10b6:610:77::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 15:28:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 15:28:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 08:27:56 -0700
Received: from fedora (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 08:27:51 -0700
References: <2e4d2f2b9efa7b0b32476947f63506cfe9568d1d.1778851656.git.petrm@nvidia.com>
 <2026061639-antennae-upstage-bd52@gregkh>
 <2026061610-lying-manor-2d57@gregkh>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Petr Machata <petrm@nvidia.com>, Sasha Levin <sashal@kernel.org>,
	<stable@vger.kernel.org>, Wojtek Wasko <wwasko@nvidia.com>, Mahesh Bandewar
	<maheshb@google.com>, Shuah Khan <shuah@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Yong Wang <yongwang@nvidia.com>
Subject: Re: [PATCH 6.1.y] Revert "selftest/ptp: update ptp selftest to
 exercise the gettimex options"
Date: Wed, 17 Jun 2026 17:22:44 +0200
In-Reply-To: <2026061610-lying-manor-2d57@gregkh>
Message-ID: <871pe5i3v1.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 04287c12-fdfc-4b5d-5d86-08decc850f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+7/VuOu6XxEqVHc2ed43jihcrrz1oiDf9CgY+0AWdeUhOyP1LXpdW5d/g/+SkQye1UnOIOntxYbwV/ciYh8M2MtOp9IA9c2++tzjnmC4JOdjHX2OhkCj7zehwJzrHhHiCyTCsaXxx1rmEQVK7DMHDuU03gykEiK/QNSG4jlMeFQh8QDYgYmh9yTZrDVfsQMtGUwsZFvKBQH11Cy9xH/yNsGWMvkI9dEEfR0wuck8pXQTbftEzXTmDlCRrPNTgwYR7eO6WCLbgGlUcm3kpQu7QKwXneNj3wXvVN4+/JTEeKQKbEyyCMHkvx3QLXn7Wrbn2he7MieyL04yMIWGCIdM14gAF/gqfaG1R7PzBwEsr61Ow9d2o2E4KCNPNJP2GBv6BHq/YiSZgAlHhrklDsQfOGFrWWLNZmoCQ2VE0nlRrQBgu5himWTy3LTQds0qoKY5/9K05JYeRSlR0ZnPpDuKFymVdsFzTgBIwyhUAxKQw4WWcZ+8IFmF8LVwyM4KgalM8uXvPDMTbJ0900NGPxDSpc6z2tD8tJs16LRD2SxDEV4sapDRcvrogJzuXfjgOTtkf9YaabCDyH7a9prFvMlb0QdhSmZjNFhOa/VB1S4kf7nffjVuaV9GTT7zN/HBdrU0X4vP3/8RpXwRBPrQcvsHjUAwzG4DHdb8euNHbkwBAV3sqVEGvh0OnSc8D7D2ULhym67p4Hp+A1gsl3tEEMSn3a0bBO5GbmyV1BkZZj189u4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pQJIpvGu/b4u7GS40VCFUjwhq4yUTIoXLQ5zl+Dw9bgBeJeE8wffjZRZKGRHgj+sazQeya5t5VB2m52eX2W9l97zriipLMpyJ4CgaUytfmVdJOp+baEdf/5ATxKtEU/g5phpXc5nNfMxgj07Qq3Wg31n+nK1eZnDsKDoopX8zyBIKR+DwFfRsCma+5soUTmFbjtcNNx6vhWjIkxZzkctXxQ0Y5mubatwBKWFSKAtewMGUd5uq3pE3QgAkFR+v4nIjkTClqfu9mtgKGgAcDnWSZFsYfOuijkVwKgK6tkVUU4+plSMrypSTYEgmJEPI/Q2hs5JHPpYJg7yQD2LD4TEAabF2lw0DdWk/tI8BFrmuXWos1MCHd0IbY7QTo5b4w27eCSf1vr9jWoZCwqGxb+LYfvrMBBjBTlS4FIlOdakQoCXbNNQq+v/qC3qwguWn/zU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 15:28:18.9450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04287c12-fdfc-4b5d-5d86-08decc850f33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271


Greg KH <gregkh@linuxfoundation.org> writes:

> On Tue, Jun 16, 2026 at 06:58:53PM +0530, Greg KH wrote:
>> On Fri, May 15, 2026 at 03:53:53PM +0200, Petr Machata wrote:
>> > This reverts commit 06954f715deb0ed053f8bf85547370db6870225d, which is
>> > commit 3d07b691ee707c00afaf365440975e81bb96cd9b upstream.
>> > 
>> > The cited commit allows testptp to set a configurable clock_id. That is
>> > done via a PTP_SYS_OFFSET_EXTENDED ioctl call, whose argument is struct
>> > ptp_sys_offset_extended, where the clock_id is set. However, this Linux
>> > version does not support the ptp_sys_offset_extended.clockid field, and
>> > the test case cannot be built against this tree's own UAPI headers.
>> > 
>> > The reverted commit was introduced to resolve a missing dependency of
>> > commit c6dc458227a3 ("testptp: Add option to open PHC in readonly mode"),
>> > which is 76868642e427 upstream. My suspicion is that the only conflict
>> > between the two is the getopt string, and there is otherwise no direct
>> > dependency between the two.
>> > 
>> > This patch therefore reverts the cited commit, with hand-resolving the
>> > getopt string to include 'r' (as introduced by c6dc458227a3), but not
>> > 'y' (introduced by 06954f715deb).
>> > 
>> > Reported-by: Yong Wang <yongwang@nvidia.com>
>> > Signed-off-by: Petr Machata <petrm@nvidia.com>
>> > ---
>> > 
>> > Note: the issue appears to exist in 6.6, 6.12 and 6.18 as well.
>> >       Depending on your preference, I can prepare separate
>> >       patches for those branches as well. Let me know.
>> 
>> No need, I did it now for those branches too, thanks!
>
> Oops, nope, spoke too soon, 6.18.y still needs it, this one doesn't
> apply there.  Can you send that revert?

My bad, 6.18 does appear to have the field already.

In fact, looking at 6.12, I see it as well. I am not sure why I thought
6.12 and 6.18 are impacted. I wonder if I looked at at 5.12 and 5.18 by
mistake.
