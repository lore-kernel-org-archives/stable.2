Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF233D47BC
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789449578; cv=none; b=sRniwOehUZWIkDj5w+NNVk5v7Fx0e6Kx2F2ydXr+wtdpr1P6TjqAdsEOEIRGJpguFSTAU/ouThxIRhw7eHiV4hPnrmm/4oyoNGiv/WaEI2BxPU2xU8cKOqEf4UCnzO7yvD/+YAs173fNpK1cJ4w4bo0f3X8SxsX+c3Vpq/zyECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789449578; c=relaxed/simple;
	bh=tRK/WLCmOL9yWhdP5u7X+a8hOKx87CLe/k7xw0s+QCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIWijo5kRHWAY5OMR4CYInjMYqIFKsfvn8j7o7S7/8ys2Z6AhElhPX4H9oQbtDblZnK59BH4g+FVI8KLFe8R2ng/PhyfxW6vHELywp8ACEK2kr56Ox+lFlSiPfHzl2KynVOwvaLrp+ZKegKSpf58R8iji2uKA1zDrFqIYq4t1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=q7rAe4ly; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="q7rAe4ly"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc502a179c1so146309a12.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 22:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789449567; x=1790054367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OOwy7c+zcjkAyM/C1EYhF9ectrxzXXceO/PRGImhvE=;
        b=q7rAe4lyJRGIY1qra+QwabZXXcVkexZdsB7FW/7cl1ndR7E0EisBYCtvRJG49n6oaV
         cPRTRyvN9KdMjleC7i0MgCg3eeN6Qv2s7WoZ60GmHMVoRAwKqU4SFMyQFNobznZciBy7
         qDbGzs+W987wXO1BvnTvqmBQl5S5Z5i4NF7K5LmaQwuvxCywg7B3jsQS9KUvj7rpCqdj
         FUQzAWbsFDlXCchxBNQUH7suXnHSsZOmxZ2FkH0jfogHQMsiMlAOEDW6MM++NoYrd4GU
         tWGRc06SO5ZPNsmYzhtS1SFoo7DYzirfo6DCgpsRJMINIaFs7+3t5/UOz6ba03YLjpCe
         eMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789449567; x=1790054367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OOwy7c+zcjkAyM/C1EYhF9ectrxzXXceO/PRGImhvE=;
        b=fHmdkXGV9QpAUUDFxpJVYJtF55RWGaOtn0B77qj6hDWvUBaiI8Ne4KTFkmgUaJbgI0
         Zldb5ut1Eg+r6INAAsiwVozUoHmW+fGmZ0d7lqaoOZhAGYd0Z3asuc1I83yEWZyH+dmd
         Tl5hzEPK4ZYvUCZqoOG43m0TKNImXXVLw1Wg88VHWzhdxw+r2csm+CSSNkmwL9AGh60L
         efyxUJhr7i9dZsvAd1AbsMht6JuYY4L6+X/bfbBUeSCxhm5BdcQyep30zKOWCo8gkd6G
         ucd9GjUAlnl7jRE4VdfYDk8ASqG3CUFwbxojB47YIUPdh3C4ZH0zhQ7pzkUOcBkIOuMw
         WkfQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnwDMtcWNG3TFk3e+a47vNlIZspVfB+OWCYYkbPhrIzoCG93akfRww+DpEt1WgiTDf8O1FGEo=@vger.kernel.org
X-Gm-Message-State: AFuF++kYDHLVbvGQeAB6SU0X+NLWnU2j82GXav94mkc2anM5/te/MEuV
	nJwg2ydh318xUIQiSgqrKZndZoFMVHtBVBiEaOpRwVXbkcTm+kx1zp7nMw/2QZEaSQ==
X-Gm-Gg: AYBFou0yKPm5tawXS+VyGWrRWHlQG/CWPAcRpdqwRsqWjRGtS7HVofRPpIR3FlMuz6G
	5AnhNNBToMP7mVfrVGG0uORZIStDAh05s1qC+Gn1oVl/oM9dpg4egpm+fbRri+TiE3ZzNyViX9H
	ZdN1cou2aoW2OsUBRnCEbOBPfFZZFh12MsqTUSM5vwp/3adi0AduVUNec92OIoPMYtP0df0+UBj
	0Qt/1Ks0+/7JUWO9BVOJvJy3jcnHEjcIDCmjMz9B+msre8s+yptXDy+UHiKxTTxz2CJBSaCJ3eq
	sV/9X220ndjS61bZnfnwOZaMbkA8edN8qc8lEiOeTYGxdcMRKy1Aeca2uzoDjDUxGj18Xh0NqCD
	y/FuaTCr8pEBc7zoWQ0PmnJo4tVXTQIKAkRqUXQb0ZR4FgT73r0hwR8LvGsBbdkkR9eVGyJg9KK
	BCfyLFhde6UqdsVitRCmmV15U9/QZ6og5Kq8/Y6xvLpljWls894F3t4+S1A18KFfnUbYNdUCVYK
	XImbf36a3RaotS02GJw9MEyRpQ1XqmI6ru+7A==
X-Received: by 2002:a05:6a20:7493:b0:3d3:aed2:6f28 with SMTP id adf61e73a8af0-3db501db9afmr3325689637.28.1789449567479;
        Mon, 14 Sep 2026 22:19:27 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e4fb3esm30593846eec.7.2026.09.14.22.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:19:26 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	co+f8e3e01d8dda8689@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] ceph: reject mdsmaps that claim more than CEPH_MAX_MDS ranks
Date: Mon, 14 Sep 2026 22:19:24 -0700
Message-ID: <20260915051924.737109-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_new_map() sizes its export-target bitmap from CEPH_MAX_MDS but walks
it with newmap->possible_max_rank, which comes straight off the wire:
ceph_mdsmap_decode() sets it to max(m_num_active_mds, m_max_mds), then
overwrites it with the size of the "in" set.  Neither is bounded by
CEPH_MAX_MDS, only by m_info allocating, so a monitor announcing more ranks
than the bitmap holds makes test_bit() read past the end of targets[].  The
clear_bit() loop above indexes the same bitmap, though it is additionally
bounded by mdsc->max_sessions.  The map arrives on the monitor connection,
which is unauthenticated in legacy msgr mode.

CEPH_MAX_MDS is a protocol constant from src/mds/mdstypes.h, and the
reserved inode ranges in super.h are laid out one rank apart over that
span, so a map claiming more ranks is corrupt.  Reject it where the rank
space is established rather than letting the count reach check_new_map().

  BUG: KASAN: stack-out-of-bounds in check_new_map (fs/ceph/mds_client.c:5968)
  Read of size 8 at addr ffffc90000ac7798 by task kworker/1:2/127
  Workqueue: ceph-msgr ceph_con_workfn
  Call Trace:
   <TASK>
   dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
   print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
   kasan_report (mm/kasan/report.c:595)
   kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
   check_new_map (fs/ceph/mds_client.c:5968)
   ceph_mdsc_handle_mdsmap (fs/ceph/mds_client.c:7060)
   extra_mon_dispatch (fs/ceph/super.c:802)
   mon_dispatch (net/ceph/mon_client.c:1483)
   ceph_con_process_message (net/ceph/messenger.c:1424)
   ceph_con_v1_try_read (net/ceph/messenger_v1.c:1430)
   ceph_con_workfn (net/ceph/messenger.c:1576)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
   </TASK>
  The buggy address belongs to stack of task kworker/1:2/127
   and is located at offset 288 in frame:
   check_new_map (fs/ceph/mds_client.c:5846)
  This frame has 1 object:
   [32, 288) 'targets'

Cc: stable@vger.kernel.org
Fixes: d517b3983dd3 ("ceph: reconnect to the export targets on new mdsmaps")
Reported-by: <co+f8e3e01d8dda8689@bugs.sh>
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 fs/ceph/mdsmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 53079ef34c3a..5e3b8c3ca502 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -170,6 +170,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 	 * and the mds rank >= m_num_active_mds.
 	 */
 	m->possible_max_rank = max(m->m_num_active_mds, m->m_max_mds);
+	if (m->possible_max_rank > CEPH_MAX_MDS) {
+		err = -EIO;
+		goto corrupt;
+	}
 
 	m->m_info = kzalloc_objs(*m->m_info, m->possible_max_rank, GFP_NOFS);
 	if (!m->m_info)
@@ -316,6 +320,10 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 	{
 		int num_laggy = 0;
 		ceph_decode_32_safe(p, end, n, bad_ext);
+		if (n > CEPH_MAX_MDS) {
+			err = -EIO;
+			goto corrupt;
+		}
 		ceph_decode_need(p, end, sizeof(u32) * n, bad_ext);
 
 		for (i = 0; i < n; i++) {
-- 
2.43.0

