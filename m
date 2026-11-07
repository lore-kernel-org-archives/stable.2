Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047533;
	b=qE+QcP1aVCWD1fNbeqJeq/QX5Nr0eHbOccrWphVt/HiKL+U3LCUYta8ljum/bPibcqwX
	 yjbBR9xb2zmr0pOauu90EwlrVIa/0lnkZsS3co6J1LrTw1VtRul6Fs8FK6bLJJKTWaDoV
	 KYWh4bvWfN27DMGxIxIarD9yeGvOMTEv02IM5J0XxWAsP/HChCTxB8tau+F0Deasarb7n
	 0ClE9RL94P/p81DbdAkBvReCLwNPQfXGzzIePMUhUQnhXhlvcAirm42TmADvWU0TKI/X7
	 unW8TfoWdxUtqijFai0P0jeankAvgZXZViWTKIU7Y5nXWgbo6/IIHfKpfJ0L3M9uOtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TBM6dIapub0MswAC4p16FtbvE5vtVUkAlv+Ot9bV4iM=;
	b=A2wAP0vX3mg0MZ/eS1LZmlmCoYdBI8nRfDZHGp1xkW6QGU9/GQg6MkV96dhktuSPc6uY
	 zZQO21ue0XzwB55u5BoJbMxtg3GjQMbhg4QYh+ppoAB9JYgjfsh9MZ93U/MrqDQtbVcE9
	 L82OjwoNjFo0BkOJadz8N9NbIXCfyidWKTYr+jWYMcBaFvPYnxoFFTwdqfMRULbyluLol
	 4dPzk5mQ90KTqg4q2PXvv23NY2nirkagKWJX+KRFMshTF0/CvgYFL6hwtvdPizqBk5llJ
	 cFLJSrbON1ghSeTrO65DIARdVKsyJxwTiS1pAnmtP14C8n3G3HyWBJQeoL+jF1zaFbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQ9HXf7x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B2606D80A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQ9HXf7x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBA31F008A1;
	Sat,  7 Nov 2026 10:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047532;
	bh=TBM6dIapub0MswAC4p16FtbvE5vtVUkAlv+Ot9bV4iM=;
	h=From:To:Cc:Subject:Date;
	b=XQ9HXf7xId5Z5aPhKFB7Uh2aUMgV5Tbf8+uMKVoN3+iY3HSx84f8bAo+stZnv48Kf
	 qd5MnylLEd4JoOSQ1s1V2Yl6t/JdcDvsr5nSVUfmpLGQKUfatUCpjvSVnullhFvVUk
	 g15gJC1Yld8PZOvguQL/AfWhfR15og/7jnuszf+wIhQbG23RP07a2Z1NqqkoURYl5D
	 5X5L9RiUUAMM0RV7ir5Qc/5daMHMt/SdWPrdBpPpi1l1Jmo3z7kpdCsh+zexMqzLiL
	 70K5qG6J8wsIg1HNQ2ks8HtZD18LGiRUWg3vbwEI87bbUSCP3N1ZfBmFMATqY/HWx7
	 v3jvmx/LtOw1A==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core: skip applying scheme if region split for quota fails" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:11 -0500
Message-ID: <20261107053211-failed-6.6-90c2fa6adfed@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 90c2fa6adfed7abe0935506a43cdff3a05c1fff0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053211-failed-6.6-90c2fa6adfed@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 90c2fa6adfed7abe0935506a43cdff3a05c1fff0 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 1 Sep 2026 06:18:42 -0700
Subject: [PATCH] mm/damon/core: skip applying scheme if region split for quota
 fails

Patch series "mm/damon: fix DAMOS bugs in core, paddr and vaddr".

Fix misc bugs of DAMOS.  Patch 1 makes DAMOS less stress memory allocator
under extreme situation.  Patches 2 and 3 fix wrong folios walking in
DAMON_PADDR.  Patches 4 and 5 fix wrong folios walking in DAMON_VADDR.
Patches 6-8 handle extreme and unlikely memory situations that can cause
divide by zero and underflow.

All bugs are discovered by Sashiko.


This patch (of 8):

damos_apply_scheme() splits a region and apply the action to the subregion
if it is needed for not violating the quota.  The split operation
(damon_split_region_at()) could fail for allocation failure.  In the case,
the quota could be violated.  From the user's perspective, DAMOS becomes
more aggressive than expected under the extreme situation.  Handle the
failure.

The user impact is not critical.  The failure of damon_split_region_at()
is unlikely since it is arguably too small to fail.  Also DAMOS being
aggressive is limited to the single region.  Users can set min_nr_regions
to set the maximum size of each region.  If it is reasonably set, the
transient overhead shouldn't be critical.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260901131850.98037-1-sj@kernel.org
Link: https://lore.kernel.org/20260901131850.98037-2-sj@kernel.org
Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org [1]
Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org> # 5.16.x
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d63d4c6fd3ffd..53952d16ebd88 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2607,7 +2607,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 					c->min_region_sz);
 			if (!sz)
 				goto update_stat;
-			damon_split_region_at(t, r, sz);
+			if (damon_split_region_at(t, r, sz))
+				goto update_stat;
 		}
 		if (damos_core_filter_out(c, t, r, s))
 			return;
-- 
2.53.0




