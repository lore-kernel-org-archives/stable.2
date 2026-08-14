Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17903546E0
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685097; cv=none; b=XoSy7aheX0Vg+nmvH6roZ+gQKbxOjFPMj9W1bMmRlovml+ZCOHEVtMAOLmokqWUEBzFdYSfEX6czgyqOQ6ZzUcMEBSW6J78UV1uDnYezmbQKNKphxVWBQJ3hYJvG2GYvlQeCrdmUtP4kWlJQ1nV75yI5Ud1GQV2rhFRm73CTKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685097; c=relaxed/simple;
	bh=NF8iSUcLOYBQB4xAvVRAR2YEaIApH2vam2Ejqz4ZVuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5PYLoipxkfkLISppqdKAp3oQbb1Yp/5Jlgx7AL3KHRwYYtI98MfHN5XjNzeyOlERQxeZBKMGNsXemjOVEZmIx5pvTE05RM3HhD19x8v7r/pO9owT89j/XD++fnMczzs7CfuEcVGf8YM75+lJJ0mKu/dppzm+iIDpLrK2ICye1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP6I9itB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP6I9itB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D511F00A3A;
	Fri, 14 Aug 2026 05:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786685095;
	bh=7lQs6neR5YOc4XJm2nkFIUU/SSelkNdC/H9+/60H9aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GP6I9itBvDB/2yfc+FnRSF3mUv/+TwKioAfXGeO5u0HucjLmihlAmVIn+YaNs8qQl
	 rACf366D4aj8K+I6lAvU8vCw/YA6a6btDjCxqE+J/MX2XIIlt8QulnVgpdgOetM1wl
	 rdZp6Ux7hpo3BnAhuDm/qHEo7c1i7tiw/DzSqf0wFvUZYpNhije4jzeZVxBdzO+fHD
	 QVq37k6pTt5FojQjjCuMkYeXphYi56dmeI5mGO0ifisKvdBKNZSJk3KsVOk+2E6jHp
	 7LG9paZvGn+YwVIJcsv2AqEMWXRm+tSISTXIoqP2dNpgPGZaMiURzvtTKnsLPkl2aP
	 JNajmDb89Vn2g==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 6.12 2/2] kunit/fortify: Add back "volatile" for sizeof() constants
Date: Thu, 13 Aug 2026 22:12:54 -0700
Message-ID: <20260814052439.430858-3-nathan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814052439.430858-1-nathan@kernel.org>
References: <20260814052439.430858-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

commit 10299c07c94aa0997fa43523b53301e713a6415d upstream.

It seems the Clang can see through OPTIMIZER_HIDE_VAR when the constant
is coming from sizeof. Adding "volatile" back to these variables solves
this false positive without reintroducing the issues that originally led
to switching to OPTIMIZER_HIDE_VAR in the first place[1].

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2075 [1]
Cc: Jannik Glückert <jannik.glueckert@gmail.com>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Fixes: 6ee149f61bcc ("kunit/fortify: Replace "volatile" with OPTIMIZER_HIDE_VAR()")
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20250628234034.work.800-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/fortify_kunit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 1541b2a1694e..d0810e4e65e5 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -986,8 +986,8 @@ static void fortify_test_memcmp(struct kunit *test)
 {
 	char one[] = "My mind is going ...";
 	char two[] = "My mind is going ... I can feel it.";
-	size_t one_len = sizeof(one) - 1;
-	size_t two_len = sizeof(two) - 1;
+	volatile size_t one_len = sizeof(one) - 1;
+	volatile size_t two_len = sizeof(two) - 1;
 
 	OPTIMIZER_HIDE_VAR(one_len);
 	OPTIMIZER_HIDE_VAR(two_len);
-- 
2.55.0

