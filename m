Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693591;
	b=OksKIlsDEhXI7yGnbDauHDHbidJvGZvNJeqVDRtkrYYgK8CQ0qI/pyz01GoIbhJUNkUM
	 A3GcAsLt2ShcaQP1Gy5q4KcgVgt0tx7f7e5h8dP9uvX0Nu3TFVFA2Q8SZh5q2DLCheH93
	 0sjp2H52AqdhWAsSXeVMi9Ax92f5r+4Wd2dair4GRxAi/OVCMk2yu17e+XNaEG3Fx5ReA
	 nZyH0+V2PKn5ireaynusLZtB2gnEaaVPl4iF6hluQD1F713rk6ul+1BtvFDLbKLVMFXfj
	 1p1cFyz7usPpF+hUATlBiNv6B5zdePg9BhwLAgbtVnKSBjrYei0AreQAgn4QLiC2pFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693591;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=vJHelf8yRuovwrqUmX6IiAQ6WiqwwkheFHbp4XKwlVQ=;
	b=VBSjuGkM5LV0k10UGHH8T/tBVosBI8C3cH06FYqWKAHeVitiG2lOhwCu7NnPJuCTsLz0
	 m4stQnkhTMTLG93GraJ0Hb5JX/rpZ8m58cfU5O0AdsP3dSQcZPIOJymmgEUD0j6r/g/rK
	 t0wbQ/pVF0mI6Xt0UHhMnKtr3ZxJ2nqqjt+Z1ADFWoVHwTWaKYi5AEOltS48v61LpzsWE
	 mjtBBT6PyHVF/llN6U3bx3f/dRJZ6pdcsBwuxZ54AkmOSgcUwUyP8W7Q/CKWqs0g9Wn0G
	 Tkyl4qp/0mayuNOL39LPtTu1cAKycaO7DwK6455G0U3PHvwzQ/S3bO86TWunEQHyVHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gdoP8LND;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623A606A324;
	Tue,  3 Nov 2026 08:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E623A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gdoP8LND
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vJ
	Helf8yRuovwrqUmX6IiAQ6WiqwwkheFHbp4XKwlVQ=; b=gdoP8LNDIyPJ5KMpBt
	R5Bg1FkLSV+Wwf2FEWxVn+kfIz3YnItvgY62xltuIVNhab6zYtFBvfgIHaSFe7wd
	/8D+VtqZhTSLLg+hTiBxEUaO7PRs3G2tUew7zc8AX+JNrX/pUUiaN4mVdMF82fL/
	/BT/OasCbj0Rdaw3IfD1+n63A=
Received: from mm (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn93dYl+lqnSU_Eg--.1168S2;
	Tue, 03 Nov 2026 16:12:10 +0800 (CST)
From: Qi Xi <xiqi5703@163.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Qiliang Yuan <odys.yuan@gmail.com>,
	linux-kernel@vger.kernel.org,
	wangkefeng.wang@huawei.com,
	sunnanyong@huawei.com,
	xiqi2@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/migrate: fix softlockup in do_pages_stat() with huge page arrays
Date: Tue,  3 Nov 2026 16:05:57 +0800
Message-ID: <20261103080557.1632382-1-xiqi5703@163.com>
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
X-CM-TRANSID:_____wDn93dYl+lqnSU_Eg--.1168S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1UZw1DCrWDtFy3tw4fKrg_yoW8Gry5pF
	Z3X3y8KFyrKrWxC3WavFyvkFy7Z3sxGF4SyF1kJ34Sy3ZxJF4ak34fZ34agrW5tFySyF4S
	qr4qk34vy3yY9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcXo7UUUUU=
X-CM-SenderInfo: 50ltxkqxqtqiywtou0bp/xtbC7RsRR2rpl1t1BAAA3e

From: Qi Xi <xiqi2@huawei.com>

do_pages_stat() walks the user page array in 16-page chunks but never
reschedules, so a huge nr_pages can hold a CPU past the watchdog
threshold on non-preemptible kernels.  Add cond_resched() to the loop so
long move_pages() node-query calls yield periodically.

With KASAN and function tracing enabled, a move_pages() node query
(nodes == NULL) over 10 million page entries (~40GB of mapped memory)
reproduces the softlockup on a 6.6-based arm64 kernel with
CONFIG_PREEMPT_NONE=y.

In current mainline, only alpha, hexagon and classic m68k can still
select PREEMPT_NONE; stable kernels older than v7.0 still allow it, so
the fix mainly targets pre-v7.0 stable users.

Fixes: 80bba1290ab5 ("mm: no get_user/put_user while holding mmap_sem in do_pages_stat?")
Cc: <stable@vger.kernel.org>
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
v1 -> v2: describe the repro environment; add Cc stable; no code change.

 mm/migrate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7bdcdb57652f..6c2371020cc5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2545,6 +2545,7 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
 
 		chunk_offset += chunk_nr;
 		nr_pages -= chunk_nr;
+		cond_resched();
 	}
 	return nr_pages ? -EFAULT : 0;
 }
-- 
2.53.0

