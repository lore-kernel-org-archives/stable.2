Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373086;
	b=IYvYzRUL6z42a41LOWjRxTmtSf34S1mcmGeFYOSvG44f9l0UVbPdb07+2V564JQTXBw5
	 ygaGystRrR8OnJ66YGrwEmRB9V9FcMrq9Z7SC4TRBr6DdyoaajyJmGZaY5E6hEvuyBA/i
	 93t+1gyijx3mV+zX9+wQcGa6XBRcFFQ0nvWd31EphCNJZbRunJ9byH+p4JkscAfwiSHwb
	 Pa+CiECxpbbFH86NjKb3Fs/1o1hqtetqfiobCPpMSgjSILxA9/a0Mla53TILoDwVfrUhp
	 cBn8wwPykJ9LvZYT3mtQy3RzKOpBpzt8je9gWz9poQEBU8ABEsaeoP87oAtCO/pcZ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5/XC8+2fi5RCSmU72pHzjpFYy1hhXKPvPazBPvPXdTQ=;
	b=LfCwW2NcEfOZ6KqsHf4q4NyQVBUn6OUW2Dkkm/qxLDL95Gg5TbdUYG+V73EcJdlS6oEs
	 oJomZfj8IljjmqPx3wVz0nfSIeSP1a20BtKwK/1V6J379vJJJPRKglSobnX8pC0lG7oE5
	 RVh2HhRReRtBujyt3XwpG56O+zMG5TpcL4jQTy8EgDtxgYIa5vvIabhEYqZ0HiWrCdlVI
	 sb4ekyJMKCrSZHuNJoUGyuDZgRNUq/7zikG1wTij9Sb7vk+bvGNrsAcMizjuJV9eT4J54
	 3Y77BrRZ+3GC1gTtCWD0D5/DAwlWUP2v0Q4gmGpe57ZjiDNigjgfEPKyK8yCOsas2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0jpukwL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99846606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0jpukwL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7A61F0089F;
	Wed, 11 Nov 2026 04:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373086;
	bh=5/XC8+2fi5RCSmU72pHzjpFYy1hhXKPvPazBPvPXdTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c0jpukwLfoabcl/aoqFF2dLd9s6/WaoaN537SGbPr3HTIPcsb8O4B1g3bMiEEuamw
	 0aixtTsE3zedrUF5wKu137keQAuLmfG+UDQFtJKF89WsSFQKsWnmVEjqLmiMMta1eX
	 ANAl6TVX076HnTiE76syX6rl4eQ2T9H79cP/KPJUyAgtyZQZHIaH5/hCc0mHklDbqG
	 4+X8RxgEKmF7Z8CCvpiXfBg7TN5nfhCQSl1bxttYl92TsqchtyFpvrErhTDgdVGe5z
	 hMpCKI7NuSS0NxzpB0ylQHXXLA7X/D1MCx8eP53FU1yCX0V0H3YXFa2gP692QcTs2t
	 oupG7VtckgHJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ceph: fix 32-bit overflow in readdir reply count check
Date: Tue, 10 Nov 2026 23:58:04 -0500
Message-ID: <20261111045704.1185619-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055513-failed-6.1-52913831ba56@kernel.org>
References: <20261107055513-failed-6.1-52913831ba56@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>

[ Upstream commit 52913831ba56efceaafd80b501d68fa00f79bde6 ]

parse_reply_info_readdir() checks how many entries are in a readdir
reply by computing the end pointer of the decoded array. That pointer
addition can wrap on 32-bit kernels and let an oversized count pass the
check. For example, a count of 0x40000000 with 156-byte entries wraps
to a zero offset, so the decoder can write past the preallocated buffer.

Check the count against the number of entries that fit in the allocation
before publishing dir_nr. Reject oversized replies through the existing
error path.

Cc: stable@vger.kernel.org
Fixes: 54008399dc0c ("ceph: preallocate buffer for readdir reply")
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ sashal: adjusted context to retain pr_err(...) instead of pr_err_client(cl, ...) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f8b469c900dee..099b68d6d66d4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -363,10 +363,8 @@ static int parse_reply_info_readdir(void **p, void *end,
 		goto done;
 
 	BUG_ON(!info->dir_entries);
-	if ((unsigned long)(info->dir_entries + num) >
-	    (unsigned long)info->dir_entries + info->dir_buf_size) {
+	if (num > info->dir_buf_size / sizeof(*info->dir_entries)) {
 		pr_err("dir contents are larger than expected\n");
-		WARN_ON(1);
 		goto bad;
 	}
 
-- 
2.53.0

