Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3436C5A1;
	Thu, 13 Aug 2026 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609944; cv=none; b=n2s9peVAZOHD7cdvgs/gydBUCt9Ehn8YNxXV+KcNCFcNYbgtUMTfcblh1oelpDQByTGl2VaaTysEehF0ryzNahqcgQGBeoZ5jZD0eK8N7muuKZ2mplsl9CNfKGEuz3QHnkZgUu++M+n6qx7dBhvvIoEEd7KgxK1acb1MgII5Qew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609944; c=relaxed/simple;
	bh=ksBE/OMSMcKCihXy66g6ST4plheTo7XGf3jp/uk3wLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAgbVtQG5qYOMxs6pGP5rGLqkhAr9cRMKi+Ez2IbemZQergHCuosCal7CAUrOd1/SAWzslw69ang6KKeh1fTBQEJP1sZIePHVH6JjfhwmAK8+0r2/yTtfyV6xgo6wMDgNUMPyS0MVv2AeDGwzjdBIulbwWoPEzHskbP6GXd3Kek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GqKm6EEp; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GqKm6EEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786609878;
	bh=FsK82zLoihOzNzCCzhnE18GOgCUk0CsnxHxsOwJz4To=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GqKm6EEpWuoEAOVTqYVtQ8K2XPp6oUROFLOHwhTKzwBDPZsw26YsTQZ0LScJo/TlM
	 oKdjbRNYJUI9rKQp/wRe060pdrdmqq7lsYdIu0OlwoXtOJQvBsRUkyieqOJLIJKKZ7
	 5jlnOIJdP2bFhk/utTUVtioxDQk45BsLKRfuh9LI=
X-QQ-mid: zesmtpsz9t1786609872t1c992285
X-QQ-Originating-IP: qYLxKK4Z842EZ2046ZmAwKA+dtehy34NMw2WWW86RUE=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Aug 2026 16:31:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8233363820908336347
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] nvme-fabrics: fix DHCHAP secret leak on parse failure
Date: Thu, 13 Aug 2026 16:31:07 +0800
Message-ID: <66356C8F993780EC+20260813083107.2078333-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mw6VipVQapeuSjZLBmmPX3Ay9v6K25LxTp8baBgnZijwCJrqD2oZbnAg
	VjeocnKd9VkN1Kx1D+ox4aIX8gjfu2WaFfiaRrJGD9k3lUZ32YdEWBGUPcvmZ2XWt0oj8tM
	LNRynidjV/a9Ksqm3A+/XfcbpylDm99n9Ljkv7NaZlkGBCjMM1i2dVgoILmD8SMjAYYfP/K
	+5GChtynw4Vn+Fub6Q4AKH6LYGE3reRxZAD9UsGweAryHERUNC/GeR0oQqMk2JzQ4xamn7w
	MDbDVjaUbnblOHv6r0W4e0fdQWYr+A3FWL7BUKuAlXRDuukXndASnF4RqAh4E1p4Sc1NPn9
	i4+daQTxKmJpzlMA/RPzEsqwHeKnOZcw/Gv1yQz23lb6w1VpEQtkBLn7mNrlnu2AXTICnBr
	c8krQj5H+FAzk2XFHCYm6XZVJ5diPVPthTUyl/SrMTpDhsQlA7jkf/UA3eEMkNSNtxqahNn
	WAu+7zWwLW3AKGII5jD8cqidxIb79jJJn00WiWfOxA82WFoDZdCbZhv73ZDo6us5IooZjcD
	sOx4q5BEkmkyAZnwQDTv8cMAbJ7o0a3+pLKFo8VFt98bUmlkUmVItP63LEN7J2fsdK/AKHt
	nKHpIECVgvzzekDe4O50KmhGTd8AQDPPluqYHQpFmYERmEleghsaPtlad0DJQKVY02n0WeF
	xRpY0UFXGXedt1Z/lew1LVx9bVZLQ+iDz/qkkzAw9kMtpDLZiRb4RAQPVLOmK/rcd4M8JGP
	o8mIDNJljjK42iHgFR9uPiqfuk4hm+N1X/r2i3qnr3LUKCrj9PmP8UWU9I/jm8eka7bhnwp
	iMtcxHA0CaD0ALoZiSmF3ByWDpHH9FpjebVXJug3yRFLf69tfIdmoJdCG+9lUSh/dmSsRfV
	3jcvXD+ptXnSFM9IyiTWv9Q91G+AbV1yo/JI8uVkk/eYiTgocsCtkX8/clg5i7XxEJJm/04
	99T08kRTUn+ik+9DasNzo/QWHvl+yaV7XX6iI+4m6GOdJwinntNxZxeAHD+izsw12PhmFZB
	gGKMVpDFJ/C0E5yEmSjZUWRXHMYtZqWqim+eJZeMzQcYpegDs+
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

nvmf_parse_options() duplicates dhchap_secret and dhchap_ctrl_secret
with match_strdup() before validating the DHHC-1: representation.

If validation fails, the parser returns -EINVAL before the temporary
string in p is assigned to opts->dhchap_secret or
opts->dhchap_ctrl_secret. nvmf_create_ctrl() subsequently frees opts,
but nvmf_free_options() cannot release the unassigned temporary string.
Each rejected option therefore leaks one allocation.

This is easy to miss because valid secrets transfer ownership to opts
and are freed normally, while the malformed-secret path still returns
the expected -EINVAL to userspace.

With CONFIG_NVME_HOST_AUTH enabled, the leak is reachable before the
required-option checks and transport lookup. No NVMe-oF target or
working transport connection is required; for example, repeatedly
writing

	dhchap_secret=BAD

or

	dhchap_ctrl_secret=BAD

to /dev/nvme-fabrics deterministically takes the leaking parse path.

Free the temporary string before leaving both validation error paths.
Use kfree_sensitive() because the copied option may contain secret
material even when its representation is rejected, matching the
sensitive cleanup used for stored DHCHAP secrets.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/nvme/host/fabrics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..736570b5fb34 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1028,6 +1028,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
 				pr_err("Invalid DH-CHAP secret %s\n", p);
+				kfree_sensitive(p);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -1042,6 +1043,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
 				pr_err("Invalid DH-CHAP secret %s\n", p);
+				kfree_sensitive(p);
 				ret = -EINVAL;
 				goto out;
 			}
--
2.50.1

