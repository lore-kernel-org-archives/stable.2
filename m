Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218743;
	b=R68haiBdBkM7OJRl1gmgCLGD1fRD7AaWVkEFItdnYtckhSBRuLywu9L+txov4ZikugYR
	 /Ik4iXbxU5nJ71ksH75Y/RstG1+5yP035MVjVJCEY+/V+Hm9WO1mc4/wfgLA3vSzp0WPN
	 wzojm6MfRHx8pooAIwtYXABuOSAv7AvluuTaangt8LbRVeE140wokYINhw1lVZWNfXAky
	 apPO3tB7VgQqtV5yLrwXzpZHzqVx0kajb+X25NWS+vNW07dM2JSgLlNjf8u9YAl7Fn62O
	 WMbbcWSnp873OeTc4R27NFqDIOUF9WNBwwtG0d43qVBhFbiKzKqlzbCSoWTyIaR0DVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H4xpcwq64pI6xfZ5hDaZEZJL6Xf3GeDLcSe5pvZrhYo=;
	b=js3bGAz9AQ4xfrJNQIpSoYaGmgRiyI389WfZJnawfzlYx3dDQLczeHphBT/kG11PHGWM
	 CECfdKD7Fks0tTBQN1rVowu7kPeZTFMm8hjrHpHAhv2LbuBsiwQ5Heui4kLj89RTe87Kb
	 K1kN07N9J7ilYgFeD5NYStdlbJqNHhes0AIOm0KvwM45rtVPb3CUorY1vQ0qu77qYzIBj
	 gZ8KlVK1C5oDKGf+Ro3jqotAnSJLlmGOhTkYbnOBpWUhhtWcbkQPc0O83X/mywebJSoab
	 fi7y5eV1kSo/oEgODZyrt14kmj4J59zujfFdyJJCfF6fuZKw2QwA7OTjYsbTntiZAbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vVwO0Eke;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA97606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 10:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA97606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vVwO0Eke
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so1211291eec.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 02:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218742; x=1794823542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4xpcwq64pI6xfZ5hDaZEZJL6Xf3GeDLcSe5pvZrhYo=;
        b=vVwO0EkeQo6/g63g8perAxJri7xduvH6z5wNddM/oKH7yoGUqfxO9qyG+j7lsOdnsc
         g7rK/jlfvU3ZXgCBl9/UXsft4jFH53u0/ZrwY3NGz8z984t5AtASf/Ccaq3cDpc6YoLZ
         nmPPU9KoYWhd7oBZCOSLNBYmJ+yz2B79/oDYrvT5P/YU9RwZhSCzJ9JfACd5wTL4w0vG
         2hTSKOTufRESB/t8EekkFz8Ryy4exnl3+q4SSy+7ju5vO2k7FvhzT6ugETrjCPX4qWmT
         lD4+mJAGejciHm/H5IXnLGg/9SCI9jRrqyc1M/uTSgexvwlbCEOkPeBatzyqSb6LQ08L
         RIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218742; x=1794823542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H4xpcwq64pI6xfZ5hDaZEZJL6Xf3GeDLcSe5pvZrhYo=;
        b=EMBjQs0KUZnTtEv1Wr3Zruu3uKJgy2MBSQz7sVEjlUCtpGYO/xan6DZpYE8hlApKAB
         bjbbj3B0SGw7sri9oGQ5LOEHGtppBisgwTlNv5LJWYRw3j/B46qne0EmfoDRALcek8pX
         EgyYgu5TcF92sAG1mQVqEBgxQ7W1Omfr1SiKaIAlWvnsgGrO3mAGt08tYaxVHogB/+LT
         Zuu4ftv7Xz/UVX9kMnydtgh5V6A4Z/fsrH1BTgL08KpgRuH8HbhNQ55/C7mbLpBN940J
         Mw4+wvXmz98vtDLgl03pGYVzzh2e3a4OpHcL1vO/lF7VwZSbLj0+UmQq1RUJ17ep65TU
         oFhA==
X-Forwarded-Encrypted: i=1; AL+hErFJezkMW9oVX7tXu9VlGKRKK6Z9KIl176SNBTIWjEEX+AOfyWoYc/kzZB4fz4SKxwQOWHCnYFI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b0S8Y9oO7COy6OlZGQDxSOTRGEEtpTlhuAXKj6loU5CqAsbtb
	nKKGBU8Ml7fL5RcZfrojg3FJHkyfylTorpAdTjBa7c5G6Dak9vBj84yy
X-Gm-Gg: AYBFou1IoFdZ3GY/g91oRVemo2SUwWYSriJ37OPp8YrNIXgEouugb7ap2hBMH61FWAS
	Q9fz2wrA4sDlXcYzKs/NYg50LdUnZKMDjty+d7CHWLJxyQed3j666RMjsQkbtnBeHc9bnMMw1Np
	MnnaMSjMcTdUnW5/f/UhESatpFDsSb13Nz2JCIfWWAkCvDNjTX+jGqVj/Mf9hsR3odKskIE973W
	eHkdg7rP82Xbiqn48mY/uHVjzlXGYu6MKuE4oF8OS8D4HNpCSEYKv1+8Fn1Jxx6UVyRXmhbfIp8
	u/ocv9mkBxjLjYMm4RZaSVFhskbuuhGGVIW7mQuShBCP77KMOUUSyU54L1Ft5iVW/lM4K8k1ZbI
	fM+Xfa4T+M9K9HpSGNr24Gj4VRtut1BdbTBl6LPVgCa59C6HVgup0OPmKmEOm1vc2FTLKfc5Wkv
	C5n2+bo3enN8mDcGTvJ57rTQ4ZymaOQNExFysAKSuoqYE4294fXDE0ox0yC/sz1MBXrN/9wdb8u
	W37xTmTQ0Ig5DzJUeTyKWsLbUzP5kPOVaxZSYcVyfP0cLN2zgMpaty2wtjpdAW2FomjgreUVHl2
	24ozZBzCLLA/LlE/wvHAk3DECi32GzDvKl4/BXXlmrfD
X-Received: by 2002:a05:693c:63cf:b0:36f:4354:608 with SMTP id 5a478bee46e88-37258c27cfcmr6328144eec.37.1794218741685;
        Mon, 09 Nov 2026 02:05:41 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:5a62:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm12886710eec.26.2026.11.09.02.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:05:41 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	maciej.fijalkowski@intel.com,
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
	stable@vger.kernel.org,
	Amaan Cheval <amaan.cheval@gmail.com>
Subject: [PATCH net v5 2/2] gve: fix RX page refcount overflow from INT_MAX pagecnt_bias
Date: Mon,  9 Nov 2026 15:34:37 +0530
Message-ID: <20261109100437.331423-3-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261109100437.331423-1-amaan.cheval@gmail.com>
References: <20261109100437.331423-1-amaan.cheval@gmail.com>
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
avoid an atomic op per packet. This leaves no room for anyone else: while
a fresh page's buffer sits in an skb its refcount is already INT_MAX, so a
single get_page() from the stack overflows it to negative.

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
only has to make the per-packet atomic rare, so a small value keeps
page_count() far below INT_MAX however many references the stack takes.
Refill by adding a fixed batch and setting the bias to it, which keeps
the rule `references = page_count() - bias` intact.

Refilling at 0 hands the driver's last reference to the consumer once
every USHRT_MAX handoffs rather than once every INT_MAX, which is only
safe because every consumer on these paths holds its reference until
the driver has recycled the buffer. The previous patch keeps it that
way by blocking XDP on DQO-QPL, so this one depends on it. Trees before
6.17, without commit d8a8ca14c937 ("gve: add XDP_TX and XDP_REDIRECT
support for DQ RDA"), still refuse XDP on every format but GQI-QPL in
verify_xdp_configuration(), so there this patch stands alone.

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
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
---
v5:
 - Name INT_MAX in the subject. No code change; patch 1/2 changed.
v4: https://lore.kernel.org/netdev/20261106114551.212675-3-amaan.cheval@gmail.com/
 - Add patch 1/2, blocking XDP on DQO-QPL, which this fix depends on
   (Sashiko). Harshitha said Google would send such a patch; I'm happy
   to drop 1/2 in favour of theirs.
 - Say "overflow" instead of "headroom" in the subject and the commit
   message (Maciej).
 - Use USHRT_MAX directly instead of a GVE_PAGECNT_BIAS macro, as the
   other drivers do, and move its rationale next to the refill in
   gve_dec_pagecnt_bias() (Maciej). No functional change.
 - Added Reviewed-by from Maciej Fijalkowski.
 - Say which trees need patch 1/2, for stable.
v3: https://lore.kernel.org/netdev/20261103090651.35399-1-amaan.cheval@gmail.com/
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
 drivers/net/ethernet/google/gve/gve_utils.c          | 12 ++++--------
 drivers/net/ethernet/google/gve/gve_utils.h          |  2 +-
 5 files changed, 12 insertions(+), 16 deletions(-)

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
index 6880d1531ba5..52223baf0303 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -149,8 +149,8 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
 	buf_state->last_single_ref_offset = 0;
 
 	/* The page already has 1 ref. */
-	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
-	buf_state->page_info.pagecnt_bias = INT_MAX;
+	page_ref_add(buf_state->page_info.page, USHRT_MAX - 1);
+	buf_state->page_info.pagecnt_bias = USHRT_MAX;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 81ea800e66e9..3bed19866376 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -152,8 +152,8 @@ static void gve_setup_rx_buffer(struct gve_rx_ring *rx,
 	page_info->buf_size = rx->packet_buffer_size;
 	*slot_addr = cpu_to_be64(addr);
 	/* The page already has 1 ref */
-	page_ref_add(page, INT_MAX - 1);
-	page_info->pagecnt_bias = INT_MAX;
+	page_ref_add(page, USHRT_MAX - 1);
+	page_info->pagecnt_bias = USHRT_MAX;
 }
 
 static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
@@ -230,8 +230,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 			rx->qpl_copy_pool[j].buf_size = rx->packet_buffer_size;
 
 			/* The page already has 1 ref. */
-			page_ref_add(page, INT_MAX - 1);
-			rx->qpl_copy_pool[j].pagecnt_bias = INT_MAX;
+			page_ref_add(page, USHRT_MAX - 1);
+			rx->qpl_copy_pool[j].pagecnt_bias = USHRT_MAX;
 		}
 	}
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index caed38cd5f2b..930555ac8fe9 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -93,15 +93,11 @@ void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
 {
 	page_info->pagecnt_bias--;
 	if (page_info->pagecnt_bias == 0) {
-		int pagecount = page_count(page_info->page);
-
-		/* If we have run out of bias - set it back up to INT_MAX
-		 * minus the existing refs.
+		/* Out of bias: take another batch. USHRT_MAX keeps this rare
+		 * while leaving page_count() far below INT_MAX.
 		 */
-		page_info->pagecnt_bias = INT_MAX - pagecount;
-
-		/* Set pagecount back up to max. */
-		page_ref_add(page_info->page, INT_MAX - pagecount);
+		page_info->pagecnt_bias = USHRT_MAX;
+		page_ref_add(page_info->page, USHRT_MAX);
 	}
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/ethernet/google/gve/gve_utils.h
index bf2e9a0adb36..c686142d37ea 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.h
+++ b/drivers/net/ethernet/google/gve/gve_utils.h
@@ -25,7 +25,7 @@ struct sk_buff *gve_rx_copy_data(struct net_device *dev, struct napi_struct *nap
 struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 			    struct gve_rx_slot_page_info *page_info, u16 len);
 
-/* Decrement pagecnt_bias. Set it back to INT_MAX if it reached zero. */
+/* Decrement pagecnt_bias. Top it up by USHRT_MAX if it reached zero. */
 void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info);
 
 void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
-- 
2.47.3

