Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35039F16B
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135544; cv=none; b=IfQDq5eN+NxUPCSP24utfDjpIgWFejNcEJY7vSvLHm7dfnwxm68wy1CJVqAyhc0D89c36NUyn9V0SuYvPDsmE1ldLRi9FUPD4ayji5ALN4UlfKIts8haeXtzR8vJLPaxRos3idcv5cmUFnkhUGKL84nL6j9lZopY5kBqIkulW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135544; c=relaxed/simple;
	bh=DIDeLH7QI4HTN/TdR1gDrvYFGwgGXfUvpY6+VQsP4cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgJ06xf1iAXdiK3WImOie2zkiz9u0G1oOagrjLjWv9zFetw0W0p/W+TS/J63bR0Uea8PP2fQmsPGPzeOQ4VwHuQ71YNlVL8DNKjE1a1df//z92Tbx0/qTtf10NZBu5KBsrlOle8cI1KOsHg6hrCfLw10jWQrGCQO8+bRRsmeZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3RCk2WG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3RCk2WG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4052F1F000FF;
	Sun,  4 Oct 2026 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135543;
	bh=fiVlH15TbPjxCvR3rNK1Di8B2TcpsV0AKExzsYv/15U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B3RCk2WGR1CFsXz9ElEL8nnY8+3OCSWmkoQ4cPrD1BOF69ZZQjxcm+L315ZlCf8of
	 0DcXJSl3cHUd8rVzi8g0YrnEAhkfB68sAc+X00/C3YrGtYOYlsCqiJYSEXAyCAPEzb
	 1YR/OcCE2op0cydaqTFBFShY7VCt/RprIfALtygbG0mPkcED/S7lGSu3uqndvkVZrl
	 hZuPjA/upOq2LK19Tm2CbPUHXDb6x4G3TzLbDfDOjXvt2tzvCICdlxPwH6bCC9/wY3
	 7PSwdEa/0R9s2/JfFnPb5WSfhZCtrEqrws7uidizDGVL5OmJ/WlSRb/WTrU69SKXnq
	 RtLjgeLNkX7zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] console: introduce console_lock guard()s
Date: Sun,  4 Oct 2026 13:38:57 -0400
Message-ID: <20261004173840.989210-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100453-thorn-hurricane-763b@gregkh>
References: <2026100453-thorn-hurricane-763b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 4847d1187402a5027d9a04393f12d52a5a1d7f98 ]

Having this, guards like these work:
  guard(console_lock)();
or
  scoped_guard(console_lock) {
    ...
  }

See e.g. "vc_screen: use guard()s" later in this series.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20250814072456.182853-2-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 226bd5603371 ("vc_screen: reload vc pointer before if (ret) in vcs_write() to avoid UAF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/console.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index eba367bf605da..cfc7125daf626 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -666,6 +666,8 @@ void vcs_remove_sysfs(int index);
  */
 extern atomic_t ignore_console_lock_warning;
 
+DEFINE_LOCK_GUARD_0(console_lock, console_lock(), console_unlock());
+
 extern void console_init(void);
 
 /* For deferred console takeover */
-- 
2.53.0

