Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359256;
	b=SN5GjYyyWR1Q+rkBBXE8aod25PShTtgncuWUO3vdjnBKqrx7gx6EMbxOGVIO+vh7QEkt
	 m6hdUe/zSw2Dtfqnmc+fkdEebqL7Ree9XjsHunEz0ObXA8XCK8YncUiq/ajK0B2AxYuau
	 H+KYJaJ4Kfkm9VmpICxjlsyjo/NVeik8ClVrxkrU3XWK01pv1/4eUrsAKzxkxc17mgXdp
	 YLvP2O9Id/jbQ7LEK1W33Z1jtdsY3OTtmJYcLDTBje0zdnpJHQsDCnwlcCKVAQ/izBZVp
	 1x4TAGqAPOp+CCR/6GTzVIhP4drt2jqAN05D6xnkyqNysr9I1yRn8rH4zzcc21wBRYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359256;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eAXeB1ysnWbXcYZcH6sfmXuzpLycASv0JGoqPEzxw2Q=;
	b=Akhae4fPhUazlEmwtNLcA6p15YQ/fmXLbjZpJsBBY2nCZSjzPwOytmeqRKiitwRNJPUI
	 PVfolGnKgqcHulZAZK4HXTGS951SMdxLjK1a1efcMYtGH3MAS8sKqNZ2KnlsQWNnJgFAb
	 zEPxLpVykAwgE+rOW0HhE8iMwhuju861cb/scmXiyhuzf4Hakrf/5IxlnemcMHDlcwH+h
	 lDPXSP5y/f2jkMtiZ4KSpryZEwjyiyA8BaRavJDKW0HYGwCdE0iKJe6LZ4T6RX1xAAkhD
	 pszktwSMVDAYgmezixmhje2yFp7m3BprwxIuiqzxIyT4xK7jAUuQKTEFdghzlyJqOhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Nc1i/9Xc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB8606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nc1i/9Xc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E363A1F0089F;
	Wed, 11 Nov 2026 01:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794359255;
	bh=eAXeB1ysnWbXcYZcH6sfmXuzpLycASv0JGoqPEzxw2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nc1i/9Xc8wgIlwzAAZ9O1X9uuxRIjufb1QctTMu57K4GrJxjxAFUhwLhfSNSPvn3b
	 l/gSXIuas/2sgxRzg4DCzHlGm2gwmSRmHx+RvqudAO5IwZgsuBWYxNXGqoH1iJfyO1
	 TC5p9NkZ5jlNFHOKKF7ASZPMTdomlV2auoJ2T12L/EYq5prmmVgGZciJ+93eQJo33K
	 ZdIs1cLmjJOk0C6tVyM86K51DlaTKt675FtBx7aqfIVvhk253aU5ZaNDJrEq8pM0bP
	 0kamvs0zktHLyn/6Y9UuzMMWGip/N7Dy/M5Ng1Qub+tDuY9pZKIkVtpY5/cVku9f2/
	 qrCWb/5CkDzVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xen-blkfront: Fix IO race during unplug
Date: Tue, 10 Nov 2026 20:07:33 -0500
Message-ID: <20261111010720.346916-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060346-failed-5.15-61b6d1df1d62@kernel.org>
References: <20261107060346-failed-5.15-61b6d1df1d62@kernel.org>
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 61b6d1df1d6234c38a6ea7e4f58e7da035ef6ab4 ]

During unplug, blkfront stops the hw queues and marks the disk as dead,
then later during removal calls del_gendisk(). However, IO issued after
the hw queues are stopped but before the call to del_gendisk() will be
queued but never handled. This causes del_gendisk() to hang forever
waiting for the queue refcount to drop to zero.

This can be reproduced by issuing IO during an artificial delay after
stopping the hw queues.

Fix this by simply not stopping the hw queues directly. Marking the disk
as dead already freezes the queue which prevents new requests being
added and it synchronously runs the hw queues to clear anything pending.
If the hw queues are stopped when calling blk_mark_disk_dead(), running
the hw queues is a no-op and can leave queued requests unprocessed.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Roger Pau Monné <roger@xenproject.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20261006163411.2583538-1-ross.lagerwall@citrix.com>
[ sashal: Retained set_capacity(info->gd, 0) and its surrounding braces because blk_mark_disk_dead() does not reset capacity. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkfront.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 02dc4a67ac82f..31dd69e3e6ed5 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2157,8 +2157,7 @@ static void blkfront_closing(struct blkfront_info *info)
 		return;
 
 	/* No more blkif_request(). */
-	if (info->rq && info->gd) {
-		blk_mq_stop_hw_queues(info->rq);
+	if (info->gd) {
 		blk_mark_disk_dead(info->gd);
 		set_capacity(info->gd, 0);
 	}
-- 
2.53.0

