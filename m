Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BD93B995E
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407215; cv=none; b=b8ZGXKtYBcoDpfXvAMgcKQ9LT6s2xHVJQLKe3IY7SCsP03nartgl9H1huhcP55hrmADzg5Hcc4+O1N//NskEvFiZE4RqYOOc/nRlGok/scPiU+KW33s3rnQFFce77TUmKzjUMhm6G3IqE4x9sv/e8fBJH8t7jmDx/ALjwoQKDkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407215; c=relaxed/simple;
	bh=j3f8/6Ari+2+xlFJo9OZ6E4fcJIZogJtDZW7dOV+Hww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQUxt5/93tCozf/ZF0i6z0kx1rEe/OBIs4wE05b3O0AgXbtkH1RNgpTWdefSRhJQ9HQb1ZzH5lx1efPrhSG4Z2HzaGSXFUBA3xOLw4W6r0Mi+hItLiMTKv/YSaJ251hNwKbe400J2633MtKNkcLnXuNiCizpQwo2FwLYnqAdJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=ZYX1OkKp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="ZYX1OkKp"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84532e3dbf7so3990397b3a.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783407209; x=1784012009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TqIW25gxmpXz6F7g7W0IsW4kAKFmIx2GtIXiGhqGKtM=;
        b=ZYX1OkKpt1aBMiMm//jv13J0TZmsOQTUztoFk7sMSU2O1OSJTWhME0raOLyTO3DZLF
         hLnWoASEXn0WpWkZbdB/0cG0mn+v42sSdA5aG24ymQnZcv8Cw6/8QGUK9N0JlC2pe7zS
         O+z5LuhQfvBjLudxX/u0HmFfRJXerXj+rj6ZJdRD6dljKcx2HGreflNMfQVjJ+GCRB8B
         TGMnY8wHFKaaocfoeQ5m8rYcUK6QSGGqVa626rH+qSQecm3Sa3XVhfFxkRLuHUR0pNr6
         UKWVmtvIAy2chVBEwZHhZ+UiJEnSuBkopj5xobdF2yM0GDe7xN1NsmyFI5PDFPRBm4m4
         A9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783407209; x=1784012009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqIW25gxmpXz6F7g7W0IsW4kAKFmIx2GtIXiGhqGKtM=;
        b=dp0GbzZnspH9Uu03voRlFDxDbSeZYvvUc0meABcO/Nb+J1niBp8gmMuczuhYxNcvSk
         B27evIuM1tGfuXr/vaFlAjfX63qbz8v8BLtYlHui7C0a3ytKw0DUjaFhFNfqMgEF8pBP
         o1Ubu6/aP1y3gWQu3w+VuzWhzhUjqPE3DEa2e8t8n6p7hfOk5LRyx+fY4X3pyiVwcnOU
         1MDagfoSFEHTlqYtLmUjY2hzLHuJNmyryhm6c8zFpNq6rxgsK6aOp/C86pBaw2fpNlbZ
         5nb+MQMDr/3np4qWimZ1oen97sc1+Udk5F6pYA+y0Wsl4T9JlwzVyp8bs+p8v2IFi/rY
         WKMg==
X-Forwarded-Encrypted: i=1; AHgh+RozeohkJuTnDGSVImP1SEL6/b2+7iwCNE7JytBULuuefdpEdso86pFwRjOKj3I6VQjtB2o45rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/yv5pyVCJ4ylcJ0CdCVzrtYfpMzaR+DuEqB3p5ea/drqA3k7
	pSKRd01ohBYjqVwqsIFjOgOm5/3HkhRp2N+rzB8j2QcEGsXAvNx/xTEVH4uGE5SPvQI=
X-Gm-Gg: AfdE7ckYFuY2vsPKef2wgAcEfdyQJzUoFAF7WPBSEwjsGWojqsnGujV/ZgLIpn0zgV8
	noHf0yW6+IWEJb/S4RDiESJ4AoLLfV0uqjIG1hW64DsuXZCnCBvZRQh8ok55+3kBQ53kCYT7ewv
	ojKMvrxZ4VXGkQvnEzVsfPgkuK9RGsvmF/Kn29mLucl6T6G1ya8bm4o2F8lrdU7gsuvj1hy8KTL
	et9FPqB68z6NJGtktyigHx6zUR9fRJcS3qdSVaqcvdxJCcc+hlqD32o2vRZ07yDETR19TcjM92p
	kCB2apzVjQOd2qzoEcY/tf3cdKIKR28wTEvOZ7I2Rz1sULLZ2E4lH0ctajcv7ELqnqUBoNXE6ye
	mDd4K6FmRHH7U8ifdphAOB1+8GELcinkDjnpm3LAyWROR3jE/Us27nhEfUvVwLlfJNalDpbSVpW
	WwZwzr/1WUxpEl1d00yyU6syk/QwTFceUSGDQH1B5ybCqP+mG6OdSsOmXB8nCXPtZTgVsJiJ2Yo
	Frb0GCBOw/t3Zk4bsZC0xjeIJOsiKNWZOj+hpDX9ro=
X-Received: by 2002:a05:6a00:2d86:b0:847:77f0:72af with SMTP id d2e1a72fcca58-84826d3e339mr3820247b3a.40.1783407209410;
        Mon, 06 Jul 2026 23:53:29 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-ca5af7d595dsm517238a12.6.2026.07.06.23.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:53:28 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: justin.tee@broadcom.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	paul.ely@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()
Date: Tue,  7 Jul 2026 12:23:02 +0530
Message-ID: <20260707065304.949135-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for mboxq using mempool_alloc() is not freed in
some of the early exit error paths. Fix that by moving the
mempool_free() call to an earlier point after last use.

Fixes: d79c9e9d4b3d ("scsi: lpfc: Support dynamic unbounded SGL lists on G7 hardware.")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/scsi/lpfc/lpfc_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 82af59c913e9..23355f12fbff 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -8189,6 +8189,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 		mempool_free(mboxq, phba->mbox_mem_pool);
 		goto out_free_bsmbx;
 	}
+	mempool_free(mboxq, phba->mbox_mem_pool);
 
 	/*
 	 * 1 for cmd, 1 for rsp, NVME adds an extra one
@@ -8311,8 +8312,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 		goto out_free_sg_dma_buf;
 	}
 
-	mempool_free(mboxq, phba->mbox_mem_pool);
-
 	/* Verify OAS is supported */
 	lpfc_sli4_oas_verify(phba);
 
-- 
2.43.0

