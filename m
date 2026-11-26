Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661114;
	b=E3uCDUDV+Isz3dWRyMC7mgOpINqdsMk4RKZ4LDMmXUYB+t6ZmBdh22azaXJIIGPG+b+h
	 OxrAQXUT8cA9tMpUgh7GEmSGJHonVEi8z076qac60nPk9KXJCyw/K/IO/HdV1xxWilqBt
	 SOgYTiHvJqjZxEGtNVqKpHZYqd6RNXtCor4crtG/IdibA5dmnX6BL/rCcEf5cx3PUj6hK
	 dx063plU8JJwIUwKR6vQNPLMBVnHenzcRh1WxYjqrBUrmFdnxuUp1zA4A5D1pW/gOgX5X
	 Scr1roOB/bCUPSoU2Y0v4HfpYc4gbibkaCwADEVfBT9x06Vssi4TQQj5Q5SrF/F340g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=p0ugNHKyD824H6jac9/myF97YFILT0FDr+3mqDSlt4g=;
	b=GPe+BsYCWdDzV6oYzdtlJeEazhy09jf0H+b5wyQ0WlAcZuCKiW4hPxsp2clk/CCQ5ptu
	 kN8kF4OB+Yu1+gg1tC+98hBqU3zOMLUCoQj1yIioB/4ape2YTCrEUJncOMo75Zo4p1lDz
	 3jz+4smM1xy0r4IDiAJg46iagF4q35SbcqTDbkljpgy79aPnuW1ktBVMIWo9ydoJbJpk4
	 9XbpotIdjOSqon4jguzXODyO2VRL3Tx0GoTH8dWQgGZT7kGV2UJgY8NpQw1DaXr8Y9Xct
	 6A7aMI05vikwqOZxHvqxmUptAtEof2NpbOwoLNp1qL4iJz3kda3KP1hoAyqWkJbIhYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=QpBPWmJU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1624606A32A
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1624606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=QpBPWmJU
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67db35e7953so6674311d50.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661113; cv=none;
        d=google.com; s=arc-20260327;
        b=E8tHdystkezwxFv8l3de4lIXsmkdFhAeRLt0Mghb/PvsnUAzs8m5kaVW7o/JVGxZSu
         ZJZlEk2tPRf62R/wB1r69DM2LGrcUgNDKJHN0RSN+9KodMYpHC50cfwQj+JWKTUCkwks
         EEUDd/8ETeh25dbMlpPeyqgCQiD8l4Kff90IbviOYrzKwfePAneQiZUm5+4k9YB4qNGm
         oZ7zfp8tUizxk3aL+N4mpzsj7b5E7YhcYytvUFVgKI9rlTNI78L/hPxFFf5moc9JwsCh
         41pyxv+Y28rjCIRifaKoX5rDT+EVm0AbaL/5eNV4x974EJUbKb6UWtcXdKh8LT4VO/Jp
         adbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=p0ugNHKyD824H6jac9/myF97YFILT0FDr+3mqDSlt4g=;
        fh=Cl8p86fIxraTdAPl9TMEjG1uOAHTz1nspTZpzog1E7w=;
        b=gUpFkXlFVxlZilUfZcXTLZZivpEJZYOTJACjDni1vMHB7UMAG2bnmFVRYhPd55Fk6N
         RERtmjie8qTLGhqmHuMEnCfQ/+QKjV7TU6D/gBb98tL1UQX+QzJns4Wore/ikXoBsXUs
         +6b9rHbnOA1lXkbmKJS+LYGLceRq0oDuDcPAAOpR8X89JNyZMn7ch3999t/zoamRzanJ
         D5yUHiNhlm4iGsOD+xBAj1P7Uj4pryn4VY14+4s42LJ5UqqaP0lAJHrxfwEUEamL2CSg
         s7dtehKgR5VcMa7NrdELaALFO9a/eCuZPIdmSexT+d1n1eO28KYl3TkBTajlsqHTkl06
         FRYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661113; x=1796265913; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p0ugNHKyD824H6jac9/myF97YFILT0FDr+3mqDSlt4g=;
        b=QpBPWmJUXlNLNkuOwyqfpJRIaX6jYUCKPr+e8UvE7vZFajPjgSDr3vi9KJd3kY7UtZ
         A6iZ1J5AnVaIR22305yZ1+IenJd6/dwwTzjnG9ewFiFTQixJuegsEDlzzWqpFpKfuWio
         erZKRuR/0ZvkXj4Cu7DHFuc8i447rIkTYbJzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661113; x=1796265913;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p0ugNHKyD824H6jac9/myF97YFILT0FDr+3mqDSlt4g=;
        b=GXksKiPPCcmQnnwlTiXTccYCxITj8RvcdGUGEmn1fhz//xQtKhvnFRY/1j0PSr1gks
         y6uOmJr2TSzQkIl9cyYySNtfCSBHnw0RMn8EOz6t7TAX79RHZBbUTavnBQJtpSpfD5Xr
         3AG1heCw08fxFYvODo6TT9Op6MrPtOaBaNz9seFzp9/HDoVDomGWdFAXjF3ke9lm03AT
         ESH38Bha2OxzfoXwyELqwTAEyzQyYI0IjAvKO4MeU4drOviyXRIbmDQyh0qee6uI3xgh
         NNSZzj0whNj83zvN07dNGGftOlrm89vGpF1N/x+Tw3iuaH1L1HtuXLYa7AKmdsAGQVIk
         vpHg==
X-Gm-Message-State: APuU4Z8U2dLwcVakccC9RcLAPoo9Hgxvu+NIYsgeqruVORw0Km/HjM7Y
	Lz7f8vgO26G7W5eCy+jqSMzowK17tEk6zVHKgd5PFlxNZgWPeU3lXhJP4jLnN6huKlozCj6RWfm
	XhdaMMd67l6almXkiromnS+fgJmkbV+OzABDpesB7zJitWhJvNLsya5o=
X-Gm-Gg: AZFdTZfhNIcNmsuIhOhylgXjJv71DRCT+PcUP51wdPZjXJVYUtU4cLo8HN5FFUKbGRC
	2KzYQJw0S04Sa71lebt6iogG2OsBO/bFxAeB8b04G/UtZoFdMeu7L7+PmqEDrIrMIUUkwrSLK8a
	vTc5rCH9h9t2a2eAf4TvUe+zZyDGZ9/N+kIpoT4Mpc3FGkIN8SGxahl/bA8Z1OyizJ9mCP9mhd6
	/bTt9qM4bW0rHbnVAWYBPsXjJ52eAHVL29wSmO3zUGk1+V1sLgFRQ8OV4Uxk/+Vt/AbRERfJoaZ
	0c2rsLi4n7yKzQlnQ0esi+YLH8aV2zZDxb/zDZJOKGeY6JebB27hJA3r+2nkhX7yAOTKqP0E8Z8
	Om4v6m4iX4g6mKQQWMYDni0sjfrSduBkpfJb7Zp4iRIjsBYIL9c0BDYLVTE92uhnpaY5X69E7dN
	mpuJCxGD6JuiJBfvCWzuFSCTvWrooYhosStKYo0Qx0QjKDrq12pO7SgPhyaSVjckzNooSNmWYLd
	ksRe5xJ8loLYQ04ze3aBUzMfE11DFhIguUl
X-Received: by 2002:a05:690e:419a:b0:67d:b673:101 with SMTP id
 956f58d0204a3-67df44dc404mr5165849d50.84.1795661112974; Wed, 25 Nov 2026
 18:45:12 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 18:45:12 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 18:45:12 -0800
X-Gm-Features: Aa3M54pIe0_40ib3Wr2ZZ2KWGpKerFTo6l3_rNQezi8pNSta7xAy8v1Ghx_XCsY
Message-ID: <CAFaZ9eopsb3vgcpzOjiZ500oafv02QzNV3dEUrvOMN1vV90RuQ@mail.gmail.com>
Subject: [PATCH 6.12.y 3/4] virtio_balloon: factor out virtballoon_quiesce()
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: "Denis V. Lunev" <den@openvz.org>

commit 29536a923a9412812eb3e378258019b54538a220 upstream.

virtballoon_remove() stops all of the balloon's asynchronous work (the
free page reporting worker, the inflate/deflate and stats workers, the
OOM notifier and the free page shrinker) before tearing the device
down. A following change needs the same teardown from a .shutdown
handler, so move it into a virtballoon_quiesce() helper.

No functional change.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260624140846.2616797-3-den@openvz.org>
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c67b29e5f799..726aef5be178 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1121,26 +1121,39 @@ static void remove_common(struct virtio_balloon *vb)
 	vb->vdev->config->del_vqs(vb->vdev);
 }

-static void virtballoon_remove(struct virtio_device *vdev)
+/*
+ * Stop all asynchronous balloon work. The device must still be alive so that
+ * in-flight requests can drain via the host before it is reset or freed.
+ */
+static void virtballoon_quiesce(struct virtio_balloon *vb)
 {
-	struct virtio_balloon *vb = vdev->priv;
+	struct virtio_device *vdev = vb->vdev;

-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_REPORTING))
 		page_reporting_unregister(&vb->pr_dev_info);
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		unregister_oom_notifier(&vb->oom_nb);
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
+
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update = true;
 	spin_unlock_irq(&vb->stop_update_lock);
 	cancel_work_sync(&vb->update_balloon_size_work);
 	cancel_work_sync(&vb->update_balloon_stats_work);

-	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		cancel_work_sync(&vb->report_free_page_work);
+}
+
+static void virtballoon_remove(struct virtio_device *vdev)
+{
+	struct virtio_balloon *vb = vdev->priv;
+
+	virtballoon_quiesce(vb);
+
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		destroy_workqueue(vb->balloon_wq);
-	}

 	remove_common(vb);
 	kfree(vb);
