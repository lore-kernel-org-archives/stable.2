Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C73E2740;
	Fri, 26 Jun 2026 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474801; cv=none; b=YkBUAtAbm+r4qXsO+VOlbwiUt8nMO/kZsrNi7ClQI4pTDAMc4rT8K2DI1aKJbn82PVVkEGrB+4yLdRRze/D9F/PLYHRV+vgmKbrhbp4nLOYrphn1dVM+KdbOmGkNka1VA0yLOdhT/MvNBwZwLcC9jChC3QOuA5OS6KYA5UHvi3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474801; c=relaxed/simple;
	bh=VxoEjYzoONNs+Ms8CrvPp7J2Kwzmc3+dYlq8ToY3wyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NhdnbilwTg7SJYWocn0TIbusKPwt1BMEh6eDyTAA8soksr4LvZfwGgE1GOHROqpxn+fuSyuz1BJsqSrheFybUZgygRyCB7au0NR17IwEdqDtAekjMBy6byeEICJ8M1HgpJQNtgrQIqmaSb4fRMtPcDO3aUC8prfaBc8ESNeYXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowACnANQpaD5qr8RmFQ--.1466S2;
	Fri, 26 Jun 2026 19:53:14 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: net/bluetooth: iso_conn_del: extra iso_conn_put on iso_sock_hold   failure path
Date: Fri, 26 Jun 2026 19:53:12 +0800
Message-Id: <20260626115312.33528-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnANQpaD5qr8RmFQ--.1466S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFWUtw1ruw47XrWfCw1rWFg_yoWkWFX_uF
	1ruFWUZr1UXay7uFsrWw4UurnrG343ZFs7Jw4kGrW3tryUKr42ga48Wwn5Ar9rWa15G347
	Cwn8JrZ5ur4xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5oGQDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4KA2o+TZNP1QABsf

In iso_conn_del(), iso_conn_hold_unless_zero() acquires a temporary
  reference which is correctly balanced by iso_conn_put() at line 279. When
  iso_sock_hold() returns NULL (sk == NULL), an additional
  iso_conn_put(conn) is called, dropping hcon's reference to conn too
  early. The caller (e.g., hci_conn_del) will later also iso_conn_put(),
  causing a double-free or use-after-free.

Remove the extra iso_conn_put(conn) on the sk == NULL path.

Cc: stable@vger.kernel.org
Fixes: dc26097bdb86 ("Bluetooth: ISO: Use kref to track lifetime of iso_conn")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 net/bluetooth/iso.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3abd8111dda8..99755671e469 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -278,10 +278,8 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 	iso_conn_unlock(conn);
 	iso_conn_put(conn);
 
-	if (!sk) {
-		iso_conn_put(conn);
+	if (!sk)
 		return;
-	}
 
 	lock_sock(sk);
 	iso_sock_clear_timer(sk);
-- 
2.39.5 (Apple Git-154)

