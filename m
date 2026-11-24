Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516830;
	b=wNC3hZMK/9Gbe99+kjM2uRpaeKkym9FmWu2npZUDAAxIDzSximcvtceW67oPSf5bLUYZ
	 1jGOeFePPX4w6zcW1RsQ4GiGDrB4BrOdd/V7+u5TpzTMZmC0C9Zlig0BlUC/G6P5lw5uj
	 NDP0iMwbfVUE+0SDDYxNQnCpFtoE5Lc73JE147VjVxBpiUdIrhlVNzRia6FkAOGVBZT0m
	 Ik4P3Z8M1yWkB7Lp+Lch+/D2Xf+8VnJMrPj4+LhCuOzjmgjN4mt3tadk5EdUmSWnWqAi6
	 qEPWSBF+w8IgAJmVUC0YVW/evlSHTtNkT5uBGq+ohhOQi0wP+tJo6DvnweUDAUW5pNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516830;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=/6dSyAvYrkzZrB+rNJ+F7xck+uglAdRkmahkz9MM2p4=;
	b=NZS0NCw61meSwuKCY7pNfcK1Si8zxjyA1/wrxxlRXI9JAhr1nE0zJlxpKR5mCNMQTDqk
	 +hZPUIEnhg5cVPx9cxlFIC7tBD94svuSoVUav58TCeshr3v+gpXlMj1xKxxuw3eTznEZU
	 zL4zVkF0d+V4eXfZbLnh0107iLodj+c9tNRT4Ye61XnOO6mCCfvanhDsgutUvmHotCZt7
	 oQWUJ9N/zAP+WuE0UvkYYoBFGLPDOu8ZtxlyGkXELChjYwcvn3SprfGmOFiY9ErRUBf8Z
	 bVWlEVfY0wX43U0k0FqcXPxiJcbJKcyq1W/B1dYHUPe7JiHVt6nBcg1hKzqbI6QkPww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=DaxkLhMM;
	arc=none smtp.remote-ip=217.74.67.63
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE5606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01CE5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=DaxkLhMM
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Tue, 24 Nov 2026 11:40:24 +0100 (CET)
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
Subject: [PATCH v8 bpf 1/7] bpf: test_run: Use a private rxq info for XDP test runs
Date: Tue, 24 Nov 2026 11:40:10 +0100
Message-ID: <20261124104016.532341-2-sst@poczta.fm>
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
	t=1795516828; bh=/6dSyAvYrkzZrB+rNJ+F7xck+uglAdRkmahkz9MM2p4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=DaxkLhMMN05JVK8MD95W1fNKay9sozcTpyFGOjZpb0bAMnWvjGGkicMZVulCO5QSg
	 bDuOIyYYREKzX325Vf3v7wqH88YVhNi5/jVAiV9SnoC7WyTFRAvXy1HG4aQ0K+xWCu
	 8K2EHCx8r8E82J3c1yuHR4BQgqLf2nmkTmE8N3Ws=

bpf_prog_test_run_xdp() runs the program with xdp->rxq pointing to the
xdp_rxq_info of a real device queue: queue 0 of the loopback device, or
the queue given by ingress_ifindex and rx_queue_index in the context.
The frags of a multi-buffer test packet come from alloc_page(), and when
the program releases one with bpf_xdp_adjust_tail() or
bpf_xdp_pull_data(), __xdp_return() frees it according to
xdp->rxq->mem.type. This only works as long as nobody else changes the
mem type of that shared queue.

A later patch in this series adds xdp_convert_skb_to_buff(), which makes
generic XDP set the mem type of the queue it runs on to
MEM_TYPE_PAGE_POOL, since frags it hands to the program come from
skb_pp_cow_data(). After any packet went through generic XDP on lo, a
later test run would free its alloc_page() frags as page_pool pages:

  WARNING: include/net/page_pool/helpers.h:305 at __xdp_return+0x828/0x9c0
  Call Trace:
   bpf_xdp_adjust_tail+0x8a0/0xd10
   bpf_prog_..._xdp_adjust_tail_shrink+0xe1/0x101
   bpf_test_run+0x31a/0xc30
   bpf_prog_test_run_xdp+0x948/0x1740

and leak the page. Restoring the mem type after generic XDP would not
be enough, as generic XDP may run on the same queue on another CPU at
the same time.

Run the program on a private copy of the rxq info instead, with
MEM_TYPE_PAGE_SHARED, which describes the memory test_run allocates.
devmap and cpumap already do the same for the programs they run. The
device and queue index stay the same, so the program sees the same
ingress_ifindex and rx_queue_index, and xdp_convert_buff_to_md() still
drops the device reference. Live frames mode does not allow frags and
uses its own rxq info for the page_pool frames, so it is unaffected.

No Fixes: tag, as nothing is broken until xdp_convert_skb_to_buff()
changes the mem type; this goes to stable together with that patch.

The problem was found by Sashiko AI review and BPF CI in the review of
v6 of this series.

Link: https://lore.kernel.org/all/sashiko-outbox-197255@kernel.org/
Cc: <stable@vger.kernel.org> # 6.4.x
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 net/bpf/test_run.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc62182e..9bbd83ece67b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1348,6 +1348,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	u32 repeat = kattr->test.repeat;
 	struct netdev_rx_queue *rxqueue;
 	struct skb_shared_info *sinfo;
+	struct xdp_rxq_info rxq;
 	struct xdp_buff xdp = {};
 	int i, ret = -EINVAL;
 	struct xdp_md *ctx;
@@ -1426,6 +1427,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (ret)
 		goto free_data;
 
+	/*
+	 * xdp.rxq points to the rxq info of a real device queue, which
+	 * generic XDP updates for every packet it runs on. Use a private
+	 * copy with the mem type of the frags allocated below.
+	 */
+	rxq = *xdp.rxq;
+	rxq.mem = (struct xdp_mem_info){ .type = MEM_TYPE_PAGE_SHARED };
+	xdp.rxq = &rxq;
+
 	size = linear_sz;
 	if (unlikely(kattr->test.data_size_in > size)) {
 		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
-- 
2.56.0

