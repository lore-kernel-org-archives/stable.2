Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C833645D5D9;
	Fri, 16 Oct 2026 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141566; cv=fail; b=U6yJfvRxN/Rgv2azMQp4vwGIO8VZCiw4g5KO5OBNZ/MdhE6QwkaoSTokxdo0yN85RQ0iZnfOcMFxzthaBHBh328ikEVrEdMN9lqMzoROxj0Nzkr7B2Az3i+LH0gs8W1/JNw0VMfeEKjo0ts1JN2Tyo173d4A3moOhM0wAaHESLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141566; c=relaxed/simple;
	bh=dO7C3o/PxHqNppk0YvOz6T8Yw44d93jRPgR9y5T6YjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WwRn4zWOEbqo8l3NwsltXHRxlgS/+sRmUwdpNyIymQzWSW9JhKcMwmXEFjMMibwJkZ4siTbYvNSjjKyUcMoSp15KIKVp0hSHHLMaMyp4tJ9iLrrSxSm38YSVVXl669Qh8WiJ70v5sO7yurpUjv07UhC0KLZam+SQcHGIWWxa5Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LkbxKakY; arc=fail smtp.client-ip=40.107.208.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LkbxKakY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPmoS/71hk8zhAP3HMA0pJIQ9FGIDC2UrMAPGrNYy2F4iIfkcD6USnCzK++elX1Psc5xFD6Y62rbh8czr5DMO5QwoLWrssi1OT0Zfgb/5ei/IefxDPzV/p19419tusZNCR9mAPZp7kOb0DrtgYBcHH9x6bZRGyrxa5fb2gPh0OQ+QpcQA+w3QTxTciS5x42kIFNL9K6Zt9TVPtoosgMRmKcOsGigeRQfNBLjVrJjsLTQw3Cefbsj+LY4w6ZCXHwo6EV385cEU+b3VteWE6OrI5sxHUN+6LxhMAKDlol4saFCx7CvnayfgNDkRnQyGZunSVUmCo9NSNOjEaM0Mtb2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH9QT2wLxpjrZ+fXorE/43hMEbFrgH1iLOYDUqRFM8g=;
 b=spPc8y8NKCOtExMMLP9Y9eQr0SNT8PZhMI78NFfIYs8zYB9tglV1+bjvYkF1WOk1bgRsB2F9j246X3DNCLOZjPmdU0S2YHv/CttAkHr7Cxd7OuABgLgoT++s4n+sH1OVrFIj8G99kwvz78OwVZ7JPgul5lD6P1KS2BdWg4RNE5MCs9r9rsXDXyiZvHmc3m4NgAS9TbkpxzfGKcwuuuhs5fVgu6LbI8Q/HM/8lXlsf8wvnsojGR+8ey94Vbm+L8CfgswYpeH5Wk71/HYYuY8EgdSO8XDreyfigi6NOe/mW6JXeq4xS4SwhjWOGRK/kztooVrbYxalI2To5BTSfdK3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH9QT2wLxpjrZ+fXorE/43hMEbFrgH1iLOYDUqRFM8g=;
 b=LkbxKakY4p7JikpIL2R0GQOdMXeNETp3kQhPLmPN61rHAwSDsmjRwQiQqvmjBEPV4apqJPSiE6GzLqpUStbd+9d7+IhhgaaPlZ10ATZe32FSkX0TE4L89bX1aK4XaAHD/dhQvjJgKMueI43lcOAXPLdvDbnC7ii9m/b923wTkHk=
Received: from BN9PR03CA0725.namprd03.prod.outlook.com (2603:10b6:408:110::10)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 09:06:01 +0000
Received: from BN3PEPF00022BC8.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::a6) by BN9PR03CA0725.outlook.office365.com
 (2603:10b6:408:110::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 09:06:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC8.mail.protection.outlook.com (10.167.248.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:05:59 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 16 Oct 2026 04:05:50 -0500
From: Daniel Huang <danielhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <alex.sierra@amd.com>, <Philip.Yang@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Daniel Huang
	<danielhu@amd.com>
Subject: [PATCH v2 0/2] drm/amdkfd: bound SVM mappings by the GPU address limits
Date: Sat, 17 Oct 2026 01:05:44 +0800
Message-ID: <20261016170546.88570-1-danielhu@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC8:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5a6590-5bec-4061-8a1f-08df2b64b271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|261009223027099003|5023799004|56012099006|11063799006|6133799003|10067099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	+F9Y98BkHLV9qNjiCWiKRxHuU26tvb6bHB4xDe2b6gtRxve3iY35/ADcK/jd+Gyw611nJwRK6kb0rh0+qFk7HpxpvRp7QB7uPVwIRnVg0wnjmlyN0MW8rgpUHFNf7LDArqPVy1EisWubY8077YCVSyXKug18/nrsqZajGEmsGsn3gUELHtsSEzDmEUfDzNU4KjqJs+MfXRdCIwaRvwHk0y4LQkod8LbeBSFErHajHtlvna0KnnoiU8DINFyOW5QKZSQb8qZcH96NH4CDpc5epLQmOjRcjjX1wYQvajAT/wwSfwGlk8ymeCNIvuWRr3GJrST3OTgYlV2+Gz1p06ddqXogacnjDL7dubirwvgOO0rvyfcKfPML69Mm9aIz/0dllcqR5z5Dmd3WEpVmDWWlnqCf/VkJ3enTK9wCli1s4qWl6nZfDzC3ZqErptRXTQyhbiFRJIAysJBmsiyLr8UsllkGipc4Jgl924pVGiU7Fzv6ovS+c9LIwQuM1i4rNLqxLR3rsjS3woFVX+F4j8I3JOKxibDYsR08VtNs8ZLBY5SzrMevJzw5THKeINKY+lmEH4fy4Qcz2/uI41DayOFB4ZYzIXNr0V9FBicWKqk9XwWaBO7RlfCjbYtA4B4JXlsfjgE51IVNxmVNamlA5n+OTg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(261009223027099003)(5023799004)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5fm+s1qoX7faRjmTmgLBIUOMgQsb7cU6JXzirD+KixPdzprBlPolI42pHNw/FYiM90QoLdTmtDfn8uZm8WI+QBYRjXUONSLZVfO4CD4i9NBP+GsT6HYLM2ukaT+9YaPLFOzWcA5ebVfUTQzOhdBRAObLOVPtrwiQrVLLzIZVJ9SjflfvaxPOIXquyYibM0cT5o3tSJS4HqrwRI3Xl6gzzbsH6i0Wn4VhW12AorynvEVTi22FkQuuFGBNEV7QOTUsxs5f7vzdscbbRi0zklh77FR//n15FRu/8ap6Yb8DMyPOIb+WDdh1d3VbBsDiijKKsXPTaPtxtpbySerVpz4aAuvH+nSwvWvwn/Wm2qY5Tmke8uxcRu5d3kPm6ij/TD5ZzVF7xY35GAzpidUaOHSMaG/H+qKkkp6K88cMAyiTvKxZqKhQnNXd3RD+LlRWs7e8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:05:59.9975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5a6590-5bec-4061-8a1f-08df2b64b271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763

KFD SVM maps memory in GPUVM at the same virtual address used by the
CPU, but no code bounds that address against what the GPU can actually
represent. kfd_ioctl_svm() validates only page alignment and a non-zero
size, and svm_range_map_to_gpu() passes the PFNs straight to
amdgpu_vm_update_range(). The BO mapping path, by contrast, validates
through amdgpu_vm_verify_parameters().

Patch 1 is the crash reported in [1]: with an explicit amdgpu.vm_size
override the GPUVM can be smaller than the CPU address range, and the
page-table walker indexes past the root page-table entries. It disables
SVM when the GPUVM cannot cover AMDGPU_GMC_HOLE_START.

Patch 2 addresses a gap in that check, found by the Sashiko AI review
bot [3]. The comparison is against the GPU's own address hole, so on a
system whose CPU address space is larger than the GPU's it succeeds and
SVM stays enabled, while individual addresses can still fall outside the
GPUVM. Every current GMC generation uses a 4-level, 48-bit GPUVM except
one gfx12 variant, so a 5-level paging CPU reaches this whenever
userspace passes an mmap hint above DEFAULT_MAP_WINDOW.

Patch 2 validates each range against the limits of the GPU it is mapped
on instead, covering the mapping, unmapping and fault recovery paths.
Using TASK_SIZE_MAX for the patch 1 check was considered and rejected:
it would disable SVM on every 5-level paging host for every 4-level
GPU, including the gfx9 datacenter parts.

Patch 2 alone would also prevent the crash in [1], by rejecting the
mapping rather than by refusing to advertise SVM. Both are included
because without patch 1 the topology still reports
HSA_CAP_SVMAPI_SUPPORTED, so userspace sees runtime failures instead of
a clear signal that the device cannot do SVM. If only one is wanted,
dropping either is straightforward.

Changes since v1 [2]:
- Moved the warning from amdgpu_amdkfd_device_init() to
  kfd_update_svm_support_properties(). pgmap.type is only assigned in
  kgd2kfd_init_zone_device(), which runs in late init, after
  amdgpu_amdkfd_device_init(). Testing the capability at the old site
  therefore never fired for dGPUs, and amdgpu_reset.c calls the two in
  the opposite order, making the behaviour path dependent.
- Scoped the warning to devices that would otherwise have advertised
  SVM, so GMC v6/v7/v8 no longer warn, and made it dev_warn_once() since
  the surrounding loop can match several topology nodes per adev.
- Guarded the new code with CONFIG_HSA_AMD_SVM. kfd_topology.o builds
  unconditionally while kfd_svm.o does not, so the reference to the new
  helper breaks a CONFIG_HSA_AMD_SVM=n build without it.
- Fixed the [1] reference, which was a placeholder in v1.
- Added patch 2.

[1] https://lore.kernel.org/amd-gfx/da43b0e3-5bd9-4aa1-86d3-b733f3bad108@amd.com/
[2] https://lore.kernel.org/amd-gfx/20261016145129.69645-1-danielhu@amd.com/
[3] https://sashiko.dev/#/patchset/20261016145129.69645-1-danielhu%40amd.com

Per Documentation/process/generated-content.rst: an AI coding assistant
was used throughout this series, as recorded by the Assisted-by tags. It
diagnosed the fault path ordering that determines where patch 1 emits
its warning, designed kfd_svm_range_fits_gpu() and its call sites in
patch 2, and drafted both changelogs and this cover letter. I reviewed
and tested the result and take responsibility for it.

Patch 1 is tested on a Radeon 780M as described in its notes. Patch 2 is
compile-tested only; I do not have a 5-level paging host with a 4-level
GPU to exercise the out-of-range path directly, so review of the bounds
arithmetic in kfd_svm_range_fits_gpu() would be welcome.

Daniel Huang (2):
  drm/amdkfd: disable SVM when the GPUVM cannot cover CPU addresses
  drm/amdkfd: validate SVM ranges against the target GPU address limits

 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      | 42 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h      | 45 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 14 ++++++-
 3 files changed, 98 insertions(+), 3 deletions(-)


base-commit: fe9f3ed36c83dcc24b4ca3e8913edd6e33a89150
-- 
2.53.0

