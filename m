Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30D3EC691
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790840644; cv=none; b=QEpxZDx0z8NL95WEvyI7SZovg6UqG1A7auJtY+lP0dMY6lnXMenqSO1KTv+yQ8mic/5I+GwcEqQsNY6SS89Vb5T3bA9De3wcD23MGuUY45UYARfW4dHXfYfacW1lTj+71LcMslVItZVzPgAGkqqLlQjdqfzN9/mQa2quY4YgZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790840644; c=relaxed/simple;
	bh=2SCttNKC7O3FocUJg55oliDoHnVOooTYv/JgB5ERAK0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qmraDLIf0nvuk0lb055k7JaA7ddt6xULLH2MYut0F9Izv939OwqiW73NpVZoSM4BquXIeUH/jOA+P0cW8HomwSeKnH0Sf+HA6uwDjsCRTLVXiMPQpEkt5CG05lxRjFelq+RVqMtDcRkUepaY4KX4Xxi7MaX1RSV+WrI2IJhZULQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=piWRvOCT; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piWRvOCT"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14e1fe551c3so355787c88.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 00:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790840642; x=1791445442; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TosNnawzDPsGc04sRZxwMHLtTq8rVKPb8WELyOmoWoo=;
        b=piWRvOCTZZ491WIHNpH8O47ceKcSSgSfywiq7uVO/f4pN/16Xgp0uisx8q9PDSjMxB
         zbBIhIP7ARs4028g19YDlmdexrIcC2qz7t+Nv5WiMDhVBfYl+SMnjo4cEcSODzIiKeoM
         UXHvRMDB1nPRIYbaMAQEMfatNrVwS97HZ1LHyBqBED2t1R2Jkdt09RRq5FjK5fp9iRtE
         r8kIlmVhMOOgBbQxMQVnOmSiC7YZwiLeS+1dps5z9h/M+lZ2U8OW6fCSD4IpamOq2CWx
         LmXdWut8kcvZ8NCL4qqrAdiWygBtb42j8G+wSAzHBXTho3a8FpWdU8XKmG2Xy7nxtHdG
         xMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790840642; x=1791445442;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TosNnawzDPsGc04sRZxwMHLtTq8rVKPb8WELyOmoWoo=;
        b=zdyBJmfzXRzJ/EbsNDD5FrLhRItCqEOQG0goMAjkDTnG9J9c9TLwuDRZhjqpl7o+Dw
         M0vPqXzgcVQEh95BhL0CJ6Axk/TXt+M/aECN3uBSqCvmtXWs3iLlhitDRW/Z0+LYLyWg
         d6B0/qe9lnuu1wem+nST3qqtFjMgJMVbwOhpaE30ZzKuDfIB9CjYwLVbkyPvzvjEZ8/R
         yeji6iS0FuQG3tMjVRov8LoWVaEUQxu4boI0KU4Le0ML7BK5f6yxnGCu2jnhU8NIKBOF
         6eXiKFTxWe/vAlWND0ciZNAKHiu9gFU3DWQS/RFYUVLctApcf0zRCbgR7wAw/H/XC0wa
         W8aQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjmR0E8uU0xN5GGWB8JIZE0x6DjVLuEciNam4BbmEZv702qoW+w5ihWHhRYPEVsNMSfaBaYk4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTO1OhHcRlTj/UruHnWcxZj3AOCztWKxfXv2oVKujBL5fIvX+E
	fcCVgrIg5r9z17ksJ2Ui3kzadFlaClRaU1uoD1F0VnPurjOvfVsUgMfq
X-Gm-Gg: AYBFou2QeJ5sU2VCCKM7Ti14HXgq5k2dmLSzLTzjHv1hz/NOiK52WEHesCWq8Xx8jE3
	D/2Bah+Py1pAvtVOZC8f8pxcoReDo/I+EI8AXP1fGTcRCs0AU3rC0t02/0N7QMOX8ccPwd5u1fA
	8KEPiFy17u3YRVPVpXNo58EaCsJxeOGkRDgbY66nxZ/F1vgz58GOZpZ+VqLGXX47D0iO8baA+mU
	AiqA0pqImYNQeQcEkhSUoYnczt1PbSmHq33ohqGNPTsFGse27wAKJK657VsdNfNdqEYs7N+uEHC
	4AyFG+cyS/8i7mPYmHC7UapSJsbR5uxiHjIGL+WS8kQkblem/HEL60lmMmiK19oGLYxGjHOx5eM
	cPyWQf+/iKLjHFgr4Q/KJ9CHy3Ea+Un6aOCH+ShVBGI80w8QY/FpPYey1CpHRF0+fLzamBoN/O6
	dpB+ZS2lbTfh2p5xOa+fs+vS3fL7mDaQCWEfaJBwDJLAE5CnKBva6hKzrLy01w1BvQlA==
X-Received: by 2002:a05:693c:87d6:20b0:34c:6942:8a47 with SMTP id 5a478bee46e88-34cdb8e6084mr3928132eec.8.1790840642073;
        Thu, 01 Oct 2026 00:44:02 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db3e33b73sm4876955eec.18.2026.10.01.00.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:44:01 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH v4 0/2] ext4: fix shrinker scan budget accounting, plus a
 related cleanup
Date: Thu, 01 Oct 2026 15:43:55 +0800
Message-Id: <20261001-fix-ext4-es-scan-nr-scanned-v4-0-b13703714ce2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADsPvmoC/43NwQ6DIAyA4VcxnNcFkCnutPdYdkAoSjJxAWNcj
 O8+9OR2MDs1f9N8nUnE4DCSazaTgKOLrvcpxCkjulW+QXAmNeGUF7TiEqybAKdBAEaIWnnwYZs
 eDVyULWkphC20IUl4BUznm35/pG5dHPrw3p6NbN3+544MGFTMSMm5rKmWt6ZT7nnWfUdWd+R7q
 zq2eLKsQGkLW9SyZr9WvrNyemzlQKFSaGmNsjT8y1qW5QO8EU6bXgEAAA==
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, 
 Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>, 
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Zhang Yi <yi.zhang@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This reverts the v3 simplification of the ext4_es_scan() shrinker
scan-budget fix, keeping the unrelated locked_ei cleanup from v3.

Patch 1 keys SHRINK_STOP off nr_scanned (extents actually examined)
again instead of nr_shrunk (extents actually freed). Jan Kara pointed
out that a batch finding every extent still referenced and freeing
none of it is still real, useful aging progress, not "nothing left to
reclaim"; Sashiko AI review independently flagged the same issue.
This restores Jan Kara's v1 Reviewed-by: the diff in ext4_es_scan()
and __es_shrink() is unchanged from what he reviewed there (only the
explanatory comment reads differently).

Patch 2 is unchanged from v3: it removes __es_shrink()'s locked_ei
parameter, which Zhang Yi noted is dead since its sole caller always
passes NULL. It keeps Jan Kara's Reviewed-by from v3, which still
applies unchanged.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V3 -> V4:
- Revert the v3 simplification in patch 1: key SHRINK_STOP off
  nr_scanned (extents actually examined) again, not nr_shrunk
  (extents actually freed). Jan Kara rejected v3 on exactly this
  point; Sashiko AI review independently flagged the same issue.
  Restore Jan Kara's v1 Reviewed-by on patch 1, since the diff is
  unchanged from what he reviewed there. Patch 2 is untouched by
  this revert and keeps Jan Kara's Reviewed-by from v3.
- Re-measure patch 1's test data against the reverted fix
  (239 -> 1 calls with nr_scanned == 0, vs v3's 238 -> 1 with
  nr_shrunk == 0).

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

v3: https://lore.kernel.org/r/20260930-fix-ext4-es-scan-nr-scanned-v3-0-9aef0be87d21@gmail.com
v2: https://lore.kernel.org/r/20260929-fix-ext4-es-scan-nr-scanned-v2-1-f4e8f6f6b8b1@gmail.com
v1: https://lore.kernel.org/r/20260928-fix-ext4-es-scan-nr-scanned-v1-1-91d88228b0c8@gmail.com

---
Qiliang Yuan (2):
      ext4: fix shrinker scan budget accounting in ext4_es_scan()
      ext4: remove unused locked_ei parameter from __es_shrink()

 fs/ext4/extents_status.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)
---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260928-fix-ext4-es-scan-nr-scanned-5af70744f6cd

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

