Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5663CD8D4;
	Thu, 24 Sep 2026 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260233; cv=none; b=NqzRYuGHGIedeqbG0dsnh5rFEostUUtYfbu2aLismWKdegx82Wxd6KcbSiyJbkPbyOelmOFAyd2uKWj9AsWHhdpnKWHYV4liUjvjqMBXSnEFBaqgpzKCgRgB8sUyC1PwjZCmo3RZrP6Tfwv9G5zN8o2tvLRnSRa7rTd/a6lQ6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260233; c=relaxed/simple;
	bh=zQgxY+TnzAu6jpq504S6FuF+f5qhxzsKFW0Gm/uo7aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XsMx5oEzB1ebTKBxQ4jRCXe7TxqZd7FMOF4Pofyz1crH5L7g+E2ucZXthpITIEvfXw4fMTnqUZewNL7uUrwekXHEHMD2lKXSxNKdv3KPgAGlnca2vWWsDx0zgIdGyl1DP25kg8d+wFrXQG2N5ZLIYZhAiKmhi28f+NnQdJYclA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RepvldUt; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RepvldUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ol
	orFO89hiVRsXudesfQMoYxJeuKC8K4eo7Mr+e7mnE=; b=RepvldUt96Zq2hD5HY
	NI5fcHsKmRB83sCT9tSDxlw6zSEZpnckt/LLH5i11FklZDHXsZvZBSNMRLXQFRiR
	LE4OVW7LMDDbGvGQ3b73dR2j8o6Py5eRHqM/hbtf92uqLgdMTR3EjI1ZZQlgaydW
	TlLwMqlWz2JMznfgGbEX/IUJc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v7zAM7VqMhFPAg--.56297S4;
	Thu, 24 Sep 2026 22:29:25 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/7] HID: roccat: koneplus: reject short button reports
Date: Thu, 24 Sep 2026 22:29:12 +0800
Message-Id: <20260924142918.1177952-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924142918.1177952-1-yaojiale02@163.com>
References: <20260924142918.1177952-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7zAM7VqMhFPAg--.56297S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7JryDuryDGr18KFWxJw43Wrg_yoW8JF13pF
	ZxCFs8KrW8Kr43GayUXw1rua4Yyw1kXFy7uas5K3srZw1YqF1DA340g34DXrWUXr45KrZ7
	KFs0vw1kXFyq9wUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRbtxDUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wUGQGq1M8WmKwAA3I

The raw event callback runs before HID core validates and zero-pads the
report.  It passes the buffer to helpers which inspect data[0] and, for a
button report, read the complete struct koneplus_mouse_report_button.  A
truncated report can therefore cause an out-of-bounds read.

Require enough data for the button report before calling either helper.
Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw-event length validation to hid-asus.

Fixes: 47dbdbffe15b ("HID: roccat: Add support for Roccat Kone[+] v2")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-roccat-koneplus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index f80a60539a96..df39868d7e6a 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -523,6 +523,9 @@ static int koneplus_raw_event(struct hid_device *hdev,
 	if (koneplus == NULL)
 		return 0;
 
+	if (size < sizeof(struct koneplus_mouse_report_button))
+		return 0;
+
 	koneplus_keep_values_up_to_date(koneplus, data);
 
 	if (koneplus->roccat_claimed)
-- 
2.34.1

