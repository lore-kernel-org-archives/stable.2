Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A332D0E3;
	Sat, 19 Sep 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789847823; cv=none; b=Krq4ca5+cDk7hFzcxz8PDwbNrWpbFfROkAWqY3jKrEbgmceh3mnjKaWB9ikEmgrP5hSXlUzw2qpw3+XwqHQhoAK4TcfFxasojvq9di7OjFYtPL3EvHFSK5a9UBbgAmOV1b+FAh/0r5fwE72TuDwod6AdkmGrP4oAX3LODsn7mbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789847823; c=relaxed/simple;
	bh=bmSjrip0R4ION0z730h6r/gyHATsSsgEJh+I6M7HJa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St0EWfqfWWBU7oPUn4sd4XL7EWV68IDT01GsdBLt0zpkcAzJAF2jmzLhTH6RzMYwM3SkVV6wX8tp+Pv38pSi8uSnlcSSPXDbrIvsF7BNsAuPtInJ4sjux/j3fLgWzkfobPdWs7Nf4q6KU0wzeDEtvoBdEw2hgTUVzb+3wdmZ/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1sUDcyc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1sUDcyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCAB1F00899;
	Sat, 19 Sep 2026 19:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789847820;
	bh=SGQhVy/Ix1KWEg13IImx3L2eVLgqfe07umBSMIVihfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l1sUDcyc33VJ2pKfNFvoo1wQ2TeV2m2yTClWbda47f7Bl/iiXjQqageGbTu597AmW
	 HT0mEgWNbqRavJ0DP4gAuZDZx7SdKBRnCNp+0ABAMQCMG3k1mOQ3QfWjixVOU5KxH6
	 ZSgFJ8Lr3y9ElJAkEd4J7dFjB8VSoZor3xGIVvk/zafGy9ECOaRbhCi///WHe88pjd
	 7CcVtkoiGOyI+T20LVDW9mSWXwi2rHlPVdBrtWT/ET8ZbK/HP0Efpkn4tobrwPiKGZ
	 XLtAfejEVWCYYwfoZUecnOB4Y/8qjyyMMaIGjO5whTKJW9sUMDzzR7I4dYubL4zJTw
	 71asaMXWAZcSQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Xinyang Ge <xinyang@anthropic.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 4/5] mptcp: close race between scheduler and state change
Date: Sat, 19 Sep 2026 21:56:47 +0200
Message-ID: <20260919195642.1977885-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919195642.1977885-7-matttbe@kernel.org>
References: <20260919195642.1977885-7-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1636; i=matttbe@kernel.org; h=from:subject; bh=1Uq5TXp1CKF/jKqL7YfsUTcPXXbot2SxFy+EEa/xV7U=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWvfhfrPWxL2XL4Sdy3FNbnO7m+85U8K3xDZU8NYmpp nt9COexjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImYcjIyXFj66E47/8md2VGz FETs728qvDV7/Q5uG4YnXCtE9wTKJTAyPEhniw/RafyemX2jw2iOhMOy4PL/ckoZ618pNLK8uSL ICQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 42064de57fb83231fcc89663a94885f228a1ee53 upstream.

The mptcp scheduler may race with subflow sockets state change: data
transmission on the selected socket may fail and a later release could
try to use mss_now reset to 0 for a divide operation.

Address the issue by explicitly checking for the critical scenario.

Fixes: c886d70286bf ("mptcp: do not queue data on closed subflows")
Cc: stable@vger.kernel.org
Reported-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Reported-by: Xinyang Ge <xinyang@anthropic.com>
Closes: https://lore.kernel.org/20260525194828.1137119-1-shardul.b@mpiricsoftware.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260917-net-mptcp-misc-fixes-7-3-rc4-v2-2-0cf5c72667c8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ff63ba5ee464..1304f3cb6d14 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (info->mss_now)
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	release_sock(ssk);
 }
 
-- 
2.55.0

