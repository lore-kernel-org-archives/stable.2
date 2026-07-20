Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581C39BFE1
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549365; cv=none; b=toDiDdecGToGrIf+Y9msP9hoyOLMWXqQuEIuPDQelkQmKL+/Xc9gAZDVvOL9S3RxPKR2lsdEDr3Oa4JZJ/xVaBKenVo5BX4Ua3Rxm39RCO18mFrSHJYYqhJJKpoHLNtIwJBwNG5rdBXbmmOBR/dtxgUnaJPPeM1vlI4A/b+yKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549365; c=relaxed/simple;
	bh=FRfkHxPsEAD8IWsYmO1umBKwlvTr0WaVJzxvcIY2new=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tLaFytMEaHgUkSr0u7GCc4c+8HSy343bUIljPK/MKPFZHDy26Tefi1jupOJUhjPfnjqOaqNudoiQzA6nqr3Xm0HDDE/ug8wofbOm2FgWj3gCu+yfhXIX61VQ7y+BJsOAhBcjixoBp4ZbDMMoUq3bPK93ZbPZWPHlRBpgSIU+i5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=VhcleCls; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="VhcleCls"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8486672f03cso9905250b3a.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 05:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784549359; x=1785154159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uRnYHwYM2fL3oV4HDL3np+Jg5FTK6wxzvLlmHP7diCg=;
        b=VhcleClsU42KNQqckwGMgUmBBdlcb/eb+SJlB8cMxrFHEudULjcRXE6XBWKvEOwptM
         fStuF7ocK5CMIIKSlekDlFErChZuGiLqQniSZ5OgQu2TBQ9V1ssl+2zKHMdZOxYBJrrv
         34dGfwV4nwDbQdsAGbpW8F2vGCxfdZyKUaWiNFEWMVCUhB7KpGxtZP3gYXUELXjwsX45
         7ilM4IuU5xWs7EjytVEjUAn27q4W5RQ5gYpKQdQAR7ygN3wSk8tIvgYjohGY+vaxWwhG
         B2ZoqV9+uXr40Bb6F4nKDXeL/Zx69YT2viGGi8rFr1SePjUMc0ZEdWhSzlxw+tRYlnBY
         q90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784549359; x=1785154159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRnYHwYM2fL3oV4HDL3np+Jg5FTK6wxzvLlmHP7diCg=;
        b=Db68zUosj6DO02HDzlbhnd0Ci0Ahz3lPxxWRkxT9/VUeY0lsKJZlnZSzlXtxNkSBlQ
         MtuY3NT84C4TkjcvCxub285coQtFNfra1rIA0wBGSQuYZDs9VwxXaaIs/eape7EA6V88
         trbc7FHQnRNQGwI8sNUm0aoeEc+jbmFiHg0OnCjQJbd8/ia11yhDyZvPTlR2kmFS8kqt
         9WZEOyn85JW68xKvOw8tedjo8NZlY1usOifVUZ8jRh3DluR+DglGDjhBaJfZUuvTrL68
         Mn2C71r3Wc82kKC8+leYk6AD0VuZX8T4k+2VIhUX19xaNsg7/rheFF/i8WI1I5yoNcB6
         pIXg==
X-Forwarded-Encrypted: i=1; AHgh+RrlhhCGuhyhSdYjWKTE2OBHwbz1nxnsZJLAoNx4vuwJqNnwQAmPqmY0R6T7iYndrA4WCBfkF7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV0EFh8BwqE+Acvfsm/zmwWAj1qYLe9eIqvft39t3ClT0/l7B7
	xZ8q6zQ7jniZZ0oUEmaWK6BaslcIKeFnTwON6xXAMc5nDD8NQrACLXtff+D0TZHGDSLaTZaBj8W
	Iz9lXVQ2K2w==
X-Gm-Gg: AfdE7cnHxHwnYydyjfr+mRVYE70HurNScu8OPldbE+vOOGbxmk/Yb2mgFRGqELdNpJM
	RjaAZRvkMRSOfRf28WhpmWShuHBLlWwZX+VnaPoMNqpmMsg3SJSezJ2kEnRUYDVtTogzTtOD13B
	WCV7BEYH3uecaZAzB4ePudQJFMD7pju0xUh53X1yZcKDDSWmGLcd2sTvoMPz4m7bWRUUCRqqMZG
	ANM/9XrKCc7cXqkyxlywjfQ5cAJgCVCzoTI5uVLAvaqnVQktE8LyvKN4HQLsEiJ+Q8N+mzoOU7V
	oadbqKQTA4z7jCPXeD4J4bBLcJ94ytmqQ3hEyj5AJ/NSlJuQnYcEbkg/Y1xuFlKAs0CkRMLIfK5
	Fnq73yHrW6+yVSMIhDvHWj2H4+hUDlWwrKLVsbwgpIRJ96aXOFv9WKeLqZDu9ymmehr5+mrSOXi
	lVW2caeev1DS3nfaVWH6sS+0v1/PJTRrpgeA8iJWKmioCKrYNP/SWlVCitNWXOYydrNPjb4/3hI
	j2CYlv/xJn2O45EkivCegnrb/MzGmuQ
X-Received: by 2002:a05:6a00:4d81:b0:84c:4bf4:10c3 with SMTP id d2e1a72fcca58-84c4bf413fcmr4991521b3a.38.1784549359461;
        Mon, 20 Jul 2026 05:09:19 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84c2abe3e23sm5554162b3a.0.2026.07.20.05.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:09:18 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: bryan-bt.tan@broadcom.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] misc: vmc_vmci: Fix potential memory leak in vmci_event_subscribe()
Date: Mon, 20 Jul 2026 17:39:07 +0530
Message-ID: <20260720120909.80019-1-nihaal@cse.iitm.ac.in>
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

 drivers/misc/vmw_vmci/vmci_event.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index fffe068a26eb..a7f7363c577f 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -181,14 +181,15 @@ int vmci_event_subscribe(u32 event,
 
 	if (have_new_id) {
 		list_add_rcu(&sub->node, &subscriber_array[event]);
+		*new_subscription_id = sub->id;
 		retval = VMCI_SUCCESS;
 	} else {
+		*new_subscription_id = sub->id;
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

