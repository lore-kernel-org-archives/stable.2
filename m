Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F43BCD0A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452788; cv=none; b=mz0KIeZk2zZBcXRMZs6u2HV5kNDQobUXIyL9dKIpnqiUsLCfxzgx+FCknfAusmcumuDa52x1QzdmKAzSEepIlulAdOgUoMTwRvQfUHhZ2ZuiiriOG08BFsDSSTlNfYmZ2FsbFyUh3vtaJY41diGp3Tk1hzaz1whM8YUdJNYorvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452788; c=relaxed/simple;
	bh=i8MtdT1anG2o3xyO5+GSRDqeHQpWAWiT1/wMc1BdItQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJkVH2PHD/QRGzN6ZbGg/SulsEC23Vkgvr54XvmDAZQ4H7QZBC78g45KLLYdcqlBycPWEGTzDW1tDafpKc6CHfsHt5fOD2cM+JUoEynMVUkxCfVTtZ+3Xhb8cCs3cLZv7mr+6zpIftTVmEhSUE8tx8B1bDxiGgh6768Ii8B+4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Ot5gxN/B; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Ot5gxN/B"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398b3c37877so3128096a91.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1788452783; x=1789057583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HTg5JxeqoxZZGBfquzkRlxTNioRot4JEGl1NHnJ0C+U=;
        b=Ot5gxN/B3rECgzDEeXCTazyX0B6iiVjwfz8DImtFs0nvb0qGIQIpYebyo1XcsaCF+g
         5aZnWJrPRzOnFWnt4Xj9b8t6rjK7JI/gWNKKJnpB3w6MH8KSq1HH+LRh9+ubuU0pcAHJ
         a+0D2A32YzleJAUFNvG5nXhgKzOBu9Nx8XTETI7Dogtdbkzf4pJiLNJqmr4qgmcg9TWm
         lenxf0PrUUdrQdPHxK29eQvUGXHtBeJCxJrPRMGsOP2FbJXAdKPmVDAT7xL6/jSEiJ7g
         LzoFltZSUxWiQfZdoQ/vcM81V71dVGXXRqdX0vgWQDgiRiuitxMSCbMtDwjf6JoAg3Jp
         uCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788452783; x=1789057583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HTg5JxeqoxZZGBfquzkRlxTNioRot4JEGl1NHnJ0C+U=;
        b=A1jIX/WjFKSVZC1wqihOdk2G1hxuM7oNU4RUEKxR6LIVPg7QhEk6nv94gaJDuTYMyL
         rnX2ICQUbU9FbIcHmtHmUYgBXIbSQodk23Z9CqYXRxem2W0345ys+TrrR/AiwhgE1XSk
         NZrbjO9oORGQjziea3+vch6s4ogAe2cPjfPICJcUWVCJnEPd0rij9vnhXBJ7akBqfsoc
         hsGMhGzw+inFoJiJRELrvehYjrQxOH6KeaOSEX++UsUFxGw4WfsGrSj5suMfpHwJeM0R
         ku8Nij2jSDFov3TTunR/8BxcHyLiWKKdh53BnFnWxKwfziNdUGG3ycyaBHdwGacAJzL2
         kUgA==
X-Gm-Message-State: AFuF++n8YOm1XPMvDx+BcXs2f4Qna5+qSmOSM7GENPtl/YqzsrGTz0X0
	K9VAiv3e3/VDOOrBgTtinqncRh9y2W6QJqVxJH7ntAy9lNmVLkbBoyqiPlJ0ojtLRFhkm5I3M82
	QGeKw
X-Gm-Gg: AYBFou311X+izCLfNH5zT+tom6SCCO1vE5c9337RXVu8wbaRFlW+NHrbicPyqZFG0bk
	m8DeH1Q6TfgkW/ds0wEsBBMyiI2zWek0fnnFtw5nSvyYRt5q5DeL5oxDUanwl0pBtCnh+a2CLUI
	ijCfqMYQxOYnYHhQuRJbLwN7HxBi/uGNUzdZoitNCrcP7GNol1vFACZHT/Lvqf1BBBrgb+8U+Xd
	6TfjFoEFcEc2OnHaCFZ9YojCNoVLQ3vrUboKN0VqRf0W34WMe3bqDhIvZAuJq/sCYpJ8urSGrCT
	YohCtvfqcxXLnTUju1ZCkWLHezW4A0SqQbHLP6ZZ/6eiTUiSOihlOqe6jUVxE8YEXnDTsCt2Y38
	oDWoVzll0iZ/0RnzFX4uOgANnIja1ehX1cv7y4Ft4S+LU79JYI0FrTS5pcUMAfPE1ssZgfkgKuV
	NCPYUVLvoh2SVqJkRvzhqmj2pas1SuNbKM7kPXuEmI33rfOVQkle6yLwWyn9E4nwE+8KzfkajSR
	rM5ui4=
X-Received: by 2002:a17:90b:4c0f:b0:398:e436:384 with SMTP id 98e67ed59e1d1-39aedf1ad68mr18916685a91.1.1788452783379;
        Thu, 03 Sep 2026 09:26:23 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([115.138.38.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083ea8b2sm6279385a91.6.2026.09.03.09.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:26:22 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: stable@vger.kernel.org
Cc: Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18.y] net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry
Date: Fri,  4 Sep 2026 01:26:02 +0900
Message-ID: <20260903162602.23182-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026090324-brewing-density-6928@gregkh>
References: <2026090324-brewing-density-6928@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_llc_rmt_delete_rkey() and smc_llc_save_add_link_rkeys() read the part
of a v2 message that does not fit into the 44-byte union smc_llc_msg, and
both bound themselves by the size of the buffer it landed in, not by what
arrived. On a link with a shared v2 receive buffer a 44-byte
DELETE_RKEY_V2 declaring 255 rkeys reaches rkey[9..254] in whatever an
earlier message left in lgr->wr_rx_buf_v2, and passes each of them to
smc_rtoken_delete(). One of those 255 matched a registered rtoken and
deleted it. An ADD_LINK on such a link installs up to 255 rtokens from
the same bytes.

Copy the tail into the queue entry, so its length is the length of the
message that arrived, and declare the rkeys that fit inline as a member of
the union instead of reaching them through a cast. The same
DELETE_RKEY_V2 now processes the 9 rkeys it carries. The copy is limited
to the longest tail the two functions can read, so the peer does not pick
the size of the entry.

The bound the previous patch placed on links without a shared v2 receive
buffer is no longer needed.

Fixes: 27ef6a9981fe ("net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to 1")
Cc: stable@vger.kernel.org
Suggested-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Link: https://patch.msgid.link/20260819023306.644849-4-yhlee@isslab.korea.ac.kr
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 8d3c1ab82c11d4fadebf817a825fd221b3e197ea)
---
The only conflict was the qentry allocation in smc_llc_enqueue(): 6.18 has
kmalloc(sizeof(*qentry), GFP_ATOMIC) where mainline has kmalloc_obj(). The
resolved file matches 8d3c1ab82c11 in every function this patch touches.

 net/smc/smc_llc.c | 125 ++++++++++++++++++++++++++++++++--------------
 net/smc/smc_wr.c  |   6 +--
 2 files changed, 91 insertions(+), 40 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 53db1e0a0..519372652 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -157,6 +157,7 @@ struct smc_llc_msg_confirm_rkey {	/* type 0x06 */
 };
 
 #define SMC_LLC_DEL_RKEY_MAX	8
+#define SMC_LLC_DEL_RKEY_V2_INLINE	9
 #define SMC_LLC_FLAG_RKEY_RETRY	0x10
 #define SMC_LLC_FLAG_RKEY_NEG	0x20
 
@@ -177,6 +178,15 @@ struct smc_llc_msg_delete_rkey_v2 {	/* type 0x29 */
 	__be32 rkey[];
 };
 
+/* the leading rkeys of a DELETE_RKEY_V2 fit into union smc_llc_msg */
+struct smc_llc_msg_delete_rkey_v2_inline {	/* type 0x29 */
+	struct smc_llc_hdr hd;
+	u8 num_rkeys;
+	u8 num_inval_rkeys;
+	u8 reserved[2];
+	__be32 rkey[SMC_LLC_DEL_RKEY_V2_INLINE];
+};
+
 union smc_llc_msg {
 	struct smc_llc_msg_confirm_link confirm_link;
 	struct smc_llc_msg_add_link add_link;
@@ -186,6 +196,7 @@ union smc_llc_msg {
 
 	struct smc_llc_msg_confirm_rkey confirm_rkey;
 	struct smc_llc_msg_delete_rkey delete_rkey;
+	struct smc_llc_msg_delete_rkey_v2_inline delete_rkey_v2;
 
 	struct smc_llc_msg_test_link test_link;
 	struct {
@@ -194,15 +205,25 @@ union smc_llc_msg {
 	} raw;
 };
 
+static_assert(SMC_LLC_DEL_RKEY_V2_INLINE ==
+	      (sizeof(union smc_llc_msg) -
+	       offsetof(struct smc_llc_msg_delete_rkey_v2, rkey)) /
+	      sizeof(__be32));
+static_assert(offsetof(struct smc_llc_msg_delete_rkey_v2_inline, rkey) ==
+	      offsetof(struct smc_llc_msg_delete_rkey_v2, rkey));
+
 #define SMC_LLC_FLAG_RESP		0x80
 
 struct smc_llc_qentry {
 	struct list_head list;
 	struct smc_link *link;
+	u16 body_len;
 	union smc_llc_msg msg;
+	u8 body[] __counted_by(body_len);
 };
 
-static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc);
+static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc,
+			    u32 byte_len);
 
 struct smc_llc_qentry *smc_llc_flow_qentry_clr(struct smc_llc_flow *flow)
 {
@@ -998,22 +1019,19 @@ static int smc_llc_cli_conf_link(struct smc_link *link,
 
 static void smc_llc_save_add_link_rkeys(struct smc_link *link,
 					struct smc_link *link_new,
-					u8 *llc_msg)
+					struct smc_llc_qentry *qentry)
 {
 	const u32 rt_off = offsetof(struct smc_llc_msg_add_link_v2_ext, rt);
 	struct smc_llc_msg_add_link_v2_ext *ext;
 	struct smc_link_group *lgr = link->lgr;
 	int max, i;
 
-	/* Without a shared v2 receive buffer the extension is not copied
-	 * into the queue entry, so not even ext->num_rkeys is there.
-	 */
-	if (!smc_link_shared_v2_rxbuf(link))
+	/* the rkey count itself is only there if enough bytes arrived */
+	if (qentry->body_len < rt_off)
 		return;
-	ext = (struct smc_llc_msg_add_link_v2_ext *)(llc_msg +
-						     SMC_WR_TX_SIZE);
+	ext = (struct smc_llc_msg_add_link_v2_ext *)qentry->body;
 	max = min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
-	max = min_t(u32, max, (SMC_WR_BUF_V2_SIZE - SMC_WR_TX_SIZE - rt_off) /
+	max = min_t(u32, max, (qentry->body_len - rt_off) /
 			      sizeof(ext->rt[0]));
 	down_write(&lgr->rmbs_lock);
 	for (i = 0; i < max; i++) {
@@ -1107,9 +1125,7 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
 	if (rc)
 		goto out_clear_lnk;
 	if (lgr->smc_version == SMC_V2) {
-		u8 *llc_msg = smc_link_shared_v2_rxbuf(link) ?
-			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)llc;
-		smc_llc_save_add_link_rkeys(link, lnk_new, llc_msg);
+		smc_llc_save_add_link_rkeys(link, lnk_new, qentry);
 	} else {
 		rc = smc_llc_cli_rkey_exchange(link, lnk_new);
 		if (rc) {
@@ -1510,9 +1526,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
 	if (rc)
 		goto out_err;
 	if (lgr->smc_version == SMC_V2) {
-		u8 *llc_msg = smc_link_shared_v2_rxbuf(link) ?
-			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)add_llc;
-		smc_llc_save_add_link_rkeys(link, link_new, llc_msg);
+		smc_llc_save_add_link_rkeys(link, link_new, qentry);
 	} else {
 		rc = smc_llc_srv_rkey_exchange(link, link_new);
 		if (rc)
@@ -1561,7 +1575,8 @@ void smc_llc_add_link_local(struct smc_link *link)
 	add_llc.hd.common.llc_type = SMC_LLC_ADD_LINK;
 	smc_llc_init_msg_hdr(&add_llc.hd, link->lgr, sizeof(add_llc));
 	/* no dev and port needed */
-	smc_llc_enqueue(link, (union smc_llc_msg *)&add_llc);
+	smc_llc_enqueue(link, (union smc_llc_msg *)&add_llc,
+			sizeof(union smc_llc_msg));
 }
 
 /* worker to process an add link message */
@@ -1597,7 +1612,8 @@ void smc_llc_srv_delete_link_local(struct smc_link *link, u8 del_link_id)
 	del_llc.link_num = del_link_id;
 	del_llc.reason = htonl(SMC_LLC_DEL_LOST_PATH);
 	del_llc.hd.flags |= SMC_LLC_FLAG_DEL_LINK_ORDERLY;
-	smc_llc_enqueue(link, (union smc_llc_msg *)&del_llc);
+	smc_llc_enqueue(link, (union smc_llc_msg *)&del_llc,
+			sizeof(union smc_llc_msg));
 }
 
 static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
@@ -1819,27 +1835,28 @@ static void smc_llc_rmt_delete_rkey(struct smc_link_group *lgr)
 	link = qentry->link;
 
 	if (lgr->smc_version == SMC_V2) {
-		const u32 rkey_off =
-			offsetof(struct smc_llc_msg_delete_rkey_v2, rkey);
-		struct smc_llc_msg_delete_rkey_v2 *llcv2;
-		u32 buf_len;
-
-		if (smc_link_shared_v2_rxbuf(link)) {
-			memcpy(lgr->wr_rx_buf_v2, llc, sizeof(*llc));
-			llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)lgr->wr_rx_buf_v2;
-			buf_len = SMC_WR_BUF_V2_SIZE;
-		} else {
-			llcv2 = (struct smc_llc_msg_delete_rkey_v2 *)llc;
-			buf_len = sizeof(qentry->msg);
-		}
+		struct smc_llc_msg_delete_rkey_v2_inline *llcv2;
+
+		/* The leading SMC_LLC_DEL_RKEY_V2_INLINE rkeys are declared in
+		 * the message itself, any further ones were received into
+		 * qentry->body.
+		 */
+		llcv2 = &qentry->msg.delete_rkey_v2;
 		llcv2->num_inval_rkeys = 0;
 
 		max = min_t(u8, llcv2->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
-		/* bound by the buffer llcv2 points at */
-		max = min_t(u32, max, (buf_len - rkey_off) /
-				      sizeof(llcv2->rkey[0]));
+		max = min_t(u32, max, SMC_LLC_DEL_RKEY_V2_INLINE +
+				      qentry->body_len / sizeof(__be32));
 		for (i = 0; i < max; i++) {
-			if (smc_rtoken_delete(link, llcv2->rkey[i]))
+			__be32 rkey;
+
+			if (i < SMC_LLC_DEL_RKEY_V2_INLINE)
+				rkey = llcv2->rkey[i];
+			else
+				memcpy(&rkey, qentry->body +
+					      (i - SMC_LLC_DEL_RKEY_V2_INLINE) *
+					      sizeof(rkey), sizeof(rkey));
+			if (smc_rtoken_delete(link, rkey))
 				llcv2->num_inval_rkeys++;
 		}
 		memset(&llc->rkey[0], 0, sizeof(llc->rkey));
@@ -2081,18 +2098,52 @@ static void smc_llc_rx_response(struct smc_link *link,
 	wake_up(&link->lgr->llc_msg_waiter);
 }
 
-static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc)
+/* the longest tail either reader of qentry->body can use */
+static u32 smc_llc_max_body_len(union smc_llc_msg *llc)
+{
+	switch (llc->raw.hdr.common.llc_type) {
+	case SMC_LLC_ADD_LINK:
+		return offsetof(struct smc_llc_msg_add_link_v2_ext, rt) +
+		       SMC_LLC_RKEYS_PER_MSG_V2 *
+		       sizeof(struct smc_llc_msg_add_link_cont_rt);
+	case SMC_LLC_DELETE_RKEY:
+		return (SMC_LLC_RKEYS_PER_MSG_V2 -
+			SMC_LLC_DEL_RKEY_V2_INLINE) * sizeof(__be32);
+	default:
+		return 0;
+	}
+}
+
+static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc,
+			    u32 byte_len)
 {
 	struct smc_link_group *lgr = link->lgr;
 	struct smc_llc_qentry *qentry;
 	unsigned long flags;
+	u16 body_len = 0;
+
+	/* V2 messages can be longer than the inline union smc_llc_msg. Carry
+	 * the remainder in the qentry itself, so that its lifetime and its
+	 * length match the message the peer actually sent.
+	 */
+	if (lgr->smc_version == SMC_V2 && byte_len > SMC_WR_TX_SIZE)
+		body_len = min_t(u32, byte_len, SMC_WR_BUF_V2_SIZE) -
+			   SMC_WR_TX_SIZE;
+	body_len = min_t(u32, body_len, smc_llc_max_body_len(llc));
 
-	qentry = kmalloc(sizeof(*qentry), GFP_ATOMIC);
+	qentry = kmalloc_flex(*qentry, body, body_len, GFP_ATOMIC);
 	if (!qentry)
 		return;
+	qentry->body_len = body_len;
 	qentry->link = link;
 	INIT_LIST_HEAD(&qentry->list);
 	memcpy(&qentry->msg, llc, sizeof(union smc_llc_msg));
+	if (body_len) {
+		u8 *src = smc_link_shared_v2_rxbuf(link) ?
+			(u8 *)lgr->wr_rx_buf_v2 : (u8 *)llc;
+
+		memcpy(qentry->body, src + SMC_WR_TX_SIZE, body_len);
+	}
 
 	/* process responses immediately */
 	if ((llc->raw.hdr.flags & SMC_LLC_FLAG_RESP) &&
@@ -2124,7 +2175,7 @@ static void smc_llc_rx_handler(struct ib_wc *wc, void *buf)
 			return; /* invalid message */
 	}
 
-	smc_llc_enqueue(link, llc);
+	smc_llc_enqueue(link, llc, wc->byte_len);
 }
 
 /***************************** worker, utils *********************************/
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index b04a21b8c..462481713 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -602,9 +602,9 @@ static void smc_wr_init_sge(struct smc_link *lnk)
 
 	/* With SMC-Rv2 there can be messages larger than SMC_WR_TX_SIZE.
 	 * Each ib_recv_wr gets 2 sges, the second one is a spillover buffer
-	 * and the same buffer for all sges. When a larger message arrived then
-	 * the content of the first small sge is copied to the beginning of
-	 * the larger spillover buffer, allowing easy data mapping.
+	 * and the same buffer for all sges. The spillover sge starts at
+	 * SMC_WR_TX_SIZE, so the leading bytes of that buffer are never
+	 * written.
 	 */
 	for (i = 0; i < lnk->wr_rx_cnt; i++) {
 		int x = i * lnk->wr_rx_sge_cnt;
-- 
2.43.0

