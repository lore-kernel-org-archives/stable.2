Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101953AC0FD
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264619; cv=none; b=po42hq/5zKsmKSkwbcx4LLjSV8nWqgrvXWHVbTaiLzalwoHwGYzocU8O0GtdFyfO7hVIChYWnEKFtQHWZebGfw0L/SJX9L+xWACHVXoafn/fwLjg8W/xVKkU6IBFUY2d/fKuqGYE6bgWrnqqFaTRluns59cFVRfBNhsjTDQ6G7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264619; c=relaxed/simple;
	bh=AywJJ0kjoxGw/jof2lC63dYgl/2uhICluMVsPAGVk1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj8p64esK1GSD6hWz2RWhMxwZPyildK5r9MohqMa0NfMthGUmIoMHiOGlzvvpu0xbaQUcvCr8lrJklo7FkoOa7rQP7oQ8iQtwPpMpXiFc5Kfnn1O3jdwi3MNH54ggOY7sAW0gmEhNErZzR3M+SP7Nt9tnkBUyn2h2h2mHyGodtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgbLs953; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgbLs953"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC8E1F00ACA;
	Tue,  1 Sep 2026 12:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788264617;
	bh=uNgPJq18+3l6lfhggUGDmY5H7CbVEs8nRbbndcijxPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NgbLs953Xb+Ym1GpvfgtScfpqBD/01K1vQ4oRCQ4e+PMgjWfi0GhL8JYdyOt4O1cy
	 RFWoPt2alNmtEtsCoILrVhBDNxZoO5GZxyVvkkwyDsM89CzqJwTuki55fTGp8YGhvJ
	 qu+OkO9P7ZL6u3wBaAOqCkDSu+JziBNOZOWHY5PA+Wb+ERkDCxEw6jUCGJZgxdLJs3
	 rkSZfy1tL567hI7A4h9QqEZ9WXwxPT9B4rVoahqIUeQ3HY+NQle/Nqu/7dmsnfnHQ6
	 uIlDzTJOcWH6aBNriCVcnkvp33VezYIFKjotIz1kO5yf0aLEkuapL1upcCjiTxY0Jt
	 bqQrjri+gIB3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] crypto: virtio - bound the akcipher result length
Date: Tue,  1 Sep 2026 08:10:13 -0400
Message-ID: <20260901121013.579838-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901121013.579838-1-sashal@kernel.org>
References: <2026083110-catcall-outtakes-9ceb@gregkh>
 <20260901121013.579838-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit f77a956f6a19f9463ef1527c9d0cda50dded6b92 ]

virtio_crypto_dataq_akcipher_callback() sets the result length from the
device-reported response length without bounding it to the destination
buffer, which was allocated for the original request length.
sg_copy_from_buffer() then reads that many bytes from the destination
buffer; a backend reporting a larger length over-reads adjacent kernel
heap into the caller's scatterlist (an out-of-bounds read).

Clamp the reported length to the originally requested destination length.
A conforming device reports no more than that, so valid results are
unaffected.

Fixes: a36bd0ad9fbf ("virtio-crypto: adjust dst_len at ops callback")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Message-ID: <20260622-b4-disp-3a2c09a8-v2-1-d1a809281db4@proton.me>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index e44ae99384573..7b1a561ffbe83 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -89,7 +89,8 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 	}
 
 	/* actual length may be less than dst buffer */
-	akcipher_req->dst_len = len - sizeof(vc_req->status);
+	akcipher_req->dst_len = min_t(unsigned int, len - sizeof(vc_req->status),
+				      akcipher_req->dst_len);
 	sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
 			    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
 	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);
-- 
2.53.0

