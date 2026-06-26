Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248CF3AEB2C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497338; cv=none; b=esWVuCwv6goHbKlH74MYnBOnztXj/Nk245EzZLaYVggXleFm0uYES01s3lCLy4NuS9LDfofHlXehaJGhBIxrQo6sDfAXCw9P7pk+zlTAj+RFce+c+bSX0ddJAhPkvwjZJ1b5LkvDxUXj63wlIq+SLNfwQbD3wrLY+5Mcq2ylxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497338; c=relaxed/simple;
	bh=t47PQtuLrsRXqwdH/IGpzs+bZ2ogQNf5phwRn+1HUWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tOpNRR8bKt40/jEnlcHOxYrIq+lxV8gALEVjj1CHrsIcbM5WHrqFUel1LqzDwZ0GMkK145hr+dbZIQvttll7gdGkxnQ4fFlv9nIP/ajWpouksc97F8pCj6l1vOQP1dnTVirJWvEM10seSPI48R37W99D2/UA2Gz9SAQuPHCc6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Rj3v3lkt; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Rj3v3lkt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782497312;
	bh=ck/XS0nE9UNwriqvEIQIIrrdC2vQw4Suitib0XE45Do=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Rj3v3lktNBE242xwigQGJFsxRaDrpky6pd5nDyQnv93ZeHhBrgelsYh/+QwjY6ldH
	 ToD/ux9pWhmkhZ0M4w5c94HSsZGSukVJd0ZUAY3XPqercWfZcbEP2vDWhs9bYuI753
	 OSj8/H+I/vqd3pRyrOaWHf7UHQkoP904sOLPMiaY=
X-QQ-mid: zesmtpgz6t1782497289t05b3e8ad
X-QQ-Originating-IP: HJXYpJjOndhwKUF6CAADANQRl7CCpMd6cWW3pmeIofY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 02:08:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4260604367069817706
EX-QQ-RecipientCnt: 17
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: 2045gemini@gmail.com,
	davem@davemloft.net,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	simon.horman@corigine.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: [PATCH 5.10.y v3 05/10] net/sched: act_pedit: check static offsets a priori
Date: Sat, 27 Jun 2026 02:07:30 +0800
Message-Id: <20260626180735.297017-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626180735.297017-1-guanwentao@uniontech.com>
References: <stable-reply-item001-act-pedit-510-20260626@kernel.org>
 <20260626180735.297017-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Mtnmbwz1r7EqcAdTMKrggI1sPjRN6mZUIjRL+gu34iQe4KzoKVWV4I5T
	zLdYKQzJV4QvxSu6URuo4rZRU/tlJp6xhqU2qbCEO2HBl8FL/BwTFUS+lEHVN4JJRQFT1Ud
	aYzTnRh9bSO86iPbGa7ixpzn4agg4B2/JK7Cg+q/ZsTGVxk8YXGCI9I+KLs4giI18BvVqEq
	X0XcKbOg1qt1wjzpnNCRAZ5CjrRiYm6KUwcOktpBBJhnXV+IqWadQQMhAymYPCdB+EUO+3o
	M97zOPBctsOt1hbCMfh535PGVJYXK71j0vGS3VigBzjMHFK3bqVpf+1uZGXwBkEbiGxqPEe
	SKV5o+B1RfMVIabzsXGUcTU5GJtXRbljuinTFeV9rM87RV1VWmVV5jhPPHiGUqw1a6DkSI1
	4iGkdhe9oGThX1ONp697klZYVIx9uGmyx+H7b/HLyYuaiyz5IrHj/Ov40qqz8RWUWyazCbr
	9Qm5Xjq7Qx3VSW+P2c1F5QmKpQz5SS+/D7U3Rkx/+v4hRU7cLaebAIm4x6hbiMyBEh+iML9
	k4aEXttnCyOo77atA+l9eOQ3zBHg/qgfwHfblJi/ewz8S71KEJhupj9Jft5SsBjTAWPE9l4
	tPT2FlSlDq52KzSwegLhErfQRnp2tpTGXy809L8s0bq0GwNMZ0OcjcqM7e/qX22fONiKyVE
	r7ziGiriBh2XAum54EJhk9YRyolQKOSOuxO6GTcfYMbbT7Iz9wNtOw0i1xknF1bFf6ACTqa
	3ZG66MgmGRFoifGjEYh7/YkkSYTssFkEGD6TlKaVn2xn5lfwiMffUhW8Dsih6TpWMYx08Qq
	8edqkd3/TKDxTOjry7AIseT0DtxrkazHOzdKyCkEKYpKYPqy7DD4q3eRChEgE9WNggeVJVv
	TmENO2uwcY7iOn0aDegUKeFCU1cfL21QWwRtFiP3kGDusUeProkICK6v/VQUiBIi1fBwXbr
	lyjaJNfBM/a5dORPVmjQif0PnuGVEch9fdSez30uwAjS48q0hOugEN4OsobTGeu/cW3AMOx
	Eg7va1DcmcJKPKT+IE791DdJa/9x3Wg0Y+RfowI2Dg8JRMXgJP23RPli+TKMh6MwHUavHJM
	MWrdsVuiLV8kbmDQCc3kBrysiUHmJyruw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit e1201bc781c28766720e78a5e099ffa568be4d74 ]

Static key offsets should always be on 32 bit boundaries. Validate them on
create/update time for static offsets and move the datapath validation
for runtime offsets only.

iproute2 already errors out if a given offset and data size cannot be
packed to a 32 bit boundary. This change will make sure users which
create/update pedit instances directly via netlink also error out,
instead of finding out when packets are traversing.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 957ce9017c3f7..95ae885ecba16 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -239,8 +239,16 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 	memcpy(nparms->tcfp_keys, parm->keys, ksize);
 
 	for (i = 0; i < nparms->tcfp_nkeys; ++i) {
+		u32 offmask = nparms->tcfp_keys[i].offmask;
 		u32 cur = nparms->tcfp_keys[i].off;
 
+		/* The AT option can be added to static offsets in the datapath */
+		if (!offmask && cur % 4) {
+			NL_SET_ERR_MSG_MOD(extack, "Offsets must be on 32bit boundaries");
+			ret = -EINVAL;
+			goto put_chain;
+		}
+
 		/* sanitize the shift value for any later use */
 		nparms->tcfp_keys[i].shift = min_t(size_t,
 						   BITS_PER_TYPE(int) - 1,
@@ -249,7 +257,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		/* The AT option can read a single byte, we can bound the actual
 		 * value with uchar max.
 		 */
-		cur += (0xff & nparms->tcfp_keys[i].offmask) >> nparms->tcfp_keys[i].shift;
+		cur += (0xff & offmask) >> nparms->tcfp_keys[i].shift;
 
 		/* Each key touches 4 bytes starting from the computed offset */
 		nparms->tcfp_off_max_hint =
@@ -383,12 +391,12 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 					       sizeof(_d), &_d);
 			if (!d)
 				goto bad;
-			offset += (*d & tkey->offmask) >> tkey->shift;
-		}
 
-		if (offset % 4) {
-			pr_info("tc action pedit offset must be on 32 bit boundaries\n");
-			goto bad;
+			offset += (*d & tkey->offmask) >> tkey->shift;
+			if (offset % 4) {
+				pr_info("tc action pedit offset must be on 32 bit boundaries\n");
+				goto bad;
+			}
 		}
 
 		if (!offset_valid(skb, hoffset + offset)) {
-- 
2.30.2

