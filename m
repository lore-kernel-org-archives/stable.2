Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315019;
	b=ul/ZulfJ/yIKH98KfXxnm+23qRfMIYD0u4bLv9JT/jxYAjDrGSZw9+d+etJRCtMB5PvD
	 qGGa/hg7FGKKCW3/cz+7e3w+jZfv7ynrqUM0W6zEU95jjHI8RMs/Zis//upHYRcpY/RlO
	 1ht25stYEqASelFM39M89GrIJKnzqkcf5I/fuJHrXkEetNMWfwliUvkTfNzBqcjn34iD7
	 mv4BPVVmQHDDSdFuxZLfIBdZZIvNcbfZWUSvAnXXpQsUn6Qr0aV8GV3Poegwf9L4m8djs
	 IwRhc/7UXGfnURH8VNfeDxjC9T9lOqJpubXVsMdpCTY3hd8VBC/HrVBE3insvzJKnfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hIqePvJF9vqtDiaaoJWj4mMGLwExY1SZs6wpgpJb2hI=;
	b=A2GcAok9opbHkfa5X1QjVxndJqQQBcDkRriEhg0PSFGfSQfNk/qX8NFgzaTQRBhz7VBu
	 hxfR8XW34y0H/ZZqVIZAbyATkiohR+rmPlyuyyipjvWIsa2VeUEZ5OR3++4dUyMRCID5A
	 8Bd4TVW0g0zU8G82ifvxGVb4949xNhTDj5T+8QHOnWhqadan67O1zaAg2rdbCLd4sKH84
	 LVibtHtBHA+htcvoMxUrkw+MMzwgsRPCTJvt7CECTAcDhFvLJGh9U9O9X4RKeGd/dSP8f
	 DZmpXzQQuVyrZvYgyXylX5FakMqlv6lCDx81tjaNcVfj8gKqZp/TvobpfJBvyYhrYKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IotGoqC+;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137760A2605
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6137760A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IotGoqC+
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so1842291c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794315017; x=1794919817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hIqePvJF9vqtDiaaoJWj4mMGLwExY1SZs6wpgpJb2hI=;
        b=IotGoqC+GmG2HPnZoenFwtMfa8+hS1ddNGLnLGzjf0QcmNQlfehryt8YZELOvNqyAU
         EIPz4rdTVIWYGt5P7G2457HW5qSQ4cEYKOjXx9BoxkllcA8luwYoXt71Zb0rJ+EMa8Of
         ZgZxSbx0a5NJOg08UEhgDJU5fsEVrYdShGgK4dSNbJSbLiLHyMvJ2PhDmyicgGcHOwCg
         /ofvq9VB3632C6AIp8UbNl2Wossa3ScvUZIsuJm8WWgIVaAqOCWv8LW5sXahzDJoxdzf
         RSMCElxmOedIRXNcObQaefNGpbPh2JrDNneTpwEPwbelqcSyorj+tBIP8jJe6nnlVLkd
         59Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794315017; x=1794919817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hIqePvJF9vqtDiaaoJWj4mMGLwExY1SZs6wpgpJb2hI=;
        b=JjLN1I8tSVQq/PCq/rA/yNElKTyxTfUvIXAFk00i0EivbrMePyFDJ9hrSMtFiprnYk
         zefgdVtL/3MFMU7c0r6OkpE4Fli39kluB09XG1Bq8J/IoUst5GFSRyzNRYVzg050RdXp
         IlRjtukLg1fYlDXZRWmSQe2pWUielO0jb08+2eGzFmIHBn6Q3tRQS+G3/O+e6er+17aL
         zVDkjhQHE6Ac+f4XPWQRZsBeA7krUHrMaJ33x0bWr+4wwCpd7bH8p9Lxp+2CAUatzb14
         mwAiGsoRcj+MwL06G/3Qan0hIgjg1or2M0ksbfNyFPERByZ0j0remI+mWip65WqrdNw/
         dnuQ==
X-Forwarded-Encrypted: i=1; AL+hErE5BrSo+XWlfBA4lx3TJrprquO6y2zbbACQ2xjHziYJhX0CQv36y3Nt3BRkdUDOlPXRnoiNSWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kLXM9cc1ELkH71JFw+AmiE8iBu29IkllM3z4uCkWZE1s8iyRa
	6tqG7B+Pg9AkhDHUXpuMBFBmhix71fCG6UiAZQH3zT3eqzcIX+049T3jduV8yCJyCoM=
X-Gm-Gg: AYBFou2xnfUE5xDIk48EnghHHuVjVKnKsoJyc6E0/IWyXwqfHb6iqCADNLqtKs6iwiq
	VFmCXXN4PM5eezu1mVCFoWFhMe+HSwdhsKuNPDGO+07mhxiP7rbHNk9B/Kx+mhMUvKt2VPRnbXd
	vhqXEkat3z2oRikj8IbmpcmYGw3Pp8bOLQQljLB0Jvcfm3b523i2RKzKcfnpsnIeHPbv5WK0/we
	mAM2FO9EWYnj2dLEy6V/5I2Rln5sRpyaOySLp5kJbxhy3QShWuTslG2khMR5ItGxwijBNXlSCqE
	DweHiASU6faAIq6D0VTwByLuXXsvL7MzPvk9HhvCPOCDF6FBJLfuXH5eRq3HjQHvODidRP3xD+f
	dJInGlwv7L8J95d32fK3gOTYehbLgdnRw5tCDDKKerUuoDgkvFwedwjLF2J1T6AHmdXm3lXV2qI
	SsBWu2h7wsz+neJzqnONlK1/a1Fnn8bJzYJKyfayrN7CpULO1VCEq25ujXv3dxCkZNgV+oBimTO
	YPff+5rkHc7KH+yIFyxxC1bVWAremrZl2TvEDB6a7OM4AV+B2zYlYIf4fEg66bHU2TFQq63oslt
	CGbb8nea7USFiQgGbflYh+b4vfjIfr+Df4lyUtgEa6s0rGNZFzqZd2Xi7D9h+p22srmOi7xK9cJ
	4w7kXf5AGOyOuL/oJoZWbEaH0bbPNwa/m82sXQg==
X-Received: by 2002:a05:7022:ed02:b0:196:aa86:fcf3 with SMTP id a92af1059eb24-1b3ba7b2b01mr1258881c88.26.1794315017171;
        Tue, 10 Nov 2026 04:50:17 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:88e2:4271:a9b8:cc50])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b79649sm7614830c88.21.2026.11.10.04.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:50:16 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: jgross@suse.com,
	sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com,
	boris.ostrovsky@oracle.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] xen/pvcalls: destroy the per-socket workqueue on release
Date: Tue, 10 Nov 2026 21:50:02 +0900
Message-ID: <20261110125002.46683-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110125002.46683-1-yhlee@isslab.korea.ac.kr>
References: <20261110125002.46683-1-yhlee@isslab.korea.ac.kr>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pvcalls_new_active_socket() gives every active socket its own ordered
workqueue:

	map->ioworker.wq = alloc_ordered_workqueue("pvcalls_io", 0);

and nothing ever destroys it.  pvcalls_back_release_active() flushes
map->ioworker.register_work and frees map, but the workqueue and its
pool_workqueues stay allocated, so a frontend leaks a workqueue per socket
it connects and releases - a loop a guest can run as long as it likes.

Destroy it right after flush_work(): the IRQ is disabled and sk_data_ready
restored by then, so nothing can queue new work, and the rings are still
mapped while it drains - pvcalls_conn_back_read() reads map->ring and
map->data, which xenbus_unmap_ring_vfree() takes away a few lines later.
pvcalls_back_ioworker() does not take fedata->socket_lock, which the
backend_disconnect() caller holds here - only the socket's own
sk_receive_queue lock - so draining it from this point is safe; the
flush_work() just above already has the same requirement.

Fixes: 5db4d286a8ef ("xen/pvcalls: implement connect command")
Cc: stable@vger.kernel.org
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: destroy_workqueue() moved to just after flush_work() (Stefano).  v1: https://lore.kernel.org/all/20261109122324.30134-1-yhlee@isslab.korea.ac.kr/

 drivers/xen/pvcalls-back.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index dcefa91a40cd05..d97c5eca5f3513 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -452,6 +452,7 @@ static int pvcalls_back_release_active(struct xenbus_device *dev,
 
 	atomic_set(&map->release, 1);
 	flush_work(&map->ioworker.register_work);
+	destroy_workqueue(map->ioworker.wq);
 
 	xenbus_unmap_ring_vfree(dev, map->bytes);
 	xenbus_unmap_ring_vfree(dev, (void *)map->ring);
-- 
2.43.0

