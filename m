Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512481A6816
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789246745; cv=none; b=d3HyAHV3vw/wHueQUpeETJqQtT5GgJEdt+yem6dC2vZ7hX8nNWHmqqeubt1xUWWcnY8WjPsdMfsvBcXTsp3uNEixH+0sAY79E4HTqGfUBrvgg0u39WJ1zL+8Up5KE+fBocfeebgDQV/P9fTM0T0II4jjK00cy2bH/G9zk2aHLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789246745; c=relaxed/simple;
	bh=quKdbjy75CHlO0P0FICcEc+6HniJOdK5eZQ/fABNbFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhzHHbDt38ZK3pKwuVqjh5YC9bb7bgtCamvsJDWd3U04iNNC/V6xBSegjT2d/WUeLIY1SzpDyOzjN8cdxTkK1ADo6hMfE16MRMnb92cwQxe0Qk1UT6t2e2lRx5mHHvYAbDw97OvfcNv+EHEk9iyQ/YuJ1NSj8ZgugVnAxUBevjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTkCU7J3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTkCU7J3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F201F00899;
	Sat, 12 Sep 2026 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789246743;
	bh=uuy+g/O2CK33NDr0rvauivUw7WujgvobF138FWtOOYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LTkCU7J3W/x3RGZ9VNz1BO6OUM4cLWe2CqWmSkT7CcPkuNnEXhweYhfWavOqkylqW
	 gIGnSzTnGILUftpxLydFU90X22BYFAhcuz16DB6XfqBNLPgy7M04mMd0LZQLW7gTWO
	 /9jKfCw9yZS45kdcSHTY9JN+yp/qfrARManjjNgJhTQHbqfrwr1wITbbFRnhvycesI
	 L7RoPoML8GFXVPnHgRzs7pJ4PCPctW4LBvC/QrLfslsIZ05J2x5JgLPp0wV4jRnDgb
	 eVx02YbbH4tAJVpz2fOUuDLCoNTWb4BVx2JZArxEMsQvVwj2MFWmGzi6lElK1sFD81
	 a+Z0flzAhRubA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Cheryl Babcock <cheryl@renat.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ksmbd: zero pipe read compound padding
Date: Sat, 12 Sep 2026 16:59:00 -0400
Message-ID: <20260912205900.3933723-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912205900.3933723-1-sashal@kernel.org>
References: <2026091124-spout-outward-c397@gregkh>
 <20260912205900.3933723-1-sashal@kernel.org>
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
index 93185ea112014..e7659290c3200 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6717,13 +6717,18 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
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

