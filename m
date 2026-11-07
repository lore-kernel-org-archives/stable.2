Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045864;
	b=iTpar0bknowj98a80RhSgRU1oi193LOF1BLz0PFitNvovbdenenxPSlnFC1MMaxLx/OX
	 ETdRqQnOq3nKH6kmHjzr6J6KEUVqnNS/AFsaTepQeKy3JiU0aizYmK6PpezNPXId54VWO
	 fLJChfNSQ4cLrnsoUYUVKZfq7yzhFZUu1OZ7qLeq9oRunakeOHqt2dF6syCM/Oy+0P21r
	 KuoB2QKdKGE4IkSNPboNNqJLRuAuCHZZTjwytShpKd3TYQIxftVuKERROolSafOfyCZmV
	 EaWcdqsbqO34zfDJlIYOLTCAgteR55UCbz6NbHcfl8xmxJzIz28lkqVkb/Igqi05gZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FvpZk2CVv5YMbMNYX63fF2cipDPFM60XY0Ol0VVR4qA=;
	b=dlUEuf4fu34jz1rbuUxGNzMRp0JAjwUjwJALbpdkbnYQbtUKfxws+d34eIYB6r9Naba1
	 +svXR8QIN4ibQzr5jf2C8saC1meBk2k5LELYisd23hjanYHqjfzZ4tE9/Yg/IuPZum5jF
	 g/Ta4q6HIstbgSJNqLBUs3MoN2+5ZYh3d1BJpTwM3KPk6jR98pkMpLFDuTtUR3m1hnoV8
	 YjNw4oSJ5rlD4L3nprw8b9LAdRj8W1TBC5zbaI2EKeJeWViDZP7VywFNi+PnuVznN28qW
	 lkFTFPAOZwjKAgCVkxvna9YTmRvQ5Q1Yr7KxOruBcw0WSjW50plCiIunyEKHb1UPRoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m43A4xH2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D89606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m43A4xH2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50561F0089F;
	Sat,  7 Nov 2026 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045864;
	bh=FvpZk2CVv5YMbMNYX63fF2cipDPFM60XY0Ol0VVR4qA=;
	h=From:To:Cc:Subject:Date;
	b=m43A4xH2lb2ftOE0oMjVP+fwVXXpm3+AX8I8WFkGk426eaptUxxIJ/PdydjbpUo6x
	 6tP/yBxB3Tudfwfm0cxu0rNNWiGFGEOJ3hHV2pB34cDSRrJMlc1I59B8H+xL1OEm2S
	 /N/VMh/lc0Mk0zQZidmUarkim5YpNnr6kppaAMfxOmO4YFyJl6LUEunqNaqqCtC7vh
	 Vr4CKjoe7jADr52zyfWehtvQ2+pc82FhadqoW9J5oihVeP/OE0W4n1DteEUVKuoLd8
	 fOCrag7F/aI0G2Xm3xN8eaIlLAYZgra0JPB159Ar8NJWuxBNSWFwxMUOaHgrHC3eso
	 7UyI9ijNhAfMA==
From: Sasha Levin <sashal@kernel.org>
To: yhlee@isslab.korea.ac.kr,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/scsifront: check for a NULL shadow entry on a backend response" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:22 -0500
Message-ID: <20261107050422-failed-7.3-992df081bc88@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 992df081bc8878d11e1eb5ae4a609910fd35c62b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050422-failed-7.3-992df081bc88@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




