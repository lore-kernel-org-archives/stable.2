Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696D3E3C5B
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391960; cv=none; b=gGE5qFnEeKow4ohS9A656nqtQNc66P4krho9/xqI/wJuz577ydKTSsxfvT2rE/0aDnNnSfZY+ITEnXNZhjys9jJL/upTn8LIatdV7JFbWEtrdgMODf3+0HSpgGPuKGn7N+O1JDMKzq0JMsevCvepLSWtYGgIqVu+tKWbiIT3cPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391960; c=relaxed/simple;
	bh=+Y7Z7sM8QVRf/Ybbi/i119j1+WeNKg9lWDTk46x3ERE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vE2BIb6cJe8wOgmh1sVHU62lY5oh0FPJuuXlFX8xGU/TnTvNBppVYryvTuBuWvXLo3lif3/spEizi2VZDSjj293EGzRhMwLZ1ZsVdw8aZrOzKXGIFH4LLKBiF+l9rD7FohD8SpdFPIKnKHwGLnKVztJ2awP6IknuENfZZAt+FuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G5rbnl+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G5rbnl+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E2A1F000E9;
	Thu, 25 Jun 2026 12:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782391959;
	bh=PZ3Qvyy82JuJ4W+hsKheO1WPd46hM5kDJEe0/9awrkY=;
	h=Subject:To:Cc:From:Date;
	b=G5rbnl+/rW4P163QR8S6cRP/n8OsKucGNxUPg4NLCfYs7FceZGvSngdyQzIG0nATU
	 VPjWgwCO/iDaFLmUyFfgo2Sx60n3eYv1HnZM1E3haXiNfg/Bb7oLKAVeQ/sP2OJu3+
	 fTJsk8czdOzt04L/+I/wd/E1o9kyHztZfCjmTelI=
Subject: FAILED: patch "[PATCH] ksmbd: reject non-VALID session in compound request branch" failed to apply to 5.15-stable tree
To: dddhkts1@gmail.com,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jun 2026 13:47:33 +0100
Message-ID: <2026062533-hypnosis-duffel-ae71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 609ca17d869d04ba249e32cdcbf13c0b1c66f43c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026062533-hypnosis-duffel-ae71@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 609ca17d869d04ba249e32cdcbf13c0b1c66f43c Mon Sep 17 00:00:00 2001
From: Gil Portnoy <dddhkts1@gmail.com>
Date: Thu, 11 Jun 2026 22:59:19 +0900
Subject: [PATCH] ksmbd: reject non-VALID session in compound request branch

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

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ae451e77689c..9efafa56c03e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -615,6 +615,11 @@ int smb2_check_user_session(struct ksmbd_work *work)
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
 

