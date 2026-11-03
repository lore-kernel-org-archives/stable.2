Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701043;
	b=QW4NrRuwEn1RR2PhStWA6ZbALVAzwRARn5lvVpW+Naemkwe8VzitLVipBOGZuBGm2mxu
	 k24+fjdi24hBBXpSmhKnoPSUnA8DnfyyVfqXOyuwN7NKzUVvhIC+1rurpjEF7FmyjABGH
	 s40jTTk/ynWuUD1D5BV1chQKVel2k2wjiP6ASvj86bz+YAzc059gbNOj3c+ZjFJptz1nv
	 td+xvEoqZxQEKrzybt31VAUQ8u2eT08TvBuAOGeEIiugTJhDI1Pi2r2tGibGx721gNoNF
	 FJ2ITfkdFqyZVCvcyuFIUY4eggTFxFmnn+CG6x8KKOWu0wPRUZQkb4WrKvyxd5X4nzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701043;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zRVJDVby/XU2Xnm1lYTXCYO8BsQrPDZhCx9uVl0CQ30=;
	b=QxzynuWOOY5LIiIjeHbqR4Lrbb1OIESc9Je0g8D6BNPMoC/mi0KdM14ERIiL6usXAYAS
	 Crxcrl1StKE4ogTQwK5GP0dHZiqK7dgcTMSyYvHHgz6ym/YOLHyjhJaOKI42ygsQ01e2+
	 V35+sZejhieSqk9l/wK6ywDG2OBTVXHneq1GiK5/BzrO1d8NFac/dz8lNDmf916Lq1vGA
	 1RwCeXc8BiVE+gWAtXc2cpaa+pfmxfmdI8KjVhWJOxqv01qfE8LOtfl+C0PVhrjXnLirW
	 1p4onAMzgCa8g+PmNiGUejXWtcjGL5Cw+ugE29h+0dL/fEHuH9XdQQM4e3OjlURbnkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lNUxoh35;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA58606EEA9
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lNUxoh35
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2A11F000C1;
	Tue,  3 Nov 2026 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701043;
	bh=zRVJDVby/XU2Xnm1lYTXCYO8BsQrPDZhCx9uVl0CQ30=;
	h=Subject:To:Cc:From:Date;
	b=lNUxoh353iLHSUmTSJYw81h+2SfFfiGl3Lq0CPuLi+gWWvKRug2CZhGOx57TBojLz
	 yEeCisxze7m8SLbWVND2MJCrKTXu+WfxNOf9hd4qqhfqqfyJ1w5B/T8erEp5bcVa3U
	 afjCISrk41wJ4JMAI2PDdMxwZoaUhUbO2uy6UxuQ=
Subject: FAILED: patch "[PATCH] ksmbd: fix session reference leak on compounded SESSION_SETUP" failed to apply to 6.6-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:17:19 +0100
Message-ID: <2026110319-itinerary-very-706a@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 03bd8f5279e490e15e0c0f0fa388ffbd2fbacd65
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110319-itinerary-very-706a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

