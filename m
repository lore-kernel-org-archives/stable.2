Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606015;
	b=FeBNNpGK3OV8dx6nbE2p+kPv4A93MWHKFHNklsP3PScv/8QKTXPMUXKUMWQPfjYR0w2S
	 Hrx/qDMtqRA0znRgWgvTs6WeeV5HDibPNigKsUWRUPsJ3bRcRXpnNkcbyFUvXB1Uk/WjK
	 00okZMxwVab1T4HdbQBk+goHoUwXFQVhRfaxtgiLbqC4OOmiUT1vhLnPpYoNOZr42OU0K
	 GWqsb++hcKtyXvDz3MW4rgPgYU56/wE7PHjPtslSbpB3FSvxmAm3dFhduUwDaQlEwgHde
	 /FgCXdvp9VJAAlwmE+LPCD0vl1WImikgUSn5d+aA3ncoyYgc4yF+tzLlGw50IqqKQOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606015;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zwlEdxHJyYZ97cuGZ7Q9Ae9f8auUCLXrXbNyTaRPCgg=;
	b=GW85KNrL8wMHNXACT6YfdKz02/5YQHh0JbcpQtthiOAGBeklasqZF8Eiih9zFDPRf+XC
	 7onVXaX7oUgzQvZPQCIPbo2KpQ+gAkyu9MDXXXc80LdX4UCRLfcfyld0OIT7tQSAw7vvU
	 PflZnZibByttp9HIyKs+ENOZ4WWLQFb7gc2dF51lKnNvtMZ7rf9Kh8ef11DaVmeQFs6kv
	 1B8QTT5IBKCffDja4L2ORYMiKmf6Cn1psamN/QJQBSkhnQAVMVQsTnSTMIY9IsVSl+wbh
	 43ysRULY5c6B7jZWiLeVkdQNPXCVekUl0zpRgemb0LvjU6cHAQFPfCG2f/ksgXHNiEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TwCvX3ym;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFE606A6BF
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TwCvX3ym
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9CA1F000D1;
	Wed, 25 Nov 2026 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606015;
	bh=zwlEdxHJyYZ97cuGZ7Q9Ae9f8auUCLXrXbNyTaRPCgg=;
	h=Subject:To:Cc:From:Date;
	b=TwCvX3ymm8+Uj3FaeP9gdwAyTlU5oV2KxgXRkNkkDkhV3FxoXeBkJAuYUQ9gkdiBV
	 VCgdSiXgbPzFWlO0q9E+RJoG8vwg6NsU8hvLmVehc9IwB0VX3syKYP5Lh5Hx5wikOV
	 K+9pr//cMqn08rQ6K0BwlQVyOJ1CK7QUEhDa26Ek=
Subject: FAILED: patch "[PATCH] smb: client: skip NULL channel in __cifs_put_smb_ses()" failed to apply to 6.1-stable tree
To: joseph.qi@linux.alibaba.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:12:49 +0100
Message-ID: <2026112549-explain-affecting-e4d8@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8deaf64a59a263161dfc5128f8398fb3dcba4fac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112549-explain-affecting-e4d8@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8deaf64a59a263161dfc5128f8398fb3dcba4fac Mon Sep 17 00:00:00 2001
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Date: Tue, 3 Nov 2026 17:15:58 +0800
Subject: [PATCH] smb: client: skip NULL channel in __cifs_put_smb_ses()

cifs_chan_skip_or_disable() clears a secondary channel's slot in the
session (ses->chans[chan_index].server = NULL) without lowering
chan_count when the server stops supporting multichannel.  When the
session is later released, __cifs_put_smb_ses() walks every slot up to
chan_count and calls cifs_put_tcp_session() on it, which dereferences
the server pointer immediately, so a slot left NULL by the skip path
makes the release crash with a NULL pointer dereference.

Clearing a slot without lowering chan_count is older than
cifs_chan_skip_or_disable(): cifs_chan_update_iface() could already do
the same since commit b54034a73baf9 ("cifs: during reconnect, update
interface if necessary"), and the release loop has been unguarded
since then.  Commit 12d1e301bdfd1 ("cifs: do not let
cifs_chan_update_iface deallocate channels") later removed that
trigger, but the crash is reachable through it on older kernels.

cifs_decrease_secondary_channels() already guards the same put with
if (server).  Add the same guard to the release loop so a skipped
channel slot is left alone.

Fixes: b54034a73baf9 ("cifs: during reconnect, update interface if necessary")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index e68fffb2ab2e..6497b0d54fea 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2200,7 +2200,8 @@ void __cifs_put_smb_ses(struct cifs_ses *ses)
 			kref_put(&ses->chans[i].iface->refcount, release_iface);
 			ses->chans[i].iface = NULL;
 		}
-		cifs_put_tcp_session(ses->chans[i].server, 0);
+		if (ses->chans[i].server)
+			cifs_put_tcp_session(ses->chans[i].server, 0);
 		ses->chans[i].server = NULL;
 	}
 

