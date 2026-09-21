Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87A51EE1F;
	Mon, 21 Sep 2026 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029579; cv=none; b=MWj5iXoDst1k3960dAizsnLtTSFaOZ8AuyBW+ABhbtTTJOEYFJ2ZfEO9dOcZuRLXRxbZIfKkoH8tjTQ57U+WQRnapUvxoZV4LDB7el8C6mmE7Uk6ZEr1lvYYmu3aZzeC/Fuj31lDiAzzKC65VNNr09cQaDwxKZbwAC9hDY5qzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029579; c=relaxed/simple;
	bh=tQErgxz8d4ieMH0CWIG8w2M/H+3MIf9cEE5FuXtAOus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BKuYLDTkB8SqkenPLnYTCxKBHHJxZs378DxQQ9wRYwJqGmOmjjX9zDyF8F5e2pENV/MZjzbmlrlnTxGt16XwBt/KKUX+nFNAy51zMhKmz7LBnBbEA6L+ukvk4AACqBX3XliHy5uXuMpC4shoNa9XDs23RyUCqrn5Y8wA3x67WFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi5Clfh/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi5Clfh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC89E1F00898;
	Mon, 21 Sep 2026 22:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790029577;
	bh=3lI3HQC9chBAMmb+T3CdTqkPoTDWc/bRBxcstdw4V3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bi5Clfh/jeLP0pgh83Ip9yAKTTg3KCzBq1fdQ9q+teHotlnzev1Jq31LENfq55gfO
	 OFG+AxgknIxPPX2Iwdzo2fdqPSIS9rXK14srjT1XGdB/p3/dsCJm9Lh4taYY+sb4Wq
	 CPAv6+gz5RhqR6YRPQDlFvvALvt3ydt6GyT/Kzz/Vs4djhhMomM3zj0UD9YQWEROZx
	 hJsV/VGBvFp3imZlsn8kg4y1Y+HnOQslHtLM1Tx1bYwXneBOif/q07+Lf4OiWoSznQ
	 qQxLeHCPgLs6jK5EFLuXbP7eyu4mw8mZRwUHf3jw9tD9UjaNuiBR7ZYODVAAC9KfCO
	 +jl2UdDtD/k2Q==
From: Michael Grzeschik <mgr@kernel.org>
Date: Tue, 22 Sep 2026 00:25:54 +0200
Subject: [PATCH 1/7] net/9p/usbg: also disable endpoints on p9_usbg_close
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-usb9pfsfixes-v1-1-9d8dcc52904c@kernel.org>
References: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
In-Reply-To: <20260922-usb9pfsfixes-v1-0-9d8dcc52904c@kernel.org>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <mgr@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=mgr@kernel.org;
 h=from:subject:message-id; bh=tQErgxz8d4ieMH0CWIG8w2M/H+3MIf9cEE5FuXtAOus=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBqsa8DA1XjZ/WrRUv675v5v0nqBM0/eo2G1H9y+
 lxWJEOV/dKJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCarGvAwAKCRC/aVhE+XH0
 q+7AEACrMtVG7EHxL1V+ovxK2LMv0j3X6s5vWL2O9V8Alg3OMzgJSRM9T2u4GViHkO1aesvsRAN
 ZHV1TCqcSvYr1hPlkQME2UPTyAtjGG/3JQCnpUfgq2DKOHKi3xvFSMuXDJBCH2vdLqEf4XWbQKr
 qw8aU6wCifX7C4IHXHtnwqKY0Uf7YgFgAwQShY4C3XY5gqaKoFAnL5ixoHeruxZb0hJAm7PAEE4
 ivyawEQQgu709taKoIOk6ScNzTGuNV3kyvmK+03cDswUENdE4R/lkCgXEVHfM+23s+LUUfESiK4
 Do7lcspbhZXsLof1pE/FqJphRhmqwG0oia8EVrgUNJTDcUnZcRDIo7HXkc0NFldcVmNQ1MX+KKI
 QOWEg/oaVwPKwZST7wHgMfrrnRbuMk3I5gICHI4CFjbNq/h4sgqD89NoL/Q5JEHuh7j0+OsSyjf
 hYZjqCm7xth4HWGDpUX5laaQaWz3urYge/W7+TSolzdEKKo5kfJLgOhDMbHTkt/XyWlwgBLtIU6
 G7QB/5ww3FFPv6xsR5J3L9NVIeICS5qrY9E0Bu6mo3QyU0cfZ3MeLexJalSEc9br8ybNIwnsQvK
 p/SPLb0JrtvlckzO1wX4aaqZfU96qxC+kaGk7jH3CMQPmmXgmH5e7y59Co2mKr7pa4DBSRHZrca
 pBf0m5kykdcbdEQ==
X-Developer-Key: i=mgr@kernel.org; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64

The close function has to fully reverse the state change of 9p_create
(mount) and the potential call of set_alt(1). This includes to ensure
that the usage of the endpoints is not active any more.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Grzeschik <mgr@kernel.org>
---
 net/9p/trans_usbg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 9fd7801d56ab..32e18077309a 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -473,6 +473,8 @@ static void p9_usbg_close(struct p9_client *client)
 	mutex_lock(&usb9pfs_lock);
 	dev->inuse = false;
 	mutex_unlock(&usb9pfs_lock);
+
+	disable_usb9pfs(usb9pfs);
 }
 
 static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)

-- 
2.53.0

