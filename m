Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916737C90A
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454065; cv=none; b=L/R1c+/7e90SYB/JP1aHzEox28LUgDPFfp8rj2ljh2hztyT/TmBdQRnUulTkS9Tafq/2yny4RkWB8wIsByPq4Z7kUnck4MveH65qeSrUF5pLaTzIBtVGnX4+C0drhGdG9J2LYuEYcRSRkor13OJWPBuF3GIzaZ8gEaF9fLm8Yw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454065; c=relaxed/simple;
	bh=lyBOjUkF2Q73xcVQLMdtNN1OvzicMee0Jx3fivdgHho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VP6BjUim7uiAkxFWv+gg0pAuNm5syIIZWYc7gN941eWDvzGoyjEk3gwhXIy+ld8NfBNhJ2nHIxoI3Re+aLKRmC9kjCv8HdypC7b8+eaKokNI2KgK0LeiDTT5FwCOg5moFmDbJX+JV1cbspnWkJCYQmXJC2kQGm1witL//oUyupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjqAGCeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjqAGCeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A861F000E9;
	Tue, 11 Aug 2026 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786454064;
	bh=bylDNSV8lujL8GiP+Ha2m0CZWo3OZOnDer1Q6O7S7XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hjqAGCeZDY90y3PSFLJ5jWs0eB6gAW4TxAsIIG5eMpK2xskg4j3QMZlmyEKUsptKT
	 xZ7j/FOmpslNliyK64iARfwbu2olwJpZOIuTYcd2RakqW6sZ7/IvN7U8yLHCtxqXdV
	 J+OWBE56tfiq+C6ANvDQOLE9CBdTKEEw6DNEfJ7c4/yJr5Cd7JE6Y5V8B3jhLQHXa4
	 ZmmVsHCBJumh4u7RB61jIqSHufUyQQkavYpTYGEwn9qKxMyKttAwdWA02tR7XHf7wT
	 /D77S/aAumXgd9RLWFro9/EtoD+xpt1Cvwv+EDzKpY0AVy6L2u3nZchQ7slGXthuOE
	 Ylh1rv3D9JuWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] net: pktgen: fix code style (WARNING: Block comments)
Date: Tue, 11 Aug 2026 09:14:20 -0400
Message-ID: <20260811131421.2547482-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080503-number-pectin-b335@gregkh>
References: <2026080503-number-pectin-b335@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Peter Seiderer <ps.report@gmx.net>

[ Upstream commit 870b856cb478bc02fffe4d89897e62c692efb09a ]

Fix checkpatch code style warnings:

  WARNING: Block comments use a trailing */ on a separate line
  +                                * removal by worker thread */

  WARNING: Block comments use * on subsequent lines
  +       __u8 tos;            /* six MSB of (former) IPv4 TOS
  +                               are for dscp codepoint */

  WARNING: Block comments use a trailing */ on a separate line
  +                               are for dscp codepoint */

  WARNING: Block comments use * on subsequent lines
  +       __u8 traffic_class;  /* ditto for the (former) Traffic Class in IPv6
  +                               (see RFC 3260, sec. 4) */

  WARNING: Block comments use a trailing */ on a separate line
  +                               (see RFC 3260, sec. 4) */

  WARNING: Block comments use * on subsequent lines
  +       /* = {
  +          0x00, 0x80, 0xC8, 0x79, 0xB3, 0xCB,

  WARNING: Block comments use * on subsequent lines
  +       /* Field for thread to receive "posted" events terminate,
  +          stop ifs etc. */

  WARNING: Block comments use a trailing */ on a separate line
  +          stop ifs etc. */

  WARNING: Block comments should align the * on each line
  + * we go look for it ...
  +*/

  WARNING: Block comments use a trailing */ on a separate line
  +        * we resolve the dst issue */

  WARNING: Block comments use a trailing */ on a separate line
  +        * with proc_create_data() */

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 817ff6efdb7f ("net: pktgen: fix proc entry use-after-free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/pktgen.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 57502e8628462..1434f6f2143f2 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -275,7 +275,8 @@ struct pktgen_dev {
 	int pkt_overhead;	/* overhead for MPLS, VLANs, IPSEC etc */
 	int nfrags;
 	int removal_mark;	/* non-zero => the device is marked for
-				 * removal by worker thread */
+				 * removal by worker thread
+				 */
 
 	struct page *page;
 	u64 delay;		/* nano-seconds */
@@ -338,10 +339,12 @@ struct pktgen_dev {
 	__u16 udp_dst_max;	/* exclusive, dest UDP port */
 
 	/* DSCP + ECN */
-	__u8 tos;            /* six MSB of (former) IPv4 TOS
-				are for dscp codepoint */
-	__u8 traffic_class;  /* ditto for the (former) Traffic Class in IPv6
-				(see RFC 3260, sec. 4) */
+	__u8 tos;		/* six MSB of (former) IPv4 TOS
+				 * are for dscp codepoint
+				 */
+	__u8 traffic_class;	/* ditto for the (former) Traffic Class in IPv6
+				 * (see RFC 3260, sec. 4)
+				 */
 
 	/* MPLS */
 	unsigned int nr_labels;	/* Depth of stack, 0 = no MPLS */
@@ -375,12 +378,12 @@ struct pktgen_dev {
 
 	__u8 hh[14];
 	/* = {
-	   0x00, 0x80, 0xC8, 0x79, 0xB3, 0xCB,
-
-	   We fill in SRC address later
-	   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	   0x08, 0x00
-	   };
+	 * 0x00, 0x80, 0xC8, 0x79, 0xB3, 0xCB,
+	 *
+	 * We fill in SRC address later
+	 * 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	 * 0x08, 0x00
+	 * };
 	 */
 	__u16 pad;		/* pad out the hh struct to an even 16 bytes */
 
@@ -443,7 +446,8 @@ struct pktgen_thread {
 	char result[512];
 
 	/* Field for thread to receive "posted" events terminate,
-	   stop ifs etc. */
+	 * stop ifs etc.
+	 */
 
 	u32 control;
 	int cpu;
@@ -2235,7 +2239,7 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
 #ifdef CONFIG_XFRM
 /* If there was already an IPSEC SA, we keep it as is, else
  * we go look for it ...
-*/
+ */
 #define DUMMY_MARK 0
 static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
 {
@@ -2506,7 +2510,8 @@ static int pktgen_output_ipsec(struct sk_buff *skb, struct pktgen_dev *pkt_dev)
 	if (!x)
 		return 0;
 	/* XXX: we dont support tunnel mode for now until
-	 * we resolve the dst issue */
+	 * we resolve the dst issue
+	 */
 	if ((x->props.mode != XFRM_MODE_TRANSPORT) && (pkt_dev->spi == 0))
 		return 0;
 
@@ -3569,7 +3574,8 @@ static int add_dev_to_thread(struct pktgen_thread *t,
 	 * userspace on another CPU than the kthread.  The if_lock()
 	 * is used here to sync with concurrent instances of
 	 * _rem_dev_from_if_list() invoked via kthread, which is also
-	 * updating the if_list */
+	 * updating the if_list
+	 */
 	if_lock(t);
 
 	if (pkt_dev->pg_thread) {
@@ -3766,7 +3772,8 @@ static int pktgen_remove_device(struct pktgen_thread *t,
 
 	/* Remove proc before if_list entry, because add_device uses
 	 * list to determine if interface already exist, avoid race
-	 * with proc_create_data() */
+	 * with proc_create_data()
+	 */
 	proc_remove(pkt_dev->entry);
 
 	/* And update the thread if_list */
-- 
2.53.0

