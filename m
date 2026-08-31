Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BB3AFD18
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146564; cv=none; b=lqvdq9UgbnXvnGa5Il09cWKl2q7Cd0fQdeB2fXBrdbCfsQ8iOwZlgqppJSwK6BC8C7F6mJz5II7EFr5TCCxTS9b3IWJzVB246tRJ38gP4wMUCPSrkOcqr8n2k2FGHuszyZOCBlA6vYIAjWrYNe4iInEzBabVfYFMHuYs74scZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146564; c=relaxed/simple;
	bh=9eab1Ug0WGCX0xsa+x5NiHyl5ySOu/jMMIlPEitNPZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZTsSJHL8vh9x88rJBONs9Md1wXsxr9D6V/sWrcwJqwGNCNNBsg3qhOH7wv+DYdgrE4CoTSIV+akP++zBvzCGos38JyxP9jz/7OXxPgpfo5lgwdMcoqYXmVDzG+PFAY7pgF6fm3ijUeBNz6NskX5ewIR7BOTmcav8wYmdr8674no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbScSo0S; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbScSo0S"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso30599935e9.0
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 20:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788146561; x=1788751361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pj7FttHveHsPvvny7SS1xjXRNHz60H2d3ikDjjOI8Ks=;
        b=IbScSo0S0Uzu/tYV1tkEVvvU2O3CexJqzh/O2hmbSm47+1IJO/pKJVYS+GxQTINDXD
         h5WyqQcQL7zfmWDVyzlEOfh/bhFFByMgCkA2VxfdLEzdF1xX5UfZ263jRTYe5NXyKmge
         Ij1/r4+olul3ngcXFJhhVu/7xu/ByhJvoSwqCEUSFYkKwvWQQTjLOWcH3LUHZT8U6qXw
         Yd6vhJbqm81SU/EZKd7a9RmRpT3f+mPjByXhPLXuvac5zll17paAiS5pT4eCrIU5HeBY
         JmNlWX++BhebTWXrPj25TNNpSfeV6rnKWttyOIzF13bw9AvChSTTfhzsqAp5ZhhPlxpC
         Q2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788146561; x=1788751361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pj7FttHveHsPvvny7SS1xjXRNHz60H2d3ikDjjOI8Ks=;
        b=kWDiKe2vo/GPpNcCl8Fz4pfGWa24ar/nSSZVv9e7j8eKM1QOZAqpJ7TPYU1tiGdYIS
         lYDogUurXD14pjbHRzxMYTZ5gSKdSW4qaBknjV2J78Lvj0p6+CV7bvkLb8yEZShyC2+o
         Nz4LNQeEnHtOtHLjtueWztTcW3wt7FepzKZBeh34wQGcBrDXXfRtmqOajQZWswSgroCJ
         qOyd+i+utqEjUxYU3udqdyVJiLTTKkF44NG1/bwoG/PCfBWgMQHQVdJ+cORUpRV0USrN
         NPH1ezSijlXNePlwwPVAxhrFo5rLDWFp4mptMT5GVDx1H3J6ApIdiBhgNoHjnj2Hzexy
         /70g==
X-Gm-Message-State: AFuF++k+9B+NaGBiS+/BmWTmboCT2E8ovRqCcyR+WlJ9RLUhxUPclUf9
	lbBRISYiL4KN8kjR92JaGO3TVRAzfFrhHCNWBqQQ0ydUWjBq0jwLiMQFFbC4QMAt
X-Gm-Gg: AR+sD11sBxCGsB5kwIZ4MJ9kZAoeHqphlEHEqe1biwiZSNzge2ZrH6NL7S6zkQxm2la
	sj3Dphq4JpbHKaDRymr9NJcf6gGutxMynMjptXevh3UEjWzrWFKtQ0VkEcNuVbyysefRfZ3CAJ+
	6QNLJAhb2NGGDoki8+Hi43V18pCwuKV27NEmsXCahBNZ/rEgfXGrXdakI8xvIhXQSoFpktZO5ZI
	PN8v/gZxMA70/9snM2l6TLry9wI9YyWGPECE2l3/r5ZCrr0CTem0rc6exDLVnA+qr4lTyCDaJg6
	jstOwOOlU9KUvj9kF5g2XJs8kqkahxsyJFESD07YwRWTYLWOKntEbzfx4oO0vPfymvDPEMY9trO
	2poITHEWhkTnv1zbpJrg20j2O/kAGwE0dL5lW4Rfb5RqW3di33eu+yljUOHagl5RAELHpJhoVED
	86jPs92xz0aVHuiHnkvw+WxmEIt9Xb1xtSzs46+tZMfexBi9ZjPfTORdRxF153RzWmUPHYrq0z3
	+KXM3A9Zh3ysWyptz4Uh8S5oJtSLncaTGzAvlZiSit00qaAEyl5nlafPK3/MKVQRJCXmplTHNmX
	4K3qU6lsGyZIXH2vAW1FEiSR39avyQq1n5mSVWzrrwb+7FLy1rutTWB4c6DVkeO1Ukubb8Ap0DV
	t
X-Received: by 2002:a05:600c:4f49:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49cd52b2c93mr92737795e9.0.1788146560869;
        Sun, 30 Aug 2026 20:22:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acb9-0201-68d0-34d2-ad1a-175a.310.pool.telefonica.de. [2a02:3100:acb9:201:68d0:34d2:ad1a:175a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cca3e642dsm144422935e9.2.2026.08.30.20.22.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 20:22:40 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 6.6.y] xfs: remove file_path tracepoint data
Date: Mon, 31 Aug 2026 05:22:32 +0200
Message-Id: <20260831032232.25432-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2026033027-colonist-hybrid-82a4@gregkh>
References: <2026033027-colonist-hybrid-82a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit e31c53a8060e134111ed095783fee0aa0c43b080 ]

The xfile/xmbuf shmem file descriptions are no longer as detailed as
they were when online fsck was first merged, because moving to static
strings in commit 60382993a2e180 ("xfs: get rid of the
xchk_xfile_*_descr calls") removed a memory allocation and hence a
source of failure.

However this makes encoding the description in the tracepoints sort of a
waste of memory.  David Laight also points out that file_path doesn't
zero the whole buffer which causes exposure of stale trace bytes, and
Steven Rostedt wonders why we're not using a dynamic array for the file
path.

I don't think this is worth fixing, so let's just rip it out.

Cc: rostedt@goodmis.org
Cc: david.laight.linux@gmail.com
Link: https://lore.kernel.org/linux-xfs/20260323172204.work.979-kees@kernel.org/
Cc: stable@vger.kernel.org # v6.11
Fixes: 19ebc8f84ea12e ("xfs: fix file_path handling in tracepoints")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ Karl Mehltretter: Omit the xmbuf_create hunk because that tracepoint
  is not in 6.6.y.  The xfile_create hunk applies unchanged.  This drops
  dynamically generated descriptions because 60382993a2e1 is not in
  6.6.y, but fixes the stale-byte exposure and matches newer stable
  kernels. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The xfile_create hunk applies unchanged.  The xmbuf_create hunk is
omitted because that tracepoint is not present in 6.6.y.

Tested on Linux 6.6.155 (a4a971135a2f):

- Built and booted arm64 and x86_64 kernels before and after the change.
- QEMU A/B tests reproduced stale trace bytes in xfile_create on both
  architectures and confirmed that they were gone after the change.
- Ran concurrent file operations and repeated realtime-summary scrubs
  with all xfs and xfs_scrub trace events enabled.  There were no
  workload errors, XFS/trace warnings, oopses, or unmount problems.
- Built the affected XFS trace objects for 32-bit ARM using
  bcm2835_defconfig.

 fs/xfs/scrub/trace.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index b1e6879a07310..2634b28e6e616 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -784,20 +784,12 @@ TRACE_EVENT(xfile_create,
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(unsigned long, ino)
-		__array(char, pathname, MAXNAMELEN)
 	),
 	TP_fast_assign(
-		char		*path;
-
 		__entry->ino = file_inode(xf->file)->i_ino;
-		path = file_path(xf->file, __entry->pathname, MAXNAMELEN);
-		if (IS_ERR(path))
-			strncpy(__entry->pathname, "(unknown)",
-					sizeof(__entry->pathname));
 	),
-	TP_printk("xfino 0x%lx path '%s'",
-		  __entry->ino,
-		  __entry->pathname)
+	TP_printk("xfino 0x%lx",
+		  __entry->ino)
 );
 
 TRACE_EVENT(xfile_destroy,
-- 
2.39.5 (Apple Git-154)
