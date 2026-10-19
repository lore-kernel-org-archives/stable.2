Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425979;
	b=thKrOlN66jcOme7yY8q7sxCHi4b4wtDq8sWuzJvRX5YmYUFzG8EgjJDyZTvB59rOCTvj
	 E++ANeCls/iZI1rfGsxv12ANYevFQnhythFKHDB3GrN4yJvnQparRsmD1Ejtb/oHtVCtv
	 2ryCQfMcEPvVyXIBmVhwAgcq6mfPA4TXlUJ7B0yUf+BzXNYTaI0Ol/14K9T4HH+DLFlIA
	 IIok7ioUgthaL/ywmrkk6X+TVAE29i5mhTNrtl6NGkWU31nFz4/1W8yaxfbSBL0Ry/tCU
	 G8eCFUMPmXrLDZB3O0Wb+zBqh830obQmcAMygock7lLTuOg6gEUMp38KkUOsam6zmsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E9RGSCGYGB/E4l/ib4WPi1HDJ9J2vhJoK5I5QF5CWgQ=;
	b=ImoKj/OPMh/DWhH26Caj+jNGnNeLJt73gICvK0gF6Ks7n63nPI96I8pBShAnLylyuuyx
	 zPWEM1Ztij7LScInWxlF63XOZIYcVl/CwuxfTxqizMuSdaqhFEFgfZUWpnq2cXvmgiDQW
	 ws0SEgDuuXrQnj9Y2LHFQcMz+8waWfXjLUebc02sAkFUOYYakqf9GqmC28pxz5e8pxai9
	 848ZkAGi44bdUKb8MI3BJxObretWzJg0U4NEvDpEseV21z3i3n8XxOvBoXJbbGtopDsiw
	 PR+yo4/mm/WdxztW8qAWRGuT7Bkk3wvkuztUOIUZwF8Hc7Rm87hlV+bPpdCIR27Ftsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y2MnjJrb;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054C606C140
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 16:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8054C606C140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y2MnjJrb
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6cfed5dd083so1517955eaf.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792425977; x=1793030777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E9RGSCGYGB/E4l/ib4WPi1HDJ9J2vhJoK5I5QF5CWgQ=;
        b=Y2MnjJrbBJCKovtMHLJtH3hpqjQjmfVqwAmhFBeDoUXTASqkVruRoBOgZHtP6sXcYH
         9ZS7JZGko1kTba/F7+m+cEx6nR3M4Z/5RFveUB1ReKsrrWZOxZ2qEEeJnIZfTqurO0l5
         3J4LkEr6ysMTNansy7E05s6y8RPUVtJ/By7nzBiDPHr1hS1ujxwXm28AymkFC2iGy4Rg
         QqqDTus/+Z51w+D/cKzBe4kLAoLrc5o1RWixuUX5kf923hOCacjOPF+iBf5kYrX2ElZN
         Epa1vyOgzSHh+mvVqrPd8nPF4t8JpDjMZ9T6CNrhl8VOenNsUcYH5WG9QaZ9cByBuDse
         lihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792425977; x=1793030777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E9RGSCGYGB/E4l/ib4WPi1HDJ9J2vhJoK5I5QF5CWgQ=;
        b=hZcbkm8NMnfLeTBpCYf6BmK3hP0w5M4d/lPsafwt0aNVUs+Thy3jSG3uDPI9N0Jw5Y
         O+jz6ruTZy8IuQAdr2OiUYBD88pcE8C0hGkcbQCQLnKN/9qqzI1gaUShLGTN1dmMT69C
         Sxp2rtLDS1DqGlOdqUWBPxd2gAxzqY8g7lY7fuB/v2Nt2rFoYRbFidGr038eW4N8LlnB
         ALxVYo7ZCGgbaCF9qVbkDLkkJSlYEdrWEdkNxS9e1cUe0D3Es4FMjJEo6h89E6lEca0r
         KfIozg/DUYTZR8X5of1kh18wx/wS71SZwtHrif1n9XvZTGUA//a6KUJsgzeBELDpcvgw
         cFpg==
X-Forwarded-Encrypted: i=1; AKwUvBxEWHwSm7w/B38ZqcjfltNZ+jvFxNfTLJy52gZ53hjczclR/TQIrg3ZDbb/qbyXl6/EyPEzgSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKQvjyb7E4xwCyuJqk/9peBb0mEpVgtHbnur6uVCtxkhIVYy5A
	jc4+4K3fT853EWPwdc6Sks7xMeVgC9fJvzoM7vgfHrjiYg4uxN5N78MO
X-Gm-Gg: AYBFou2gOnOxWXrYE8QYGl5lk/YQTn8et1bD/6d67NjbD9GXwgdCmMygrEbrmQzoLTG
	UL8qTYm3xrmrP2Rj6pW4D/FT9Wz06i/kNnKBWi5rttdl6om8CPOI9Ljye5kLiY2WS41zGhD+Opz
	Gh3RtYfH6WbPSMhSXsXUJF7FGVSnuMyM14x1CsI3Vh6MmVySRr0nFB5FIrhbB7j8brspTfWaJfy
	1xmBbwNwoFu39MjdZuPnW2OYI2wbz6MQMBHEer5IErGH0R2dsSTb8R/IBIT/FDJtjdChvJ7wp11
	qzhw3rBKps0kM7w+X2VLlDVPu6CwCYZicYvVQ6939Z8376ng9wld6WpjHmsznqoqQRKvaG9iy4v
	T+ZVju83SyhzFWV/zZWBXPGN+ilLnZlUafP0mrKaCoUJgskd2BBor9uRGsbE2Z1zgl4WqkfPm8+
	Wklmjrnv2jP870g0cP7h47+sNtbNc/Bx/M7naMOkOKMQw9UANbRGQWFVTWTtl41Ns27kQtbpBXP
	tpSskyhEJRdEXdT4frrb+5MUmiOoMMtG43RqLuWybaa857kYFMYyGQ+INFJSZtmP9f1ymAnixiY
	WNtIFQ==
X-Received: by 2002:a05:6820:4b09:b0:702:31a1:9049 with SMTP id 006d021491bc7-70356aa41b7mr5416083eaf.36.1792425977222;
        Mon, 19 Oct 2026 09:06:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b63cff2sm8248666fac.7.2026.10.19.09.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:06:16 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm, swap: revalidate populated clusters before scanning
Date: Mon, 19 Oct 2026 09:06:15 -0700
Message-ID: <20261019160615.2348500-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
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

swap_cluster_populate() can publish a cluster's table with the cluster
lock dropped. A cached allocator can use and empty it before the
populating allocator reacquires the lock. The resumed scan can then
dereference a NULL table.

For example, CPU1 can retain a cached cluster offset on an SSD with
per-page discard disabled:

    CPU0                          CPU1
    ----                          ----
    swap_cluster_populate()
      swap_cluster_alloc_table() fails
      spin_unlock(&ci->lock)
      local_unlock(&percpu_swap_cluster.lock)
      swap_cluster_alloc_table()
        rcu_assign_pointer(ci->table, table)
                                  swap_alloc_fast()
                                  local_unlock(&percpu_swap_cluster.lock)
                                  mem_cgroup_try_charge_swap() fails
                                  swap_cache_del_folio()
                                    __swap_cluster_free_entries()
                                      free_cluster()
                                        __free_cluster()
                                          swap_cluster_free_table()
                                            rcu_assign_pointer(..., NULL)
      local_lock(&percpu_swap_cluster.lock)
      spin_lock(&ci->lock)
      return ci
    alloc_swap_scan_cluster()
      cluster_scan_range()
        __swap_table_get()

Reject an unusable cluster under its lock before scanning it. Relocate
it only while its table is present.

Fixes: cdd77f84d966 ("mm, swap: consolidate cluster allocation helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c3288910b3e3..988b7316e0a1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -981,7 +981,11 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	bool need_reclaim, ret, usable;
 
 	lockdep_assert_held(&ci->lock);
-	VM_WARN_ON(!cluster_is_usable(ci, order));
+	if (!cluster_is_usable(ci, order)) {
+		if (cluster_table_is_alloced(ci))
+			relocate_cluster(si, ci);
+		goto out_unlock;
+	}
 
 	if (end < nr_pages || ci->count + nr_pages > SWAPFILE_CLUSTER)
 		goto out;
@@ -1010,6 +1014,7 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	}
 out:
 	relocate_cluster(si, ci);
+out_unlock:
 	swap_cluster_unlock(ci);
 	if (si->flags & SWP_SOLIDSTATE) {
 		this_cpu_write(percpu_swap_cluster.offset[order], next);

base-commit: 4dbe24720eb3811563cd56b35d87ddf3f9beed2a
-- 
2.53.0-Meta

