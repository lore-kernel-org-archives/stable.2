Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725073;
	b=f05+qAh0undoRotJQEz1IIE9zPsYjzIhfbgAwn1o+FxLC4j6U1Rnt/n5LzmpWZBU9llF
	 tE3NnyCY3CxjTy1beS9DHLaPcanqhpvlCcsWIx1X/446JCJiUXrSb0vEG3l0F/AstEAyH
	 T0lGp4zVVC5a11dauSROAGzHLbOIR9b2I7uP9VPx5VEquOminr2jVoDgk0jgaEblVxX0X
	 8WoERLVUGTfd9+GtCKSZl0etdUpF4ZzDikcOu8a7nZJeiwbPDfyYMdBKouMl7fMpwv/1q
	 ME8qqcLcH4+a1ff9mCIQpHFtpcs5FP4qELI5/9QsRiX5d+7+Oxn7PQM03bXzJCMWQZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725073;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h71raNGeav+lDREoJ7yFuBQ7Xy9ZEYVyn/oS4fWUSLM=;
	b=S5u7Qm00gJg3z82TR1YRL2mH/0r3Gt3F+maYdXTw6984m6eyAfwAGWeCBMv2QH+k2OhD
	 Jd8FnV464B7pfZev65EtYRQIBiKvDmxHcNwmuxO15s6puWO66fKIkZ8s4KJB8tjcv02uY
	 BoYAvgo7DtylXh3DzbCCNF+XzQNNBrqNZQWo2kl7wCxCRcYr0LwfFIO6nLsZvAUDVKzUI
	 TCg82ydXgN4pTYagFUS+mFsMfGUi25hqkhEBOdIL7n2e6YSjgEURIFgzdZca319V63aqb
	 tmOZO/xlVk5FV1JvINzTnODGozpXiU6Iu0Mr7cQT8vLZbrdpJlyf06Ae72elSON1Jyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4zlnuvZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB4606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4zlnuvZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FBE1F00919;
	Tue,  3 Nov 2026 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725073;
	bh=h71raNGeav+lDREoJ7yFuBQ7Xy9ZEYVyn/oS4fWUSLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y4zlnuvZZBKLjuRiilKry/Ho29YtVbfKl8z+vfSL4S5dy1wz7P2+bG/7js2P0W5sH
	 LkF2eJ3v4elMsUFozid+5kYWkk9p5h9vrCGcLcqrI2WBT/NUrLiz+yFoebn48sfw2j
	 fpbr62oj9VBt0gx48DDRBkPEnAyVEV/yuoXj5wmdfeGugzZfT4LZ9xh8T9m75SmHmG
	 e51Q4mERJ1j/b6z2vm8a0BJ2lBKOdH7sM4VKEWOCbmLxEcZXgiTWFWud7/Iqsvw2c+
	 tR+tKhA1llFhbCrjFNpRwiUnK0s66DMesDUS7dkl0Iv6Z5cIkbbiZgW5hhyYOEejeO
	 DT8TPEzgbDHWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	"Zachariah Mithani (AploSec)" <zachariah@aplosai.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: prevent share root removal through empty paths
Date: Tue,  3 Nov 2026 11:57:51 -0500
Message-ID: <20261103165720.646458-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110337-chute-essential-cb01@gregkh>
References: <2026110337-chute-essential-cb01@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 9fd1fcbbf84986a7bcf601a2b90540899069d263 ]

A FileLinkInformation request can supply "/" as the new link name.
smb2_get_name() strips the trailing slash and passes an empty string to
ksmbd_vfs_kern_path_start_removing().

ksmbd_vfs_path_lookup() resolves an empty pathname as the configured share
path, without LOOKUP_BENEATH. With ReplaceIfExists set, smb2_create_link()
can therefore remove the share root from its parent before link creation
fails. An authenticated client with a writable share and DELETE access to
a file can trigger this if the share root is empty and the mapped user
has write and search permission on its parent directory.

Return -EINVAL for empty pathnames when for_remove is set, before
resolving the share path or acquiring removal resources. Ordinary lookups
continue to accept empty pathnames for opening the share root.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Cc: stable@vger.kernel.org
Reported-by: Zachariah Mithani (AploSec) <zachariah@aplosai.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Moved the empty-name guard to smb2_create_link() because the lookup helper lacks the for_remove parameter. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5f752434be3cf..d2330137b9b76 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6339,6 +6339,12 @@ static int smb2_create_link(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "target name is %s\n", target_name);
+	/* The share root must never be removed. */
+	if (link_name[0] == '\0') {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	rc = ksmbd_vfs_kern_path_locked(work, link_name, LOOKUP_NO_SYMLINKS,
 					&parent_path, &path, 0);
 	if (rc) {
-- 
2.53.0

