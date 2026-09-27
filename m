Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CE3CB907
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502329; cv=none; b=sjp1vA8NYv/c+HIy4FguvpGZIvL34y1p9if3yVkbQ/9S6vuUDITnNJ0Sn5sEqS5OJ0XkxS8kADQAHy5tevX1l92aAi3IeZyBJzmWP/mZfo0pBGnWkad2sJSIj/0nLSfVO/Gaa1jMTM+eH00zVvGcMb9OXM2iIRg9JXTsR9J5My4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502329; c=relaxed/simple;
	bh=tax8JMiviEXQQXZx8r3+hVtfjUs+GKtkWSm4PU5xCJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fg1H7wl8pQ1ZBs5bB8C122PciAN9T+Jg/YAoUb2cy2LMTp9hLtrCVKCd2aHWXJJjW3UugZZPW8iam0yAcdMneNvhDoZai8y88k/TcNvVgj+mkF8OiigLnI7agoS6Rz5fIvckGjnBvfbMIzUG7qne8cIzE7KxzlgnSQvdH7SQ8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Izwagjky; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izwagjky"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2d747ec6185so8302905ad.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790502328; x=1791107128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WW03v5grmvf8mOWn+UC1EtDiLQQpdA7r8LHu21l4O94=;
        b=Izwagjkyn0n5D52tEVvLkltNBuce8XeUH2Wr+miu9fid183camoilkMwVUMVj71UjW
         rQwNE5JA9qJ3J90eM6SGC7RWVbgWeUjSn2PknOmVEOIaHuTsX9fvUB/T+mq/AGe4+K1V
         ueMTQYY+GY8GxYKqEgQOQIytwpdHe783sKxEESWihDD+enrA8etadSfJNabskfjUhQob
         XcZ0LQlX/PL1KVO3j63xN2p3l2EwEDeKzPNPwt3aUBvixDeAhQ5A7d9cOIijFv2yUGEo
         qBcOZt8KLgcAtSbo+2TgExnkQ9tS7gnSLaqCe4pennyN9DjcV2PYNwhXpQSNxTrTx2KL
         XItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790502328; x=1791107128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WW03v5grmvf8mOWn+UC1EtDiLQQpdA7r8LHu21l4O94=;
        b=pceeY2MdpNQ1y2mycVyM2u7N/bGBB2nwkR0MN81sooxCz79KrHY/dkEBKNbSc7h7aV
         OtQn90WwOl30ShNCOBaDr/6JguL7xzLv6Py38zoQRfvhCFXeumfb7Q9+THYkvK+kh+3I
         V2Ii9x/reXVJSBY35QIvsqYqN7oRtPyQCXyiwOFq4o/FW1D/SsYKkWaNXvPC2IaeDW01
         oh3LEvAo/TTHmGV27Vc47qU0VYRV+dqN9AJa/f4SoDHMrXGIWQw2Zxvj/Eiy7jklbnC/
         mBUCpeGbJAHB9RzZ1NK3slS5ERpSHx7I9uI+puEYnE+IOr5zaCKZou4mGdjJplfLwejU
         W4Gw==
X-Gm-Message-State: AFq9FYLcCaeDFS3k6TIGg0+8jfto7MiIJJd6n0glDZDNUNu3sQUwceBk
	+SG6dwltaqPiE/Xs/2C6ka7C1LIf43I3YOk+GUD1x6m/y6OjLhQnmTRHss6WD+xrsV0dKkXv
X-Gm-Gg: AYBFou2h+h+hrMo4cbt2DViSnIf3MaQqvklp7m7iMN3VsZpK80VMO/2gtY21Y2qb1N0
	oHD68lQqur+X0VEQ9vIv/rnJxaZtovJDM1gM8gUQUlpxd66K/DW++kwFQsitP+s93Qpm0ENS3uP
	TOgHbNezdwNft3jv88DsCIQJ764JSVO2/uWK3RUk4nXu8WUwJ8WRO8F/KZElRZdQre+Rmxn9Sq3
	QjJkTAS0nusk4kkVRMeivkIR58W9epr0oPy3taCBxWlmejyptjkYE8+vXBWoW8WqePXm45UyaVL
	dA54SOK5OgJbVcToIhn/7PLatNaG/e2aaxhC+rbdxRSxXmVPenbqpKanotgvPMYMyilrZjMdkG9
	1YCyApi92HabGoGZiOVHPWVJb+f4KuCo8K4+F8+edBT6TRjw/kXBLk0nVQ4tWcDZcpOL31c2xlw
	zfmuzqKTwo6P6fMVmzLDObgAnwzR8nK9fEhUtba5WMt4Ahm+usql2TGGlQlHdHX897yPkrmIxIU
	IY=
X-Received: by 2002:a17:902:f689:b0:2df:95b5:ee7 with SMTP id d9443c01a7336-2df95b51595mr53557255ad.28.1790502327685;
        Sun, 27 Sep 2026 02:45:27 -0700 (PDT)
Received: from localhost ([8.222.151.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9525cd53sm26576315ad.38.2026.09.27.02.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 02:45:27 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: zhangdairui@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] nfsd: fix READ payload landing one page ahead of the XDR accounting
Date: Sun, 27 Sep 2026 17:45:24 +0800
Message-ID: <20260927094524.1745207-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd4_encode_readv() passes the in-page offset
base = page_len & ~PAGE_MASK to nfsd_iter_read(), which writes the
file data at that offset into *rq_next_page. After each operation
rq_next_page is set to page_ptr + 1, so when the reply stream is
mid-page the data lands one page ahead of where the payload
accounting continues (which stays in the current page at base).
The wire then carries the stale tail of the current page (previous
RPC payloads, since reply pages are reallocated nonzeroed) instead
of the file data: a remote kernel info leak to an authenticated
client, plus silently corrupted READ results.

Trigger: any compound where a READ follows an op that left the
stream mid-page, e.g. [PUTFH, READ(100), READ(N)] or READDIR+READ.

When base is nonzero, place the data in the page the accounting is
filling (page_ptr) instead of one page ahead.

Fixes: ed4a567a179e ("NFSD: Update rq_next_page between COMPOUND operations")
Reported-by: Dairui Zhang <zhangdairui@gmail.com>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---

From code reading only - no runtime test yet; the trigger compound
is in the commit message. First patch to this list, so if I've
misread the flow somewhere, please tell me.

 fs/nfsd/nfs4xdr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6a0a97d..17aff48 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4933,6 +4933,15 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	__be32 zero = xdr_zero;
 	__be32 nfserr;
 
+	/*
+	 * rq_next_page only tracks full pages. When the reply stream is
+	 * mid-page, the payload accounting continues in the current page
+	 * at base, so the data must be placed there instead of one page
+	 * ahead.
+	 */
+	if (base)
+		resp->rqstp->rq_next_page = xdr->page_ptr;
+
 	nfserr = nfsd_iter_read(resp->rqstp, read->rd_fhp, read->rd_nf,
 				read->rd_offset, &maxcount, base,
 				&read->rd_eof);
-- 
2.53.0

