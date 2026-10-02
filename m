Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED124A9D6C
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960190; cv=none; b=Yh6paTRd6xCDhwU3Z0FnHJSrLXCwnWDuwr9dzZUjEGeFawC7JtJd8wHqvfd66hEf4r+1RVx/o/XDystjLedU2Q/wWOJygshmUXOGS9Jdj3MOravYJYvBhbC0k9WSImsuRl39LBqSGY1OoP+NNhnwfllSycafWc9kSJSG2+UrP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960190; c=relaxed/simple;
	bh=yvr4THWK+b359x9GAPgm8g4XYqFtpb7xUBVoOJlXZcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0uTglw3YrR+jGLjMiTr0SFOtXqbWyZyzJ38r+6pwFN73RPoI8ntqBsv2Fz7+Cj3ISA9mJ0q3jHQp7E1DlP7JtayrwrABQdidAqB5kHIeei9RJQj1kR9iqCS+E3RHk7ACHE/tndHEaVtDYR2hlr3yFEUA2Y+rYIPviVyZoKfGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0TpSjbl; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0TpSjbl"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a49b6bb21eso125799a91.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790960179; x=1791564979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wizRrn3DJlyZ2Elw+HTCvVAyeo09ldgbQPuJfwoj4to=;
        b=V0TpSjblJqOITQLP4HRmGiGusoPvAiJmSlUsMhA44QX9wn8L9dgk3Ol7U3Ch9wjURQ
         RuHVvmt/u9CgtNigoIj97ZbzqA8cYZXZWeYemyzY44IeDcBMbdx4U7VFvgigwVa098yS
         pdgjN5LqiqKqijglQIhbsEEhXOqzuKkiH+our9Xtbazk789T9bs+Gt7U+gKKIJk/mQMi
         iCQvBx0HffOkXazwrA/hIZVvK/kU8C86sCdcfk3frN8Uhrl4EyFW4mdK4aO3TIxlGHY9
         VKzXoVMkoyllX5aYrlbcoobnQF0XzCxptnk4OjgtOgeWFSrnZAbQut0ix4VRdB/vCoBt
         prRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960179; x=1791564979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wizRrn3DJlyZ2Elw+HTCvVAyeo09ldgbQPuJfwoj4to=;
        b=CyyNeELQ+cmv+78nID5j81a8SvpxeLNXEIhIIZ089QeR7KPQjwqObb7RUhJUhhzuFd
         tAhynzCKGz2jrpbsP4D4hF85Di5upiZ9zrbltgC7WyBfa3OiSAWThsJdZmNSQttCFE6E
         ppfT1/+To2xw9ziGi6iaZzDpHqPZXyru8kWARNEIFgrZYecI8U0BF7ohcZYs5DA4nYrn
         3aKSmwPQaOf2OdYQl0kJ678z3hTWp+JYLCIIWrc0C0OwzfBx77kZpnl4xhsWeYqNNltr
         F3P/M8RRu/UmRVCVHN0S7ZLyefDG0y5ECMTEgYL1hD6IC85loLCpVu8mC1lteHQgeqvc
         hWIA==
X-Forwarded-Encrypted: i=1; AKwUvBwTQT5ODgP+tXiw12p42fjp24agHuajwwtHtkeJlsoOQGhvMnpY+l9tNqo+54i0jeAde7uqDvQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuwE15OSofqi244WNauxZU1hfYXBXHRe5SkqOvx8sV3PdDkHP3
	d/XbKZn7ivIYGCKSM7ecqS1CNsVeyPBlC75DRZKeZiWryTYaIydNjdwu
X-Gm-Gg: AYBFou3qJcfb/nz6mKqbllHnc31vy7Cv9JOSeULaCkjs0WrHD1MdYqgD+BzoiBxMO3V
	4JWb1N6ja9iXOLeln38IBaHTY9XvcqXtkQGSxsJPAcSDRRBkQ5j1AB8RYJSi9B5m8A6RXCKuMI+
	uMOdbHkfPd8FKw/bFJU6YHHfusNBZHBe9rukKfstXMpgL1ShbMZSRpe3oAviZ2KQT/Dbgrvx4Se
	aPY3IlSIBdWjdUATuOppI6arYrU++QMtjPAwdiTO+egU26Yw4Y/Bni0OkoRryV9oZF5oRJcFVX/
	vgqTUhPiHKN71FbUStryNyNqZV+6pkWlrqN1tDpPg9nfjh9Y6WYr8iePpKJaYQSTeSku3bLzAGL
	qo9f14j+5pG4WO93ih+yUf66Xtgo6r256Zo67F0myHt+LQOLPCP5FmZGCCHzsZgfkBxtuzC5XFz
	gk8zAxQPy2vJWE2sU9MCOna0MFYC+08Z+lN96VXn7FmjNCzigZVl5w7gf+jKHJb/FTbZjHjz0st
	1YYZ7FtimE=
X-Received: by 2002:a17:90b:3889:b0:3a7:eb0:119f with SMTP id 98e67ed59e1d1-3a70eb012e7mr335685a91.43.1790960174158;
        Fri, 02 Oct 2026 09:56:14 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6f7f7482dsm2448670a91.11.2026.10.02.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:56:13 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	4ncienth@gmail.com
Subject: [PATCH v2 net] netfilter: conntrack: reject nested ctnetlink master chains
Date: Sat,  3 Oct 2026 01:56:01 +0900
Message-ID: <20261002165601.1754467-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001180224.1018290-1-4ncienth@gmail.com>
References: <20261001180224.1018290-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conntracks created through ctnetlink can reference another conntrack as
their master.  Userspace can repeat this to build an unbounded chain whose
recursive destruction exhausts the kernel stack.

Stop the repeatable userspace paths.  Reject a direct master that already
has a master, and reject NFQUEUE-attached expectations for such conntracks.
Keep regular ctnetlink and kernel helper expectations unchanged.

Fixes: 5faa1f4cb5a1 ("[NETFILTER]: nf_conntrack_netlink: add support to related connections")
Cc: stable@vger.kernel.org
Suggested-by: Florian Westphal <fw@strlen.de>
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Replace iterative destruction with the maintainer-requested creation-time
  restrictions.
- Reject nested NFQUEUE-attached expectations while preserving regular
  ctnetlink and kernel helper expectations.

Tested on net 71a77ab76e74 and exact v6.12.105.  In both userns runs a
one-level master was accepted, 5,998 nested direct attempts returned
EOPNOTSUPP, and cleanup ended with nf_conntrack_count=0 without a crash.
A policy control also confirmed that terminal IPCTNL_MSG_EXP_NEW remains
accepted on a related master.  A real iptables NFQUEUE/NFQA_EXP control
created one expectation before the patch and none after it.  The related
object is W=1 warning-free.  The netdev allyesconfig and allmodconfig W=1
full builds were not run.

 net/netfilter/nf_conntrack_netlink.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 4e5d7c70143683..c68e79d1ac87b9 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2359,6 +2359,11 @@ ctnetlink_create_conntrack(struct net *net,
 			goto err2;
 		}
 		master_ct = nf_ct_tuplehash_to_ctrack(master_h);
+		if (master_ct->master) {
+			nf_ct_put(master_ct);
+			err = -EOPNOTSUPP;
+			goto err2;
+		}
 		__set_bit(IPS_EXPECTED_BIT, &ct->status);
 		ct->master = master_ct;
 	}
@@ -2864,6 +2869,9 @@ ctnetlink_glue_attach_expect(const struct nlattr *attr, struct nf_conn *ct,
 	struct nf_conntrack_expect *exp;
 	int err;
 
+	if (ct->master)
+		return -EOPNOTSUPP;
+
 	err = nla_parse_nested_deprecated(cda, CTA_EXPECT_MAX, attr,
 					  exp_nla_policy, NULL);
 	if (err < 0)
-- 
2.55.0
