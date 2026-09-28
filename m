Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9230486B86
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585308; cv=none; b=RwMcc99aEWMsqa2KDFVLSgTkJyCme9dKAFO22BdSwFcp3HGD65BlcB937/wScRhNmq7RujSAyT3PnzYhDk36fKAF8kfCB0d0N5T8MrAZJ6uw+qRNjcoUsrC+EwrUjr3CjwFWNnqcZBHiBsBzTxY+25TQa8OoojZb1SxPBLCpA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585308; c=relaxed/simple;
	bh=s1sH/1IcCUCWkTuphEUbN/Is/vUMXm3bT7doJt8rKZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJAwc+Hun6SdNtP9yh7faVRy6z0HK4BBYYUZKoJtB3+49IalLXp03G+Fh2apaaWLiL3bWtDS5HM/pWa9LO229rl9iB56WreY6liq9oGjNZHArRz79tN0gLe8lmjNftmqnfEI7MkQm9EVc2kAXB6ke+20Dy+gGxGSzp+KPZ7sgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmSUHuyO; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmSUHuyO"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso14135285e9.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790585304; x=1791190104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DW1aw9XilMAGHwwMkE5gUpMp3JZrQpWAH61R3Ws3XHs=;
        b=dmSUHuyO7LYFvNU6p60O9dadqqst5WT2+e8G68CWxSDA1NnzcP9OssEU9gkRR6jbh6
         rjifG3zE8DY+g+A6qJL3gHZTAdWXoZokb79xdkYUVpfEiv2YKZ2NwE0Cqhz/MBTpDFXq
         69+aNfL/Es00juBasCQ/H3Xki9y6/fGOPUYoX0UH9MBOah6NREFSPZ9ndEeQEkRyWcqs
         Qy5gT4QPJnaj+uby1BskFbCz639B2FgZ5e0AMibD04J4iw63e1GP/SUA9jzhZGFbTFF6
         WIzOWwODvRxV/aN9MnfbhBlU8GhfoTQhg88AXq4sSJ/ONUC6feXOLuoSSQgpOgkeGOto
         KXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585304; x=1791190104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DW1aw9XilMAGHwwMkE5gUpMp3JZrQpWAH61R3Ws3XHs=;
        b=ZzD7BgiOrvIDTYRe3LyBf/3b+ygUwwx6VGEfPbMy3UlvwcevxbpGuoZEqzeTBWhwck
         BnO3eJ+5NYxCyP72BIb7lylM7eMHr8PEBd+1komjbNwkBnoG6VBOHeRiil2rdjANWHUT
         9rjfHdLrZW4TiBwhMf7B1Urwv4yO2SQf/nXhwcywpgysGGqLagybyvcMN6BDOTzFFmIq
         E86At/lZO6e3LuoI3JSeLwLabxw9Gq6LIJ2cdWXlM/aBlB/3Dj1jh+JLN5WhCOUwnnet
         1iTkuRK/s4ZLjmjuR8RUNVnePWE9cwKNKtcPlR92tVH3rZCj6n7C8gYj2lvUb0TQzMw1
         eIjA==
X-Forwarded-Encrypted: i=1; AKwUvByBa9HChT++XWSZkYIH8dQGpE9VWdEQjWU/WkKd9NmV0BiZI3tsm4J/OsjulWndKGLJtbnp8Nc=@vger.kernel.org
X-Gm-Message-State: AFuF++k/cIivGGeI2ooYf/mk2v7gzrzIqJNIIp3EsLE0iqJaCgs+H5Fh
	0YgQfRhXrwplPSo2S/m9RxI3t4H5sqRT79T+PaO+K5Dtmne7d5tgd84u
X-Gm-Gg: AYBFou23sNHzWtvGG4tEdAAYNe40uqTqb5+4hAb4NIdSUN+doBxmtyCXcB2OuGSLzhc
	q0cfsdwqvhyeKZWHaCZ4Ud5xhxeLH9viOZElNNH7joX7BiCQ86K/4qWxH3s9qJ+Gomdhzpif41A
	RTeqfnFhlptoNJdL99d1tBbS+irCqXbiCSRYJsB38Xj3uas4bHU4EnOUKcCD0lRA7q0n8TXsQE6
	CkR/Vtx21wlpJrUDcuE17Ayy0NCQ322WllTHZXGn8B8JuyXkRg3DjPCUIjzpcQ6IKyoPvmC4r1w
	kvySCi+NXa1ND8hPvaWjLZe/6cHg8AeTiQ11E9Ym3c8w2eZUhu8FXQWrYmRwrPVbYCu+NznUBJw
	e4f4bnGAiNXKfT0kOGCohFuBi9v3xJqG6U0gfbsYLDg7leDvLeGVcqsgzBy0iD0UlaFE4vBLXej
	J4sHnrHl/MIF07ug+oqJPBY1bkpKhD+VdHTtWnegcxKREZNtsBvhyR7oEvBBM7vuRvKEVNl3NCV
	5sa96CqvrbLiyOZXUi8OXS0I2uF7SieqJ2lcWT6rrUcZ97M70h03ZIS6ZLwBeVgslQSq7tS0tNI
	LdNI
X-Received: by 2002:a05:600c:3494:b0:49f:ff73:9971 with SMTP id 5b1f17b1804b1-49fff7399f4mr69817225e9.18.1790585303613;
        Mon, 28 Sep 2026 01:48:23 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm182584705e9.5.2026.09.28.01.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:48:23 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/4] iomap: don't resubmit an ioend after ->writeback_submit() failed
Date: Mon, 28 Sep 2026 10:48:06 +0200
Message-ID: <90fbd42df4f51306e57a95830d2d53873f630eb9.1790342457.git.parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790342457.git.parri.andrea@gmail.com>
References: <cover.1790342457.git.parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap_add_to_ioend() submits the pending ioend through
->writeback_submit() before allocating a new one for the current range.
When the submission fails the helper completes the ioend with an error,
but iomap_add_to_ioend() returns the error without clearing
wpc->wb_ctx.  iomap_writepages() then submits whatever wpc->wb_ctx
points to, so the already completed ioend is submitted a second time.

For XFS the second bio_endio() lands in xfs_end_bio(), which
list_add_tail()s the already linked ioend into ip->i_ioend_list.  This
corrupts the list and leaves a use-after-free/double-free window against
the ioend completion worker.  Reproduced with a fault-injected
->writeback_submit() failure on a reflinked XFS file with several
CoW writeback ranges in flight: the unfixed kernel hits repeated
"list_add double add" warnings from __list_add_valid_or_report(),
the fixed kernel fails writeback cleanly.

Clear wpc->wb_ctx when ->writeback_submit() fails.  The old
iomap_submit_ioend() cleared the context unconditionally; that clear was
lost when submission moved to iomap_ioend_writeback_submit().  The final
->writeback_submit() call in iomap_writepages() needs no equivalent fix:
it is the last thing the function does before returning, and every
caller allocates its iomap_writepage_ctx on the stack for a single call,
so wpc->wb_ctx is never read again afterwards.

Fixes: f4fa7981fa26 ("iomap: hide ioends from the generic writeback code")
Cc: <stable@vger.kernel.org> # v6.17
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/iomap/ioend.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 7bbbb417f9152..32ae292a84cbe 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -246,8 +246,16 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 new_ioend:
 		if (ioend) {
 			error = wpc->ops->writeback_submit(wpc, 0);
-			if (error)
+			if (error) {
+				/*
+				 * ->writeback_submit() completed the ioend
+				 * with an error, so drop the stale context;
+				 * iomap_writepages() would otherwise submit
+				 * it a second time.
+				 */
+				wpc->wb_ctx = NULL;
 				return error;
+			}
 		}
 		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
 	}
-- 
2.53.0

