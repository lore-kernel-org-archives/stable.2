Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ABF41378D
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181229; cv=none; b=EQVFiHZcz75ehSVq2PdNtRXrowCOLKP00LcuIzhKLQUhZUuCF8lHoPd+JjigiVqrbeUiYQzbWOtPKfE8hThvQZaMluilGeZFoPty9ubCmW0ggbNt8BWine2LlbtuDw8OpLdriPYPvV8lJQdeZXku7+eXpBJlpxpzo7ohndJ3riI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181229; c=relaxed/simple;
	bh=w2O/femVqqf0w1uPyGkifd/SmiuBfVkBmKk5EtouKB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZKNhxShBvE0h9VqW+iJXe26ydpi3K8ID02qguy6hOUEfsL7h3jd1GM6lu7TmPxV4/Pwmh/Fl6x28xvlftCp8sWo8WW33XISgmmYXPRyQvehXgnwkzvLhWWyEQl7yoRRghFoB6l2xO5azFXjLwhKqes6qOCLl5VnXVmqUWrWvTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kj56xm1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kj56xm1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69071F00A3D;
	Mon, 31 Aug 2026 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788181225;
	bh=mPhkzPmcZHIqPA3J3LUaq23uWX+5h6RaMW8y90FhgR0=;
	h=Subject:To:Cc:From:Date;
	b=kj56xm1xDbfbrQ0GWu7guoHbL523n7yzaYmODoYeaOGM2QFS/v2fWN/fs5neTspab
	 Z84FzJ6L6hCI0gvktaM3X+Z9toPSuAB49z8mDnqI0DfOgWsHu9n+WoU1NHU2dvKwjs
	 zORmglZ7CHdwM45qJpge0Rou7z4OTMcDNSct+4+U=
Subject: FAILED: patch "[PATCH] crypto: virtio - bound the akcipher result length" failed to apply to 6.1-stable tree
To: hexlabsecurity@proton.me,mst@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 15:00:11 +0200
Message-ID: <2026083111-ahoy-glove-a297@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f77a956f6a19f9463ef1527c9d0cda50dded6b92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083111-ahoy-glove-a297@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

