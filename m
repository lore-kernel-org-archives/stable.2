Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792932098;
	b=A2hU5cecNrhDZOT2TU59Suy0Qwo6JsgCktX1WXe3jreHiMJvE0j1kc8jWB9y3zW3C1es
	 cKSl5pankp5bWzE54CHvZZnFX+GuJ5MNEAtYXe0s7O0X5tOSAPhXfe/EF0NwongLEn19z
	 26XwjagdXnauPKtTSXZdutgfHvthzcxfFFeGkTezTItPOZW+1hPQPmOdzcYhHSfZATgi2
	 YMaaEi3mLAT82isNXpzNUpcN08LhWFgqUp+9ITcUwzWN0KlaYdtVpc+4DelBvMd42YTrW
	 VJ6kNCVy8kkx1WcjQs0gdabjZXxBn+3oX7QkNgRP+1wGo6g/F2Dbr2vjEs49OI6Sb5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792932098;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=kBj+4RxwijaLWN5ITLDs5hsE3jd/u1ixbAu4cXW/vcs=;
	b=SJjMbN3Ts/w34jwgeY1joZ6ETRjeKEHgCZIIEy5U0xCcsOjnxGs5cZySIccwRZfYTGmv
	 1+NrNbYEXYf1bkfzcRfKIWve4pdHSFvLeXaSWvqYDMYsqZmLLsU72tRAUK/uvktI4qWY/
	 0ANBKp8xNjGr2HmAfigk7tIILrXzneMjZHJF/7CYyjDXUzxEekhM5y1rmkj4Ma2/mn7oP
	 hIWz55EGu+hQncQUnfXzeD2naVEpbbVjnvXML42NCVv2cmU+AHafXnsS/2hnD03LE3Rin
	 WqmPcKxFb71uI3tTnQDGP1tihuNlqjp/xbJSR7oy/pYl1FE9nGQlVmR0AJ9uoXF/a9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=irqm4AVT;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34A606A31A;
	Sun, 25 Oct 2026 12:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC34A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=irqm4AVT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kB
	j+4RxwijaLWN5ITLDs5hsE3jd/u1ixbAu4cXW/vcs=; b=irqm4AVTDaZMMfbMc9
	ZI3mPqcgCSZgPdSKM8qtMSLspV66/LzvQCoE6pZXc/59gHIy7jRTG9e503ChvQCt
	V28xRWnjS+yxejDfzXcgNWJMkeJJehpfrhhGIf3gr5SX/q0VxYQ4mCr6Bf2C6uE5
	LRikHUBT52D1uuRDeaRVq4OIk=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnvTzs+N1qxJALCA--.54355S7;
	Sun, 25 Oct 2026 20:41:23 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5/5] zonefs: drain in-flight DIO before buffered writes
Date: Sun, 25 Oct 2026 20:41:14 +0800
Message-Id: <20261025124115.3178287-6-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025124115.3178287-1-yaojiale02@163.com>
References: <20261025124115.3178287-1-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgDnvTzs+N1qxJALCA--.54355S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7XF13Ww17XFy8CF45XF43Jrb_yoW8Jr4DpF
	9xKF13GF95ZrWxC3yvka1UX3ZYkF1kXr43WrWqq3W7Aa4DJr1jgF4jyry29a45AFsrAFWI
	vF4kWryUuryqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URCJQUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xOMxmrd+PM7ngAA3v

Conventional zone files allow both direct and buffered writes. An
asynchronous direct write can remain active after its submitting thread
releases the inode lock. A buffered write can then dirty page cache before
direct I/O completion performs post-write invalidation, causing the
invalidation to fail and record -EIO in the mapping error sequence.

After taking the exclusive inode lock, wait for active DIO before running
buffered write checks. Return -EAGAIN when an IOCB_NOWAIT request would
otherwise block.

Fixes: 4008e2a0b01a ("zonefs: Reorganize code")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 fs/zonefs/file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 5b34849be7a2..8635a795c24c 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -576,6 +576,14 @@ static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,
 		inode_lock(inode);
 	}
 
+	if (atomic_read(&inode->i_dio_count)) {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			ret = -EAGAIN;
+			goto inode_unlock;
+		}
+		inode_dio_wait(inode);
+	}
+
 	ret = zonefs_write_checks(iocb, from);
 	if (ret <= 0)
 		goto inode_unlock;
-- 
2.34.1

