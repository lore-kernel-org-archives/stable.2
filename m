Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74EF40DB34
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274131; cv=none; b=N1y5GT5g0hm3gF7/S5JvQGZ5owtWKnw3poatXpjFlnCdJHLFzrVwYVKjX3x0b2VMERzk5/+Jgmf9aFJjp5jce2htEi2aQCBdAEGMnnHsqA2UDc7Ur5Gs2pmypBlWrkEpXaq3O4eo62uplf76Q7iyypnXJvXDwTBa3PmRbjNr1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274131; c=relaxed/simple;
	bh=BAvlKpRqo3PYnxK2uuliOTaHZ18+H1NmGfLq5T0NtWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKFAwJPkwY7Hg0LtZC+Qqc1KKjPuKWp7/t/bm8TfHIvNzGJvfbodmdNcuY12tvppn+eqc+tgolZsMu/UVS6qgFJr3RW+3hxhzAJipcSK082W2iX1tMHVbHVc/AQg2Dymaq8ub+IjI83kj+s8G6X5n0YmURJLn/oWvU1TJbKWDF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTCR7aQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTCR7aQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC791F000E9;
	Tue,  1 Sep 2026 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274130;
	bh=8fdyK6fJ5J/fHromb48W6dCpR0CrTkLTnhqEEV6kzb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DTCR7aQ9Y4KSBNHpT0yvw1wEIkB5PKD1wV1H/gcPAXzdf+MPoGK9YpvrJJDG/Lm8l
	 UgJeE3qG3i8Qwr5/PfpcF2ONuLwZlms+h5TRN+6+7Qrb5GUQaRlb1wM8l3SRN9XZ0m
	 G6Qx6qg2hqu8++mADXvnyY1l4C8FF45Y+JsbpC4wlBvWLGCsEFwzh2avh+Wt7nen++
	 HENGEwp+NdsX5ZLqS9B97MiU1SVUM9TGKjRplWUvpD/Eu8iZo3edGaEBSgS1KN68S+
	 YaFCknO2RMpQs1yZd7V4l53WRWV83mtObrRAk2SiN0S7pw+p7TVdJzkEU6AVdCI9GL
	 56hKkjWor/rww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] crypto: virtio - bound the akcipher result length
Date: Tue,  1 Sep 2026 10:48:45 -0400
Message-ID: <20260901144845.1102445-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901144845.1102445-1-sashal@kernel.org>
References: <2026083111-ahoy-glove-a297@gregkh>
 <20260901144845.1102445-1-sashal@kernel.org>
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
index db3817f5ab46e..c19920d3397ba 100644
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

