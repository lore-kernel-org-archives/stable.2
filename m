Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719780;
	b=rPjGazMKUOVWooY3GTEcrrH1T2CsNFSnsQT+i7j7MNij3DJN/SFeWUmpo6CCVSOBDcIh
	 oUZaolgT+4a4zJJppmS6GIKOEoqvWTTk3fwjQnriWSIMdQyLfLY4LSGE7DTPmuLQz6xj9
	 6gCNYZyigQxrqxjmMJWU+QXVEgtoUOoLAxT9HrVzZZ0Rb2d/yT6QGD5rf4Af3pBnt4LnT
	 S2b7lI3aFq2D1hISeFoIPAPjAfSzgG+oDzCeOWqaTAJr6KJuzy4dYfsgwFeAsCLyVfdbj
	 j0GIuOm8q+6BClp+K3c2+1+HQjjavRK3mKgf1FosuqPa1+5VK0YabUWHqYw1XqjiVLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719780;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wK5Flck385QejTi6A69H+h+qqC7XJ5y9kr9PNPvjKVg=;
	b=kDEcEnx0URYxJiUtFKkhWjQGVLQEerIYLE/MGZrLeB9iYNngFNMLs9jVotBiXyUVLWpD
	 lbPz22aKb28xxC2s320S4tky9OMFCb+n8zQaUFlqTNiIaWHeI+BXbce3pKVrl+bEjEIyY
	 L8K0CA0lvrPJ5dyTJjWtZXpU9336aAMolQeTKs6RT3LJPeZWHpg3/tu0A+CdHyuBYK+Aw
	 Gzmgy7SOuykxtzlPElTr1HUe522n1xFCKEjCdJPJifmoKJW9CxS2ql61mGAzIwJx/Wo/L
	 MC/scblRECLGk2Ld6i1epCCcbqdgv7zmsav7lrcEaSwJjJyjHn/ie0/PCrTJ65AYk1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1U+aYFK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEA6606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q1U+aYFK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B4A1F00919;
	Tue,  3 Nov 2026 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719779;
	bh=wK5Flck385QejTi6A69H+h+qqC7XJ5y9kr9PNPvjKVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1U+aYFKvdGL/rpQJac5dO3OVJt3F2MYPPpC/IuNJZ+EzB7Qzq7kFPxI09VhqGPRL
	 5fdmQ0CcYwDO3eqOYg2t/VSwq2Vj334RCMNWqaQhPI0H4LKS95kBL0lC9PusHmNq3k
	 ONBEC8nY98day38Jx904qZznk9rZeG9Xygg/62Qw46b/Fn+dgmoH6+YqTDQXD3uU5H
	 IL3FZK8XAhXZmh8hnqxLo3AcHSSm9urG8+79GAFc+kzxaBKfq8kkFYc+XUq6k6cDfD
	 Yah911wk6chhJPUMsyjIXg8LC/9zI4SZEV4EEEIT76Tzzaam/0lb2U8bWKcwrqCbRi
	 dKOYnnRjpR+uQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: return end of file for reads past a named stream's data
Date: Tue,  3 Nov 2026 10:29:38 -0500
Message-ID: <20261103152925.390692-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110335-embattled-grievance-334f@gregkh>
References: <2026110335-embattled-grievance-334f@gregkh>
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

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit 626611dc22a3b63b3264a7a797d9dbc530234fcd ]

A READ on a non-empty named stream at or beyond its end fails with
STATUS_INVALID_PARAMETER. ksmbd_vfs_stream_read() returns -EINVAL when
the offset is not below the stream length, and smb2_read() maps -EINVAL
to that status.

smb2_read() already turns a zero-byte read into STATUS_END_OF_FILE, the
status a regular file returns at its end, and an empty stream already
takes that path. Return 0 instead of -EINVAL so that non-empty streams
do the same. Clients that read a stream until end of file otherwise get
an error once they have read all of its data.

The buffered copychunk path converts a zero-byte source read to -EIO,
as it does for a regular file that shrinks during copying.

Fixes: 2ae1a6cc4302 ("cifsd: fix potential read overflow in ksmbd_vfs_stream_read()")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index aff2d0f22c8fb..d27d64ef25528 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -299,7 +299,7 @@ static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		return (int)v_len;
 
 	if (v_len <= *pos) {
-		count = -EINVAL;
+		count = 0;
 		goto free_buf;
 	}
 
-- 
2.53.0

