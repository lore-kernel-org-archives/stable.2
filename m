Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383774;
	b=QGLhDnk1PeVDRbgvykAMTJFTP6oF0NTbHvbbunibTwNWHr8SGsuC6wmvHoua9kPtoJA1
	 jrdIMct+OhDYEuxX59eyvzVLUJBjmnxF/Y7JWRvWAOFoeRk5NZ80t6zlIVWTOpbgdkglI
	 i71XempRxNIIlbt1EFGlvg2s1orNSbXWzzcehRh1Ah7X1MpRd+WaQo5/Aa9qmrXwmAWRg
	 eQi1K77bsK3zRu7Gt7/CXHYKy4uRyQyOOOlILjJHSmOtFAK9ZQAd4iE9qC9BAonGcLeXK
	 99XRLQgnuwerUu5hwYDEyWIvzI4v5VQJg2LXeVvqlflZcr+ABkfH9UBNtfkaT8KY6Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383774;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=soTvF5CMV1+/h6MRnxANckLsxhy4ExVwHoglT2c1CUE=;
	b=vFazy0+vv3BHF9bUyKgptcZPg5ba7yZvbxXXhTXQZNRbtdFtEIVhiEWxqfL7DQ6jMv3m
	 GKCd0oX6PIaMw6thqdfpXyMJIThWW8MDglWCEYlfXGc6hvFEmyOjmmiVGM65dVt1FCdYU
	 ofAKOpGUArtx1rcsQl/kNxHB+Rb83v8K8ZgcDRhFGiiOsMRJh6C5ZUqGP65JWvtaqU0hT
	 wIERrkaAzI7KzQR6pt+dx1QIClWduPCc7SD7JwIShyouxp5dLMR7nPkBu/8P+aLgPgF0o
	 KkOV1rhMjtf94uPk4Tk/xECnPaT0awAWpP4AnvmnKjZwzMo1iUn/BQUCRVzBWAuKTOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AA60A2607
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F3AA60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from XA1730-0357L.amlogic.com (10.88.19.140) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 23:56:12 -0800
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
To: <stable@vger.kernel.org>
CC: Joanne Chang <joannechien@google.com>, <stable@kernel.org>, Chao Yu
	<chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Jiucheng Xu
	<jiucheng.xu@amlogic.com>
Subject: [PATCH 6.1.y 2/2] f2fs: allow pinning empty compressed files
Date: Wed, 11 Nov 2026 15:55:59 +0800
Message-ID: <20261111075559.1338-2-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261111075559.1338-1-jiucheng.xu@amlogic.com>
References: <20261107054156-failed-6.1-a64a3fec11e7@kernel.org>
 <20261111075559.1338-1-jiucheng.xu@amlogic.com>
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
index 4a0bf44b3a54..c07077f0b56d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2667,7 +2667,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 	 * If IO comes from compressed write path and fallback to raw write,
 	 * force out-place to prevent metadata-data inconsistency.
 	 */
-	if (f2fs_compressed_file(inode))
+	if (fio && f2fs_compressed_file(inode))
 		return true;
 
 	/* swap file is migrating in aligned write mode */
-- 
2.55.0

