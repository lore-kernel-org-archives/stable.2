Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA981732
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450530; cv=none; b=V3FKqMqWEMaM0+1MzMnfmfi0jBWxz9LOOXsINx7nFKq08SYZW9b8tcJLs66/IJ5O8sC8pgJsgM7zm+TfYGS5v5E9p/0XbnzjUZzx/xtnkMHbTAvZP8X9QnGcq65zX8YUzsz/8Z5QCu5IFsdVs5F4jNMfOOxqoblZlYQ/HqL01TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450530; c=relaxed/simple;
	bh=y2nLxOus1sN0VV7XlPWrp7RbTi6yCm9xDtqAu8PlyJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZ0zeONWho4+5xgehkbp/D0baW2naGh1DgzrB2f/8zxymdVAWGRFsWvRkO2I9P9rWWPRsxiOtaBKM3OJCHuNe5gqkEjIIF3EllyAR6qtKikRsRjxKbEgOjXK0UkzNHhbjgyr1/BoBF66sHTXlwxwjn6RZ++0GebMw8zg4QnDOSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2dFCwtM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2dFCwtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9544A1F00A3A;
	Tue, 11 Aug 2026 12:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786450529;
	bh=2y95dElGeSPfVDQT3o10RTo6819vAGn6wq/Pasz0kII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d2dFCwtMktoM/fw3Tu4fOldMLnht2lN6b0WQMRJiH0qp9c22JGVetfo7dDUYUHLHs
	 IwLvNplyC5ZeNgBAJw+PhhM4SKU0/nN20LF1Pf7lvJ+QxyV6qsd5FLBHGhqtLKI1lV
	 fGqBWnDWXfKG0QIogANFtomWyqPkBhX8cla66FOWpwTCaIIEfm+vbwjK/Fdt/qoc0M
	 sINIsFluOrqK7VNJxKTrfsejMOZdtTZF6Tbx+hQvJA9gb/hdR0u/jZ+YVQVyBxp4Mb
	 iChq8W4CAX2/cr930OIXWT11GtsA3aWD3j4g1Qno9TGC7/w01ubixjOSS7+tHtiACk
	 7nOB6wvcVbbcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] net: pktgen: fix code style (WARNING: Block comments)
Date: Tue, 11 Aug 2026 08:15:25 -0400
Message-ID: <20260811121526.2373725-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080501-smudge-pork-db82@gregkh>
References: <2026080501-smudge-pork-db82@gregkh>
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
index 6afea369ca213..f558e5d407821 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -284,7 +284,8 @@ struct pktgen_dev {
 	int pkt_overhead;	/* overhead for MPLS, VLANs, IPSEC etc */
 	int nfrags;
 	int removal_mark;	/* non-zero => the device is marked for
-				 * removal by worker thread */
+				 * removal by worker thread
+				 */
 
 	struct page *page;
 	u64 delay;		/* nano-seconds */
@@ -347,10 +348,12 @@ struct pktgen_dev {
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
 
 	/* IMIX */
 	unsigned int n_imix_entries;
@@ -390,12 +393,12 @@ struct pktgen_dev {
 
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
 
@@ -459,7 +462,8 @@ struct pktgen_thread {
 	char result[512];
 
 	/* Field for thread to receive "posted" events terminate,
-	   stop ifs etc. */
+	 * stop ifs etc.
+	 */
 
 	u32 control;
 	int cpu;
@@ -2343,7 +2347,7 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
 #ifdef CONFIG_XFRM
 /* If there was already an IPSEC SA, we keep it as is, else
  * we go look for it ...
-*/
+ */
 #define DUMMY_MARK 0
 static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
 {
@@ -2642,7 +2646,8 @@ static int pktgen_output_ipsec(struct sk_buff *skb, struct pktgen_dev *pkt_dev)
 	if (!x)
 		return 0;
 	/* XXX: we dont support tunnel mode for now until
-	 * we resolve the dst issue */
+	 * we resolve the dst issue
+	 */
 	if ((x->props.mode != XFRM_MODE_TRANSPORT) && (pkt_dev->spi == 0))
 		return 0;
 
@@ -3710,7 +3715,8 @@ static int add_dev_to_thread(struct pktgen_thread *t,
 	 * userspace on another CPU than the kthread.  The if_lock()
 	 * is used here to sync with concurrent instances of
 	 * _rem_dev_from_if_list() invoked via kthread, which is also
-	 * updating the if_list */
+	 * updating the if_list
+	 */
 	if_lock(t);
 
 	if (pkt_dev->pg_thread) {
@@ -3907,7 +3913,8 @@ static int pktgen_remove_device(struct pktgen_thread *t,
 
 	/* Remove proc before if_list entry, because add_device uses
 	 * list to determine if interface already exist, avoid race
-	 * with proc_create_data() */
+	 * with proc_create_data()
+	 */
 	proc_remove(pkt_dev->entry);
 
 	/* And update the thread if_list */
-- 
2.53.0

