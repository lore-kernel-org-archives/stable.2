Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD428F5
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788065890; cv=none; b=o34glIU8od5jXEuU1tsLLwXJYCH4M5azsIAoqir8fTOSDDmh3Lht1py+wUSbnk+AQQerIj4GkoXNzlMnqPyY7uWtU+5HpWQedZIUHYd0OVda6NE867X5MBQg1MrWjlrYTx30vGE3cIHZmbZPw1Hbvfi4QfQyYFr6jg0SZxHF/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788065890; c=relaxed/simple;
	bh=j2reyEwkVzuigYb4g9w772HGYBd7zXybory5yurv0VM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hRP/PeNVrb8MY6l16PozbyWsDPJ7rJLc9kbsQoCfH8Xvx+/4MCuci0AS1Lb8GDI7bmUaXAo7xRJJa8foAnhY44ho3Ve6rOtklhPQn3JX5R9v3MqP00+twnj5HMJuSse1BSYxDe6x2OEO101vLuv4UgBPz8r7l3We6oPTc63sjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD4L7lsd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD4L7lsd"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d9004f39d3so4862965ad.2
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 21:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788065886; x=1788670686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4TeBqKMYh4QBqd9QGK6X+AfZ1Ew/+0qOQuZZIDYCtJs=;
        b=QD4L7lsd/Ma8FNPUNIudPoenc1CMcvc+peLNWMVkY+YhZRz3rkUWaXVrsSQ49de4AB
         Jqa0W+oEydoQyUj5UsJo/7+e0W3cJYDApN6XKU3SeoJxGo+ImMmoCP573bwYrZsRvcxG
         lzqtVkaCyAN8BiipqPWzzHg2U7mWihlJVJB7MvazMZ4QquStbSP/TlMP55Tk96xaWbHS
         VBQ49A8SqEGtAgyr95ljORrbUzrc+F6WFmjUQC3D5IdjAo/4cf54UlHmyxekY8bTp7eA
         y6VoW2GuChhV3JWDtiR+I9WsbjWaayK8VUvFA0zhoesvdfNc6JH/XzGWoej9qu5eUS/5
         NAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788065886; x=1788670686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4TeBqKMYh4QBqd9QGK6X+AfZ1Ew/+0qOQuZZIDYCtJs=;
        b=DiXePJsFLPhfOcPIE8E9W8xCsDNi8iLgL0WaF5V7P51FTg6PgNayosXTfN/Zzkq0s/
         JHHncWxnZpZ4gsPDkFAXabcZGDuHlt4RnUJnyG/7TolLUGHcPSreHPcN6DSimZxLMiK5
         fOccKxV+GfdpmC1YVjJ8WDHNGpo2i6FwaaVg1CJlA9RdiBOeExqn9o8/MYbTAOYVNQ5L
         udIGkfz0plJe2Gcd2/l2XKt4/K/k0qxPLu3O0U39d5FoigIWqZr8fV3UzLvd4oRV18gs
         Uh6PG0SB4ZEA8skS52DLj+B3fn8EHxbfTM0if810oveJeVP7liTQxFf1kyXwUCvSCkVH
         2R9A==
X-Gm-Message-State: AFuF++nvDwkVbdu6KDTrKy8Nd4Og4t/esAxY7DsbLo19155zxbZXNkyL
	ewquE2eL1r9qzBhPVqNLuwHAnMDWqCsV8oD3z6X46mxH8h1D9cB7EI4TAvxUojrn
X-Gm-Gg: AYBFou1fFkG2R6qNUAfuiWkmUiyqgeelvnLf6mADT/4BHULoCo3Zygngfg2IXrQc/ui
	91tvMjXvGBUcCx9Sbn46lBiX4pdptbxKl7D+HlV0uJ2/EM9vPVBm5+5DxlZH3ZKy9DiSEG1UuHI
	jhQq6L4WULuslgjaeFrMRLgmbwI85m1+CxeRUf6kUVZXoA9fqGrhPqh+6JrjQgI+GMIIPeHiQRn
	+0aCHvrIUZzUYG3aqFCjfQxeZt0iom1BJ9+o2a4O+o247kDR/xxXDWuXiO9AogzLXUOEjkg0qVD
	iINl3kCKSmtfN5f7k13Y4BH6fQeRkDhBRryBWfP6GC7KnxO84ugu7GcUvDdP7P4etneTmhRvaLs
	sjBA8FDJclCHvtoB/eL87wl4hOEzdbZcnYHwDIIgpG1kmCmDckWx+o9yV7fWNoM6TL/SRXHfcIe
	qgJRHXI6XbiBheI+iON4dLCnczyMxMSN50SXrAp26OXshIDw/cENX7uJ2AI+4cBehAxkIA1qbYr
	gUgwUkSF2tsyAjCbQ5+JiY4cBsNlBGySefyoC+Xy/322OvneOumnkSjnPV08g5GG7dwTABgDekh
	Nmi/8JVd7Gvtjg==
X-Received: by 2002:a17:902:d484:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2d74ddddc11mr304302695ad.7.1788065886359;
        Sat, 29 Aug 2026 21:58:06 -0700 (PDT)
Received: from penguin.bbrouter. ([200.218.229.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm21914666eec.24.2026.08.29.21.58.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 21:58:06 -0700 (PDT)
From: Daniel Pereira <danielmaraboo@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] Bluetooth: ISO: ensure no dangling hcon references in iso_conn
Date: Sun, 30 Aug 2026 01:58:01 -0300
Message-ID: <20260830045801.212389-1-danielmaraboo@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit aa9f7cb2bd3a2be998ceb739fc9a2f986eba43eb upstream.

After iso_conn_del(), ISO sockets should not dereference the hcon any
more.  Currently, clearing iso_conn::hcon relies on iso_conn_del()
releasing the last reference to the iso_conn.

Simplify this by explicitly clearing conn->hcon in iso_conn_del(), to
avoid more complex reasoning on races about who holds the last
reference.

[ Daniel Pereira ]
Backport notes:
- Adjusted the context in iso_conn_del() as 6.1.y handles iso_conn freeing
  without refcounting (kfree(conn)). Explicitly cleared conn->hcon under
  iso_conn_lock() right before freeing to maintain the safety invariant and
  prevent any concurrent socket accesses from holding dangling hcon pointers.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Daniel Pereira <danielmaraboo@gmail.com>
---
 net/bluetooth/iso.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index aad4baec9..ef31fcd47 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -183,6 +183,7 @@ static void iso_chan_del(struct sock *sk, int err)
 }
 
 static void iso_conn_del(struct hci_conn *hcon, int err)
+	__must_hold(&hcon->hdev->lock)
 {
 	struct iso_conn *conn = hcon->iso_data;
 	struct sock *sk;
@@ -208,6 +209,9 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	/* Ensure no more work items will run before freeing conn. */
 	cancel_delayed_work_sync(&conn->timeout_work);
 
+	iso_conn_lock(conn);
+	conn->hcon = NULL;
+	iso_conn_unlock(conn);
 	hcon->iso_data = NULL;
 	kfree(conn);
 }
@@ -1669,6 +1673,7 @@ static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 }
 
 static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
+	__must_hold(&hcon->hdev->lock)
 {
 	if (hcon->type != ISO_LINK)
 		return;
-- 
2.47.3

