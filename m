Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F48348C67
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067873; cv=none; b=UAHbj1SgAFJS8sHMIrpyR+GKOU9m93CdrpSDqxORKdQMO7JBhqqeEfhsaUopjole2P3VRjr7028l0n+9sVwvPYBKIyYJlsCoxITn71gxc0KrmZdZLwK+n1sX26bPffzAU7SRQYhZ7uEmw3Y4CuTVkuTBfXCFWeFOEyzP1r35rCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067873; c=relaxed/simple;
	bh=WY+/I3PCWDW0D7KQP7ETeSQTyPJIDlAn3sHacC1niIM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fSfFLc1f82YWtO7kPXl172yeARHQjGKp5DUpXCoNj/pg+sQqD8parierW43RxgKsNWZGhuqWaFeyPvRtNGEcYJLZrmcD6WbRfz9OePXNL62O6juXLk6TheIUTGd58zgBUYvEErlZt7tTaB7vKk75KlbvVElswY+tbaJGHZ5k3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjMBQ5Fd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjMBQ5Fd"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso651261a12.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783067872; x=1783672672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bMJVyVv7LxWaCV6bTjHr7ZvWMrD8Vg6RvcBWgEOqFjo=;
        b=SjMBQ5Fd92TVJbzyPnZmseuTNNV50oaXO7iObJsr/ov7AZOeoCgUo2lm2UGsc0axZw
         dpyoArVsvZl72oYrZoytk7OxlbvvgFrqmNsMbXn/3k8Sqfo6+KNfj1HO/ZJMgwMtESVw
         KvG8ELkDW/8zWK7xtXXTedMOBH15ZIAmRy+n99690vnpePvJ3wQ1KRRZXD8IXeLVeMqL
         ghEorbgC7BgFkerfLIA/Pap/qgrxl10fP4XJn4lWIUZmoUooNKk3dckdcLh+bFYD1ejW
         m7ZlGvPHc97fp4TEwCOMDq0dEK8+UiU1lJF3cK1o1Aw/Z27pZL1QGd1QZOHEfQygRoTc
         +Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783067872; x=1783672672;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMJVyVv7LxWaCV6bTjHr7ZvWMrD8Vg6RvcBWgEOqFjo=;
        b=eVVsNsVZuG80YVPhRyd8jYdTNApqpJpxpYr4lFtbfT1JGWLjrVeFBuLs0FDNuQCLxt
         dDtFFhp8WUD9bnM9W0b5Ky2TdGzHwAf0Gg0HBow0V0GZlQi7Z7J0XR+r12PZer5GWqwe
         TrryLbGRtWBmQFOBIWqrJHhBGhuD4uups/nCLnAAzyzVnI82rA/xzqTRhqRgZqwBx/VI
         2/CEBHNG3Qg4Z1s+ig77c0hxKiRP7surjI7IGXDERq+dXy/U36ifqbxZf3L8xJg2Y4gq
         QsG5ohT6hmBrOfBkdmD3xOfpjQuNdM21scYeUTp7ht9+KoTIJD/0cGC41DtD0VJ49Tyl
         dVJg==
X-Forwarded-Encrypted: i=1; AHgh+RqJRygErk2aIDIzNHIjnOSGwN3TNpoRr4x0FEYrk5qnZCDZaddh7HZbO405guvXd3S9cZ6Q4zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxytgJJFnHEkXHX8oOnIfgcqmPhFrr0RyW00ynGsOmlVI4TscDN
	SnVZVbiug23al1NehSZnDsT6Ubas+yAEt/7z4JNvQ6s2tqVlHwRaRRHDha7zQJxxxzRVEEQSDbf
	wmbBXUsxI6wJRGJFscqfZta7ejaqdwLMG0g==
X-Received: from pjxu11.prod.google.com ([2002:a17:90a:db4b:b0:381:ef4:4373])
 (user=sonalipradhan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d44f:b0:37f:133a:3e07 with SMTP id 98e67ed59e1d1-380aa0fc88cmr10298423a91.2.1783067871532;
 Fri, 03 Jul 2026 01:37:51 -0700 (PDT)
Date: Fri,  3 Jul 2026 08:37:24 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703083725.1903850-1-sonalipradhan@google.com>
Subject: [PATCH] usb: gadget: f_ncm: validate datagram bounds in ncm_unwrap_ntb()
From: Sonali Pradhan <sonalipradhan@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, raub camaioni <raubcameo@gmail.com>, Kees Cook <kees@kernel.org>, 
	Krishna Kurapati <quic_kriskura@quicinc.com>, Brooke Basile <brookebasile@gmail.com>, 
	Felipe Balbi <balbi@kernel.org>, stable@vger.kernel.org, 
	Sonali Pradhan <sonalipradhan@google.com>
Content-Type: text/plain; charset="UTF-8"

When unpacking host-supplied NTBs, ncm_unwrap_ntb() checks datagram length
against frame_max but does not verify that the datagram fits within the
declared block length. Additionally, when decoding multiple NTBs from a
single socket buffer, subsequent block lengths are not checked against the
actual remaining buffer data.

With these checks missing, a malicious USB host can specify datagram
offsets and lengths that point beyond the block, or supply secondary NTB
headers declaring lengths larger than the buffer. skb_put_data() then
copies adjacent kernel memory from skb_shared_info into the network skb.

Fix this by verifying that sufficient buffer space remains for the NTB
header before parsing, handling zero-length block declarations, ensuring
that block lengths never exceed the remaining buffer space, and verifying
that each datagram payload stays strictly within the block boundary.

Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call")
Fixes: 2b74b0a04d3e ("USB: gadget: f_ncm: add bounds checks to ncm_unwrap_ntb()")
Cc: stable@vger.kernel.org
Assisted-by: Jetski:Gemini-2.5-Pro
Signed-off-by: Sonali Pradhan <sonalipradhan@google.com>
---
 drivers/usb/gadget/function/f_ncm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index c5bf8a448d64..64eabda2f546 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1189,6 +1189,10 @@ static int ncm_unwrap_ntb(struct gether *port,
 	frame_max = ncm_opts->max_segment_size;
 
 parse_ntb:
+	if (to_process < (int)opts->nth_size) {
+		INFO(port->func.config->cdev, "Packet too small for headers\n");
+		goto err;
+	}
 	tmp = (__le16 *)ntb_ptr;
 
 	/* dwSignature */
@@ -1209,8 +1213,12 @@ static int ncm_unwrap_ntb(struct gether *port,
 	tmp++; /* skip wSequence */
 
 	block_len = get_ncm(&tmp, opts->block_length);
+	if (block_len == 0)
+		block_len = to_process;
+
 	/* (d)wBlockLength */
-	if ((block_len < opts->nth_size + opts->ndp_size) || (block_len > ntb_max)) {
+	if ((block_len < opts->nth_size + opts->ndp_size) || (block_len > ntb_max) ||
+			(block_len > to_process)) {
 		INFO(port->func.config->cdev, "Bad block length: %#X\n", block_len);
 		goto err;
 	}
@@ -1273,7 +1281,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 			index = index2;
 			/* wDatagramIndex[0] */
 			if ((index < opts->nth_size) ||
-					(index > block_len - opts->dpe_size)) {
+					(index > block_len)) {
 				INFO(port->func.config->cdev,
 				     "Bad index: %#X\n", index);
 				goto err;
@@ -1285,7 +1293,8 @@ static int ncm_unwrap_ntb(struct gether *port,
 			 * ethernet hdr + crc or larger than max frame size
 			 */
 			if ((dg_len < 14 + crc_len) ||
-					(dg_len > frame_max)) {
+					(dg_len > frame_max) ||
+					(dg_len > block_len - index)) {
 				INFO(port->func.config->cdev,
 				     "Bad dgram length: %#X\n", dg_len);
 				goto err;
@@ -1310,7 +1319,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 			dg_len2 = get_ncm(&tmp, opts->dgram_item_len);
 
 			/* wDatagramIndex[1] */
-			if (index2 > block_len - opts->dpe_size) {
+			if (index2 > block_len) {
 				INFO(port->func.config->cdev,
 				     "Bad index: %#X\n", index2);
 				goto err;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

