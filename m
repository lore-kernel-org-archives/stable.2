Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4E46F481
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140616; cv=none; b=TnRjLSZM5HFTqCGMEBUGdSJxyG03EfA+Hk4nh6/r4/tNqa2xRYcKZDfkQ+CEyl+1l2NGhXpUkLxmboBsUxJu2On1mqNvpIY838EpnLJCzJOxCliqGX9sultD/XVBpmsYvAIVVQVasPahzIIfWsVj2DlrCAcA56UTO7ILt7DJ1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140616; c=relaxed/simple;
	bh=UNRjquDQEWAiqyL5vmTUH+UIA13vcwQKRMs2tV796yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2n4rIQ5+vD21qdojK9nw5/mPm+xGUbJ2qHSnZfOnmkhqk4ilqrRJSXygJTJnOn7GXc1uFkIAGdrQagqTDn8mBE/gPBqTXMdfdutr6qoL5bfHFp3+fN4Yqk36X3aBqwlaYW/I+f2G1hlI6bvcBSVpAN3G6OAA3UW/+U/8X01ZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIMjOAqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIMjOAqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B25D1F000E9;
	Fri,  7 Aug 2026 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140614;
	bh=+VOgBSmlCCw4CD5Uc6xIQk3aqTnATj4FJu2FGrUzJMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lIMjOAqBbfLTAxpXMVUjz4WRPu5nX5yXc3Lmdae6c6sQceLc7Y0XP5pSbNXNzEHGW
	 JqXRxINzXG01zgpqneDFjmYVpYRf6qyGtbRhkyll1/rXK6wDe7ZS5B5N/15CtlJBlz
	 S6qzhYRlSIcPviwCTF+32rSDoQtUwwHAGheWWwlcl7WcUGVSvmg0CS6HzGDdPeoBBK
	 oefj2Op9pBgP3VPmZ4hardWzU7T9nZggCDxIdaRl1PxEi+Kf9RYWqWCIsEjAFTcYpU
	 Q6gokaHw2Eov4Vjp81xRq861kxNT1efj7QFx3rhSrMG3Jx0wKoQkiebhYguD24PecD
	 ADcHu5f/2DbRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] ceph: fix writeback_count leak in write_folio_nounlock()
Date: Fri,  7 Aug 2026 18:10:08 -0400
Message-ID: <20260807221008.3785418-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807221008.3785418-1-sashal@kernel.org>
References: <2026072947-gulp-passivism-4b27@gregkh>
 <20260807221008.3785418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit cbf59617cd715219e84c50d106a3d0e1e8ba054e ]

write_folio_nounlock() increments fsc->writeback_count to track
in-flight writeback operations. On several error paths where the
function returns early (folio lookup failure, snapshot context
allocation failure, and writepages submission failure), the function
returns without calling atomic_long_dec_return() to decrement the
counter.

Each leaked increment keeps the counter above zero, which can prevent
the filesystem from cleanly unmounting or suspending writes.

Add atomic_long_dec_return() calls on all error paths that currently
return without decrementing the counter.

Cc: stable@vger.kernel.org
Fixes: d55207717ded ("ceph: add encryption support to writepage and writepages")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/addr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 57086663a9bf9..c63ed9fa1ccd7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -724,6 +724,9 @@ static int write_folio_nounlock(struct folio *folio,
 				    ceph_wbc.truncate_size, true);
 	if (IS_ERR(req)) {
 		folio_redirty_for_writepage(wbc, folio);
+		if (atomic_long_dec_return(&fsc->writeback_count) <
+				CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+			fsc->write_congested = false;
 		return PTR_ERR(req);
 	}
 
@@ -743,6 +746,9 @@ static int write_folio_nounlock(struct folio *folio,
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
 			ceph_osdc_put_request(req);
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+					CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 			return PTR_ERR(bounce_page);
 		}
 	}
@@ -775,6 +781,9 @@ static int write_folio_nounlock(struct folio *folio,
 			dout("writepage interrupted folio %p\n", folio);
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+					CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 			return err;
 		}
 		if (err == -EBLOCKLISTED)
-- 
2.53.0

