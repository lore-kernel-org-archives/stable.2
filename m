Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668426;
	b=sEMVBsmdca4VAoXAYSiEWs5Xik5cTRsG56B/VckeIJXR6XEnJUQdd7a/c5VKvLG6tYuE
	 ek6s9RXfuRy41eWaYuKzUn4qEnFkWw9Z2//Jnw4ZBRbr+hYn+xkKlJWucwKpfawehZ1dl
	 Ye0kg674IKaMYacXRTVlzVCB6kZsPkCi9gS2MI4YAWs+6YnrYguoSOgFwfqGgoatdDH9K
	 NEO/OCz7w6dWdbC7SjFyM/3wXlywSEbsqDb3H+Z6ofmNxWnPZQEV46hKAuJlAOQZ+mv8d
	 Vtx02h1dgJuVhatHikPuqnrwfdgAZO1G2CYVCJ5TZNq9+pb30sfkVAuo/sod18DCB0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668426;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VncEk7iXvL16OSBXj7CtxGn6VV76Behg05reAt47BJw=;
	b=fB6fTZ8TQL+PKI7mPLVPBjJMOywXbp3zBDC5zOKSHAQ1Zea26MleMP3mFFA29yZ9wzuS
	 +8qP3Ae3b/FJwXYHN1uW9uZI3dulOKbMA+LhuXI9eE+bF3wwGmDepkEytmSPosJIU1mty
	 qrTNupEwR1pq4ZzsYxxmKWyrFYiTWIeOpY5ZzqnvJmipgDaScSaq+L56H4a1N3wc3h6Qg
	 BMJP0ynecpDNO9B9abqvCynl0y9I8bVKniezJ8Hj1yl9tsfcBSeWZ7WB9f3iQ1vzm1XuS
	 1WiTQx/4tbjh0fQJ1o/qgSKXzfDXFMtfuU+V/hBr5aYXrDUkFEd0WuLEBPrWuvaRDPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d2Kq1HE/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EA606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d2Kq1HE/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4635E1F000C0;
	Thu, 26 Nov 2026 04:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795668426;
	bh=VncEk7iXvL16OSBXj7CtxGn6VV76Behg05reAt47BJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d2Kq1HE/pfL3iiP/iK5o3nJ9ftgTiEPI8A7aWe0gz3jsNIZ0xs8nFHCMKpGOF05yg
	 4QCTN8oR7u5Hz1N2IWFZXQLnqh388IdlE5YWLbFn9fQnxg3cETjXB8zb7knLSTE92F
	 Ef1M6ZODvs7wt+QI2cy9tAj8Kk5GI2Uun97m58xSc1dbxaTEjJytaU36JFLHe4CbHh
	 Szm3u4nVMhNVJ5/1Wo6Ohn6IOG7tCulsZWAjDTqTM01SJkw6Ogh2wrRVSmK6gsojiQ
	 hDBObimCFTOrj8zVcMTv7ocNFRcFVngqn+UMbJJ2aQ5d0cpgc2pURQ/Ywj3wRb3n4Y
	 niM5OpE+YUuSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/5] smb: client: remove commented-out cancel_*_requests() calls
Date: Wed, 25 Nov 2026 23:46:58 -0500
Message-ID: <20261126044608.1960941-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112529-flatly-mammal-3d12@gregkh>
References: <2026112529-flatly-mammal-3d12@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit a40b17cc9ecaaa85c3615963ec21cfed1c734340 ]

Drop these leftover commented-out calls.

Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Stable-dep-of: 9bd8ee0c1614 ("smb: client: don't replay handle reopens inside SMB2_open()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 5a22796f2e957..5518a62549806 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -869,8 +869,6 @@ static void cifs_umount_begin(struct super_block *sb)
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
-	/* cancel_notify_requests(tcon); */
 	if (tcon->ses && tcon->ses->server) {
 		cifs_dbg(FYI, "wake up tasks now - umount begin not complete\n");
 		wake_up_all(&tcon->ses->server->request_q);
-- 
2.53.0

