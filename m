Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09F83FD13F;
	Fri, 26 Jun 2026 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492481; cv=fail; b=myF+BKoZo27nGugRs2Slqs7Muxk1xritCAR8HPawE8feY3alIgOCMiiBKhJ2ID/hZxYWGol4rkIdawC4Xydolqj/07xpkeg25QSy5DJVysbwCUimyWXEpM5EsvrgdLenCGNTUNQ9GVs4PPENCL/++n9Etk+F/oW2V2LLzRGGOeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492481; c=relaxed/simple;
	bh=OPrL7m+jD0MnjSwzW3v1PCmpRp/bn46nHuWgILOcgzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LEegnMMWSGZosKQf/pWV1Qpb26AfTSzU0OBkTFlF6mQ6EY0PLs3SdoN5SNUP7YV/IqMixylNcCt5nRTIOijYlZtkELre3Bp+23cnziuDpRnBNW+FOqd8rqkOOonizVNP0O9P8QqKjeg7rJwrvjMzKRwrwCu8YAu5ptqgKejj6aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AyWVh+IX; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AyWVh+IX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nssZprXzn3eR1tJg4u3UAWgqBeKompgISFB2VVkYm8qPh3IXAKD6mahqA4zq/20DQZ6ZYO+3oI2lasgsFU4TM8DAVSE3/APZuXCZr4yVt6JmNa1MZxOldqHnEBN6qMDI+bIGBt/MvjVP0GBj+q8L+l2GVzPnmYg0trixHeM9bwtH8hAdY9z5ADw6ERBPLYkgMOCV9+loNKqcivTYaNdzfDaM+/e9Whz4XHPv4ZCbsMxejHfhiaV9Urh51tO7bKRi3QHUoIxHaF5NNiR/OMTuNTotmC6JbmKGBrlLOLpN/UoahZnI4D/PEj9IRw5XdK57C648dM9qv8K66lu/OaThjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjU3/0btqkpalm97bPTco8DqFomCTrBe34psB4TOmmE=;
 b=p0DI4YWPSC/dE9BVLKjRnc2YLHJCPOf9RhkYfeTJQfd3UA6Vpf96GtklHrRj5BpHXB5n37AanlEpcztiHPMn+Fg9TBjm1blrp3Xz3phJ22IppPZ/5dhi73vCHv7BlW2F/w408xflHSghKJYRPu59nddELlh7H0uwVZdXYGM1TwvcMmRA4doZSxfXdiCYoDnPfj2u16hINVLV/vzeLHp/4I9oMEBsRIaup1pzsNrwhQEmWPm+nvFmnk8ogMA9j6VsVTRiPsU72W6E0fevoS3ILmJuNYeaeMoaC3R4saY8kiTgxw/YXEdGSEN9ijn3Ot847FpYBz5UXV/NEeRnKFdlrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=iscas.ac.cn smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjU3/0btqkpalm97bPTco8DqFomCTrBe34psB4TOmmE=;
 b=AyWVh+IXDqA0ojcetLWgYdOHI09A4hcq2hlDQcjd7S6etHeNYHKqLTsrNuc3eI5E62Oy2M2YMLJneKOQQUjSt/X2txDBv+FZ4Zo3SXXKYwJ3fJUyj4atJPXCEqYb3GR8fZMWcPeZd+o5Qx6RIZCM/2rDGVkK6yOICd/KJ+VEIhc=
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Fri, 26 Jun
 2026 16:47:52 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::94) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 26
 Jun 2026 16:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 16:47:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 11:47:48 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 26 Jun 2026 11:47:47 -0500
Message-ID: <cb0d1d74-2be5-8b54-4638-4c9629b15055@amd.com>
Date: Fri, 26 Jun 2026 09:47:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Fix use-after-free in
 amdxdna_gem_dmabuf_mmap()
Content-Language: en-US
To: Wentao Liang <vulab@iscas.ac.cn>, <mamin506@gmail.com>,
	<ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260625113239.49764-1-vulab@iscas.ac.cn>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260625113239.49764-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 159acc39-dd7f-411d-ac47-08ded3a2a8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3mBgEhSJTt2flkdByd0iveO1DekN3IzF8BXA3XXJb17xpvNSy4foB1WeUvM8qMlCL0SXFx1rmLdm5bcJrMqb9LoK64RLAYSCB923wANgC5TlUpPjC8S64Q33ZEX5y9kI/lC+gtXe2b7h0JUDsgyVTU5odn9dqBuiAguJBB9lzxsynNjAOfe7ravDAD/wrI+fublMv/OtVf2/ESWn0KLs94qf/McKHQASpmxoXeCRzw26yq+nwdIYFg9lcA2fYAUU8FTag5pPWIDyNgHzZzaCXbJSYyuKve9SNyFpUST9n1tERaMxxC6BRnnkhLHRbpqfQ/4/pXnGGWQUKHywDodUuDIv2YxZMfb5vdDSHpGaRF7daiNARxTiMTmMJKqJeNaLAcGsbp0PEbSgaBraz1ooSuKwzj7uTO0Yx1EtvWc3jsPFt6tLbla+6lIzzndvs4DxhpSft8Ho86TSpdqJ548ivj0k3JXhAZWIJviu6YYYmQ54NLY6Y2Si8SsU/cjowP1yF0N+KVPdAMJb0fx+rCqlHePp9PW5ljutJNxo4PYxXBaLrl6zCxrTd/doeCA15DlOWPdlSzGZzSgd7kTaxUDmYZ7oeoO6WJjvb28xmvd//p0ZUHrsmhA4pfVdk1a+xKLeBoHChMvQHt8PtNrLxyRnU/ro2YGP18i9VFdYt0HuQurZ9MWTtcZ1xT7PcHi/Cg9zW+ZLWkdVTTGp/U2uX0v0aw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D6G3AZ6a9s5dsn+bODynya5O5F9lj8FMvZPcKwjn5nbEhM71wmfTwmsNdeQ0GbWa/hEv9lSDMZ8ZAn3/U75yp4XPF8bFW3DeryKXWyzs7iwZQ4f3sjRM+PYEWE18n4BjkNV5aHUUxCNtlQiZmzFT9Af3pjiqjfc6ozLUsALMVLu/GtosgM4tBHJP+Z5ZftP4bfZrhsliA/m/x9Qi6LNg2cduHFRskSE8JLNd1uPq7QMwl0l90Zbw2epUq5Y5qikxfK4rph3SC7IXPxvUUbVP5Ecbx+i5kE6R0IWIu6JnQsYkk740jNVKmC45XSeF3rehm8P64Dg0O3QcNDLCbxdXiSAX+0L5w7E49OcF0qqKV3Cb8ELAmX3JoZwsq8cieaErIrHZbJhze1VDQftK0ZZ5KfWazXdZukEbuhTa2nHbkbpcsPW+okPZdQcyvjSoJN9o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:47:50.2408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 159acc39-dd7f-411d-ac47-08ded3a2a8c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311


On 6/25/26 04:32, Wentao Liang wrote:
> When vm_insert_pages() fails, the error path calls vma->vm_ops->close(vma)
> which internally calls drm_gem_vm_close() → drm_gem_object_put(),
> releasing the GEM object reference acquired at the start of the function.
> However, the close_vma label then falls through to put_obj, which calls
> drm_gem_object_put() a second time on the same object.
>
> If the first put releases the last reference, the object is freed and the
> second put accesses freed memory, causing a use-after-free.
>
> Fix by returning directly from close_vma instead of falling through to
> put_obj, since the close handler already performs all necessary cleanup
> including the object put.
>
> Cc: stable@vger.kernel.org
> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/accel/amdxdna/amdxdna_gem.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
> index 6e367ddb9e1b..fec9763c518c 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -469,6 +469,7 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struc
>   
>   close_vma:
>   	vma->vm_ops->close(vma);
> +	return ret;
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   put_obj:
>   	drm_gem_object_put(gobj);
>   	return ret;
