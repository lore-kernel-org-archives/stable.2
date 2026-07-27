Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3034F259
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154801; cv=none; b=r4HNWxuQWHqv44sXTtXN3kLWS/MCQB/3rEJituVON3ZXQOwf+vXPDNmASVGSWQKvXVi8uMcutTEANBhRUcmwjJdLgsJrsZ34oFNc1/zn38p4qIkREMTxD4IODJY9i0CD4214FqSsHoYY0vWBJKgGz6ee21DeCuHK+pmHT8sBXA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154801; c=relaxed/simple;
	bh=YAoTBxwoMsYbEodMy9BFDpCymf7kVeR0WkPRHkanteM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK5M/mXws7p/GmPwylyfRB2Nb1yKgOIR2jon9Je6lE2UNAB+ZKtM/8KB3TCg2u7LWKSKX2MWCvu2LnPpogMktKwxLK0jGhllxmhv01M6Ag2BSSFrqqvC/ONM5HwPTyEkyQIK47f0Um03qdtd2BcwiYXbpAnXQ62CU+VgG7HG9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRrQIP7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRrQIP7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FF71F00A3D;
	Mon, 27 Jul 2026 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785154800;
	bh=Z/9LKZRDRSOmu0rezA9Ng/VlG2DgBcbHg3P49jQzNYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRrQIP7eFfAK8zH8ER6x4V7NSui8WO7sWLSYkE64TxYZCKMXRscka5mx09lq67GzI
	 pW499GN4iWANg/7gQDglim0TcOuIz4jeE7IBtmb4OkbQVBE+Oc+4Gnk1r+H2/R4lkm
	 nMaKMEtfPwJvl/UP8QRxh2rUzpzVCWwKdB+BvapgKgZSeTN9kGILBIoaMgLIHN9oHm
	 feReRUmcU5i7i2tnOfE9PYh329IqYDKBD9299tV7pYg/mOy8M0rnuerXEkSFmNKnob
	 OcWobhMmnxAkR1121MdVh8Kt6ZDxMNVKYt7yZJ+RB334lqqqMHnhaIUeMvvidHxZov
	 vhIw6KVPaC3xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>,
	Qihang <q.h.hack.winter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] tcp: Decrement tcp_md5_needed static branch
Date: Mon, 27 Jul 2026 08:19:56 -0400
Message-ID: <20260727121956.3778569-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727121956.3778569-1-sashal@kernel.org>
References: <2026072046-unworn-conductor-0b8e@gregkh>
 <20260727121956.3778569-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Safonov <0x7f454c46@gmail.com>

[ Upstream commit 6f6e860e370c9e4e919b92118a25e9e1f82e9180 ]

In case of early freeing an unwanted TCP-MD5 key on TCP-AO connect(),
md5sig_info is freed right away (and set to NULL). Later, at
the moment of socket destruction, the static branch counter
is not getting decremented.

Add a missing decrement for TCP-MD5 static branch.

Reported-by: Qihang <q.h.hack.winter@gmail.com>
Fixes: 0aadc73995d0 ("net/tcp: Prevent TCP-MD5 with TCP-AO being set")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
Link: https://patch.msgid.link/20260625-tcp-md5-connect-v3-3-1fd313d6c1e0@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 7a769b75fc1f3d..d2d8e989aac7c3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4124,8 +4124,8 @@ int tcp_connect(struct sock *sk)
 			tcp_clear_md5_list(sk);
 			md5sig = rcu_replace_pointer(tp->md5sig_info, NULL,
 						     lockdep_sock_is_held(sk));
-			if (md5sig)
-				kfree_rcu(md5sig, rcu);
+			kfree_rcu(md5sig, rcu);
+			static_branch_slow_dec_deferred(&tcp_md5_needed);
 		}
 	}
 #endif
-- 
2.53.0

