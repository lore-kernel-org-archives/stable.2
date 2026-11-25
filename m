Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634204;
	b=JgEB5qdZ4IS93WV1mdGP2ZrGmYNiZFCiOEvadHrzoyA/3Ub4UaZf4uX5imrndoH7/ker
	 +6WT4z/OiUkj67vHTtF9Hpf/diXu7qle9CP0FNkg4V2e5tQaPKHKutKakgnNugYAZx4kJ
	 gagc66+cayg3KfwDz074LEOn6Adz4uz6D1wAlpKi6EjudIOAJMqj/9nqHbnCLYxsjtMgv
	 OzgocuVjvXgM4LaqbkBGvIMQZbKM+D6sDJHeqHYqRlzHxDuY71FXIsx5NnbgficDqvri2
	 l7pXf3fhDUBD4nUC04Rm2jfhWCsiDN76Zz2ZQbRGZnwTUu940ttg+TIt/TvzGkg2AzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634204;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XRFFpJBX8ueqKGaAkuwemjgnJa55TI3k/DM+XH7bIk8=;
	b=CyQ77XKfu1MEw1kHaQ7QhZwzMIneL7RO/bdQWnrGI4MINl4V/q/ziA1zKucFaCQ0dP+D
	 nrwwW/1OrgTHvtmIsfD4FDiyOwoLrW5oyLN5DvvHmeBStPjlzZhgYgPE9NsVIhvw/KX3C
	 cSLVgt/D45q5vXowJjkVi8a+ZRc+sDQUmUnTZT4hbzCKLIOKpTgqNePHnRExj7eM6tz4u
	 0SG14/iODeCLvK3qg5VucvNNd+Y9W5anys55tZRdx8DOXYJj8dEpgDmJBJpivBCqIfvkF
	 Dl7wt+DmNUvdWt/MhmPj5deCw3cNlGQZm6PeHdlOXG93NNbfONEcN3pacmuOyZbXduA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UksX7n/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D7606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UksX7n/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB1B1F000C4;
	Wed, 25 Nov 2026 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634203;
	bh=XRFFpJBX8ueqKGaAkuwemjgnJa55TI3k/DM+XH7bIk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UksX7n/ZTHcCshEMvsfeRXn7q/fjVI+7VSgjeZLPAQesCaaCbb2CufAEK/kVMXrzD
	 QgXdxRrrLcE9W6tVk+FKmBDXlqGAWaJCEo4FEqyHk8mrdJgSOIrbZyCv0fFigTyszI
	 sLocYkQ6SiFqEENeFmtn+wfn4MfoP83cR3/t7arkdYwSUwuVEjZekh5YJ1vvf83xFj
	 VLVAVRxpeOq6dUIt4HWKxd24bKygmzPMet9LUagPtvmrAZTk23vuK1kqBj7TTRcjpk
	 +ak8nLzuSaAifT4Cb+6A6wtPB1dvkhXY/pUisuF/lSs54QKzsuSFpjsPjE4+45DnU5
	 9TtCmnLjWkgkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] ksmbd: apply byte-range lock checks per open
Date: Wed, 25 Nov 2026 14:16:40 -0500
Message-ID: <20261125191635.1197631-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112524-enamel-landslide-2197@gregkh>
References: <2026112524-enamel-landslide-2197@gregkh>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit bfefe73543197d06e43c5669148b5bcc44f2dcff ]

Using the tree's POSIX extension flag to skip byte-range lock checks
also skips them for ordinary opens on a POSIX-enabled tree.

Base the read and write lock checks on each file's POSIX create context
instead.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Stable-dep-of: 2fd145f8865b ("ksmbd: refuse to read a handle that is not open for reading")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index f88daeb5ef873..f9e4752b5bf2d 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -366,7 +366,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 	if (ksmbd_stream_fd(fp))
 		return ksmbd_vfs_stream_read(fp, rbuf, pos, count);
 
-	if (!work->tcon->posix_extensions) {
+	if (!fp->is_posix_ctxt) {
 		int ret;
 
 		ret = check_lock_range(filp, *pos, *pos + count - 1, READ);
@@ -552,7 +552,7 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		goto out;
 	}
 
-	if (!work->tcon->posix_extensions) {
+	if (!fp->is_posix_ctxt) {
 		err = check_lock_range(filp, *pos, *pos + count - 1, WRITE);
 		if (err) {
 			pr_err("unable to write due to lock\n");
-- 
2.53.0

