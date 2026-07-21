Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A492417D60
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625880; cv=none; b=b2orYvogDJVNFg/FEJ2fhoHXebuyQIAbOfrTL2j+DeMsgHUbmBGUJNXoyYP+cIeqO4cKxddC4PS6NGA+aZZNG8bQE4ONkAgXX14/80/goQJRBxhvxFGvBb38DEV03ozGO36u39RLE9Z1Fej0jw1SlVlqFy5z8rjwZIge+LrViIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625880; c=relaxed/simple;
	bh=pIjuTSCGNH2m6PwkXQO8ieYJ8KMh7nrxSZCJrbUL+1Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PiDWIj9l6R2haUYojLe+xdSvHzOZcEQm+t5bhm1F98MD27eJvE8r5DLl8an6efMiHSTIUSRkYLhlCKcwaWP5szP6uGYhMKCW4UxAyuczLCQHiLaJnTceWxLVzfv4ksPrEFNuYosr0u/n4cFTuDnR/os/2ZwCwcQ2WcQ7wbo8w0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=duZUB3vH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="duZUB3vH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECAA1F00A3D;
	Tue, 21 Jul 2026 09:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625878;
	bh=EKjuMilfqeXC8YTlzDZKO6GvyhopsudgV+DP3pzKCuo=;
	h=Subject:To:Cc:From:Date;
	b=duZUB3vHlZry1RIuyp6z7wDwAP7X48U/6P0VU7xtYCKF6lnUu7xPglHDapHqESEQr
	 MRMJBl9Pnm++q44hy4yNuPwxvMFRskM/jQnu0JO3IWfNUBA6SmcHmToiOIeXiCFaNC
	 UHdR3oYaZezIR6mquzcnw7e/iFaWeXAa4R3+1TT8=
Subject: FAILED: patch "[PATCH] landlock: Fix TCP Fast Open connection bypass" failed to apply to 7.1-stable tree
To: matthieu@buffet.re,mic@digikod.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:23:33 +0200
Message-ID: <2026072133-clapped-variably-21a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 33cb713db0161b54f04fe830e062c9e102c29a04
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072133-clapped-variably-21a1@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33cb713db0161b54f04fe830e062c9e102c29a04 Mon Sep 17 00:00:00 2001
From: Matthieu Buffet <matthieu@buffet.re>
Date: Wed, 1 Jul 2026 23:46:27 +0200
Subject: [PATCH] landlock: Fix TCP Fast Open connection bypass
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The documentation of the socket_connect() LSM hook states that it
controls connecting a socket to a remote address. It has not been the
case since the addition of TCP Fast Open (RFC 7413) support, which
allows opening a TCP connection (thus, setting a socket's destination
address) via the MSG_FASTOPEN flag passed to
sendto()/sendmsg()/sendmmsg(). The problem then got duplicated into
MPTCP.

Landlock did not take it into account when its TCP support was added,
leaving a bypass of TCP connect policy.

Ideally a call to the LSM hook would be added in the fastopen code path,
in order to fix this generically. But connect() hooks are designed to
run with the socket locked, unlike sendmsg() hooks.

Closes: https://github.com/landlock-lsm/linux/issues/41
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
Link: https://patch.msgid.link/20260701214628.33319-1-matthieu@buffet.re
Cc: stable@vger.kernel.org
[mic: Wrap commit message]
Signed-off-by: Mickaël Salaün <mic@digikod.net>

diff --git a/security/landlock/net.c b/security/landlock/net.c
index cbff59ec3aba..46c17116fcf4 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -351,6 +351,14 @@ static int hook_socket_sendmsg(struct socket *const sock,
 	access_mask_t access_request;
 	int ret = 0;
 
+	if ((msg->msg_flags & MSG_FASTOPEN) && address && sk_is_tcp(sock->sk)) {
+		ret = current_check_access_socket(
+			sock, address, addrlen, LANDLOCK_ACCESS_NET_CONNECT_TCP,
+			true);
+		if (ret != 0)
+			return ret;
+	}
+
 	if (sk_is_udp(sock->sk))
 		access_request = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
 	else

