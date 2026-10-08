Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A427280A
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 03:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429797; cv=none; b=pfIxErbK/nTHx6J/AiDH4pd9nV8aofGN9GUEjVuR8VO6lgeVBTL2LFpEmVIO0rVn2/PYYIlftJ0f1kZu9E2fxTWh4McW5W4UPZ5O5UC82WZfKTdT302FZQM9kWoPLDDcAVc/ulTWpkEvwhqYYW39STJBsgpqD1xdR2FB1LL5lYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429797; c=relaxed/simple;
	bh=YGBMYM1z2o/Q5w9jEH6xIY6TbDDsbogSpgPbTr+m/RY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ep5GDDnYC7fL0WwlDx9ttwXPmQj1Erf1qT8XeP+K/etMuuKuPjjrWRNVWOEdY092ZXfE7loFvOKXuKYhyv1fHptoQ1b4SvTS9KxOJZebelPtxLluQp3c7UvQpLKQIhGQOa1VLQOarYEUBYxgaVDXhT/4/8wlSy+fGpJEY0zgnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=hnGxfHJv; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="hnGxfHJv"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x3rsevz+xlK1p56nF15nSzSuA7KlVfVMFR+K/1Lrv8c=;
	b=hnGxfHJvpUVBJbj8Dj2XVjLuluFHLljMuFunLE/rnzT9qP7FPruFLuNuf5QijArknCJdCbVDc
	/6IjnCaaNV3TucKUtJOIzdz18Ze6GP1EA9tjct8h2+CV1B4Df8KsmUacOxBgpae74BblL+fVDhT
	hcy933dHO8xyiO187j5sjCw=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j0ZkZ5k5Zz1prQs
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 11:10:46 +0800 (CST)
Received: from kwepemp200009.china.huawei.com (unknown [7.202.195.233])
	by mail.maildlp.com (Postfix) with ESMTPS id BEE6240561
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 11:23:02 +0800 (CST)
Received: from kwepemp500015.china.huawei.com (7.202.195.9) by
 kwepemp200009.china.huawei.com (7.202.195.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 8 Oct 2026 11:23:02 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemp500015.china.huawei.com (7.202.195.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 8 Oct 2026 11:23:02 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <yangxingui@huawei.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH v2 1/4] scsi: libsas: Fix out-of-bounds memcpy in sas_ssp_task_response()
Date: Thu, 8 Oct 2026 11:22:54 +0800
Message-ID: <20261008032257.2689518-2-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008032257.2689518-1-yangxingui@huawei.com>
References: <20261008032257.2689518-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemp500015.china.huawei.com (7.202.195.9)

The min_t(int, ...) clamp of the device-provided sense_data_len
turns negative for values >= 0x80000000 and is then used as the
memcpy() length, reading and writing out of bounds. Compare as u32
instead. Well-formed responses are unaffected.

Fixes: 366ca51f30de ("[SCSI] libsas: abstract STP task status into a function")
Cc: stable@vger.kernel.org
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_task.c b/drivers/scsi/libsas/sas_task.c
index e9d291007817..2080e5836179 100644
--- a/drivers/scsi/libsas/sas_task.c
+++ b/drivers/scsi/libsas/sas_task.c
@@ -25,7 +25,7 @@ void sas_ssp_task_response(struct device *dev, struct sas_task *task,
 	case SAS_DATAPRES_SENSE_DATA:
 		tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		tstat->buf_valid_size =
-			min_t(int, SAS_STATUS_BUF_SIZE,
+			min_t(u32, SAS_STATUS_BUF_SIZE,
 			      be32_to_cpu(iu->sense_data_len));
 		memcpy(tstat->buf, iu->sense_data, tstat->buf_valid_size);
 
-- 
2.43.0

