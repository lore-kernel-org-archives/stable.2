Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679811E515
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785205399; cv=none; b=dIaSfVz9w8wWimtK44tCAC7cJqad5GqMoQcSWF8RlauNyxXQOwPiOlLe/qHps0Qx2Pk9Yt0EJqFiMJIq2hCdCpGCJLnb6tXpqIS0aT5yqzGnjyORQJNAe6nUpxXY7PQEZDgQOrz6vFV2s568AaM7GdaJ3Byz+F26EpbbVTpuCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785205399; c=relaxed/simple;
	bh=4+PNToQ0P1ufcozGR2WIvvV9Qbs36GVV+YUjtcQ1E0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FntK2JA+tg7kjsNfcYaM1uECIpjJ7AuiXDk2ukmhOrqsBdqJvwdX2Lv1E724RbOQ1vQpt+X2gJ6N+EcAZTY9N4dk4KKYu0GH8ichENG1/5Dg/VLPf6Wcv8PPCrbKyqTbsbhBG5ys/+9dcnVBzvb67nNpJKlASeJAIOj28tS5+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgoGUdOs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgoGUdOs"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e08baf860so3511648a91.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 19:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785205398; x=1785810198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cbQyvDgv29JlNpT12GPIHTmAjrSEhbRccdxDK/svQ+g=;
        b=lgoGUdOsJsZjmcx33OxhFKUprkClNOd0eqUjV5G7dyIZI1gTNuxauC8Pn7nfTddrJJ
         kgZx73xctLyT0m5+xYing7twZSDvFRTKEFRIGvSTnAnPUL6OIyBkXlZazTxSUUdURal/
         Yow9zHrYtzO+U648qOnScuGxBNe2Tks9zaGPtXMLCyVg5liOOnjhZO+x8sZ0k1uja63r
         SsIgimOEZHY9AgMIBG4LCeIqTt57a8D+h4YjWdlFl8G1sl+5mO/gwcMO6BRMT5Y384bT
         kPDQMhsUCJfIrIZyK2vl9yA5sYUJJIrQBGhtqIUXmZc9K/CC1Jzxh1401dsaHf8g1+Wr
         C4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785205398; x=1785810198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cbQyvDgv29JlNpT12GPIHTmAjrSEhbRccdxDK/svQ+g=;
        b=i59wrG2Vj6VuTPDARgan7/q9lcJdtQ3YV0wr+8bKRWSqTxPuD2MSc6U+oSN9iGxxDc
         JWzhckZmk67rwrE6VbOPcODSte7DA3IQuQYfyFjXqAzoDCMBvOJVA7hy5B2Qocdo1JgQ
         VusY2BiWxx53bkshlc70p+eh2Pxe4kW5BchhXD7PpSKtjINaXFZFNFZRz3lM3VoHFn7L
         OPLxfQvbG2lYSavub6LqPs4WgAD0sX/wXtnnYDb5oBM1UjnboBYpd4+7NC1bHAzOBRp1
         etPKWRnZPc9+y34F3HYPuZ6jBDhrinCppaLT4EBJTuraOKh3LnpQMFuxTT/3NvfnyQGY
         EW5g==
X-Gm-Message-State: AOJu0YyaHNHn5Aiaf/rAtubdC3laB1S2pz2ljutimh1PuW8eknZnL52G
	jfOAcas2fnwDTd3Le9uZZ25Gm+nUVlJ985uuNhs5FCsQhYo/a0yMgoAW
X-Gm-Gg: AR+sD13Ejr8DcX5eeeTNBAEgG6R1Fabyei4ssUd9HyynOzepWbcA4s2HvI/hIMyJW8T
	KSE+zfKYNiWTyWwskcv9o2LDju06qWF2a3Amw85wJLDtAWpH0GyHySOyl3Hzj9BPRqJLl0TL47l
	+lYndTiox7miwNtlKp3LcCQMYYUJv7RNRm97sN5pnqgiBU2hM0/XgWjj3k3VCuUcUQXK/9m9Vgg
	Il0i7CZlRxQM3x0iIyA3F+MRV/WIxO0F3VcANDO5Bic5Et9cUqzwAQ7DRnbfd0PCLCybNRuEWN2
	MkEtxzhUZld7/iuVitVfAIfnbaNixSuBpolRvcck+H6xxBh5xe7IIRpbv8WQiPZwlqX2LZ1TDRA
	PkB8TaGb2TpdeauNYN9V0AKa00wY+hrfYFjKzpRbvWNAwi4OBpsgCBfH+oPV5rUhahPpBX+G6vf
	rHDQIH54a9AE+yHddqaijd1zgaMGoBTBDMszPVka8oU51QtrJVJ2Gxbfg=
X-Received: by 2002:a17:90b:3e4c:b0:36a:8240:2477 with SMTP id 98e67ed59e1d1-38f6a4763admr429909a91.19.1785205397711;
        Mon, 27 Jul 2026 19:23:17 -0700 (PDT)
Received: from JIAPENGLIN-MC0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6412a118sm543437a91.8.2026.07.27.19.23.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 19:23:17 -0700 (PDT)
From: Lin Jiapeng <ljp1205831794@gmail.com>
X-Google-Original-From: Lin Jiapeng <jiapenglin@tencent.com>
To: cem@kernel.org,
	linux-xfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	djwong@kernel.org,
	jiapenglin@tencent.com
Subject: [PATCH v2] xfs: fix exchange-range reflink flag clearing issue with  INO1_WRITTEN
Date: Tue, 28 Jul 2026 10:23:03 +0800
Message-ID: <20260728022310.99955-1-jiapenglin@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When exchanging two full-file ranges, xmi_can_exchange_reflink_flags()
can move the reflink inode flag from the file that currently has it to
the other file, as long as exactly one side is marked.  This assumes
that the file contents, and therefore all shared extents, are exchanged.

That assumption is not true when XFS_EXCHMAPS_INO1_WRITTEN is set.
xfs_exchmaps_can_skip_mapping() can skip hole and unwritten mappings
from file1, so an exchange can complete without moving every mapping
that the earlier flag-swap decision accounted for.  In that case the
post-operation cleanup can clear the reflink flag from an inode that
still owns shared written extents.  Later writes then take the
non-reflink write path and may update blocks that should still have
been protected by CoW, which shows up as data corruption between
reflink-related files.

Fix this by disabling the reflink flag exchange whenever
XFS_EXCHMAPS_INO1_WRITTEN is requested.  The contents exchange can still
proceed; the conservative outcome is that both inodes keep the reflink
flag.  The regular reflink flag cleanup path can drop the extra flag
later once the inode no longer has shared extents.

Reported-by: Lin Jiapeng(TencentOS Red Team) <jiapenglin@tencent.com>
Fixes: 966ceafc7a43 ("xfs: create deferred log items for file mapping exchanges")
Cc: <stable@vger.kernel.org> # v6.10
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
---
 fs/xfs/libxfs/xfs_exchmaps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index dcd0bd0b13b4..3efed37cb98a 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -959,6 +959,16 @@ xmi_can_exchange_reflink_flags(
 {
 	struct xfs_mount		*mp = req->ip1->i_mount;
 
+	/*
+	 * The INO1_WRITTEN optimization can skip exchanging hole and
+	 * unwritten mappings, which means we cannot guarantee that all
+	 * shared extents actually moved to the other file.  Clearing the
+	 * reflink flag of an inode that still holds shared extents breaks
+	 * the CoW write path, so refuse to exchange the flags in that case.
+	 */
+	if (req->flags & XFS_EXCHMAPS_INO1_WRITTEN)
+		return false;
+
 	if (hweight32(reflink_state) != 1)
 		return false;
 	if (req->startoff1 != 0 || req->startoff2 != 0)
-- 
2.50.1 (Apple Git-155)

