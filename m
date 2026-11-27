Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799300;
	b=zRD8WN8mIIWTjJjZAmgc9mN2JXBNSeTFL1Lnx/VK+dylQTTe1lBvTzazRUoE6vKqaJIT
	 X4ed95mgdOJ0iS375j9EwMXAQkR5Xc2eD1VOQjTvi31KMiSobBQSQC4WwkzxzAfr4NatM
	 oijjw7Oup9MLtUEzdXweYYjHx8aCry8FRghkgmIsxXMTfVsuJDyeRdWArGMrdUknpUFml
	 4v7ALzxRGKjVeFRyndxWWhbRQp/G9xLFRGObWS0KCX9XwdcXy0IrjSpjy4ue16oQlPrV+
	 o4mHplNJ9XQj8m9eUY5/xbpP6HGuWIFM/TLwUHzMgWku3SCnPQiRAyq9lwCju4LHnYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799300;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1veHuZHPhPsOKfLbrnXt41Uj3vw8c/wxAAIxxMwE2qk=;
	b=SKTMFs9aRmFNgayrGubUaIXV3P321/QWAZUMCofbU6FFZ9Gd0O2DmILenpgPQtznawvd
	 LHZqoZljHbwsxq9301IRmwY2C5uC+6+YUG9iMsR1Y8B8jjK35GYn6tmgp3XatedYzAnIz
	 njG/YTCUch6RPoUvkcOy2p2E3lKgBvpA1vg2NDbThNtcQ5MeP1ytIYsBD+tPVn5+51+Um
	 PKYYfyo2ZKxCNXzREGVzOSfuIyJX0vkR1oHwzw4LTtYh2DoRj5REQyGzgqr8qpVWVMP5w
	 cG4JCEmJsHvZKhAj4TzvbPBVpDcpBfxFHTTvQLNq58SFR6/gbDQRaMCk1GraJcLk0Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1HVjRfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A74606A324;
	Fri, 27 Nov 2026 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1HVjRfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552EA1F000C1;
	Fri, 27 Nov 2026 17:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799300;
	bh=1veHuZHPhPsOKfLbrnXt41Uj3vw8c/wxAAIxxMwE2qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1HVjRfCQiOCvZQmfp6w7ic75/7qCay5TJNmSHyEjzbsPd9ppKlbcQEgaGBscpCLF
	 yY4uHuOLNkqPADCjDy+Z8A9BHZ3onVhBgK88m/Cesv8LDCJzSEo1QGOGbsDWsOGwAt
	 UavaJ94gso/ukqyn7RTpBhK9dgO6gtKznxsh28LO7Xz0+6r6np2uLKga3n4KWASNzh
	 lwqirCEbpd28zFNCXzD+WT7zZG0m8zgYstHr96LRdjCz3BXpZy7x0L8t1CTkBdZ1Tf
	 J2c2qxLDZ9SmW3b7jiYDKlPqOT202diMrnju1xz6wqGvyaPkEnFDRf65lOahAwCasK
	 l9/Afft10VGtw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Andreas Gal <gal@cs.uni-magdeburg.de>,
	Vojtech Pavlik <vojtech@ucw.cz>,
	"Zhang, Jun" <jun.zhang@intel.com>,
	"He, Bo" <bo.he@intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 09/10] HID: debug: Hold driver_input_lock while dumping raw report descriptor
Date: Fri, 27 Nov 2026 17:06:27 +0000
Message-ID: <20261127170712.3163443-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127170712.3163443-1-lee@kernel.org>
References: <20261127170712.3163443-1-lee@kernel.org>
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
v1 => v2:
 - No changes.

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
2.56.1.839.g22a8290db9-goog

