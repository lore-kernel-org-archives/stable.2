Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712C1E9B3D
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247884; cv=none; b=V9ACM4haKwcQnMAOGFDgEfeIzUDYzAMfmD+L/YAlVp97qnFj8uIM3VPXmG8psp7obIN8kjLQuZgtlJgvF8uJyPKg2Uet+MfXhS+InxVgPS5DfUxFVEGTmPvgJorXA1D/g+eTP9abYdC1cR8ZyAX61ukxsVILYhW4K6iJZiFg+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247884; c=relaxed/simple;
	bh=YWiHtTQfrKouiI2gIV/LBxL6/4x6FzP7KHrPoXsozeI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UQdKTSpGj8P4TARerB843tUjN1L3uH8+roy7qHtfkbBtdRt3P/8jxstFYxePxpCpKwYhIqcMAkkAPJXHijV0hQ1w7+JXzFwnQn0v1LhPPJvpH51tPIsE7PwK0tUHmWNzVc5BVKx/0GYDZU8BMyvAIoYk9Jv4GNyLOyolx3EO9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5s0NrAm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5s0NrAm"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cce14a21faso19484115ad.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784247883; x=1784852683; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3BZOgadh0/WAQnS0GZRJ8uTk+OHst0wqYuvkCMlhb4s=;
        b=N5s0NrAmgBqeRVsTpenwjPG7gDJrH9TWE7heWeSFzPSoRsN5C3M+XqpKKlQSa7ld0J
         QTnlpa0lE13GGU1YU2ATZEPeQ3l5c100Nlu+oIpFyODaXjIjNFGCGisnnVlJISyAGOKC
         DFsjzJGuKmd7DARbMKTjDyB+RshT5Ss/IJ/rj/9/HGOng+F0+KfrNxnPRMXdydD/isJ9
         /jEScbFttqP9T77X5VqgOE0RMKu34mhiuykFN0gHacdDxUx/aYUBUXMgdJ3fY0juwxFz
         Oo1GQkcoIQpYX5FFde2HxBywVUF6vn6dMPfjvCxfgCWh4vmpoqqPNb4jDO8oN092rhEi
         imjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784247883; x=1784852683;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BZOgadh0/WAQnS0GZRJ8uTk+OHst0wqYuvkCMlhb4s=;
        b=mtpT68HkiCshbJT5Peu7ap1bzfTPXXzpbQ5eSdeV+mUyhGgATQZtaCjIZFlTEYObZ3
         VqPnJUc4yw2ET7xMRTMY51pETkCo8XZnn85UYh3ykZzBWKaQSnzDjwof42UZ3UWAEzur
         ndahyy0tCXqcOBSTw4dBZQr36d9bK1xE/WmIRlpb/vpzl+OERxpxzzuNC++TLoSmYbKD
         8Ij9LKqREQ9o5inkYfoD0aabFF4No03uLlkbno2r1fop8ykXF8Guo7yA7rJFoc32AQxW
         7SOXo5+hKiePCFhF87EY/AAfQUGS3eQFs2dlXycWDQFAjCE+P/WllSbivxz+eTTTDvmD
         v9sQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBekrxCANx7sEQYtAXJetV8zgDY/vD5G6MVl/vG2kRssHn9nn39ZEA5k5w6HldlyRezd7IP4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2XD2AqsQrs32fJJ1gAAjJvdAF5pQyOv8aAe54VK56Sd4H71ng
	wPzHZR3W48eqHBAWp5RqjVuDrOrI+IRCheOHniPpOjeKhrYwwLhZhFNoioG4IjNxwMP6yk6r42l
	GqQ==
X-Received: from plhv17.prod.google.com ([2002:a17:903:2391:b0:2ce:aea4:5e73])
 (user=linkl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f683:b0:2cc:db7a:251
 with SMTP id d9443c01a7336-2cf1f2561eemr47925045ad.2.1784247882515; Thu, 16
 Jul 2026 17:24:42 -0700 (PDT)
Date: Fri, 17 Jul 2026 00:22:20 +0000
In-Reply-To: <20260717002311.681748-1-linkl@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717002311.681748-1-linkl@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260717002311.681748-2-linkl@google.com>
Subject: [PATCH v2 1/2] mm/page_reporting: use system_freezable_wq to fix UAF
 during suspend
From: Link Lin <linkl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Link Lin <linkl@google.com>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"

During PM freeze (e.g. S3 suspend or S4 hibernation), device drivers like
virtio_balloon reset their underlying virtio devices and delete their
virtqueues via vdev->config->del_vqs().

However, page reporting work (page_reporting_process) was scheduled on
the global system_wq. Because system_wq lacks the WQ_FREEZABLE flag, the
PM freezer skips it, leaving page_reporting_process active during
suspend. If pages are freed into the buddy allocator while suspending,
page reporting invokes virtballoon_free_page_report() on deleted
virtqueues:

    [  196.795226] general protection fault, probably for non-canonical address 0xaa1436fe70dae6df: 0000 [#1] SMP NOPTI
    [  196.825967] Workqueue: events page_reporting_process
    [  196.831038] RIP: 0010:virtqueue_add_split+0x233/0x4c0 [virtio_ring]
    [  196.927073] virtballoon_free_page_report+0x3a/0xe0 [virtio_balloon]
    [  196.946943] page_reporting_process+0x370/0x4f0

Fix this by switching page reporting work to system_freezable_wq. This
ensures that the PM freezer pauses page_reporting_process before device
drivers destroy their reporting virtqueues.

This aligns with the driver's existing design. The comment in
virtballoon_freeze() states:
    /*
     * The workqueue is already frozen by the PM core before this
     * function is called.
     */

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
Fixes: 924a663f75e2 ("virtio-balloon: Reporting free page reservations")
Cc: stable@vger.kernel.org
Signed-off-by: Link Lin <linkl@google.com>
---
 mm/page_reporting.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 7418f2e500..4dc6f4b852 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -80,7 +80,8 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
 	 * now we are limiting this to running no more than once every
 	 * couple of seconds.
 	 */
-	schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+	queue_delayed_work(system_freezable_wq, &prdev->work,
+			   PAGE_REPORTING_DELAY);
 }
 
 /* notify prdev of free page reporting request */
@@ -343,7 +344,8 @@ static void page_reporting_process(struct work_struct *work)
 	 */
 	state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
 	if (state == PAGE_REPORTING_REQUESTED)
-		schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
+		queue_delayed_work(system_freezable_wq, &prdev->work,
+				   PAGE_REPORTING_DELAY);
 }
 
 static DEFINE_MUTEX(page_reporting_mutex);
-- 
2.55.0.229.g6434b31f56-goog

