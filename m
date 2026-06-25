Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD072459CF
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404717; cv=none; b=EsxsGGtLPYTyjdyCJE8GQqCFBk0MWw7Kgmcc1c3gEeyjdzMyzO0FYQeTgpETBWatOxLNi7dZHx1QI8+PkGDnjb2D9Go/iwoJ6NRbc3/1w85ydO0VwnzE1ksC9w7Rt+yYggeV5OjvU0OWb7hIHxby1OHSiAt/rn8fjE2hcnM5P0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404717; c=relaxed/simple;
	bh=SU954l45fwkWhTsxD5uDX44V/RmqaYS2Opy4fPxDwRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCWD42arOaOv1U1SGJhMczIkpA/vw5+VeL4EwDSHUJETdSkvHqNdssx/ELJPU4eAw2bxzqZ8upvfTBp8CR4xiY6eLAjitlLkHstuEkpeaYLeA2xuu0Nfp+l7olSNMWoSUUL77w65CgxCjHczp4xXLON5pnEoKf4Lq0tNryhXhuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmGdH2Ct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmGdH2Ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0331F000E9;
	Thu, 25 Jun 2026 16:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404716;
	bh=1t9JWqqLncDjB6W4k45Q5tuUud3abVHaHYLcKLsVzcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YmGdH2CtJ+ZA4YczDRoY+WAg3GTMG4/+6WU8OycGrHQjKvX3SwIrDDAhHLxUjSJm1
	 CuCglwsDUmVgjEXkkS0XT7IwmlpIBykBBnDSShipKQ3j/dRg3e0KJTwgiAmdwqg6dt
	 xFsLK+SdeW3Ogzt7u74bTr8g1agENIbzg+x8V4y1jfyE4UgqHo3kfxa+1lLUJOrNMZ
	 ZhpAQenfaYXVp08huxtKuS/rrcW3K/dWqcL6vLQRxG8lnhhkORcocV8thuCEaxs/t9
	 NvvOHS5LtV66dVQtazh0/V7qvzHuUj+WXUGB4Zi+qD62EFIiwe/Fxdq/LI+yI7zF06
	 mfpJf+8Qc2aOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gil Portnoy <dddhkts1@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: reject non-VALID session in compound request branch
Date: Thu, 25 Jun 2026 12:25:13 -0400
Message-ID: <20260625162513.2501233-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062533-hypnosis-duffel-ae71@gregkh>
References: <2026062533-hypnosis-duffel-ae71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gil Portnoy <dddhkts1@gmail.com>

[ Upstream commit 609ca17d869d04ba249e32cdcbf13c0b1c66f43c ]

smb2_check_user_session() takes a shortcut for any operation that is not
the first in a COMPOUND request: it reuses work->sess (the session bound by
the first operation) and validates only the SessionId, then returns
"valid". It never re-checks work->sess->state == SMB2_SESSION_VALID, and a
SessionId of 0xFFFFFFFFFFFFFFFF (ULLONG_MAX, the MS-SMB2 related-operation
value) skips even the id comparison. The standalone path
(ksmbd_session_lookup_all() plus the SESSION_SETUP state machine) does
enforce the VALID state; the compound branch bypasses all of it.

A SESSION_SETUP carrying only an NTLM Type-1 (NtLmNegotiate) blob publishes
a fresh SMB2_SESSION_IN_PROGRESS session whose sess->user is still NULL
(->user is assigned later, by ntlm_authenticate()). Used as operation 1 of
a COMPOUND with operation 2 = TREE_CONNECT (related, SessionId=ULLONG_MAX,
\\host\IPC$), the tree-connect then runs on that IN_PROGRESS session and
reaches ksmbd_ipc_tree_connect_request(), which dereferences
user_name(sess->user) with sess->user == NULL (transport_ipc.c:687/701/704)
-> remote NULL-pointer dereference and a kernel Oops that wedges the ksmbd
worker for all clients.

Reject any non-first compound operation that lands on a session which is
not SMB2_SESSION_VALID, mirroring the validity the standalone lookup path
enforces. SESSION_SETUP itself legitimately runs on an IN_PROGRESS session,
but it is never carried as a non-first compound operation, so multi-leg
authentication is unaffected by this check.

Fixes: 5005bcb42191 ("ksmbd: validate session id and tree id in the compound request")
Cc: stable@vger.kernel.org
Signed-off-by: Gil Portnoy <dddhkts1@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d029227f2ba616..496e1b50700d03 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -606,6 +606,11 @@ int smb2_check_user_session(struct ksmbd_work *work)
 					sess_id, work->sess->id);
 			return -EINVAL;
 		}
+		if (work->sess->state != SMB2_SESSION_VALID) {
+			pr_err("compound request on a non-valid session (state %d)\n",
+					work->sess->state);
+			return -EINVAL;
+		}
 		return 1;
 	}
 
-- 
2.53.0

