Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808444F547
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034955; cv=none; b=YoUcRqN5OuLrgMP4XcNyPHocAbhFWPwQ8A500z0F66osh4vK0ZfgChRrA2mAL28+eufWC11EvQdHTP3AzpEWMpA/wJBVvEFVhmyMyi0JaMZoB3+8iLmFhMzNsCOQLoU+8a9090HuOBW2IFGGgL/5TiZQNBGwSwzl02GGZ6ufK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034955; c=relaxed/simple;
	bh=ZlZmmE0Ud4HtB8YhKVNsPgOQtYjW6bg/mZoU2cnlRYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T/mmAGhE9WiUb0GNd53/521jeRi5jZ/tPopmf4QKxLMAcEcosGNoebeI1i+IigGSe78CM2koSB/hQ3Ni3+AISF/dC0VJACYakGn2zC0+SFnuIFaNwdChlleGO0/ofSXxCKbjeMnY+MPPEyxrQuDwmJhhUUnC8uAqEbguYb5V9Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=everpuredata.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=ER2Q7Ts5; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="ER2Q7Ts5"
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-49e651e83dfso9321465e9.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 16:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1790034952; x=1790639752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DC4z4qLDl0mYRFHdnAjlB1ZKHEqGD7UBjetsY7bEK80=;
        b=ER2Q7Ts5YbfRlmJ9MXUTJbYwo53bCwYEhkicRq3+tFf/MdyHXBv8cEJbxiWOnN7zs3
         8nV8jJ24CKQmOKMlIT4kqpNoAdK6pwxW12+GfiafTmn4P5G/6qCSBai3S5R/F+h6nb/w
         6t/a93CW8g4nRDzVcYH8n8dZbEk94ueYq3L9YQ1nCchZrt1X5lSJ6GLe+i6D4kw6hYm0
         c3h97E1XvWzAGVyCVnAh3ANX+wmSJKxbN7d9rTsurNoZARNVthKqq1JNEIGvqt/empXr
         2pB0CK3CRPV0TZBs0hAen0WWd2IHz/CodACJtGehWDrn26YB1BltdgvQd6sLPDzrztKD
         ZsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790034952; x=1790639752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DC4z4qLDl0mYRFHdnAjlB1ZKHEqGD7UBjetsY7bEK80=;
        b=Snu/XibofglGiiacStWFGlbrjxMV9GVGZ4CgSG8b0s1MuAmJ7SwjpO86WDOl817Tru
         eQi+3zITDL/QbIrIJKTnfP2ROjhXxswP8Q2M4810c8oWrumgVzh6U0W6mJUV4V3kZCWW
         aRrdNtlKfSSWrXmXKXaChHoVKSplfU2y85E62kQntbl8+elLWw6JKpip9ut5IXYdlmNW
         W65sQy4z9QXn4fiHcs0iBbrRrvwT5koOJmiOti+aZHKietiXYrHEiZNLFaT4BEVYzN+W
         zNZyYSIekQm2Nt3+W0n8+DB6a9P8teqNDpSYvLBUpvqJ4SHcxUdeZNOK+DHmwJOQGYKD
         IvLA==
X-Forwarded-Encrypted: i=1; AKwUvBwwnr3wNdjLE3phUcC0NEEODlPJQzULGz0lsaQ4hQUIj3XznI6FzNboJvPraB4aIsSr4crZcbw=@vger.kernel.org
X-Gm-Message-State: AFuF++nsOuRgl37m8wjM7Ge27521lPW5B0WRerpl1F4E9uJgThHw0tfP
	gRu6je3LRpshpXdgjMNmD4gC+i7YsyWL1Z5W4lABKkcG6WkbY07GQFVfoH3AUO/Sc0kceXDKeR+
	+R81Ws4s3qyHoNnBj2kKyc/8fBFpD+XOzBXqz
X-Gm-Gg: AYBFou0aiypBMzjbsh4xBJ3EHoKAjwepK5DMiKpGo2YmwNUfTM4opae6qJnzihFzNu2
	+8XEozEwNiQXUIicPsu8Dbx2O5C8xzgFdwuSv1YTGXu9clTksuzmZuYhPSjvFpSwOfEj6qv4HOi
	XgHKWtiU0CYqcdfuRu5SZnWLc5ce7dqWU081wb+HpKKlE2QQhkVMQzJ/AHbJiJZbiN1G3uq00I+
	CGxkpY97MIoUovRU+ry2niiqvWtw8YJ6Bj2ukQefofrUhqr4WUI1BqY+GYbfHHV3i8oH5P2n2/B
	rCVXBy//Jl3O1QqBd2ULzoddUw6/LCWYPvGfoyPoGUmfvg9a3zMukREx+kJdeuHN1Aq53iY9knn
	RByzC1ZACVT9+ILfdJ3QM0xXztX03BguAha116oM=
X-Received: by 2002:a05:600c:1daa:b0:49c:fc6c:bdfc with SMTP id 5b1f17b1804b1-49fc574643bmr157725415e9.19.1790034952055;
        Mon, 21 Sep 2026 16:55:52 -0700 (PDT)
Received: from c14-smtp-2023.dev.purestorage.com ([208.88.158.129])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-49fdab8660esm1052625e9.0.2026.09.21.16.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 16:55:52 -0700 (PDT)
X-Relaying-Domain: everpuredata.com
Received: from irdv-tmenninger.dev.purestorage.com (irdv-tmenninger.dev.purestorage.com [10.32.149.15])
	by c14-smtp-2023.dev.purestorage.com (Postfix) with ESMTPS id 6F2F73417EA;
	Mon, 21 Sep 2026 16:55:20 -0700 (PDT)
From: Tim Menninger <tmenninger@everpuredata.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Badger <ebadger@everpuredata.com>,
	Jon Curley <jcurley@everpuredata.com>,
	stable@vger.kernel.org
Subject: [PATCH] NFSv4/pNFS: Preserve layoutreturn seqid while lsegs drain
Date: Mon, 21 Sep 2026 23:55:20 +0000
Message-Id: <20260921235520.502987-1-tmenninger@everpuredata.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e20772cbdf46 ("NFSv4/pNFS: Fix a layoutget livelock loop")
changed pnfs_set_plh_return_info() so that a zero seq argument is
replaced with the current layout stateid seqid. This ensures that a
pending layout return has a nonzero plh_return_seq and does not
continually invalidate newly acquired layout segments.

pnfs_cache_lseg_for_layoutreturn() already passed zero to this helper.
Before e20772cbdf46, that call updated the pending return iomode and
NFS_LAYOUT_RETURN_REQUESTED state, but did not change plh_return_seq.
After e20772cbdf46, it also snapshots the current layout stateid seqid.

This is problematic when an lseg that was already selected for return
takes time to drain its outstanding references. For example, suppose a
return is established with plh_return_seq S. While an lseg covered by
that return is draining, successful LAYOUTGET operations can advance the
layout stateid to T, where T is newer than S.

When the lseg's final reference is released, the path is:

    pnfs_put_lseg()
    -> pnfs_cache_lseg_for_layoutreturn()
       -> pnfs_set_plh_return_info(seq=0) # advances plh_return_seq
    -> pnfs_put_layout_hdr()
       -> pnfs_layoutreturn_before_put_layout_hdr()
          -> pnfs_layout_need_return()
             -> pnfs_mark_layout_stateid_return(seq=lo->plh_return_seq)
                -> pnfs_mark_matching_lsegs_return(seq)

The zero argument causes pnfs_cache_lseg_for_layoutreturn() to advance
plh_return_seq from S to T. pnfs_layout_need_return() then uses T as the
upper bound when selecting lsegs for return, so layout segments acquired
after the original return was requested can also be invalidated and have
their I/O cancelled.

Under sustained I/O, those cancellations cause more lsegs to drain,
whose final puts can advance the return boundary again. This can form a
positive feedback loop in which newly acquired layouts are repeatedly
invalidated and cancelled.

This was observed on a one-client one-DS system under sustained
direct-read I/O over pNFS/RDMA after restarting the nfs service on the
DS, where the repeated layout invalidation and cancellation caused
severe throughput collapse.

When the draining lseg is already covered by plh_return_seq, pass the
existing return seqid to pnfs_set_plh_return_info() instead of zero so
that caching the lseg does not move the return boundary. If there is no
return seqid yet, or the lseg is newer than the recorded boundary,
retain the existing behavior and snapshot the current layout stateid.

Fixes: e20772cbdf46 ("NFSv4/pNFS: Fix a layoutget livelock loop")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
---
 fs/nfs/pnfs.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4f9c0f639014..69b085482921 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -596,9 +596,17 @@ static bool
 pnfs_cache_lseg_for_layoutreturn(struct pnfs_layout_hdr *lo,
 		struct pnfs_layout_segment *lseg)
 {
+	u32 seq = lo->plh_return_seq;
+
 	if (test_and_clear_bit(NFS_LSEG_LAYOUTRETURN, &lseg->pls_flags) &&
 	    pnfs_layout_is_valid(lo)) {
-		pnfs_set_plh_return_info(lo, lseg->pls_range.iomode, 0);
+		/*
+		 * Avoid resnapshotting the current layout stateid for an lseg that
+		 * is already covered by the pending return.
+		 */
+		if (!seq || pnfs_seqid_is_newer(lseg->pls_seq, seq))
+			seq = 0;
+		pnfs_set_plh_return_info(lo, lseg->pls_range.iomode, seq);
 		list_move_tail(&lseg->pls_list, &lo->plh_return_segs);
 		return true;
 	}
-- 
2.34.1

