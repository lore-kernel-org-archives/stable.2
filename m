Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922862;
	b=08Uynp9YLCBO/p2YNPWPSQI6JVIoX8EWOGcgKvh5QqiCgcrhy0G5MmZnDiDE1tgLfoJm
	 k886JW6ZnNuE8cN1t53kiZMp0jC6kJ0iK+sIci/gAZTE1nRWUMRtcFkDfd4s3wQva6ZLZ
	 eFLlJshw/5l4IRGkwlik65rN3tD3AdLJF89Mu6rnXqYWXjII9tRlLqxmSvrjTS86tcYvF
	 TKWwwN6Tx+qXYv2nVADRJ+1LudoN4HJjIORzVcbwlGxOeX7mSmyRhtV+P7YzKWFhORQKM
	 QD2pfqzkStm25pI/103l0EnVYt6sVhMZy6m00yanBKiYK+5iPG+5sYy8HFTsF32EudQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xbM/8NkFsyBNUIt/zB1tHx2aYKgPjS1RSmbEYKw0CLs=;
	b=wsr2chkptA4Zf3T1C1o8I5xsuWQbZJlTLy4MYvhDBFVgqN6rpb8L9DYod0uElNLkVmgy
	 PXCVbWuJD0PacJRd+jKnnJVvEhu9sGMc1qjeKy+hag5s1O+BH1JbCV4OIwBRF0PkmSA4t
	 ckV1cy4uq42HyBN6un6wDCW5UZT40YYSSo95OxRzL+l6Wl5fVT2+BXjG4bDzBHCaYAplZ
	 hSB7QB1g8O6MICONZBgPfbGbqS9dklYfcpJhhcf4JgLCA7iFBKwokPp3UyQ/7fLN7knDK
	 pAodqSNQ6mYBl0N727yiIJ0Ne+Xpf5NB9uiSp8iqfgyU8b/KtT/6yowsn+QFxs5AySw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1password.com;
	spf=pass smtp.mailfrom=agilebits.com;
	dkim=pass header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=foXaldXx;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDC606A33D
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 13:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50EDC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.a=rsa-sha256 header.s=google header.b=foXaldXx
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5365d26ccbdso33433521cf.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 05:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1794922860; x=1795527660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbM/8NkFsyBNUIt/zB1tHx2aYKgPjS1RSmbEYKw0CLs=;
        b=foXaldXxEEH54V2YER/HHxt3jQlsWT7az36Ckd/VVrISFU+poHoFoVbuu7oDwkMqzU
         qb2Irozt25K9uH+74SzjT1PdSdXH54erl8ewjyR8naD8oGSgnVqYFLAsTrAhqK+ZjDqk
         stYd45245HPCPLkxFvpF7zkqwuKxfJCeAjwcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794922860; x=1795527660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbM/8NkFsyBNUIt/zB1tHx2aYKgPjS1RSmbEYKw0CLs=;
        b=Y9TTLLhh+0IEHLu0sTo6Cn77NrDZ1Rl5Uo4EaCRUPp1dwypghTEhzpmgU2h9gHvkEZ
         6aeNoldatgnxQ6FkdR0CQRVLJF60bUyElSuA8z6JiBjhIK0uhzg3epP/MS7ObHGNtM0u
         DkaXWY9DQ83GbsVpjT9tOwcE/iEgp5sM4/90k+Vdub7zgzn010DXwNab4OzJqdJWViar
         fowkKXhxAEbPQlGO/eXJPXGTzxHJmGfVj9UeAAnYzYWKyBKOWfP3m55+g0XdZrLVJe3D
         OFlhulGlVVMzA2c5yzJMP631BNSEgSVIgX63p+Q5WzxnLqS5paPhZUl19AwYOj4wpIh+
         DW4w==
X-Forwarded-Encrypted: i=1; AL+hErF8nRQIrit2XzQxENrFUcF0YY2aZkQ14emrJOsrQ/c2AYCfXBRAJOIOtY0bpogno82BGk5YgBc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9by63shHvcJ6Z3BQXMcwF/wbxrgYtmpMyBJ9yAJ+RIwkpju0Bm
	Nc3soheztjKmfCZWEGAI/jdQsn+NMqryUXddshCnUeJkfcOT1Eb6RcijQghN4X/vf0k=
X-Gm-Gg: AYBFou2fnG+0aF5umtkOa/6vl4JJ3VFs/QgY6dxAc7yDd4FEJu+70GOCjou6XQ8yd8u
	N4CKwVx7RzAgCFhcHm9aK1ARB5u7AGjx6FKAzVBRJreEujUDLMkYBwqV+ON5HGTO2rUUfd9guRW
	ITfHcBLnpcMvD2o7Rui8/Goi2+5goAWNXBhnMw63AUVDQmqRVEYaxUQHAXSPUV5iOs07A4cz2gZ
	H+9nb56gTH1v2gSWF8Ryj5rdP25SdL82GEFAOGqdFXKceh5ptxAwz7VsYIc5yqJ7y9K6OTzTbEW
	/ogyCq/Af48kBQPEl09FSXKd78x00+xHoRxja81T06cHl6WDlQdaxJEjHm1nuRXoUfXW9/xDOBU
	d491LEZ79FFouuQqtoyhAz837Mrj4WeIcDV/3Z+A/eov3tFNPAN9MktloC7cIa4zKaBkUPhWRYv
	Tc33LpJFOffSNazsDkcvBHGM4MvfThWcOWXnRt+JnuYwugfj1iAIUJSn1RRwIq+werhKyFeNis5
	2iGPUUxbY69eUvVYRZBSnKkbXFRP6jDj77DGQ5Ft1VHkr6ByWcAfqJ9cAYWcS/ER6mliCFADE1Q
	a+o1PxpSZfd8irq542bT6UJtGcyXHuJXVXSlSKp+nIhIHpA=
X-Received: by 2002:ac8:5d04:0:b0:55c:8b2d:bb41 with SMTP id d75a77b69052e-55d4a6ce73amr38497231cf.57.1794922860216;
        Tue, 17 Nov 2026 05:41:00 -0800 (PST)
Received: from localhost ([96.239.0.47])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0534196sm104516571cf.9.2026.11.17.05.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:40:59 -0800 (PST)
From: Axel Mierczuk <axel.mierczuk@1password.com>
To: ja@ssi.bg,
	horms@verge.net.au,
	pablo@netfilter.org
Cc: fw@strlen.de,
	phil@nwl.cc,
	dsahern@kernel.org,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	w@1wt.eu,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	stable@vger.kernel.org
Subject: [PATCH nf v2 1/2] ipvs: avoid out-of-bounds write in ip_vs_nat_icmp_v6
Date: Tue, 17 Nov 2026 08:40:48 -0500
Message-ID: <20261117134049.52386-2-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261117134049.52386-1-axel.mierczuk@1password.com>
References: <20261117134049.52386-1-axel.mierczuk@1password.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an ICMPv6 error embeds a non-first fragment, ipv6_find_hdr()
returns at the Fragment header without updating *offset, so
ip_vs_fill_iph_skb_icmp() leaves ciph.len equal to ciph.off, the
start of the embedded IPv6 header.

ip_vs_out_icmp_v6() and ip_vs_in_icmp_v6() pass embedded non-first
TCP, UDP and SCTP fragments through before any lookup. AH and ESP set
pp->dont_defrag, so their fragments continue. Their lookups read only
the addresses and never use ciph.len, but handle_response_icmp() and
ip_vs_icmp_xmit_v6() size skb_ensure_writable() from ciph.len, which
then covers nothing of the embedded header. ip_vs_nat_icmp_v6()
rewrites the embedded destination or source address, 16 bytes
located 8 or 24 bytes past the end of the validated area.

Include the embedded IPv6 header in ciph.len at both call sites when
ipv6_find_hdr() stopped at a non-first fragment. Only the size of the
writable check changes; the AH and ESP lookups do not use ciph.len.

This fix does not depend on patch 2. Stable kernels without commit
342e24a339b9 ("ipvs: do not mangle ICMP replies for non-first fragments")
also need that commit to handle incoming ICMPv6 errors quoting
non-first ESP fragments.

Fixes: 63dca2c0b0e7 ("ipvs: Fix faulty IPv6 extension header handling in IPVS")
Cc: stable@vger.kernel.org
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Axel Mierczuk <axel.mierczuk@1password.com>
---
 net/netfilter/ipvs/ip_vs_core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index fd503f0efb57..d5da16ff9673 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1206,6 +1206,16 @@ static int ip_vs_out_icmp_v6(struct netns_ipvs *ipvs, struct sk_buff *skb,
 				     true, &ciph))
 		return NF_ACCEPT; /* The packet looks wrong, ignore */
 
+	/* ipv6_find_hdr() stops at the Fragment header of a non-first
+	 * fragment and leaves ciph.len == ciph.off. Only AH and ESP
+	 * (pp->dont_defrag) pass the fragoffs check below and their
+	 * lookup reads only the addresses, but handle_response_icmp()
+	 * sizes skb_ensure_writable() from ciph.len before
+	 * ip_vs_nat_icmp_v6() rewrites the embedded header. Include it.
+	 */
+	if (ciph.len == ciph.off)
+		ciph.len += sizeof(struct ipv6hdr);
+
 	pp = ip_vs_proto_get(ciph.protocol);
 	if (!pp)
 		return NF_ACCEPT;
@@ -2036,6 +2046,16 @@ static int ip_vs_in_icmp_v6(struct netns_ipvs *ipvs, struct sk_buff *skb,
 	if (!ip_vs_fill_iph_skb_icmp(AF_INET6, skb, offset, true, &ciph))
 		return NF_ACCEPT;
 
+	/* ipv6_find_hdr() stops at the Fragment header of a non-first
+	 * fragment and leaves ciph.len == ciph.off. Only AH and ESP
+	 * (pp->dont_defrag) pass the fragoffs check below and their
+	 * lookup reads only the addresses, but ip_vs_icmp_xmit_v6()
+	 * sizes skb_ensure_writable() from ciph.len before
+	 * ip_vs_nat_icmp_v6() rewrites the embedded header. Include it.
+	 */
+	if (ciph.len == ciph.off)
+		ciph.len += sizeof(struct ipv6hdr);
+
 	pd = ip_vs_proto_data_get(ipvs, ciph.protocol);
 	if (!pd)
 		return NF_ACCEPT;
-- 
2.50.1 (Apple Git-155)

