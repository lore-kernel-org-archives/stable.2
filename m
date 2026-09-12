Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51B0368D62
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246918; cv=none; b=do0Xv/HX7ad3ZumEIwLDYZY2EWxd01zh7Iaa0Dk1CB7Qg2iasZvx5wJosx4Ib7qLpS/GI1jiaxvrawibrQellVcpZvFK9DmTgEHO6/uHYehk0Vq/MOtLg4jLDRxA16Mohn6bohkO1uyeqxvf6oUCDa1V67PFKayUJXK3Mck/4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246918; c=relaxed/simple;
	bh=FCp9RDnTquy35QphyE5o6HKV7kHJqXwy8TzPwqOvCO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLkDKvSb0nlHnrLg3uI+xIKcdkQ1748fjjaeEL7XT41zx5RhQrfd8MF42O9R1ZBNxkuleb7PQCPCujLG5Ouo18kR5f1kLlE04/RkIiZX8BtL8w2T02NMbMsc7ez37TrRsHdeCcpVoQxc6l2VLEQbZnodsz3a8Bie5rmwV+oZOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJWDcVqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJWDcVqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5D31F00899;
	Sat, 12 Sep 2026 21:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789246917;
	bh=uYkV2LE9pdlRCtKE+X3NedOXxTK0fqIxWoIleB+qDWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iJWDcVqt4h4+pBOJQrluyuiTlNQWX+9mMUDB/Ob2bbFUeITH/VDsjxA0v0PJun+ZK
	 LaPo/nu0+i8meP6HD6YCG+fxmIV0HFZiIRv+LiYjO+lk4amS85/Dzfr6Md2QRqrxEL
	 k3rN6hFfryTwYLe3u+ypUKSzZm2x0AFUM6YTwb2cBrT1zQ69Rigd5VRUPXtD+4nBMB
	 XmVExZlbIqqTUhLqADTzB1lL50x+VRXKekfFJRLEqIfhhcbdle8rwamsnEoBUo2zMo
	 qgvY7jlKykldWQiBmVd75XUyYHPFRRUF+PyTYqfELDocb+Ioi34l5x/CeIneBRGDAa
	 XzPNZ0jfI5H4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Cheryl Babcock <cheryl@renat.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ksmbd: zero pipe read compound padding
Date: Sat, 12 Sep 2026 17:01:54 -0400
Message-ID: <20260912210154.3935717-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912210154.3935717-1-sashal@kernel.org>
References: <2026091124-undefined-monsieur-f0fc@gregkh>
 <20260912210154.3935717-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 73f860489e3be2245598d1819226304fc5b87291 ]

Compound response handling extends the last response iov to an eight-byte
boundary.

smb2_read_pipe() allocates only the payload size, so the alignment padding
can expose up to seven bytes of uninitialized kernel heap memory.

Allocate the aligned size and clear the unused tail before pinning the
response buffer.

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Reported-by: Cheryl Babcock <cheryl@renat.io>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 1d073acc9c027..d586633fd168c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6271,13 +6271,18 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		}
 
 		aux_payload_buf =
-			kvmalloc(rpc_resp->payload_sz, KSMBD_DEFAULT_GFP);
+			kvmalloc(ALIGN(rpc_resp->payload_sz, 8),
+				 KSMBD_DEFAULT_GFP);
 		if (!aux_payload_buf) {
 			err = -ENOMEM;
 			goto out;
 		}
 
 		memcpy(aux_payload_buf, rpc_resp->payload, rpc_resp->payload_sz);
+		if (rpc_resp->payload_sz & 7)
+			memset(aux_payload_buf + rpc_resp->payload_sz, 0,
+			       ALIGN(rpc_resp->payload_sz, 8) -
+			       rpc_resp->payload_sz);
 
 		nbytes = rpc_resp->payload_sz;
 		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
-- 
2.53.0

