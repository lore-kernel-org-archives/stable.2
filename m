Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047599;
	b=lfVZsBSnq9yV9cBolKrDmBoLoIkdVljrIH5TlgmEjftthqLIUxnIsELwhoHb6LXaJGnN
	 wVkeFgvTbi2U53Wz7yq9Y/nIGIyzUevxof3RFvjCDW53c5B3dSexWjiy1w8zbkfiAmS+y
	 UIl7BqQlnf8ZbvuCYLYIjj8sLyyETgx6V+xfFryHuKfhX9GThSkrlsfLI7XOsCOWAKq7R
	 6s03rEAlvYVdhHx+seffvWCoIN+acQuOyFiKXAUAcUy5B0jh1tM4hZtoGpseqg+ql0am2
	 OcbJbQN5YXUTDJOGhFD4NgUuhpwMj6cdmIzEHqwx9nphv9/yzMXEF539C7YOFy/iOwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kYUUwfHp08ZsX85EpjXuwAA26iZFxfRfy+MykxRaxcY=;
	b=MSc2ive3wTAGRLRBQ/VB7WLaYs2yb+/oj6hLOY51lvIucl4vRc+sENafAKt7LmXWtW3J
	 c5RdBAwt+uPcmPJTpq23EdwyrMP9XWdaPr/ZpXOZwqcjwDjf4ZiBP61lGGFR7cz0L7v23
	 QAwI3DSQpXFgba4TSN21tBcSRrFdV55Iqn0Q3H6ClomKHsYWWs5VQM6dW+wOSmdbXP6Xm
	 V+GSL6NClD+ljoM9zKsXXFtJZOcCqfymNz4pzflU+EYIddzx2g8S3bw9+/WvWpziIsW+t
	 Nncy1MJL8Yn4/c/I0LPORWwG1dqDlpNK7D/7GB7yOqPpf0ovyyemA/AaKe4/YmBeXXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipaj0vBW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70804606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipaj0vBW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB79B1F0089F;
	Sat,  7 Nov 2026 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047599;
	bh=kYUUwfHp08ZsX85EpjXuwAA26iZFxfRfy+MykxRaxcY=;
	h=From:To:Cc:Subject:Date;
	b=Ipaj0vBWfDVYd7DE1qHxJOYWW2NddqWXs6EuRBiCpmiLx2D4runytGB6T4ixKBaJC
	 3O6W9j29AFXVsrs3l0FjGKDT6bjDSbm/1YLpwradO7ptCGyiWU0KQLl/IRBGl843ER
	 XXUhfc1bqNym8uz/CDWmCY1k3A6kpO2rU0/0oh/6BiC+yj6bC3tWh1gYQ9RerCTdcu
	 tZW28E/XpVsz2rj0B+86S4Y27oNNhhKnVE5rbGOYgXKVlV5c8B+9ieLPBCIaLTwb0a
	 dgwpOXaJD+ge2oPj+Mfp0Sbq2ypgpP3vEGTnQKrfUUJq21JKcUBU8sZL93RxM0b8E+
	 f+n5PM19UykmQ==
From: Sasha Levin <sashal@kernel.org>
To: gyf161023@gmail.com,
	ekansh.gupta@oss.qualcomm.com,
	srini@kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] misc: fastrpc: fix double-free in fastrpc_map_attach() error path" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:17 -0500
Message-ID: <20261107053317-failed-6.6-09fa66ec1b48@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 09fa66ec1b4896ab841da085ca58b6433f28f07f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053317-failed-6.6-09fa66ec1b48@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 09fa66ec1b4896ab841da085ca58b6433f28f07f Mon Sep 17 00:00:00 2001
From: Yifei Gao <gyf161023@gmail.com>
Date: Fri, 2 Oct 2026 11:12:19 +0100
Subject: [PATCH] misc: fastrpc: fix double-free in fastrpc_map_attach() error
 path

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
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 53ad9a3f10699..904f538f0dd0e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -927,7 +927,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
 				len, map->size);
 		err = -EINVAL;
-		goto map_err;
+		goto get_err;
 	}
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
@@ -950,7 +950,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
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




