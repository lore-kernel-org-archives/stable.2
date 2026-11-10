Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323656;
	b=D8MMu8W4ITvW2nZw8H0Cl2x7CzwvwuiuCCXi6aLiZFwjcxKeRB19FzJ4M+JDdc2iKBnp
	 zc9qdxN4xhE5pOqrJvL99xA+2LJksYUl+AjXEtmogO4PB9X9V84N9F4Gl2X2X9XZ1fbJw
	 Imu4yZSlySaCuWdNKHz4r2KkdQjE5q1p5O9NyZutX4woiWnYwr6g2QwfLhatUMy3nxrpa
	 Za309N3AGf49i/lMZ6M9myixksPKaN+7MCqC9XTvQAcI0m0x/FwJobij2QjbS/dMILOjA
	 TP9gok4gfcacCcOPwICoQN7hpEM++hxZbj/oGp8biSJfycZtDrqFH9t7XCkite6nYUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=C7mcOM+n5OQpUfop9CP8BUGmScJoc5ssQWRuOnotN9Q=;
	b=Vzr9TbANsFHeSSyxbrEcWRvKSS6XgD6QnQNS9rMdKXdkFTNZD+46gKxlTvN31a+nR11q
	 mc3eV17JZgpOdRJJ/pGzELQRFYMEQ2C/8MOhHCpXvahMD8pjVURbmjqj5pezFvkkXlEW/
	 oMLeHG8vQt3WjJ18e9MHquq/zCD24hveZoOXI6E8gFcd78FHOaDmuo4YAvFRsu/oYlAbT
	 UiqI4C7YJOdFuiLEblRSHyKTuMOj19zalz6FH3wIuEr112GZmhG9JAALJpDUyAsmGA68f
	 MyL6c4EMqrTyGODcqXYropnF03brto14TeN/1yigV9TTTIHX8xZX8RoGIvcCyOPhVDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQtkm1d4;
	arc=none smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC560A2635
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ABC560A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQtkm1d4
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-675617e81f9so1992505d50.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323655; x=1794928455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C7mcOM+n5OQpUfop9CP8BUGmScJoc5ssQWRuOnotN9Q=;
        b=UQtkm1d4FoNvK0Zsa+dWzOF7EgInHiEfjTI/iU0wl6bhOF/jOcC3kECFeX4k8ehaSR
         I4QMLoLGWLnSzxIc54xVCD+sjucplQTn+z0Z+QqdWk+7nCYJwHdy7zfRwbiFmizJyz3x
         B3JiyNzzP66sOfP5xAMJcOS3Nz5KsCJfWwkU9yvFlE/6swtd7Jr56QOhRmkIkAi6nl3k
         MqFwcriSpMNGKcJ8Bd7OKKjf6Gi+pKX+bnb7rA9uftEC2fWY/UZoC0GkxMcRftdKY7Eh
         NeT/GOJTWS4TAVsJNAU25m9MbbJOB/m+iSXmL4vD+9aFeAEg6OBWvWhjQyXPKbp+Bmb4
         q/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323655; x=1794928455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C7mcOM+n5OQpUfop9CP8BUGmScJoc5ssQWRuOnotN9Q=;
        b=sMvpJP7P/1o44zrEnxrxGaScIo87HR4vJctF4MhXF+woMHw8bXZp4yLyKYmy9yDJhF
         3o+xbkOkQ+AiXGhgOvIjJ6V5cz2hW3UoM7lOnYNrEjg53r4vZn8IS+6Qlhsr50fVfCRQ
         QUNwnWcd1UOrSrAquD8Ku58NGlgm88oW+urAqrX9oG8NmnJgtyfZIWs5wUV7usj8dF1d
         1wxmmdGZusopEXOY+YWDjRhgPlbRVj1QFsmaryskccXpxC/MDhdUevXk7DAZnhJd/enC
         72O6nKTpwq2re+OLWyksw2iNoilxymu1L1lRFR8EJ+dlIb1wox1ioEdfxVAAz7ye+rs3
         4fFw==
X-Forwarded-Encrypted: i=1; AL+hErHRN9av3Zdzuat+blBCkfpCmRoCqcVUJzDvwxl+S6dF7+lOyvnN7SDISAlPvZhjHrlBhkgewds=@vger.kernel.org
X-Gm-Message-State: APuU4Z9eql1urO45nBiBIb/2JiovFRRFiSHcJZbxzjQXWhXI4utTV8SB
	4WUYKvb6wVuX7OxbW/qKomE30tdCW3UGmmFfP96/7HQnFk8kcltzqemF
X-Gm-Gg: AYBFou3xqNZFPPISWEdTdbpbLR/JZBEv1IHxy4U7a85CnBTAq/PjVUNbw+YtFH4tHf4
	b2aKNYbzgA+fQjfzjRkU5sSFa7p1Vn5uvS/XBkVSiXh+HNNF6/azaAf56XDePHzYWVO+o+RYFzg
	PiobjNOCOkNuWNH4200f9Uagul17bGZyK0tPMUubAvTL1UVbmx8nla8oZIq3An63YgB1iBKX6yn
	uK2zjmkenWtF5eNK361Bxftyv2FsYLkPkWWFzF3Gn/985U6dEBMAYIUAGbbLpuVWoohbhCn8Wm5
	2ZrxSKANgW390XwztxgaMeQy0j5SvCWk4oZa17Ylkka9LmYUHD9qmgaJ8PlgReCLm9hTJh0sTtn
	JewvMxjxG6idCtW5pmj8QyRHyUzvZhKCMmcESbqbEFJe7zIlKBn2R1OOoHz86+DXbZ/2iegaRBi
	kiyvRf1++IJYl1Vbm0u4hemdSzh2NFoyRHSHbyMQEDqQY7Wi43EZUck8fES6UxFRsEhnyL2STyJ
	uPNkcXr7RhZu8oItcUFJS0HOkb6IIW+DZ127RpEudSmMCeQX1o0bSiBlRhjlHtSaq4LRSklpfBx
	Se7Bgv2V24KbqiCQytoVakK8snXruiL+8lGyufwf32+EjnrM6jymFrBVDmh6KMJcZbAjFuNVNuD
	1Ka2vdfLcO0chmV/1mUgF2492wU5oa9FnRGVT
X-Received: by 2002:a05:690e:480f:b0:679:b86d:6977 with SMTP id 956f58d0204a3-67c568b644emr1317770d50.73.1794323655270;
        Tue, 10 Nov 2026 07:14:15 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c58a1f11esm2086933d50.20.2026.11.10.07.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:14:14 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	willy@infradead.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	ryncsn@gmail.com,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] mm/swap: skip relocation of tableless clusters
Date: Tue, 10 Nov 2026 07:14:07 -0800
Message-ID: <20261110151407.789960-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110151407.789960-1-nphamcs@gmail.com>
References: <20261110151407.789960-1-nphamcs@gmail.com>
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

A stale reclaimer can reach relocate_cluster() after another allocator
re-isolates an emptied cluster and drops its locks to populate the table.
The cluster has zero count, CLUSTER_FLAG_NONE and no table, so relocation
can free it again and dereference NULL in the DEBUG_VM empty check.

    CPU0                                    CPU1
    Reclaimer                               Allocator
    alloc_swap_scan_cluster()
      cluster_reclaim_range()
        spin_unlock(&ci->lock)
        __try_to_reclaim_swap()
          swap_cache_del_folio()
            __swap_cache_del_folio()
              __swap_cache_do_del_folio()
                __swap_cluster_free_entries()
                  free_cluster()
                    __free_cluster()
                      swap_cluster_free_table()
            swap_cluster_unlock(ci)
                                            isolate_lock_cluster()
                                              swap_cluster_populate()
                                                drop ci and outer locks
                                                swap_cluster_alloc_table()
        spin_lock(&ci->lock)
      relocate_cluster()
        free_cluster()
          __free_cluster()
            swap_cluster_assert_empty()
              __swap_table_get()  /* NULL table */

Leave tableless clusters to the allocator under ci->lock. This also stops
a stale reclaimer from returning a cluster to the free list while table
population is pending, avoiding the resulting FREE-to-NONE state cycle.
The existing cluster lock serializes the table check and relocation with
population.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-203018@kernel.org/
Fixes: 07adc4cf1ecd ("mm, swap: implement dynamic allocation of swap table")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swapfile.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 32639f65f13c..9fd62e4ca7a0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -815,6 +815,13 @@ static void relocate_cluster(struct swap_info_struct *si,
 	if (cluster_is_discard(ci))
 		return;
 
+	/*
+	 * An allocator may still be preparing the table.
+	 * Leave the cluster to it.
+	 */
+	if (!cluster_table_is_alloced(ci))
+		return;
+
 	if (!ci->count) {
 		if (ci->flags != CLUSTER_FLAG_FREE)
 			free_cluster(si, ci);
-- 
2.53.0-Meta

