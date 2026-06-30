Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1EB3955D2;
	Tue, 30 Jun 2026 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847524; cv=fail; b=Q0H1nlIqdSFkQMbPGY9/b1BS3TmsMms2TMQ0cBvDjzShSBkAJ/CJeWcCiaU10Gd3yePLs+7fSobte9WYZBYL1eQXLDwSXSvu64EOqETzQKh6mfopdT8aDcz4alaGtR0IjwabJEqgvVBcYrlPqNFb320DsZD55eEW4Kxjb0S2MPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847524; c=relaxed/simple;
	bh=f3b8B6mum5ZyPFvrKQDfESUcKMmqzabYIm1C44pvUUg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyFEMFN4nOFqE/E+PAKGuC8LnmI4eqYj0WC6GGwqkp10Ekmd4c+2B6MrLz5sgD9VzfMEqP8+dF0soCF/ovsT/0n2lGUOccmSsT8aSJbQ7tVKoovkTS/BKnFEjzl456aYXfwAMUqMO2yIj3xMZNRHjLhAAN7bto3NiCLQH+beoVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UTarTolH; arc=fail smtp.client-ip=52.101.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UTarTolH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukjLkoH3isgiXrLLIQxrjHbvTTrDy8vvDxXm0lnTnDDPxS7xdz7QHA4swU6xvay+/5RFUlp9c7o0yCUI1Qzrt94ZQh36/6yrx1HwfGwM06IzffR/tB4mU9YpEJn84eo+hQVWgS/gQr6AvyX4CkIw/hI/6TYHJgTh2PjuEN2zVq/YZwnG7DtsiNZatjnXNNNYMoCoDOFBzU7WgvaQtXfUfFYUrvnBmIZvhhwOs/tFFkhh3R7R2uCwAPw0gttSYM46CX73yvZR04F0fjHHeScz9FoiATmm90HtnzA8Qo3/ROaTTw6Gfx4N9RdZRwK0+kj6BKA0lGuDThURnHiLTijANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uEJMrWD0UMiWZwUum+CyPdGGjt9SIXdRcE6bWkTdYc=;
 b=xAxrF0LUUlfd+dv3zFLPJWbu7T7sWgOioI6ki7ShuipunCtRu3/QVZxgHPNETqHSJwwKXVjS6EiPWge/ElvNMhaNtBFJrRjxIvDYPuYMXB5zBwkFf0Z0bGMf9i3zmapsXJHVCJF6jIoTg2JwZkUr6HA5x7LANXQ3hSLRUXY2+sEEP7KRLSMiGMYE1UQQQ1VVu47vp+bgIqQoodTmbsRvZ9bPxj+P7orUS/4yW2L2vY8knja6YSwbuhDT0Mc6x9VZhzXtdo5/GEMM9kfVxXHMKPF7oGxx6lvXy/YUOnCvk84NvTwb0Serac0uYmnYlHfagKoHRY9cM+TvokwFPe7OPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uEJMrWD0UMiWZwUum+CyPdGGjt9SIXdRcE6bWkTdYc=;
 b=UTarTolHUJlqDkQrKU4GaRnbwKS5pgKS31mb2CAKoRTx38XIN89tp2kRHFJAztKbvnNyob5rbGDLbvxwG8DK3e+sfO9kA+7lJYObb0JvKWqaVSt2lwZEYZxkLQplA7PWDSaKxgZyX+0zxAoAUzurEpp6tLnlo14/g5XjsN2rxzyI6O772ZCpYeOd5mBSKLYasK4QBsdOv3jkZr3aI0GCUPZpF42nc0cGVlcFyZ52y97W9tZafj09zXV3DeiiBH+LyGg15uCpyFNyCuR4oOJZKBVnp1TcilnpOH7YXuOyDqweztfAxcd8h2vFULgjVrs32eK45jRtcehSluxRPbDm5w==
Received: from CH0PR03CA0298.namprd03.prod.outlook.com (2603:10b6:610:e6::33)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 19:25:16 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::27) by CH0PR03CA0298.outlook.office365.com
 (2603:10b6:610:e6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 19:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 19:25:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 12:24:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 12:24:58 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Jun 2026 12:24:57 -0700
Date: Tue, 30 Jun 2026 12:24:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, Mostafa Saleh
	<smostafa@google.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <kees@kernel.org>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akQYCgLWv4fs7GAg@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <akQLURkLA-bZ9dAk@google.com>
 <20260630190819.GG7481@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630190819.GG7481@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: a959c263-d134-44dd-9525-08ded6dd50a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|82310400026|36860700016|1800799024|13003099007|18002099003|22082099003|20046099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8smg1bM6EEIGTo4iPua3NJqHuFpEBBbCDwkisI3tV+dNYsYfYlnfPtO/GJoGC2/+qN9kjh+2lbZ2Z3xHt04Cop95LaNbXrfhe8CKYzhGym747Rn9GOQIDS7QqDqEsL7jwK2aZ3SdqGKjBtLSzj0MfKFslnutcUg1Wk3U1f3XWyZVms9IR/J3PV/rF5QN1at3fBjpBficaw+8sAnOUvWFvDBOV2JA59bjKzS+fWZcwu4xvNO5aPE5bY6Ox9GYNKD3XNPK/CStkwajaOLkiFL+qnP1lQ7s667hRd6a2J5JhnpcLr9yp/zEx6jalB2ZIh3Zc4LcOmDXo0pHpV8LI34hxmSPj//R7r/cOlvwM2vrlTWUxIksCvZ8Rju0nmJD/BWADfpqygLh8yllSkg9yzSJ5Gx+nmlH6BhJg9wZy5cuSjx8DqbJDJZ3EYHH7eEWQpjlcz7DJyI4esmfWU+5PC2slJu2L2kVmVZUXnTyUlGB0ejNP3l/MjhdL2cAD59HzliE5OAO8L9t0sTTfucyUMYBi0dQ6QQAufr7btO6bZxDazyt/QglTyxwiKs9tv7wieUJlOK3lC8uJ61ORyi6r70R23fCwdVGEfVdSkyTUBymfFoHu+tPLDzKKl+O1w/Pac6qaujmvihC5J5IHrMERySxxo7VBEXfqq889SqVUfhkRSzJSGcCGPqzlPdriv3IB2isf5UX83BoCbQbiSlS3x2qFw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(36860700016)(1800799024)(13003099007)(18002099003)(22082099003)(20046099003)(11063799006)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3tD1AUINm11GzvrVykByft1KRUCP5J8ZBIF955aVUb+wD1JpkM6riO29GmIQCiyRa1q2OyKVP4aVNI95if8GRALIR55Xbq+ElmZf0VrfSPhtAbtjDVX7KMP3Dw0xRwfkOFEeyo9f40QBHT+KxkxEktbRgONPXQ3RfcfrwDj1ysJJRbRuH+v8UhNo1GCVFeEETgN30uy/JLBBPU3jDGhpp/5u5rbzTU2WeZ5d5lXgvp+O88BI7C6f+cISVIyiCUgi2ACbKgQTNOkcDEfhqX1mRr5KpLY4XXazlp7o/TIS0L9dHimIDXXiGTU/RKk6li0TXcKigaKF42J8bLCS4YbFw4HTve7IZRvRcqcB3hafk5Evtpef5jztPGZacuEdGfSWNcvNSlWbwXc+dG9KGQy+IVFLSGP/w67sEeDxU1gY56kx456DbaxOFPeA95uH+ShT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 19:25:16.0914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a959c263-d134-44dd-9525-08ded6dd50a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267

On Tue, Jun 30, 2026 at 04:08:19PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 30, 2026 at 06:30:41PM +0000, Pranjal Shrivastava wrote:
> > > As I mentioned above in the previous
> > > reply I am not sure I understand what situation leads into this, when
> > > does a device trigger SError to the system vs when not which is observed
> > > as an event in that case.
> > 
> > Ack. I see what you mean now.. How does a DMA fault raise an SError? 
> 
> As I gave an example to Robin if the unhandled failure escalates into
> RAS emergency unplugging CXL memory then the system is going to
> explode when kdump touches that CXL memory as part of the dumping. It
> is not quite so simple that a DMA abort is triggering SError.

Here is link to that email:
https://lore.kernel.org/all/20260416172005.GB761338@nvidia.com/

> I don't know exactly the sequence of events that lead up to the kdump
> kernel crashing (I imagine it is hard to debug that one), but it is
> something related to the new kernel not participating in the RAS and
> the RAS flow escalating to something fatal.

Here is the original bug report:
 - kernel boots into a crash kernel
 - crash kernel hits OOM do to insufficient reserved memory and
   panics
 - PCIe errors are observed during this failure flow

Thanks
Nicolin
