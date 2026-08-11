Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F703438479
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452722; cv=none; b=rUT63pUTmNazO6dsnZjmmm619NEPmxx+2NwuJ5grlsutSyD4+raqRa8SBjqJkI84OKeH8CYpdnq0aCEdel5dXKGVzwDlvNm/joyAsivj7HaNUvd11yJZu+6cow177UTDzfIiFxFb+thDcN/xsXOYwk0xCPDi7X/ncKDHbBm/xAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452722; c=relaxed/simple;
	bh=3fy+6SFiDk/FOvO1URK69rQlHDj9VM/yzlAdTS6QZiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOqC3sUXzpYW2KDJF5VZFsEwoLOsTcTFpgjayHZGUDnOjNZMa3jDIw47LEYeu1TlI9ahcs1NRG238jYua/K+tL6K9b5ovVtS8L/qIHGlLdT9IuEKR04j2kcQeEunh5xNXhBTbY8qhFNEiDvVa/mpgRe5w5EhIRmGvu2xIV+VHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq8BqBOi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq8BqBOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD5F1F000E9;
	Tue, 11 Aug 2026 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786452720;
	bh=UtvDMKs+48Yas2ERoij6O+ZElsCMakTbgZ3Fmby6MQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uq8BqBOiMSpjo8A++0I1zqZS5/iVIZdTiOsVOSsSJ5y/LJ8L/jACVS6sGa8NPglDg
	 tizEAkzu2N3HDJss6ufk/3sHWhx7nPY4PbF05S1pVICL81HE70w4Y97Jc48lUPbnYs
	 QMeGF+5s7ti57+vqxUWKaPnSxw627DLvkKHnr4IKRnbhb7hmctWeB960fZoOGE3e6u
	 9eVyX+PqIEWARdZvz4G/9pFW89Boj9cvQooKvKq4QHsJ6NO/68bB1YgqLXLnJaMVe4
	 vd4iyK+dNZ9ykShOdb1HxBpXmtj5p734QL8u1xsVN8dIqASrs0X/EKhqOm1BcsVkYb
	 ewNDk+0yWCTmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net: pktgen: fix code style (WARNING: Block comments)
Date: Tue, 11 Aug 2026 08:51:57 -0400
Message-ID: <20260811125158.2464614-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080502-hush-icy-18e3@gregkh>
References: <2026080502-hush-icy-18e3@gregkh>
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
index 2b7b1de70cf47..1042a1e85b3ee 100644
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
 
@@ -458,7 +461,8 @@ struct pktgen_thread {
 	char result[512];
 
 	/* Field for thread to receive "posted" events terminate,
-	   stop ifs etc. */
+	 * stop ifs etc.
+	 */
 
 	u32 control;
 	int cpu;
@@ -2341,7 +2345,7 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
 #ifdef CONFIG_XFRM
 /* If there was already an IPSEC SA, we keep it as is, else
  * we go look for it ...
-*/
+ */
 #define DUMMY_MARK 0
 static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
 {
@@ -2646,7 +2650,8 @@ static int pktgen_output_ipsec(struct sk_buff *skb, struct pktgen_dev *pkt_dev)
 	if (!x)
 		return 0;
 	/* XXX: we dont support tunnel mode for now until
-	 * we resolve the dst issue */
+	 * we resolve the dst issue
+	 */
 	if ((x->props.mode != XFRM_MODE_TRANSPORT) && (pkt_dev->spi == 0))
 		return 0;
 
@@ -3711,7 +3716,8 @@ static int add_dev_to_thread(struct pktgen_thread *t,
 	 * userspace on another CPU than the kthread.  The if_lock()
 	 * is used here to sync with concurrent instances of
 	 * _rem_dev_from_if_list() invoked via kthread, which is also
-	 * updating the if_list */
+	 * updating the if_list
+	 */
 	if_lock(t);
 
 	if (pkt_dev->pg_thread) {
@@ -3908,7 +3914,8 @@ static int pktgen_remove_device(struct pktgen_thread *t,
 
 	/* Remove proc before if_list entry, because add_device uses
 	 * list to determine if interface already exist, avoid race
-	 * with proc_create_data() */
+	 * with proc_create_data()
+	 */
 	proc_remove(pkt_dev->entry);
 
 	/* And update the thread if_list */
-- 
2.53.0

