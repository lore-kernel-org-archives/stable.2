Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225A4E06C6
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546626; cv=none; b=FOZtdGHAV9W4m6jrshb/whY45AXrfdUUaQkIcj675FDbef+eJIJqa/bU+c/09zrxQqNV5d6V1WhOrCpbnrTxahZ8jAKg0QsrddWj10CUKSCPk07Q4K2Cqz8K1+BwCAqnouH89Xx6fs/iIocDvHQzkYl+jWU00O/M6nMZVyRNj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546626; c=relaxed/simple;
	bh=eEYk/WUBoJNEYfRAjecrPDziLiZTHm5p6P1tZdTsKko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRJafIKgBJd1HIVFKraxBdadOXC478+fixXAiZ+S7ZNS+tjUZiAHiKwsI9/s7VCLzy4UQQCN33NL36iPXPaPXwOKsayyccj/OtKRri4wH+PN7L6wTcLZvdoQYnbI1NoRzAGHAOMJ7cuDan3i2HS6hJqzmRVIId+mWHAId8qrpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XodLqo6w; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XodLqo6w"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-826f42e479dso3067989a34.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 04:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791546614; x=1792151414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QrkQmyqxC53pOYj/1KIRQgog5GJjTm+HpEKGS8SAvH0=;
        b=XodLqo6wd3q5Ar50Plp/kt8C2fEEeLppk5MpuSIrqgodD4Ie5wvUe/cqrxh0CKuNh+
         1GMIQyfTuFsRZSj1ESj+Gq+Va51C7YO1Qk8b7Ln0onNMVzGHpR2pP6x9z9sNX8ha1uQu
         DYZJo8bfKP/EpN8eU+BcLzBx7Aw4yroets7tUMCRdyBwFtqRAPH+zCzgtitnKQh5uIT5
         pQPO1gwAecV0nyy0BCcogD3XtKMR4tFy7fzlGhll6vGBsIW/LW/CebWh6yYGR3NiWPJJ
         U1twE3KqZfBql2Cb3eWxnDrk7Cq5Fnwv0TxMXN9JDkRnbnNESGvAE/czwTcUlp21QTPw
         3pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791546614; x=1792151414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QrkQmyqxC53pOYj/1KIRQgog5GJjTm+HpEKGS8SAvH0=;
        b=Yvt51NXlD9CotTUYikkeCxZNaeNtV2FdxaSB+al0kZ4n5YNazcNriQqJVu9MFCPqJ2
         DVN2TCAawYc9pTtaVBS9oajZPto/X6/gA5UY6lGP9qQatUU8WB3uJnnocH9aToJittmh
         oBqUHUWCWeo2kcdFIfPzpd91edC2fR73gK8RAE9cgO7t8yJO03UR4P4MG4I0hUNPtPHx
         XbMXbfk3juYRJIrH8ljR6ul+wT5RD6L/jLzN0t7tWkMyjo7EZWb3TIEDyO1ygPwMizt/
         fYYvtIyrqHIa2wDrkUhiLZwX8bJ5386SN2kEE/Sfxg4ccZanIDR78PwWA4lD0CyOkzOU
         iWRw==
X-Forwarded-Encrypted: i=1; AKwUvBzOXViwzMZoV2dPrLfUVOxzVHbSog6xPKOW6d/JJVy4Jl+JyAMAGp3Y2USZHyctcghjSBX+qZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++nAL2dQATl9NGOSNprMaeF6g8MunS1BfAF5ofMXDyd+3aq2IRom
	FOcIP4v4ocF5+Q0RNXpdNMT7Db1Pl6yHbpN0VvLLqGDxQU9pSOxyUdKu
X-Gm-Gg: AYBFou2U6Avl9HQn5jAnPijRoYo6/2CyV+4OMtE6NDJVkz7J0w5aC5vGzyqkQHZjhe7
	/3z4JXAmFurVKPHrbbarz/oxkYtVYgYLehoIK0yR7TWiC55FRMVu9u+5k6ebcBGUzIu+ULTwwJK
	5F0MLNR02dq85M9/v3ycm5mRpSlp4lWzQJJMBTcVfYH4ob4xwKEndKdRbofqkIxuDovqDC4yU+J
	3b5RaTzCeK4eZHR6ylsZm8QKrHBnfJEuK49ybs65ik2PVeZuqAmLghkMvpMdepBj9oxQ0/N7/KL
	Sgzr+eMEmxwMHX4eWZEVfjJgSMqSvyezkkKteF07jXNrg+MeZJuprAyI+mV0MLZySFLoFhIreZ5
	0izqG3xAIjvuMLduLF+GAIBaM2qXutTcKyFUxbwQRZzslMUZV6YjVqX/tOS2wB8Ax3ct8KtwBf8
	CRJ8+aqtlRZ5luA4d+E14YNn48xR0zi2QvTXS+dzF9fL34QRHNEXeNNY3L4M8uFs/4bCLutzIbu
	2mJnQ7aQc/JgdzGEGbKKBBdzBiBTndqj05h
X-Received: by 2002:a05:6830:2b23:b0:81c:a945:60b7 with SMTP id 46e09a7af769-83090c286e2mr1321835a34.2.1791546614333;
        Fri, 09 Oct 2026 04:50:14 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385b9c4asm1480984a34.9.2026.10.09.04.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:50:12 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rxrpc: fix connection reference leak on aborted CHALLENGE
Date: Fri,  9 Oct 2026 19:50:03 +0800
Message-ID: <20261009115003.3696517-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_process_event() returns -ECONNABORTED before reaching the
CHALLENGE case, skipping the rxrpc_put_connection() that pairs with
the reference rxrpc_post_challenge() stored in sp->chall.conn.  The
skb is then freed by the caller while the connection reference stays
held, pinning the connection forever; a malicious server repeating
CHALLENGE-then-ABORT leaks one connection per packet.

Clear sp->chall.conn and put the reference on the aborted path.

Commit 092275882aec4 ("rxrpc: Fix oob challenge leak in cleanup after
notification failure") handled the sibling leak stored by
rxrpc_post_challenge() when its socket notification fails; the
early-return on RXRPC_CONN_ABORTED is the remaining, still-open one.

This vulnerability was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 5800b1cf3fd8c ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/rxrpc/conn_event.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0..56503a05d5d7 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -272,8 +272,20 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 	bool secured = false;
 	int ret;

-	if (conn->state == RXRPC_CONN_ABORTED)
+	if (conn->state == RXRPC_CONN_ABORTED) {
+		/*
+		 * Drop the ref taken by rxrpc_post_challenge() on this
+		 * CHALLENGE before bailing out: otherwise the skb is
+		 * released by the caller with the connection reference
+		 * still held, pinning the connection forever (leak).
+		 */
+		if (sp->chall.conn) {
+			sp->chall.conn = NULL;
+			rxrpc_put_connection(conn,
+					rxrpc_conn_put_challenge_input);
+		}
 		return -ECONNABORTED;
+	}

 	_enter("{%d},{%u,%%%u},", conn->debug_id, sp->hdr.type, sp->hdr.serial);

--
2.43.7

