Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907614;
	b=XCoBjw1sF1ADVxAaMKBy6W3md8+8C6GmFmH3d/3dSIbmY+bANY4cs+7naVTohuAp7Beo
	 THNvFyFaNf+5oMbgHWgV1lRGMtaJMU1aUXWAtIIa5RzyiORvA2ZYfxZBq+FDbWpMF08b+
	 K8B5fdQmqQN+eIrvo4CRCSEsiOwGULlKGgpKnFQ1wGdeicIug+8P1HOsN2jqeaqH6v3+L
	 dNASmnQ0bK6RcYZI4H462Z69lL/sv6BLOfTOFhOGefqfO2SXks0ZRszKltP8if1QpUy3O
	 fTWrbkgn5920/n3bjU7T4VX4DA51LkbdOerVnDBxOeHxq/vgzDR2UAlds5ecVnquWlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907614;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dg8NW2YgRQdOFa9iGi7LT9+G+a4v5aicjXSJUUExz6E=;
	b=aMXaRQdbjhhswB0iCVlmhgVKXxYf5IAiPsEA58kwBWAP/YDzyFnvNwChEOz7M+DXMj/l
	 nVsBfyUMe85Z5vgP1rcJGPPvRapoenKeVoN/Rm/+A5P2j1GJ3ytW6ur2jYlgnxjha3KmS
	 9GvcWN8nP65DmOoXnIoCGY0GM+7ca1rlvI9FXzSqu+d71cpW+hGNeEEBUeDPwRsF+SfmA
	 0DbZn3BJHeyBkAmHZwEYXs5M5nROlwWvi62azuA/ieYkl8XbR5Tbvaah5A3bhsF12NBGZ
	 +IOsd6nLZscgMeJFdR3E0deUmJH96XYd0rZZCOzO35PAEF/5aC6k8t3lGeSREAMhxNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+AvKbiY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306B606A32E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+AvKbiY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D40B1F0089F;
	Thu,  5 Nov 2026 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907613;
	bh=Dg8NW2YgRQdOFa9iGi7LT9+G+a4v5aicjXSJUUExz6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J+AvKbiYLQO9kRaeYqlilTeeOMW2NsCc9TfcZi4QFRIMKZ0zTU99fHbjqoISMa70x
	 shXKxT1+FKBinOO7rhZvhKobJES+vKDiHxbpfeDWzi/L86mOtjkEmlPPmakOAVXEUN
	 j5WVDXH8+UQuh6+86EL5+5CJA8MGU0NVE7Y9NpWqDWrv8lPh0Bs9hpN4UyVwcBFSw6
	 O42QSPqmuzVNeEau8yEQXmgl/K9PDJdSDqwbahUM3dXPIE/yrRXmv5iM3LR49Jcr60
	 /QwCobQDCNGZGKnP++A3CAkFYFVJlJZ8gWp8/trNh1ebjRkj5WFqPLYa1YioxTcu7j
	 b32wCC1++5ftg==
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
Subject: [PATCH 6.18.y] smb: client: require stable pages for SMB compression
Date: Thu,  5 Nov 2026 14:40:11 -0500
Message-ID: <20261105193919.2635668-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110441-ethically-speech-8e44@gregkh>
References: <2026110441-ethically-speech-8e44@gregkh>
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

[ Upstream commit 8667061cf99394526dd9c0ea2662e6bbc7ae7848 ]

Like signing, SMB compression builds the write payload from the pagecache
folios: should_compress() lets a write request through and smb_compress()
compresses those folios on the way to the socket.  If a buffered write
mutates a folio while a write subrequest is still in flight, the compressed
bytes no longer correspond to a consistent view of the data, and the server
silently stores corrupted contents - worse than the signed case, which at
least fails loudly with STATUS_ACCESS_DENIED.

Mark the mapping for stable writes when a write may be compressed, i.e. the
same condition should_compress() tests (compression negotiated and the share
allows compressed data), so netfs_perform_write() waits for writeback to
complete before modifying an in-flight folio.

Fixes: f046d71e84e1 ("smb: client: insert compression check/call on write requests")
Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
[ sashal: Replaced tcon references with direct cifs_sb_master_tcon(cifs_sb) lookups because the local variable is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 7c638b8d5490f..c63c74dd9d434 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -87,7 +87,9 @@ static void cifs_set_ops(struct inode *inode)
 		else
 			inode->i_data.a_ops = &cifs_addr_ops;
 		mapping_set_large_folios(inode->i_mapping);
-		if (cifs_sb_master_tcon(cifs_sb)->ses->server->sign)
+		if (cifs_sb_master_tcon(cifs_sb)->ses->server->sign ||
+		    (cifs_sb_master_tcon(cifs_sb)->ses->server->compression.enabled &&
+		     (cifs_sb_master_tcon(cifs_sb)->share_flags & SMB2_SHAREFLAG_COMPRESS_DATA)))
 			mapping_set_stable_writes(inode->i_mapping);
 		break;
 	case S_IFDIR:
-- 
2.53.0

