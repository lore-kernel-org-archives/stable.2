Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C473CF200
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788039189; cv=none; b=rnmj/fIIIgvXnEm8KhiB1zt03KND8DoetSkizeLFnoOn68badm/E1mysA+Xr9vCQDXXCQVu6BnXQaHfExOr1ndz9b3LLgAXF+YCSDlMk0x+NN5K3oIZupZkuplyEVm8Zxuw/kG8dMH+Q8qpEpa8b0z5I++IuJxEaaYaVUVLnUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788039189; c=relaxed/simple;
	bh=Zt6xM5ByKMqjss0Ju9Pq8lrUfSmBQl0+BHJmcT0gcU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nw4ukMAUCCq2GV+W9Wu+ynFMKQLEYrOxTFYHj9OfJsSlRHxzsupbE9WhO9c1+nATCrutp+99+2rWpUXjn4sMEwau2wmUTqwXnjSWspBgpMdMCIK0/c3RBRECU6pl3ctb8POyH9sQensQwcX4Y8fG19R8xFOMMNmkwMdUbXc0yNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1pRPMGO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1pRPMGO"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f633e6058so1612110f8f.0
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788039185; x=1788643985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ucnD2vvZKQodkVcezxvV4KyyS73dxyfqz8xpesSWdQI=;
        b=A1pRPMGONSvtnDEQSeM88hjsR4UhzcAQhj0khTIC7Kcg4ylw7Hs2Pp1ze0Wzml5xEY
         vuEw+SVSZ/VOCZzx44S2OhfeEa97fyg++wvqcJ+h7khmMFjcxME3guYCom6RXQU2XX3v
         TScKUqTfBJVT4IgbmJfe9G5pEfClUwmBXHlXLZTwtgnRhmGsgirYEHf6khLFQR1JnU3g
         9X8Rtk5up1uqY+KmUDI1pXc7QLqp0I+sTCALkRSD3QZPa8kiXhJ3yffXwH06sl93+gcU
         QnU57sOzivcNJ8juYFAMciOxBoJlyzZlFGKYTIrbMvpoq22mHXzt8bYXuIKTF4Zrmqgm
         YgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788039185; x=1788643985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucnD2vvZKQodkVcezxvV4KyyS73dxyfqz8xpesSWdQI=;
        b=FkOoblftpBqntKzzLPgsGwkPlaz4EVZ2mNcunflUe95g85FhmqKBkjowJ0Mcmf5eJO
         rcEucjygmqzLfSy74mopjnMZksZsY1ykhQiT+SizH/R2YoBnwG+Qucd2Zi5pSCETpwhm
         n+mHz/i17J0L7CmW7V52B5/PkouByXVcBSxbp9A+Tud93J1MtVfxftcW8S4C0QbR3LUH
         TPRp4LL3a47/4vCa2hyY7Xzs8HzzOO874BDy93v/xhGhXoKcEBvazwkDIkYySYG4ERey
         VtJIw8YIno94fsxKmSfgvvaRQWGizzYF62k80/4jAg80c9LfpW4/cuCgW3wg40mzhjHK
         ALCw==
X-Forwarded-Encrypted: i=1; AKwUvByCKvZw4vTODE7Gf4YxznZpaFEpRmhk1gKZg7RXbTc89/KM6+ylCDf7e6IMwgmf0XmoSd5c+zo=@vger.kernel.org
X-Gm-Message-State: AFuF++l7PRMiYoDb2KJoJPozHQr/qMpQGkA7ZjbR1kue3O2CYtlBOYzE
	xn67UiWCvu8eRIlkcfL/C2mLy1pKO9SwcUCSOv7U1yVRydXDtFNReAm2
X-Gm-Gg: AYBFou00j4Mf9NQPQkh2hKQq2Dv/gCk605u5P+RZcy8Aa3xjWfpqB814yr0OtjzOSsW
	4BW2y7ZYEya4PNfRBZbh/J5+Vs0+ZqNihRXyA9+7VeL5QFJAQwd7ks6nU3REHaG+NR3Q5nHIM3y
	yMctTj3iJklhA51OTZ/YKrZeIh6mHlL3cyF5xUxPTl7GfheL7GqafLGiswJIbD1jeIE/3IYIa7j
	Itj4X9fAb5tRFqtv1zuEfJDieB+yi2yFSFPrg0FE0G//7V2mOwk4tLgPiNyESfr5CaEFeDA5naW
	r2iyK5FSinBDVMK1QnzlGtZvuAi6TWvcGqZVp89K+VPP5LyfatVF5SnzsIKCi2Ra/jg9oOGOkLk
	VqY2gK2hR2DUwfXng6EavyZ+BO+bxRSRuswdklB+2EGy83NiughuPok4wUJdUzrQQ+4K5FozZ12
	Y4s4W8SVAtZPV57lhQ22lk7c9s8rfbFidhhrSUzNloWDtiI/btw1QkTXk1w73A9dP72X8p5xS88
	qE2PSIpMwng7UcUpBaIq8Bc0f/4n5Qp28e/veRhTd+OZ0C4pOO4GRYlsNW1nHwymVCCG4AU1DjY
	6matbw7JHc7iiKqisM13Lgr6RUu62VmiTDaq6ac4MEafZGMfg2mFkvCIRLkcBb3WY1EniA0LgAx
	5jg==
X-Received: by 2002:a05:6000:38f:b0:484:3315:1a38 with SMTP id ffacd0b85a97d-48433152785mr8141778f8f.28.1788039184984;
        Sat, 29 Aug 2026 14:33:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae86-1b01-80e2-8851-4221-68d8.310.pool.telefonica.de. [2a02:3100:ae86:1b01:80e2:8851:4221:68d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb33070sm12540616f8f.36.2026.08.29.14.33.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 29 Aug 2026 14:33:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: selinux@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Baokun Li <libaokun@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/2] selinux: fix nested backing-file mprotect checks
Date: Sat, 29 Aug 2026 23:32:54 +0200
Message-Id: <20260829213256.51527-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 preserves the top-level user file SID across nested backing files.
Patch 2 preserves and rechecks each intermediate path, mounter SID, and
file-description SID during mprotect(), including execmod checks.

The series is based on cf72cbb39da8, which contains
commit f2381b546e7e ("fs: fix user path of nested backing files"). Neither
patch needs that fix to apply or build, but without it the top-level check
still resolves to the intermediate inode. It is already marked for stable.

The intermediate list is allocated only for nested backing files. It is
captured at backing-file allocation time and remains immutable afterwards.
Capturing it in the mmap hook would require synchronization between
concurrent mappings of the same file.

Tested on arm64 QEMU with a small BusyBox initramfs, SELinux enforcing, and
two nested overlayfs mounts. The original SID propagation test passes.
Direct mmap(PROT_EXEC) and mmap(PROT_NONE) followed by mprotect(PROT_EXEC)
are both denied against the intermediate inode when that permission is
omitted. /proc/self/maps reports the top-level path.

Changes in v3:
- Add the intermediate-mounter fix as patch 2.
- Allocate intermediate state only for nested backing files.
- Rebase and retest on mainline containing f2381b546e7e.
- Document the BusyBox test environment.

Changes in v2:
- Add selinux_file_user_sid() instead of open-coding the lookup (Amir).

v2: https://lore.kernel.org/selinux/20260820175832.44512-1-kmehltretter@gmail.com/

Karl Mehltretter (2):
  selinux: preserve user SID across nested backing files
  selinux: recheck intermediate backing files on mprotect

 security/selinux/hooks.c          | 150 ++++++++++++++++++++++++++----
 security/selinux/include/objsec.h |  10 +-
 2 files changed, 142 insertions(+), 18 deletions(-)


base-commit: cf72cbb39da84b6f02f90c07f33b102fc10b16f0
-- 
2.53.0

