Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323119;
	b=dUALxK4ty6y47dE7VFcuhyrfnQeWNDOmx0nsSn69y5nm58DME5MQHn24HGFMclUQwY4e
	 XLv3pM6+Kwtanz308mGI1/WYILmyf5ZYtGJfWXkIjj+O9O6G3KcjOGR7Qlm3s678/9hUh
	 KiyYDf0v+IIuVTtcB1wPuOtMxD4pO7/C7jXzL9kABnMICpIqi+05Gop/jEdkOgFKgecz4
	 SFSXNvTtGde4JBHHqOYQoAb2vcfnYpYg8f7KB3+ZQhHF0K3CCLDNJgzXHq2DxTCtcugKu
	 HdXjZJcHlibyN2MGOWJjselgxidjsLuH8H7sf25t3JGl/0uK2TdA2W7ItsdAuTZmkwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AvjVGl7hP9n6ZVen3Z6llmgS56dtNy5sp1qyOJAKUY4=;
	b=l6s6TMuHA9fMtFRlAzn0FFxyPkmN33MWPmAD9N3O533iKZ+F+vEvfVwq6pHc58knhwZq
	 DyZMexA4LwYIaYRcimqi/JOhylLN7BrCX+hFGUCJcT4NVdEHFt5TTz3x0HoSKUcOaAAN1
	 toGJM7SCNsgb0NZmeZ0Ys5auAEmvqBVrd5xRrrnziuo1jqWybZvLpiUdnnbEJKUJM+1fc
	 RwQ6hRpqhboRJQFKhKcwR2/KeETNTDKh0fqjgeSzbTwujGMDpOErRW4MZjsn+ImSbqTPz
	 26hDTseOzeNX2NbhwT5ja/5NajCYFl9NiMFl6O1azlVFvTLf7srIH77rJ+4TZgZ1uXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHfF5mYP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83760A380C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHfF5mYP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723CE1F008BC;
	Tue, 10 Nov 2026 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323119;
	bh=AvjVGl7hP9n6ZVen3Z6llmgS56dtNy5sp1qyOJAKUY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mHfF5mYPrJOEKrQIr6qttsjeV/4c+Z2ubDx6IcaDaI8JRXIHpYDYttinpFgk9hf2l
	 Ebr5wv/MmACRvtzfSbAoRgkVebIdQ/rhak7q+uyXTr9bA2sCo6sQL4+NXua615Rchg
	 UlDyfKdQc47hb3HJxi7gib+25Jth2eyWAvrBC9GO+ow+89Gqw7kNcJAlRJuee7uhbr
	 v2hT+Rkj9ubGeQKcGJZ8DAtx8sJ2QqjH4HbJoIC3Nutr3Bma3nLJe8YA8nfemTtcKN
	 6fnQnr4wQt4VdB6Pa2Bn7T9OKJ01jtwOmxLBLbPK5mxT1ICFh4+eU+VJwYP2757kiW
	 Wv4AFXBDDlbeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Gao <gyf161023@gmail.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] misc: fastrpc: fix double-free in fastrpc_map_attach() error path
Date: Tue, 10 Nov 2026 10:05:16 -0500
Message-ID: <20261110150509.2034547-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110150509.2034547-1-sashal@kernel.org>
References: <20261107053317-failed-6.6-09fa66ec1b48@kernel.org>
 <20261110150509.2034547-1-sashal@kernel.org>
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
index 18acf810694c9..20ef5822030cf 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -856,7 +856,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
 				len, map->size);
 		err = -EINVAL;
-		goto map_err;
+		goto get_err;
 	}
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
@@ -879,7 +879,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
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

