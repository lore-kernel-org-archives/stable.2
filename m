Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40EE1E5018
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945900; cv=none; b=t5CtR4MBNtEpk4z9e37wmzTBE4/6avB9AlD9eglKFpAztUpeUtmz6e9JWZeIGYKtlmE7SKrsVlbWPQuU1Ap4A0WJldkfrTtKlBf0BgJN8JqBTbTMGv/wE8T243Ch04X2NwQCwgMhHTCf2ePxpdGlfhuhkHPer2Od4Wi99vrG16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945900; c=relaxed/simple;
	bh=J+aMreZdWc9ZypDOWeyNufpfkO0VkKAKv4AZBZXSX+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ay8tsLD4W7q9Cu9hUqMZAh4gtJegqG3jZTadXERDGaAM+CNpc/3AJn89PQ2hbQcfwBmGzx5ZJLDwN2Kfy6lJ1d8nd33b/yvjxvGs4X/X+iSDGxibJMKJELAfS2p7Be+8c3ooWJ0HXoi/JU8r3Q/xNncOa7Jd/07OlKKesB9Geh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD/0fpEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD/0fpEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E571F000FF;
	Wed, 14 Oct 2026 02:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945899;
	bh=KAypq1b6c9uEQvjawzeDScLX1jedgtWr6Hw/4wzScfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FD/0fpEeFh9UQQpls8icFFjJ7vyZpZVBZKEuwv57INgBoIBvjYOYMAGv+jAms5Xwc
	 bXLxHlD/cywrxhbF5XBXeLNHFoJcVm6H6ievlce4i62xNjTk02kKbYw3s2cdBah6uP
	 yZTfwY5bMDbUzPmjmrJOpUlC+NAq3bwGfZ2pyHpobKQLfsbFDe0xf4SIeFnJZc0pgS
	 8IEKkfFgqZP0pDG8CbSeXi6EqwofBpBysE4M/E112CyG0cD2e8KWPLGzHQFcFFDIMe
	 oIWeicRPGNtcIXe1WDImDsBxmFxgVSiqQbCgOBA+ebFKMy3yvjzvtMhd+PaqDwOAd9
	 yC6dIHgZSlnEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fcntl: refuse F_SET_RW_HINT on an immutable inode
Date: Tue, 13 Oct 2026 22:44:58 -0400
Message-ID: <20261014024431.1769524-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101224-otter-confess-ab7d@gregkh>
References: <2026101224-otter-confess-ab7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit b0d1022b9bdb1e98aa7fb3244fdd50a58c61766c ]

An immutable inode is never written to so write hints are pointless.
Refuse the hint on an immutable inode the way setattr(), fallocate() and
etxattr() refuse their changes.

Fixes: c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261002-work-mount-fixes-4-v1-3-dd44b89d44ce@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Moved the check from fcntl_set_rw_hint() into the F_SET_RW_HINT case of fcntl_rw_hint(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 14ab4660d0240..cdc13f97d7adb 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -307,6 +307,9 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 			return -EFAULT;
 		return 0;
 	case F_SET_RW_HINT:
+		/* nothing is ever written to it */
+		if (IS_IMMUTABLE(inode))
+			return -EPERM;
 		if (copy_from_user(&h, argp, sizeof(h)))
 			return -EFAULT;
 		hint = (enum rw_hint) h;
-- 
2.53.0

