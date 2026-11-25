Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587919;
	b=PII8w/aYVjjHUSFlXGnS64R8FwX3SV52r+uTH+jlmLnfqa32JbyejTggsQR2Yevgo4k1
	 eUK5Jr29CNV26ar5HOog4s7lp2FKQF6C81AqH+pmQp7zkFO/S5kBxJV4+ajmf17UlZKr1
	 32Jr1Z1gvg4ptgxFQBOUR/FT2/TS1UI3DHQ94rXZTZ7yVEAWrvbYoCM2mUaVlLMFLvK8V
	 FpjcG6xTCU/c/XI3VROOxpRRlqVwcM4+3UORSuCmLyPkfzht1bZJT40L7M2K1o0uYbJqY
	 yuYxz9Nne895Tnry10/fybIR2/cM4+63G3TkMXHnhPnegjf7QuWtW+YVGU1qrfe8qYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wQqO0ZGiPSduhL/nnYRl9rtTaPzOuw285ahJlrfXT+I=;
	b=Ylx3Hl9Lfd/ZoGnuElvKr+ULMsuqi5r7g8TnFz9srC5RVoNdY4VxqbltSOlaRvImmuPf
	 jzbnDA0//fKqL1vULhJtVVlw27XSShXjY14pTRuotAmJlM4pMQGRMNbUVd6/4ZFlVIAaI
	 8JnxEi1HboQBywIePr9wgfOyPJjH/5MpeGBBbXdNFtLjKdyhOT7nwXgBsTidJLRbIHITB
	 O7+QXXGuNIY4Rr4YJMVXkRvaq96K8DGhtpCz6M8n0RpKimSuts+tcuQdCuxGOksl/KFeW
	 UYrcbaPwZ+TVxoxLuiian/ZtqJJJY1Oi6hnYESo3s06IKOGy9Zq2yEIutH1YZ0bhYQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=TpoNvFtS;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA592606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA592606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=TpoNvFtS
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3acec6677so7976746c88.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795587918; x=1796192718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQqO0ZGiPSduhL/nnYRl9rtTaPzOuw285ahJlrfXT+I=;
        b=TpoNvFtS12+lK8hf3bzKZIbCHJLGkCNO8QlnTkgbPcTiUsXEpwd8y6rnb9buu414Vx
         G3EK3Tf6sVwIoNB6L+6eubiEqOUO4uPfbDlWqonLEJQDv/ZOcpVs6q804PcxXfFx7h2m
         9cjV5s2Xlfn7bGUHMzJ44X4zquWVGVsOIhCYHIzfs8CuASW2YObI3NLx5EaYdJ/Ol9+A
         7hNOxXVdBqYiUE67MvFKG618FL56Jnc7iy8Jdw79VW5wSmbGrVEl6573uyDaZjq4L1Dv
         vvGBL/g3T0uTyZBD+ocHHBaUQuhMibUzD1RzV18Q/ZGce7jQDkumwn5WguktDN/OXCPT
         VtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587918; x=1796192718;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wQqO0ZGiPSduhL/nnYRl9rtTaPzOuw285ahJlrfXT+I=;
        b=GhKhCS3CVqxzA7zeFGYnswes/GZBI1RrbyDUH1VwN3SBHKzkOUzX3/o5WDFqfQQzYm
         7p6Xf1GW7jboPvinfwOZctwRvPjaeTq9OQ9nasTb7cpu0VWLKrTFIrmE2OUPKaR/MHyb
         fRdikIkGBxP4JiRhjPHRsRDVSKP5X+MO969/R0wsjz4Sa/xVW9X6pXXkC0rNR6fDOYlJ
         mnan1qrXgRkVbrp7YoprGxMfpqP25ly2VUrAQkUbN10ejV4o3Wf0lCF1eYBgcAldpV00
         pqwmGwPlbAW2vTkzUhJ9N6dQVqm3V4eMTN3qeNxGA9joBm94ruyYBGJCvxJRMrNvC2EQ
         zpvQ==
X-Gm-Message-State: APuU4Z+Y+8XtTbegtShSI2fOhuQuNAyszBeX2tuswsr2KcVIt5t2j/sQ
	itj4NTKaIh42ibiySe7Ymgl5I6NuLM2Vhaa12afdWGSRO3UZrgEh/Dh5Pi3ZYRpgF3YmMBpHNt2
	aoU6g530=
X-Gm-Gg: AZFdTZdxlON7C9pbatWlgB0sbF8TB7BVTvzm6TS1GdfsTgTC7gb3swx0bwN8zOIdxDw
	cR9OZRZJZW7dU74H1C4luDxot6yvr3qpGaRvx5OYRomiqjHdnajHgjC1en1wCU/mMX9eEe1492h
	JUvT4jA/vj0q+3AUxEmDzFjnbxp0btHKh9rfAmhJnrsDqHf2EAtRA+mAWp4HD8AI8B5d6Hc/AxG
	1aBfPXmbBils6jON3rAiAZmZbyOMrqj0FLZGk+wgrHgC0tTMJYVbcERQ3tkeUo7jc/eD3tOzH+9
	tg4rOh+3JzFcnlLbpinPvITcJpM0eprbZWh3+M1u1519Iqsx5MPDxZjXQ87jZI6m7CXLasLlxhr
	bZ1hThOqrtTY4flew5nU3CsIFgMEJuQpDVC7puFWZRbdQO41F/oHy3Yiclr1kxyySlwXgOhkN1w
	BryJ6zwkIeaom2sG8FLCvMaWrtqV1rXiEz6zuiRZMh1kiSmGKPJVaSTHROiSjdzBCtXfAGum9gw
	ONVdWP6zw1qpE4fzkGPTayL87aYq8yTtEfSGa9TpkOCq6/iaDUpWrIZEZ7CXGdCwQtHlfUntEan
	BKwak3R8xQx8i0fivCNAffDGqmuUst3McoVZ4zEgOk/t8kSfiinmCxqKRp7bhfTCFPqnrTRJApj
	K02pFAtN6KqoSjdKZEzKB7aA0uA==
X-Received: by 2002:a05:701a:cc88:10b0:151:6e80:ba7e with SMTP id a92af1059eb24-1b5567dcec1mr15984271c88.4.1795587917888;
        Tue, 24 Nov 2026 22:25:17 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm38712721c88.15.2026.11.24.22.25.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 22:25:17 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	autonomouscodesecurity@microsoft.com,
	blbllhy@gmail.com,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@kernel.org,
	g.goller@proxmox.com,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	idosch@nvidia.com,
	ipsec@lists.linux.dev,
	justin.iurman@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	razor@blackwall.org,
	steffen.klassert@secunet.com,
	xmei5@asu.edu,
	yuya.kusakabe@gmail.com
Subject: [6.18.y] Please pick four networking fixes
Date: Wed, 25 Nov 2026 01:25:13 -0500
Message-ID: <20261125062513.96901-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Please pick the following four upstream commits for 6.18.y. None carries
a stable tag, and so far each has been backported only to 7.2.y. They
touch unrelated files and can be applied in any order.

1. 2842ce397dd09882530b42f7fdb0c855767eb24e ("net: bridge: vlan: fix
   bugs caused by switchdev deletion errors"), CVE-2026-98285

   When switchdev fails to delete a VLAN, __vlan_del() returns early.
   This can leave inconsistent state, leak memory when the VLANs are
   flushed, and cause a NULL pointer dereference on the flush error
   path. The fix logs the switchdev error and completes the software
   deletion. In 7.2.8 and in mainline since 7.3. Applies unchanged to
   6.18.65.

2. 9fa903b24b1f46b4ff5443bcd4aca23e5c57f9c1 ("xfrm: hold net_device
   reference under RCU in bundle creation"), CVE-2026-98364

   xfrm_bundle_create() and xfrm_create_dummy_bundle() read dst->dev
   without holding a reference and pass it to xfrm_fill_dst(). A
   concurrent RTM_DELLINK can free that device first, causing a
   use-after-free. The fix reads the device with dst_dev_rcu() and stays
   in the RCU read-side section until xfrm_fill_dst() has taken its
   references. In 7.2.8 and in mainline since 7.3. Applies to 6.18.65
   unchanged apart from line offsets.

3. 87cd6b717e4069dca34e0866e57eaeb44d3b173e ("net: ipv6: keep room for
   the mac header in dst_dev_overhead()"), CVE-2026-98570

   The seg6, rpl and ioam6 lwtunnels reserve headroom with
   dst_dev_overhead(), which can be smaller than skb->mac_len, for
   example on a VLAN device with reorder_hdr off.
   skb_mac_header_rebuild() then computes a negative MAC header offset
   and writes past the buffer. The fix makes dst_dev_overhead() return
   the larger of the two values. In 7.2.9 and in mainline since 7.3.
   Applies unchanged to 6.18.65.

4. 8ae3f4067ba4ae3a15581392f6dac422e3d3def0 ("seg6: ensure packet data
   is writable before modifying SRH and IPv6 DA"), CVE-2026-98802

   advance_nextseg() and seg6_next_csid_advance_arg() modify the SRH
   and the IPv6 destination address without making the packet data
   writable. If the skb is cloned, for example by an AF_PACKET socket on
   the ingress device, the clone sees the modified packet. The fix calls
   skb_ensure_writable() first and reloads the header pointers
   afterwards. In 7.2.10 and in mainline since 7.3. Applies unchanged to
   6.18.65.

   Ordering note: queue-6.18 contains
   seg6-fix-transport-header-for-inner-ipv4-with-ip-opt.patch, which
   adds code above input_action_end_b6(). With that patch applied, a
   three-way cherry-pick of this commit is clean and correct, but
   applying the upstream diff as plain text places the
   kfree_skb_reason() hunk for input_action_end_b6_encap() in
   input_action_end_b6() instead, which fails to build.

Apart from that seg6 patch, no patch in queue-6.18 touches the files
these commits change. All four cherry-pick cleanly together onto 6.18.65
and onto 6.18.65 with the current queue-6.18 patches applied. Older
stable series are affected by some of these bugs as well; this request
covers only 6.18.y.

Compiled net/bridge/br_vlan.o, net/xfrm/xfrm_policy.o,
net/ipv6/seg6_iptunnel.o, net/ipv6/rpl_iptunnel.o,
net/ipv6/ioam6_iptunnel.o and net/ipv6/seg6_local.o with CONFIG_WERROR=y
on 6.18.65 from a cumulative x86_64 tree, with and without the current
queue-6.18 patches. No kernel boot or runtime test was performed.

An LLM was used to check applicability and stable-queue history and to
draft this request; I reviewed the result.

Thanks,
Artem Dinaburg
