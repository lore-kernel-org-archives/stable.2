Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFB449EB8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752308; cv=none; b=P6S+jWKTdxvKRZo/xhfYOggUnXlTXyqFimpOWQgYty8dWqf+88iM+f6RoJAWXFXCT4Ws0oANUa006m4gcFHzCYJyUb4ArdB/eD/clok8lUi+C9AXFseMJQFQ6AekanGiz1K1selfBE+T+dtxD/ANtv4QRLS7yd3oUh+UxEnAGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752308; c=relaxed/simple;
	bh=THALjTc2ekV/VHBl1pTdNAPYfaghOcuUvvpw/9eRGgA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gTj+SiSbxOmNPoIvOULBYH2R96Xxb4XSXITjInZ84gI5CfDEf9QQDzsQWrrxg8hiSpBsKzVhJreV12k3k1Yw2JZuXinSs2bXLepufgK14SvvHBmPfx0GaHFRu8erpajpAiQYSMEypD3Ay5+qMI7KdWqsjlKSAz18A1rXus4rlXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRIZVxkc; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRIZVxkc"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso5304227eec.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752304; x=1791357104; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QxYDyqZ3i76HSJhOHQLDltbCWIhkGa5sofn3Lj/sGzc=;
        b=cRIZVxkcTr3jAJwjFAYh7HENQFx/yiV3I4K0HK0au9DTYwGAfHKDy3aivhQ0P2jSmo
         jeKCs/HlE9y6tOjA5k0jH//oFLypaGZsydkwrNqFxT/0Oyu+v56x/W7H3g5Se4Q5sI2l
         IK6R/qeYe8WqDux05xt/a9bQ9NkjweUmwea7tc2aSem448AJF4t569B6F8/BxgJoQbiq
         uxQL9zBeoV7FtymN7LaZ26C7sx9mQCovhBPJow0CnYY/NnanTk+fCxOldcruUK9lLmAu
         qY40gxQGDKND0i8wCjm4Pq5ZIPyIhLmPg9s4JeGrCvtVBi3fLxxzLeilEcyAtZYPY7tC
         P9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752304; x=1791357104;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QxYDyqZ3i76HSJhOHQLDltbCWIhkGa5sofn3Lj/sGzc=;
        b=Oh4oNPN3/b1wr5C16hhSq4BfiHawLv6csOHhubjjtmsIJ14VbYrYYdYgD5zPgl/CyE
         81JjyH5x+jBrPT0LmUi0NlG9gngCFjvQfoNXIiiFFgxFm/h6Y8fR3PWuEOIxzm+zAD2F
         KfDkDE/09tJx70Na6POGc4Orwc7Amj3YvJfQ2ze0I597lIf3uVJZmPjZln+3wDrOdMgl
         WgNKTV21t/qU0r8agFOl793IH+3juIbayDyq4FGt8OlbE0UP2wR8TpqBMH64L8LKDwmt
         IoEiBdSHtMAGj8IEleYZfidq58b1k7+XpGcWEGe318CHTyJSK4RKecURVd8NxgXnl3NY
         0YMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxexLdxr1M5zaEAOMgBtCRrSyqzPAsgHDM6eOsg9RjI+pPRFCS2efdwrFvIVD+96wmvfcUDLHc=@vger.kernel.org
X-Gm-Message-State: AFuF++kaU/wMqk9W4PIsi+XTb5BpbYk+S+a788FCyIr27z4508Q+g6V8
	UJZSaoNeBVfy85cGz9sMZeHiCmAdZpmW4qh75+sJf/m1DW3oU04Wq5ND
X-Gm-Gg: AYBFou1yy1lqODFwN0lhLqiX8CpqpaeQo8LiFRj8CV6+IPA/K0QUWgo4BbLUvMsr9xH
	yRCDuC1QUzcOXNh0oay1c8pF849qTC5KGRP9ozTiZAoJBlwVPmaxTAh0eAXUwOG0pKCU3ucycPw
	bZSEUgohdnouQS0vu6N2M3ei0lfMXoUjkjvRsvJ8gOVYOzivac9oAURelnEq4hYeV9YPV8033fc
	vCMy0UCql19XnjlO6j1/YjpoooyEZU4pSafhJE+RD5dDiNUF5uyV+b65KIoYIM1nsFgFq2qHrGb
	EbybBgvjSddXQnizbe8yMUS3wpmKWeymzvCmlHpYK91PmNs2fmoGOEv+uPsXH3RM52nWLnZg81z
	656kMeNJCm0R211fF/E4I5JbGlI226CWq7FCsGJm1rUt6hRRh1lZyVolvkDBbTUWC27fauuH3Ag
	D+b5eHWuf+T4P+3k4Z6m792FGq/hSurYftPG7XhJb3w8Ql/YKcWSZB7lacmpwr6rw4Kw==
X-Received: by 2002:a05:693c:42ce:b0:315:9d54:6bf with SMTP id 5a478bee46e88-34cdb1fd8f4mr678342eec.10.1790752304018;
        Wed, 30 Sep 2026 00:11:44 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5b4349bsm1621837eec.25.2026.09.30.00.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:11:43 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH v3 0/2] ext4: fix shrinker scan budget accounting, plus a
 related cleanup
Date: Wed, 30 Sep 2026 15:11:36 +0800
Message-Id: <20260930-fix-ext4-es-scan-nr-scanned-v3-0-9aef0be87d21@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACi2vGoC/43NwQ6DIAyA4VcxnNcFGEPcae+x7IBQlGTiAoa4G
 N996MnTslPzN83XhSSMHhO5VQuJmH3yYyhxOVXE9Dp0CN6WJpxySRuuwPkZcJ4EYIJkdIAQ9xn
 QwlW7mtZCOGksKcI7Yjnf9cezdO/TNMbP/iyzbfufmxkwaJhVinPVUqPu3aD962zGgWxu5ker+
 W3xYjmBykknW9Wyo7Wu6xcJ6pqrEgEAAA==
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, 
 Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>, 
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Zhang Yi <yi.zhang@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This revises the ext4_es_scan() shrinker scan-budget fix per review,
and adds a small follow-up cleanup noticed during that review.

Patch 1 simplifies the fix to just returning SHRINK_STOP when
__es_shrink() frees nothing, dropping the sc->nr_scanned computation
entirely (Zhang Yi and Sashiko AI both pointed out it added risk
without a corresponding benefit: do_shrink_slab() discards
sc->nr_scanned on SHRINK_STOP anyway, and computing an accurate but
small nonzero value could reduce the SHRINK_STOP hit rate under light
background load).

Patch 2 removes __es_shrink()'s locked_ei parameter, which Zhang Yi
noted is dead: its sole caller always passes NULL.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V2 -> V3:
- Drop the sc->nr_scanned computation entirely; just return
  SHRINK_STOP when __es_shrink() frees nothing (Zhang Yi, Sashiko AI
  review).
- Add patch 2/2: remove the now-dead locked_ei parameter (Zhang Yi).
- Add a Fixes: tag for the commit that split count_objects()/
  scan_objects() apart, and Cc: stable, matching the equivalent jbd2
  fix.
- Re-measure test data against the simplified fix (429 -> 238 calls).

V1 -> V2:
- Correct the comment and commit message: nr_scanned == 0 is not
  only reachable when sbi->s_es_list is genuinely empty, also when
  every inode walked was skipped or had nothing currently
  shrinkable. No code or test data changes.

v2: https://lore.kernel.org/r/20260929-fix-ext4-es-scan-nr-scanned-v2-1-f4e8f6f6b8b1@gmail.com
v1: https://lore.kernel.org/r/20260928-fix-ext4-es-scan-nr-scanned-v1-1-91d88228b0c8@gmail.com

---
Qiliang Yuan (2):
      ext4: fix shrinker scan budget accounting in ext4_es_scan()
      ext4: remove unused locked_ei parameter from __es_shrink()

 fs/ext4/extents_status.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)
---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260928-fix-ext4-es-scan-nr-scanned-5af70744f6cd

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

