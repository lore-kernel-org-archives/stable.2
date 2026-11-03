Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701040;
	b=TK5ojfstaB5H+5nZcJCc7HtJZf9VGsVMqKf7FX8w2VYNV96gRmkm1cGf8XMl7jG/tSWq
	 UXncLRB7knbbgESBfq/CyAkIegCVuvvHDqyA3XxFbez5T4p3/KxhJq6S14NRhUZ8Q5o5l
	 OQ7hCoEAjDToFX+cmoLTQDVFpkwio6QRFkc0M9U8T+hH4dfOAMx35w2BjqbtPPVNKkitI
	 RapLI1rjcG0U1bPedLvl8WZY+cw2joRItmwVisXjuIsdxmEaZOQSAB9yml8L1b4mmvW6t
	 U6QcGmqSWDdu4i8FRrlEM/ffKm55qYnx4egvalssLncmgAsoOJeHgyVTW4zZ4NFhsGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701040;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MD+2k0Mkcrlp6nWnWnhg6nW9gG355tBkPKwe33jjcfY=;
	b=TgayReWtiImqKjuforvp+16sQ+a0F/nUC1DQX8BOVa+/5PfoA6yOu8Q2qzpP8pyGge29
	 hzlH17+sAaj7e4SSPd0v3322S+pzVJC3SwLYIMQhX/y+WA8OABDKSxYIrIvy1hpjAskK+
	 wgkFCKFu1JsNVisGPdBniidAnkHnwecgDV97hBpGRm544dCmbcu+iIaOT9t0LCPesbOto
	 zGU57Az+oENkpnr8/h3uWBtv/KeLo9LbZCctzgBbGewOJ77JTSRxNpAS6vnlxkFCDiD4e
	 iHcGgnoWUqT2TtHAvVjz+wgVdzYLITGqrwwXSnnCFhaViKxzLH0QhmzkYTH/Jr8sRJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E7oHIeGZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B8606B113
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=E7oHIeGZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042C81F0093A;
	Tue,  3 Nov 2026 10:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701039;
	bh=MD+2k0Mkcrlp6nWnWnhg6nW9gG355tBkPKwe33jjcfY=;
	h=Subject:To:Cc:From:Date;
	b=E7oHIeGZYG5reZ7zWvXXUaNyKmAoooM9W68dq277UefHoSL2/Z+RZUKbYL3Z76pq2
	 ZyCvCLxFlKG+uMZzqTnFxPs4bHEUtyYr2j8J7O+5mlRmBqdC4oXJVPnn4qY2Z+tRqE
	 i5k4EoBb4vttNBOdGI0JSC6yUFAxcuS8Y0lMgsBU=
Subject: FAILED: patch "[PATCH] ksmbd: fix session reference leak on compounded SESSION_SETUP" failed to apply to 6.18-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:17:17 +0100
Message-ID: <2026110317-undermost-pretty-44e0@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 03bd8f5279e490e15e0c0f0fa388ffbd2fbacd65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110317-undermost-pretty-44e0@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 03bd8f5279e490e15e0c0f0fa388ffbd2fbacd65 Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Tue, 27 Oct 2026 10:21:35 -0500
Subject: [PATCH] ksmbd: fix session reference leak on compounded SESSION_SETUP

A compound request can place SESSION_SETUP after another command. That
earlier command leaves a reference to its session in work->sess.
smb2_sess_setup() then overwrites work->sess with the session it looks up
or creates, and the dispatcher later puts work->sess only once. The
inherited reference is never dropped. That leaks the session, together
with its setup connection and socket, and every repeat of the compound
leaks another.

  unreferenced object (size 512):
    __kmalloc_cache_noprof+0x32c/0x3a0
    ksmbd_smb2_session_create+0xf6/0x9c0 [ksmbd]
    smb2_sess_setup+0xda4/0x6280 [ksmbd]
    handle_ksmbd_work+0x88c/0x1cb0 [ksmbd]

Save the inherited session on entry. After the request has been
processed, release it once, but only when smb2_sess_setup() has replaced
work->sess with its own session or cleared it. Do this after
ksmbd_conn_unlock() so the put does not run under srv_mutex. An error path
may instead leave the inherited session in work->sess. Keep it there, so
the dispatcher still puts it and the error response is still signed or
encrypted with it as before.

Fixes: 7aa8804c0b67 ("ksmbd: fix user-after-free from session log off")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f4b61521beac..9f2b435fd437 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2563,6 +2563,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	struct smb2_sess_setup_req *req;
 	struct smb2_sess_setup_rsp *rsp;
 	struct ksmbd_session *sess = NULL;
+	struct ksmbd_session *prev_sess = work->sess;
+	bool installed = false;
 	struct negotiate_message *negblob;
 	unsigned int negblob_len, negblob_off;
 	u64 previous_session_id = 0;
@@ -2679,6 +2681,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			int sign_ret;
 
 			work->sess = sess;
+			installed = true;
 			if (sess->dialect >= SMB30_PROT_ID)
 				sign_ret = smb3_check_sign_req(work);
 			else
@@ -2731,6 +2734,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		conn->binding = false;
 	}
 	work->sess = sess;
+	installed = true;
 
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
@@ -2928,6 +2932,14 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	}
 
 	ksmbd_conn_unlock(conn);
+
+	/*
+	 * Later in a compound, work->sess holds the reference that an
+	 * earlier command took. Drop it once this request has installed
+	 * its own session there or cleared it.
+	 */
+	if (prev_sess && (installed || !work->sess))
+		ksmbd_user_session_put(prev_sess);
 	return rc;
 }
 

