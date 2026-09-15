Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93876305699
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433865; cv=none; b=aqXiAJ/87EK/0neVMFjiAm6m2IEOWnGH+8Q+EbFR0h6Zzqi8T1jMoLYHgPChR+B4I9icn2p75lWajp8g/1n602FqsDl8RV3kCImTuwm/EjbQrLOU/nw/pHjHbjml8cL9pYl3hlG9zdZYMGWTZEG2PzTmZVO1gkaDZcs6GJgOuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433865; c=relaxed/simple;
	bh=/UEMaY7twJnmiCXA74bC5h5NpK4IyD/Ab3YfZF0J3mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cang7F5CAP5HLQKW3WW5wIqCMkh//k/fozdD733xsYGSE+4uA1f2ttpJzZ3MWpbHuqQ0hPrlGdc5i1AsFbCiB8II/0ns8DrmBGC0IGY7Ras2b0qQxBkuOKebLNOu6g4rww2Q7IoGvv7Bk5KSoMIVk7XQIs2dwiRfihBbih8NGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIJEb/xq; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIJEb/xq"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-530e1b6a689so21727911cf.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 17:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789433862; x=1790038662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m6lvqoIibEREzr49NvqIocAukK1oV7HubreMb9a0XXw=;
        b=PIJEb/xqaZu/v6YSDP1v/1VgtwKHoMJhuVRNWxpl1zMh7PP+yeSrCNWq8113jPPa2s
         YxO2WGJEipgi8+TGxko5rbtyhtVbqrsU2/BudqznR55fg2H2+4iVp0vPzQa4+8V7oK6q
         ny8kPAn2LZdRpixgO5oYpNSNK3mXnEZSLZgWl5wZhgNzmRAc01zd8Sayc1ekKU1/Mm0P
         Se5O72RZm2CB+nK+sQCDTpf6zibUD/V9tEgRSI3naJg81xnFDSed3nqZmK2x7ag1YQgY
         hH83zuJ0Ymt/RdQ0pjI+Kbkb/+eWbc3zvgslElD1VrA3kOfQsarstBeoYS+meH3OD2Lr
         iTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789433862; x=1790038662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m6lvqoIibEREzr49NvqIocAukK1oV7HubreMb9a0XXw=;
        b=a03yyDVdg1s/NIZxFmJCk+1ivT3lL7zjKn0PudkCTEkje9aCZtdrrQ2R1J4b8jZsum
         5ts5PfJsBGr9cvEWYZlT4+bHIbJG7lnbUSl558Sa0uOFO2rov1+1XhjpikSuQFba41M2
         4UFvStrE44fGB9iOVMBDTZjG4tZHeCXlpKBZwRJpXYA6ozyNGSZTu3Nebch/2XA9lBzd
         CrtW0HIjshnhQf41QqvTpvlxRksbLRTCYyTpSTZUVP9P1ZTi7j+F6vGP/Fo0P9J8D7Or
         cboffWnOiAe30sFDXECn3g1keNihec2eXo9u9vmvGnELjRTSnuNtF/nbGRF7i3Xyid3M
         ge4A==
X-Forwarded-Encrypted: i=1; AKwUvBybPnw+zJ7sGZdGE+9wSY/xB9lg9B0DJuzs1R2KQVydnTF2GOp+Snx8/s3qmXH2V3mbN2N7HTQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lzDXfM5jWoPGydR+KvEslNgKObXdAbDKOOHZOBvGO4QrLSZy1F
	zJDgo0tOic/oQIEx25OjJXJ497nmG2rbAGSjCKkwp4uP932EPB/1FVo=
X-Gm-Gg: AYBFou39SlBL03B4arxS2zhEfteDDSiUoHGz+UXRT296qtKNgpZFP8N/3LO3q7Q4xjN
	x5V+qKyFHwEGNlsGlH0KVGcOwqhV0eksC1dWenV6KFX6Lc4hRxMRjFSDMhU+ZUHmwxcCjlhd/QI
	kx/9pCtqhQhpAjn34kv+XP2/rT3krWH6Fnmpg4RfAaEbbRu7D9TbvwCncPwAX+y4k2b9hk41Gdx
	XoFyQeKCvmIRAIbopo/KIZ69siwEb+2j3U/ANnxJLNCYmD53P/33Hzh3zRaUt945X3MRl7rkmTl
	Hu4lGZBs8CI8yvnUQRhVhAu1WQlTsYqDuv7+p4c7jMu4kaxbhURTIclgBudPqqu4GZo+Jcs2ufj
	kds/eeDGFMFc6k2PK6BumcHpIxtSCzFs+0nk9uuD0vskZwS7rYpXjm+eyD5gHawFCnDQZaGXlPL
	ISf1/jCkMpEfWSaijOPpmW7k2hxCChGEoSyuTPjmTbkiLnnxErpGABVQmWZF1galHzhxbfTTkLy
	lABdB9qyf8p3JhgHPeSaMDZwKVDFeerNyJr7nP8gZnCSMBvVHiBnQORsmyVp3J5+OkMNXP/8at4
	m/p+91doGRO+x4mNlXtxIpKM4WYbbBKBngGxDS5nmZcH1Zmxa7fdSL1fZhTblfwMqnvyMQ==
X-Received: by 2002:a05:622a:991:b0:530:42f7:4ffc with SMTP id d75a77b69052e-5310d027297mr84536941cf.45.1789433862242;
        Mon, 14 Sep 2026 17:57:42 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ce4ec298sm115972951cf.16.2026.09.14.17.57.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 17:57:41 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: a100u2w: Disable the PCI device on removal
Date: Mon, 14 Sep 2026 20:57:32 -0400
Message-ID: <20260915005732.52332-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inia100_probe_one() enables the PCI device, but the remove callback
never drops that enable reference. Disable the device after releasing
the host and its resources.

The imbalance is already present in the initial Git import.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/scsi/a100u2w.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -1204,6 +1204,7 @@ static void inia100_remove_one(struct pci_dev *pdev)
         release_region(shost->io_port, 256);
 
 	scsi_host_put(shost);
+	pci_disable_device(pdev);
 } 
 
 static const struct pci_device_id inia100_pci_tbl[] = {
