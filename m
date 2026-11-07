Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047593;
	b=dHgiJ3kbp4W0mAy8bsC4a+eqU7vcj1+C4UrpscLMYVhAZYDANwVAesZVaR539neA3D1K
	 xQi65lmlPWXaJ1LMf7hpmsEOzn9NY2U4UNduD5mK74aCmBa+TXIfr8P9IRYKsDkOjeF7l
	 P49Mv8x5nDmMrEsCwM/0sEVQY0Ja4nRfXWZbrUCQ+froYH96ecjDZzZjkBhBHMmqbQiOq
	 LcF1IyPkGBHH1AQ/j+KefyHLyuAduXfI6EHaty/N8Q8Hs+yYdMC9bv2d5UA8lgXVw+m5G
	 mFGHs9Q+evy6jDAZNWG2oEsrH+pbsartK/jTqc1+KoAUe92USckCPHBQdeZG6JEP/Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/fiU2r2Vc8QJa3bfBzIKxH70rvX3zekiNT9tijrq5Nw=;
	b=wIL3CnNnZFLUvJR1pu5ZziYf0ka/LwAasIGbVM7PHgR+0S++bMfINOqUAHKrhQ3Mn1Cl
	 yT6ZzfJN2fBMXHxvSjCzoSAev7SREtzjxEJ6Y8AzrkguKc11SgO9KR/aH5mE0e4GQEMnv
	 wjMel2gd67OHYOka6L9OnIVHN1xSuDNKirmDCS7ttJGaeuuzj/OCkBFk/KgOFI3AnURmJ
	 bX2nYX/1o2uyqmQEj+Eg4fYrIEFQAsHG8DDLpXfG9isT/wzQJqu4DfwctUJBdVLD/T/DA
	 +Vg4KkrSyOUwfxDyhhR0SbMb3fO5Akc/O0OlDDUEJdvLprOh9divNz/dxttFykbk7JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9psMVY2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B71606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9psMVY2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEE81F0089F;
	Sat,  7 Nov 2026 10:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047592;
	bh=/fiU2r2Vc8QJa3bfBzIKxH70rvX3zekiNT9tijrq5Nw=;
	h=From:To:Cc:Subject:Date;
	b=J9psMVY2jcDQmFiZ/8GhIpqgvdXBAOkEVafWFT227ob78iUHueGb+5NRl0yhnIzcg
	 4+jWbrPmOQKZT6vTJQIW+roaU1i6w3NCcqQ847HeO4BDoc/OaFCRkAEipkVUFslobo
	 ykIp2748bXOrp5yXcsznDYdD5W3h/MEljB/3+/p9yLYxy1ir8G1/bHuQPoq+IBywLg
	 7vf1BYPsAcJcdGok9rqcqXhnjABrHSzwhxO8qjjBAvQ1wVB+nIDZZgJ1Fgv64/dC+k
	 ksRD2yv13h8nPjMu84xYPMAZpqFmCEsBRNVydgbvc7Wy/KNLmqW9CdeTwuJEe8mGo+
	 rRDhqyEzy4Nvw==
From: Sasha Levin <sashal@kernel.org>
To: yhlee@isslab.korea.ac.kr,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/scsifront: check for a NULL shadow entry on a backend response" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:11 -0500
Message-ID: <20261107053310-failed-6.6-992df081bc88@kernel.org>
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
git cherry-pick -x 992df081bc8878d11e1eb5ae4a609910fd35c62b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053310-failed-6.6-992df081bc88@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 992df081bc8878d11e1eb5ae4a609910fd35c62b Mon Sep 17 00:00:00 2001
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Date: Mon, 5 Oct 2026 21:35:54 +0900
Subject: [PATCH] xen/scsifront: check for a NULL shadow entry on a backend
 response

scsifront_do_response() validates the rqid in a backend response against
VSCSIIF_MAX_REQS before using it to index info->shadow[], but then
dereferences the entry to test ->inflight without checking that the slot
is populated.  Shadow slots are NULL before a command is submitted (the
host private area is zeroed at allocation) and are reset to NULL in
_scsifront_put_rqid() once a request completes, so an in-range rqid that
does not correspond to an outstanding request makes the frontend
dereference a NULL pointer.

A malicious or buggy backend can thus crash the guest by returning a
response whose rqid is in range but not in flight -- for example a
spurious response before any command has been issued, or a duplicate of
one already completed.  The ring has only VSCSIIF_MAX_REQS (16) slots, so
before the first command every in-range rqid selects a NULL slot.

Reject a response whose shadow slot is not populated.

Fixes: 6d1c2f48f3fc ("xen/scsifront: harden driver against malicious backend")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20261005123555.253995-1-yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/xen-scsifront.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index f86a47056ea8c..9d7e12e400896 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -367,6 +367,7 @@ static void scsifront_do_response(struct vscsifrnt_info *info,
 	struct vscsifrnt_shadow *shadow;
 
 	if (ring_rsp->rqid >= VSCSIIF_MAX_REQS ||
+	    !info->shadow[ring_rsp->rqid] ||
 	    !info->shadow[ring_rsp->rqid]->inflight) {
 		scsifront_set_error(info, "illegal rqid returned by backend!");
 		return;
-- 
2.53.0




