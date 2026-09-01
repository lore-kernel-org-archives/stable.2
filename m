Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91633390C95
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272305; cv=none; b=UqdczCQ1fsX6CG6h8xctS2buxKl3RAFDKQtA/YwyhaYfooNsgtxit/wzkIH+yYE097lyIcTEu5AV7e5yAeq0mfErU+G0D1n5bJjVDh9H0g3rJiEDOWfWmpfUBhH8q3TdeZi3GhzwjvBqpKsIGUJtyUNf188EWzDCK+brOGCUUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272305; c=relaxed/simple;
	bh=AywJJ0kjoxGw/jof2lC63dYgl/2uhICluMVsPAGVk1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTX0uLdmDMVyHPJOuBlo4HUcRsrgdd85ThNhcek37eMHC5g7IhmyqczRfPY4jK9I4cBir9wghl/AMaNItQBWAK7g0J1wXFcsXdJtlBL4J7cT+lqjz/yz6YliREBP4/ZcXbdmE6QGSbKIHEvpMmYZsEdBYnnioj3Eg86hENNXO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajJTzPNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajJTzPNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FE61F00ACA;
	Tue,  1 Sep 2026 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272304;
	bh=uNgPJq18+3l6lfhggUGDmY5H7CbVEs8nRbbndcijxPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ajJTzPNvMRGNiwYBd9XRl3jKmFQ2AI49i/tWvcBwb+As1roLkB/AztSeZVE/e8o96
	 Xa1AbUVpffVxFxeuxEr9ArB6mYZTVCkJswYBUqEntfWwXY8/YLUllJ4ymkYHmJfmeT
	 ht6mBqNcY706CdsGdBQPbTPrxZHnOk2l1mXYUV1MSSq+D7KUYTceJsBkUdZD/l/Cgq
	 MEy7TfvCxUxi/gANsog04kq3P3dDrh6HwDEuljgMVpBTR9BD6jr5K/s/c01a1dcMw2
	 lsHoIhDxZ9VHCbAQB56wWYsIxDbUHpfmiIVO5BqkUccHuTDCV6p6BMta/KGRoe/tAQ
	 irqnI0JBWQL2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] crypto: virtio - bound the akcipher result length
Date: Tue,  1 Sep 2026 10:18:18 -0400
Message-ID: <20260901141818.1033381-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901141818.1033381-1-sashal@kernel.org>
References: <2026083110-repugnant-jingle-50dd@gregkh>
 <20260901141818.1033381-1-sashal@kernel.org>
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

