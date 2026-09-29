Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB595187C4
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682732; cv=none; b=hhCAu2e9D3YyfdXtoSh/Eq9saRk0v/exa0DdsxnAxuAqAkuPh7U0oRlSmYu+QpSGb8h7wMh38LHCUGgj71MO+VATH4EAs+OjFHrpAH4j3ZApbQ9O3SMeax97GnTzEgJobSf+6nkw3UHEONakzmnfwJ0x/r4Kmq8W/SqJMSrYvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682732; c=relaxed/simple;
	bh=4b5YTC5TX7ZoVlM1noHtSUGvstdNtCxbYAboriPq0mc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=exZfz/uwgxotAi0CtdmayeX5qSqBKUyKr06INOeUlZlCFbIQfnfojtynmrgvfZXRS3wicxs+3GzbTozNaR3SDeH1nQFllDcQqlMu7dTskOdteYskXH/wTS4c1pkFhbd3agQkHR2/xbsAJ1xt5CVdW0i8PuFi3RE1Gv2ue4LuCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JwZtm0gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JwZtm0gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423321F000FF;
	Tue, 29 Sep 2026 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682730;
	bh=L7u+Gan9+Sq4dFEM5W7wSCff5hNQ6t1eHlojbOteWB4=;
	h=Subject:To:Cc:From:Date;
	b=JwZtm0gbiSR7BD4bUxnB8C+1K90/eI0SoFOtqG74jOcEXl1pWBYaheQAdrIp5fcP7
	 SwSjq6oLn4uPNq4wA5jg8sp7JZs5d6jEK+OnwvG0qLhlDjFM91PXQjBWFzZt6lYIrN
	 4jHVFUa2BeF+DSRoyDj/sEIBReK6qXSsIwLez/Ao=
Subject: FAILED: patch "[PATCH] smb: client: delete compound mids on send failure before" failed to apply to 5.15-stable tree
To: adarshdas950@gmail.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:52:00 +0200
Message-ID: <2026092900-threefold-unblessed-1235@gregkh>
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
git cherry-pick -x 8f6f8a48399f82f4a83f7b9f25b9707e0062a4f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092900-threefold-unblessed-1235@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

