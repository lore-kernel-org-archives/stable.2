Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.106.246.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383690;
	b=k6Vlcp7nerwVgatC31ZdwLCewSHW80qAwe/l5ylheHkO3zLDIt/afnRAJWt/SMD6EXZM
	 0Nl5hWFElITB+jtkK0mmzEI1J/9B8RIoLwmzFC+45oHTAG3Wpd6HZERcn4Lxs6x7D/C3V
	 zQvVyUCpRL1Z6L2c5HBI/qvRUWaRWSJVJEOe2HcoU6hHWkTuR3h8QD0LK61FNw761698/
	 ST7LlvNXkv4ZiDhPIHtcKOtLCAGqrwq/kyM/JJ/OjQu+E8kXWPEti0jvqJay/FypHRBW+
	 Ck6WX1paR/v5waFYkSPmO3VwqBwRbT88kpQ4Bb5/gCnd4Nt+0rViMoHw/gqjKkufjAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383690;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=IUWQzLHvxHkgnIqpVU/SEUTYF/MpK0GU+njYZcUM+pc=;
	b=s3M9aCBRgGiaKjCGTImQKTPy0GtmzTylyilg2O5/T/LtDwaY9VsF/TSoh71P+TGwez5h
	 Iupl94Z9z0EjFXEddPmm+VGmQWzCDMhYRVVE2Oc+hWqaDWFP62NxPH6GaFox1prTJJfVP
	 QzxMJY47IPl7tU3TLMjBK5k9off3O1iiX8lRLdW0zPRg3IJNOAQMh6zjZikQu84LnVmWh
	 SdHDBSY1oPVBpAnjB2gRf+1ZvcaWulpSXa2vXJldUQBC42dGSNt4+wZC90Jmeb2KXMd0h
	 zhvvhZAxHra/pUswSFW+EUg+xo+uYgE5Z7FpY+94dPhvBioGMCmnaRJWD5tTNg+4BDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	arc=none smtp.remote-ip=64.106.246.77
Received: from mailsc.amlogic.com (unknown [64.106.246.77])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD66606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AD66606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from XA1730-0357L.amlogic.com (10.88.19.140) by mailsc.amlogic.com
 (10.8.11.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 23:54:48 -0800
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
To: <stable@vger.kernel.org>
CC: Joanne Chang <joannechien@google.com>, <stable@kernel.org>, Chao Yu
	<chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Jiucheng Xu
	<jiucheng.xu@amlogic.com>
Subject: [PATCH 6.6.y 2/2] f2fs: allow pinning empty compressed files
Date: Wed, 11 Nov 2026 15:54:02 +0800
Message-ID: <20261111075403.1299-2-jiucheng.xu@amlogic.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261111075403.1299-1-jiucheng.xu@amlogic.com>
References: <20261107052913-failed-6.6-a64a3fec11e7@kernel.org>
 <20261111075403.1299-1-jiucheng.xu@amlogic.com>
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
index 65f933d24fe8..435eaf4f7547 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2634,7 +2634,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 	 * If IO comes from compressed write path and fallback to raw write,
 	 * force out-place to prevent metadata-data inconsistency.
 	 */
-	if (f2fs_compressed_file(inode))
+	if (fio && f2fs_compressed_file(inode))
 		return true;
 
 	/* swap file is migrating in aligned write mode */
-- 
2.55.0

