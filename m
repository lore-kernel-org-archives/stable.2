Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E83B5F48
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214750; cv=none; b=Ugtb7L2+Mep1r4mpN4sAnm9LQ3UaBDbyLvwekzDv75cNisn98C3Of4t0m67orARP0YNhSnM8IhaP4D3V+n+9OC45NloFgtjf5fxDKoLc3P89vCBe1sqrDa4waVNFwyMWjqDCdMvMzaqJRJ4fF6BqgyJNNEoN/GoWs2Bl/4DfSWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214750; c=relaxed/simple;
	bh=GeDgxcAAxWRswXI0bO4TJ+ASumLxQqwI+egxlfWdMac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCgUxU6vVXNgvTeaAx+4y1nSbzkrWPCVxsVkblVkLYPwln9PqiOotBN11IfioVA4saPwW+UXgIUxHHuIYopzJ9IJHt16mZGZ7mz5YOlFezchZrvab5K8m7ElbXW2UFMbVbv9T8m10+bloh3XmvILWgqN6MEs5CXEoa6JQnoX0jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pxu3Mhcr; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxu3Mhcr"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4827cc09f20so236544fac.0
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790214748; x=1790819548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1cN5CmufZWfppAn2JUAeeUtUy9gg/Lw5nvjqwMTeguM=;
        b=Pxu3MhcrFOM4FmLBFLHQZzDwsZ06cznT9HutdU9PpyBIwURqu3QlQ6Jzm1j+A6BdtD
         cUTwkabchRec+PVymZLVnadUCQ0mgIQ9TQf7DNxyWDOxgK9w+5rfK5c0QtKbmUjIpsmi
         YLRFYbD8U5AUPrH2qY9hyeYceZpPHJFFZAvzuMaKs+b8BlWDfHqDIFuXM9vUS1dxLZKy
         yMwUZLmexyT+bugSNyOn28nQ2xkUjFpn6ZMMwvD3eNgt5daHYgW3YTOmr0/s0N9My/lE
         vwElVgbLBSohXULeCzh/qY3z11kNUzyKSeSO6Y/OL3hD2fjixANr5GDMPvizte/Pmqyw
         mQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214748; x=1790819548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1cN5CmufZWfppAn2JUAeeUtUy9gg/Lw5nvjqwMTeguM=;
        b=zWVtxWI+SdRmeP3HWG6ecTHL0orL56NdQfmxZvX8SYk92ggjX51lYmt/lGniN2/MG4
         78wgmhljIPT5syNZHYzdIfEF5OJPxIOovLE+cmo+QDqalZyKdVLL9+7q3VLQsX8SBNLh
         xdMvSwmMLLjkqGuCLydF8csIDdvoCM2MFYAw5AWRAYub6mz5K7zHPA9JaE91ihqG8cTB
         Jwa99qH5zmPdjeIHWX0ZkRQOboj+DIA/9m2Ko02h7sK23cER9bkYMoIJEvSuBInxoZmj
         NdsfQK6KlR6rEpdI5nqWSQn8QC+DblNvSshri6Ax2CGryO4cvORZrFPq2Ugywh7CtvM2
         r/7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzC9vQpo52nY/qRCjY0hacNnyN8Qbe66cYURBCRLh8HAAC/feDV7sZ0LpDTznPqSd317OJ28/E=@vger.kernel.org
X-Gm-Message-State: AFuF++k6Iz0GsXL4R+0ME7YVdd1ai6dih+GorDoszxyfCNq9UHYbVbXM
	sKQ+srOs2QpL7yT/wYpNd1wA0MAubYfw6MMcsqCzm1DDMWkEpU1hPini
X-Gm-Gg: AYBFou1M/9EWiZMlIsJ1H/5zm+z6y1Y5YVzLlNnsxLe07mlhg1hCicgd/lKjkNvxv6K
	YiflrYmj/V4zc4lMXlSXbjxPXS6ljPS06qj3kJQxbk1hWWvVgAt+ticikyUt4ZH5P8+iNw99P+W
	izj+q8jv9tEm45fRSA8mMMWtZQh+NudZPbYQE65WrSY3hAcMJiOUh1No6fYXcmUGR56COjte74I
	vRRfDXrEWhZ+o9wZlCu6rd6va4ZDBLVIyFSp/CLD1JoQOqsfKvisR4HyPK8p/omiZYUx1VdcR0p
	MT4h2FpUF72XNAItFik8JOh1gx9bPoDtVJRjzt//hAvXjS63nwJIQUctCJvdjC5zdOfBeFffNBD
	BhsKv94/jkJTFUelchWQGW825HptAJ4wKoZ879mm/haDMw2EjGnRyw8WQiWstXF39mMzft8eBo6
	/FXus14OwtrH1cqSMgKzOcnD3Ae4P5LoCduBza4SX+xhsBhxHX2AkNwYu6NiN5RLpiQYvQi/GcQ
	xh6BLnjeFOwaur/hYxzGbMm4DpWkb6/vo9D/Uct
X-Received: by 2002:a05:6871:3a28:b0:47b:e30b:893c with SMTP id 586e51a60fabf-491e9303f7fmr908800fac.6.1790214748117;
        Wed, 23 Sep 2026 18:52:28 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491ed1ebc62sm1057379fac.3.2026.09.23.18.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:52:26 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] tools/nolibc: fix readdir_r() with 64-bit directory offsets
Date: Wed, 23 Sep 2026 20:52:20 -0500
Message-ID: <20260924015222.31693-2-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924015222.31693-1-danishkhateeb03@gmail.com>
References: <20260924015222.31693-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

readdir_r() stores the result of _sys_lseek() in an int. Directory
offsets are opaque cookies which can use all 64 bits: ext4, for
instance, gives 64-bit processes 63-bit hashes, and
0x7fffffffffffffff as the offset after the last entry. Truncated to an
int, such an offset is negative about half the time, and readdir_r()
takes it for an error.

Since commit 4ada5679f18d ("tools/nolibc/dirent: avoid errno in
readdir_r"), readdir_r() fails at the first entry whose offset has
bit 31 set, which on ext4 is usually one of the first few, and returns
the truncated offset as the error number. Before that, only -1 counted
as an error, which the last entry always hits: readdir_r() then
returned errno, usually 0, without filling in the entry, so the caller
got the previous entry a second time and never saw the last one.

32-bit processes get 31-bit hashes from ext4 and are not affected.

Keep the offset in an off_t.

Fixes: 665fa8dea90d ("tools/nolibc: add support for directory access")
Cc: stable@vger.kernel.org # v6.15+
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---
 tools/include/nolibc/dirent.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/dirent.h b/tools/include/nolibc/dirent.h
index 2dbf4052b85a..19857369de2a 100644
--- a/tools/include/nolibc/dirent.h
+++ b/tools/include/nolibc/dirent.h
@@ -81,6 +81,7 @@ int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
 	struct linux_dirent64 *ldir = (void *)buf;
 	intptr_t i = (intptr_t)dirp;
 	int fd, ret;
+	off_t off;
 
 	if (i >= 0)
 		return EBADF;
@@ -100,9 +101,9 @@ int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
 	 * readdir() can only return one entry at a time.
 	 * Make sure the non-returned ones are not skipped.
 	 */
-	ret = _sys_lseek(fd, ldir->d_off, SEEK_SET);
-	if (ret < 0)
-		return -ret;
+	off = _sys_lseek(fd, ldir->d_off, SEEK_SET);
+	if (off < 0)
+		return -off;
 
 	entry->d_ino = ldir->d_ino;
 	/* the destination should always be big enough */
-- 
2.55.0

