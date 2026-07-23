Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC029BDAA;
	Thu, 23 Jul 2026 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823746; cv=fail; b=LsMoESxF7j1slg+K964QsOaGc9jGLZYR6811e5cN7U7mcsSpLfWL9piFTHdXZ0EpbksgARWHZkB86BeFXclatlBhsCQ9nqWkfywmpj2MLWIASydE7Y6MmxmCxoSExNUKKouwMp7XbmyB83/ymo4jc5kvyLj+HfcB7061gQkDk58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823746; c=relaxed/simple;
	bh=BXYnhSzEQ0KDCRraSI1TYrkuJzsiBFjVpDRXXFQ0MjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCuStjCr47abJYWvy8kvGf63BjxnZZAmoywFL3OcbBp1VOwcvcDfYLImIVheNmgaQdMFPJRDeBsx6ZYnTarPqOzCkz15ENAg3QVmMtq0W+ZGlpwMnfW+e01qJNJc9D1KnItp/KNKtN5vOGx3jJ946O9nIWGE8zSMHwTSkhseWQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HQULGPUh; arc=fail smtp.client-ip=52.101.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HQULGPUh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sI0xNo5SD/ZeXNUZo1L+vIizoIikKwYmRWgKD9HDxbnkv5NsBcVlYZHltomJtOlNmplxQBVL7YQsXkRCyk7bTMOl62yclaz7PlJ2YcWy+09+vX9gOSTJl7tW/Dca0WlV4TYBha3pxgsF6e4bjJh/4TDDZkq29OJVLoBaDbvEKJN0aRV6BAbPM0BPo4zosOoVcWnA55zeq9+QNB8si8Cd3Pa2q/zf37cr1SiGInm0SK9y5vA3hSvndEtVFMlHzRTap4NmXiWZpjN4RQ0lhj3U1G6NJNlyloIQR1Mp0kKthsU5QE70OqwKni+LWDij6MPsQ91bzgPrcbjYVQsyO6CnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNQ9ZcEoUWNutCszNKjo7DsNDU/zqafN8r6FNP/UYI4=;
 b=uAKIx2yGugswy3ilmVf2s9e39nn/SUMQWBlevk4CdgBJSZwawHlhhe5esgS1eTUkaVf5EJiSbYOkhPculM1DNoWxrBBOJlCRmrdDcXKFdTx2v30VVnINUAqTjDcgpjt9jtXNihPhfPZrdsvPob9ErR+MUBo/MXEqHa9YaHnQTFE3fH4IsQrwG6moQT9b5SycKLUcPjxD8DYSCcjDq4Pnwj4bpDeadRPnyof/vXzCqXXVY2SpAgKtLTTkTH/b38rhfn8Fr8nY/36CF/pEYGFFIU6zna8GqNpnLSnbZRp0bXmvzmUaORBcuSKWnM8nD1Dgr0b4AnmLsvWXmrSfdO9ehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=efficios.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNQ9ZcEoUWNutCszNKjo7DsNDU/zqafN8r6FNP/UYI4=;
 b=HQULGPUhnR67WVzhO7DlrtEtqQCLSUsSdvWC2tN389ZOOKKCc5u7BRMMT8ENCXKT3bkcNKvL7LJU45TqC7Kh8PIP/QPw9BPmnAt2mofvCBqYQa5wPuPM1yAzc90CcDgrCSs+DPPThUuccwPZzLqEfERDP+uDagFDnK5703YlTGttzHYeQjL2clEEtzDnwIIXLo0Z0hdEU0BNYh8yXHiM8aiLMRQ/O5mRbPsm5XKZ5YoWV2S0A6IJl5aEj8FpfT4ASF2aVkGDjBOuel5+qGHyK9sv9HqQ+KEiyOMKHNnue9ObOUGDvMW+BAAwG4oxtXmXVeYwPonNoPAeyLZO8NMVHA==
Received: from BN0PR04CA0127.namprd04.prod.outlook.com (2603:10b6:408:ed::12)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 16:22:14 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::27) by BN0PR04CA0127.outlook.office365.com
 (2603:10b6:408:ed::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 16:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 16:22:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 23 Jul
 2026 09:21:48 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Jul 2026 09:21:48 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Nirmoy Das <nirmoyd@nvidia.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
	"Vlastimil Babka" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	"Suren Baghdasaryan" <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
	"Shakeel Butt" <shakeel.butt@linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: use precise current RSS for high-water accounting
Date: Thu, 23 Jul 2026 09:21:27 -0700
Message-ID: <20260723162133.877125-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <bd3facf5-cc4e-4fa3-95cf-0f4aa926ae23@efficios.com>
References: <20260723134158.1473841-1-nirmoyd@nvidia.com> <bd3facf5-cc4e-4fa3-95cf-0f4aa926ae23@efficios.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e131106-37e0-4436-31ff-08dee8d68d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|13003099007|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	flJb0cr9lhC3f1oIx0Tfw8IZpM83arRIDwUm58ufdkgSSzbV/DePCaOkdpmVVQ6ArHxzmxy9lnw0lOTNTB4lJEEAG4abMjQ1L017A2I6DInHWEp3VZOsTUsVltBbDZa/L7ctyfmZ9aN2vG4nT2Vdz5Y+fPLs+RzXJOebDmJwKQHwmq2RfV8scrrEuiy6Ihh9EZz09EEHX/n4U0nG2Lig47Q45UzzDKazKz85nDaxvVGd2gTixPP/nLbF61ydrsUTWFFlpVJAAZTMA8msp5oTFAxquHuRCc4J8R8/PDCO0JAUPkf6yawi+ZApi34TQwhS30aAGRRIntOE5QQV8U9b1k/9yv1Kwr+31hG749wr9ouMC6BFdTJOX0uQCSoOUi+1WLvqki13ny5M4LCtTdY5JpBm65hpEXohEkAsri3QWHKCuny/J0t+WrblenQx3c3e8QD1Djhp3JrNR56DNA+bmxCVeEdKRrTz4tH6VYDQiy9GUfs/tMn6jW01c3RD7STqrCx917MooFYKOe0VHV6zz+JWwkf9bC1JersS6XrbOzA9wrziqzJW8skK9Wum86zvukGEJW2AQejZyyufqU7FzGWQQpR8Ounl+wxsjRnDVhtK9jqUohCXibP6AqgedgLMtv1lVhamkFlfeZtLeWgwYwstE8qOsHTuA+sut+iYOV727mwjNz+q4QSzeQuGjNIm/D9u4L+wPpnsl30M+DiIvw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(13003099007)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kcg++CDdsz0ZG1a7xsyeY8eNrm0R0WseK8qNJPFB2LHmRZ2RZ7lbriVgYAvuYkagB1jjXXW60ctYNKLGFVzIwnTBX4uV/t2lDCsotNluij4fPDozOqRgVOv9uFodNrTEgpVvhUj+kt+nzWQfPFBYg6wXYTjVGcwSEjbJfzCT3kHKcXD8Hdqyvjpmw1bLmX/mJ2f0iBwzDTXVZsNg7IluKfMdpAplAg4YP7PAPlvFE7N3tXUPxzGfd/6yViYP5P6rRJZtZ7r14Sl/GZTN6gSLzrmtqD4XSQVcxqeBQSANKXv7t93Dp7XlCS05BpBh5SjSOWPbPVikZGBJ8r5Lsx3XtNkrIBZlYcfOChmowpW7QbymCtVgetld9HLiDhhYc5HMcUZYrhUpm9zwsH1dG5aXFFXw2wPVXBIfPSlHppkqFqCD/aYEI5d8XF4YAr7Ztd5p
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 16:22:12.5222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e131106-37e0-4436-31ff-08dee8d68d75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066

Hi Mathieu,=0D
=0D
On 2026-07-23 09:47, Mathieu Desnoyers wrote:=0D
> Did you compare this with my hierarchical percpu counters series ?=0D
>=0D
> https://lore.kernel.org/lkml/20260707131544.75906-1-mathieu.desnoyers@eff=
icios.com/=0D
>=0D
> I've sent it to Andrew two weeks ago but have not heard back from him=0D
> though. My series attack the same issue you are trying to solve without=0D
> increasing overhead when reading those counters.=0D
=0D
I tested the v20 series on a dual-socket system with 352 CPUs and=0D
64 KiB pages.=0D
=0D
On the v7.2-rc4 test kernel without the series, getrusage03 failed=0D
10/10:=0D
=0D
  TFAIL: child.children =3D 270336, expected 307200=0D
=0D
With v20, it also failed 10/10:=0D
=0D
  TFAIL: initial.children =3D 0, expected 102400=0D
  TFAIL: child.children =3D 262144, expected 307200=0D
=0D
In v20, get_mm_hiwater_rss() still calls get_mm_rss(), which uses an=0D
approximate counter read. The series did not help this test.=0D
=0D
Let me know if you want to me to try out something else.=0D
=0D
Thanks,=0D
Nirmoy=0D
