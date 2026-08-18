Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6E41C6A
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787091369; cv=none; b=sQvfc8OxeouEKwwSWqTgCfmwK3YhORtmFiKt8vkVCKpB6s5U0gboNMdfyqu9YxFZOS5MFE6SR90VkWa5uUvFrEA1VjYm2RrDMqM7rUVODt3aQ03xwD4soPRb+lMqvf16j+ajqoDsTreE4ezV/A5+rKdP7/71goSQWyah66uR8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787091369; c=relaxed/simple;
	bh=5pCMJvmTRWodZPjIeaJ9tOdNMSzMsh3PNy0m9xaH0Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB3noJEflk2PC7SjVdJ3OO7TZQnmuuSDOP5r5yvWCg4yb4UYpOzRy0i+M3efIXcaVtqQkLrmFPcgIl2Mj719rSIyolXvtWYt9XWaiCMjbeZ+iZlBHssGAoVMFtHisewfLewqUe/T63HYnUvmjdq+k5d3L+lcodFVfd85ImLZDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEpbvnPV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEpbvnPV"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbee846deecso331679a12.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787091367; x=1787696167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYpN2ZOSXMQHmxIbzvwC74/jrfpE9711u+W0ljMUVKI=;
        b=BEpbvnPVZNTuCSV3/15FcaoMHFwh/1kUTEjRAZ1Bx4TN4CvZAYVGuKf1l88Igke+Ky
         Jbiq0wh4ctHi+NA2vAbgM0j911+uUxSxJYGUxI20ye3oJB/gtY+6mXtkHWI+zrdooayl
         hqA3pZW3ODQruGnqGT8Zs/1wFly5hoFCu3W2DYpNidcg8FVOwqB6MEIY3KaVoxuGwFlx
         cU5fW/23KAWs7/WYxtCXbGNG7uZ8EGJWiRXyZWu/KVaQeRfSkBQ5xKvJmMNOu9grIlW0
         CzlHa9GK8OYa21p6DJ2siU41puyiyt9Dd7SsxepFVj23axJPIu6kJYVRhocouREPQTGq
         bW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787091367; x=1787696167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aYpN2ZOSXMQHmxIbzvwC74/jrfpE9711u+W0ljMUVKI=;
        b=E1v0GU9Qn6KfXWyerqj7V8RfEyk/4Q7oneFvwZqo4G+k13svwTROOtzVzmN77X2k/v
         CwgmLjm3LyylKTqPLEuQcliedfZOel0Oj5lGb8fWD+tAl4E1hy/izM/ez5cdaK22UKCr
         MwFyc9NpSahOzfWy8iUEuEtG1G1Vd3HYaI2NFH+OSwCo9mI/hdpKgUIa7Rmb6drEnzcf
         UtNupg7nTp8/p25Q4qrX+6mAS7gDHBgJqndO4iJ5bycS4RuFq/nl/bmr2r16PuweiMH3
         +xdjDwV74g8EywF8lFJcQay/LAze8wxYqn9cmfZVtKeeQ1KNA2S3aPWxNaKKdd2WhJzJ
         K5tw==
X-Forwarded-Encrypted: i=1; AHgh+Rpo885PtUvL/TpXgimByxFi0IUUlYL1gotuhVJj+QjAckDkDA1dhExxYKLV9T1ONFeWzADSmYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9XI//vQhZm/nCRnvXbAV9bjM2MJx6VGiWF093XYIhGQHDnU5E
	Op0O2EotUK5DowvSdVoojYf88A+ZF9qoNf0X6CVAWi93okIOH25pQEXb
X-Gm-Gg: AR+sD13FvOk/OIhSCLXFkjYZJreJOc66bQ8p84Xm/PxYZAvU6Lf6G9p07NREzMvznKG
	PuDEOlYn4PBDIpbbHb8DcHmreab2ORS4KUTP2S9p1+NMpi9T1f+QMM7QRadW3HIEdMJQr6mFslc
	6Kn89GHsoSBvuqVMty2GEf3lURwQYF3ovNUGISz+u7S61remMNRwFtiTY79HjOD0k4VENVuXvCM
	BKEtVa2VbQXlkjMgVXmv0+viLz9K3RhqwLaEnWr7Y62R3bMw8/9xR/C5JZIgGOZeTUDe6ewGi7p
	y0rdOKf0t5PW/bDJCXdtM4/VA4MdnN4nPNf1JIwTEYrTQJifM91pica5zg0Sc1oBN5pFcm0K4iv
	8/mkMxqzlLJVPyMv9fCVBDsz/dhWIJTkhozso/wWOSJcZDaDkuV0bAKCJcj0LF9w/EBknEyRHPk
	0kfRFFCHyPkEAgP0MXwQSOrX+ht56YcHcdZdAHuvK+JYy+sIHofGahlPT5IwxfC+l3Jon37Q1nq
	nwJNdwDZun6PUmo+kjpvXyAWR4zRKWKD88yIDHtsw==
X-Received: by 2002:a05:6a20:e607:b0:3c3:89ce:b5bc with SMTP id adf61e73a8af0-3cd01213941mr682869637.15.1787091366743;
        Tue, 18 Aug 2026 15:16:06 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10d497sm223707eec.14.2026.08.18.15.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:16:05 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net] net/sched: act_csum: Fix missing headroom COW and integer underflow in header rewriting
Date: Wed, 19 Aug 2026 03:15:19 +0500
Message-ID: <20260818221519.75088-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818221519.75088-1-meatuni001@gmail.com>
References: <20260818221519.75088-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_csum_skb_nextlayer() and tcf_csum_ipv4() access and rewrite IP and L4
headers based on ntkoff = skb_network_offset(skb).

When the network header resides in the headroom (ntkoff < 0):
1. hl + ntkoff or sizeof(*iph) + ntkoff can evaluate to a negative value
   or underflow when passed to functions expecting unsigned lengths, such
   as pskb_may_pull() and skb_try_make_writable().
2. skb_try_make_writable() only evaluates writability from skb->data
   forwards and does not invoke skb_cow() on the headroom. When modifying
   cloned SKBs (e.g. from packet sockets, tc mirred, or BPF redirects),
   updating headers via ip_send_check() or L4 checksum replacements mutates
   shared headroom data directly, leading to packet corruption and page
   cache corruption.

Fix this by introducing a helper csum_ensure_writable() that validates
headroom using skb_cow(skb, -offset) when offset is negative before
ensuring writability across the modified header length.

Fixes: eb4d40654505 ("net/sched: add ACT_CSUM action to update packets checksums")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/sched/act_csum.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index a8e2b83ebae5..cd2a6e974e6f 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -124,6 +124,18 @@ static int tcf_csum_init(struct net *net, struct nlattr *nla,
 	return err;
 }
 
+static int csum_ensure_writable(struct sk_buff *skb, int offset, size_t len)
+{
+	if (offset < 0) {
+		if (skb_cow(skb, -offset))
+			return -ENOMEM;
+		if (offset + (int)len > 0)
+			return skb_ensure_writable(skb, offset + len);
+		return 0;
+	}
+	return skb_ensure_writable(skb, offset + len);
+}
+
 /**
  * tcf_csum_skb_nextlayer - Get next layer pointer
  * @skb: sk_buff to use
@@ -139,8 +151,7 @@ static void *tcf_csum_skb_nextlayer(struct sk_buff *skb,
 	int ntkoff = skb_network_offset(skb);
 	int hl = ihl + jhl;
 
-	if (!pskb_may_pull(skb, ipl + ntkoff) || (ipl < hl) ||
-	    skb_try_make_writable(skb, hl + ntkoff))
+	if (ipl < hl || csum_ensure_writable(skb, ntkoff, max_t(unsigned int, ipl, hl)))
 		return NULL;
 	else
 		return (void *)(skb_network_header(skb) + ihl);
@@ -437,8 +448,8 @@ static int tcf_csum_ipv4(struct sk_buff *skb, u32 update_flags)
 	}
 
 	if (update_flags & TCA_CSUM_UPDATE_FLAG_IPV4HDR) {
-		if (skb_try_make_writable(skb, sizeof(*iph) + ntkoff))
+		if (csum_ensure_writable(skb, ntkoff, sizeof(*iph)))
 			goto fail;
 
 		ip_send_check(ip_hdr(skb));
 	}
-- 
2.43.0
