Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F79650AC30;
	Tue, 13 Oct 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901793; cv=none; b=u/kac9vhyTDB5bVF2d1fUTYoAVz1AQOxAdp3a4xeYbOWBAs7cghv92a02yeWV4sKkzF9QPTXljMfTOzGh96FzWAs5g6ErziUIYKSBuS7mD2SUbQI6p7t0UZrVqgZ1gpPzsEWYIHHAkrJPPnhM01WRlIEFBUDXe/TcUOjXWDWUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901793; c=relaxed/simple;
	bh=bKy5Oklgz8n6gkj5dfyaeFlXazXcC30okFNxUY7gjl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tjwqd3PXhxxeAOlKcUgoW2am4w5uu83la/3vziJn4cuwAHY4cMmix5WP0y/4iRuWE8T8Oj56oyBFY6H5oOvJK1fdAOaNw8bvpqBaoUDB1b/nypv37WmOuuXD+U5YETYmUZPo/vEBaYH3L01s5LhksyT0LqE6lvKYXYb0asEyTCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmuYpX9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmuYpX9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF81F00893;
	Tue, 13 Oct 2026 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791901792;
	bh=Tto5KOWAoI1gJxTOOJjG6YNAV5y6e3OxsFdzPDbUl0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fmuYpX9JcZ+j50ySmf0IFrnZIzMzZRuaWcSEB1d//PNuBdRfDvEMOc/84uqdW8ZY2
	 2YVQ1K0lWUKvh040zVluqGmWuus1OCfPbeAFTxWwL5k9G2A0+MOzvDp1Ev16ZGyZeA
	 NsfHQYPGIFKaKQGu0UuXuaaFc8BAQ/JzAmzh+hpqz/rUlOifveP23QGPsi4jkIZzYX
	 tONC+21Emha5DFR7xoMtBwmLu9ZU/wVl6VMF58wwG/5UqU9sKAzVwEgR47ANJJatkN
	 OzVe8oxdim21oe5Hszl2XPwlfqU15bblck3CTuxtwKF/GMCIfr0IT/GUGVeh+HEseX
	 HPoA1OFU/X9uQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Oct 2026 16:29:19 +0200
Subject: [PATCH net 1/4] mptcp: reset msk state on early connect failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-1-932c9b182fc7@kernel.org>
References: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
In-Reply-To: <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Quanye Yang <quanyeyang@proton.me>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2lbUcr8HsAkGQq5oDGKp8tCE0/67cLkwLj9/f5Hi7jc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLOOYQr+GXUPPibHh6+PvDks6YdCR5Gt4VySrUv57yMu
 aPJ6xjdUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBFjLUaGyTMmy9pYitXXfDSb
 Z9D3/1lpZZWvv+Ryp/T20OVHEkusGRmWP7hum55w8fLby4IbH5x1FCh0EzX6IqT52nPKJNdvUYE
 MAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Quanye Yang <quanyeyang@proton.me>

mptcp_connect() can fall back before the subflow SYN is sent, for
example when the netns is in an MPTCP blackhole, token allocation fails,
or MD5SIG is in use. If the subsequent subflow connect() fails
immediately (EAFNOSUPPORT, ENETUNREACH, ...), __inet_stream_connect()
returns while the socket is still SS_UNCONNECTED and never calls
->disconnect(). This was reported by Clashiko [1].

The error path only dropped the token and moved the msk back to
TCP_CLOSE. MPTCP_FALLBACK_DONE, allow_subflows and
request_mptcp were left as after early fallback, so a later
connect() on the same fd stayed TCP-only.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/633 [1]
Fixes: 0235d075a592 ("mptcp: mark as fallback even early ones")
Cc: stable@vger.kernel.org
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e89a69ab927c..e6f73a5ee630 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4212,9 +4212,16 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	 * subflow_finish_connect()
 	 */
 	if (unlikely(err)) {
-		/* avoid leaving a dangling token in an unconnected socket */
 		mptcp_token_destroy(msk);
 		mptcp_set_state(sk, TCP_CLOSE);
+
+		spin_lock_bh(&msk->fallback_lock);
+		msk->allow_subflows = true;
+		msk->allow_infinite_fallback = true;
+		clear_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+		spin_unlock_bh(&msk->fallback_lock);
+
+		mptcp_subflow_ctx_reset(mptcp_subflow_ctx(ssk));
 		return err;
 	}
 

-- 
2.55.0

