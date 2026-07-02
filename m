Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9BA3537FF
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981280; cv=none; b=PG4g41nrV58PhvWM3N00d0eoBXkKvaJi4EHhuZCI0VM3aHEm8oMpMKkXtJGPUIct3WURpeO/lTK2DgM1QUGCex6ANi2Ix/J855wgha0P3f8kbsRMkqRMQvkA+d7v5Lc7AvqeQYcTJwCyWjn1ba1QqywORfyHxafOCjKDj3GG/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981280; c=relaxed/simple;
	bh=w0nsHqVI+7lPqEWqpPA9hOKXNbt9XgaScpagqBoESxk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YYj1l41VzK4cg2L5tIGBDF7H+3ISCR193fZOe0m5cVcgOYogKMccZGHtMdEZ4Gjr9w/8l338fOaWjyMHdSH3VtWCM0E/jhTw/Noofimuv0ttCbsFt+iMqFrWNsx657SydGrilxAgAUkQ+sFYLjRNJVLo/wi8yPewCzkpD6zB3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xNyPxr74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xNyPxr74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563051F000E9;
	Thu,  2 Jul 2026 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782981279;
	bh=MherCydkunyTD/o8jZ3ULS7graYyJ3fqvRox7jYpdXA=;
	h=Subject:To:Cc:From:Date;
	b=xNyPxr74m1uRuZ72Q8yMRnRVFPfIAuLhD7fCN1A+pzdsgob0eEo+8StWWnPAeoWPu
	 wUx9kw7mJ+AiJD9+Wm4zdDPu0aytmSI2ocnnjhzL77XkEc+ENe1faFE4+Nj7DPAYh+
	 WxcvQ++eNHvcIFGtYTBqyK/4aycP/BAUky/PrzI8=
Subject: FAILED: patch "[PATCH] apparmor: mediate the implicit connect of TCP fast open" failed to apply to 5.10-stable tree
To: hexlabsecurity@proton.me,john.johansen@canonical.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 10:34:41 +0200
Message-ID: <2026070241-scabbed-quarry-6e0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4d587cd8a72155089a627130bbd4716ec0856e21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070241-scabbed-quarry-6e0b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4d587cd8a72155089a627130bbd4716ec0856e21 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Mon, 22 Jun 2026 15:57:38 -0500
Subject: [PATCH] apparmor: mediate the implicit connect of TCP fast open
 sendmsg

sendmsg()/sendto() with MSG_FASTOPEN is a combination of connect(2) and
write(2): it opens the connection in the SYN. apparmor_socket_sendmsg()
only checks AA_MAY_SEND, so a profile that grants send but denies connect
lets a confined task open an outbound TCP/MPTCP connection that connect(2)
would have refused, bypassing connect mediation.

Mediate the implicit connect when MSG_FASTOPEN is set and a destination
is supplied. Add it to apparmor_socket_sendmsg() (not the shared
aa_sock_msg_perm() helper, which recvmsg also uses) and call aa_sk_perm()
directly, mirroring the selinux and tomoyo fixes. sk_is_tcp() does not
cover MPTCP fast open, so the SOCK_STREAM/IPPROTO_MPTCP arm is explicit.

Fixes: cf60af03ca4e ("net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: John Johansen <john.johansen@canonical.com>

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7457067e8192..88d12e89d115 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1422,7 +1422,21 @@ static int aa_sock_msg_perm(const char *op, u32 request, struct socket *sock,
 static int apparmor_socket_sendmsg(struct socket *sock,
 				   struct msghdr *msg, int size)
 {
-	return aa_sock_msg_perm(OP_SENDMSG, AA_MAY_SEND, sock, msg, size);
+	int error = aa_sock_msg_perm(OP_SENDMSG, AA_MAY_SEND, sock, msg, size);
+
+	if (error)
+		return error;
+
+	/* TCP fast open carries connect() semantics in sendmsg(); mediate
+	 * the implicit connect so it cannot bypass the connect permission.
+	 */
+	if ((msg->msg_flags & MSG_FASTOPEN) && msg->msg_name &&
+	    (sk_is_tcp(sock->sk) ||
+	     (sk_is_inet(sock->sk) && sock->sk->sk_type == SOCK_STREAM &&
+	      sock->sk->sk_protocol == IPPROTO_MPTCP)))
+		error = aa_sk_perm(OP_CONNECT, AA_MAY_CONNECT, sock->sk);
+
+	return error;
 }
 
 static int apparmor_socket_recvmsg(struct socket *sock,

