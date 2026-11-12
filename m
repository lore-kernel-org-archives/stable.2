Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521615;
	b=kiQFcW0QmQDDY5I/T2EFzmi2MWX+7Lvv8B38MPFfn2twAtmDDahIS/HALuOGNFSwizob
	 Dw/kXdT5euOzoDHP/sh0mSr9MiqqIzt6DWCNR2RbKZxpJy+681YJQQyX7I4mu5FDmDIKe
	 LNZ2zwDIFspPS1D6tlsJHtMZ5H1LNjnUsVtn/xi0hd84sqIYe8Xppd+vDyvupwMWiH9Je
	 nQbkWKxmvm0CqkF52tN7ueyEEbRRghiR0gM5ojtAfsD01cxD3bVN9b+YUSBedTf06C7vl
	 Dz443UtQvkifir+6Cd1K9CAg1Gx9pHktZWWuaYthThdQST7ukfrN5Z1egndCYf0qEnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521615;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RInPL6EFrXJuf2yH7R0NFlj/fMVwcAayM2FD7gWkifQ=;
	b=RBlpTyCKm9QJp2rPISgxeocxxNya7zmBFG8or3jaVsOatvcYPjgKPismMWUlXkiRX5xN
	 /nfZvzSilpmohZGzJIuN7w4+CmHui9VAbypL1VkXS9XCzXt8ONcEjQVRER0ERhbUJHLjB
	 kW+Jlr4Cpf/fB2RvGIeBDQiTbvkb+2lpFk29RqrosZ8q/oh6cxb+1UodV1EJrgZ6dhRf7
	 LOwuWMGdyn9E/cBVGdEfcYtpjqFeEPwgbWSFES7EkxmtvcPfUX2PLIrT/v1dEjT4t2rCP
	 4VKpOWVko9Fy+z73K9cI6DunieJenTQdB7H8Q9//bWWD7OkwBp55niLAoIvOJibmyCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lChPB/sl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6646606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lChPB/sl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC731F000C4;
	Thu, 12 Nov 2026 22:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521614;
	bh=RInPL6EFrXJuf2yH7R0NFlj/fMVwcAayM2FD7gWkifQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lChPB/slsM3AhqklvmyK/LktmZl2tuo1Nzt+xz1GBk9k134UWlej1fA2JvGiCrsDh
	 OBCVqbA0UkUmVTuNyF2TAkMLozpCsQU9Sz/TgFh3jW+vZ0DxErev8XW+yFOwxN49xP
	 71kZTAo1te1R+2IF0BmQVsd+uAubuytflyRiyHXxGv4hZ2yh6WT5R93ctAx0p0zb+b
	 WMfFwV09/UkFUH0fsuq6t+FCzAZ2okcYGtvH9vd3hJZbdgffZc6e9O2pTlbmynyHlA
	 lQBEEzuTKIjzQRDiW/QzcxupqRLrgrjhK3FkGxpA4RpO3Qc8/Qqf8s12LyiUvc7jOL
	 FNR5PoI+O92ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Gao <gyf161023@gmail.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] 9p/xen: fix refcount leak in p9_xen_response() on wrong tag
Date: Thu, 12 Nov 2026 17:13:32 -0500
Message-ID: <20261112221243.3984840-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202508-failed-5.10-4d183e6f1532@kernel.org>
References: <20261109202508-failed-5.10-4d183e6f1532@kernel.org>
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

From: Yifei Gao <gyf161023@gmail.com>

[ Upstream commit 4d183e6f153245aca2534e372152583b868dd925 ]

p9_xen_response() looks up the request for an incoming reply with
p9_tag_lookup(), which takes a reference on the returned p9_req_t. When
the tag does not resolve to a request in REQ_STATUS_SENT, the function
warns and continues the loop without dropping that reference, permanently
leaking the p9_req_t and its msize buffers. The reply header, including
the tag, is supplied by the backend, so a malicious or buggy 9P backend
can leak kernel memory on every crafted response.

Drop the reference before continuing.

Fixes: 728356dedeff ("9p: Add refcount to p9_req_t")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <20260806144255.4167019-1-gyf161023@gmail.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
[ sashal: changed p9_req_put(priv->client, req) to p9_req_put(req) to match the one-argument API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_xen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index ff81b323ea7b5..d76da50c664c0 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -233,6 +233,8 @@ static void p9_xen_response(struct work_struct *work)
 		req = p9_tag_lookup(priv->client, h.tag);
 		if (!req || req->status != REQ_STATUS_SENT) {
 			dev_warn(&priv->dev->dev, "Wrong req tag=%x\n", h.tag);
+			if (req)
+				p9_req_put(req);
 			cons += h.size;
 			virt_mb();
 			ring->intf->in_cons = cons;
-- 
2.53.0

