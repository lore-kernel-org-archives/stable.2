Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB733D4E5
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055997; cv=none; b=GFIbamAHg4cdWmER0KTNm5pDEJ4EJopF5eF9f0gLHdSlQqSQ+ppi7LNtlS22jTwRKQzejkcYVpHnd+ByyxvW3nd6r45y1iA66RuBfN3AU+p85xmMursWJ/Gxy1bNeaIAefVx69B78NNJulWReMx5aBBnjHsj9rzZXNbeg3VCIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055997; c=relaxed/simple;
	bh=WY+/I3PCWDW0D7KQP7ETeSQTyPJIDlAn3sHacC1niIM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RGS5IeMc7QgvPuhhVEKUyf7S4GXNpuJRaSd95l/E1HaouxjY3eNuhls3oZtBpefFgFPKN6/+MIyykWA9EmvzklTrn6oDbjXe5aBiZ8DlEGRVLZ8GFDXfs4UvBpZvXue3uvAJEGQmc6vk3L5+VzAHSMOIelrup4AaQUFsx459Pak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2P30bPR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sonalipradhan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2P30bPR"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37ca4367860so1629420a91.1
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 22:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783055989; x=1783660789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bMJVyVv7LxWaCV6bTjHr7ZvWMrD8Vg6RvcBWgEOqFjo=;
        b=j2P30bPRsIZHjBYzUs52FdkYmoSu2Io7rHZxAL/pHGajDR86MXokkUlsIHdFUKOA5W
         OCMdRUF9FA0ZqdmBSmOB7BS2mgPX+3T2VlD//Dc0qG1qYaEmAwS+G0qhJzGF01vgB7SL
         LkLRWhBhz05eSsUc0skmsLA4ExhynIUX7kTe3Vu+/FbSPHxR17ZS8mZoDZVD1S4fLWKi
         Z3cHiCJaGW9TF55AxzUV8GM/Lo9gDqYlcQeUtZLfh+arkWpg/Rss/eczQRtrd/7RUFL7
         j/F5f2Ig6IvS15hCUatOWpydnvimCQBqEEgme/c8VzMh/LYidHH/rLAsyCqHK51gzfAM
         gNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055989; x=1783660789;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMJVyVv7LxWaCV6bTjHr7ZvWMrD8Vg6RvcBWgEOqFjo=;
        b=Jo03Jv17PC6CyS37ogcAv4uVhJfRQ1+jOnQiF2+nil0OJvW2Z4ikpRnuH5p4Awf5CK
         8qmhnX551FyhE3j1zhYYicE8G+UxkQiMX7XCGTqi5YyliTBYFK72UMNBrVrhqQMmbFfh
         IUJtL3VpSrdxrA7iBDKavbBonEgpvV3MlL3g+DgMu0ZueVwomCoFFqMYljwvTu1tpuOn
         5taSEwy59s3tIzD6TeE7tjo89hTk8te/5GalIQ0XVbmpL61nM8DZtMWDNUqW+2ODH92Z
         gEfI2hqxIxF+MUTF8OkZ9qE72H1KcTk4DCXyfoAXm1R0ZwZyKCNeT1mPbp9q2fg55J13
         2HxQ==
X-Gm-Message-State: AOJu0Yyn+xN9RFgGKcuDqam/beRDM4tihWsImNdiluxrQtze91QNPFFs
	ouMgL2xFNpq0gb9qWvWLKkmbnM9EWqilBpQFD7vvFwYkKW2eBoaVbn13Xz25/7gAvlOGK2vqZCh
	A75lUQh7d5s/W2cQKxVHtcUsnQMjGDt08Ug==
X-Received: from pjbay5.prod.google.com ([2002:a17:90b:305:b0:37d:87a0:e7d1])
 (user=sonalipradhan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2888:b0:36a:8254:8eb1 with SMTP id 98e67ed59e1d1-3811209e3c2mr2502367a91.6.1783055989416;
 Thu, 02 Jul 2026 22:19:49 -0700 (PDT)
Date: Fri,  3 Jul 2026 05:19:45 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703051945.1691028-1-sonalipradhan@google.com>
Subject: [PATCH] usb: gadget: f_ncm: validate datagram bounds in ncm_unwrap_ntb()
From: Sonali Pradhan <sonalipradhan@google.com>
To: sonalipradhan@google.com
Cc: stable@vger.kernel.org
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

