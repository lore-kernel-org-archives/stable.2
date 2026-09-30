Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75651353A95;
	Wed, 30 Sep 2026 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733067; cv=none; b=CH3/vyv0cimHy7Yeku7s4WYjf5DkBS2aC+Gxj7PyLYeXQNqI8q7HZMzrm7P67NTQFnYiYhEGKHw7TmzlGFQP1OjzBFTwf+4UvZZuE0XMQr3Jd1TfacR90yjMZjE2LHlgJgcvWC1u4VP8UaiDT66NHAVHd+JUmqwcQij7V2O2Xfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733067; c=relaxed/simple;
	bh=lYodqqIK2zi+wad+MYVf2ul8TYMyLpMTsKaSFpb9Nfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDTlAWmEcBVB+rEvg8qlGZUaEcF7y+Gm2YceUhxqPQh9kZyp4P5eoQ3Q7x9hLUOjKAsBy0AdaDCheZXXnH+PQOHrgbSBBX5FleKRADiDPgQxirizxjniZiMrawr2COkbZv/EmgkSSEeN8HbGoeA36JwIVX119LFKPxWZfwNlK2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TN8hMeQt; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TN8hMeQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dG
	XYF0/+7RyhBOmcpBWeq65dCMBAS/MpvEl6ZEWgA/k=; b=TN8hMeQtljTBtGzlmg
	LlqWhGIaSyYoMKRXpbXsFMeFtPASUikKKzjE2HgpbEkmhtbcvievOnt7Q1f8brXj
	fTeQsnStFVxUUTBMfgzBlyHovZzS0gzmLa8HCvRVzeKQrr+GBBrYSbRp3NW34eIF
	tis7W/DIp9bbzjkM+ZIeZ0liw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3tyTharxqWlxqBg--.28987S2;
	Wed, 30 Sep 2026 09:50:26 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Cc: Hans de Goede <hansg@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH] staging: rtl8723bs: fix scan-abort timeout in rtw_scan_abort()
Date: Wed, 30 Sep 2026 09:50:24 +0800
Message-Id: <20260930015024.3627275-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3tyTharxqWlxqBg--.28987S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1rXryrAw1UtryxCrWDCFg_yoW8JFyfpr
	45Cw18CFWUK3Wj9w40y3Z7JFyrCay3GFyUK3W7tw1Yq34kJFWS9rZ8KFy7JryxAr9aq34Y
	vFn7A3W5Wa17GFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/xtbC-gKcV2q8auIflgAA3g

From: Gongwei Li <ligongwei@kylinos.cn>

rtw_scan_abort() checks jiffies_to_msecs(start) <= 200, but start holds
an absolute jiffies value, so this converts the time since boot rather
than the elapsed time. Once the system has been up for more than 200ms
the condition is always false and the loop never waits for an ongoing
scan to finish.

Use jiffies_to_msecs(jiffies - start) to get the real elapsed time.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d18768a51b19..d4beff59f272 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -931,7 +931,7 @@ void rtw_scan_abort(struct adapter *adapter)
 	start = jiffies;
 	pmlmeext->scan_abort = true;
 	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)
-	       && jiffies_to_msecs(start) <= 200) {
+	       && jiffies_to_msecs(jiffies - start) <= 200) {
 		if (adapter->driver_stopped || adapter->bSurpriseRemoved)
 			break;
 
-- 
2.25.1

