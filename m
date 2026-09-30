Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161F7370AC8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784195; cv=none; b=aVvmQcpvEXL8vxtqABeuQ0SjhamO3/461ci1yvRAM88Ek0X7/MDieiOu7ibkU1VolHp3UiYtV2v0jNryS+bo66ekHLOq9lKojN5rMyPLU03f3XRPMoKcpG4wX8q5bWsK0iUfjCV3S6ceWLek3FZMlyQpOgEDB7uE0qGAPDoHyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784195; c=relaxed/simple;
	bh=6rCEMBW5JSJOe6/5Vqk2+Yxfj8FkUdJO8XscWJflg6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKw/ZSS4MYnkUuyX5u2rPfWNG1sWT71mLzt+B5w3rWpEL8vTNrgQku3lCcxmMl2Wf4/vDyYH6lIvwJ5m7qnjvnOm8IFY5Kt4hUhrufbGKt7kwgOZda4dvgP174HRn/8NwbH9gvTLgqwDwA6mkdYeFKxAPLLM9YGXKAkyzBjYhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZALYp458; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZALYp458"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCFC1F00898;
	Wed, 30 Sep 2026 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790784191;
	bh=XgWvAIQ6r0qXuT2t9s3+DVWyl9YaWoFUoTX352x3Gn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZALYp458HkUC2fEVrE0B4oGsl7K0pJnP85wBQR1J+p5Z7BtEaowcME/ZSk2Vy5ux0
	 h6XUA4ziOuuzDc9GVOEERKYZ333Q88ybyYV2E5JU7b2DlI8/ttip/7lcjkonBpPyOi
	 JWSWT2ldqoRtP2RlK+iB+iJpu8DfOgOnDo21PSSFE6BZux4dREdNSGL9U5b/AX++qW
	 PFouFUWGzyxowAVGLkPQxJfQiKSm+1EzwqLQ2i5A+p6v2XTPBcmv3L5QlrtRpgjW4H
	 4h3JFqg6rQs6G2gONOGuZKnUZoerLMgGWFWtaBroNPTlAuKo47FExP5KP4li/VKfAt
	 oQ4BVV+Fe+mcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Frank Sorenson <sorenson@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: validate POSIX create context length
Date: Wed, 30 Sep 2026 12:03:09 -0400
Message-ID: <20260930160309.2981856-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092934-enclosure-bronchial-deea@gregkh>
References: <2026092934-enclosure-bronchial-deea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit fa2e9900dd2a3f5a1e7ef5a8c5e8d435feedbfcc ]

parse_posix_ctxt() reads the fixed nlink, reparse_tag, and mode fields
before checking that the POSIX create context contains them.  A short
context can pass the generic checks and still make these fixed-width
reads run past its declared data.

The current in-tree smb2_open_file() path passes a NULL posix pointer,
so this handler is not reached on the ordinary open path.  Still require
the POSIX data to cover all three fields before reading them because the
helper performs those unguarded reads.  Keep the existing soft-failure
behavior so malformed optional metadata does not fail the open.

Fixes: 69dda3059e7a ("cifs: add SMB2_open() arg to return POSIX data")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Tested-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index e93dd51a88557..17a35be351139 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2030,12 +2030,15 @@ static void
 parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 		 struct create_posix_rsp *posix)
 {
-	int sid_len;
 	u8 *beg = (u8 *)cc + le16_to_cpu(cc->DataOffset);
-	u8 *end = beg + le32_to_cpu(cc->DataLength);
+	u32 dlen = le32_to_cpu(cc->DataLength);
+	u8 *end = beg + dlen;
+	int sid_len;
 	u8 *sid;
 
 	memset(posix, 0, sizeof(*posix));
+	if (dlen < 3 * sizeof(__le32))
+		return;
 
 	posix->nlink = get_unaligned_le32(beg);
 	posix->reparse_tag = get_unaligned_le32(beg + 4);
-- 
2.53.0

