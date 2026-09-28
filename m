Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A210847B423
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585303; cv=none; b=MKCDTKmjNRS6r9TdVJGsYtHJCLUJ69VooG33FzcGRpHgxKfXr30pMo2Vk1mhHWGg2JPDEkkAur1pRaTnGHytW7lVkppGWU6oSdKaJ1MU0Tmj7ZGM3WW4CYh76GwaUcOTv7Zp6kJLXlE60QxLlubj9WGWlv1NWC1DfhrmQo3dWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585303; c=relaxed/simple;
	bh=nGNK4CJ7IAGxiLKQK5N1I+NN+hh0tDC50qXrF7zVWV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtwcyWF/0uaf7EJYWc3MNAdbhANLUfb3+c4YZAiRhApLZ3DO+Au1/ixhj8m2ncLHUT+Lc2SVgylIdGfGNy4LU9eTAMWK2+/g2KCH7MidiwqHgqfxjyPb0cwIDzP6KraswQhm3AcS90YcZ7YrJFHNA6FrNmSIZnW++Hw43krsw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJJpx8b+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJJpx8b+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff23af865so21114215e9.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790585300; x=1791190100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DlTyxrC5JLY4QSgeol6426LcGC8kkaxi4wrrxLeCtIs=;
        b=hJJpx8b+vD0TBgD70aw8kyrK35e9qxFjpsoSa7cSUq9slEeIEJDqY76u6bCmf7cCa6
         m3mZvs0nrJ0U2n+Xwmpl/4/x51CWtvg5d3GGJONzOqErG7sgTQegRZ5NzCGi2rm+15v8
         P7Yh4lEmPzI/aj1jCHFRDOXx4AbnL3UnimiEkhItQ/t7SMxTPT9MYwb6GPkyN2/YIibO
         S59G9QM4x0bFDBK/o4b4CWoWl0hNdNiAlxNOU+CuG8+7WA71rdVdT3Q1s15Q0HrFGhvT
         0ZSqWVnjER0SZMvv+GxxXRfGPS2xl0By6375Lrk8lpkUzXXDQCM9MVKxIx/Ko0wZHP5N
         PkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585300; x=1791190100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DlTyxrC5JLY4QSgeol6426LcGC8kkaxi4wrrxLeCtIs=;
        b=FqLd3+oMSIe22F9GPtITzQTs6uI08pt7tblKZ3p+qitYY9DhJoXoz1JTt+nsZBzJ9R
         wjARdln4BNoS3mmrqglnh2hkYwcfS3vTpC9j7KLNpV4IpP8Bj+RmQoRtCo/hCfw8FBIJ
         badcX6xC7eLYWXa2ILZOsH6g65t+5dJHhE94ylpKrv2caeQEiy0YEqxPBkAGYUqx3Jgy
         JS/8ImEzerr35OwaBf1RKLiYHCZzcKVXi4h925oa7FJsUwOXW8LOUNPqxKem3511S8yl
         JVRcUFhudgN9W+BMduoOIzuPaJQnBj3GM3suKDG5kmYv9BZdV+S24aCTe0mKX0EBsaVo
         TPoA==
X-Forwarded-Encrypted: i=1; AKwUvBy3c370OqSJDTLxwjj9ubdeSOX8vqpJVbMkDSrboH7r9qLW47YgLuyxxe0tnDazgQH7QLx7ZY4=@vger.kernel.org
X-Gm-Message-State: AFuF++mD1m75+GoFUE87UUTqlD4yv1godXHS8Phyp+DDcrUrLHPT6VW4
	JcAVmLZmG+mSxadLumc5wIfpuuS9ldPuzaYz63PFvZUaA3V2hfggcq+6
X-Gm-Gg: AYBFou1+pwPFoY6WgAC4GTtMm1/Hu/LeFFn/b4J+ZejypSar+fD4ZzoYDvhqSf1RTcl
	btF6IioPlAA058nCmIY45xSl6/iauS56aCLsqjniM/mbVnWN7LRZVca1M6OT4Xs3Th+cTsIx/F8
	8Su03fWOsLjLKBq3q2gvh7KiqDi55zify49KCSYvmh0P3xT37E9oLuY5qqYxSe0MV7ppbpXIwpl
	tDE/d7kl4KLDEwGzUpOtpld98RyNL49bKGIha/QQ6QJWLrxVT/25g1GABzgONk+mzNeVVu16xXO
	TWgzwXDXy11T/yEnQTJs2EPKdr8KM+8kqlvZLUGtH0DcvoTQqoKU34s7T+EYbel/7veL7HhOVP3
	PxnqvMeuMGtUoZfPC6udgLkVfPC93j0inqkNY+YACuJ3Rj2xsWspXFfNHpB+m8hRUT4+0iLWEND
	2vpdtjubViwwWP/sSDNxy44T8KTDdpux0qQPrKSNS6K+NF+gOfxnjZ6YYXXamunLiTfZBVj92Ql
	OdJd85VTNK+RdCT6PI51HmCwq/xRKh9cY1KqQJcY8YdUmBNt8lX6GC41Xb/eGepgdOsoV8qKapu
	aW3olg==
X-Received: by 2002:a05:600c:310b:b0:49e:7862:c09e with SMTP id 5b1f17b1804b1-49fe66c6289mr211174025e9.14.1790585299451;
        Mon, 28 Sep 2026 01:48:19 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm182584705e9.5.2026.09.28.01.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:48:18 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH v3 0/4] iomap: fix error handling regressions
Date: Mon, 28 Sep 2026 10:48:05 +0200
Message-ID: <cover.1790342457.git.parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix three independent error handling regressions in iomap:

 - clear the writeback context after a failed ->writeback_submit() call,
   preventing an already completed ioend from being submitted again;
 - preserve an iomap iteration error when iomap_fiemap() has a pending
   extent to emit; and
 - preserve a direct I/O data path error when sub-block tail zeroing
   succeeds.

The three fixes have no ordering dependencies and can be applied or
backported independently.  Each issue was reproduced before and after
its respective fix.

Patch 2 is not a fix and carries no stable tag: it adds an XFS error
tag (requested by Christoph) that lets patch 1's ->writeback_submit()
failure be injected without the boot-param hack used for the original
reproduction.  The corresponding xfstest (list corruption caught via
CONFIG_LIST_HARDENED on an unfixed kernel, clean writeback failure on a
fixed one) was posted to fstests@vger.kernel.org:

  https://lore.kernel.org/all/20260924091338.198407-1-parri.andrea@gmail.com/

Changes since v2:
 - Patch 1: no code change; picked up Christoph's Reviewed-by.
 - Patch 2: fixed the alignment of the new XFS_ERRTAG_WB_COW_CONVERT_ERROR
   define; picked up Reviewed-by tags from Darrick and Christoph.
 - Patch 3: no change.
 - Patch 4: dropped the reformatting of the iomap_dio_zero() prototype,
   keeping the iomap two-tab indent style (Christoph); added the
   "# v6.12" stable version tag (Darrick); picked up Reviewed-by tags
   from Darrick and Pankaj.

Changes since v1:
 - Patch 1: reworded the added comment to fit 80 columns (Christoph);
   described the reproducer in the commit message (fault-injected
   ->writeback_submit() failure on a reflinked XFS file, reliably hits
   list_add double add on the unfixed kernel); documented why the final
   ->writeback_submit() call in iomap_writepages() needs no equivalent
   fix, since wpc is never reused after it; picked up the version-scoped
   stable tag Darrick suggested; picked up Brian's Reviewed-by.
 - Patch 2: new, added per Christoph's request.
 - Patch 3 (was 2/3): no code change; picked up the version-scoped
   stable tag Darrick suggested; picked up Reviewed-by tags from Brian,
   Darrick, and Christoph.
 - Patch 4 (was 3/3): reworked per Christoph's suggestion to make
   iomap_dio_zero() return void and drop the handling of its return
   value, since it can only fail via a can't-happen WARN_ON_ONCE()
   assert; this also resolves Darrick's question about the local
   variable's type.  Brian's v1 Reviewed-by was dropped due to the
   rework.

v2: https://lore.kernel.org/all/20260924091203.198225-1-parri.andrea@gmail.com/
v1: https://lore.kernel.org/all/20260921083133.2960-1-parri.andrea@gmail.com/

Andrea Parri (4):
  iomap: don't resubmit an ioend after ->writeback_submit() failed
  xfs: add an error tag to inject a ->writeback_submit() failure
  iomap: don't lose a fiemap iteration error when emitting the last
    extent
  iomap: don't lose a failed direct I/O bio's error when zeroing the
    tail

 fs/iomap/direct-io.c         | 16 +++++-----------
 fs/iomap/fiemap.c            |  8 ++++----
 fs/iomap/ioend.c             | 10 +++++++++-
 fs/xfs/libxfs/xfs_errortag.h |  6 ++++--
 fs/xfs/xfs_reflink.c         |  5 +++++
 5 files changed, 27 insertions(+), 18 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

