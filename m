Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771772EEE83;
	Sat, 19 Sep 2026 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848373; cv=none; b=f4at05q841vQGwZtbfsrjyA0WXb28WAd40nyshlk2xoXGTLllOP63rxSTJ3DPSXTBcmGAAyymJc8+NXqyP9Q7xnVQ1Nv9MQGyScpJKoVTjfKc+vVVZyhKSNLjNDcq3YVD2iQ4PGnYiehStngeBmtq1BimFOAX8++S3RgM5rUX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848373; c=relaxed/simple;
	bh=z4bHwk34w97PhcdiQYgvyrJPUJnicLu6Dy4p42791Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dspGU9yKisUutobkGQ/XMesZoHHHYXATxOy5ei2rT+gJRqBTvPGvGawAdwDzfshyR90IQq/HngOP1J4kpvwNKfDCx+OMyvtkDyjE2P8vs/1t1J46OCo7OliWHlZmKJ3U6htM9OuvlepgMQuRzVNTRNYjAFYLAh6KwJlVbZ8j62Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJhcjI4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJhcjI4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9591F00893;
	Sat, 19 Sep 2026 20:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789848372;
	bh=Lqp576fex7GWhNKtxj+fK8Pv3UXdez1DYfIaQ3MwAlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJhcjI4/5SBNcoGQ/ekFujdlKX9nEk2wiIxnFT4gcwmjAvmlR8UPASPROXpr2yEhm
	 6GILKhlBs+QXb/eaCwJqujvYRo8npMFmoDK5Adsz122zerJJvS6ikD2RZLpg7trhCu
	 SzDLQX1Nkm0ZLR/wMikbGsSg31YA5q0Noddsy4t0tttt2LEGnqPs5TowhAbcv+/0KR
	 RdcyvkZ7265MA8TGv4SA1jr4Cte1DB27OBR1uOkDHGcWGfBzXXjYttj4O11jaVHxOO
	 kJnMsRl82jNIuedf6hhAZHi/LmLlIFrih5iYbNJll+xdRqsEPBBDTzIDrwrRc9kYoP
	 svN4RNUm6Ya4w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 3/3] mptcp: fix bad accounting in __mptcp_subflow_push_pending()
Date: Sat, 19 Sep 2026 22:05:58 +0200
Message-ID: <20260919200554.2005069-8-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919200554.2005069-5-matttbe@kernel.org>
References: <20260919200554.2005069-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=matttbe@kernel.org; h=from:subject; bh=Z7wZIxyI5mLrdl16r9OvM6zFuezi5/svoU0ovvJE2eE=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvVbf8NtaXe9B4Sk+93UBJtM27v6U96V9s3fdbe7Z/ dW8bkodHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZNY/hn8qKzSmH7lQ0Trxq ufV7z+ks08r8EHsG6diH3PySdR91QhgZNnX6RFntN9aaWDv3xxHeTXo6FjZMkbnGNkLrOaIOTj3 IAAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit f3ef03357396d4b147d8e76c75fb612c2f264ffc upstream.

If __subflow_push_pending() errors out we should avoid updating the
copied byte counters, to avoid mismatch push call later on.

Fixes: 0fa1b3783a17 ("mptcp: use get_send wrapper")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-3-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3c1ad8601fb2..cd76b2d742d3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1750,7 +1750,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			if (ret <= 0)
 				keep_pushing = false;
-			copied += ret;
+			else
+				copied += ret;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
-- 
2.55.0

