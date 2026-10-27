Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119150;
	b=wDfs4PKb61fOgRY+yK0B7tuM2/CGsAo309KAYbEunh0wb3ocN7KEPYNlYqqjRjFFuNiv
	 NKWvBFsdJLmuLTNMankQ0wM4tYGYqCXXfzenVoak14HB0YflCavE+8mYxmNa/6m3NTk7j
	 i0l3jGQ0Ullx26igq0JjkbrI+5WSuCW1eDrIyIAa4Kv3pkFAKy31zg1dvpam0ZxFxA7e7
	 4wkyt1ENs2y3I1ne79LOJDAIIy6tMb7WG8Yo2Oly6TbT/Alnk6v8gO2e0CcA895BB0CWq
	 Mu5GdjrvKrlvqY2XNk/xL6cQ2iM4OEeSofEE1OftvkAALqqo5iy6Q9HOD013TN0Cryg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119150;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=aWeIFCUSStBB678tZMupBU9VdXokbp8ZAi5raZvu5B8=;
	b=NQB67Oaixgol5Bj57x3Qu+V55YrG2UepEO9YTNWuN7jfYLu3JetR9NColO4OqzCwElEv
	 617ud/d+EKpsF8fbUrftynEak4mtrJrCMVDlfjKlrVuxQICusGmA13vwXVr/hINmTe3fB
	 9WVht9rdOXaMpjgtjdgG57qzbSGdy1vO0xyOI15MANgmr4XPQCooxV7j9P8xjCx59Smwf
	 chAlWocRnOt3sSg8mNfGpBKhMCFjUb3Bgv7QC3LPJ48IU4d5QOxB6IRjTt+mGGFzPWDsK
	 XGN8nUPVklb81LnRMuECZqxY9ishoI7qL6mmpcZDu2Syd91TPiCpy/968vV1IYA+z2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIp5eOoO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421A606A32E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIp5eOoO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793119149;
	b=NdqkLSoSjk8cbqaRxUOQIezMbdOVLx4+83XdEZ3Q7EzDGdGf1is0wv0VpGKqV59qHj0z
	 LPhNXYYEF2E3ZytGqu5opE06y3OClFaw/OCH5mUuLg8UPiUcnpFXAlWiLRrKQw9Jga9TP
	 mfa63nqm0EnDHEdQ55HFyUPCc3pNSgzxP3dKXpn4S3JbVTGheqceP1S9ZA9qeZKykVAYm
	 ygXV3Wq+fpxmwuoiobC6MzARSsyz/IRcrMa0MKdk3Pz7oYk9DtpEw6Wfx3JokJUOMzjFp
	 KBAgXFo8F12yNcdJr3vFt3WSFAlF5cR0fbFMVeeyRsefmbz1sWzP6zONHp3lEZv08CQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793119149;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=aWeIFCUSStBB678tZMupBU9VdXokbp8ZAi5raZvu5B8=;
	b=yvZoV3iqpjHA4hzpQbZuwlwAnsYTXXKVrTLqOM/9PHv8+CyqcE6nGMoe75WKkZlc79kn
	 KByFL0yR3DZoCAHlPcLkOXCCKaYTkUoXpUkP/WTHWvKEA6qlZdHGpNd3sP5bRsUrhwzAJ
	 D4OvmYR/LhQxBQY9Pj9n2WNvJHTlZo4LsjkhEFIm6ZIAdoRx6BRKkque+l/U3tWOeCCh+
	 RT5y397b9smbB4i/FE2JDFvtFKOFvqNYqAJAwaAFn78xJpsg2zR/cFtFdJ45oJ6g5pb+N
	 U+Zqb7yWZrr5wKzdIWz6WFEuu/HCqFxOykMyrkYWbFkEfQKGqZmmfsN5uCsOdAEr5NA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E9B781F01828;
	Tue, 27 Oct 2026 16:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793119149;
	bh=aWeIFCUSStBB678tZMupBU9VdXokbp8ZAi5raZvu5B8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=QIp5eOoOXp+EJ/EZAv/sni9jE2uHCosG6+649bJkR1B+AfWhvUEcct59ppikhUrPM
	 KSbZJTCgRkDSkECIroRQ+pKl1wGGTyX+V/05jUjnUmxyzgsoERn/f77GzZj7eKhIft
	 0j0v2kK21OLWGZwemEH5c71B2wo27hoQT99FEU4PLLeujkbES7FVsIfYTPINk0zxVc
	 1QY4s0l7NXccMStq5BKekACjI6Oonu9FSX7Uykavrpf2kYqHRmndSjfR6nR1jr2tPC
	 TsFeH5dJeafk37YD7lzteHA6ceZr4/EtC0aShOER5Qvcso5GB0fqsoHrUJmjQGZv2O
	 TVpl46GSUiLzg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4D78F45187;
	Tue, 27 Oct 2026 16:39:08 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Date: Wed, 28 Oct 2026 00:39:03 +0800
Subject: [PATCH PATCH 6.18] mm: vmscan: fix dirty folios throttling on
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
Message-Id: <20261028-fix-mglru-v6-18-v1-1-5813f30470a5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyML3bTMCt3c9JyiUt0yM11DC12jVKPkJMvURMPk5FQloK6ColSgErC
 J0UoBjiHOHgpmeoYWSrEQueLSpKzU5BKQkUq1tQDt75kYfwAAAA==
X-Change-ID: 20261028-fix-mglru-v6-18-2e2cb9ea1cce
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793119146; l=3366;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=ZuOibcyCjCwv7fTq5uuREQh9Yfw6I6yU4s9aM7bnXV4=;
 b=3j88arFiX8mhZjRvXzpkeMvBcyhqDUR26nojAxrpj74mDTVq3eldHmZqWhb7Px6kGFQpZa6ZE
 qdwMVTRednGAejQQotqS2wsl0h7hpNVih/ipGXCJBL7lFVWcCfxVja9
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
index 2c66fbcd6e84..c983815bde5b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4901,9 +4901,24 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
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
base-commit: 1253a6aa5d104312bf0992afacc15220ae35bdf9
change-id: 20261028-fix-mglru-v6-18-2e2cb9ea1cce

Best regards,
--  
Leno Hou <lenohou@gmail.com>


