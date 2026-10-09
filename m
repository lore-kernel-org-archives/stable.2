Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA43E40F5
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544965; cv=none; b=H6GI964A1HbKwOygng6js5hWOsta3zpxjUYQdhANwZo5CtooD8jUy1Ms/hIah75kNOjw0Tlaznij8Zkoct7JrbSqxnA+VKD6CPaMCg7+8JI9wAe6OlX1ifpl+ojYj3uNFoBnkYKpS+HbQRLQzPi550ntfo9r1ilo0hZL6JTlTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544965; c=relaxed/simple;
	bh=BXGkEZuWz6PIaWyhn3drqwPYaoL5CeBKsRvBIJ9Izno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgK8AyNNRRBDdBmvoKftZ381YMIp1LaDLow+Fg1U70fEkftJZrLII0mEcSKczMIWpKBHHdw3/CaUkkz04KJ3AAaVZZSLry3RVsGSpFof27gTnRgEZasitN4hilo9hgYFI0vJZBUIH6jzVetipRt2WQvVISbhGeFZqrc24OjCOJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZB2UcRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZB2UcRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A5C1F0089A;
	Fri,  9 Oct 2026 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791544954;
	bh=O7Xi6h1I5Mb6FlicJ0w7Ua9QyL0wb103FvJh6JPXnG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cZB2UcRisGi0IojFPdySQgrV+KJHWv4fRxJ6+jRuYzEt7Pj4pyMoxjjcHp6cjNijZ
	 76dmfcEi2zg9G/CrgIslUcUbkrChYjvK3Ho7Zz9DvJNbHuHRKZ/yyK2RFEA0TqPNO6
	 LDE69pnhH7SGgk+9SL9FDEqcdKbHmOY9DsNBTfA4VEvDEYbpUYy/CFmIEk9p37QySg
	 eUmZv33JFAaiP8QEE/w4J3t/4zRV5NHE6efihViNL8Pp7FtzfcJSJOJqbKxoQAaZIM
	 +fvnbAySD0fhiQf4LfcKaTk77eyE4LFhbTLZhFLZ7Rq+w63MfZFe2wSdaxXS0gs5Hj
	 pE8VzlTbm7Uqg==
From: Chao Yu <chao@kernel.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH RESEND 6.12.y 3/3] f2fs: fix to reset all pinned status during fggc
Date: Fri,  9 Oct 2026 11:22:20 +0000
Message-ID: <20261009112220.2276173-3-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009112220.2276173-1-chao@kernel.org>
References: <20261009112220.2276173-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 ]

Otherwise, the pinned status may affect latter flow of fggc.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 664260807072..6c831276d81d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2132,6 +2132,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
+		/* reset all pinned status during fggc */
+		f2fs_unpin_all_sections(sbi, true);
+
 		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
 			err = -EAGAIN;
 			goto next;
-- 
2.49.0

