Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919503BED66
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791132647; cv=none; b=Bwioxtn94K56poh33AfuWKXIhVyn26iyCzkLgaY5DH/bpjCceMvlQ7mZ/VaTI5f7d6AspRT6HcgPE2s2JEGvl9vsQgcNTISfVGcD4HItyWRlNNJccdZDFmbqAP/FLM0LMYQsba+aQ3lqKKMtQpY8O5BSi4nSkE+I4hFPmB7NoyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791132647; c=relaxed/simple;
	bh=cXu03aRI4HlDFmA/qrIbHpH3YMt7cA3OCGBqlEfijzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auqUsxdpkNJ5xa8FkqUipU1bfskV+9BGH4wG8BOQP4PgfXSN/FfUns03PAhSBO8zKfSJTuo3w1tonGznFyocpDUPJjOeiotrbnJsc1dVpjnYWukBEQS7HS4HgFV9Gd1pNlT9iWeBXwxax+Y54kWnYqFB4Nsh3OU3LtN2XchNWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoKY2AD0; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoKY2AD0"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bffc8105eso1265991eec.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791132643; x=1791737443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/PJMyB/tCoGml/sAKt25M4BdbNdvXYz8ZJZF7qGSo50=;
        b=eoKY2AD0iVZzyw0mFj+ogfL8xQCA1SStNsag6EFDnCg+yeiGohVS6M5cZz7EvxnPYy
         qnUS3HRWZ7ouUOJ0ULUKhsam6kjYAnhsdZ9YUulwqEcP3/8R0dQID9k2lFeANmGKhpGO
         d2vcgU3o7RH1wL6L6EGgCAmi+J271XFaPQg9Rfxg5O8yc09pL+rHquLCZM3nAm0XY/WC
         S/7NTRUHFNeOPQBmvh26BkEA4F/G5nhe/7CkzPEp78UWflw0BQUmfBb2spJHnCJVJTbs
         AqBzk8hu95Wo5Z06+XTwZwZqcYClxU5crSH2EqjiokY8Atrp6JT5oS8u6TeKoIwJb5er
         lWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791132643; x=1791737443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/PJMyB/tCoGml/sAKt25M4BdbNdvXYz8ZJZF7qGSo50=;
        b=lGyWlZ7lAZs5POqbBwsQWwtbRrhWbz0ZhICstvlulF//5s5U6KeeIOVSPX4Q11ey6X
         faI1IHShW1leS8XkVXYhNIWkLd/iXfTN+ZkdtfPjYClumDQOovUd1BY/CfJOXwwmlpjN
         xR4tju4cZhq/lm/hoFLcUzENlBJRrMn2Skm3oVXYJdvApeBeYzpMqAgVI2XCMyIa3DMH
         2EgZD/MWbkzWVSOqMWkS1aG7PIEIEqBOEzr80VBbry+dl3Ga3zFw4E/WfR/nI/ImKenk
         GIBu1WOA9QpCpAIPzJ9IzHkY7IH8D6UAOy1VJR0TSwNJTzyjCQ4/rBX2wVdWHnBgm3CO
         s1vg==
X-Forwarded-Encrypted: i=1; AKwUvBxTpZ2dXTgSX7VTc6zjgc4ThYLtH/90rdPbjPTZgn4Ww8aY1dm+mchV2OElP5h9AgC3g3lPQ0Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWIu6U4rf6z723nThC2qiXDxxml7dvNV9C4sjNOTuOctRTkcw0
	8ENkWEVNz6WjMa1zjfOpMX1lDVLkOHjbv64JIKbLUit/c4VezltRb/8+1L14Rb9VdmA=
X-Gm-Gg: AYBFou2sYwUIKHOYzctVNQDwJdXQP5jmraI1QvIrAGE0yUfu1zVzwdSvQxR8x25MTi0
	ysm6711Gzd7jo4wvoMLz4cAqTsQQdnqGQ0VPE/cAOXsiVeld9UZ6STWWKb2o7sBiYWGS7qE2nfL
	gV0H8Ac/K1RVDOJMov81fVeZwQ6USeqYQXTQbJs4TeX5595t1rlBvF41w+nkX/M0H9zpx3Lucjq
	VqkdYCyc0+Y2cb64EjVK2uHwcoxZcunXMdzKa5/pAIbMwGs02eZUG8NDEnd8HOpxw7zcAcpTojd
	hJeS/94dcbuOg8MwHh285AGatOrICdhjsVNtU86EhngcRpfsZ2jikbGz/EqEeQxjKk/r90r4Q11
	wChaqIu6TGsg4tuRthHKKSEHHlfHw6CKdWu/1WOSdfIeAFyUD/142zkCys5yPU6AzzwsVyarOOz
	ddY6G8JPkfTPKYkls6qAc9kRrWhdcfvjxw5UHP2OG61lI3OUizFCAYq+iu9kDHnEzCpBRCt1Mca
	JjqrB6vYdPMZumPL+GOKUpBKUckSIKz
X-Received: by 2002:a05:7300:fe44:b0:343:9eb1:9940 with SMTP id 5a478bee46e88-34f2185a4e2mr10137138eec.26.1791132642992;
        Sun, 04 Oct 2026 09:50:42 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351273aaed6sm7009915eec.29.2026.10.04.09.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 09:50:42 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+71b6509cb791e531@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Eric Dumazet <edumazet@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2] tcp: reject zero CWND route metrics
Date: Mon,  5 Oct 2026 00:49:44 +0800
Message-ID: <20261004164944.2006741-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A process with CAP_NET_ADMIN in a user-created network namespace can send
an RTM_NEWROUTE request with RTAX_CWND set to zero. It can also set the
RTAX_CWND lock bit while omitting RTAX_CWND, leaving the zero-initialized
metric value locked. tcpm_suck_dst() copies the zero into the TCP metrics
cache, and tcp_init_metrics() later installs it as snd_cwnd_clamp. This
makes the initial cwnd zero and can reach a divide by zero in
tcp_cong_avoid_ai().

Reject zero RTAX_CWND and RTAX_INITCWND metrics while parsing route
metrics. Also reject a locked CWND without a value, so a zero CWND cannot
enter the TCP metrics cache.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Reported-by: co+71b6509cb791e531@bugs.sh
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/ipv4/metrics.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index ad40762a8b38..c26f95126ae7 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -54,9 +54,19 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
 			NL_SET_ERR_MSG(extack, "Unknown flag set in feature mask in metrics attribute");
 			return -EINVAL;
 		}
+		if ((type == RTAX_CWND || type == RTAX_INITCWND) && !val) {
+			NL_SET_ERR_MSG(extack, "CWND metric must be greater than zero");
+			return -EINVAL;
+		}
 		metrics[type - 1] = val;
 	}
 
+	if ((metrics[RTAX_LOCK - 1] & (1U << RTAX_CWND)) &&
+	    !metrics[RTAX_CWND - 1]) {
+		NL_SET_ERR_MSG(extack, "Locked CWND metric requires a value");
+		return -EINVAL;
+	}
+
 	if (ecn_ca)
 		metrics[RTAX_FEATURES - 1] |= DST_FEATURE_ECN_CA;
 
-- 
2.55.0

