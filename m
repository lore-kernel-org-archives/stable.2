Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2F349CDC
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964004; cv=none; b=fNn2es0l7KCjjlyCwoepO5AEi/UwvdQ7E9xYDd3cIjdzI8bIH/jhDgw3M2IF2viFxsR89I0kDWBE70uwMHieWD2Z9RhzkJDvq0mpqt311aNeXzOEtOKE04wV5i6XOBZtNiiGKDh2Fbcn9In12heVx+8YJPfxrzvcyxpjFVGKeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964004; c=relaxed/simple;
	bh=DX4yD1fceAw1TE2YJq//fl5Ld5WZXHMoH7nz+I58P6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmRfQmTeBHKUjT6V+6At6oazUOQrYIBByzSD41OPWhRqjrAZ/GWD5O9NX0OGulrQIKfGvseobjDnl7hof4WLsOxwn9Zj9c7WJcOJMwbUXvko4jYfznBIaux5feWcdJ4h0Xg2yzqKI58//yDlIEaGb9Rwd5Jf9xqebOgdoa0U+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNRc07qe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNRc07qe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783964002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8qE4a9Od404gw/x9tLPMScB2hPPKwyyUE1M5NWdqvd4=;
	b=UNRc07qeKXNyWpa6zpkMeGYIXk4GZjjcB/L+arqZu/QqabCMrSK4dsKXkf7BT2JLXXBuin
	EnvefZ2F5Uqhob2JYG0/vtKSLB1ddshyvBBp4MiqGJn1Dk8WuZjp7Mp1c9/Q527W2kh1Dt
	Up++2YKP3REsz18+qd1Xe6mCuITVKR4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-zH5eTQK2Ns6yNU_X8H0m5g-1; Mon,
 13 Jul 2026 13:33:20 -0400
X-MC-Unique: zH5eTQK2Ns6yNU_X8H0m5g-1
X-Mimecast-MFC-AGG-ID: zH5eTQK2Ns6yNU_X8H0m5g_1783963999
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC408195609F;
	Mon, 13 Jul 2026 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.6.23.248])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17E661686;
	Mon, 13 Jul 2026 17:33:18 +0000 (UTC)
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	justin.tee@broadcom.com,
	sarah.catania@broadcom.com
Subject: [PATCH v2] drivers: base: Remove statistics group if encryption group not created
Date: Mon, 13 Jul 2026 13:33:18 -0400
Message-ID: <20260713173318.3060047-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

If transport_add_class_device() gets an error from sysfs_create_group() when
creating the encryption group, it does not remove the statistics group in
the error path.  Adjust the error path to do this properly.

v2: Only remove statistics group if tcont->statistics is non-NULL

Fixes: bd2bc528691e ("scsi: scsi_transport_fc: Introduce encryption group")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/base/transport_class.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/transport_class.c b/drivers/base/transport_class.c
index 416e9f819df5..351c3d3ce6a0 100644
--- a/drivers/base/transport_class.c
+++ b/drivers/base/transport_class.c
@@ -168,11 +168,14 @@ static int transport_add_class_device(struct attribute_container *cont,
 	if (tcont->encryption) {
 		error = sysfs_create_group(&classdev->kobj, tcont->encryption);
 		if (error)
-			goto err_del;
+			goto err_del_statistics;
 	}
 
 	return 0;
 
+err_del_statistics:
+	if (tcont->statistics)
+		sysfs_remove_group(&classdev->kobj, tcont->statistics);
 err_del:
 	attribute_container_class_device_del(classdev);
 err_remove:
-- 
2.52.0

