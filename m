Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118845;
	b=oqT4Am1pTLX/KmFfEHe7llvYB3Tz3bx0w3qPV5rmUA7tCRnVFEdoy62FX2dHGB+tt656
	 7/SSCyVDfdG61yhds7e+gJhwi+PfSdy7H1D1j0fWdVZM7m2NW0zK+ONtyIpP4xgmhuPyr
	 7UUpAbOwzuh6UupC5kQiVpgWo763tKDBJFg1G6PYKpvWymvmrn211ZA/NcbKn/xl2htWm
	 yUHPac3UDXxSAnKAuxu0EuSBlo1D5dyP5UqYs+6zlOHGCUpibzqLdwmBXMjAFde3QBTjE
	 ONxNRrVOcmYui+abOs1spTGaK+ym/OZX+xgTgLQDyEbgxUbwoWF8xv4FphfaueIooQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118845;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=9xOO9zOigHVwCArnF0ErWEFfcPokwljPR1zEHzCP5j8=;
	b=HhWl+w5EHTuJAd4aol3H54Ty77IZnDkco1UwxKF5y/JrzhIh6koV5UsSdkN9JHko757b
	 g3Vpit+KTr6WJVMGWf6P07pU96fJ1PhMpdOmMbvzjIAbWNpGobfS6njfaIbQg4gEDKYgO
	 OhhdKfjv171I3fhwpewMfcXhjfcphr1oP6jn3qUi3fXYQ8rZCEHftnNAYByrESv8H8zaO
	 fy9gTEsAqpwnAlz5BJ204QEx2LKyEpi6VXIbCFTSlOVBa95qiH5Zm893PtxPrRHHSz5pu
	 iI7gfu3ucIotV9ULs6arx/ydSYvSFtfwRLw7BthVaNXLY1t/o1OEFVz0ixWTJ86eM6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YilBKrWf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC39606A324
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YilBKrWf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793118844;
	b=pp9tcJEf1mCWMO754CxuFNw/BtTTjFw28HsIJPNDEF0NFm/aFt6pz9Om3nznYcYScLdq
	 eZlIi9+XAn81VMFesjdxsh3Tqxx7Lt7qk1E9u+nfMwvn5Qvmu/Kk2r74Sw841H/r6DrA9
	 o3/arPeV0jyDOWaezVM+ihqbZNMB62foAw1Q5OOs+nZmZRIMDTHoEY7nwyfOmRvdrTjl6
	 vo8SsMOt1hVlQyGwl1JVF40t7P/KU9u6kfvOOCGizjYKKhSWMoyvr5+dMLaWite4wLHcn
	 2o44GYKRZ4mtChqMFC2zyNsB1FYcueTYuotvCHQSBXk9OotPWGK0q8xYBQrCC1B61Cw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793118844;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=9xOO9zOigHVwCArnF0ErWEFfcPokwljPR1zEHzCP5j8=;
	b=iYOF4isbcHxP76YqUIWja7KOr/sjl3hlPEHcd7gLt4qc/J1J4DQM/Sl5QZDohOdnQvk3
	 2n2XvcJ6yNjrbd42mdX212KiEmI02hXmB+i2u1yIDVUzO0iAaXuRXiTi5N5o8qTXy5YNw
	 byutybc7HI1WYSNUphbcX4JRQI/unKpEvItwsbqbTC+pujS0VsU+Pw0tIRKjzvZ4/fGdi
	 w0BQ4Hpnpcc/XesPUAF4yjkqQuZXebvVAcUTrlz2Y1BZQQmu7K61j6DMcpy9UIpiKuW1f
	 CaxMHV2WbQHhTyIt3aqIBrk/rI1INQBeCxrN0nRCPPRn7Pern55AKUq9vXOCNd4juIw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B20E71F01828;
	Tue, 27 Oct 2026 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118844;
	bh=9xOO9zOigHVwCArnF0ErWEFfcPokwljPR1zEHzCP5j8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=YilBKrWf5QW6gpYgz2UZ1KWjMx0WNbpX2AICuO1gSAEFsZw5PHL5cnAs9LYpvYVzm
	 u7yxHE+wkGB7RMTjr5HpdcVlRO2vBqu9l8OcYscdpWwkW6LeINhDzJzCcqStwXP07K
	 mfXkK51xt95DXhj3vQHp8JRH+OZmT1t3vA5G1E4uGTAEeVojoe9s3v9HZkZtcbjndy
	 S2jdmF9j9wWo13UNy4e4NZGUGeCIFqeShx71h6X77pAa4zLZwXJoZ6H+YVMqSyzigD
	 RdHgwDFF+1zZ2xTbUOt0Rcb0Np/jdk7++W7gmxOVk9ZshPt6L9yWCH35nkJWEBZg4z
	 PfF3lBP0PRMag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0EEE045187;
	Tue, 27 Oct 2026 16:34:03 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Date: Wed, 28 Oct 2026 00:33:55 +0800
Subject: [PATCH Resend 6.12] mm: vmscan: fix dirty folios throttling on
 cgroup v1 for MGLRU
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-fix-mglru-v6-12-v1-1-e44f4f97ca67@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBBFr9LM2jHtEBr0GG6NC2gHGAPVdISYE
 O5u1eXL/+9toJyFFc5mg8yrqDxSAXcwEMY2DYwSCwNZ8s5Sg728cR6mvODq0RHWpz7UsQttVVk
 o1jNzufyKV7iwcorGHx3B7T/q0t05vL5N2PcPW/IE+4AAAAA=
X-Change-ID: 20261028-fix-mglru-v6-12-59fc5dbca330
To: stable@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 David Hildenbrand <david@kernel.org>, 
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
 Wei Xu <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Leno Hou <lenohou@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793118841; l=3366;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=w5XO7uxDe6BmXywiUuWRH0ePynDG5fOBKE7mkiiXvK0=;
 b=J9F6rHPhSJslAtxXDC/CJCbqmroGQWPBOdIBdHQAaS4dtdfRWIOt4gh0xoTGECyvBQpLQ9zTn
 Tzx1cS9YnbwDLrj2hFWqYrR8325U6AFLVPg2Mk+X1S8WDM2bi77KCV3
X-Developer-Key: i=lenohou@gmail.com; a=ed25519;
 pk=8AVHXYurzu1kOGjk9rwvxovwSCynBkv2QAcOvSIe1rw=
X-Endpoint-Received: by B4 Relay for lenohou@gmail.com/20260311 with
 auth_id=674
X-Original-From: Leno Hou <lenohou@gmail.com>
Reply-To: lenohou@gmail.com

From: Baolin Wang <baolin.wang@linux.alibaba.com>

The balance_dirty_pages() won't do the dirty folios throttling on
cgroupv1.  See commit 9badce000e2c ("cgroup, writeback: don't enable
cgroup writeback on traditional hierarchies").

Moreover, after commit 6b0dfabb3555 ("fs: Remove aops->writepage"), we no
longer attempt to write back filesystem folios through reclaim.

On large memory systems, the flusher may not be able to write back quickly
enough.  Consequently, MGLRU will encounter many folios that are already
under writeback.  Since we cannot reclaim these dirty folios, the system
may run out of memory and trigger the OOM killer.

Hence, for cgroup v1, let's throttle reclaim after waking up the flusher,
which is similar to commit 81a70c21d917 ("mm/cgroup/reclaim: fix dirty
pages throttling on cgroup v1"), to avoid unnecessary OOM.

The following test program can easily reproduce the OOM issue.  With this
patch applied, the test passes successfully.

$mkdir /sys/fs/cgroup/memory/test
$echo 256M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
$echo $$ > /sys/fs/cgroup/memory/test/cgroup.procs
$dd if=/dev/zero of=/mnt/data.bin bs=1M count=800

Link: https://lore.kernel.org/3445af0f09e8ca945492e052e82594f8c4f2e2f6.1774606060.git.baolin.wang@linux.alibaba.com
Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Kairui Song <kasong@tencent.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Leno Hou <lenohou@gmail.com>
---
 mm/vmscan.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f9b5fbd072db..074e403ffd14 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4809,9 +4809,24 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	 * If too many file cache in the coldest generation can't be evicted
 	 * due to being dirty, wake up the flusher.
 	 */
-	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
+	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken) {
+		struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+
 		wakeup_flusher_threads(WB_REASON_VMSCAN);
 
+		/*
+		 * For cgroupv1 dirty throttling is achieved by waking up
+		 * the kernel flusher here and later waiting on folios
+		 * which are in writeback to finish (see shrink_folio_list()).
+		 *
+		 * Flusher may not be able to issue writeback quickly
+		 * enough for cgroupv1 writeback throttling to work
+		 * on a large system.
+		 */
+		if (!writeback_throttling_sane(sc))
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
+	}
+
 	/* whether this lruvec should be rotated */
 	return nr_to_scan < 0;
 }

---
base-commit: 85d82e0d7c2dfd3e75d34f35b7ebbf41f45c9c4e
change-id: 20261028-fix-mglru-v6-12-59fc5dbca330

Best regards,
--  
Leno Hou <lenohou@gmail.com>


