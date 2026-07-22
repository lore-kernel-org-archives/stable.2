Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB448035F
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715150; cv=none; b=ZCdKIcsSyddCUnmNTMFq0j1H2G7BDCrQg8EmiI8brqxtd+ZG14Skv0y9sUDn3dkdLJO2aAYoA8V4UYaTXO99Y6txY6qiVcCSA8e4iMJPrU7qgJJbMhYIGSuiiwjXQty8pYM5reeedSw80ZBo+n/uKj2pGXm7U3u5dHVjZej70js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715150; c=relaxed/simple;
	bh=+EO+/DM+UqXo1X+9c7qNvx+s5xrKmkfKbDX0PDh5eCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1DVc40bI8pLbRHVj9lB7/SQ/FjPYVXMIbW3pg1nmWPjKpWABd4/F6CVO4ont36FmGCWnmzKPWSzO/bqn6TXU7tlwms3gZtIibGW0lKpE9OQ89/qRn3qi0nlxGclR45085C54sHxik0ZvPP+XSeXZFa4lX9HrLLmyeoMzNuo+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=PugG/3xX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="PugG/3xX"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c96c92c0980so5914062a12.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784715144; x=1785319944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zSKRTMZROa7njeBdu59rhX1AOvMB9lBLaZAp5eIkHZI=;
        b=PugG/3xXJLXadBFoMbHAwq4I3H+uP000COGvuhY4GXkfIs85LmnThqljQkmHsDYyGv
         0Q9CGcjfg+qQyLVSzWFTPkp3cjHong6qffP6GcCObTNk7hjjDKhm6QbnJlCeHqPW1vmj
         IwpeelW/CE+CPDowVctHz3zi3aTPTFHIgRSGmObb21+0WtQ86TsoUCw/uSCsILxLhR4z
         ccxYa+qAr3YHzanw0tqf7bHGwB5dNig6foqasT4b0vXTOynXz5QVLKpDKawxfO3biJSN
         pNPIQkYpWu+bRBT8IuEExkhx+D1sMj8YeW591lsd+mhZ1ktq1JG/AjjdhY+E7n2a7uFZ
         B3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784715144; x=1785319944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zSKRTMZROa7njeBdu59rhX1AOvMB9lBLaZAp5eIkHZI=;
        b=FwsVyjHsQqTL2hmLzbn29V3vxe1WhNRirlec4KY+X3ZJzhrggiIN9YbaKgOMJ8AyTw
         aW5GL9vyqHrxK8cm+3b/rSK0GdggivTZiLxU5HpN+4JEvXyFNWS9G9KQko4XO56oJ81p
         gc6vqFPVjPLYcAw5D2rY5s8sQ0Uy32+ax95Xw0PJUr7Tfzmf7NKnSif+HDjTG9FQeh/b
         kpW0spila4kXHdUL//8C21Gdwx+jyyWW+iTi8yz++bTTDZmSaLpsVSWrjvrZCH16BTsK
         j3cOwb9LJlpgtUSvkNtMDWxbqXS2cy6T0srQSRhnc7kDr1D3GYa0IhYQy/DBj6dDMSa2
         h0NA==
X-Forwarded-Encrypted: i=1; AHgh+RpxOjMjoxjYpJnt35j2lxc9Xv772QGdVOoaEem/RtpH+Vr357MbpisGstZ0XCUX0QfUcuQ/kMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXnFkfyX+GfNoa5VlKu2Kg6wmuwEWvkXRPgBaS/hH07tlWZs2O
	vuzW5uRrxug7hpBNfD53ekXdObfE6uh38T9nxnKFOCTZqbsp7LI390ujawbALupFYNkZzwUTvZS
	l6lww/XzhyA==
X-Gm-Gg: AR+sD11Qz1O2LniPpty++wlbqEqVR6OS4HTc3WVF/gMTdg8i1BNvTsbzJU0iLBxfOS4
	yEnjVdhHBlm3DT/4u4NQvEzkgjFqJMyqEU0BR+o9WiNg3k2yTtREOEXsayWqfLhFr14weR87QdC
	w3TpVmc9pp+9zpswYjjIacrhTSfBuFBJcGDhUzuAWWC4+hnIb0RAvBZgJzy8p6EX74+e8FE8Ri1
	PrQHzdX+pHqn6Af5RVVzN4u5ge80Pvk4N0Sn/yAhyH8f5mrCWJA2RgMlTs5L55dp+fx4uiGNrf/
	RITE1RXkqi4mF4jaPsxjRShNPWh+WH1pHsT3K8W3wUWPBUetymT/mxNTW/O3fxyU2oTjYP3RnEC
	Ne8l1bq82WN9t4LWUvk0UD8rNxvtU9l43e5jOlteb8KUaT92LkUTtaRqeCBlElrsesq0Y4dblfT
	INgE1MOzGhkzeBki3E9voSW/dqnleTqUFwwNpEG3UZ/x+uLE4Zf/ABfJfglxMkmwj8oLbVw0cjq
	gchibkAYFoEoCRMK4l7juJML2zXtgukDCwEvzZLKJM=
X-Received: by 2002:a05:6372:a743:b0:3c3:cb39:669a with SMTP id adf61e73a8af0-3c3cb398792mr17162832637.73.1784715143594;
        Wed, 22 Jul 2026 03:12:23 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3147e1c9289sm8012662eec.29.2026.07.22.03.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:12:23 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: bryan-bt.tan@broadcom.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] misc: vmc_vmci: Fix potential memory leak in vmci_event_subscribe()
Date: Wed, 22 Jul 2026 15:42:13 +0530
Message-ID: <20260722101215.76680-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for struct vmci_subscription (sub) is not freed
in the error path when have_new_id is false. Fix that by adding a
kfree() call, and moving the read of sub->id to a point before freeing.

Fixes: 1d990201f9bb ("VMCI: event handling implementation.")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

v1->v2:
- Moved the new_subscription_id assignment to the point before the
  if/else to simplify the code, as suggested by Vishnu Dasa.

v1 link: https://lore.kernel.org/all/CAF+opq15TtOnHaLvYr0TH18sCDEPbTYRTsFZMcyjgvvLd_ARkw@mail.gmail.com/

 drivers/misc/vmw_vmci/vmci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index fffe068a26eb..c3ef3b98c432 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -179,16 +179,16 @@ int vmci_event_subscribe(u32 event,
 		}
 	}
 
+	*new_subscription_id = sub->id;
 	if (have_new_id) {
 		list_add_rcu(&sub->node, &subscriber_array[event]);
 		retval = VMCI_SUCCESS;
 	} else {
+		kfree(sub);
 		retval = VMCI_ERROR_NO_RESOURCES;
 	}
 
 	mutex_unlock(&subscriber_mutex);
-
-	*new_subscription_id = sub->id;
 	return retval;
 }
 EXPORT_SYMBOL_GPL(vmci_event_subscribe);
-- 
2.43.0

