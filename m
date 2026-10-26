Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792978567;
	b=VaFSlnQBYGSuluXul82+8GvEkMmQVeRm4ZXjkZoPkoD4fHJtT+ZRIuE+ajLXWDRBtc6r
	 icCECmIgKVvMPzST464QmiyuvwhUnwiEdheehrplp3haJApB7Ajep4snudJXjChegCoKT
	 SOHcudlnA9G/OSBt2ycFXpuPsNgx1DBwbZyfwrgTjXs6iC+Vbvrbcer26SbzvstUEbug1
	 swTkGcSNL2f+iVp5JXtvSoHJrpTa4id6maRe8iduoUOv2xh4d4HMy6gQ2t5z2upIOO4zf
	 r5dK4DoOxHJ41JEQnzgLl6+Q3q1kTKkqEWZPfSEkEJ2kEzcIMahaZMhMernc1mNTiuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792978567;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=G8Ajzz5naVzS35r8PFaFnbKVlFcksfzdUJCNllkRj8g=;
	b=LOKKeMn+xd/vUXMkWU+SAo0roaB2+XoV64jeFgsnamxbtAbCNqFtM24jtNX1cPg5/VY5
	 LSEDd0TIdUct7ET07148EfboF/I33JoQC7dt8WP9rTmkmJsu5ddckudTC9mgMnSWKLIx+
	 x9tA6lohuBHATK8QAGVJuoy1klq0w2ucAwEzHSc/gpc7ONTtVrVX4YLFRWOP6W4WtRFy+
	 gbzwhttsq+qJ+zPR9P/kN4/VPXjtLFfULwpkvMh71aR5drPMK2UbTUJyWVEHujj9riDUk
	 c0AhK3uuFA/R10ZytZMCeAlM6wVruKHbHPIFDwSah60EzMS0JMBKybPLiZkvAg0ZL/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=C0yt7kdc;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41564606A31A;
	Mon, 26 Oct 2026 01:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41564606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=C0yt7kdc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=G8
	Ajzz5naVzS35r8PFaFnbKVlFcksfzdUJCNllkRj8g=; b=C0yt7kdc8QkD8nEMLs
	nOy+HMUtKY19r0Hku8zoF0FyLwn91CLqB1OWomSqiRdsFk5PZIfzva4lCPhabPJJ
	0B7I+buCWSNDfo/AFOPGoqf2NuKVFuKPN79JGS5Ospszq/zNVXC15ppS45CaLeky
	fakiX4WAfR6YiEhFA9qjgRykI=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnH55prt5qhnFSCA--.7906S2;
	Mon, 26 Oct 2026 09:35:38 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] f2fs: drain in-flight DIO before buffered fallback
Date: Mon, 26 Oct 2026 09:35:36 +0800
Message-Id: <20261026013536.385261-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:QCgvCgCnH55prt5qhnFSCA--.7906S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF43ZF4DXF4xuw4DWryDWrg_yoWktwb_Wa
	4kC34UXw4fGF4fXa1Ikr4fAFWvv348uFyfGrWayryfC34fJ3yrCrn0kr9xG34DZFW5GF98
	Gr4fXr4Yq3429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbLihUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQoYUmrermrlWwAA3D

A partial direct write can fall back to buffered I/O for the unwritten
remainder. Other asynchronous direct writes may still be active after their
submitters release the inode lock. Their completion can invalidate pages
dirtied by the fallback before it flushes them, causing page-cache
invalidation failures and recording an I/O error.

Wait for all in-flight direct I/O before the fallback dirties page cache.
This only serializes the internal direct-to-buffered fallback and does not
change ordinary buffered write handling.

Fixes: a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0c759cc99054..e54456e3a226 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5596,6 +5596,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		 * The direct write was partial, so we need to fall back to a
 		 * buffered write for the remainder.
 		 */
+		inode_dio_wait(inode);
 
 		ret2 = f2fs_buffered_write_iter(iocb, from);
 		if (iov_iter_count(from))
-- 
2.34.1

