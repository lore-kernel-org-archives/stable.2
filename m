Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B04A8435;
	Thu,  1 Oct 2026 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860912; cv=none; b=jeE/mGBmXB4fMnQD2BkIRCQUceKzKqoZM4YCr+SE9D1AUpG+/VKHpp4GwtYvtSufGnqL+rMFIB5+OcVvZSbiJmPUahqZzPVKxGKyeaIR3brXywExkgBbLvV2YiRqngQJ72GcIIzdgZkzxezBnhqTjIEaEWecvDB86DzzmRsFtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860912; c=relaxed/simple;
	bh=ttaACn+J7nN8EiSTpFlyrWMO9oy/PZG/11Jzw/p2DlU=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=A94LQ3lvPLxBDgVols61/riEbhSfWAZi4poxf8gULrsuJFYxQBYoplubLZoAFhv4p0CMfQ4XwCJOeQrK2juTWeSbjJegbRn42so1rsXKC9osH3de4VUtWWRtRMnxxga7S8/8q3L50ldUofDRVC14YQPt/Wu78xbcrtVaqjd2cEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=DaC9eDp2; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="DaC9eDp2"
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1790860898; h=from:subject:to:date:message-id;
	bh=ttaACn+J7nN8EiSTpFlyrWMO9oy/PZG/11Jzw/p2DlU=;
	b=DaC9eDp29kijErRdjlhd7HK0rwp7JnOqOcPaeVUljaPZfv/cpng45AjNHAk1mNEhk3UwkyPUPMZ
	3Hk5TU192jzSF+63RTn2PNMiFAiS1mkc7UOkDyuvBKL0z2zYQFGP1ALK7+fV22RSnqPsC1toUZU/F
	/OfOFX205uI8uzxkNB8fNDgrYgXTQPi27wjToptHi4I4/4r8t4c1VSzpPO4PInlyt5OQR8TDM1AOp
	BgC0XduvMImn/9BZo+2VjQWJvgtQi0z/Ii9WvAE4uYYYyS1YjWhRl/4hARlvdUrP5feOb2pXlNqPn
	WMae/mfZME5UvuGMNy6fXADJnkbwLq9ruY0w==
Received: from amicon.ru (192.168.33.117) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Thu, 1 Oct
 2026 16:21:37 +0300
From: Artem Novikov <naa@amicon.ru>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <lvc-project@linuxtesting.org>, <rrv@amicon.ru>,
	<pchelkin@ispras.ru>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5.10] vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
Date: Thu, 1 Oct 2026 16:20:37 +0300
Message-ID: <20261001132038.21173-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Kuniyuki Iwashima <kuniyu@google.com>

commit 30a45c0bffdd62350261e2f2689fdba426a33578 upstream.

udp_tunnel_sock_release() could set sk->sk_user_data to NULL
while vxlan_gro_prepare_receive() is running.

Let's check if rcu_dereference_sk_user_data() is NULL after
skb_gro_remcsum_init().

Fixes: 5602c48cf875 ("vxlan: change vxlan to use UDP socket GRO")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260502031401.3557229-7-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Artem Novikov: Apply the check to the older vxlan_gro_receive()
  implementation. Initialize the remcsum state first and use the
  existing out path for cleanup when sk_user_data has been cleared. ]
Signed-off-by: Artem Novikov <naa@amicon.ru>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/vxlan/vxlan_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8dad17023e..7a916eebf5 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -790,12 +790,16 @@ static struct sk_buff *vxlan_gro_receive(struct sock *sk,
 	struct vxlanhdr *vh, *vh2;
 	unsigned int hlen, off_vx;
 	int flush = 1;
-	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
+	struct vxlan_sock *vs;
 	__be32 flags;
 	struct gro_remcsum grc;
 
 	skb_gro_remcsum_init(&grc);
 
+	vs = rcu_dereference_sk_user_data(sk);
+	if (!vs)
+		goto out;
+
 	off_vx = skb_gro_offset(skb);
 	hlen = off_vx + sizeof(*vh);
 	vh   = skb_gro_header_fast(skb, off_vx);
