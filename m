Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF103D75C7
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769324; cv=none; b=MshF7uw7Gi33fUPHuRuM/cuDzZz92d59mOCYZp2IRaP2WBg6NKjX6pb1t8++PO2Iy1+PbcxMLT6Yp2IVa/5FGryAGQ2qoiH8TuqqE4TNKKlm75eRvexhWXrC2SYVAd3uQc/xLZxqbKZOqBh7tBVbZnPND7giRXjCn/9qTo8Jnik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769324; c=relaxed/simple;
	bh=t47PQtuLrsRXqwdH/IGpzs+bZ2ogQNf5phwRn+1HUWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gccrOUjOsPw0otZxZBPBNRbp3jnV/+TFiaGSww3nzYLDMeJIs1iEd+WooVPETKV5mxTteyu0O931JyXgfBvdJY/uK15w+M4ijH/lvXrHhwV7q6gGlLhcWHzJo6VjhsEFbp7JsiYchpenhUB6PGJk7sVbUUaCWXofmYIj97Sl0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=EVGqlct7; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="EVGqlct7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781769295;
	bh=ck/XS0nE9UNwriqvEIQIIrrdC2vQw4Suitib0XE45Do=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=EVGqlct7pmJj6z5MLWqq+/tLPmK13FeLNOXYH9Fl7Zs1qZtC0sPETWL5F9Cet/uDd
	 sLIbSRt1h+dkMzMG2t6PF2W//Pp5d1gS7kymC5bABeb750griJ4nA7+nYCPnNxrsz5
	 8bfxebHjT0JgppBIAMvidCg9w55arStXXzoRX4Bo=
X-QQ-mid: esmtpgz14t1781769276t69bf22ea
X-QQ-Originating-IP: +i2cuPGhgO6ABY6eAkpfeZTUEkjlgwUhnzzLYZg0Hh0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 15:54:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17691181396673560340
EX-QQ-RecipientCnt: 17
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.10.y v2 5/9] net/sched: act_pedit: check static offsets a priori
Date: Thu, 18 Jun 2026 15:53:44 +0800
Message-Id: <20260618075342.1599593-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618075342.1599593-1-guanwentao@uniontech.com>
References: <20260618075342.1599593-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OCFGt05vYz7YjruEjZgWPlLIN5f2la+Rv2Efg+iCyUz2o8DYFFuTseg0
	nC3pz4vSXUhDhfl3eaO/63IBcvN7l0LTXGnB3Hl5CvQBA1JX+BRec6fmC73u9mDB43WA5ze
	ZOQEpJfaGNr1Q7l2TG5gBi7w8g/7ciABL2o9BROropX/con5kHXshZixpjUqTsOp+h+Aruz
	WWtPR6fIK/xdk09IC5tsZxmcuKZ8bx+PCIXYs1jhLck4DPYzAPDPLQbAuGrnEh9233vO30O
	F//jby7JtugEydLe3nTjNfzIVI7xmFi/NPcdQ4a1GyKLROiWEHsY1ffdgEOtqGmLYC9+aJf
	HFefkS/CQAm9HmVlR49XBFC1FuA+tv5qw2gfMgUVdg1uURnJi+LDfxjY6RpfrEOJZubQ2Mb
	LPL+kPo9PtiuhZB+RuhATeWPbBorKF1HxWtLy1XGnKiuMu4J0VhYBkkppnZAJoq31MWYM5L
	l6msdw3znsB2AGz0Vi76kL9Wl8G61tc+D3NOL4F+xKAc/AmCo3+2xz8JBI7kkr2GQEWjuLk
	2LsKZdPMvEN/zyV/gCwHbMUpWeGouKa0nxrR5Z0eox+BFbhfKuc6ocFhZQlGsiOluiGV+Ez
	z61EGasIfw6fJwolreWFy/n9jvAvC7CZvotR1sLhsxQcF4gv+Xz8DC5HQjkdYfJXfX6zoNZ
	fU5DPdyBFZG5mUEHAf0/mLoSKM1wtC9xfnIIC4Z0n8th323CZq+NhcVU3AZdCh+Ak1Z3MUB
	gIlUEA8F7l7/V6qOcx7hXKlxYDTKi0kuyo3OHWIQ7Bse9CbZG9f3QRQeYIg7gPIpbQTy8US
	OAOrttfgWYIIBvE4/wjJGT9WIGNjf8ClrKRVL6RZTh/62XkmDuCIeiVbPovtmpWxI5E2mR+
	b1ArfayK2WTuCvKo2MhwLTv04Q6MrGgWlOXkd38G0sxm2Zn8Im/zelwEY6wjg6VvV8ucD9h
	FvJRD7XaaNtFHCW2TkSoL5gTZca0MUTdASywdloUQc/5c6MKtnmgcx2xDs7vx7e3ose+mXv
	YanTfCOKQjwKyF3Sw0W/1v+VG2rHusCJ22QceUte4cgTBSlyDEozMf4d3NNYP35CQ/lElCr
	8/rO3lI5R7t924WWgHGwHCUuevlxQEQiHyGmWY9aYzG
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

