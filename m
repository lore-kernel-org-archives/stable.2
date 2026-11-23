Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449170;
	b=QDeX0bNQdcwSruQFRsRbbX4DXD8d6vijJQUti78ZC/wCv5vj4XZs+gRH+A51U2zB1YJP
	 vmYl+X5Yu3kSrlD1WDIz/WclZoPs4T1UojKA0WgjJBgs7866Z5ylRLZR27bBIRmcdLbHV
	 p/j1LP582SAqP3VxhVKFvHIT/pAOx/coiuWOPOkAOprNS/UNKHKS+GPncNl3gydoU65Xb
	 dnHf+Go6rZjHU/Z7Actf1aNSCL1lU+Qb2QbsKrCXlo9B/d/B7DYeAgEDadvrDHR7P89km
	 y57/gBc5L8mXkGHdBO1teIFp8pXYQQ5v1MXMGOXnvKhM2ovsESV/pfLnNfM5O1DP9VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449170;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=k8rF/ZxvHVGoqlNnInPhIlRC9B636la7vmqkeuSHtkI=;
	b=Qu31atFQLBWFf14ppz1SdYNpAQxwAeIbxqZ6/RP9+yDo8RMok1P/bnsqmaqHY0tbp4IO
	 KTojA52DhJIS5YXrCM8wU0V5KlY+DoisatPJt7ih8dEeTYt3yQQSrK1b6SSEl888J9oyL
	 mQ7K2oP94XmJNOumRVu9bYa+prxSu93c298BV/XG+Rk1rD9Dko05KgA+Ntw9BtK8EKdmV
	 s7j8dwRtim1vhRXPhWVUCWlg8LJbfLSen8D5xsX0NkgwzPyfzdz/y+paBT9bgVD+Ohrm9
	 0xG0+QHVkXhZYqnzY3S7NycI1YdvdhbCNfV/5BdkMvxuhkWRGzRK4D+afv4x2BUJeUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZVYoAzk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C530606A327;
	Mon, 23 Nov 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZVYoAzk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7CF1F000C6;
	Mon, 23 Nov 2026 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449169;
	bh=k8rF/ZxvHVGoqlNnInPhIlRC9B636la7vmqkeuSHtkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NZVYoAzkCu8J7J0psuvLW7JpybEEGdw9rPZUhwJu3XRpcBeapwcM7CiCYdTNJPbzx
	 27YPfmYDH4tvCoSrVNNO4UMYkobzFismkRoNMbvlxFOuM3hMVNmEmtlmLH7t+TyLeo
	 BUnIGiE0PE9CXkKubNEwCRRS0jzn/VTU5FgBlrD4Oxm3cA1BZ4FsYFe4sl6+SBrWDA
	 0t/Te1qt1G58E3mr0d0dSbYRc0j+hFOhr5A6ctrrrtZ+t12jSngQJuYo+QFqcp/0bn
	 MXLZ5UuZoxJscvYHZ3CjqIRZeqQVlsYAfR+lMaQtQHXnlywHFAP4FDZeW8UwIKDYU3
	 t2VXEuqT7tOaA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Andreas Gal <gal@cs.uni-magdeburg.de>,
	Vojtech Pavlik <vojtech@ucw.cz>,
	"He, Bo" <bo.he@intel.com>,
	"Zhang, Jun" <jun.zhang@intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] HID: debug: Hold driver_input_lock while dumping raw report descriptor
Date: Mon, 23 Nov 2026 15:50:53 +0000
Message-ID: <20261123155138.2907049-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123155138.2907049-1-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hid_debug_rdesc_show() reads hdev->rdesc and hdev->rsize and formats
the raw report descriptor before acquiring hdev->driver_input_lock.
When a HID driver with report_fixup() unbinds or HID-BPF reprobes the
device, hid_device_remove() and __hid_device_probe() free hdev->rdesc
and hdev->bpf_rdesc under hdev->driver_input_lock while the debugfs
entry remains accessible, causing a use-after-free in
hid_debug_rdesc_show().

Acquire hdev->driver_input_lock at the start of hid_debug_rdesc_show()
before reading hdev->rdesc and hdev->rsize.

Fixes: cef0d4948cb0 ("HID: debug: fix race condition with between rdesc_show() and device removal")
Closes: https://sashiko.dev/#/bug/linux-31c0bbf2-e4e7-41e6-ab3b-0d17dfe45389
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index f44e6e708404..56207dea4aa7 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -3654,10 +3654,15 @@ static void hid_dump_input_mapping(struct hid_device *hid, struct seq_file *f)
 static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 {
 	struct hid_device *hdev = f->private;
-	const __u8 *rdesc = hdev->rdesc;
-	unsigned rsize = hdev->rsize;
+	const __u8 *rdesc;
+	unsigned int rsize;
 	int i;
 
+	if (down_interruptible(&hdev->driver_input_lock))
+		return 0;
+
+	rdesc = hdev->rdesc;
+	rsize = hdev->rsize;
 	if (!rdesc) {
 		rdesc = hdev->dev_rdesc;
 		rsize = hdev->dev_rsize;
@@ -3669,9 +3674,6 @@ static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 	seq_printf(f, "\n\n");
 
 	/* dump parsed data and input mappings */
-	if (down_interruptible(&hdev->driver_input_lock))
-		return 0;
-
 	hid_dump_device(hdev, f);
 	seq_printf(f, "\n");
 	hid_dump_input_mapping(hdev, f);
-- 
2.56.1.750.gf70dc682cf-goog

