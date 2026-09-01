Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3546A5EC
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298800; cv=none; b=T6/3+e+luT2Vov7OIi/OZ/BvEoHWORqiT1SGTveFt5QRkp8Ji+At0K0cGGpo8G/tYiOkF1QGQpOLb1WtPmbKbqMz+uAIr/Sgal+2zTloZVOAV6XKcbnoIgcFUhwxUFSqCz+xXVKK4RDIJ1K/3UgbqsRDq4egMicvejqxjRhpK8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298800; c=relaxed/simple;
	bh=CZcYT4H12Z590tau+Ggna8NfSJnrXJarOehmwomiNFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Feyrv5qBkY/vz2yk4IVLWA3YLV1Twrkn8Yv9tvIttxnWAt3nJAzcWDNo4YroHcrAn9OoqnNNiGLqsYLVWxKWlBLG7t6xt6DzmiSMVf2tC72hvT7cmNUsF891eddpGs4jnlD1LouBOBnZwnsrvy+RrXud48zHg+w+1EhMcxyCXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=yCxcr2Ba; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="yCxcr2Ba"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90ce08834feso5242856d6.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298798; x=1788903598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CS83/1OzQ4e6zuu3aLpz2rT1vWyNGuyjDUNfgFfyELQ=;
        b=yCxcr2BaY/ACBZRF1Ady0aVx4EePC9tdRrCIl+SjymkRadmLyCooXIinbYzzle0Xcj
         h/KHDT3pu9VSyW4RnaROoSAim1mmo3zB9W+V18RDYv05k1MRQgDNVWbLpMHCqfbLlFYm
         FJsG5duA0JkvjDZkLJoQp2AX/X7BCiZBc6mco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298798; x=1788903598;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CS83/1OzQ4e6zuu3aLpz2rT1vWyNGuyjDUNfgFfyELQ=;
        b=czJKyHbVSsPeSiyIgCGWAeksu8428WqWwgzjgBZ+22HOwvjRbA/0v/Ha74qmDUfGFI
         QjdjXVf7XwcjDkPDeMqJhH3sKE1KYLvHtrWxWOTNmKxXECuYUUX96xTjXlm2lc53Aue2
         /4pYhWlONFIIDOw/k+Qf9dGHjQKBdnWs+iccwhLgcSMVK5716Z8skEneCb3AVCDUIyA+
         5AhhQvoiqOygiKZasfU5WXf/iAOQ+n/3R4XUoxFPHvnXlv95SFZyHxu62UyT0YZrWEG6
         a+iCygl79YyDlgfiwK5pV14OzlK2fo80PZLpPG2cm3K54UatGF6dNeE0GBNaDeFDgkyM
         8lAA==
X-Forwarded-Encrypted: i=1; AKwUvBw8tIuakrrjwo4bMcVRDytiwOw2PdzFySawI7vTwbGU6jA8/ocMifreIndGnF3eaVkAYBdExcU=@vger.kernel.org
X-Gm-Message-State: AFuF++msJZS14LX2n0uO917DmrWscdOiSuvlQhPZhiEyDL26yJMvTGm9
	jRvtP2s8KgVDBiK/EfL/ErTEwX53tFN6IflD8bfNq5Q9oZLWengLQWyhNHhRGXnxWw==
X-Gm-Gg: AYBFou1N01RLfC2B3zESXgRm8Zqm+DLLdkTiwFmxhhfeacKxuSqKeFNZLNPD+6X5dZk
	oRMHhw0kMOhEyj/FCG4V5Pr0dD8fmOHgZjJRBACjQ+sPMr4KgjUvKbOVsoML2MGOGMXxUBUFnk/
	0eoyD/QtCE9J1H6Z3nefOctgw6H9U56FQZqo438q1uotFjIJUNi2PImviLl5iwvmVciCRQBDpyN
	4MFeYtsD02UnaSwY3RPP5/7q582Z2zlSmVAUmJwyG6dNC0IMwxgvFP9mwDq42q255997sQ9mNbv
	tS/OZzWvH/VMrzKT5UwLrGjQJG2M48hK+B6/tnYGm/PMCMwgAYrAPp+yDj0Yn0kEOGR0Gmsx6Nh
	cUHbIBjusaUgPf3871phzn3CbjAusf3tRkGrrE2GMlRH8N06aeMs1PN1cLN29JLBD5M7ZcIvp2L
	jmScxoC/0K+O5H2Sbv/weU4gD7ywdbvBE11IhBFRtqwm2Nqo7M2SlMrJeXx1XWurTQl/etg/hCl
	CeH8AecbpFI1/6xj+Dn3ZEEI1YcWRi2zrhHpA==
X-Received: by 2002:a05:6214:3bc2:b0:90e:92a4:2194 with SMTP id 6a1803df08f44-90eca378bc3mr10695206d6.14.1788298798008;
        Tue, 01 Sep 2026 14:39:58 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm3458426d6.2.2026.09.01.14.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:39:56 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Vega <vega@nebusec.ai>,
	stable@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Vijay Subramanian <subramanian.vijay@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net v3 7/9] net/sched: drr: clamp quantum in change class
Date: Tue,  1 Sep 2026 17:39:28 -0400
Message-Id: <QDISC-0CFC.v3.20260901204856@mojatatu.com.8>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

drr_change_class() rejects explicit quantum==0 but falls back to
psched_mtu() with no floor. With a crafted size table qdisc_pkt_len
reaches ~2 GiB, so quantum=1 (or a zero psched_mtu on a headerless
device) makes the deficit-refill loop spin under the qdisc lock.

Add clamp_t(u32, quantum, 256, 1<<20) after the zero reject and on the
fallback path. The explicit-zero reject is preserved.

Conditions to recreate the bug:
  CONFIG_NET_SCH_DRR=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root drr
  tc class add dev dummy0 parent 1: classid 1:1 drr quantum 1

Fixes: 13d2a1d2b032 ("pkt_sched: add DRR scheduler")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_drr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 91b1ef824afa..8621d057edd9 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -82,8 +82,9 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			NL_SET_ERR_MSG(extack, "Specified DRR quantum cannot be zero");
 			return -EINVAL;
 		}
+		quantum = clamp_t(u32, quantum, 256, 1 << 20);
 	} else
-		quantum = psched_mtu(qdisc_dev(sch));
+		quantum = clamp_t(u32, (u32)psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
 
 	if (cl != NULL) {
 		if (tca[TCA_RATE]) {
-- 
2.43.0

