Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945150;
	b=yO6nc8eBGSMg3HW5hgVUdJLiTlpHcJQr+Bvi0MquNHfap3X+lwBIpDQKMTzfuG5bXPG2
	 +R1saVuhOHRdKwMGC4cdslsbnQI0xWVr7iXS/yo9JfWST/Sz3UBUmWAPzzhz2q6rjhJ77
	 kl2/GCErcoMLoh00Qkd7ma2jjpUKZpqdMlYdGIudShLtF2ec5DaYHvrQf97PIuts8h2Lt
	 fk5/nNNhfA68D32BvLbNNnaxIeSLf1MtwVaR7ZlUvC67Zqo0OIwmwkPJf2fB0uVvqS/7o
	 oVO9IeYaj4SJHgDZWBKZn/J2TcaYIjA7HaPQV3rdrjJDOKZFcwBrpwiBThgYeb74F5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QYzpgT5zWntgfM1mnEHxsXKCCGNOpHFfMxgWgIGdnmY=;
	b=ZuU1ZIYU9r1OlM+wKUaPIzBe5VTdguxzBz/nDLiGysmAoeJmwlkPted2kSSHcfQVHF1Q
	 eatNUY3VxPaiDP6wysAxHLgpSW9rEYmP2TpfYCToU8oMu20hKbzwS5bRMzCJbYcqMhg+L
	 esvTaoCoEBupPIFFNMTWvju03cGlTB5aQQ6QIyXEA3XwChSUBuUZqqY1w38IWFpo7RBQw
	 om2KTJWX23LDmBv8hXAq3vjJYQWEkGw5gZBi77IhdyK6NyEEYV6+1gfRXZPlTA6LZoh7r
	 ZuHUAst/HV16XMuUylkhfyrOCWzqsxaKhHTcnTT1s8qPDkAaftEJ2TwKf0LlnZj7DHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UitchYbS;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B4606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 06:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B0B4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UitchYbS
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a60f90a924so86299b3a.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 22:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793945150; x=1794549950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QYzpgT5zWntgfM1mnEHxsXKCCGNOpHFfMxgWgIGdnmY=;
        b=UitchYbS6lfBJSDhPoHzzUIm8XiykMpS6zDi9o+dMNbpgt5926amZaAMpeFhdg2PFD
         Lm3hHkq8Th4Swk9bv78b04vYgmc0bdIcbQ62YAqrEo1Gm/mbjVsr1AoQfLZiG18R6uWl
         t+2fFaaTHNleC7ZcuWwE2+0+tglJzEL1q5sxYCl16O10mxeaGew2n25PT/VkLLHJmHcs
         i9VtEEzuUZmJwyAtRLpdfyUHX6veDO67r6HqSKfxuQiY0oQlXJdpBtRzVlVJc3g5JoP3
         LoB1LzBjEhaecbDDxmELnEnfw2TLFFRTiR2Fh9PN9sJE9ZneWDVC+GAO4VfU7YpQ05es
         Blfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793945150; x=1794549950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYzpgT5zWntgfM1mnEHxsXKCCGNOpHFfMxgWgIGdnmY=;
        b=INHjQzyu7kHzGmcEvhtGz2rvPNmR3AIhToQKqR8Hep8JsC2JS7H7g1aW9MM6wL7lTz
         dgRYd0weRXg/5cRGNj9gzr8+P5u6Tu/37G4GsxTxs+GJrPj566ftoA+IiKiK+fjB1GUU
         tvW4McvRVR5PokosyFLuQG4o9cktAZCTuWJ46A9CyTVM4mN9u6Hq4kLTbWHZqCtjs1wd
         bIKK+X+iw+vPe4ZaAfcnOLYjytigrklPDhlLkJMI8O39kOT7L2QgfIheOezYirxNLc4d
         qZFj5mHjeQVyBdoM9zJkrpHzmZzrza2dg3nh9/Fc4JqFRhLTHWOruCkMJ+lPsFVcXmv3
         flNQ==
X-Forwarded-Encrypted: i=1; AKwUvBySv5x6xWXJyibj/uNczy+b96ymLxaK0tVJCQ7wiV3SXLR427JFslBVSlML7ESUV+9IO9hu0S8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6ILlJZ71nqzV9GxBTw/G3Z/VV2x7F+hlHvHjK01hBKggEl5qX
	KR7CTQV7N1PYBEIZOy5zk+tpW2WjzqMrsLTtoYy3qAnrh/cekz4Xw1gH
X-Gm-Gg: AYBFou3zNvQhAmwLt9eAeHgbq3Vr1alTaQQjlkQnTJvF+Lx/J4YC2q3oflN+CboVoYp
	8rWGcndmQ8GWXfEVhgiJ/5FUoayeXYnXeKA/7PXadNxL3ssL2OsRHFO8U92RXCxifM0sckrxfx6
	OENkce0o/DFgg32yDOkrosSjA4s+QMCpiGQuIWLZHu82U9f/EIVokROOfLx6hKtnWQU6d1lKrDc
	qIx6lOXhGSKD4CdHAMKRqwjFaRSSDfUzPndOi+rnFPDOJmkT/1FJLnHjQOlNSmlj14+biH3PfIH
	CqtkqSzvkEADRbKoF1XdAOUGoFEXoKRQk1+rX7CU84q40C+V24zjavd8rqE9QAyAY7vBoZsmR+O
	FfgRDe2mf6NgmpNPljpAjqq7aRVBzRiyC1umIVGSW/7Wlf1/dfPSgfBsGLmfaBhWZOOQw8Wkme9
	9scLb5RRqdLkegDGac3a8ia0bFfS+cK4VDf6kEqAQlzd1XSJFzyXs7YXR/mJ/C6tN890JU5a8Al
	NUKlYNOqKk2KBiCyiVIsG3NaS86rypCYEtJKrzTtxCiDM2hbM9tEKOvprlvMWaFu+jNKdbMomnQ
	G5mM9vgB4OjIuiO+dXz8AP126MiH07mLqjkGJVaxSQ==
X-Received: by 2002:a05:6a20:9e97:b0:3eb:ace1:4b4a with SMTP id adf61e73a8af0-3ebb2addc3cmr1804269637.71.1793945149791;
        Thu, 05 Nov 2026 22:05:49 -0800 (PST)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70661c74sm241209a12.10.2026.11.05.22.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 22:05:49 -0800 (PST)
From: Daehyeon Ko <4ncienth@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	akpm@linux-foundation.org
Cc: david@kernel.org,
	tj@kernel.org,
	hongfu.li@linux.dev,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	4ncienth@gmail.com
Subject: [PATCH v2 RESEND] mm/hugetlb_cgroup: prevent use-after-free during cgroup offlining
Date: Fri,  6 Nov 2026 15:03:47 +0900
Message-ID: <20261106060347.637480-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
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

A normal hugetlb charge obtains the current task's hugetlb cgroup with
css_tryget(), charges its page counter, and drops the CSS reference before
the folio is committed under hugetlb_lock.

The task can be migrated while the allocation is in progress.  If the old
CSS is then offlined, its final active-folio scan can finish before the
charge becomes visible.  The allocation can subsequently charge that dying
CSS and commit its pointer to the folio.  Once the CSS is freed, uncharging
the folio accesses the freed hugetlb_cgroup, including its page counter and
per-node usage.

Keep the reference acquired by the charge until commit or cancellation.  At
commit time, while holding hugetlb_lock, move an uncommitted charge out of
each dying CSS to the first live ancestor.  The hierarchical charge already
includes every ancestor, so moving it only requires canceling each dying
CSS's local count.

This orders commit against the offline active-folio scan: either the scan
runs after commit and reparents the folio, or commit observes the dying CSS
after the scan and selects a live ancestor.  The retained reference also
keeps the originally selected hugetlb_cgroup alive through this decision.
Reservation charges retain their existing CSS lifetime and are not
reparented.

On an unmodified v7.3 kernel with a 128-page 2 MiB pool, a
capability-free uid 1000 allocator racing administrator rmdir reproduced
KASAN writes to a freed hugetlb_cgroup in three of three boots.  Controller
disable reproduced the same fault.  With this change, 5,000 rmdir rounds
with over 1 million successful faults and 2,000 controller-disable rounds
with over 1.6 million successful faults completed without KASAN, LOCKDEP,
page-counter, or refcount reports.

AI-assisted source review was used to identify the race and to help draft
the reproducer and fix.  The interleaving and the resulting allocation,
free, and use-after-free stacks were verified with tracefs and KASAN.

Fixes: da1def55919f ("hugetlb/cgroup: add support for cgroup removal")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
V2 RESEND:
- Resend v2 unchanged as a standalone thread for easier tracking, as
  suggested by Hongfu Li.

V1 -> V2:
- Remove the redundant disabled-controller check from uncharge, as requested
  by Andrew Morton.

v2: https://lore.kernel.org/r/20261022022146.506005-1-4ncienth@gmail.com
v1: https://lore.kernel.org/r/20261020100345.1677643-1-4ncienth@gmail.com

 mm/hugetlb_cgroup.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 3fb41311e4c7dc..6921b185726662 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -310,11 +310,10 @@ static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 		css_put(&h_cg->css);
 		goto done;
 	}
-	/* Reservations take a reference to the css because they do not get
-	 * reparented.
+	/*
+	 * Hold the CSS reference until commit. Reservations keep it longer
+	 * because they are not reparented.
 	 */
-	if (!rsvd)
-		css_put(&h_cg->css);
 done:
 	*ptr = h_cg;
 	return ret;
@@ -337,9 +336,26 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 					   struct hugetlb_cgroup *h_cg,
 					   struct folio *folio, bool rsvd)
 {
+	struct hugetlb_cgroup *charged_h_cg = h_cg;
+
 	if (hugetlb_cgroup_disabled() || !h_cg)
-		return;
+		goto out;
 	lockdep_assert_held(&hugetlb_lock);
+
+	/*
+	 * A task can be migrated after selecting h_cg. Once offlining starts,
+	 * redirect the uncommitted charge to a live ancestor. hugetlb_lock
+	 * serializes this decision with the offline scan, which reparents
+	 * earlier commits.
+	 */
+	if (!rsvd) {
+		while (css_is_dying(&h_cg->css)) {
+			page_counter_cancel(&h_cg->hugepage[idx], nr_pages);
+			/* The root CSS never dies. */
+			h_cg = parent_hugetlb_cgroup(h_cg);
+		}
+	}
+
 	__set_hugetlb_cgroup(folio, h_cg, rsvd);
 	if (!rsvd) {
 		unsigned long usage =
@@ -352,6 +368,9 @@ static void __hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
 		WRITE_ONCE(h_cg->nodeinfo[folio_nid(folio)]->usage[idx],
 			   usage + nr_pages);
 	}
+out:
+	if (!rsvd && charged_h_cg)
+		css_put(&charged_h_cg->css);
 }
 
 void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
@@ -419,15 +438,14 @@ static void __hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 					     struct hugetlb_cgroup *h_cg,
 					     bool rsvd)
 {
-	if (hugetlb_cgroup_disabled() || !h_cg)
+	if (!h_cg)
 		return;
 
 	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
 								   rsvd),
 			      nr_pages);
 
-	if (rsvd)
-		css_put(&h_cg->css);
+	css_put(&h_cg->css);
 }
 
 void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
