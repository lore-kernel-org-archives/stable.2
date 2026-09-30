Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1534104E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753480; cv=none; b=NMtqP39So8clFtHEkWYmZSDuGqo7erh5/vZXeT1VmTBsu0Gr+qDHamXbprat9m0E+/VfGYZ7q2/H5yjDF2iA6zOCkEqs2yTk8KcZr1EKYqvva2n9ba383bXbCQHJ2ZjA0RON8Ec19Z1ssVOCPIvEuRQvqC/+9997YKsGEz6Lolc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753480; c=relaxed/simple;
	bh=aluq6XDX77di7kfn43swR2cM2XeDL6dQliyhlLnI1Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KmO272C+u7FK8iaziZDG82lmB5apbJtea5EPYwajXRSMiM9X4y6wxS+wnaCIL5pdqHIQLztrYf+Dnk4U6BfHDQEuvD+TmKPBEyp/YXWsf7khwFs+GA9V+ZMGXfN0KFHPn1hAeNbFFeHVNK/d2oPvatAJBtc6EapCIBOba40aEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=hRBsyt43; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="hRBsyt43"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5d67aa05so462965385a.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790753478; x=1791358278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R9i+4Nh+hm2eKyiJR0k0Xb2So8Jv28e3f/mMEot2DDY=;
        b=hRBsyt43Y5GR1842RI0Vpm5mhMmPtZelsPovzhGBvHDPmrkJmwMLwyFRKxq0XxD/T3
         KcHjBEtvcwVGKsWd/puACt3KdKoh1/mCdg/2wGvjo22nfme58njEoBZqiNBaTnUFgubg
         +E2o1nhixWNCpw9AVGDGVzs2yLo4CsrCy/ul0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790753478; x=1791358278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9i+4Nh+hm2eKyiJR0k0Xb2So8Jv28e3f/mMEot2DDY=;
        b=aD1p14fzao9qWpUoFfBr/tRGa/a5bQI2BRJ/WyYoU70gugc2v0szsNGWaaBdLk6o54
         XhLO/2uDTmqgoJTkfd9tqXivrs1mzt00tMF3zxFSBQQxRtXIrux5Rw7y1LWQxdDM9hko
         je2W+lCVeJ2yAbaNQY7W7sN5DkuCXqmfMjDb8WMWFAYFuoVf1zKs++PAVXbsG37rh1ZW
         ZIdMptM3djSQl6gRFYgb5SNT3jlkghQW9osTA4zHIx7ob94O2Dg79s4pPkXy0mtiSM7x
         e+YTyk9FlLwS5TZYWubN/LYsIJTAs4xlYldLnG3jedwADNWxR/7tFsicXXOr01pfXUJK
         PGTw==
X-Forwarded-Encrypted: i=1; AKwUvBxh568ZwwNFZFyukUjNJiaz2JYLwc/89t6QKTQ0YPMrFW58ZrWMTrnf4XcgQdb26ptKZpILqmI=@vger.kernel.org
X-Gm-Message-State: AFuF++lA0dEwFUdAEn8jOpLNclRNj/xQ/zbI5VMW3r/W9JJvDU4Hd9TH
	k8qHZX/3JtG7pWuKfT9dNfHWVKj8SsbP8GLoOBsqalBimHvbmSGEUXrT+FTIIco26Q==
X-Gm-Gg: AYBFou0BzoogJSPomLrb7/4SR6UkoiztGoY2Ba1wQcZ3CCNQMnCvX7wcWfVDR1CCe0z
	w4wNkxBjQDO6R7UE9hV7YCpH9pjPJvET+3Uoop1v6bv7pdY0pdPd6TRCLLh7g0JdJrt3fx536hY
	TwgvbDVWljZKx9JTHcUo5LNLDz8n7PXX8bLjiNlYcFoJKNPUwCKSus1rNun19txn4pZVIHuItvB
	47sT6t3+N+FRHnG/EE/jCZwvc4hGGqIpTXPQ9ub/W1wK4T4e/DUZIyivG2GMuenWOuMTdrxUsl6
	FP1VUfPpCYKliaQa3mz00mDxBSBYXJelpTbf8NYAXE9RI2Sd+QdJ8BCoqiZrb9/dTnqXeKkrt8e
	J+XMH/F4UunhaD8k8FBLWhMF6rrgoSvkslBtvplzVq/t66YoGXUES5qwQyrXvxrzi2lB/hGgE8k
	kQ9nxd4xI7xK47Hd96YmBClhvoGG/S/6mAngY9zzByoukmbTOEBf+Fz2Jaz/bP7f1nM8cxtxeyr
	Q3BpQJv3Y9kBMDFpG6iBEHLcGS2uw0cKwFQG7EB/UhCuRpW8g==
X-Received: by 2002:a05:620a:4713:b0:939:6132:62cc with SMTP id af79cd13be357-93ca96c72f7mr82625885a.27.1790753477544;
        Wed, 30 Sep 2026 00:31:17 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ca82ea561sm55706785a.33.2026.09.30.00.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:31:17 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Thomas Graf <tgraf@suug.ch>,
	hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: em_text: reject unterminated algo before autoload
Date: Wed, 30 Sep 2026 03:31:02 -0400
Message-Id: <QDISC-2DIU.v1.20260929183844@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This is a follow-up to commit 9c572a83037a ("net/sched: fix potential
stack infoleak in em_text_dump()"), which zero-initialised the dump-side
struct. Sashiko pointed at a pre-existing bug that exposed the change-side
input-validation gap open.

em_text_change() casts the raw netlink attribute payload to struct
tcf_em_text and passes conf->algo, a 16-byte array with no enforced NUL
terminator, to textsearch_prepare().  On the TS_AUTOLOAD retry
textsearch_prepare() calls request_module("ts_%s", algo); vsnprintf()
walks %s until it finds a NUL, so an algo[] with no NUL reads past the
array into the adjacent struct fields and payload and feeds those bytes
to the usermode helper command line.  This is an out-of-bounds read and
a kernel memory disclosure.

Reject the attribute when no NUL exists within TC_EM_TEXT_ALGOSIZ bytes,
matching the check xt_string has had since 3ab720881b6e.

Conditions to recreate the bug:
- CAP_NET_ADMIN on the target netns (namespace-local via unshare -Urn
  is enough)
- install clsact on an interface, then add a basic filter with one text
  ematch whose algo[] is 16 bytes with no NUL (e.g. "A"*16) and
  pattern_len at least 1
- the add fails with -ENOENT and the kernel invokes modprobe with a
  module name made of "ts_" plus the 16 bytes and the adjacent payload

Fixes: d675c989ed2d4 ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260918133953.12494-1-bernard.ladenthin%40gmail.com
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/em_text.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 4132f8c3c5fc..bc45edb8c03b 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -58,6 +58,9 @@ static int em_text_change(struct net *net, void *data, int len,
 	if (len < sizeof(*conf) || len < (sizeof(*conf) + conf->pattern_len))
 		return -EINVAL;
 
+	if (!memchr(conf->algo, '\0', sizeof(conf->algo)))
+		return -EINVAL;
+
 	if (conf->from_layer > conf->to_layer)
 		return -EINVAL;
 
-- 
2.43.0

