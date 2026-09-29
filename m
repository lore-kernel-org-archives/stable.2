Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8398519E17
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682958; cv=none; b=qUA+YBz7ehEWw4C+adpVWk1lIe7w9zF6QQgEblNged2keNHlTp7ABSuMsVb0ov78qGR4QT9EUIFWQKxKvqH4RJVfq0rweAf+Sx36IwIVmttRTLj9MpcjwRT++zUWl9J5eOgwFbq9fGpBxgc5D1P1xLjB9AixNU9koNvD0PhvLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682958; c=relaxed/simple;
	bh=sRY2d2bm3Fm9czWvEV/EldyLURS4TWooXTmJdOol5fs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sl7nTPhkOmB0N0elwKv3IHzYesdUSs5/7YF59AYEPfHHGsaSJ6DmF7H4jrhUm1hSZHF0lfemLC+jcCUSXXHWnKdywmVORyQrkqJX9DRzvlJ70MtTb496pgZaPiaUBTgqAad5h+ghvOShdxqopggD+bCmuM7sDzjQkTkyh8R09/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eDchy6sq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eDchy6sq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D7D1F000FF;
	Tue, 29 Sep 2026 11:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682956;
	bh=WhTPBjlw0sPTEvFodgiRNr3v+f1+mYIZ1tEF3aCgbEw=;
	h=Subject:To:Cc:From:Date;
	b=eDchy6sqye7Ot+3ITzvCLoLF38bUAC4BVg8JgGMD2hT0NKf1c4vmvqNqNpHZQLF0G
	 +6Co3n+zNVATsEjKbK/43JB22/505v0q+f7z5oqpIbRs2E7svy5dodtYd8ofCZeG8B
	 Zw9wiAPn4XlMz3Q0ZunhRRxuaZDF8T7oU+50Bh10=
Subject: FAILED: patch "[PATCH] smb: client: delete compound mids on send failure before" failed to apply to 6.12-stable tree
To: adarshdas950@gmail.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:53:26 +0200
Message-ID: <2026092926-stopwatch-rumbling-2993@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8f6f8a48399f82f4a83f7b9f25b9707e0062a4f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092926-stopwatch-rumbling-2993@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8f6f8a48399f82f4a83f7b9f25b9707e0062a4f9 Mon Sep 17 00:00:00 2001
From: Adarsh Das <adarshdas950@gmail.com>
Date: Sat, 19 Sep 2026 16:27:32 +0530
Subject: [PATCH] smb: client: delete compound mids on send failure before
 unlock

When sending a compound request fails, smb_send_rqst() kicks off a
reconnect. compound_send_recv() still has those mids on pending_mid_q,
but it unlocks the server without removing them first.

During reconnect, cifs_abort_connection() walks pending_mid_q and runs
each mid callback. With no response yet, those callbacks return credits
and drop in_flight. Then compound_send_recv()'s send-error path returns
the same credits again. in_flight ends up decremented twice and
smb2_add_credits() WARNs.

syzbot hits this during SMB2_negotiate when the socket send fails.

cifs_call_async() already calls delete_mid() before unlock on send
failure. Do the same for compound chains and set cancelled_mid[] so the
out: path does not delete them again.

Fixes: ee258d79159a ("CIFS: Move credit processing to mid callbacks for SMB3")
Reported-by: syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6a727d22.40259c87.584f4.04ce.GAE@google.com
Tested-by: syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index e266859818a4..7df5b3447aea 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -965,6 +965,10 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	if (rc < 0) {
 		revert_current_mid(server, num_rqst);
 		server->sequence_number -= 2;
+		for (i = 0; i < num_rqst; i++) {
+			delete_mid(server, mid[i]);
+			cancelled_mid[i] = true;
+		}
 	}
 
 	cifs_server_unlock(server);

