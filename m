Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272E40D567;
	Thu, 11 Jun 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188817; cv=none; b=Im0EoN/DGoiQzip7PoPVPDLWTzdbq5TZNn7gwRK3f6l/vs/tkFc9zdLQq7znGsRGG0u2f7kzw26OX0mXtm19M4EtPyTzgJMbZQE7TpbT7q4fPc61t0zQAIbpKE/bQTpjD5UsKtKkSqI4CgbaKxQgMWWp5S8aK6EkKkWF5+9zwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188817; c=relaxed/simple;
	bh=VxlQ8Q/mIPv2p36F1IgHfA/69SnhoWRW8i9Ij8pUEX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wc301FQAm022UKzdpbuFyfvIWGmIENFN9CO54gUNpHKrOnpPvLy4nN0FJWlezjUhnMsfoSBryfLw50kOewwuqVxJWpnTHIEHjwx5GTVVS/tttmW0JJ5BDHxnl6k1TTVEzmQHnBY4ZjnXUJoPYjMJruFwKQM+xnewATIM5EkGRso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowAAXXcDJyCpq2KwXEw--.1062S2;
	Thu, 11 Jun 2026 22:40:12 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: fix refcount leak in ceph_readdir()
Date: Thu, 11 Jun 2026 22:40:07 +0800
Message-ID: <20260611144007.88851-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXXcDJyCpq2KwXEw--.1062S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7JFy3Cry3WFyDXF1UZFb_yoW8Xw4fpF
	4kKas0yrW5J343CF92vFnYvrWF9ay3CF1rCrWxAw129a15Gwsrt3sFyF90gF17Cr4rGrsI
	qF4kGFW7ZF1UGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvXd8UUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoPA2oqhg7QRwAAsf

The ceph_readdir() function allocates a ceph_mds_request via
ceph_mdsc_create_request() and stores it in dfi->last_readdir. In
the directory entry processing loop, if the entry's offset is less
than ctx->pos or if the inode pointer is unexpectedly NULL, the
function returns -EIO without releasing the reference held by
dfi->last_readdir, causing a refcount leak.

Fix this by adding ceph_mdsc_put_request(dfi->last_readdir) before
returning on these error paths. Also set dfi->last_readdir to NULL
for safety, matching the cleanup done at the normal exit.

Cc: stable@vger.kernel.org
Fixes: af9ffa6df7e3 ("ceph: add support to readdir for encrypted names")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 fs/ceph/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 27ce9e55e947..ef9e92e362d3 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -546,11 +546,16 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 			pr_warn_client(cl,
 				"%p %llx.%llx rde->offset 0x%llx ctx->pos 0x%llx\n",
 				inode, ceph_vinop(inode), rde->offset, ctx->pos);
+			ceph_mdsc_put_request(dfi->last_readdir);
+			dfi->last_readdir = NULL;
 			return -EIO;
 		}
 
-		if (WARN_ON_ONCE(!rde->inode.in))
+		if (WARN_ON_ONCE(!rde->inode.in)) {
+			ceph_mdsc_put_request(dfi->last_readdir);
+			dfi->last_readdir = NULL;
 			return -EIO;
+		}
 
 		ctx->pos = rde->offset;
 		doutc(cl, "%p %llx.%llx (%d/%d) -> %llx '%.*s' %p\n", inode,
-- 
2.50.1 (Apple Git-155)

