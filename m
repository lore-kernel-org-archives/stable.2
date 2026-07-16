Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0B30D3F6
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217867; cv=none; b=n5DXfm3Esmrv9xHTB9LGkKhTML6cXovNJqfSpgeR6yDJRuZtbxOyBSbZFxRWvyECCzEnFykW8h9l/596e7ke1X7bquLhN4geu0ChpFydBo1PjequnBt5PesTFtXURCx0AxIZDN5uCRwSrg82jCFPSB6QfU6WAJEQOT6CeveD19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217867; c=relaxed/simple;
	bh=CdF62TKB2sQLZl0/JZGZZOCwxzxKc329OtxuHNhDjgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzDHY5dxYAg+tMN8+FKFv/f8mTdVQb3F7N/FGmS3bNtcm4GalvWsm2t8HKHFc2w12fkiIsfMkhs2NVH2fH6rvaYuC3bAeolNeXikayeiMzNniFkXu6O6fMw+1KlalA/6TAsNHufvgzfYF2rR4eZPJpaDGSonX0z4UF145lNZ9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbCYMrHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbCYMrHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B721F000E9;
	Thu, 16 Jul 2026 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784217866;
	bh=9RUSwf7EAs1Wp1sn3EpfmRTiI9ePxRcOrVFxVWA1n4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LbCYMrHW3xhue8F/+Uy3glhtLcCwHReYTiad2cVgpwjty23WA7apaM7Irwbe1RYPu
	 iHoB3Nv1IUHHo2ut0tqEBJPV1VvcPwi/S+7mfSfAY8h67lVopSZfYUD4y7iaFQRZqK
	 cvqnB/AtrauOwbOrEi6wHXSQ3qR/+gPuiVAH+bf06WS0lNzf7Oe8RhXHzJsbuee9DY
	 6R2wwqA05WAxbCNidTDSwAXjHY7SKk973KeWfFwAcepNCF47FkhrIt5kUQnV3URTHX
	 49iu/pymZT2uSmUfQuR4yvn3t8k49xQ+O8jxNXH1RrViBPj0J3m9JHxKfPyxtpthx6
	 sH6DQEqMzVPrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <xizh2024@lzu.edu.cn>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: harden POSIX SID length parsing
Date: Thu, 16 Jul 2026 12:04:23 -0400
Message-ID: <20260716160423.620093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071425-retiree-hydrant-f109@gregkh>
References: <2026071425-retiree-hydrant-f109@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

[ Upstream commit 7ad2bcf2441430bb2e918fb3ef9a90d775a6e422 ]

posix_info_sid_size() reads sid[1] to obtain the subauthority count,
but its existing boundary check still accepts buffers with only one
remaining byte. Require two bytes before reading sid[1] so all client
paths that reuse the helper reject truncated POSIX SIDs safely.

Fixes: 349e13ad30b4 ("cifs: add smb2 POSIX info level")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 302c08dfb686dc..afa7197413db9a 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4592,7 +4592,7 @@ int posix_info_sid_size(const void *beg, const void *end)
 	size_t subauth;
 	int total;
 
-	if (beg + 1 > end)
+	if (beg + 2 > end)
 		return -1;
 
 	subauth = *(u8 *)(beg+1);
-- 
2.53.0

