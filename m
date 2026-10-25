Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792932132;
	b=kl6c9OSYf/b4zDqi0zpisPVXh343btvPOdFjVOHib8CqTr0wB5tyBa8PgR+Lt6vIhGGy
	 0Q038nnsLm0FDQBmRhH0brVoMVyc2WdalTooNxiIaEN4/J/wvd8QYNhGrw0LHAWjaVlNp
	 zdZlEZd+hFYpn3WuGOI0v/HXF1DL5kGerm08nAtrmKsqr7QxwYZtucqF7nNjDsWLQ4wch
	 5Br2ClHyqBs8yfOqvkJvPvfSoRyWHaIB3F8OMokCUVLohCuWAb3zb7szqH/V+jIVI3Fhp
	 rzz7OqVdJHgmSX/zSpGB7DnvNei6JnLAYECdEiBdpGTsZW+AyjDtx7KEszycX0irCJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792932132;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=xGxgnZ4Nb5+HVxPTfCx+RwDc2J83kiFYIRes4qeJPT8=;
	b=Z/194Vl2eof+OR4lC2jMiBEt1Beh/UdGZWH8AGKvng63s1G/5RUf2GIAbf3CgEYlml4+
	 TwIV0y7dS//0ZMZ7lXq+9dImyDR7PJTUxldO3UcvE3g579GTN9dqnEGulpIbSqOhyumPF
	 6WHV/epLy/nZkQNVMOl4yFu8E1FbXMjLhdx7DqnZMKia2x8tviOuXhrsGJub25JK7Nlji
	 vfi/nrQTQYGCjVxz9PcYMiKoXmtrEOilG1i2z105N/Jn04UJBGOnGvlCGGszR9FzB8W0m
	 7PgCtu8ZbExEoutWY9Gecl2lVEoc/1oNMFcUOF5Q/+DpsJh/TP1DmPZ/0onK7Au5mOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=a+alNaFD;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08235606A31B;
	Sun, 25 Oct 2026 12:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08235606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=a+alNaFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xG
	xgnZ4Nb5+HVxPTfCx+RwDc2J83kiFYIRes4qeJPT8=; b=a+alNaFDKo+L25nvd2
	DmanOPi1/a4qkJ36ZoDSJFtO6iTrhrhjvmJznpgNhzuiiiQoHwZlL/5E0/YVl7zK
	L+1tFgK10dUln03+UuJddpld7lfXjLcnLp+vb7oNi3FNUPvCeOkWUIR7DgkbSmIi
	hikcDJW/NwRtFozzxIQdwOm+Q=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnvTzs+N1qxJALCA--.54355S3;
	Sun, 25 Oct 2026 20:41:20 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/5] filemap: drain in-flight DIO before buffered writes
Date: Sun, 25 Oct 2026 20:41:10 +0800
Message-Id: <20261025124115.3178287-2-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgDnvTzs+N1qxJALCA--.54355S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1DtryfXFW7uFyxArykuFg_yoW8WrykpF
	Z0gryFkrn3trWxCws3Ca1Uu34rKFWDAay3JryUWas8Zr1kGrW3KF10qryYga1rAFs3Wr4a
	vrsYk34kCwn8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UM6wZUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xCMxmrd+PA7ewAA3K

An asynchronous direct write can remain in flight after its submitting
thread releases the inode lock. A buffered write can then dirty page
cache before the direct write completes its post-I/O invalidation. The
invalidation finds dirty pages, reports a possible data corruption, and
records -EIO in the mapping error sequence.

Drain in-flight DIO before both regular buffered writes and direct I/O
fallbacks in __generic_file_write_iter(). Preserve IOCB_NOWAIT semantics
by returning -EAGAIN when waiting would be required, while retaining a
positive partial direct write result.

Fixes: 8174202b34c3 ("write_iter variants of {__,}generic_file_aio_write()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 mm/filemap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c..289b8ca44ada 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4502,10 +4502,19 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 */
 		if (ret < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			return ret;
+		if ((iocb->ki_flags & IOCB_NOWAIT) &&
+		    atomic_read(&inode->i_dio_count))
+			return ret ?: -EAGAIN;
+		inode_dio_wait(inode);
 		return direct_write_fallback(iocb, from, ret,
 				generic_perform_write(iocb, from));
 	}
 
+	if ((iocb->ki_flags & IOCB_NOWAIT) &&
+	    atomic_read(&inode->i_dio_count))
+		return -EAGAIN;
+	inode_dio_wait(inode);
+
 	return generic_perform_write(iocb, from);
 }
 EXPORT_SYMBOL(__generic_file_write_iter);
-- 
2.34.1

