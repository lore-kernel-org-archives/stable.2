Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8B2E7380;
	Thu,  6 Aug 2026 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978641; cv=none; b=obUr3bVhgZeii1AZFnwUTcAhXx2P4+hsMiPNp//CHCvlGs5+GP0Hh3FXOddVdJnPYD1BZ2211jolhHsAUayJNKBUAJfP78O7KIdGZ5flE+sO23OExMfQdGa4zG81uWn7dtndFWRlitiuJrmRjL3jR8dRWp4OhmgdUcaLfyo0P+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978641; c=relaxed/simple;
	bh=iO0/RNGDsoBrusjjqMEfjS2xD1Gh/6lSjGGh2TJJlbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EK9j7mVema+bCWuREUQmlrT3rZgt81bwSeVSkqerUnViWToZIox86OsvFYxOh7wLVg/femVDquA05uhGkaVdFRzpU7Hlz9k5S40bLSWCQMniGZC0HmMYLAM2GVgXeMbwqbJkXBuibfd5FoXA/uP22bhHqwT5FTSGh0WLMnWPn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XScSEJ66; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XScSEJ66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=G0
	ow5W0uSGuZWxs9MYWa46XNBysZkCZarO77EvWlPdA=; b=XScSEJ66OtIhRnF0Xg
	11SMKZthS3A1yFxeDQPtCgWAhtZ4wVkgRBuwoNMjkswQY5hDMkr8KKHozMU//QMW
	ozuYv1lKYhNm2hSHSlHq/LGzaSk4HkUsfc+/9D2fdS6XClvaK0IqdNFtJfF1YUL3
	1lZ45cscx9sOXivqJ0G8Pgp8w=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXW6va3nNqLxe2MA--.82S2;
	Thu, 06 Aug 2026 09:09:49 +0800 (CST)
From: kensanya@163.com
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] ACPI: APEI: GHES: fix ARM section length accounting after header
Date: Thu,  6 Aug 2026 09:09:44 +0800
Message-Id: <20260806010944.32384-1-kensanya@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXW6va3nNqLxe2MA--.82S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF47Gr43ZF1UKr45JF1DZFb_yoW8GrWxpF
	Waka4jkrs8GF45Kw1xGF42va45Awn2kay2k3sIy345uF1rCF1YqFnFgr9Iga4DGFy8ua1S
	qa9FyryjvFWDuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbCwR1mQmpz3t0xWgAA3J

From: TanZheng <tanzheng@kylinos.cn>

In ghes_handle_arm_hw_error(), after skipping the cper_sec_proc_arm
header with (err + 1), the remaining length was reduced by sizeof(err)
(pointer size) instead of sizeof(*err) (structure size).

That overestimates the bytes left for cper_arm_err_info records and can
let the parser read past the CPER section when err_info_num is large
enough relative to error_data_length.

Use sizeof(*err) so the length accounting matches the pointer advance
and the earlier sizeof(*err) size check.

Fixes: 87880af2d24e ("APEI/GHES: ARM processor Error: don't go past allocated memory")
Cc: stable@vger.kernel.org
Signed-off-by: TanZheng <tanzheng@kylinos.cn>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
v2:
- add Cc: stable@vger.kernel.org

 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..e6362da72d15 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -576,7 +576,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 		return false;
 
 	p = (char *)(err + 1);
-	length -= sizeof(err);
+	length -= sizeof(*err);
 
 	for (i = 0; i < err->err_info_num; i++) {
 		struct cper_arm_err_info *err_info;
-- 
2.25.1

