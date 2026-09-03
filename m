Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5700249EC4A
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436543; cv=none; b=pThtNTytXUS+rRLm89CMNq9vGpVnxUBucmr4CN3TrmrIRMy20YSOB2ZpzL2Y+dQe3lCbUC37vK9wZesMf71qutCuPbQDuNNeff1XaUxBQg3pVlfIkL784uCyh+Be2dEUDPLHUqDGZGS38IohqltPrFi6gLwD1MlhPoNu7tMJTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436543; c=relaxed/simple;
	bh=DGBqDOeyzfNy+29WumkC3kdwnB2FhZZ+segPy9L+b28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfMfG++Uyv3rJyjCy/RY0n+YsvcYL4h1coN/QpKnH7W1zWHcf0Pz1ZDxiPMXzlE8RzxYyEvW3Thwhm6QzoRP3GEo1jf1vGhr174oPpkF4Qu39Ux4Ve1i2/HYBNmZ0E2vXi/FvpVmwACyyPrNIs3Xc4N13eZy36fRSrL+ysGll5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=fheNGpj1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="fheNGpj1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39927410578so3980768a91.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788436537; x=1789041337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1i8Z8yZUed8BAdZrDOJbsKwDdPch3XADEoDyC5AXu00=;
        b=fheNGpj1WPIhb3B98s/v7oSY2M1JDejBAVFPgWwF4/RllwHLGJlZcyZQHYUANcgoHV
         0uwJ+yuTwit82EvY4vF0wtAfPcqOMKNEUGGDM/uxjlcP6n6E4z2XC4zL7beOO15uMhPz
         xpbFmpfRsIm8mqGwHAiJhkY9xgOc5F8Dkju1X6CQRUjc5AkHM7VAn2t6qkRUwOYFxQAD
         zd+d0JSeJ00gPBMABx9GKYqGEiI09afFBjEP8EjwTuAo5edAEGXXt5ZtCdnyqEbsY8UI
         X/YVMrKJjT2LBis6Tv6rD9stMfy9S/yFFfr6vWDJ9srkv4KMvQL463Fq/svIrk7EFm7T
         5YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436537; x=1789041337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1i8Z8yZUed8BAdZrDOJbsKwDdPch3XADEoDyC5AXu00=;
        b=h0u7jyiDN/5TiMnju0ujLY33nBDr8AYZ4w80CbyilKRW0RuPUfs95K/xwZRb3Ll/QG
         hnVsDnnwNkuv+ejGwnzPhxDuhtaELyklSfUSGFzglluKVo+Mb0jGHEpK80xIHGknVPjs
         qACgu1dvCuLEG9U9spzPu7NUO0oTBINu8S4TKhklwVnH/1Kz++uK8gnOeC06CV0yP1pH
         /ftJzuKXLZduQUyGrcF1ejjGD81KB/2IIp+8VnatNqn4852zvli7GjHIC4a1hRTeoJ9h
         Ldui+UK9vlnOaYdtWhRWY8ttDkUDnzoOWLly0rgKdQCEQzDCZoOhIhSLnlYXKSCG0JAP
         Fuow==
X-Forwarded-Encrypted: i=1; AKwUvBwaNopuhpte6mUJx1+uRizL9lV64FvW3miRaC6llBHrL+CgJjh0c3E8nr9etwDwdEQ4D06olvM=@vger.kernel.org
X-Gm-Message-State: AFuF++lKYU2U0aRXIJwsLk0JT5V/sL0WNSzMUbOcfeGAcHKIDce1A6zf
	g3ARH9niyKhLqtwEaVjSnYu8i9qr6uQCoZSeVLsvVrM/aF7phhpS/Wo7u5t2fiA5uscq
X-Gm-Gg: AYBFou0Xx8siH7Osj2QNoRlbOEKNm37L/CoLMbAd3Im+WmI80NQNeufSAV4Z6H06viv
	/3Pg55g5rcZMM+MV8zskvNgGl+5iDKXDz5awXhR6+AUw/K48OSXUiqZbyQysj53SxjD3xKee2D4
	wUQ3W5Lxgfkd4LPxxTBhMh+y+waWXkeDjaNj7lnLs4h97wKD8NAtDaWa2k5bBf5jlSykdD4DuS8
	+re5+M1PYgOYS9P0JK7i9fg57cWbMzFgNy3taEce3fu1Y847GF2zGkqWaKtLGQI3mxn0ht4LjQW
	IUGkdLyzU/hmRpYL4i8aUZ4GO+LmOUelCD7ecp5f8BrIF5+TaUoZMZ40ZEsmZVgBV39af008S32
	0N2mZbQC8N5KTzFXzgL+LmK8E2pGA0ZKnDeKm6s1lbwoyMau5a+dwSqlgMZs+J3WeE1Ap/3ceYO
	73FSNrJTwjQCLwAtdffDxki0dkvnpReq6grCCf7fXTaTmW1uE+GyL/qWWcSaswkFRbhv/CGZMNL
	+SN1I2iVNqpTK9lLjSsVTKuqCDFAJA=
X-Received: by 2002:a17:90a:f94f:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39aee21a4demr19811899a91.19.1788436536858;
        Thu, 03 Sep 2026 04:55:36 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc090sm5222206a91.4.2026.09.03.04.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:55:36 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH nf v2 1/1] netfilter: nf_dup: disable duplication in user namespaces
Date: Thu,  3 Sep 2026 11:55:21 +0000
Message-ID: <34fe34497e78fc763a3f93605e29ce2a3fd7438b.1788425393.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788425393.git.zihanx@nebusec.ai>
References: <cover.1788425393.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nf_dup_ipv4() and nf_dup_ipv6() send a cloned packet through
ip_local_out() or ip6_local_out(), so the clone can traverse netfilter
hooks again. A network namespace owned by a non-initial user namespace
can combine NFQUEUE with TEE or nftables dup and retain the clone until
a later verdict resumes it. The transient in_nf_duplicate task guard
has already been cleared by then, so the resumed clone can be
duplicated again and generate packets without bound.

There is no sensible use case for packet duplication in a user
namespace. Skip IPv4 and IPv6 duplication when the network namespace is
not owned by the initial user namespace. Keep the existing TEE/dup
behavior in the initial user namespace.

Fixes: cd58bcd9787e ("netfilter: xt_TEE: have cloned packet travel through Xtables too")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v2:
  - drop the persistent struct sk_buff::nf_duplicated field and nf_copy()
    change from v1
  - disable IPv4/IPv6 duplication in network namespaces owned by a
    non-initial user namespace, as preferred on review
  - v1 Link: https://lore.kernel.org/all/cover.1787903722.git.zihanx@nebusec.ai/

 net/ipv4/netfilter/nf_dup_ipv4.c | 3 +++
 net/ipv6/netfilter/nf_dup_ipv6.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index 9a773502f10a..c33dae248c47 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -53,6 +53,9 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 {
 	struct iphdr *iph;
 
+	if (net->user_ns != &init_user_ns)
+		return;
+
 	local_bh_disable();
 	if (current->in_nf_duplicate)
 		goto out;
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index 6da3102b7c1b..a5f6f074a7e9 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -47,6 +47,9 @@ static bool nf_dup_ipv6_route(struct net *net, struct sk_buff *skb,
 void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		 const struct in6_addr *gw, int oif)
 {
+	if (net->user_ns != &init_user_ns)
+		return;
+
 	local_bh_disable();
 	if (current->in_nf_duplicate)
 		goto out;
-- 
2.43.0

