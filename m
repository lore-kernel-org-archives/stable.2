Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30635B631
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115973; cv=none; b=ot46Bs6jHsxraC8HV2mXomLUX81/kr3r9VmU3KCq2g5wLte3asroQKvOv2K9vSrp3zc5MGu701j9yzkRK1RG836ortBmyn2LGiH6jV89Bg98ysWA4BXPRylVNke172GRv48XoQULdJX3/m7+EG+7mI3iw8hjQNRgNORFk1zbZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115973; c=relaxed/simple;
	bh=uF25b95PLgx5yVYjljqzuwnIrBKWWhcXbVieSHoSrPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIi4IwvRRcE6VbtqxsgjoIUtNNMpSfzbokB5tNbnaufvDiXrQ3WI2jwBAiOkUm4KVJ2xr28ERA6/nD3+mKr/QXdWCQghdJqwvbs0jnGCgZ2KN4l6VhhXkkOzehPG8UTGNGun3C8RKNUgfKl/Hrfd3+2MrH7GjIc42Rfq8RtoEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQpF6Xgp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQpF6Xgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30C11F00A3F;
	Fri,  7 Aug 2026 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115972;
	bh=MVNbRlCA0xFKjh3bVvBRAMcccSKPbAmeWdDpBHFDcxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQpF6XgpA/6q46MHVAfq3JRw+WKpVuFsC6pmg7ewjgJ0o86kABFpyQ3PE0R9svigI
	 yeweui8OzinQ/njvFXwDaNE8E/L2WwfJ0XzU439MiJitsXVTkDRgrP3a8ZctqPSsfZ
	 9kAuY8/hygXXCnVyxwVgQ0BR3rbxNog/yrBiBGrgVeZ7Q7Bn2767nrkt6ILd+KZs40
	 Ibhi1IsGZnn0egT6Ix5GBBy7elL8NIMO4XcMKTyuHD2AVwOrHDfEAyED+M0PB+tajG
	 +RjG3OC6pZ99rCTum6WMKpnJayoUfRpNYcc74xTDNxt0AiuUU2C0o3qsoz+hHC8nGi
	 TLr2Yx48mBPgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] ceph: fix writeback_count leak in write_folio_nounlock()
Date: Fri,  7 Aug 2026 11:19:26 -0400
Message-ID: <20260807151926.2227006-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807151926.2227006-1-sashal@kernel.org>
References: <2026072946-idiom-facelift-7c9f@gregkh>
 <20260807151926.2227006-1-sashal@kernel.org>
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
index 72f72ed69723f..e5ea8fb6d9a6f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -746,6 +746,9 @@ static int write_folio_nounlock(struct folio *folio,
 				    ceph_wbc.truncate_size, true);
 	if (IS_ERR(req)) {
 		folio_redirty_for_writepage(wbc, folio);
+		if (atomic_long_dec_return(&fsc->writeback_count) <
+				CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+			fsc->write_congested = false;
 		return PTR_ERR(req);
 	}
 
@@ -765,6 +768,9 @@ static int write_folio_nounlock(struct folio *folio,
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
 			ceph_osdc_put_request(req);
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+					CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 			return PTR_ERR(bounce_page);
 		}
 	}
@@ -799,6 +805,9 @@ static int write_folio_nounlock(struct folio *folio,
 			      ceph_vinop(inode), folio);
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

