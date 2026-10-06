Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A23D411D;
	Tue,  6 Oct 2026 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322606; cv=none; b=c7EobVsfi3LDCqlSTg9rcmFSkJZ+j+U90zurPPe4N/gR20brWUbAHHDanRzS6SPyN8zvaJvqFN556ZzcdHTt8803rIuIONWXFU5Qqtm9pwmNqr/E1gjR+ot2tZ+aoI6Yu6Uo2f/PBeH5UjdoxUmqzZmxq50vpA/8AgyMc3pM21k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322606; c=relaxed/simple;
	bh=QHpr8Zb+qymnsNq3MOlCaXYNHcIK9zX76MX9U3feZcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TwcB/mly0hGM3ablUA6ttHRcz32Z9cAS5AXVKvEnJrIsK0QR1Ud1KLpennd0DYD4+oICwg+Tq1kI/xZrr2S7Dt/AjFLDB8j2nZZIwJC5MIsAbpBsW5Swmx6B15N3zG5iqhLfbAkVTI0pszppFprvM3QAWDcyDS1EpHBc7Mx44pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGYUU4he; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGYUU4he"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842411F0089B;
	Tue,  6 Oct 2026 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322605;
	bh=mUoLSukX7jQp4krWaSzp1OxmpA0fI7w2cd58U6Q/Djs=;
	h=From:To:Cc:Subject:Date;
	b=UGYUU4hegbyL5ctqUFsl82u+0F8U9mBH+lfA/eK8kw0m2ch8yMV7PLDY6OTflLpsS
	 J7mEGqHr4S94QnWO6Ku0fLqpBsglooHm+f5c0jtgBcdWLJJmpB68anIqhg6BE/Zmij
	 1tUqp9etP99HIzNyE2PZ/0hL5/rJ2oPVFL01XlR8SoAyF2aNx3S1M7+jsFvBE9Haq7
	 X+rry9CDy5pGGZOfcHhJBHh7iM0MIMcgEcDdVq2E5Ot4P3u85aVtR4kstENI67iRxD
	 /2MY0ogakE3LKVaEdNP1snlG4x/2SiTHugqZ5FVC/WIheEJU3SOPu4SJHaN0UTQhL/
	 dfnTwqvNERT6g==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 0/2] Forbid truncate of fsverity files on btrfs
Date: Tue,  6 Oct 2026 23:36:03 +0200
Message-ID: <20261006213605.46946-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport the fix to forbid truncate(2) of fsverity files on btrfs (and
also the fix for that fix).

Andrey Albershteyn (1):
  fs,fsverity: remove check for fsverity being enabled in
    setattr_prepare()

Christoph Hellwig (1):
  fs,fsverity: reject size changes on fsverity files in setattr_prepare

 fs/attr.c                | 12 +++++++++++-
 fs/ext4/inode.c          |  4 ----
 fs/f2fs/file.c           |  4 ----
 fs/verity/open.c         |  8 --------
 include/linux/fsverity.h | 25 -------------------------
 5 files changed, 11 insertions(+), 42 deletions(-)


base-commit: 725bd2f3c81d54edccb66fead01d4c0c222e2231
-- 
2.56.0

