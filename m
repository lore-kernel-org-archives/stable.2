Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9973497B95
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816572; cv=none; b=esRBKHqf7gj7vLqtKZfF1KZD+UuzgHRbzuEMAzasLr8ui6zMOxYuTlIJWXc6Fn1l4dM1WZaz/A1GCz3awgM+wHzZvKc/m3UA9xX5dU0qy5zAcx7gZkiRQ06O0rD/DEntv8H+WzomM5nWqOyCtbFNaZVaMiVcpKGI3t1+yR1dF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816572; c=relaxed/simple;
	bh=c16ZXWH+GRMU9Gv5D5TMERR/RKlvixHWFMYKRCEvbV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MmQuVSbAti40dDNGQxnOrLK37bzu63sSVN+noy2Q6vwbaof1o+SjmASSazJkGavh/DddbnuA/dTamJ2htuZ0OfyBpXw+GivLfH9GRzb1gb1QMtRbwPRHiG9P3UgAA/adq0kQTspo6I7u3gDa6QehAKUWohBAocGQQhqHI4TG06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjUNRMFE; arc=none smtp.client-ip=74.125.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjUNRMFE"
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-3538045633fso1678432eec.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816570; x=1792421370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SNefojtvKaPsWksx1KlDETs9fKwCel6Xh/eUYbsILEo=;
        b=FjUNRMFEC+pDGGGu8b63dqh18hWiqu5fMctk3Z2IyZ2Nr6Ao42/QBQh0xUvFzV5Msm
         FAMZKkpD5pzEYT6ogVyvGuejLAGGRmirA0pCff0245ea1fwpAE+IzX0fnskhqqqwJEHq
         HuIOb2QdL9auLOjXYfT/Guhy63chO03CcQ2mdOZTCNHNEUr2NGwQJi4QmJCJIzZEsS0v
         5eFqEeOpkoPfdUABtGvHvRtqOTU4MKL/H8Q23mUL7ukiZgBJWGdDNsXAZHvzDI0ILMNU
         i394zR2QxRvmAqFkj4nWLafHfJ96uuKLAcMh0Ct18V977s+dTl/VdKjIdGeCjazkCRwN
         f+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816570; x=1792421370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNefojtvKaPsWksx1KlDETs9fKwCel6Xh/eUYbsILEo=;
        b=2L6q5KEPiTv7D8bPw6BYQYobI8sP05aFoeEoTVp5mqvAFlfLpBmMramCwRYDeuevE1
         jW0WVW+rp5CoCw0Ej3tqTy0JFY6a9owIfEe91AMlNb+YojK1UFoANxxq4RT7yLq2hryB
         +JXxLpqBeiF6E19sAAvunjG0y0YnypXgdqaiZY+k5zqsMGx4awCQxMszCSD1tWAN3JsV
         zti3YZo0aGkOQMai55tC7s4QyOmyTGA+TutWJ1R7DxrThk3Dq3LfqgJYAb2ZFw8c9eRD
         TIfv2ezjx4WfJLhNLLq1K1k6SVpPLP/dNA2QyK72+76Urlxnz9eEERFkzm11fB0NQj/X
         Z5LA==
X-Forwarded-Encrypted: i=1; AKwUvBxMcoAf8iYVGqkbU2W476nf6RDZ9Nb2Kol02RuYnd9jP7vSEtwO+AHFAX10K3Q9ZnDfoPmMKrg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoWAm8OhLDduKV1XoU84CqoCjL8KMNZ1dhum3Fxp0PySQzpkR7
	XJsDLZKm+NfHMVNnCqMUIBy3tQ47EFtAs/CKXVC6IqRHr8rhcmUOBdjl
X-Gm-Gg: AYBFou2J1/OQ3xgS3ubR49biL0hdyA6gATLLm+WR0Nr4Vf/DOxgCnhAlu06bG7yXjwf
	aYbkae7aPQbfzyc/zOpPlElxLKg7hbIXs4OYyoc/5orb5d197zFeJCW7B8Bu1bCFIYO26ctHMq5
	GY88Hm2zv8oZ+41UnSX96v1vaCUugeXdzDDRprrPZ/9Cefsl4q2+qM/ideHZABW9NZT7Op2d+v7
	ci3RPlknyIhoU55Zn+668cPTW3BtUJ325k4S1NwAUgp+rWmcrqSHgR+boXzGrf/HBSpDS/RArKh
	umvQ8awQ9TWPVGLlOKPDBh60xOGqw+/yL/dOSIedBH/OUZyiDcBS5a5g5FqikVrnrRDXG8mH0TS
	toj+z3Sp4BDOsIyM6Wvs88/8iizE05dQqaNkuFfXl94FXLIBtqS2tSpRjNtsMiEXcSpG/BBkWwQ
	YBTaeRknXDy8LN9IWBEso7tBWJKcaX9wPtebPeV4GttETcKvGP+my/mfuD4C98HBq4Sj7V1y173
	9POi7kTlZ3cTxSGqfMZS4Km15+TK3Anu76fHZhYsoi4tPMnsNPYhHNS94XtWE1Hq1CGDw==
X-Received: by 2002:a05:7300:a50a:b0:33b:f5b7:f494 with SMTP id 5a478bee46e88-3537df8cf05mr20301538eec.13.1791816569788;
        Mon, 12 Oct 2026 07:49:29 -0700 (PDT)
Received: from localhost (ec2-18-143-158-86.ap-southeast-1.compute.amazonaws.com. [18.143.158.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm11272773eec.11.2026.10.12.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:49:29 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEM DIRECT ACCESS (DAX)),
	nvdimm@lists.linux.dev (open list:FILESYSTEM DIRECT ACCESS (DAX))
Subject: [PATCH v2] dax: fix wrong error code returned from dax_dedupe_file_range_compare()
Date: Mon, 12 Oct 2026 22:49:24 +0800
Message-Id: <20261012144925.6728-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

When dax_range_compare_iter() returns a negative error code (e.g. -EIO),
dax_dedupe_file_range_compare() incorrectly returns 'ret' which holds the
positive return value from iomap_iter() indicating more iterations remain.
This positive value leaks to the caller, where vfs_dedupe_file_range()
interprets it as success (bytes_deduped = len), causing userspace to
incorrectly believe deduplication completed.

Return 'status' instead to propagate the actual error code.

Fixes: 39eb05112987 ("dax: advance the iomap_iter on dedupe range")
Cc: stable@vger.kernel.org
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---

Changes in v2:
- Add Fixes tag and Cc stable
- Add Reviewed-by tag from Jan Kara

v1: Link: https://lore.kernel.org/lkml/20261010021010.19575-1-jianyungao89@gmail.com/

 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6ba50142eeb2..1f6a4fbb97bd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2261,7 +2261,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		status = dax_range_compare_iter(&src_iter, &dst_iter,
 				min(src_iter.len, dst_iter.len), same);
 		if (status < 0)
-			return ret;
+			return status;
 		src_iter.status = dst_iter.status = status;
 	}
 	return ret;
-- 
2.34.1

