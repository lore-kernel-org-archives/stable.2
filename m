Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516834;
	b=XZMan8lGPwRyBPRQN7LWPBHs8HzX0Asf0RydKG8H7RuiId5QIroL3NOgp2JRFRlQJLik
	 /jqqIdCIJ0bYNYs3j9V1z2VT/EXOiPGXkQv6TAfwjfOTfcmPsn73jb09C1XfvpY3z7o0i
	 KYtySIe+1SSjtmS2LKlHrw+cL3K5sUbRJocu8JCge0fSUCXkNnX639m55ryerU309cu6M
	 OBW8HEr2APOafitkFh6dvULM563HIRvO6lU+1AXGrHfTgr+73u2koy1ygqn+is2YJBiRU
	 f2bBiMQ3GLocnLIJ1WL9DF39jDwKtRHRrclSrUkM2OuTdzdn/56s3hgjsBiVGumoKsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516834;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=6xmad4X9z3ns7Ue26u3l8ROqewvXjh+VHhGEaTDpSWI=;
	b=EOwOj8dJsGvwrKQmVLBnGxiuwwHy41jqzt7ntinCQdpT/RlNie6HNrhGtkjWLAotOtaM
	 /l9FAvz9VqLhsss3R22vESM2hgB94l9HQmW3UXNUlPYd6M48sxQ0prHthnsTDLDNyI/s8
	 aeqNaLuY6g0eOgLQ34sc2dHbdatTTyBHTOnujao5/9g/k6X0H4l6e3UxAfyDPEJvSKNkv
	 uQ+LDjbbPycq06/u/dXtCfzmekd6vvBPqR3zXtz1Wt1Cw/j357JZ9TiYtQQj6P2oeu3TT
	 9hXQu5pomLNJeotaPnyasbCSSq4pX+1c7o8z0C5CvgL4tUQ3bhe3P2KGtePYJvI5+SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=RHJYjXgr;
	arc=none smtp.remote-ip=217.74.67.49
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2385F606A33C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2385F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=RHJYjXgr
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Tue, 24 Nov 2026 11:40:29 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Octavian Purdila <tavip@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>,
	stable@vger.kernel.org
Subject: [PATCH v8 bpf 2/7] bpf: test_run: Keep frag_size on the private rxq info
Date: Tue, 24 Nov 2026 11:40:11 +0100
Message-ID: <20261124104016.532341-3-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124104016.532341-1-sst@poczta.fm>
References: <20261124104016.532341-1-sst@poczta.fm>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795516832; bh=6xmad4X9z3ns7Ue26u3l8ROqewvXjh+VHhGEaTDpSWI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RHJYjXgr88KR/LLqf6a0QxmVQepL5NZNy/jP9F812mcYfrx4wLdC++wZtbdTbrA20
	 KsbDK6KZwtnFnJCVW7SGw1rjHlor5n7ZaB1050iIvehed2on72ZoWbCR37irEaMqee
	 wuQbW5OcuWBdI5GJ5T+xToD9Ir0VagQoD/AUN7Xs=

bpf_prog_test_run_xdp() sets frag_size of the rxq info of lo's queue 0
to PAGE_SIZE, for the PAGE_SIZE frags it allocates, before
ingress_ifindex may switch the program to another queue. This has two
effects:

The value stays on lo after the test run. Generic XDP on lo runs with
this rxq info, and bpf_xdp_frags_increase_tail() then lets a program
grow the last frag up to the end of its page. The frags generic XDP
gets from skb_pp_cow_data() can be parts of a page_pool page, so the
program overwrites what follows the frag in that page, possibly the
data of another packet. Without a test run, frag_size of lo is 0 and
the grow fails with -EOPNOTSUPP, as for generic XDP on any other
device. Generic XDP runs programs on frags since commit e6d5dbdd20aa
("xdp: add multi-buff support for xdp running in generic mode").

With ingress_ifindex, the program runs with the rxq info of that device
queue, whose frag_size is 0, so growing a frag of the test packet fails
although the frags are full pages.

The previous patch made test_run run the program on a private copy of
the rxq info. Set frag_size there and leave the device's rxq info
alone.

The problem was found by Sashiko AI review in the review of v7 of this
series.

Link: https://lore.kernel.org/all/sashiko-outbox-223211@kernel.org/
Fixes: 1c1949982524 ("bpf: introduce frags support to bpf_prog_test_run_xdp()")
Cc: <stable@vger.kernel.org> # 6.4.x
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 net/bpf/test_run.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 9bbd83ece67b..8e9543f98211 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1418,8 +1418,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 
 	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
-	rxqueue->xdp_rxq.frag_size = PAGE_SIZE;
-	xdp_init_buff(&xdp, rxqueue->xdp_rxq.frag_size, &rxqueue->xdp_rxq);
+	xdp_init_buff(&xdp, PAGE_SIZE, &rxqueue->xdp_rxq);
 	xdp_prepare_buff(&xdp, data, headroom, linear_sz, true);
 	sinfo = xdp_get_shared_info_from_buff(&xdp);
 
@@ -1430,10 +1429,12 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	/*
 	 * xdp.rxq points to the rxq info of a real device queue, which
 	 * generic XDP updates for every packet it runs on. Use a private
-	 * copy with the mem type of the frags allocated below.
+	 * copy with the mem type and the frag size of the frags allocated
+	 * below.
 	 */
 	rxq = *xdp.rxq;
 	rxq.mem = (struct xdp_mem_info){ .type = MEM_TYPE_PAGE_SHARED };
+	rxq.frag_size = PAGE_SIZE;
 	xdp.rxq = &rxq;
 
 	size = linear_sz;
-- 
2.56.0

