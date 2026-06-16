Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FBB46AF11
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626742; cv=none; b=kXBvRO5vNlVlVoRqkw9sgl5J4D0HOH30YXv1N7rw4jJkbdoWRbdVTY3XFAP/n8iuhhm9HpvWALzDwDcHZydhnqynsv0p5OvC+xyZlHTfzdYt3pY1K4TB1lzseh/3cKPOnvOHmv90L14AwkmcJgJp3ZK52eAstxNqKzaV1lQbO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626742; c=relaxed/simple;
	bh=ris77oPsGbaorWuP4W4LqnMqm5sOkWuBvKfybJA1jGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNn1tTUn5O90Q+lNqxdCwnNASJq06QokuekzD9pubUZ0UlEgLFSmgKNxhAuJGY+HNhHV28CmoLc+zaMJQY1nw3cvy66vJTflQLYyBfRR6rD3NUVVJSkL/OYCWosgI7gYuH0fkhhCntOOw8bWuUflKVjUTaHh3smMBjUqgkKKvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyQ2dOk2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyQ2dOk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE8A1F000E9;
	Tue, 16 Jun 2026 16:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781626741;
	bh=HNotEzno6DlUHfSSkJqgB6WovQsh3ASWIxV5iwJr/Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jyQ2dOk2/ZbUS6ptF+r9g3ao4TqSTF4zaCP6viar5TLPvYaAiU8evECkyiJs3LV+t
	 YnKHGNZ/2mGEcDUc26JWJ9pmHEf2d2NGLkLY++RbB3VMhMsjmY9TyzT6hJT61Ld/wV
	 rKD0VelRc0VTV9WQ/Qa1X7kTcAsVVyDL0A1sJiG4KQDsUnVk3AdzIZxw4cZFzihiFO
	 ZOfBKf3nzpsoS/C0zTADzaMmOqmU0+mkus5Onyms+yWEVxbi0LDAI0eiEGk41ntQ9r
	 djagVUBmRmirPqOGWwp9owXlQIpd47/A1Kxk65DUeNJvGKumQ2r73yydNMvwcwBDF1
	 76nmKe+lwJFIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: fix missing wakeups in edge scenarios
Date: Tue, 16 Jun 2026 12:18:58 -0400
Message-ID: <20260616161858.3332254-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061542-certify-unmixable-abde@gregkh>
References: <2026061542-certify-unmixable-abde@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9d8d28738f24b75616d6ca7a27cb4aed88520343 ]

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-1-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 965819ddc04c95..3abd6ee4a2970c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2182,8 +2182,10 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 		__mptcp_splice_receive_queue(sk);
 		mptcp_data_unlock(sk);
 	}
-	if (ret)
+	if (ret) {
 		mptcp_check_data_fin((struct sock *)msk);
+		sk->sk_data_ready(sk);
+	}
 	return !skb_queue_empty(&msk->receive_queue);
 }
 
-- 
2.53.0

