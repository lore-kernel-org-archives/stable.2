Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9D4E1412
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485024; cv=none; b=fasahnX+/uuKPAfTg539jsR6t3qeID6srC9C7LGU4+njWBnLxphb9Gq5y9klQOxOeFAk5GuzNwLVhO3b1t7l19u+woJz6ks1D38xwhjIsQn1DKQ67/41k3xd+n5NO8ZR5AvlRtGU+ThpCMEHxgmKrDRR35ec6FInGXR7zNyoXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485024; c=relaxed/simple;
	bh=uSXX/v1i277yMPTo3o6YTUypZcjJkmSCfy7gVxyfX4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8gFCoA+aclupy0pbaTPhY6GSrrv42PFJj5WvFMYb6a/DmQ3kPk4GnH8nqiFYAP2OpTdJZKPdOeg+jxRZ6ghuTyAm0/Kwpvr48U7rgjXNezPS5H2wMysFiruYpYZ0mZHaOvE4SZmq/6Lof9tEMOq/8fsZ7VB8wM2ELYMstOk2iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOzmRbFb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOzmRbFb"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a02718da81so25969075e9.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 11:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791485018; x=1792089818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2TQ/dYlIEQ7IbvZ9UoPQ3SFyHjvvBzoDN2VtQPnIdfI=;
        b=IOzmRbFbvUNn0qvu6K5nvkazL7O5xQCPFI3SwI0IRlZu65GI3t1SdrnosvsQ+e1TI3
         Y6TztGymVoh0nUzNJqvsRFCn0na5IZAD3Atk7ph2tMQCOnwW8FPSRwqitJIyRxspL5tI
         dUGNf7BynasoVkQPYHOkeYjyigD+bOdqqEDZYztwyjOHgT79p1tUp+Q8bociH0vuIf52
         Y6asZXiU93GUmX7vK2UROfqP/cUsaksLV+7Seu31lf4PiNw8YGbZYZ9ljRiceRUL8zaR
         dOHgykPLMRhgiFAUqVW00Co+Rm3HIx+AVGvEib9DUBqEfwMXoStuVOpFhcwfcl74rbbV
         kJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791485018; x=1792089818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2TQ/dYlIEQ7IbvZ9UoPQ3SFyHjvvBzoDN2VtQPnIdfI=;
        b=Ymyf1u3Xs9C+vM2vDXHxRLPKeq2Ri6fo5fwFWAjTlM09agVCPq30yPftRvbPYsirEZ
         EC/RGXOOuTnMiIWQF/w2KhMLZD6oUC2GGYsAXndgD1XmbmdYHGhEBBzMfdVHJj0ATdWJ
         7ZAn/e63Q6I8NeqfQ44CwFBAGFcrv6LZ70ecEduR98R1OQqitmSM9gteWFSGiOzd4c7O
         IJJ/AMVGhpZGadvfTsQnaiohFK+F8s4l72Q9KM0YUBW4+2hmuyGQtlhe3H21MPh89IlR
         BQt7NuiqLB/Ln4i+nG8JFEl5DNUObnNGkPQUxnmbRy2OhrshQic3SvepmYynrF7ZBmEm
         XJJQ==
X-Gm-Message-State: AFuF++l2iq6Vj8YoTunG57dxylCgTE6mnJCxXlYhkqW/Exed9Jts6Btu
	qqkClay3Gu2WW0wb0o2UtgzRVfglXai3HPX92gQlrImRA9U631zWB8tVpIMLamRNebw=
X-Gm-Gg: AYBFou34uo9H2oguyWLsYQz34IVPzYxjdcur/zNnIEMyAtjNEIjOYnr9M6iwoY9GF8D
	ZzhImbLoKwwFRvJEPJXJyvcUcl70UHkVk/S3p7x2Z8YRIxkWBtWAAP9XdAa70+QaCsI48BqQstc
	ejA1dDCxZzGv9J2qc9amBkPQ+ZCi1Nj9o+fXasy7DSvh88j1MuPXxHW+R6LS1DEfdRfknjDEK/h
	DJO5gr6KSifl7yneSfTXq30id7WnF45l6ArLE0kzInu6QAHeaphqZtdL2Ab7nHTd8rl83TGyjC5
	boxD1WY3i8fMeGEGvudPVbbCUY/1G6CN/snReMejxOq8+tj6aoRFY7PpcM0659ViR3BxooUTsUk
	dcwgJfbEX0/Y6/1yC+CDfxHEPleCu91X8io5oYbZigZIZWamsbgsghoJhL9WEC960qE3Dvzy2A7
	qzDm/C2LofThWG8P5BOOpuS+nv98/MWfSIKrkgCwvYURBGgnaCl3ON+HYp+XY9J/dHRw==
X-Received: by 2002:a05:600c:1911:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4a180455696mr118519395e9.33.1791485018191;
        Thu, 08 Oct 2026 11:43:38 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb5dd8dsm4881605e9.0.2026.10.08.11.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:43:37 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	justin.tee@broadcom.com,
	paul.ely@broadcom.com,
	martin.petersen@oracle.com,
	nihaal@cse.iitm.ac.in,
	linux-scsi@vger.kernel.org,
	Andrey Misiurov <andrey.misyrov@gmail.com>
Subject: [PATCH 6.1.y] scsi: lpfc: Fix use-after-free of mboxq in lpfc_sli4_driver_resource_setup()
Date: Thu,  8 Oct 2026 20:43:28 +0200
Message-ID: <20261008184328.2857037-1-andrey.misyrov@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6.1.y backport of upstream commit 1bd28625e25b ("scsi: lpfc: Fix
memory leak in lpfc_sli4_driver_resource_setup()") added the new
mempool_free() of mboxq in the wrong place. Upstream frees mboxq after
the error handling of lpfc_get_sli4_parameters(). In 6.1.y the hunk
landed before that call, right after the NVMET WWN loop:

	mempool_free(mboxq, phba->mbox_mem_pool);
	lpfc_nvme_mod_param_dep(phba);
	rc = lpfc_get_sli4_parameters(phba, mboxq);

mbox_mem_pool is created a few lines earlier in the same function, so
the pool is full and mempool_free() really kfree()s mboxq.
lpfc_get_sli4_parameters() then builds and issues a mailbox command in
freed memory. This happens on every SLI4 probe. Its error paths also
free mboxq a second time.

Move the mempool_free() to where upstream and the other stable trees
have it.

Fixes: 299f5baa1321 ("scsi: lpfc: Fix memory leak in lpfc_sli4_driver_resource_setup()")
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 13ebbe4..fc5a640 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -8175,7 +8175,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 			}
 		}
 	}
-	mempool_free(mboxq, phba->mbox_mem_pool);
 
 	lpfc_nvme_mod_param_dep(phba);
 
@@ -8209,6 +8208,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 			goto out_free_bsmbx;
 		}
 	}
+	mempool_free(mboxq, phba->mbox_mem_pool);
 
 	/*
 	 * 1 for cmd, 1 for rsp, NVME adds an extra one
-- 
2.43.7

