Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322346;
	b=cwX7DEoIR39+2lLUwQo9Ud9zr/EOtfe5m9KaOOjK+/FiaiEYkLGFC7F27okUg5R4pZw/
	 9WjY2er1KZsGuF9KlWB3p3+IjbzuneC8RPZmaIXCuwDpHjPdIqmE4dAHR1zSERbr1CSSN
	 LadUcS9p2TOGMuA3g3QBcvBIQKtbdhQw9Bn59LJY2GS3nS2bwWw0p3URXCDpwn/q/Fx9T
	 1YH0yn5kC0wPSxMC9qV8iqTXczI6nmyntxL7vfCMi4sCZ5FvkL5QqZSsN5JMOHEWQIjmc
	 sdYCIr9fD1oOGbVYB8z8vqaW/TsUU+KnIMe+5+iJQ2Td6gmXpTRn4TSU2UGL2IF/Wcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322346;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WEi0OBPz0WhzdtOPhVd3eOIpfuGhYQ8+zh669kK+Wao=;
	b=rGgpp4CwtAuIb6yP3dSNp2ju9+hwBxZTkzxa6F6rHbVs314rR3POpJc/Z4+kiQpwXJuT
	 awGPT3td2kHQDYsZgzaG32GVOExEyEXRjOqf7ZFPW9hGAMdBshXiFhu2I8YwdgbWhfcua
	 cx4pVMi2O1Xz46ES+Z3gDKCLpGfEXf089Nt9ytAJPTt5XwfzD0En/OPjtEbN+b2L+cnks
	 3L9il2e9WstxFI1N43Vmq2AD65WUvWgw6YaE7TjN0BYx8f4RB9N+0rUKUKRek57mjAmsz
	 KbWMyyzwxJuEt/Okw9eBqGGznjkx+6MhtX47Q2Rs7DoTbkqja39zGrOr8vIYWiMgjSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J+GuAu/+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297E60A2600
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+GuAu/+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D601F008A2;
	Tue, 10 Nov 2026 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322345;
	bh=WEi0OBPz0WhzdtOPhVd3eOIpfuGhYQ8+zh669kK+Wao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J+GuAu/+y6Bnu0kJO8pyb35iJct9HtmwiBoZ97h+zx7eAJKot4jDUUMa38wkA7VV0
	 mG8ox2HcDiEHw6s6wAjmXhjVB8NHtuvnWaWr0b7K71QvHIOIRSE0mXPu0gqzQimeSD
	 IURaXbowxlbjaqeqRbRtQM4YZZ/RIWPNwpduQzPZYCmV4u9vRZa7+K6mjvGN8DOBbX
	 B1iOdKN42BVSokqM7TYKA3BBnb9n/1ReVQK3ZGw1dOa4SJQJ3G/zFVmPw6APCuXQL7
	 ZFVS262XwY1gQg74MLdZAV+IUWDbqbyOU1p4/kC7aPkPYhuJLyOlDaBRvHFPXjJtG0
	 +SavMiEpEvnaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Gao <gyf161023@gmail.com>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] misc: fastrpc: fix double-free in fastrpc_map_attach() error path
Date: Tue, 10 Nov 2026 09:52:22 -0500
Message-ID: <20261110145217.1998136-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110145217.1998136-1-sashal@kernel.org>
References: <20261107050955-failed-6.18-09fa66ec1b48@kernel.org>
 <20261110145217.1998136-1-sashal@kernel.org>
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
index 891f28e933537..9d596f4fd4dcd 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -854,7 +854,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
 				len, map->size);
 		err = -EINVAL;
-		goto map_err;
+		goto get_err;
 	}
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
@@ -877,7 +877,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
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

