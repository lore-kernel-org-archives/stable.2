Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C273B7B7F
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698511; cv=none; b=S2cemioacL1yDd/qKGGjweupI3D4Z20JcPpyWrbwtLBqhN9kqnuzhLkNEG7t1qmSZ8Vb/flaNUf4LyfXE9mYrWB4xSrJq/0RPvU/ZVs67Rq6n0wcrAn5pAUIO0t2k29QOTI7lHJbY+IGR5fbzY+CleRvwCUzoqxUMtnq8nao4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698511; c=relaxed/simple;
	bh=TSlhaoHt056EG01KMjT4sa2DRPkJIycjVnCyNR/78kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oTw1FiK9+usu4DdGQfBFIVzDcLAiU7Bt5vlCU91+SVIxWQRTHZyMSPHpu8TAKjCquCqD6lWUcW4FYZwy8iPA8obUOGq+udZcpb3CLTGF6Dqk+XWgPe2KaDHZgdC3kRJV1jjsQwDVkAQ05B/klUwFKMybZUfQjQJv/PjwP+YjAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=gClRRH3o; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="gClRRH3o"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc1cea4bfb6so64225a12.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1789698502; x=1790303302; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=75MOn+8Kpp1iMZpcq17k9pp4tVm/EJnw36C6hjqHAdo=;
        b=gClRRH3oH/0dsIVnjUsI2HRVYRNeqIO79qCisS/ajWM5QrGBPLtWLsWy1kDMve4jKl
         hxNhjfakRL3QTNjYfeta48mSkPvD2dRdlVI3o3F7M8sd1eYpz2T8Bnkn1lsDXvjCcKp6
         +vypVM11/+RlH0Y4uVqz/3w992zj3wFkaAQ8Lry0rKOWR3c9HPlHpyW/mmN9QclpwLkY
         CtCLvgth4QHg3MJd7PYiM+5Tj51cmUbGUNu2pu3eJBgbzun24iCTSC7Ih06UxkT86zz4
         WYFiPPm8xuS7zJoAr3c4WHw55HbLnROMSlkjQ+t6h+kLNb345IzhZsOlfFIw7XMIMalO
         YgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789698502; x=1790303302;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=75MOn+8Kpp1iMZpcq17k9pp4tVm/EJnw36C6hjqHAdo=;
        b=0G7JKESpRsuCtlvffKIykrXw5BWVcnTDhj7E3q0k9FkFVRkzF3J0z0ZkHcnic+zJ45
         Rd1zhotlvJhF+wX0DvlwQBJ24tuIBHIN6QUjy31P1XldPqTZ+fZrR/UbVwjFBeExUFO9
         ueHtf2OtxNgZb6pS7XtL5dIROVbZlFFpswY+KvSbofR7RPJCisc+hdp19/VqocwVm7ep
         Sp99/cGbEccgh0pj3pk26UgMRvbSODEXcQD5A1L0R69AUua57dkAsT3+KM0PMcWhyySC
         p2WM4o+gWYOcat77l1HC0KPxNxCf7buh8fmv9PFNg6R/Klqc0FldTrG57K55EnC121EL
         JhZA==
X-Forwarded-Encrypted: i=1; AKwUvBwdsdexhGAZT2+XpJsTPzTQ2Hs3Nv37FiFcp05zxM8QZEWOF3Nb3Jzm0oqiyQuhkUA4plG/vAo=@vger.kernel.org
X-Gm-Message-State: AFuF++nNNSdpFcI6Su52i/XOv9smaGf45AS7qZLcaWBvqe/y3cFQFSSZ
	UxQeoBGe+hLHEA4j8sJT/XHcBPZdOUAJMWJUhbI1bGgHvqDNGzpxiV/StuBy8mNh+xg=
X-Gm-Gg: AYBFou0b5knMvI23eav7ryHPkf1ajEumIDwrCsTO/oSpJwbVB1zjiFOdE5mPW6O3/25
	Bu7VUj5ylPcp+p+hgzgjphGKwBGr8UR++g9gdKxfHchTbC1844Zh1w9JsbSFVyJuOJJ1oypVzJz
	Y9+hlK1QZ4gn+yMx+s0Ndy/uZ0Ex4Fq24xUCeHt4Tfi1i+XYpP0CxNxubkx4LA3sV09RrSXjrtI
	hOtlPcXzBuMCeqF9qSqAv/blmidG+YP9CVZFJldnCMS/mqX7PAkVqEhgNQQrUDbMkVZSEE2/8Oi
	4RuvKSM/kadBXijh6yeRXwM63t1jnqdiq21UpjELb7qXm0jK50q5tilAu4UudVEhTNj4qrVyQx+
	l2k+PG3iwxXnGVsj3K6USvdyHutFFOAU925keEpRy+Glj/QnnXAK+prIe0nCxwA229k1FJIbWL0
	wOn7YVAXLl9pdaHShpW8UOaDisAhMiuEt/zpFKRCsLsCI4UYQXEeMbGzNrWd96n7o6yZAgwuUi/
	qc17zUbODT9
X-Received: by 2002:a05:6a21:e584:b0:3d7:b3c1:cc34 with SMTP id adf61e73a8af0-3dd8c41a56dmr1477664637.26.1789698501950;
        Thu, 17 Sep 2026 19:28:21 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c28723c6dsm251393eec.14.2026.09.17.19.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:28:21 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Thu, 17 Sep 2026 19:28:16 -0700
Subject: [PATCH] of/overlay: don't pass the changeset's own id to
 of_overlay_remove()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-b4-of-overlay-remove-all-fix-v1-1-920441cecae2@nexthop.ai>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAyF4auQrm0yQ4iCVzEuytCRmpExHSQSw
 t2tunvfW/wbFFbhAudqA+VFiuTJ4A8VhJGmG6MMZqhdfXSdP2HfYI6YF9ZEKyo/bCKlhFHe2EW
 KofWuYXJgiaey3b/85fp3efV3DvO3Cfv+Aey4M0SAAAAA
X-Change-ID: 20260917-b4-of-overlay-remove-all-fix-9fafc8104ea0
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko AI <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789698501; l=2070;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=TSlhaoHt056EG01KMjT4sa2DRPkJIycjVnCyNR/78kc=;
 b=ahKQebfVELI4uwmP8Kd5EoQqoH+iJVv59cuX1yxk5zcLN7QNFhea01Xoi1+K2qopXD6Rp8nzY
 gFulJHc0tqWDTyQRZrhtRClVjXoAYNFUqYktzz9b2tjGtTKtI4lQPN9
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

of_overlay_remove_all() passes &ovcs->id to of_overlay_remove(), which
zeroes *ovcs_id once the changeset is reverted, before calling
free_overlay_changeset(). Through the aliased pointer that zeroes
ovcs->id itself, so free_overlay_changeset()'s "ovcs->id > 0" guard
is false and both idr_remove() and list_del() are skipped: the
overlay_changeset is kfree()d while still linked in ovcs_list and
registered in ovcs_idr.

Every overlay removed through of_overlay_remove_all() thus leaves a
dangling list node and idr entry behind. The next ovcs_list iteration
or idr lookup walks freed memory, and the ids are never returned to
the idr. Nothing in-tree calls of_overlay_remove_all() today, but it
is the documented API for removing every overlay in one go
(Documentation/devicetree/overlay-notes.rst), so any module user hits
this deterministically.

Pass a local copy of the id, like every other of_overlay_remove()
caller does.

Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/20260901014554.83A8D1F000E9@smtp.kernel.org
Fixes: 24789c5ce5a3 ("of: overlay: detect cases where device tree may become corrupt")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5 [Claude Code]
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/of/overlay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 83c56dd9b5d8..f66f16cddc79 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1297,7 +1297,9 @@ int of_overlay_remove_all(void)
 
 	/* the tail of list is guaranteed to be safe to remove */
 	list_for_each_entry_safe_reverse(ovcs, ovcs_n, &ovcs_list, ovcs_list) {
-		ret = of_overlay_remove(&ovcs->id);
+		int id = ovcs->id;
+
+		ret = of_overlay_remove(&id);
 		if (ret)
 			return ret;
 	}

---
base-commit: 21c89ff1fc86ffa517f3a9ca1ba5c48e9e37c1ba
change-id: 20260917-b4-of-overlay-remove-all-fix-9fafc8104ea0

Best regards,
--  
Abdurrahman Hussain <abdurrahman@nexthop.ai>

