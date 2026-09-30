Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94F446BEA
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752310; cv=none; b=NAWXlanWQPojZLpN9Zh3Sgbj4zHr5CCUSVQ+6C30QARe+6fBMKovLeoAMu6Ukl/WxwJmltOH3tVTuFbdnok6Vm2h/6U8SZD3erDb9q45VJvM1Kbj0EuPu4YLOzx64cZ1BUTHMXPSpanXifoCkO0C3V7BOM8nOJz3iTo0PxV12xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752310; c=relaxed/simple;
	bh=OTLf57bRLMObeZY65qGuyn5U2mnysVcG5k1v3huPGzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXQUSi6hecV4DWkS0g7lw+/wM5uRgYBqbolJKACF/waYmmNpCmNXiuhhGJDmcDFrK6wpqEbeLltoD/L98P0asnb+ZlV0njS1Rnxz3l3DsIEREi1rS+VYVfqGwCzee3IBA7PcgdA6XUx9kG+OexkemFPpoxnHh+7OLvgrgjtKkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz1J37UW; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz1J37UW"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c4a0870d2so642094eec.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752307; x=1791357107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zcnJ184JoYb53zg3yz9uspX1LHzg9LyZlu2u82RZHnY=;
        b=jz1J37UWdme9gEMoheGwEcwN+WtODKIIgLck3ow6AAC8WhOwCMUNsLCpwpR8e56lDn
         IXl/fvXcoAzHkeaw2r1/btRpSCplG7ZY7NCDsFtLUVbtVUBPnBcsGDbZwNZg9qkciHdP
         IHsZtF3n44f1UAT/fEllI4dGnmzqwGPywKUZEIjE6Chv3y7ly2/9R+Ny4RJuJk413AFs
         H8jPoBVMFCSqDfNg3gLPA/lvmFK+2kU51uTtX9G5gepgGExexfjKpQwOMscTI4RoS1Y7
         NAHIKFdWGwzKlcM9Nk1KVD4MHsEX5QRCA9E3kX60/nq0Gq3fI3fnOJ6DFz7D5qi3L+g2
         fpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752307; x=1791357107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zcnJ184JoYb53zg3yz9uspX1LHzg9LyZlu2u82RZHnY=;
        b=mTEd5zpHVKs7Sq8urs3kfqc/ZY18YnUNHA6RvfYqYfe21RQwAVZGoLGh74Y4igAorM
         sCBnR7uf5NVCCz7lVGm8RF/T8CR1rGc+tJ2q5xDo8muqx1giA7DyuD++X4blqvL90JhF
         3/nWbCAyxLRkqYyyU/Uxal3SlNZwdCTiz6WFqC98/W6+XgbYc2LWH4PT3P6feFXAdWJt
         W4E0Wtwb8xLrnsk7iHyUIEdRWd4NY2o8yYkQTviGLkLGCkANYTaLK/M/SnzXg8kyMdlE
         0q2dJqijvm7pjDb87QsMELx8FNb77uMXpVmqMAvkNEXJY3NuFENyoIwe30VJQ/J81xGi
         Cacg==
X-Forwarded-Encrypted: i=1; AKwUvBwWeeYIUX09OFCtT8uT0apsz6w5EHuX9B96/kvULQccj5h5kibkMLv3Vx+nFmIX5ezjlHIvj3Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnmdHIP3oE1dZYA5OtIQv3hvzZhLKTzeWpUT/SGG+Q6p68EpCo
	/1wJcvLSdC6VdsDJ6nML9001Z993IDbfinTXpTBmo4PoN4CzUR6icbZQ
X-Gm-Gg: AYBFou11s1txuJAcgYEITeU0HMb+3wFqoLQ4um7MzcxrxYZ4W9tDeeqxffrtnUsz1tz
	PVHIixi2dM1aEJAUhG14pCdrnG1yt3QKTGzBtSKxNzvIYWenFciRrganA7QJyRKCc/Pt8V1qBR5
	vZxf1KbrUp/D052DdLb2WEcxChPK1pJs6qfCBj3fWl4a6cichoEncfx9gsrKqD2JeotMLPDTHnb
	M/GCnyqrPb60/NjqA08XHcWAy1rb5LCjXFY/zp1ygbVQD3IvzRw1lTwZR3i89/qCwdpzNBufJ0I
	A5QRzk5YyGuBBRE8HCEx8ihnjUOYWeoG5/pKstOHvJ0v5a3nKemF3JbID+GYddj9pfipCVCTYFS
	YyotwDVT3KLOUrplnmLEr3/cUtucj8ccOGxFzd0yyRCOW6ieGRUbUCWBNnnO2aTXU+2Lp4uhrZV
	9ZGhCLuQmB1vq9gHReOL7cAqWzSBD3HvPOwXuGGuwcyXUOqKzvrevWGZWHZFDLBy5t+A==
X-Received: by 2002:a05:7300:b282:b0:34d:756:9b2a with SMTP id 5a478bee46e88-34d0765e6b7mr406978eec.23.1790752307547;
        Wed, 30 Sep 2026 00:11:47 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5b4349bsm1621837eec.25.2026.09.30.00.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:11:47 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 30 Sep 2026 15:11:37 +0800
Subject: [PATCH v3 1/2] ext4: fix shrinker scan budget accounting in
 ext4_es_scan()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-fix-ext4-es-scan-nr-scanned-v3-1-9aef0be87d21@gmail.com>
References: <20260930-fix-ext4-es-scan-nr-scanned-v3-0-9aef0be87d21@gmail.com>
In-Reply-To: <20260930-fix-ext4-es-scan-nr-scanned-v3-0-9aef0be87d21@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, 
 Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>, 
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Zhang Yi <yi.zhang@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

The extents_status shrinker's count_objects() callback,
ext4_es_count(), reports the number of shrinkable extent_status
objects via a percpu counter. do_shrink_slab() reads this count
exactly once per invocation and derives a one-shot scan budget
(total_scan) from it, then repeatedly calls scan_objects() in
fixed-size batches until that budget is exhausted.

ext4_es_scan() never signals SHRINK_STOP, so do_shrink_slab() has no
way to tell "there was nothing to reclaim this pass" from "a full
batch was scanned and none of it was freeable". It keeps calling
scan_objects() until the original, one-shot total_scan budget is
drained, even when sbi->s_es_list has had nothing left to give for a
while.

Return SHRINK_STOP whenever __es_shrink() frees nothing, so
do_shrink_slab() stops calling us for the rest of this reclaim pass
instead of burning through its scan budget against the same stale
freeable count.

Tested by fallocate(2)-ing 10000 4K files (to populate the shrinker
with reclaimable unwritten extents without also exercising the
extent_status "referenced" second-chance path, which needs a
separate two-pass accounting of its own) and triggering
"echo 2 > /proc/sys/vm/drop_caches", while tracing the
ext4_es_shrink* tracepoints:

                      total scan_objects()   calls with
                      calls                  nr_shrunk == 0
  before this patch   429                    189 (44%)
  after this patch    238                      1 (0.4%)

Fixes: 1ab6c4997e04 ("fs: convert fs shrinkers to new scan/count API")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 fs/ext4/extents_status.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 6e4a191e82191..d88af807d36e7 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1783,6 +1783,16 @@ static unsigned long ext4_es_scan(struct shrinker *shrink,
 
 	ret = percpu_counter_read_positive(&sbi->s_es_stats.es_stats_shk_cnt);
 	trace_ext4_es_shrink_scan_exit(sbi->s_sb, nr_shrunk, ret);
+
+	/*
+	 * es_stats_shk_cnt is a percpu counter, so it can stay positive
+	 * after sbi->s_es_list has nothing left to give. Stop this reclaim
+	 * pass once a call frees nothing, instead of burning through
+	 * do_shrink_slab()'s scan budget against a stale count.
+	 */
+	if (nr_shrunk == 0)
+		return SHRINK_STOP;
+
 	return nr_shrunk;
 }
 

-- 
2.43.0

