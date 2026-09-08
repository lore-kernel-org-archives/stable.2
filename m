Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CAE54CF6F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878117; cv=none; b=AA+ii6b101LdgS9QYtmN9F+ZdRxRKlaoEANmzfnWDkVTBNGkoj8MumgovPLySo7dVR5bBiw7PCjPUMkesCiX/JrXHTjk266JE88iWdSdTtDYAI1e/la4pqNizSXPx3kBIuXPvRjhrtObo49294hjm5RbsuZuKvbARO9nnODng+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878117; c=relaxed/simple;
	bh=BfLF/Aj5a2l/eiHeKL8scRNQ5iV8q4zXfLB9x+4z/8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9YBbrShgXtfn/nrxx9u81OJFXgAJcgSTF1O4McFxQ6oJOhUe8zPjhPdj89NRtsWv2TRfWBpwEIYooKptpXcCgFFthwOgRwePaRlqQTKhhoDDhp4vjwR7lUwb0MGB9vi8Czqw3HZKMxxiQRsQYlmyU6QuxmomtO4znq8T63l4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCYe4Bvp; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCYe4Bvp"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b1a4faso653181e87.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788878104; x=1789482904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MW4LrkosLq6x3pWpb8ZQTriCBVYq7W5XekYvYQdHPT0=;
        b=tCYe4BvpdSfzdybPtfB68UUi9LwOUXrcCYcyVxdcJuQYmt6d0Z5VW16P6jSPdNlOGw
         uKLeMilJBhY4T2cnadX9RDtcCEYZZQ38q7/8N2NDVeqeyHa24dI+BmAVypnACc2TnwZK
         WrCxNihbsHZmDYKPvZbmCfECod96Z8cXKgnYdDNi5mKTlgnhP8HHpXBY9Lq2ITIov0Zl
         1CBfybWFAIHQeYBZHruZk5MUERhOoJ4J8IDvQ7oDAq/B/ajXVYJe0y/IvReV7qp1wSyi
         eknEQHgLBGoXDXk4I8LIm3qfNBu/nWCjT1tuKCyWCLHniuH+5NCxEiEndTwWssRoDxjb
         OvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788878104; x=1789482904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MW4LrkosLq6x3pWpb8ZQTriCBVYq7W5XekYvYQdHPT0=;
        b=cpizvoSQ1iMOM0rANy6p43LTFldesiVZ71rR46kJVPz3ODbp30Lz8+pjatoeFNHM5v
         e8DRA3kCkMHxiNX+oLOGcdesYK+9kDLJCy4QC7rIxf3jACR7yu1GYdN8fhwa0vJP5BN+
         Rxl4kyadiOK5L5EXQoyZX3jKRYpl51h87KzLVdjEz3NU+/E6ePMcuxxMPI3w3NUY8QXA
         vBXIw4gAg7dutG/cdwi0U/PKb48ngFnGYLP+DkbdVlGFhcbcOZOuhpUaJldgFrxbyeqg
         +zbJOBg1hQo4nNH6TR9hTR3C0fKWT8a1LGXEZ31/TQYuASh2v3kjAE5JhQNBlW33cs+A
         E6VA==
X-Gm-Message-State: AFuF++lsyPJiUJCl+PqoAuqXZVe2W8hLkXsMxu0zSD0OWNpnmY99DJta
	J13ntQSJQPpWTpygcNh3XyOO3TMWQF2mviS2hZl0Ox062KFHWW5ChSV7e/MhuA==
X-Gm-Gg: AYBFou2e7Mbef6GHDXRc9hPzj5G1UOxn3NwWtbPupnmNZoVsQ+IkxI9ikpPFGhcNKyP
	VPYg9O8EILr+qlgQGIROklhJjYWvUVHNmqmWmdsTTOUyqU92VRpptRGP/oRJ3ycwQJQfTEom9nO
	cVEyOk0rVmrTIVpG2EnfjoMAYRwTEa4LrlDHyDgbtk8JKcNTTHKuLXfmeYZkZVSsDpE3JyxEN4y
	QJazWBIG0uYrX8azu81jRRs8Kt5PHeCdyFGKmbniIwJBkzMxLt5dAZnTt2xH+2TCpQmSGJvzDk1
	8EZRFjthbZnvt0PTwsQdsVfqFWpQo9KD/HM52tr0PPFpQ5r3U/nQ5JmxZN/MhkmxeuUZLatHx5b
	JKqz9IslaZcxfpO4j9OZV6BNGXbvWNbXyWSlCIVhDN9RGpKhzjO295PGyO8OMoQUFzJjfnx/oW5
	t93gICwWwaYIwbhvH4l3B8cY9pACP5leN9ooZSuzlOdCiUwdCsR50Vi5HcaOb/kKJqfkuKMlWSj
	jc=
X-Received: by 2002:a05:6512:685:b0:5ae:b2df:c11a with SMTP id 2adb3069b0e04-5b74d4055d3mr4095036e87.0.1788878103832;
        Tue, 08 Sep 2026 07:35:03 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b616709f95sm3092257e87.74.2026.09.08.07.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:35:02 -0700 (PDT)
From: Dmitriy Okunev <dokunevdmitriy@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	lvc-project@linuxtesting.org,
	Declan Murphy <declan.murphy@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Mark Gross <mgross@linux.intel.com>,
	Daniele Alessandrelli <daniele.alessandrelli@gmail.com>,
	linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: keembay-ocs: prevent underflow in sg_data_total - remainder
Date: Tue,  8 Sep 2026 17:34:47 +0300
Message-ID: <20260908143447.2155188-1-dokunevdmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kmb_ocs_dma_prepare() function, the `remainder` is calculated
as `total % blk_sz`, where `total = sg_data_total + buf_cnt`. In
update requests, if `buf_cnt` is large and `total` is less than
`rctx->blk_sz`, the `remainder` may exceed `sg_data_total`, which
will lead to an overflow of `sg_data_total - remainder`. This results
in an incorrect large value being passed to the `sg_nents_for_len()`
function, which can lead to memory corruption.

Add a check to return -EINVAL if `sg_data_total < remainder`,
so that the subtraction is always safe.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 472b04444cd3 ("crypto: keembay - Add Keem Bay OCS HCU driver")
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
---
 drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
index 9a67bb4ecc82..92f2d9ff6f83 100644
--- a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
+++ b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
@@ -246,8 +246,11 @@ static int kmb_ocs_dma_prepare(struct ahash_request *req)
 	 * HCU must be aligned to the block size; compute the remainder data to
 	 * be processed in the next request.
 	 */
-	if (!(rctx->flags & REQ_FINAL))
+	if (!(rctx->flags & REQ_FINAL)) {
 		remainder = total % rctx->blk_sz;
+		if (rctx->sg_data_total < remainder)
+			return -EINVAL;
+	}
 
 	/* Determine the number of scatter gather list entries to process. */
 	nents = sg_nents_for_len(req->src, rctx->sg_data_total - remainder);
-- 
2.53.0

