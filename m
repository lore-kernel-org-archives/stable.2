Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8B322B6D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075098; cv=none; b=haJOW57hj4JaDTmIS82lOnSTHddTO2jOdfzQUgAhXIihBQ4G0fA1jgsG3ST5IvjvyTIBWoiLSCd5KCV75pZaBago/HmAPx5QcDxGv77W7W+pDzWOGW7xYLOE+H1+yacVogld7tuYgh9DTXOVNA7vIOnCFGci9+J9+8kg16KNiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075098; c=relaxed/simple;
	bh=owPfq0PSDvB9gawcEBCt0Uj7B7CJIVsxmRmrwDL48/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llP4IKVzUukECpTxkG6vaWRdYm1mWQkYkw6h25EfHnPbeYzS/LKesDyljnAKB0YxXHUSwm5K3bYk01UxzPFBFj7iPIRh64UPc1yH7npvHpuMNFf406DxJqsqiaaz0g+iD5XkWzt3dGliCGcyhtwAr8MwMu92xEq4j7itCk361uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA5LYlbI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA5LYlbI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so24344005e9.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075095; x=1790679895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+lnBZ+IWAlLOWBXKGPYen7OI+mkJxck1LeofjTDj2Kg=;
        b=AA5LYlbIo3gbF+cfhAIUzjPzVmZMw1+wLb1WL43zeZTGg07XAMbisAunT6DQMAkJKO
         r0NrCWSRgu/w7036TzPmQHHayXzW1mzvhZB7W9XEIbg6HLIj73Cl0PnwahqHdHMTvZQS
         VDWqQihaHaDEdumUSxX3HPkyjXLGdlMWa0fG0SihBuMC1Hm2m5Aan9fKSzbN9Q+3DsAJ
         0KHl3DfpsuqJrTa8lW8iKQZZppfSlbNYzxabrxtEm7Uqe71/2ltLHW4FKMlNEPWuoBiH
         eoiUkHj2SIqAFkQ6dXUTaMGe9RkTTAe9BgiVEgWY5q2c3rcdvyojWNuMn6xhi513TrvS
         uf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075095; x=1790679895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+lnBZ+IWAlLOWBXKGPYen7OI+mkJxck1LeofjTDj2Kg=;
        b=PkdLFerofyIlBigHf3D5RieR17LBtUN7ZDBO6EU4XWjLc0TV5mGAIhjy1SE0XwvVbS
         Utf+Z1HjKJ6MG/ZeL1HWkMPaGTEF04NaN5O6iB/OFLBlWp1Zf6ig3PMBQ3zZWkQzR0nj
         FFHpZjBanAx+5gy01SXYdwNrNxJSjuXtfaXojkFBvH/jceqH9CCfIDSpjLl+6GwIb5qt
         brnsX3Ropk6h2Y6KdPycIjv65Emua/IjaIjPJ3hYpGddXO/pjs1aepYTFEIVe2Fpn2nM
         Up0gl0nw5IvW75Lx5wLC95cxmnYV7POOQ/Wcrh9cdG+EeJAcKJJ968/mhjgK4o40s6Vh
         8w1w==
X-Forwarded-Encrypted: i=1; AKwUvBzivDqFWSNQC9R/fiWgmZzkkGvz2zfCFDti3eFrUyULJteXnbaGhyBIdiw2FjahB5vBgeO36Dw=@vger.kernel.org
X-Gm-Message-State: AFuF++lCM/7q2uiFoDXnpKUfXwXnI6ywHVc0spCn0h4GZlyZX6oJy7xP
	IU9OAD+J/aIqkAHvGFTlvtEDm94h+87DcFq/Z5kYhUN/b3hcKKPiQ7tC
X-Gm-Gg: AYBFou0Lc//FzxaXqNKzKiqBB4ZJX3ybRsuTKh4yaEZCq6zXOZYRV3z4rHrpQU//Mwe
	eerA3Yxh1pmyZuabDRLrTcBmWJ6L9pubyNoOBsPZ5+EbQed0rtpTRl/QrG+YUiwJluNHkG+/FP3
	RWfONO9sNviTSW9jF/OYli2q2V7HbEqzGMjdC7j62MYiNH/q7OgWrEMccDzNcjSGdAg9fahf4zS
	se9yAejE8ICDAmZX/vEWSEmgV882wJKnpNZg+wV5u/knmYsGr9nW6LnJVnfANLSr4+8Bmig3KYR
	1US/0K/is3aqZ0VLN5peHMYdkmc6UaJaNS6+PQ82pAyFunkZ6l76EylJAP5KfBALKcTZKj6NV/I
	CUUlx7HHtTgAcGFczSmFZuhf1NZO9OqoTVvu0nBKgSRGVMzkCkoKXK7doFB4ZSyIA5jUOL2tAZ5
	54Wl7MLnZjIw+kHDhBQ07b0auWh7OmnJ9f28urdwB0Erx/US5zGnBBfz6/l6Fy9tcnwTIXuKJx9
	icGzPGlFy0=
X-Received: by 2002:a05:600c:5250:b0:49f:bd0d:59f5 with SMTP id 5b1f17b1804b1-49fc5746338mr203519895e9.18.1790075095113;
        Tue, 22 Sep 2026 04:04:55 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:54 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 24/26] xfs: drop dquot flush lock when we can't find a buffer to flush
Date: Tue, 22 Sep 2026 13:02:19 +0200
Message-ID: <20260922110221.1431-24-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

LOLLM noticed that xfs_qm_flush_one fails to drop the dquot flush lock
if it can't grab the buffer associated with the dquot.  Since there's no
buffer, nobody else is going to drop the dqflock, so we need to do it
ourselves.

Cc: stable@vger.kernel.org # v6.13
Fixes: ca378189fdfa89 ("xfs: convert quotacheck to attach dquot buffers")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_qm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 99a82107b8e6..54d00d543b51 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -1432,16 +1432,22 @@ xfs_qm_flush_one(
 
 	error = xfs_dquot_use_attached_buf(dqp, &bp);
 	if (error)
-		goto out_unlock;
+		goto out_dqflock;
 	if (!bp) {
 		error = -EFSCORRUPTED;
-		goto out_unlock;
+		goto out_dqflock;
 	}
 
 	error = xfs_qm_dqflush(dqp, bp);
 	if (!error)
 		xfs_buf_delwri_queue(bp, buffer_list);
 	xfs_buf_relse(bp);
+	mutex_unlock(&dqp->q_qlock);
+	xfs_qm_dqrele(dqp);
+	return error;
+
+out_dqflock:
+	xfs_dqfunlock(dqp);
 out_unlock:
 	mutex_unlock(&dqp->q_qlock);
 	xfs_qm_dqrele(dqp);
-- 
2.55.0

