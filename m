Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697118;
	b=mmfVKLOuSgDy4ZLf5+VLONb+9QjgPBZW/Au8N21fE+F34F+GOBG0rmwZgZH3Yzv3JN6I
	 tiPbAKfuX1+EZOQ2elUvvmW142mP2oRbag/wcfoLATzdHsqBRH1eCoHRMs4468njUurWc
	 4JkT7c6eJiehdLHNZfocPxdzNcuI0bikbbbE+gxcYd8RkqE096aCmbCWPKto9dyyUtl9A
	 W6Dcy3hPFHkfba7LIaZM4O8/l2L9g/aLo+4zkdsM7atNuiXodX/LlGL/3OtCdXwYry4XZ
	 W4i2mDfpwgpn04LNrazZYRMCdAkgvC8K0pqk0gXsiqEylLXQ/pnUOoBVKjIcy/jTbcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=thwyuo3n71Onu9HUu3z0eZP8Hqsa2f8kijqEmTyQ/Bg=;
	b=JK9IntxT8x687gndg2gT44reubyMQWq2ae+FGiJMFUBKZDyCEElDaT9vpPyHSi6cao7i
	 wvEqe0axub1G3taFbSzIoHNLIMR/buukbaFMuSaObUmVKsrDz+sU/V12ElKANrwLoTGeE
	 OyVUOvmj6mxFz8YlfXW8chSW1s5EoDsEjfF6Re4wDIY/4X281SZ2vRQbV0Ei0F3OkIRPD
	 7P3IKpdInUBW63Ejsap/b6+s5X7fQ/0G6Qv675zHe9psk6KYYbb+Ybz6/rLARr6HTVI4J
	 TzcLIO1zgvVrK44hQ8+qHlw6+jXUINy/084abd0p3HIgK7woPzIPdEro13j0YaSKeMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W3Y0p3sQ;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A215606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A215606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W3Y0p3sQ
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-353804b591eso6884204eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793697117; x=1794301917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=thwyuo3n71Onu9HUu3z0eZP8Hqsa2f8kijqEmTyQ/Bg=;
        b=W3Y0p3sQUr1ElW+VDp0X5u8rmsKzKv/8v1h0mUL4PsQVa8AX6kKKKuCsj17UOlgkyd
         4qeIXkzRer3LaLIwWDiJNCZ6ilrUXpIRCU9YoTpgeiYU+bZNWIrNato0ArHxvJ4+53n+
         1BiqPYQcyTXtWorostK+TGsEvBKCwEZDGIIFSUgNZ+u0UH2gc1U9brd54sTNm5bCRfwV
         dkuQ15s8ji1AaR8U4DICRkrRHbDke7u0sOywKTxrMaUGD2pIIDGlu0UOedyDnpdf8dEE
         dFWvDNN7Ct8i8Kgrb6NujTw7kIyj1dox7ZYUGBZNK2Wd20GZlvIJbCJtyLx0/1WQTkii
         mPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793697117; x=1794301917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thwyuo3n71Onu9HUu3z0eZP8Hqsa2f8kijqEmTyQ/Bg=;
        b=dsbUbaVDJVj4xLe45F8bjmw477rC4sxvgsU4Hdz/ZxNiUcBwCrWACfcaZeksmUFv17
         3iBezsJgWyqAgPTX+k5hZc7pHfDMKZyDBpv3J36xZWh46HuLbDqswYR+xqNqZEJeuELP
         oWj8Q2JHKV3BRc6amrMC+mOJWhrUQUJ7g/5YDHYhbwoG65F5+AzVvZKA/hug6dFKKMT7
         0RjOAdnMC/Y3eGlUiJhD00hhUORpUTlT9W85+I0mgj1IOBVJzLrFScesR5p39Mki2rAm
         QKUM8zvF8dAjBzJd9qc1cjUgWhxGYWhIBDedYIDY9j7uQCjZqlqAcTLtricG78a0pNtt
         8J7A==
X-Forwarded-Encrypted: i=1; AKwUvBwhxcvZ0x1nXzC++OzZNFgLBVkekNnGoeLZlWxgAlUiDEvyOoHfaT7MT5TVVM4cYjQsUDQvo0g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2iptSRT/6XfRSahaVGBFdRyuPZcM/+ykR+TSZDUrJ2AcuMd/+
	N+2nJl8pFBL7HKDbWDqRx8dUAGvxYX48TJBsOCqChgqkJ4onSaevXU3M
X-Gm-Gg: AYBFou2uOZREnVuE/n9mT3KPoOc7SGsCuEg8pKO24S56BDCyGal34qPXG45hFYl/Rye
	K5KDBoJG7D6LvsHKjNMsqPmb7GTLiGUO00Tih68xpHxRuIG3Vev/AXmP2A/p5kPhei+1I1Prt/p
	zh7UyWQJBOfvQNG/Fkw43cywpLlrRaVMNGLYmUyPFD77KaLoxhYGI8v4unto0i1V/duQX6/MPG6
	JrJP7kUSooMUd9F1vTkgMpUtb9bLwV9xedQX0+U+zIByDqUErJu7pnOpFnDlkDsaCypUHAwXlGK
	capWTxBv7DmSYL0Ptf5p0CMDtUFsK7c81MEaGMOg3lo/8FaIskMDZ61nGbKAgwqhvclShowga3j
	LfPlMJCnO4/Mnkj7eNTbHAEr3VyRegkpsQHZhrmKI2Uqy/w/eFP3LqEISoUjYvtYjuq4rUJ/q/G
	fD7iazkW9yOwfyLG+v/n5K4VxoWBgxa1I8G6KU+gn7vhp8udK+lb1IXSoTF3mF5Ck7DDlgHxXBN
	gU9wSMvO4xUGfSU5qbRoB8TbRVPyu0U7M4Plx+W/KXDpP3PG4uHHabaWrH/6WhfnezKBGg2CMl7
	bZUIOoxAmpJ0DuUcnGMBesejp53rr8ccHR4HP5vdbYlF
X-Received: by 2002:a05:7022:7f13:b0:195:76af:b810 with SMTP id a92af1059eb24-1ac5bf91b35mr18860638c88.25.1793697117230;
        Tue, 03 Nov 2026 01:11:57 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:284f:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a504c6sm46128799eec.21.2026.11.03.01.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:11:56 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: Amaan Cheval <amaan.cheval@gmail.com>,
	joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	nktgrg@google.com,
	maxyuan@google.com,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] gve: leave refcount headroom in the RX page bias
Date: Tue,  3 Nov 2026 14:36:48 +0530
Message-ID: <20261103090651.35399-1-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
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

gve's GQI and DQO-QPL RX paths set every RX page's refcount to INT_MAX and
hand references to the stack by decrementing page_info->pagecnt_bias, to
avoid an atomic op per packet. This leaves the page no headroom: while a
fresh page's buffer sits in an skb its refcount is already INT_MAX, so a
single get_page() from the stack wraps it negative.

splice() of received TCP data into a pipe takes such a reference, and the
onward splice into a socket then fails: skb_splice_from_iter() sees
page_count() < 1, sendpage_ok() fails and the send returns -EIO (since
commit 2e910b95329c ("net: Add a function to splice pages into an
skbuff for MSG_SPLICE_PAGES")). tee() of the pipe fails with -EFAULT via
try_get_page(). On GQI the reuse check gve_rx_can_recycle_buffer() also
sees page_count() < pagecnt_bias, WARNs and calls gve_schedule_reset(),
so a task that merely pins a fresh RX page (e.g. holds spliced data in
an undrained tee() pipe) can reset the NIC.

Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do: the bias
only has to make the per-packet atomic rare, so a small value leaves
page_count() ample headroom below INT_MAX for the stack's references.
Refill by adding a fixed batch and setting the bias to it, which keeps
the rule `references = page_count() - bias` intact.

Reproduced on gVNIC in GQI-QPL mode (GCE n2-standard-8, 6.12) and in
DQO-RDA mode (GCE c3-standard-8, 6.12, where DQO-RDA still uses the
bias) with the help of relay.py -- a small splice(2) TCP proxy --
relaying a download while the RX ring is refilled with fresh pages:

  ethtool -G eth0 rx 512 && ethtool -G eth0 rx 1024   # fresh RX pages
  ./relay.py $HOST 8080 &                             # splice()s both ways
  for i in $(seq 200); do curl -so /dev/null \
      --connect-to $HOST:80:127.0.0.1:8080 http://$HOST/file; done

Most downloads failed with EIO before the fix (tee() with EFAULT) and
all completed after it. relay.py is at the Link below.

This bug was found and fixed with the help of an AI coding assistant
(Claude Code) over an interactive session; it read the driver and
splice/pipe code and ran the tests above.

Link: https://github.com/amaanc/kernel-bias
Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Fixes: 58401b2a46e7 ("gve: Add rx buffer pagecnt bias")
Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path")
Cc: stable@vger.kernel.org
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Tested-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
---
v3:
 - Refill when the bias reaches 0 again, as in v1. DQO-QPL is not
   supposed to support XDP at all, and it will be blocked explicitly in
   a separate patch, so the v2 refill-at-1 change is not needed.
 - Added Reviewed-by and Tested-by from Harshitha Ramamurthy.
v2: https://lore.kernel.org/netdev/20261102112613.18334-1-amaan.cheval@gmail.com/
 - Refill when the bias reaches 1 instead of 0 so the driver keeps a
   reference of its own across every handoff. At bias 0 a consumer that
   returns its reference synchronously, such as an AF_XDP socket in copy
   mode on an XDP_REDIRECT from DQO-QPL, freed a page still registered in
   the QPL.
 - Commit message: explain the refill point, drop the build notes.
 - Re-tested on 6.12.113 (c3-standard-8, DQO-RDA, which still uses the
   bias on 6.12): no EIO/EFAULT from splice/tee and no NIC reset after
   applying the patch. DQO-QPL is untested; I have no access to that
   hardware.
v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/

Built allmodconfig W=1, no new warnings.

 drivers/net/ethernet/google/gve/gve.h                |  2 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c    |  4 ++--
 drivers/net/ethernet/google/gve/gve_rx.c             |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c          | 12 +++---------
 drivers/net/ethernet/google/gve/gve_utils.h          |  8 +++++++-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b7ce6e8632db..18d7edbf4b3b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -119,7 +119,7 @@ struct gve_rx_slot_page_info {
 	void *page_address;
 	u32 page_offset; /* offset to write to in page */
 	unsigned int buf_size;
-	int pagecnt_bias; /* expected pagecnt if only the driver has a ref */
+	u16 pagecnt_bias; /* expected pagecnt if only the driver has a ref */
 	u16 pad; /* adjustment for rx padding */
 	u8 can_flip; /* tracks if the networking stack is using the page */
 };
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 6880d1531ba5..571f851d6dcd 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -149,8 +149,8 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
 	buf_state->last_single_ref_offset = 0;
 
 	/* The page already has 1 ref. */
-	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
-	buf_state->page_info.pagecnt_bias = INT_MAX;
+	page_ref_add(buf_state->page_info.page, GVE_PAGECNT_BIAS - 1);
+	buf_state->page_info.pagecnt_bias = GVE_PAGECNT_BIAS;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 81ea800e66e9..6533fff06155 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -152,8 +152,8 @@ static void gve_setup_rx_buffer(struct gve_rx_ring *rx,
 	page_info->buf_size = rx->packet_buffer_size;
 	*slot_addr = cpu_to_be64(addr);
 	/* The page already has 1 ref */
-	page_ref_add(page, INT_MAX - 1);
-	page_info->pagecnt_bias = INT_MAX;
+	page_ref_add(page, GVE_PAGECNT_BIAS - 1);
+	page_info->pagecnt_bias = GVE_PAGECNT_BIAS;
 }
 
 static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
@@ -230,8 +230,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 			rx->qpl_copy_pool[j].buf_size = rx->packet_buffer_size;
 
 			/* The page already has 1 ref. */
-			page_ref_add(page, INT_MAX - 1);
-			rx->qpl_copy_pool[j].pagecnt_bias = INT_MAX;
+			page_ref_add(page, GVE_PAGECNT_BIAS - 1);
+			rx->qpl_copy_pool[j].pagecnt_bias = GVE_PAGECNT_BIAS;
 		}
 	}
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index caed38cd5f2b..cb6fba3122d5 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -93,15 +93,9 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
 {
 	page_info->pagecnt_bias--;
 	if (page_info->pagecnt_bias == 0) {
-		int pagecount = page_count(page_info->page);
-
-		/* If we have run out of bias - set it back up to INT_MAX
-		 * minus the existing refs.
-		 */
-		page_info->pagecnt_bias = INT_MAX - pagecount;
-
-		/* Set pagecount back up to max. */
-		page_ref_add(page_info->page, INT_MAX - pagecount);
+		/* Out of bias: take another batch of references. */
+		page_info->pagecnt_bias = GVE_PAGECNT_BIAS;
+		page_ref_add(page_info->page, GVE_PAGECNT_BIAS);
 	}
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/ethernet/google/gve/gve_utils.h
index bf2e9a0adb36..316f97607351 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.h
+++ b/drivers/net/ethernet/google/gve/gve_utils.h
@@ -25,7 +25,13 @@ struct sk_buff *gve_rx_copy_data(struct net_device *dev, struct napi_struct *nap
 struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 			    struct gve_rx_slot_page_info *page_info, u16 len);
 
-/* Decrement pagecnt_bias. Set it back to INT_MAX if it reached zero. */
+/* Up-front references gve holds on an RX page, so handing a buffer to the
+ * stack is a pagecnt_bias decrement, not a get_page(). Keep it in a u16 so
+ * the 32-bit page refcount keeps the headroom every page needs below INT_MAX.
+ */
+#define GVE_PAGECNT_BIAS USHRT_MAX
+
+/* Decrement pagecnt_bias. Top it up by GVE_PAGECNT_BIAS if it reached zero. */
 void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info);
 
 void gve_add_napi(struct gve_priv *priv, int ntfy_idx,

base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
-- 
2.47.3

