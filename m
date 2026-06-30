Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548AF3B42ED
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807110; cv=none; b=fyRSSYAbQW703d5hbvfnR4ijwbc6iJMM9IBcCxOD4CcmblOhRwglDfoOyhaRjiS058Oi8yXVvzZV59K/1iUj+jab8X+hn09FO6U/xCg5ojJU3hWeCXvRGMq8WH1/VBHV4LkAwxExSirUbDXxcJ2RLNqUYf1YDvhf1su5e14T4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807110; c=relaxed/simple;
	bh=9WOKJEUmWGPbrtC633HUp32C+93WqW3IL7MVE/LPjHY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nxFnEA40SopYBEYbycnW6fOjMprAtK1qKpaCxfvelc45niRQvD4AK6R8Mlm5Kfwfy1GIQLLfs2wEKMdbYBBrhXpvOa3ZjFxNNdr/FR2Q7Ra1uJPNanW4xVzL1wS40QImwTiyiKOl0Jjqx99NCtkkmjI4V3RkqMsWz6LGEGBQYKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=vQM+1Ggz; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=VlU8V4nT; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="vQM+1Ggz";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="VlU8V4nT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1782806706;
	bh=9WOKJEUmWGPbrtC633HUp32C+93WqW3IL7MVE/LPjHY=;
	h=From:To:Subject:Date:From;
	b=vQM+1GgznpcjTS9yOEn+kS5GSejnRgtVsj0pTFS9AXm8FfXLIzASr4gnTL3O6vun8
	 05OmBW5YGwJxZv2mDT1+8ZUolKNLuJbqOayGUl6BmFquF03RmHKCzAksCbmvQhcsWn
	 b3d5i/HX+q5LcBwDXp5jDUbRvJmBmIS4n9IEfhpEPmJKqlYMHeNOUAziebbodGpHRc
	 RfjIrL1+zLvZDU0b67ltJK7wIFtJ7J2fgcfDIEi6dl56Xptro3XOtqhCeCcihE21U/
	 DjhK8ojU523JzDlWsgt/0I/3MUdFCgCAk2kqFfJDcpmpMNV7cl5Hx04hWTYgGcIZ84
	 9jEe5vxv4f34Q==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 931F3262
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 17:05:06 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=VlU8V4nT;
	dkim-atps=neutral
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 72645262
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 17:05:06 +0900 (JST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8478947e047so1191473b3a.3
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1782806705; x=1783411505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYTqILTvcqVqVJ+q6wbQFT2JmVJmeSOj94A8snwL4SE=;
        b=VlU8V4nTzJ0oa4aDuxwvq9aekLSlKGY073xo3UZiWAB6nY6fHN/sUOhi0Eu0PUvtYz
         nQ4+RAGPqlQVA/Ba1ymAyDgRftv2txpfPDJkxMqoF89rWGtF5408ZmikzDIpS2uqMEnW
         pCOE6ApICHqJx7MIm0GE4Ukvkk6SCbVZsves4W2jVyrKWFgE8euoyF+z29UhFdP4Q93y
         qyx7JcYHdKl9hOZ++n31mdNH+fW8SJDgJoAug/4zrXF9Z8313n+8xZDyEHJGT4WjHVHH
         BcRbqP5jEnrorhvBzZCo+7kgxAu8GrB8qRihfNY7nhWxelK0bgeN23v26YktuXNfYG6I
         hddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782806705; x=1783411505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYTqILTvcqVqVJ+q6wbQFT2JmVJmeSOj94A8snwL4SE=;
        b=Z55o2A1OD0rVeRHBLKVWyhkgUXpyU6SqU6asU17SCNJ5MceoQO2AqjY9ORCNtPzwP2
         NbYiFKjSUUImtqCt61Xj+G5ONmrSWzcGP6RI43gVix2GWxuFNDIEoCKn715F5tA35hXA
         yJA8u9kquJYugs0nZXveym3HXex20Bf90DKCl+lmd4Bl7WquV0z2O9Gs66CxmWE8efxw
         LRyBtV+R9DLAzSjPJ+dBAqHhxpL4NdwcVBMI1CYSKp03r2iifnkiqlNf4zf7gRYbRV1s
         VsZ9nhMaBP3erOubsViKbiLcIKbawm9FZ0H5GTJw8zwZmW33LWM/J3VB2HvNZTAKUZ5N
         YQhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqf/Gqwft3JT+jGx5A6rl+UmsZ8vNmZIy6rQ8ZqUlSH8b0nt2yRVt1nQPGcY7LdT1vh4cg+0Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjnJaS3CWEKiULOSYUWMF1RIkWBCutrArMeTzvQx1jbZIqShC
	THl0WP5wlMCd2abt0+OgdYl0B7E9LXSD3dP6pVMq23/zo8s+UWu2RBzLQMpixrEMWUjQdlj9p1y
	ldCQcpKw6vlPyRsY4/zilg062jC2he7uJE0VSfVL2v99CvsEJx1qA/HKO56Kc37b0Ws0=
X-Gm-Gg: AfdE7clnuthRAgxfGcp2YSfnmOwcVUgHOsLfbZf6G4ePPfNGv/l05FDk1bL4PQfBIpq
	53I/NteBTg6dLFuRfOo86O8U0c+4pdZN4J64q1PDk5lhjyR4AYb08ktGzdoq+Qh6ggm2n6hhnVo
	SVydoVrWUVpfCS9HQfC6nZrRZc11u4a8V+YVVA+8RA9Z5vN+7Pj8bQPZZtepjoUGdD4HARJPDOz
	lcB+Yg7WBnCETPp0HJp/zfLWSToCaHISQFHyEnrcy06RYJZXGww4lsZw7YHPgFWZqNYrYtm8KWI
	3VUOu60lta96OzIWEGCQUri1rg/gWWJcZIRn05Q8FIWFqXsNpA6LaTvCGESfmR7LxwO5t0SEHCL
	J6/4StkhETa7K2NszUReUiksJ3zffZOo+JwqpX02VSh7qLxG75Q19R/R87fM=
X-Received: by 2002:a05:6a00:4b56:b0:839:12a7:70f7 with SMTP id d2e1a72fcca58-8479f26ada7mr2050448b3a.31.1782806705436;
        Tue, 30 Jun 2026 01:05:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b56:b0:839:12a7:70f7 with SMTP id d2e1a72fcca58-8479f26ada7mr2050413b3a.31.1782806704973;
        Tue, 30 Jun 2026 01:05:04 -0700 (PDT)
Received: from localhost (sodcd-04p2-40.ppp11.odn.ad.jp. [203.139.65.40])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-847a02ced41sm1326619b3a.36.2026.06.30.01.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 01:05:04 -0700 (PDT)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: dominique.martinet@atmark-techno.com,
	stable@vger.kernel.org
Subject: [PATCH 5.10.y] net/sched: fix pedit partial COW leading to page cache corruption
Date: Tue, 30 Jun 2026 17:05:03 +0900
Message-ID: <20260630-cve-2026-46331-v1-1-c1986f356f26@atmark-techno.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260630-cve-2026-46331-4f851ccf8244
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8877; i=dominique.martinet@atmark-techno.com;
 h=from:subject:message-id; bh=oqcZ/f4/98migEijhvNaC5FLNfmO9L/opKQ1jbIHVBc=;
 b=owEBbQKS/ZANAwAKAfKKYH/WjHEHAcsmYgBqQ3f7YjUi3XnzjgCFJQqCGn8HEiwjWqbnoJh3M
 zcb0dWRnEKJAjMEAAEKAB0WIQQoFSiLMD+txr0veJbyimB/1oxxBwUCakN3+wAKCRDyimB/1oxx
 B563D/9M43LiusPq/K+A89lE25NeUV+YZF2e7L6IpUbQVFAaL5RZtY+BufA4YYTavenpmG8ULTl
 yU75Jb95mk0oGc8wdmxcZBbinh24dkxV164Ri1meSeWNfSetPzC+WlbtMb/kEZaQRxNTLdCmmb2
 gR5/0q92SsQQ2iSJ7m3OwiHmOOUAW7S892mXei5ApkC5sJYLqwpZo9euzWFqH4APwNG0/yx3MAN
 16DkhYXSTtDrripzoNEkMN+2hP3H46g3s77Ho8a+j6tBOfWZ0msqgYMA40qvG/WNcpcX8t3MPgY
 Ss4rEauiwbw1aNWz164s6U7+rY87nXY+7CtUhk7nYmCDKe9uGTGW4LeO+f+OyjTrwpF3vgdqU0n
 MqFRNpKbNk7NIGadMTWhCf0YS7qijz7zjMuTYWfgosZIs9CtgBcEN6upfon+B6oe6gWOR1bTxmg
 l3A6dfU2hSN9jEqt2K2jJ7ukkAwrqe+DAYzmcmUjau65Wm0sMzdEITIRVYeJN2ld1vmvLNzuGpE
 LUB8gc9Is1T/vnpWTEdEgH5vgl7A/aAdUSHyoTxzuFIezKG42jc74YtVWzCLyWqY5i3+ncM9b95
 b7TGZYWYaBLI1lLWb1D6DkXBvKyX3adIHEKT6WdziyAuH+ery0nTcIXI0bdlXr2y0gB+B6fZ/Zc 8wumq8nZdU91lqA==
X-Developer-Key: i=dominique.martinet@atmark-techno.com; a=openpgp; fpr=2815288B303FADC6BD2F7896F28A607FD68C7107
Content-Transfer-Encoding: quoted-printable

From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>=0D
=0D
[ Upstream commit 899ee91156e57784090c5565e4f31bd7dbffbc5a ]=0D
=0D
tcf_pedit_act() computes the COW range for skb_ensure_writable()=0D
once before the key loop using tcfp_off_max_hint, but the hint does=0D
not account for the runtime header offset added by typed keys. This=0D
can leave part of the write region un-COW'd.=0D
=0D
Fix by moving skb_ensure_writable() inside the per-key loop where=0D
the actual write offset is known, and add overflow checking on the=0D
offset arithmetic. For negative offsets (e.g. Ethernet header edits=0D
at ingress), use skb_cow() to COW the headroom instead. Guard=0D
offset_valid() against INT_MIN, where negation is undefined.=0D
=0D
Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writab=
le")=0D
Reported-by: Yiming Qian <yimingqian591@gmail.com>=0D
Reported-by: Keenan Dong <keenanat2000@gmail.com>=0D
Reported-by: Han Guidong <2045gemini@gmail.com>=0D
Reported-by: Zhang Cen <rollkingzzc@gmail.com>=0D
Reviewed-by: Han Guidong <2045gemini@gmail.com>=0D
Tested-by: Han Guidong <2045gemini@gmail.com>=0D
Reviewed-by: Davide Caratti <dcaratti@redhat.com>=0D
Tested-by: Davide Caratti <dcaratti@redhat.com>=0D
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>=0D
Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>=0D
Reviewed-by: Victor Nogueira <victor@mojatatu.com>=0D
Tested-by: Victor Nogueira <victor@mojatatu.com>=0D
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>=0D
Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>=0D
Link: https://patch.msgid.link/20260531123221.48732-1-jhs@mojatatu.com=0D
Signed-off-by: Jakub Kicinski <kuba@kernel.org>=0D
[Dominique: plenty of context conflict but the code itself could still=0D
mostly be used]=0D
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>=0D
---=0D
CVE-2026-46331 got attention and I've had to backport this to 5.10, so=0D
here we are, this should fix it.=0D
=0D
Unfortunately there are more conflicts with 5.15 so I didn't do this=0D
one (but if anyone cares older 5.4/4.19 cherry-picks cleanly from this,=0D
they're no longer stable kernels so I won't bother sending)=0D
=0D
I've tested in egress with a trivial rule redirecting port inspired from=0D
the man page (and checking on target with tcpdump because return path is=0D
broken), so I hopefully didn't botch this too badly:=0D
=0D
tc qdisc replace dev eth0 root handle 1: htb=0D
tc filter add dev eth0 parent 1: u32 match ip dport 23 0xffff action pedit =
pedit munge ip dport set 22=0D
---=0D
 include/net/tc_act/tc_pedit.h |  1 -=0D
 net/sched/act_pedit.c         | 84 ++++++++++++++++++++++-----------------=
----=0D
 2 files changed, 43 insertions(+), 42 deletions(-)=0D
=0D
diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h=
=0D
index 3e02709a1df656931942be4851a115dd6bef8b4c..748cf87a4d7ea5c92b4fd48dd33=
02b8ad64944fe 100644=0D
--- a/include/net/tc_act/tc_pedit.h=0D
+++ b/include/net/tc_act/tc_pedit.h=0D
@@ -14,7 +14,6 @@ struct tcf_pedit {=0D
 	struct tc_action	common;=0D
 	unsigned char		tcfp_nkeys;=0D
 	unsigned char		tcfp_flags;=0D
-	u32			tcfp_off_max_hint;=0D
 	struct tc_pedit_key	*tcfp_keys;=0D
 	struct tcf_pedit_key_ex	*tcfp_keys_ex;=0D
 };=0D
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c=0D
index a44101b2f441919b7d4b0be177aa735a3c547350..cebeed6214558b1e1dd717b411c=
9ffa108a2293d 100644=0D
--- a/net/sched/act_pedit.c=0D
+++ b/net/sched/act_pedit.c=0D
@@ -14,6 +14,8 @@=0D
 #include <linux/module.h>=0D
 #include <linux/init.h>=0D
 #include <linux/slab.h>=0D
+#include <linux/overflow.h>=0D
+#include <asm/unaligned.h>=0D
 #include <net/netlink.h>=0D
 #include <net/pkt_sched.h>=0D
 #include <linux/tc_act/tc_pedit.h>=0D
@@ -229,21 +231,11 @@ static int tcf_pedit_init(struct net *net, struct nla=
ttr *nla,=0D
 		p->tcfp_nkeys =3D parm->nkeys;=0D
 	}=0D
 	memcpy(p->tcfp_keys, parm->keys, ksize);=0D
-	p->tcfp_off_max_hint =3D 0;=0D
 	for (i =3D 0; i < p->tcfp_nkeys; ++i) {=0D
-		u32 cur =3D p->tcfp_keys[i].off;=0D
-=0D
 		/* sanitize the shift value for any later use */=0D
 		p->tcfp_keys[i].shift =3D min_t(size_t, BITS_PER_TYPE(int) - 1,=0D
 					      p->tcfp_keys[i].shift);=0D
 =0D
-		/* The AT option can read a single byte, we can bound the actual=0D
-		 * value with uchar max.=0D
-		 */=0D
-		cur +=3D (0xff & p->tcfp_keys[i].offmask) >> p->tcfp_keys[i].shift;=0D
-=0D
-		/* Each key touches 4 bytes starting from the computed offset */=0D
-		p->tcfp_off_max_hint =3D max(p->tcfp_off_max_hint, cur + 4);=0D
 	}=0D
 =0D
 	p->tcfp_flags =3D parm->flags;=0D
@@ -277,15 +269,12 @@ static void tcf_pedit_cleanup(struct tc_action *a)=0D
 	kfree(p->tcfp_keys_ex);=0D
 }=0D
 =0D
-static bool offset_valid(struct sk_buff *skb, int offset)=0D
+static bool offset_valid(struct sk_buff *skb, int offset, int len)=0D
 {=0D
-	if (offset > 0 && offset > skb->len)=0D
+	if (offset < -(int)skb_headroom(skb))=0D
 		return false;=0D
 =0D
-	if  (offset < 0 && -offset > skb_headroom(skb))=0D
-		return false;=0D
-=0D
-	return true;=0D
+	return offset <=3D (int)skb->len - len;=0D
 }=0D
 =0D
 static int pedit_skb_hdr_offset(struct sk_buff *skb,=0D
@@ -325,18 +314,10 @@ static int tcf_pedit_act(struct sk_buff *skb, const s=
truct tc_action *a,=0D
 			 struct tcf_result *res)=0D
 {=0D
 	struct tcf_pedit *p =3D to_pedit(a);=0D
-	u32 max_offset;=0D
 	int i;=0D
 =0D
 	spin_lock(&p->tcf_lock);=0D
 =0D
-	max_offset =3D (skb_transport_header_was_set(skb) ?=0D
-		      skb_transport_offset(skb) :=0D
-		      skb_network_offset(skb)) +=0D
-		     p->tcfp_off_max_hint;=0D
-	if (skb_ensure_writable(skb, min(skb->len, max_offset)))=0D
-		goto unlock;=0D
-=0D
 	tcf_lastuse_update(&p->tcf_tm);=0D
 =0D
 	if (p->tcfp_nkeys > 0) {=0D
@@ -347,10 +328,11 @@ static int tcf_pedit_act(struct sk_buff *skb, const s=
truct tc_action *a,=0D
 		enum pedit_cmd cmd =3D TCA_PEDIT_KEY_EX_CMD_SET;=0D
 =0D
 		for (i =3D p->tcfp_nkeys; i > 0; i--, tkey++) {=0D
-			u32 *ptr, hdata;=0D
+			int write_offset, write_len;=0D
 			int offset =3D tkey->off;=0D
 			int hoffset;=0D
-			u32 val;=0D
+			u32 cur_val, val;=0D
+			u32 *ptr;=0D
 			int rc;=0D
 =0D
 			if (tkey_ex) {=0D
@@ -369,13 +351,15 @@ static int tcf_pedit_act(struct sk_buff *skb, const s=
truct tc_action *a,=0D
 =0D
 			if (tkey->offmask) {=0D
 				u8 *d, _d;=0D
+				int at_offset;=0D
 =0D
-				if (!offset_valid(skb, hoffset + tkey->at)) {=0D
-					pr_info("tc action pedit 'at' offset %d out of bounds\n",=0D
-						hoffset + tkey->at);=0D
+				if (check_add_overflow(hoffset, (int)tkey->at, &at_offset) ||=0D
+				    !offset_valid(skb, at_offset, sizeof(_d))) {=0D
+					pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",=
=0D
+							    hoffset + tkey->at);=0D
 					goto bad;=0D
 				}=0D
-				d =3D skb_header_pointer(skb, hoffset + tkey->at,=0D
+				d =3D skb_header_pointer(skb, at_offset,=0D
 						       sizeof(_d), &_d);=0D
 				if (!d)=0D
 					goto bad;=0D
@@ -387,23 +371,44 @@ static int tcf_pedit_act(struct sk_buff *skb, const s=
truct tc_action *a,=0D
 				goto bad;=0D
 			}=0D
 =0D
-			if (!offset_valid(skb, hoffset + offset)) {=0D
-				pr_info("tc action pedit offset %d out of bounds\n",=0D
-					hoffset + offset);=0D
+			if (check_add_overflow(hoffset, offset, &write_offset)) {=0D
+				pr_info_ratelimited("tc action pedit offset overflow\n");=0D
 				goto bad;=0D
 			}=0D
 =0D
-			ptr =3D skb_header_pointer(skb, hoffset + offset,=0D
-						 sizeof(hdata), &hdata);=0D
-			if (!ptr)=0D
+			if (!offset_valid(skb, write_offset, sizeof(*ptr))) {=0D
+				pr_info_ratelimited("tc action pedit offset %d out of bounds\n",=0D
+						    write_offset);=0D
 				goto bad;=0D
+			}=0D
+=0D
+			if (write_offset < 0) {=0D
+				if (skb_cow(skb, -write_offset))=0D
+					goto bad;=0D
+				if (write_offset + (int)sizeof(*ptr) > 0) {=0D
+					if (skb_ensure_writable(skb,=0D
+								min_t(int, skb->len,=0D
+								      write_offset + (int)sizeof(*ptr))))=0D
+						goto bad;=0D
+				}=0D
+			} else {=0D
+				if (check_add_overflow(write_offset, (int)sizeof(*ptr),=0D
+						       &write_len))=0D
+					goto bad;=0D
+				if (skb_ensure_writable(skb, min_t(int, skb->len,=0D
+								   write_len)))=0D
+					goto bad;=0D
+			}=0D
+=0D
+			ptr =3D (u32 *)(skb->data + write_offset);=0D
+			cur_val =3D get_unaligned(ptr);=0D
 			/* just do it, baby */=0D
 			switch (cmd) {=0D
 			case TCA_PEDIT_KEY_EX_CMD_SET:=0D
 				val =3D tkey->val;=0D
 				break;=0D
 			case TCA_PEDIT_KEY_EX_CMD_ADD:=0D
-				val =3D (*ptr + tkey->val) & ~tkey->mask;=0D
+				val =3D (cur_val + tkey->val) & ~tkey->mask;=0D
 				break;=0D
 			default:=0D
 				pr_info("tc action pedit bad command (%d)\n",=0D
@@ -411,9 +416,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const str=
uct tc_action *a,=0D
 				goto bad;=0D
 			}=0D
 =0D
-			*ptr =3D ((*ptr & tkey->mask) ^ val);=0D
-			if (ptr =3D=3D &hdata)=0D
-				skb_store_bits(skb, hoffset + offset, ptr, 4);=0D
+			put_unaligned((cur_val & tkey->mask) ^ val, ptr);=0D
 		}=0D
 =0D
 		goto done;=0D
@@ -425,7 +428,6 @@ static int tcf_pedit_act(struct sk_buff *skb, const str=
uct tc_action *a,=0D
 	p->tcf_qstats.overlimits++;=0D
 done:=0D
 	bstats_update(&p->tcf_bstats, skb);=0D
-unlock:=0D
 	spin_unlock(&p->tcf_lock);=0D
 	return p->tcf_action;=0D
 }=0D
=0D
---=0D
base-commit: d9666dca97c01de1c7395ac53041634eb75120e2=0D
change-id: 20260630-cve-2026-46331-4f851ccf8244=0D
=0D
Best regards,=0D
-- =0D
Dominique Martinet <dominique.martinet@atmark-techno.com>=0D
=0D


