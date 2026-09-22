Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080014A4F1F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105633; cv=none; b=WoPZlW4epMMWHm+T8x+X6jr5CNA1ueMQgnEAsPdCXpkiLwaq80D3LwlJF9SBVwmiwAzMVfr4+w/d3vDNkXRr3UVRKwog/QuL5QCGU49KDh4uL3eht9ZlYpGRwBUU+scVYKz3moxR0zlDE0xEbm9z4RYrunxGD36qoEHzKVrHAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105633; c=relaxed/simple;
	bh=9Fe7IeNRyBhBNKzOuYAjydyV/zm9cyjffLTK8uGq7xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjzPtee5+lmWfcNfb6rpaElctBBFbJqGWQe1JYLncFLvPDXqwXUvZ7OOa4Jf3M/R2RsXdalNZkmLX2rjxQlznXnVX4VSRbf80PQldyChC9awFqEN/3+Tk8AQgjmzjpaMnfthmiPqlbdIDS3x69W4u4bg8ZfV5HYENLRBTf+23Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8ir3MJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8ir3MJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67FA1F00893;
	Tue, 22 Sep 2026 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105631;
	bh=054IRsch3YkogJmDcwn5bxJXuTD3XDemuXzlsi5l6aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D8ir3MJWpWsssorR2JyzWeWm6rVpESJAB7TrKEAY/XW9yn0MSl9cD6c2uzBwMAgdB
	 ekzrws2hO1Ir1wS/6BoSLyqXTQaZWIqRVrlxipwbdYeG+786QR7yf+zEyxFrnE8cWu
	 THz2bjhLjhfTb98ftinAIqn1TCerfaXeCQYjRM3MXhZSFw3C8/twrdtdiUJlE5Sn4/
	 T7nxvY818JRHp7PlDmvx9F/lRihvcu1OoPHUoLAmRbcJvfWBbMGyPFmSDubzer1YY7
	 9QlyeF44Q2aaOG9/VfMinP24LmCEnoHQhfPZh5rYVrQrENE3qUyQ6iVNxNpi671uoM
	 KRZfl6SxCK5ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Stefan Metzmacher <metze@samba.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix smbd_connection leak on cifs_get_tcp_session() error
Date: Tue, 22 Sep 2026 15:33:49 -0400
Message-ID: <20260922193349.4154041-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092221-chive-engaged-cc27@gregkh>
References: <2026092221-chive-engaged-cc27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit e75c96157d45e498970158c8f7373d90102e33b9 ]

When an RDMA connection is successfully established via
smbd_get_connection() but cifs_get_tcp_session() later fails (e.g.
kthread_create() returns an error), the error path frees tcp_ses
without first destroying the smbd_connection.

Fix this by calling smbd_destroy() in the out_err cleanup path before
kfree(tcp_ses).  smbd_destroy() safely handles the case where
smbd_conn is NULL, so it can be called unconditionally.

Closes: https://sashiko.dev/#/patchset/20260912165503.521597-1-pc%40manguebit.org
Fixes: 2f8946464b11 ("CIFS: SMBD: Upper layer connects to SMBDirect session")
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Tom Talpey <tom@talpey.com>
Cc: Stefan Metzmacher <metze@samba.org>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index d35474b836007..a91d3f6ae5be6 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1574,6 +1574,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx)
 		kfree(tcp_ses->hostname);
 		if (tcp_ses->ssocket)
 			sock_release(tcp_ses->ssocket);
+		smbd_destroy(tcp_ses);
 		kfree(tcp_ses);
 	}
 	return ERR_PTR(rc);
-- 
2.53.0

