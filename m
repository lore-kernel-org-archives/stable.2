Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3D33555F
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823859; cv=none; b=X8wbrecs7XMjVa51NqzqBGUIL8UwtG71XKIqzmQsHi5y07jQuMRny/UTSXpQcM0PIr7Lt/XQrrzLbmeVQ/kRZz8mYKzWH7KyIGfa/asQR6v+4M7tgn/Z3L6gAk2IDLQOjKZmiM7TEGRWw1nZkMIqudtPIkGmvgBOkHQaaCk9A9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823859; c=relaxed/simple;
	bh=6L1PVLST7v1nkRF+r8Iv2XGopCR5emnQnssaQ73pjKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iosKEQ0LIsWUZk5etChFINPALQvRoTs5HX+WArkL7DM7TQpFTOLqDoCis1WtHol/W+I9rS+KMpSq1B8GH4DMHRUhSuBP6EtTcXJvJPsNmw+TTdPdHu+34bAu2IpN95/mW+Uzz0p0YW7G7heYAqK4sCjuoooybVUpzOGAme2GxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=VLfa1xOg; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="VLfa1xOg"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8efbafa1bacso22764466d6.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 23:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1785823857; x=1786428657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DuDYSjJQEMSMyuu+bbvopLn43BBsmPMFs7o1wHmptzs=;
        b=VLfa1xOgk01S0I2L6YD4aRtKIaQinZJQojLMS+83TLQgeFf4npsXh9E93ApIT1LL5/
         hawKrs8rZBJJwKbQsQR8Nnha6DM89JW1ZWX/Uoq0jRO2sVwiT/Pog1WwGuYlV19Sttzp
         XR64xo1TYSz8hSq969/dRX7Z/nrxePk3psYqiIo9eqPvhE7edxq/tVWtKCq6BoRbYVOV
         tvuf+H2uTkJDsf8612X+N6vE9erSzQZ89iWpSelr1UqSlXjiKwNPCVTT2E0bw7YQT/Or
         RBBQwHsAnwF/kMUCpfzfj4zG5aTj8scSOR3dEGkbmr3qIpuoAkGIQxDhhVqusX8BC10J
         0EQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823857; x=1786428657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DuDYSjJQEMSMyuu+bbvopLn43BBsmPMFs7o1wHmptzs=;
        b=AeIb+eeStWBdtFnyGkyXgivzq71myXIhx3VRt6qRhdrqYzeR2yZoqepsSuQexvh1g2
         MSgkwx0zSrtwD4fEjhoSgYfYc/xE72ClmaxNFWQfYCBgvehjnCSDithLutTpitZ9wOBG
         Ni4o07Bpld53CCXWRkTcq12BmJVSrVU5sWkLcV14BYiNcbVSZLLUPcGapXpu2axaYy9E
         g+5jC3OKdwi/JVNENaE5GLDeWf2OkAyOyvzwDuwHm+u5N7VkbhIiY0l6IQLtr5vFPA4P
         AjXR/YiQzpFeA3tkcEP69qchyzEnWQXgWKUTT70F0r87wWZpGPOq2UQDp72W23yh36Qr
         ERFw==
X-Forwarded-Encrypted: i=1; AHgh+RqS5Z4rYcZcPy0C6MAbZ03Z2LE/3XcZjFXygZKrTPcxM05FZh7oD8RY2WvzgM5txi4pAIjUprE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG30D0Kaeu4DVSDeuMaUeXbo7Zp4pO36armCQG9YB9xYsvtNrE
	JitEwR7ifuBWNEXTkpYZRW3GW0oC+LgmvIJnTFc2jGdswfzlBxBqUDvTGCqXTAt0910=
X-Gm-Gg: AR+sD12JyLreuYG0A7AUAZm1bDxmnE0bRCi/EvQ6PInMiuMjs0H8NILBbQLv6mQ25eA
	BBszGKgt2tfQ3rFGK9eyJITZqWjVeQSZuM+Ev+bz2NJXw+xyaHLJL5WYaF8lhktHHJ7QH52yXVm
	93hVeB9ZlCtEXrhMnqrnp0JxlK7IhK9vvQDJ6rwTm78h7uE10Vj4TMoX9g8/lbiRa4t5O+rGVIo
	h0850nS/VmYbu7N4n5DDmnx3BqgiuNxK9gg619VpBFMItln+JnrdPKA4M8blDbTm/0nPEdeorsE
	0rihI0A1rKvXQ1GhU9s/aG2QE+DZxOIwOdz1tF21BFLBlDzia8hMd42ZsNxW0gtDYtU51MmpohV
	3YtsSFrUHR7YkKWcQvqs2Z3gO90SmHjIs7bFEyi+f4GJs4m3QLa7jEvMt5LqHjrxla+xEUR1P6V
	K5xN3+GEnlLiI30eXeNUHnPwTgZU3MlUAbd/eGZWuCSuyLFs/dlR2LWyFCulXbngon1w==
X-Received: by 2002:a05:6214:2f02:b0:8ea:184f:c15a with SMTP id 6a1803df08f44-90849600a6emr294349336d6.17.1785823856908;
        Mon, 03 Aug 2026 23:10:56 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-908435eab41sm92617856d6.34.2026.08.03.23.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 23:10:56 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: horms@verge.net.au,
	ja@ssi.bg,
	pablo@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kyle Zeng <kylebot@openai.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	Sven Eckelmann <sven@narfation.org>,
	phil@nwl.cc,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH nf v2] ipvs: clear IPv4 options after rebasing tunnel ICMP errors
Date: Tue,  4 Aug 2026 06:10:55 +0000
Message-ID: <20260804061055.711402-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

ip_vs_in_icmp() rebases an skb from the outer ICMP packet to the
quoted original request before passing it to icmp_send(). However,
IPCB(skb)->opt still describes the outer IPv4 header.

A timestamp option in the outer header can therefore leave an offset
that points into the quoted transport header after the rebase.
__ip_options_echo() treats a byte at that stale location as the option
length and copies it into the fixed-size option storage on the
__icmp_send() stack, causing a stack out-of-bounds write.

Clear the stale option metadata after resetting the network header.
Keep the remaining control block fields, including the ingress
interface used by the ICMP response path.

Fixes: f2edb9f7706d ("ipvs: implement passive PMTUD for IPIP packets")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v2:
- Add the nf tree prefix to the subject.
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.

v1: https://lore.kernel.org/netdev/20260731140822.567128-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN stack-out-of-bounds write in __ip_options_echo() and can share
if needed.

 net/netfilter/ipvs/ip_vs_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index bafab9345..fe06c380c 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1951,6 +1951,7 @@ ip_vs_in_icmp(struct netns_ipvs *ipvs, struct sk_buff *skb, int *related,
 		if (pskb_pull(skb, offset2) == NULL)
 			goto ignore_tunnel;
 		skb_reset_network_header(skb);
+		memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 		/* Ensure the IP header is present in headroom */
 		if (!pskb_may_pull(skb, hlen_orig))
 			goto ignore_tunnel;
-- 
2.53.0
