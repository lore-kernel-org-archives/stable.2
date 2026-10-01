Received: from mail.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145B384228;
	Thu,  1 Oct 2026 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861803; cv=none; b=ZhtE1db/zfIHyc7FY7L25KegV77IKBJvcf+9jWFfB878CibockIraIjvSTx51yiKEW+lio/8lSj6iHZSwKMgVHrwotX8mxovruiVRoeGWQEZLeXjV3Xk/bl5DT9cxIyYkDLJK+BgbBSfYZTh9iwFQKWkEwt6V0pa09UF+cocPYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861803; c=relaxed/simple;
	bh=g6MZGkVMD8lDOnj82enZyiFjp6VYVN4UMf0xbL8JAgc=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=Aw2XSZHofv45MkR6PIRZKQpRvH+KyXKczNWxj3lVfRvI9Q9G08S5S8hRTvwyY6qcUsRNCrJ9bthIIQhL3iehe+/EsrbwS1VRvI0A22jeX8fNoUidQMB/8vwW1aYVYAaSj9HpTalmV/c4PqXFOTbuMY0wB9RWdoshgDWhXHXnIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=LbA2v5yX; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="LbA2v5yX"
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1790860890; h=from:subject:to:date:message-id;
	bh=g6MZGkVMD8lDOnj82enZyiFjp6VYVN4UMf0xbL8JAgc=;
	b=LbA2v5yXfvJo346mmzMszQq2h9n/GCA7PW16GUVn5Hv4HJrpLTOGkiPHBmcW+X1+uqENBEbHi3r
	SdFVUjvB54w56ViVM/DM43+9ICb+ZAwhdGHwOUZhl4tzL3MRjb9VFp+N3D4iwTsD1T9JjLxstVdV8
	qJwQRXfWCJJnCbmxVUbTH4i+6sbF3yk5/4HXGDUKxk86m4lhx3HyONrH82j3LLGGS0/gcyGY4RoOl
	N/oyft1MaASBRl8GS25w2XFSWOYKzOOnAZzRZg8Y18nPJ62YNq0Mb22soWBTjfZVh5qVR55Y0eype
	IEWXqyIquGn37gAhmU9tp0Ya0/9tfvLAk6hg==
Received: from amicon.ru (192.168.33.117) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Thu, 1 Oct
 2026 16:21:29 +0300
From: Artem Novikov <naa@amicon.ru>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, <lvc-project@linuxtesting.org>, <rrv@amicon.ru>,
	<pchelkin@ispras.ru>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5.15] vxlan: Fix potential null-ptr-deref in vxlan_gro_prepare_receive().
Date: Thu, 1 Oct 2026 16:20:39 +0300
Message-ID: <20261001132039.21201-1-naa@amicon.ru>
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
index a4e911386a..bb2896b18f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -791,12 +791,16 @@ static struct sk_buff *vxlan_gro_receive(struct sock *sk,
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
