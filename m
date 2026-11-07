Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046846;
	b=LyKU1d7/0T9ZSa0obUEzV4GwKPW4uPRpzfn8/gpmoy4wXoY/uT03Gzvc1Lwt5Rnica6g
	 goAJAFFYUFpe/exoFyKIJT9walwrf5P6xUOIVU7W+2CdshJ9ezDZz9M1IQSKLlA3XJt2J
	 7YmsroPDT5+zoHq9Ji8fPQadN/Rl4+m6U4S+3ELrT3UcWid3+EPIj1ZUhKqKY30JWJpP9
	 8F5vcKdP4opLFuuYoKOj64WLbK4DZQ/fWLQ/nReP23569DJrteXJw9S9IOF/BGpPwTEYS
	 D6YeBAepXT7rSTM5PmXu136EtwTABzVGvo52Exp4JFL2jXzjDFN69j1HHNeawUlUFtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046846;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tfbdPVkq0CD5L4HrlVJdUt0XOnaZq1x4c78kNQPtu08=;
	b=WYecVe/ZhcoG9YM76AB/NkZnvt7HuXjyxJGdcUu7wKsG9x8A7wKFcwhQeXVqC067h8VR
	 iq1eQTtyp6/EWJx0i/ogucTCPr1V5+0cgKmF6Yqh/I4dwuFuQDZYP1mFa+fdouUpr7zxA
	 VTqjJYYMOkdUviW/PB792Zx1FWBHxi6A/FxWHbHjOQFwlkVSwhCAWGMSey/zDhO/XDYRN
	 kO+DHf3NOnwz3dn07owcrp/TcG5G2iVsQUeYwS1ZXAUeI5qtriyfdEaXSrvjmlDXpu6la
	 fDmEn/xQj1IQXUcJ+v3l5jIUuV8F3ZK0j8aevf1Ra5fCR2d0zys9PDTL8y0PfGPd3MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeyVLTt6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA8606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WeyVLTt6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF44A1F008A1;
	Sat,  7 Nov 2026 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046846;
	bh=tfbdPVkq0CD5L4HrlVJdUt0XOnaZq1x4c78kNQPtu08=;
	h=From:To:Cc:Subject:Date;
	b=WeyVLTt67xEyGG8OhbwrhabzO/4kAAjo7NgylDxiNrWuMRvbNbkjQsU3vYRnZx7nS
	 5oX/IxaoJoJOrbb8Jb1Fk2JfMrMkxlCTAgvU9GbNpVecLyifE2Bp8saYnHLOLm2YYh
	 Fcnn7xe1/WaHxMYpKIwg8wlwpnZ4ca93zp+B5mrcFjeiJ5xtJD+YfEpKLrZaopydZt
	 SZn3i5YHcjhFmQRYYHYTCFQeIkfLJUc2fNn36Ao7fn2bIKKp4HA96x/U9zfrj05rAM
	 rYUsDffdrIaO5pFQ8kXJXV+4poJhctRQtPQOyVLagc28F0msKXc6+LSyh9HMhbhXi1
	 e2dK4wIBurPdA==
From: Sasha Levin <sashal@kernel.org>
To: yhlee@isslab.korea.ac.kr,
	jgross@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] xen/scsifront: check for a NULL shadow entry on a backend response" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:44 -0500
Message-ID: <20261107052044-failed-6.12-992df081bc88@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 992df081bc8878d11e1eb5ae4a609910fd35c62b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052044-failed-6.12-992df081bc88@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




