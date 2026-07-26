Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F83D5645
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785083990; cv=none; b=KdLwPBeqphElfCl2zaXfXUqYhSPhWkfZv4S5A5d0NGVXnh6WIhzYgtWqjGkG0WCAHZh+VnGfvC0uXgbaGfqnyI+kEB5KeDgcHQph3tjDsjt9atffNQf/Fp1yVMhxW2BqsCuXllkjWPa3ppdkv6eq0bS9rAAjkp/upoz3sxkEm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785083990; c=relaxed/simple;
	bh=/o8+MrMMQvKW6YIZmjb761BoFGL4U3Ayo85FrEdwgpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyRCATtpSMvODqqnUT9dB3EmdzpEgLNMWMDU7YzDIjImrNvp4d+DifYw40HnyxhfGdCNQjGdlVnYJyNgxGyRKTfhdsrNUy5WNzZSjZ5CGZDCjvTHh/M0lsA9eitQxARQh4UEU7YIThTXrrK9Dy9hn0LHqRIaGJKb9qc931xNwes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=kkjs8EzL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="kkjs8EzL"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cae1a3a744so14529615ad.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785083988; x=1785688788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LvWcAyC/LEkvD+saSCcPsZJV67914bEAZIKwiD6urdg=;
        b=kkjs8EzL2rUmUTwKqSS6+W4PMu9VJTADPu+D5HqB1QTo3+vj7Eq9xi7MYeI6re/uYu
         mGeUgO6lF68aVYfbtPvSWdB/LoovVDdQFqCEKRYEx8/ONNUGMehLQi6MSgjWdvdCzpg1
         tD0gmrx3TG1YhFqQls6LCOBSzlVPUHyGuqxG1DTDMrjb+r84Y2Khe3XQ9RcFIZoFPOe5
         O4cPrrqsxiGQX/+EQob1qbLzQdSBg/EY4HySb0jeasJGaHOGDpGBrltIELY6XzpwmGzr
         oi5mvfKEAeyATN4sz9opIyIsoveo9R+FpJer+acIb2K8wAVG9dyUpruq3Aj7P8A86usG
         2qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785083988; x=1785688788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LvWcAyC/LEkvD+saSCcPsZJV67914bEAZIKwiD6urdg=;
        b=N94g9R8e2j6xxjyiw8SqtvEZ1Q6G2CMUsVUlm08KnsEPm35mJ0QnBeFCs/s2iS2MS/
         nA0teoO9u8qajeutkKumIkXVGi2oNGRyzT3slYPa7dSVuP9F2+ENdc/EYBmjO+hc/AZd
         HQfqHt415m0RNYPj+15fdBwXkQsY4hX4M1BZyZeXsmdsi8ZTgFVUR5eq5bZ5aQojzHJ5
         ouVvWucKXwcm49eb72E5issgFTRiOsDauGaWAVfm5r3+QTgxLHbR3x9cmvvAcNNZFufS
         JZbqPE2uNIH4raBRo2aunexZhfleB++cVg/qBLT2xsC2bnPX7D217ZWAVppa2dN5FKhy
         5xhw==
X-Forwarded-Encrypted: i=1; AHgh+RoPQfME4wEmpMO+hXePyN8reUjqqk8uReU7PAX0pk72TacZy4Gz5fzFrBshRtwilAFd7pzL4ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAwX8xePltBZgxGcZjYjbo5N+6mLv42Fu+PzYGfVYIOUkq02q
	yAm4i/rfZHnlDUhOaFkQJbJTrIP29HJjHnM4cSsCH50t+6T9T8A4AqYR3N5B9FHG0zHKxEdNdgd
	sQOZ+cbXbfQ==
X-Gm-Gg: AR+sD13l25sQGRh7i4KWNL9XI62KCrEVhNvO+x5AMmtBDMLLhbk1wNJdA+bn7PXGVvW
	P4UhyF4UXxWpfibkQ1+v3kxhCMOPrXoK2cjgpDYHw+BTWiWlZlebE0cW1Q3QWHlWVWPptZdBFqO
	q4LMZQbyWNKr7yl03ZfIUcA4dz6+3knmXq1H4vM74nBixEJTKilzEQSrw09L9bQpG8s5e1UeaFW
	FM3JF7ZAABM/ypYpjYRUYLmsHodNSI8j/ukXChHD76lZCR+AmV4oIWiu4vONCeLPv0Mgt7qXf4O
	WTFlL5sd1Ar74ktH7lzJoFpNi3iByvZJty/4fMe+SewKaSuQdkZqwpVaQ0YLNVqE/g9B+qpUE7C
	Zi/zzuK0+LymhPBsjfWL9jQPx1oePcu7BP4nud7vlhEEhh+9v/L0aV/AEPgVilyB77fiE+FoOwU
	UMQQOz1DbD1yTbIeGCi6Cq2xAQ72s41UDXtFo=
X-Received: by 2002:a17:903:13ce:b0:2c9:e835:ac67 with SMTP id d9443c01a7336-2cfde7c2957mr54494845ad.19.1785083988616;
        Sun, 26 Jul 2026 09:39:48 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:be9c:ea6b:29a7:6c78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde80306esm21514315ad.75.2026.07.26.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 09:39:47 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sagi@grimberg.me,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yhlee@isslab.korea.ac.kr,
	Leon Romanovsky <leonro@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] IB/isert: reject login PDUs declaring more data than was received
Date: Mon, 27 Jul 2026 01:39:31 +0900
Message-ID: <20260726163931.971063-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726163931.971063-1-yhlee@isslab.korea.ac.kr>
References: <20260726163931.971063-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isert_login_recv_done() records how many bytes the HCA actually placed in
the login buffer, but nothing compares that against the length the login
PDU's BHS declares.  isert_rx_login_req() copies min(login_req_len,
MAX_KEY_VALUE_PAIRS) bytes into login->req_buf, and the login code then
reads the declared length back out of that buffer - for the first PDU in
iscsi_target_locate_portal(),

	payload_length = ntoh24(login_req->dlength);
	tmpbuf = kmemdup_nul(login->req_buf, payload_length, GFP_KERNEL);

and for the ones after it in iscsi_decode_text_input(), reached from
iscsi_target_do_login().

login->req_buf is a fixed MAX_KEY_VALUE_PAIRS (8192) byte allocation, so
an initiator that declares more than it sends reads off the end of it,
before authentication and with the length under its control:

  BUG: KASAN: slab-out-of-bounds in kmemdup_nul+0x43/0x80
  Read of size 8193 at addr ffff8881056a8000 by task iscsi_np/167
   __asan_memcpy+0x23/0x60
   kmemdup_nul+0x43/0x80
   iscsi_target_locate_portal+0x48d/0x1180
   iscsi_target_login_thread+0x19a9/0x3350
  Allocated by task 167:
   __kmalloc_cache_noprof+0x158/0x370
   iscsi_target_login_thread+0x971/0x3350
  which belongs to the cache kmalloc-8k of size 8192
  allocated 8192-byte region

Falsifying the second login PDU instead reaches the other reader, on the
same buffer:

  BUG: KASAN: slab-out-of-bounds in kmemdup_nul+0x43/0x80
  Read of size 8193 at addr ffff888104d10000 by task kworker/1:1/50
  Workqueue: isert_login_wq iscsi_target_do_login_rx
   __asan_memcpy+0x23/0x60
   kmemdup_nul+0x43/0x80
   iscsi_decode_text_input+0xc6/0x11c0
   iscsi_target_do_login+0x261/0x1470
   iscsi_target_do_login_rx+0x51d/0x7d0

iscsit over TCP is not exposed: iscsit_get_login_rx() validates the
declared length with iscsi_target_check_login_request() and then reads
exactly that many bytes off the socket, so the declared length governs
how much arrives rather than how much is copied out of an already-filled
buffer.  isert does not call iscsi_target_check_login_request() at all.

Reject a login PDU whose declared DataSegmentLength exceeds what was
received, in both paths that reach isert_rx_login_req():
isert_get_login_rx() for the first login PDU and isert_login_recv_done()
for the ones after it.  dlength <= login_req_len is allowed because the
received count can include up to three bytes of iSCSI padding.

Once the check is in place the copy out can no longer exceed the copy in:
the posted login SGE is ISER_RX_PAYLOAD_SIZE, so login_req_len cannot
exceed MAX_KEY_VALUE_PAIRS and the min() in isert_rx_login_req() is
login_req_len.

Like the existing short-PDU check added by 29e7b925ae6d, the reject in
isert_login_recv_done() returns without completing login_req_comp, so a
malformed subsequent PDU leaves the login to be torn down by the login
timer rather than failing immediately.  The first-PDU path returns an
error and fails straight away.

Reproduced on 7.2.0-rc4 with soft-RoCE (rdma_rxe) under KASAN, using an
initiator that sends the real key=value payload while declaring 8193 in
the BHS, on the first login PDU and on the second in separate runs.  The
reported read size tracks the declared value exactly; 16384 and 61440
behave the same.  Unpatched 3 of 3 runs report on each of the two paths,
patched 0 of 3 on both, run alternately in a single session, and a normal
login still completes on the patched build.

Fixes: b8d26b3be8b3 ("iser-target: Add iSCSI Extensions for RDMA (iSER) target driver")
Suggested-by: Leon Romanovsky <leonro@nvidia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 66435a0a5c7a..064e3353f4a2 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -971,6 +971,21 @@ isert_put_login_tx(struct iscsit_conn *conn, struct iscsi_login *login,
 	return 0;
 }
 
+static int
+isert_check_login_req(struct isert_conn *isert_conn)
+{
+	struct iscsi_hdr *hdr = isert_get_iscsi_hdr(isert_conn->login_desc);
+	u32 dlength = ntoh24(hdr->dlength);
+
+	if (unlikely(dlength > (u32)isert_conn->login_req_len)) {
+		isert_dbg("login PDU declares %u data bytes but only %d were received\n",
+			  dlength, isert_conn->login_req_len);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void
 isert_rx_login_req(struct isert_conn *isert_conn)
 {
@@ -1409,8 +1424,12 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (isert_conn->conn) {
 		struct iscsi_login *login = isert_conn->conn->conn_login;
 
-		if (login && !login->first_request)
+		if (login && !login->first_request) {
+			if (isert_check_login_req(isert_conn))
+				return;
+
 			isert_rx_login_req(isert_conn);
+		}
 	}
 
 	mutex_lock(&isert_conn->mutex);
@@ -2375,6 +2394,10 @@ isert_get_login_rx(struct iscsit_conn *conn, struct iscsi_login *login)
 	if (!login->first_request)
 		return 0;
 
+	ret = isert_check_login_req(isert_conn);
+	if (ret)
+		return ret;
+
 	isert_rx_login_req(isert_conn);
 
 	isert_info("before login_comp conn: %p\n", conn);
-- 
2.43.0

