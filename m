Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A1412C12
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181225; cv=none; b=n3KlmLxQnT54HPRAHMh+u5cW4cLBdXyF8l5CHdcqOAtW5WnsCski7hoszj/TdxLwYSkuKRGORes55565gptAI+rih632qbNHTOj5FhAj2+i50rbsjrN6RiQEo8eMmAipc4mBXNqETTYZsmtPo3Niyur0KZ9KkN5ONgNYHngRuEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181225; c=relaxed/simple;
	bh=6OrJMq/Q5FfuPXSeepYan6w2OwJU3cNg7cLnI5zVeSw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jFG06IL5o516UZnxH2Z2aaS0BQVF4Mgy1POphx5r2CwRL7IMrQTqHvSxdjP32VXQipivAxC9znvyQK8u+GSsk1JoxSFA0+rvOepMA8FAef823nOsr8SZOPI8vEElAN2sWv6ip0dK4YNf1dBrd4y7BJpOUbSJagkbCcwr+BFebo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KQL+Guwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KQL+Guwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B27D1F000E9;
	Mon, 31 Aug 2026 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181222;
	bh=9AdqQqw99u8laNLKg2+m/U6BEaPruRXIOHskhEmsygc=;
	h=Subject:To:Cc:From:Date;
	b=KQL+GuwzpEftGa9NbNDtrmLNsazLhdAy5T7oONFQIjmc9grfpjPNPJ5j1CGCMY0V1
	 wVJOSTVsOCBdQs8gFqIsjeQ4x4jHf5HWtRNVovAyJraOZJxjteWwEqjudyJ/y8aP/f
	 ZQ7IReUg0E3uXOFqc5bKvS70n3HtRH2h6KBl8rHQ=
Subject: FAILED: patch "[PATCH] crypto: virtio - bound the akcipher result length" failed to apply to 6.6-stable tree
To: hexlabsecurity@proton.me,mst@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 15:00:10 +0200
Message-ID: <2026083110-repugnant-jingle-50dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f77a956f6a19f9463ef1527c9d0cda50dded6b92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083110-repugnant-jingle-50dd@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f77a956f6a19f9463ef1527c9d0cda50dded6b92 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Mon, 22 Jun 2026 01:52:15 -0500
Subject: [PATCH] crypto: virtio - bound the akcipher result length

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

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index d8d452cac391..64ea141f018c 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -88,7 +88,8 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 	}
 
 	/* actual length may be less than dst buffer */
-	akcipher_req->dst_len = len - sizeof(vc_req->status);
+	akcipher_req->dst_len = min_t(unsigned int, len - sizeof(vc_req->status),
+				      akcipher_req->dst_len);
 	sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
 			    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
 	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);

