Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383888;
	b=qzjzO+UKqYQUIo+ew/U8LTO+yxJ/cvbuN854Qm7KLkquc6vKZLdPtETI8m7LxlsjKLu+
	 oc8dVFg/jH4CKsMQOjmTXp/4TfjEk06UFdy2ZpE7TSjjBOH9X4FMcYEtk82MvbfyX6CfZ
	 ISa6pMVH+vL5KsykPlHhK1iZm4ggFMU/vvvjNfwB7lE7ro0M0vDDiVa4zWUVQ53fgdfdt
	 kzOu/fwiMoz8pJy7KQCitRPAPRqqwRusDSINzREsRaGbndFmz70GUxxdhrm3EA9CX1nCz
	 nwx4OXc6vGGqYLURwtJsth1X7Nzi6dmOgtNpOmlAYnOdHQCrfdKcP4WrUcV9X83R5pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383888;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=18dyxcW33Gsai4KZxKv+IVjtAi4cwLms2RPXNhKC7Ek=;
	b=iuPxd6/qTPUAyd/SvVrFOR2xU80xa5szfiuWoA0qbDKYKWldF+BZqbKvqrMH1vbFRouT
	 Za7Ru6YHKJXhANus+H2P5XIwdMUgeFCG1A47lRwSxmwRpMSJ7/7gCLIBSdImmAp5S6J/g
	 YIrA/GSBcD+7b2YYBA2PpYSMdThNx1N7JByBn5AkkY1wY5pWlu4sen9EkbtS5AJqmFLJ6
	 8uQG+TtEhPwoK5PWoon7SeIxcC5/Qh/+CschU75wAFiVtDIl1/7NezOxexJN9mqwu6Q97
	 7ezYBWkDZQZJMm5Qpw+G4XshVBr8pgKq8hE7G7YZBpZM+6tPaSixcbLXA1mvoA5FyJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545AC606A335
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 545AC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from XA1730-0357L.amlogic.com (10.88.19.140) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 23:58:05 -0800
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
To: <stable@vger.kernel.org>
CC: Joanne Chang <joannechien@google.com>, <stable@kernel.org>, Chao Yu
	<chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Jiucheng Xu
	<jiucheng.xu@amlogic.com>
Subject: [PATCH 5.15.y 2/2] f2fs: allow pinning empty compressed files
Date: Wed, 11 Nov 2026 15:57:52 +0800
Message-ID: <20261111075752.1381-2-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261111075752.1381-1-jiucheng.xu@amlogic.com>
References: <20261107055847-failed-5.15-a64a3fec11e7@kernel.org>
 <20261111075752.1381-1-jiucheng.xu@amlogic.com>
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
Content-Type: text/plain
X-ClientProxiedBy: mailsh.amlogic.com (10.18.11.5) To mailsc.amlogic.com
 (10.8.11.35)

From: Joanne Chang <joannechien@google.com>

commit 2eebc31ae5f53e1066bb6238c8087c23b688ad17 upstream.

Commit a64a3fec11e7 ("f2fs: force out-place update for all writes on
compressed file") updated f2fs_should_update_outplace() to always
return true for compressed files. However, this function is also
called during f2fs_ioc_set_pin_file() validation, so pinning an
empty file with compression enabled now fails with -EINVAL before the
compression flag can be stripped.

Fix this by guarding the f2fs_compressed_file(inode) check with fio in
f2fs_should_update_outplace(). This preserves forced OPU for actual
compressed writes (fio != NULL), while allowing f2fs_ioc_set_pin_file()
(fio == NULL) to proceed to f2fs_disable_compressed_file(inode).

Cc: stable@kernel.org
Fixes: a64a3fec11e7 ("f2fs: force out-place update for all writes on compressed file")
Assisted-by: LLM
Signed-off-by: Joanne Chang <joannechien@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
(cherry picked from commit 2eebc31ae5f53e1066bb6238c8087c23b688ad17)
Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b8da6784e2c4..4b47d7316d4c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2675,7 +2675,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 	 * If IO comes from compressed write path and fallback to raw write,
 	 * force out-place to prevent metadata-data inconsistency.
 	 */
-	if (f2fs_compressed_file(inode))
+	if (fio && f2fs_compressed_file(inode))
 		return true;
 
 	/* swap file is migrating in aligned write mode */
-- 
2.55.0

