Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB30387348
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746201; cv=none; b=BA44zRs0oU/fyUHT4KhQ7Qjrh2p/HXi5e2cgH7w1Z5VuB1witJ9n7y0SrksbCUuPS/e8+Pt+kyJQj3ff1FIGE1zh/oVrJidGEt6vvmcibIY63PVagJHPLAUeUlfFZLwDuyFES3EM0CPmBB43q/xrFc2Ug7PgtfIN38DtpkFd+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746201; c=relaxed/simple;
	bh=mqSJttTdo+n0mPl2WuY2VUEG5F4GmpsRn26cLo+5jQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gEXwdm4Le4lLvuDeNvmo7Vok6s3y6lWoj51JbABzRjQF9MV3osUHnCKK9ZEh1eHFZvLCzg94uEs49dYngXh2RPfXTR/il8fSyOn1zacHi420hn2GynzryOY6bQMMUzU2vHZ9bgx5cTKnaJVi7Yo486X57rZ+rFu4CjTLh5P8NJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBc3fJtZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBc3fJtZ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-930f72317a6so82220185a.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786746199; x=1787350999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=08sUbb6fujQhCY3IeGKjx4yAsK5SOx6MmNZ5dS/j5Rs=;
        b=oBc3fJtZmDpqCxlciULifR/NG/jzZdNIF3cKZJL7qbsvGjsCF6PQBMi1wVxC/zSapg
         wWNIOEa6ZpeQ62eO5lgm6FbwXwDCkpBdHkeeG0cL0nwB46Oz+qHNw1X7FlaCZCb79mWa
         sQ2hn0s0IdHko1TZIPlKYXSd6/fLhNY6rZ4N3YeHulvgBxJyS/f50MpNS2tRSXf9br37
         T+yox3jI2b8iBGRQFMTB9mz5313Cg/Uw+ml6neVDtgyGZv13P2BguV98tXwWtqL8BfID
         hIYY8wmmIJw8q4iXYXXRDG14roaZcYlFzTLqT1vn4WN8gQYnl2kbUG3ZdpnvajykHgRA
         iCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746199; x=1787350999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08sUbb6fujQhCY3IeGKjx4yAsK5SOx6MmNZ5dS/j5Rs=;
        b=azRxK6pBb8Efh+yE3UxBjcCw5T4HjZpNuZLMrFxFW9GZViWLeWelud8u0k6MPfqB/o
         XzmPETGtBXpAhPz/NaWf2TSMt4gOdpG22f1yl33vwa3EYGhkdP4Tnoi2OzaenDVnSAkm
         23pomaOlMomgjkh0CKMdcMRQkW8SUdNQLMEoqjZGFvcBploQ2j4yZLS678cUesyseX16
         A/aBzZ2SF85BK9Tk0mGJ0ymxbB69GaJ3MS9t/fb5+4LkkeVvFUd22EAy7t52zXUtorsS
         dClvmPgiyOb0yFzVce8aImP93IC5SOp7pJ5PWlPQnZDtUztGK8w/f/mhy1VCPTpM+cdZ
         XKpA==
X-Forwarded-Encrypted: i=1; AHgh+RoIQNS4iFwqtd0iKWH+mnGLaLJdmKurRbFLdkI7R3JuC7wRNIVsK4jL2serB62iuOJ9gAnA4Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgv0gdTl2XqaD/q6EaKztCo+Xn/Wec2dMBvRsiHRltQxXlxFt
	wbu3y1rTD8NrsAz5cga1dkf28t0smjlCjkTjx/BsHEn343db86GDVpSO
X-Gm-Gg: AR+sD104z9reNsTMOck5bTUGAYPpsO2j4wYJFCCGky/j6IWAZcNeJSd8sAYEPpU5BTi
	KPtFG7iB/P6zcBLykPZhBQlJUZGs7MueOteXSn0SGSfC67INXY+dLk/oo1/hefs85OPMRQucPo3
	D1ty4gg0SJWpvecxQ2zf+eALsNqhHwpQAq4XwaGD2luG/vbIG3ELq36s8OdEJCC9xVL1zQzTtkK
	41lGYlxfm1zZ6DOe4y2KuIwBsQhY4M2+OrHfWg/gJHnjSuDyCKe3boMjpL3OVI9XzhkZ3dJ7Pvx
	1O5qa2fxPxHlcyzLwyFZVF+5c0ILUnW0n1Qe93sa8v+AbCSRmylR0UZT6oqRWs3nzkWUd3WbdN9
	MEXmNkeQRDNGGwb5pu8qK+i/8R/6wG0rpV1lcp4ijyjX6C5DGIVI2pVuayy057cR8oU73D531JH
	cRuK2vxwCQA4dPQ97ef4YzSG3ammO/cmlz3hhG7HNmCc87SX6QLGxZRvLkdaRn12mUKETYYkPe4
	SNYc8dZcgWz1saSzg==
X-Received: by 2002:a05:620a:2804:b0:915:9fba:8794 with SMTP id af79cd13be357-936d2248b7emr1070690285a.6.1786746198687;
        Fri, 14 Aug 2026 15:23:18 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce1ea6cfsm381481985a.27.2026.08.14.15.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:23:18 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.scally@ideasonboard.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: uvc: fix use-after-free in extension drop
Date: Fri, 14 Aug 2026 18:22:54 -0400
Message-ID: <20260814222254.4104235-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uvcg_extension_make() adds a newly allocated extension unit to the
extension_units list before configfs attaches the item. If attaching the
item fails, configfs unlinks it and invokes the drop callback during error
cleanup.

On this path, config_item_put() in uvcg_extension_drop() can drop the
last reference and free the extension unit. The subsequent list_del() and
descriptor cleanup then access the freed object.

Remove the extension unit from the list and free its descriptors while the
config item still holds the object alive. Drop the config item reference
only after all accesses to the extension unit are complete.

Fixes: 0525210c9840 ("usb: gadget: uvc: Allow definition of XUs in configfs")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/usb/gadget/function/uvc_configfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 70a1415ea401..86facba5109f 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -1256,12 +1256,13 @@ static void uvcg_extension_drop(struct config_group *group, struct config_item *
 
 	mutex_lock(&opts->lock);
 
-	config_item_put(item);
 	list_del(&xu->list);
 	kfree(xu->desc.baSourceID);
 	kfree(xu->desc.bmControls);
 
 	mutex_unlock(&opts->lock);
+
+	config_item_put(item);
 }
 
 static struct config_item *uvcg_extension_make(struct config_group *group, const char *name)
-- 
2.43.0

