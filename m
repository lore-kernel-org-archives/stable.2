Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322799;
	b=XfRmwn7DEZSiD/pSVDirMf6zxfs8it9CnrqEjVk0yLs1717LOYZKT/+JmwIEx5IXCPi5
	 spkPDW0WXgtY2Z0Hx7jdThCqdICF4UHgcTpWKdIAdK97TNOZ1X9RUlK9BvPiFzoxx0dVl
	 H4HRzbI2YtFFv5tgfaXHStWFH4Bi8xaYbgpyMFz2vdf0c4EYrW1Y6FA0jn9bXyQR2DayD
	 g9b+g/6a+gJEEsFvyRH1RD+39i9PYIskgrIWSxUmrRouRCIyQ5keREadF41HgIcARmlNC
	 YnRwjO/m9Qoz2epY1wMJLYLLg4X5tyMDKxDPQHsSew1VkCvRkg5qv4FO6LALgfdNsbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322799;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mEfMS9ILT1rPQqgbKFW2JGPLsDmYArucIN6/LOvmWlg=;
	b=blcr1D80ij0uQvxezkMsX+Ynuc3eliTkCbaUGXK4FTgZkODn3mwnj+gwco8ABnOMdON8
	 B+rIkaL7TnD9mVsRD/t4Mna3tQsT/1h5Sp/IF6M3QeieTm/WUZccmZnIe4N8TTfbpZId8
	 jRrk0YHxmVW8cLizLHsDfadvhHp1UrwvY5HY65MwD8WQrgLODQbT8d56bCHujqX9sqrcf
	 0zWe9qdHIeILIzgT6mcnw3F22nJ9E0l408TODLQ/UPf8HyvwjtLkoK4XP8/WjExqP8VwW
	 BBPHS+pIMf9ba6FMeDMwuvowfDiwT+ll+RwXb1BqnsxyW+C75d8xrUoISLIhpguR/HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fhR/bpkr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0660A3801
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhR/bpkr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1729F1F0089F;
	Tue, 10 Nov 2026 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322798;
	bh=mEfMS9ILT1rPQqgbKFW2JGPLsDmYArucIN6/LOvmWlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fhR/bpkrzFSSmIMFXPeGi7EGbBWtgegYQ4PRkv1o/m+v+sg6uO1PSq8TPaAJ3cDfQ
	 f1jKSeU1whESMyTSZQa68MH+QhK13KuaInyazSSwCoWVOq2o3riQQiR+qvb1RrLP3v
	 NPWiSz9abJefqFAKR0SgC/FDfVBUVz3bHETQiXUhEgrFJeZHaIaBXWSSdD+KSmQGMQ
	 BZIS3TH+4Lk+lKHRgy6yFEnlH+fa+Qmkf9uNMwIaUPz5KMsglznmnyt6rDZ7fhAPOS
	 RFmDNxu+QzzdCj6vjvTmaJX+1FIt4sJeYEQBfyqCBCG46Y1VAXMZ2SCXuGBN4Yzw2d
	 VcmRYYo+XxbLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Gao <gyf161023@gmail.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] misc: fastrpc: fix double-free in fastrpc_map_attach() error path
Date: Tue, 10 Nov 2026 09:59:55 -0500
Message-ID: <20261110145948.2017214-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110145948.2017214-1-sashal@kernel.org>
References: <20261107052053-failed-6.12-09fa66ec1b48@kernel.org>
 <20261110145948.2017214-1-sashal@kernel.org>
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

[ Upstream commit 09fa66ec1b4896ab841da085ca58b6433f28f07f ]

map->table is assigned right after dma_buf_map_attachment_unlocked()
succeeds. The two failure checks that follow, the len > map->size test
and, where subsystem VMIDs are configured, a failed qcom_scm_assign_mem(),
jump to map_err with map->table already set.

map_err manually calls dma_buf_detach() and dma_buf_put() and then falls
through to fastrpc_map_put(). Since that change the error path tail is
fastrpc_map_put() -> fastrpc_free_map(), and fastrpc_free_map() already
unmaps, detaches and puts the dma-buf whenever map->table is set.
The two operations therefore run twice: the second dma_buf_put() drops an
extra reference on map->buf, and dma_buf_unmap_attachment_unlocked()
dereferences the map->attach already freed by the manual dma_buf_detach().
kref_init() sets the refcount to 1 with no intervening get, so the final
fastrpc_map_put() frees the map synchronously and the redundant cleanup is
deterministic.

The len > map->size branch is reachable by an unprivileged process via
FASTRPC_IOCTL_MEM_MAP with an fd whose dma-buf is smaller than the
requested length, before any DSP invocation.

Route both map->table-is-set failure branches to get_err instead of
map_err, so fastrpc_free_map() is the single owner of the
unmap/detach/put sequence. map_err is retained for the
dma_buf_map_attachment_unlocked() failure, which is reached with
map->table still NULL and an attachment that fastrpc_free_map() will not
clean up, so its dma_buf_detach()/dma_buf_put() must still run manually.

Fixes: 334f1a1cbe03 ("misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20261002101220.1084101-2-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index afafaa68e2bd2..a4577ef5a3946 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -857,7 +857,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
 				len, map->size);
 		err = -EINVAL;
-		goto map_err;
+		goto get_err;
 	}
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
@@ -880,7 +880,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 			dev_err(sess->dev,
 				"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
 				&map->dma_addr, map->len, err);
-			goto map_err;
+			goto get_err;
 		}
 	}
 	spin_lock(&fl->lock);
-- 
2.53.0

