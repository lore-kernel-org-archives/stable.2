Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5BA3C553F;
	Thu, 24 Sep 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260192; cv=none; b=poKZSX/KYJJZcPuHAKdUquFXRXC7ZqVKCMOaZAa4t0Z6d/SZGBb2OPElF6EjAGk7NcGChWNQ/zhuFah3ysE9qf0MRtg7+PCypcRl6MTmZUJYtYJPoS5GLJLLrjBIRDwEKNuNfzGAInoRNrLCBDK8W4QcabJBDuYSyIqd4+XKbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260192; c=relaxed/simple;
	bh=aIF8GhYWNTZc3bLCu06pZTzT38Gtm5V5gwlXiwekpPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjtaI38M3aDWrTIVwzqPQ+fvsTpE+VG6wRJ9n39jzEHee5+kFO3iC1QqfY0aLbfE5hl5emV6uZjRJa8i1nq6e9rwuKh2KpYQigVj/Y8BgQip7G2sciq5hYOmlV2xi848awJQggiV+4Inld0OLOotK9l3ftwERYwhL2CzqA4OVoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=c+/wubk6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="c+/wubk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vV
	vw+9asavbQ7qXXrMVuoGe62DYH6vZCRBRWPjd86b4=; b=c+/wubk6ZwUq9efGXc
	eJQ0XtTfAS7q5rJKnm+Up3fq8wMLL7EtgJY/QW/YOc1WmPU0bHSITtDrK35n+B39
	SwnHve2dxMFslr/yN9idOPitY7QIywYUghlx7iwr0ADgghEjFTFi763gLJUD5vFt
	Zjhs4yivWRmtCTO8Kd+lm+cPI=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v7zAM7VqMhFPAg--.56297S5;
	Thu, 24 Sep 2026 22:29:29 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/7] HID: roccat: konepure: reject short button reports
Date: Thu, 24 Sep 2026 22:29:13 +0800
Message-Id: <20260924142918.1177952-4-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3v7zAM7VqMhFPAg--.56297S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF47KFWkZw1rCw13WF4xXrb_yoW8GrWDpF
	ZIyFs0kryUKr45K3y5Ww1UZa4Fvr4kXF47ZF95Ka429r1YqFyDZFy0ka4jqr45JrZ8KrZ7
	tFs0van7Ga4qva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRCJmUUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AkHQWq1M8mr8AAA3B

The raw event callback runs before HID core validates and zero-pads the
report.  It reads the report number without checking the received length
and passes matching data to roccat_report_event(), which copies a complete
struct konepure_mouse_report_button.  A truncated report can therefore
cause an out-of-bounds read and expose adjacent data through the Roccat
character device.

Require a complete button report before inspecting or forwarding it.
Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw-event length validation to hid-asus.

Fixes: 8936aa31cd5f ("HID: roccat: add support for Roccat Kone Pure gaming mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-roccat-konepure.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index 7f753dfc2a10..529466c33bf8 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -181,6 +181,9 @@ static int konepure_raw_event(struct hid_device *hdev,
 			!= USB_INTERFACE_PROTOCOL_MOUSE)
 		return 0;
 
+	if (size < sizeof(struct konepure_mouse_report_button))
+		return 0;
+
 	if (data[0] != KONEPURE_MOUSE_REPORT_NUMBER_BUTTON)
 		return 0;
 
-- 
2.34.1

