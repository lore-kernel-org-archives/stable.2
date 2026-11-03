Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735341;
	b=gr396mjkW/R4VV16ZQYl2dXv8uEu2QisG78Rwg5uaVnDY7gAyGdRpFVJuWUcBcMO5CEm
	 aycSstXOWGKytlr9rDEngZRPDyyWAsFJWAQyUss8yPqQ3C87t1dKhELPVQETjPXQwNYfT
	 hDLBdMaywP0zuu7s7bhPaoz7gbg/ZgMbRonwyvfGXMzpl8GpCxys1kyOvi1HIrZxws7nm
	 vaB/ozeSPi2uT+GIYChcIcwNEUw3So91kjMZoMg952w6gsOhSNPsEsYFNuu9xZRJXXsMu
	 AbdMEqgkRKwJHsC0YLeWDyeJ9nqRsZroUdiIhvWYX2R7pO60y4FdHEOSpS+98S+X/7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735341;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FODGCVcgzso6cFQLj2zTed4Eu/8gfflGk/DM8a9lT9o=;
	b=qrsMvYIpD2KRT3mEv+FeFA+sxcd+vuhJNNC8RlisQsxJremWDRxwTNLOuYNJVec5b7bQ
	 4GmtI6Gfc7XbXf5ZfAe20gCNkBv5LNkzF2jKjPx+wfG3uW8CBxc+/AbzK6bAs0RW1sxqH
	 iiGVdS5128wewu5erY2l2U3PFcqy6BAVGvI5QeZT0VBeRzjmNQORwJpHbkWjlIbOE7Cm9
	 WARJ4+ma2W3yqKocLdvhX9txjKbmrnSC9M1H47VDcS1DfbHY/q0VFxIdpLjr9i3MD/auk
	 WSrQiB+qxYij6sKbsUhNXxxTpWF9EXf8cx3RCuK1XsJ17gFCTPwBDeSoxEWNtlIy8Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDcvCPr8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C3606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDcvCPr8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3FD1F000C1;
	Tue,  3 Nov 2026 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735340;
	bh=FODGCVcgzso6cFQLj2zTed4Eu/8gfflGk/DM8a9lT9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hDcvCPr8LZWbTZ8gHkcPYZH/nT++LArNEGLp4j5IBnztgkSuGGi2lhdftQ7pVFGFi
	 kzA0IRlMW0pUW9i0WD0XTiLHpKdj3866cnCwINWctYCiP+5i7FqQx5PQw2MGNpn048
	 barxdHxuUAcPo0RyGneMt41co32jyAehM8UUdJPFgc/wbHqpIC7TbOejAaoDO+qmys
	 S2waMYa+jf70f0pb8WsKx18czIjQjLF77NRf/wp7m0jFiq81zKq9Y/QFEzNh+SYdHq
	 BZsQ3/CtXW7A2lmOOSEirbLcMU+8ZNFlQcVdUp0KcWGfmQ+1nSy//5cSMOchKH+Du5
	 2wkvFQE/gjYHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	"Zachariah Mithani (AploSec)" <zachariah@aplosai.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: prevent share root removal through empty paths
Date: Tue,  3 Nov 2026 14:48:58 -0500
Message-ID: <20261103194750.700945-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110337-caboose-tile-5488@gregkh>
References: <2026110337-caboose-tile-5488@gregkh>
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
[ sashal: Moved the empty-path check from the shared lookup helper to smb2_create_link() because the helper lacks for_remove. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index aaccef2e3f3bb..1573edebee2af 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6303,6 +6303,12 @@ static int smb2_create_link(struct ksmbd_work *work,
 		goto out;
 	}
 
+	/* The share root must never be removed. */
+	if (link_name[0] == '\0') {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	ksmbd_debug(SMB, "link name is %s\n", link_name);
 	target_name = file_path(filp, pathname, PATH_MAX);
 	if (IS_ERR(target_name)) {
-- 
2.53.0

