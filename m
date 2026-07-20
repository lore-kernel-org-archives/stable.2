Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F6D285068;
	Mon, 20 Jul 2026 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513786; cv=none; b=fbw7U1Mz7ghCcbBzWxLGZgkCU+zxghMu07BqxKhHPbPGRUGflL67JbxKuiffIxaKCKujN1o/A9PJqwzS9ZBA1w+7oOS2cCebOakDkAdLV5BwKtiQCGHiH4oFI3RcUVnXUvMS4O8O5l7Ji6P1qrefOe2vSGegbI7IrhJJmTh7sAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513786; c=relaxed/simple;
	bh=ZgHVEtOq2Rwcq6liMTh2Ia3gDejKXmkZVAGuiDzqiOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIRs/k6lot4oBda/SptIbjd06tUunlAr1tiYNuPCwCeZEl/zzFGwNF5lUcDKiF5Bj5fn2rYF3swwIXM/1tb772aq3JKuRub/5UCYtTHpkUkswFfdeQIQL62+/Y8QUMxaV58b9jDi8hY8Ul8BAuSmloykLkCS1IxTjhNBZkKxmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XCLlAwHd; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XCLlAwHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784513706;
	bh=FnPhHP0vAmPH/HL0nJh6vKsrhj3OLcSDjcZY8qN8cAQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XCLlAwHdt8cHtm3ipXHPDB2M7rAzKenZ/UpSP6UkCR0SZVmhMiddqc0v7hOiIH0Hz
	 I73IL8HEUXBd+uJw9Sw9+gBUcVjXeF1qrPB3qldNjRixyJoSue2aeH88qdLG8Z33Td
	 OwsbwFR6Gx6by5HmO+ExI/pxWuMWj34lQzeSW4Vg=
X-QQ-mid: esmtpgz11t1784513688ta208e4d7
X-QQ-Originating-IP: oK4aREHWhptA46o4dQdQwJLNIQ2+B92IkJZTsIj4V0o=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Jul 2026 10:14:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12807910474211670954
EX-QQ-RecipientCnt: 9
From: raoxu <raoxu@uniontech.com>
To: david@ixit.cz
Cc: raoxu@uniontech.com,
	kuba@kernel.org,
	krzk@kernel.org,
	error27@gmail.com,
	kees@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] nfc: pn533: purge fragmented skbs during cleanup
Date: Mon, 20 Jul 2026 10:14:44 +0800
Message-ID: <2D896607CAE4408E+20260720021444.3362044-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NFNrK8KlcSCR04LgPZlnPCbiPt21agmYF7FhRUiCmQ/i9vd929Lu6d0k
	f9M3uOvTTjZt65sscfJzJqmOZi9UgTyPxLP0YDgJkd/WTJy002jywyboah/+/4BxfSaIAQq
	/JCakQbgKBzKrLEZPOXWSw3dD2vPwdu+n4J7GKpx9NeObjjgnLXpjwT616jd1Z6dVHJ9Vd2
	OUnPumS2RG5TXa7FVtb6T6eotj+ollUOBuvHGKGa5e47ZJEa37sUHyKtotzTHR+tpSjqRLv
	km4fiXzEyBFvFhndsa76wGlu19sK9KxAYI7kXsy/x1SVgWY3qJQgmSjFrgbAJPdZdfMheDC
	QGGpx/fYgiq1wSd8rrio5zffYJErL4jjL2G7ByAc/uo9m2bshW5SZfCAC8RIFG6FqA1A3pK
	Q8Dy50LYfeI9I5apB9ay0ZKaHFS8CnRfPw+5V0ZXa8k5H2cqFSmMG037QNyzdkFpdxlZ/2x
	RTf18zO6qLgjJR8Rqgxxh1tITBCtf61kg8NO8LNrTrAPtTVsQc0h4/YhHpaBoyWVfESFIQY
	a0PhsyOvhJ/DbZzQ5sQ0jSfCHL7XsNqnd67Rg6+qPuWYny8xQNYkqhVwXZKC+EpjQEM2XAA
	atzMboZ2MukZNzZmi3j2HlKQUnFvIzWlA9afVv+G15W0XtYtHNFMB2XdNp5uGo050oeyQsB
	c9JzbNoMoU5HTWr/V4zsRQlnhF1JRS58Qw/LpOW98RsRkF4Sfi5oYqOvV853nWMONJsb3Lw
	jve7vDs8etl/1yOrEBm8H2W+HKCegi6IGloPI5h0ABrf0PqaYkJyIPgo0i1fp2Oh5m/i8pG
	7MvBSTYO5fbe4NtwWx9KgQPI54G5LCudDPuD/YO+UnWZIPJH2kgsJ44aHAxSaH5xuJOWgBI
	b927Tf1scztGXWI+/ix4jQLL3pVUN5F7tD74gH3O8nanwA3W+5fzowBgaRmKdkn42qrppqj
	4Oq2FzUctqkRp0rcMgbEvsi6p3PmGq52p7dUXSJ6dV4GmnpI6+Ge+u09lRWgPgZIxKhxbjq
	BJSKNPX+HcQ5sSpdL/KH4cg3qysvypfw49eZbkyegQIlqS0zIg5SespkItwcY=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

pn53x_common_clean() purges resp_q before freeing the common PN533 state,
but it leaves fragment_skb untouched.  The fragmentation helpers queue
transmit fragments there while sending large initiator or target-mode
frames, and those skbs remain owned by the driver until they are sent or
discarded.

If the device is removed while fragments are still queued, the common
cleanup path frees the PN533 state without releasing the queued fragment
skbs, leaking them.

Purge fragment_skb during cleanup alongside resp_q.

Fixes: 963a82e07d4e ("NFC: pn533: Split large Tx frames in chunks")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Split out the queued command cleanup; this patch only fixes the
  fragmented skb leak.
- Add Fixes tags and Cc stable as requested by David Heidelberg.

 drivers/nfc/pn533/pn533.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index d7bdbc82e2ba..6db9ec90f594 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -2799,6 +2799,7 @@ void pn53x_common_clean(struct pn533 *priv)
 	destroy_workqueue(priv->wq);

 	skb_queue_purge(&priv->resp_q);
+	skb_queue_purge(&priv->fragment_skb);

 	list_for_each_entry_safe(cmd, n, &priv->cmd_queue, queue) {
 		list_del(&cmd->queue);
--
2.50.1
