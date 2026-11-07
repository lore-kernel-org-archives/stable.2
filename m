Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046855;
	b=RPT8c9IUP+P1+la1DB1oSXyOv/VsxRr2SGWJZ92oTyONFvSOXs9pj0gbu0ELQyxABj4X
	 GdgFH0nCM/M2mbGaBFYXuZJ5GJTqKzbFwg/2IC7T1uMJfGaq6/3fy8yI3z+In+eXX3Iv5
	 U5Gipd4NEO/yX9C17ak7JQzp2Xdy7wu1Tw24EA3UtaRX8McdWis+7mcuMgdl/ATcbJPyl
	 cwJm4tcB4TBm1VSZBqKLrJENNCmSJ/WfzXNzRNBsJUOndRx19ZLrB3HsBb3dszo+f/xP3
	 N7RCr9XEYuvU8VQSZtixlpZyh59zOk9gjZrRLfSEujce9dTXKtUmA5gQdOIR4KxEruw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BB5uRvvDKv4Z6dCAskfy6AOr/0l5IL93QfpZJ9tNE6E=;
	b=EDLioXZ4JSaQ9pgcf+cKxH3gPOgYWkbSGjdlNJvHfkJm/TwFVNRn6um7+8/0xCDE845u
	 3Xr/LH11gI5+Gr74VFiZoTDb6FQiCv17sfQ3E4O2D3veHlJ3JEzaVjpMf6FOPg14YYOCj
	 SCLQ6qV3Cc7BoN027PlJg+Hvjd/9BR8AmRMRgYPjKb77VhZlGPJ7Ap3acglzuwZjzdzwA
	 Pw6kPw8RoIuEGYglFQDypjuPcXRqrC309VMzIo72oevLXqqpFpwVxB1T2ooecQOgHY7sT
	 aIFl6EEsEWmwalPQx2Z4+CS2/kMePUBubUGvOePwFcY6c8EEjs2T2EokC4e0Jz4YUkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JN68b4MM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EF8606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JN68b4MM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6441F0089F;
	Sat,  7 Nov 2026 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046855;
	bh=BB5uRvvDKv4Z6dCAskfy6AOr/0l5IL93QfpZJ9tNE6E=;
	h=From:To:Cc:Subject:Date;
	b=JN68b4MM/AYDD/r9P9vXqD921ZF5TOGcLvUp+8juNAhcskk7Xw/GV0QjKXmpGKIy8
	 S6dt9WnybSBLmGgpr61f0jdUhWLIFR04pgx2KuEnd3PWPRj3C9y/1+OKalskv2ZJsH
	 Ql2zSUYBPqV/zeMg6PJgmQtQDU8Nbxpn+47HjU6J+4D2fIyVteqVwy1sSbOPEt4yKe
	 dnZ6m5AeN24IAExSnkPHVwqfCasxhWhq/CIQXPaFu009I3vznnGzlGbKwpOpd5LJrw
	 1TSzmWCmos41jbMnc99qLR/M859WAN3HmK3u3McXSwpm4TYm3RKMeQBzYyl/N6cLNB
	 kdzc05Q6GiKCA==
From: Sasha Levin <sashal@kernel.org>
To: gyf161023@gmail.com,
	ekansh.gupta@oss.qualcomm.com,
	srini@kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] misc: fastrpc: fix double-free in fastrpc_map_attach() error path" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:53 -0500
Message-ID: <20261107052053-failed-6.12-09fa66ec1b48@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 09fa66ec1b4896ab841da085ca58b6433f28f07f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052053-failed-6.12-09fa66ec1b48@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




