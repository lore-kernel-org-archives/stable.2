Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93B3F9277;
	Fri, 28 Aug 2026 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924300; cv=none; b=uPDbdoGBvDeR9CYNtND8YD2u1bgUbSzKUTewTo6YxWaQtHImkvgjpghQXKiG3Ue7AafWW8kAto3xlDMKuW89k8KCV7cyKWJMNTwUVdR1tX7jOGTrIZ/EswbxngQS81BdVpzC9lLMpuqpTb0U7Gz+AHJL+C+sFHRiQf/8l2roHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924300; c=relaxed/simple;
	bh=MQT+qv5zJz0DYDSrgzZkqbQrlrmqspGBn5E42xfDKnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ccGyOUTpJLQMpsCW4WUkDf7tBtmJzeZU4tpSyv12bgTfKWrGmemilIm/NkcbLg0j+MOIlB9WDwlACBO2PuWfKGXnfLmRAVCKTjSECprY4c+s2jKAYMUupgYXTc1J/93P6JXm/FhDEw7oPsgOaSlKI3kzLb16wKef3glVOoy2eW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZj3uAyL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZj3uAyL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B254DC19425;
	Fri, 28 Aug 2026 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787924299;
	bh=MQT+qv5zJz0DYDSrgzZkqbQrlrmqspGBn5E42xfDKnE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=gZj3uAyLmHh/sWcwUQ5gnPpBAEjDXl+oROa4+N8MSN5DNbViiXDFvjJm37A+tO4fe
	 PaoMGm0CR8pFroz3q3hZg5xvH7t1wpOJbLtC9q3Gx1oO3CfeJMDz2qIx4vx+bhIUqj
	 1js116suo+ELj5k8BiYRW239sdFU9sb4P522r6rh5DOtU9AziBiTu4GUF3AjqoqIFa
	 cIu4OmqSctAmj5+91jFeeRur5SuUjkqyHz0R9LLLtL6zLQx9T/xGAXsakFRbrG6TLk
	 rSU9m1XRHtrspmCFPH2XB+q0+wkzM3cq+/rDNSRuf03CYlYgBtjZK2hVusSnCoUBtY
	 xDtd9gLsxiClg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D922C61DCB;
	Fri, 28 Aug 2026 13:38:19 +0000 (UTC)
From: Maurycy Pawlowski-Wieronski via B4 Relay <devnull+maurycy.maurycy.com@kernel.org>
Date: Fri, 28 Aug 2026 15:38:18 +0200
Subject: [PATCH] hfsplus: fix truncated xattr names in listxattr()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f378c@maurycy.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQrCMBCE4auUfXYhhlqCVxGRNU7tiqYh24pSe
 nejPn4D8y9kKAqjfbNQwVNNx1Sx3TQUB0lXsF6qyTvfueADD73l+2wcx/w+JXmAe32xdPDipG3
 DDlS/uaDOv+7h+LfN5xvi9I3Run4AK56TeXkAAAA=
X-Change-ID: 20260828-hfsplus-copy_name-fix-a6e2a0a4485e
To: Viacheslav Dubeyko <slava@dubeyko.com>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Yangtao Li <frank.li@vivo.com>, Kees Cook <kees@kernel.org>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787924298; l=1797;
 i=maurycy@maurycy.com; s=20260828; h=from:subject:message-id;
 bh=IQcRwEprbEp3pKKBaOEYBUQJiRxQaoTwOUPdhNAlj1I=;
 b=KcE8oNk53vD38NezIG497FfmNiyzCJPCYtuzI0dy2SFvEjiWNpAhZl283vPZfwo6yGp39RBOD
 X3kCNlZskQ1DEEROGsjwU3ev4JIDLn460WlxnqGa+gmEQw9eLaGwy9p
X-Developer-Key: i=maurycy@maurycy.com; a=ed25519;
 pk=cK6zOi8RCOCUTWtJDER0YR5jWodFabZ1wH57I+KmldA=
X-Endpoint-Received: by B4 Relay for maurycy@maurycy.com/20260828 with
 auth_id=983
X-Original-From: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
Reply-To: maurycy@maurycy.com

From: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>

Commit 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use strncpy")
changed copy_name() to build names in the osx. namespace with
scnprintf().

The supplied buffer size includes room for the prefix and the name, but
not for the terminating NUL:

  $ python3 -c "import os; print(os.listxattr('/mnt/tm/.DS_Store'))"
  ['osx.com.apple.FinderInf']

The truncated names cannot be passed back to getxattr(), so getfattr -d,
rsync -X, cp --preserve=xattr and tar --xattrs etc. seem to lose all
Apple attributes on hfsplus volumes.

Names in other namespaces go through the strscpy() branch, which already
sizes the buffer correctly. That's `why xfstests generic/377 does not
catch it.

Fixes: 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use strncpy")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
---
 fs/hfsplus/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 21a1c196c71f..4a3c97373682 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -515,8 +515,8 @@ static ssize_t copy_name(char *buffer, const char *xattr_name, size_t name_len)
 	memset(buffer, 0, name_len);
 
 	if (!is_known_namespace(xattr_name)) {
-		len = scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX_LEN,
-				 "%s%s", XATTR_MAC_OSX_PREFIX, xattr_name);
+		len = scnprintf(buffer, name_len + XATTR_MAC_OSX_PREFIX_LEN + 1,
+				"%s%s", XATTR_MAC_OSX_PREFIX, xattr_name);
 	} else {
 		len = strscpy(buffer, xattr_name, name_len + 1);
 		if (len < 0) {

---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260828-hfsplus-copy_name-fix-a6e2a0a4485e

Best regards,
--  
Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>


