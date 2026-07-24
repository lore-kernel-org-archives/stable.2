Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784963F482D;
	Fri, 24 Jul 2026 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932437; cv=none; b=r0YCuj31DIMcWpylwql9FFPaCtj94HaH3xaKzybZw1G9wbUjRkxDlUxIw1rayIDcU8KtjMs4cCKQpXu1n7xqPst37nO8NDoxbkUy3KjTCobWgZtR2qmTZkgMdee70BD8AL+R9qKh5CpypU5r0zJh3h1z4hNEkBE0nkcTMbqwcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932437; c=relaxed/simple;
	bh=+hm62uNx5Nt9QktjrLRNaBxvbigeLcRFHFoxY37oqw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ueu3xFVt/G9HmGzjHfZaOn+659u/fREAtT5A5UejKjo2GF0VzkcnChj4BDTCLIIeWn+cAEwvAQxL6CvkaCEhvblBm59k0CE/Ql1TGrnTGoi3wPLzsK5IiRJwHXId+Mu0tZZXuS4hsBHjm7+l/Nboyrdcljgrl6w5RVxYpe3Va9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owZGQHVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owZGQHVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CF61F00A3D;
	Fri, 24 Jul 2026 22:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932435;
	bh=ljnoWx5eorV9w+2zpeNyCq0Qijcg2gSirzinnZYNAhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=owZGQHVkZZYVh5EbhUqe1ldV4sHe/YclbdzrJuW0XDQu5OLXowZqY/vw3JDYd9yEg
	 eWFPxCQhzqIR62kRk1ZeTEVf3GncpKn2AivvG8W+4hIVxGA43TKgWhs/LAIGRGj6I+
	 1uqE4HhnZBlDgoGWeq5ipXST8UUHuoiz1rx9FwAfzkdrt27t1ITxP6cdqbsPTVGEP3
	 h98D6HYuTR+QWw3T8xB1qOEECjdgfjPCM3k78LlWG7MpzG/xtBP8URCb1bUQP4/dFy
	 PVIqyA02lBzb3yvF/PDjZCWdzGl0opWVMVaIkEcboX/cEhADSnUEkFULAQvsAuGNgt
	 FWGeuV5pMzaQg==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Eddie Lin <eddie.lin@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 5/5] misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free
Date: Fri, 24 Jul 2026 23:33:41 +0100
Message-ID: <20260724223342.629168-6-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724223342.629168-1-srini@kernel.org>
References: <20260724223342.629168-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eddie Lin <eddie.lin@oss.qualcomm.com>

The 'ctx_idr' is initialized but never destroyed when
the channel context is freed, leading to a memory leak.
Add idr_destroy() to properly clean up the IDR resources.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f8cbe30c5d5c..eb6c2a78d3c7 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
 
 	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
 
+	idr_destroy(&cctx->ctx_idr);
 	kfree(cctx);
 }
 
-- 
2.53.0

