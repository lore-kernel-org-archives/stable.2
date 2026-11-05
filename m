Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909754;
	b=cGX96d/0hJZsxrjaHjrJxpbqKPfTOupryNX+GxW4/HKUMlXrpS07b4cN+jFrMDWa0tc8
	 +w2m7VzDO5yEhh9ir6VDTy3SSxmxM5UpJ0N45CRyajmyoFcFLS/7k8IGTC2gZCM+IjR6C
	 PotpG2wgulMxSsYyCPBjfFpCjrmar3Zy1rIRvqpgYOC/ruOOeviNQzRNxH8ntEjtBGs0w
	 Wrl6VSt2b/I1XgL8XPwudukYfnyF8v6k6ktQbOi4qAZ+REp1CoaGDf2mnd3Q6Zo3bB4xe
	 x+62WltQRPHYPEGIoxqjLswrvZmdlEP65iW+2f1oah8Qoll91E+Kpub9E9EmSIhY8QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909754;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F9vPT3LbOJAel6j4s1h2gdtASFdRBTWv4wy+NoCBICM=;
	b=rhDcCWtKlglCvhUsXd8EgEehy2PASj8y9UguclYjKQuBpC78EEJ0b6tevXuvZ+z5jGfS
	 QmtLahdz+LKhv4fG2WtfjsNI1UcPbJ6MoY8lb3Wo5kNp0+qvyGOZAlxjdKYvlLox0NXWw
	 KQXpTBF0ezMQBamAMg0inht157E5/3hbiJrnATwWc2N797p+fYxVOPW6bGvF31kNJKbxk
	 r9lW/lPamX+pjCGiA4Mx2WRnJRODGkEMVmK2KpT2yU7F5l8tGJR/0MAR+R9FWcRgryiMp
	 5ckgWqZM9Q74ATHExE0uz+azArohwOOYVEL4byzRCWD+TVEFINo6hLEHhieNYko4PNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHlGJRj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846E606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHlGJRj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DA01F0089F;
	Thu,  5 Nov 2026 20:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793909753;
	bh=F9vPT3LbOJAel6j4s1h2gdtASFdRBTWv4wy+NoCBICM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cHlGJRj9sSX7ICLKDHjv/opj+sZjyr0SxoiOZUhhYs3lSkCsjXJD0zykHL55cf8UG
	 Q4jrTqIGLWB5+emnK1i6iH5w6VX9OR0Mez/bZhpTBXaQAeoRIybomz4vbXaEvIToT5
	 x9NK18WGTNA5Fqbc68aPEWBNjI+afI3V+eA4HyxUvL/XOdNA3obVmkz+SWg317HdaI
	 CkrzSJ5/j8fRjr/ZdpMfiSsZAUUPUWWQNfitJzB/v1r8XfYJrSYI7mIZN7ImmV6ksf
	 Hpza4fQhOK4+YGytrl4/V5zYsWH/DVmdmHqey5GRfpv5/+jzNqPN0ZWW82/HA06lnN
	 ynNUhFLthZDPw==
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
Subject: [PATCH 6.12.y] smb: client: require stable pages for SMB compression
Date: Thu,  5 Nov 2026 15:15:50 -0500
Message-ID: <20261105201447.2683057-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110441-macaw-surround-30fa@gregkh>
References: <2026110441-macaw-surround-30fa@gregkh>
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
[ sashal: replaced tcon references with cifs_sb_master_tcon(cifs_sb) calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 9307a2ad9e444..5db59b429fc3b 100644
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

