Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB194A6887
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106046; cv=none; b=G6adQNtovoS/LlKQRk4dZ9o2ioPCtM0OdHoi7Vf0Z6/XnFRA8OwOPr6mlo92qVoBei9R1FKZFrkpwF/W7NO8Wc8hBN5h4yYPo2sXtie1CpCA0FSbCRgidA021hsJcJxJd14JiMSNhd0ccro1WVlHGKE4Btfh0JMJ/dvWF+tiE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106046; c=relaxed/simple;
	bh=h1PgTzEesg1zFt6FAlNgYZlcsA4PPqEaTzK3N2Bp2rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQNWRyhJWw5LflpLxmR2w/JL+1I3oD9BoD/6zuxfTAkmNzW5MVBE4fUfwtT5oX9wlKeH2p3JD5OQhfmw4jYEF07Syw5MH0Ro9L2yvLliCmq2KytIOBpCM9Zjj11cszQLFP1WmmSnsd4YGli/ZZrLj+51+MlFfu5gCTXwSi9gfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPIXkb8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPIXkb8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893F31F000FF;
	Tue, 22 Sep 2026 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106044;
	bh=XODYpV2vYod8iioKVjGzTtr3Zh4yl4rVDv8gTFvJcYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fPIXkb8WttxHFDavaGbnNzOQKEV8pN5ID4U9bWvtozZ6QudEDZENm7whBA1qnc4Cf
	 yEqSGvxBTRHp/9WgoboAA5Un0ooGaQufWYIIw1vaPRcpY6hWxVXUJW9beGVKbszY8u
	 GvsFnkGtG4crHKmwQNJoTWHH5GIjHDVOZ0ITuU922Rj6LurcYKMPABpcANGWPGVd3P
	 Vk3AHnoeGn61s/77vnwF6NSThB57WcI2ZVtA2DkQHV4eRPZ9rhsfGNqsvVCFodz4Jv
	 Nvp0CKVQT/3HIl9hCK9WQsL9FxO4N4uMED7ZiuzLxybw/HPMAW/SeAIKbI6VCOnxCs
	 fht2wk091l1bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bharath SM <bharathsm@microsoft.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] smb: mark the new channel addition log as informational log with cifs_info
Date: Tue, 22 Sep 2026 15:40:41 -0400
Message-ID: <20260922194042.23351-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092254-playoff-luxurious-1cdf@gregkh>
References: <2026092254-playoff-luxurious-1cdf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bharath SM <bharathsm@microsoft.com>

[ Upstream commit faf1b64888ff13caa94fa09835fcfdabee18b057 ]

For multichannel mounts, when a new channel is successfully opened
we currently log 'successfully opened new channel on iface: <>' as
cifs_dbg(VFS..)  which is eventually translated into a pr_err log.
Marking these informational logs as error logs may lead to confusion
for users so they will now be logged as info logs instead.

Signed-off-by: Bharath SM <bharathsm@microsoft.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: d034e836eefd ("smb: client: fix use-after-free of iface in cifs_try_adding_channels()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/sess.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 6fac7a1075920..d3619c8ab142b 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -279,7 +279,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 
 			iface->num_channels++;
 			iface->weight_fulfilled++;
-			cifs_dbg(VFS, "successfully opened new channel on iface:%pIS\n",
+			cifs_info("successfully opened new channel on iface:%pIS\n",
 				 &iface->sockaddr);
 			break;
 		}
-- 
2.53.0

