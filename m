Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701069;
	b=z3Ob86R91zsNerocEr4qus4SVaPOGokvQNQnk0G7FgxrXHxxdzMKVF2ETUWqUww8dycH
	 fypkVHXPZzbvav3iHYWoflz8WX22/6DA67YuFEW7rB+WGkv4XCRonniEpRu4BLkYnpvhf
	 dtYPZ/F48NZc8vTnQdmqBCU3dw2y065Z+jkdfYZa1MDunMSpidGxkZhmZh3359aCFVFsh
	 3kKg0Lfpi+OgtvOy56x23Ym3QJBgzkBdM12sbVY6dfco8kWLgabYGFUeHcO9XRkyMyJFJ
	 6/0GaENTNMSoJXPQvTTCRXHBDIcI1JTnSUL0uQeQzo1hQhRAR7ORB9F9k9JZS9s9QcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701069;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PlLye3r4fUCtOc4d+fsDZHc7TeGIjOUiavjkub5r+oQ=;
	b=klFajpUXaEoKAvEn3z6DrKP8kI1wRaz6raftRsxqe70lBvTFnKq/Sx6451XOdVDJs0gB
	 1slNp7w1om8+x0bXSSDJBXNXwS1sRxSHex5jCXSCWRG3HX+kmLoG9gZbdPvph6H0PQMfq
	 ODKOKTXvlfMcS2I3a8mcweB0iUYHIeFHcZHWT9J/KuGo9XwscbvmhPv+PVgSBtPwj3gm/
	 HKup4Sd1+59iw0POcffXH1IlRWFMurKamLiawlqvgWymuqHuORqo3yPj7jrLQirC7Tmsp
	 NLw6i545yZgvPaBsX+w1B9p5d99nGhFIeskbQuLw3chUqx2ye/27xUlYjxUiMf2Z2AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Xv39xK3R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7ED606FAF1
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Xv39xK3R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FC61F000C1;
	Tue,  3 Nov 2026 10:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701068;
	bh=PlLye3r4fUCtOc4d+fsDZHc7TeGIjOUiavjkub5r+oQ=;
	h=Subject:To:Cc:From:Date;
	b=Xv39xK3RLzzNSrnpT1OI7/djOT7WCMof4mAuHm2V60ifwP+ybPkROvtZ+NtZXeJfc
	 OVwAjPUUqyvP7OQeUXY+q1EoO2UOjlXKRw8jIUq1wS+NPOabaKIxA6OLyxTizveiRk
	 OJAddyHZEhbq1cR7UqU3SBQl4Vj/yjkThv7gz5So=
Subject: FAILED: patch "[PATCH] ksmbd: ignore network devices of other namespaces" failed to apply to 5.15-stable tree
To: j.koester@act-marketing.de,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:17:46 +0100
Message-ID: <2026110346-accuracy-product-ad13@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1f5ce2b8b9164b3fcb93a18fe1e7b451c2fc6eea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110346-accuracy-product-ad13@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f5ce2b8b9164b3fcb93a18fe1e7b451c2fc6eea Mon Sep 17 00:00:00 2001
From: Jan Koester <j.koester@act-marketing.de>
Date: Mon, 26 Oct 2026 10:25:37 +0100
Subject: [PATCH] ksmbd: ignore network devices of other namespaces

With no interface list configured, ksmbd binds every interface that
comes up. ksmbd_netdev_event() does not look at the device's namespace,
and create_socket() opens the listener in the namespace of the task
raising NETDEV_UP. A container with its own address on a bridge brings
up its interface and finds port 445 in its namespace already taken by
ksmbd, so an SMB server running inside the container fails with
"Address already in use".

Interfaces are also matched by name only, so a container's eth0 going
down would stop the listener on the host's eth0.

Only handle netdev events for devices in init_net.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Signed-off-by: Jan Koester <j.koester@act-marketing.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 937d321fa364..c51b2f7d8b27 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -858,6 +858,15 @@ static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 	struct interface *iface;
 	int ret;
 
+	/*
+	 * ksmbd serves the initial namespace only. create_socket() listens in
+	 * the namespace of the task raising the event, so a container bringing
+	 * up its own interface would get a listener on its port 445, and the
+	 * name-only interface lookup would let its interfaces stop ours.
+	 */
+	if (!net_eq(dev_net(netdev), &init_net))
+		return NOTIFY_DONE;
+
 	switch (event) {
 	case NETDEV_UP:
 		if (netif_is_bridge_port(netdev))

