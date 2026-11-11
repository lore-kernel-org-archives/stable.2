Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413998;
	b=ERLjd+/4wlagjeyvbkZnDfvqA2KJb1NabXmFQsKz5V/qxkwX+oA0XkIcVegAo/j/w31G
	 4ahr0h/bZ2VthH91WD3jsg3F/MhwYB3aiZq1w3spTKPi4JZaWWNBdO020FuDQx7iRpzVQ
	 M5eX/HwHarhxYmwDa581IvjD86qAPFId4wFxUD7g7I89rg9Vj4FKOml3ynbIJ0sNXlmeO
	 VEHswJtA9AYXPPrdox0zl8mW7c7nKM12xm235+eKcSpBRdZOOWEwzqFekp246XZXClTMn
	 rcnmITvM8ICjT/NaUiapPFueZVrNN0WuhEYJBH9+BHPhanZGk+J/7w18G05nbevzNUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413998;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=z0/1FyElIkwXEaesamY+aEhrCW7xXmcnkgiEqANaKWI=;
	b=xBtXQIatqlwWxhNyh4YHXf/3kDSZAmOk0JtEQrtG68K4I4ei+Y2gpCLNStpnJcOtdIQa
	 FKMeaNGbHMeuqNw8CA+kRn4GgCBND2HMZWDpcWIQ3spZ7U2I8ohWiiKzslQsLv5C3qCu7
	 FtMRRgR6oyXB9BZck8nlQfICN4Esh9COU5MzH0OjJ7OOU8fUkqP6l8OGZzR7KetfHLn4v
	 mL0BbK+M/yPOa+qv73UYzC0WxVaSrLJyxDrWX1zFp5mWEiXnU+hjSpVYs+Q87M94Fondy
	 LzaRwQoQXIpRsCzDVKCvSf2fsxxeDCpBd8GSpblpsoUKg0qq/lu3HTRx3PUFOru3KMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfTpX9FY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A6560A263C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfTpX9FY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044FD1F00A0B;
	Wed, 11 Nov 2026 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413998;
	bh=z0/1FyElIkwXEaesamY+aEhrCW7xXmcnkgiEqANaKWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BfTpX9FYg2Tv59Ucox97jsK0DV41Yql3ayBKL51UziPr91Sf6ygVINFdMUVE4Mj5z
	 TbZxI9Tp04P8KmAcoQ/zWfYBFxeEGgxjuVZb75aOu169ENYgDigDKe8C7qHBl2nozo
	 0hBEXVyR0BaSHqit+xysuMbbAoOztqTjHE15DIMJ9QE+dN/Nm8pq7xqarvDSyL310G
	 o4DB+xez7EDtqDfQGmzx63bUQYPHqnS8BQ8iiiJSp8jK7nTnDoIMEYwYrOm/AVbzfo
	 hdZ9Lb5rAsKL5qQiEa8HBeV0qRGZc8lI8izN2EVJFA1qeN64HD2VjiFR1F/Z9MckiM
	 lCXimaCvh+1iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/5] take the guts of file-to-pipe splice into a helper function
Date: Wed, 11 Nov 2026 11:19:53 -0500
Message-ID: <20261111161949.3187571-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161949.3187571-1-sashal@kernel.org>
References: <20261107063106-failed-5.10-79b496ebe382@kernel.org>
 <20261111161949.3187571-1-sashal@kernel.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit faa97c48c33454ac0107db930a491b692dd1dff1 ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Stable-dep-of: 79b496ebe382 ("splice: avoid stale f_pos writeback on error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 070b192b56386..8237ed720a35f 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1005,6 +1005,23 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       struct pipe_inode_info *opipe,
 			       size_t len, unsigned int flags);
 
+static long splice_file_to_pipe(struct file *in,
+			 struct pipe_inode_info *opipe,
+			 loff_t *offset,
+			 size_t len, unsigned int flags)
+{
+	long ret;
+
+	pipe_lock(opipe);
+	ret = wait_for_space(opipe, flags);
+	if (!ret)
+		ret = do_splice_to(in, offset, opipe, len, flags);
+	pipe_unlock(opipe);
+	if (ret > 0)
+		wakeup_pipe_readers(opipe);
+	return ret;
+}
+
 /*
  * Determine where to splice to/from.
  */
@@ -1084,13 +1101,7 @@ long do_splice(struct file *in, loff_t *off_in, struct file *out,
 		if (out->f_flags & O_NONBLOCK)
 			flags |= SPLICE_F_NONBLOCK;
 
-		pipe_lock(opipe);
-		ret = wait_for_space(opipe, flags);
-		if (!ret)
-			ret = do_splice_to(in, &offset, opipe, len, flags);
-		pipe_unlock(opipe);
-		if (ret > 0)
-			wakeup_pipe_readers(opipe);
+		ret = splice_file_to_pipe(in, opipe, &offset, len, flags);
 		if (!off_in)
 			in->f_pos = offset;
 		else
-- 
2.53.0

