Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEA0377018
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747975; cv=none; b=BHCiHt9LxHAzEuq8cf/JRH6G3Ej484diM6IqGplEi308tVnnbUGafTDTqbUHNTxZ2WEryRzBY0klAyJEJ6T92VgE5Cxp+kIU1+g1kjrPKs9l/iUxk1mIsAJIYeB/LGcWGUSRQzWGNMXA53mcV8rIsgxQLElDIZ9HhkjQmcssGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747975; c=relaxed/simple;
	bh=Jb9J5bSOSje9FMdG7C+lQp/nEJBkbTNQ6Tu3vF6YLm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOyN6SvOl7Gb8X/yM8kRLhhZarvvuTGPL/GIdtPGXzc+EvcYvFBvxnavO75tOUKGcSSew6KCii0hXrHLicy3Y9oMAuKC6dqP5cIUBqwm5Ssg/3PVjJSntTGZkzeAhqgwDdIpGVW0QPQ0QoAZ2lrBKWrBig7W8CcJsYJpt+vNppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=KWnoGLja; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="KWnoGLja"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4720f3bf164so3690545f8f.1
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784747969; x=1785352769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pnInvCDAwEksrdCAmMtd6TY5IpoNHnNiOOgeViffG5c=;
        b=KWnoGLjaztBwfvaNzv3hM8DLIpDdS0MGN/bpFMCS1lIM0PYf7kzJqsX+d3kMWptqx5
         hLRpjsTf0oAnwAdEBRiBpMMc1lbIYRv5diN4U4M/vhYcbiQxWwqajKEvzttN3xsP4hRe
         sRYh1ngrIyxB+MnZP9/yqnDzzqHs0XjYMlhAJ04MbHikJ6X/wGNmHmsmt3QuJ4wyUWAB
         phk0hH873T4tdw8Kr6aoFHL6us7YTvrlzIvYBLLWUg41ZYpqW1WkHuVDyjrrELXGfBEI
         3kNWiRGjJMAtluPcKd/Aa+2pZhg6NUC0+u9IscRiRmRRReF1nuQ5bMtrqtGBbTQTSfD2
         efBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784747969; x=1785352769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pnInvCDAwEksrdCAmMtd6TY5IpoNHnNiOOgeViffG5c=;
        b=cFsldUSwfGZ7s6tHO/vLawfHLPS4HLVBu7IFlNNrs9jcMP2hy39Bs0QEsSc6gEQblQ
         PGFDUJnz/HjibiwBez9d+1kpX7UhURSeisXEPARZ3Sf6MtMIupuJ+o5MkN8CeCx6EZQ9
         Txp03zHdTOEkb2X1xTu6ED3FNaE7FsswOvFMTOE08vKE/7FlXXcj65I7HyUmlbA937mq
         6MlQ5gKRq0sQqqXkMDEMy0pJveaL8YVIQJpJQ8yk/xZsk/qvm1zeGO0TNn99hed1piZS
         6Y040g3j8Tbs8O2lvZ8TaE9IUEzb9ctXXBRE2YqbRiMJ9f+Z4m+12yMmZXzie+n9bAq7
         vhGA==
X-Forwarded-Encrypted: i=1; AHgh+RofofYjYtAG0i++LJlOJBjPzdZH8vo5dpnG495mVAzPhP2qpqprj3caGo6RDbAoKwvlqFQXlu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEGoHkyH3Xx4L9h/2PSyOjx7B42pfzgxzpY7C04E4UBQ8flTR
	GU8ffYGyp6nO7vY8MeB4u95xamvJcdog5vT39HZp38HBgekVneTVN7mlD998Ospw1mQ=
X-Gm-Gg: AR+sD12meR9JPtr84avbGeM+SLLu+Ib8ePwchmkQdi1SffRAPrzXtZkBOzHdrsfm6Cx
	tVxHxbpBREwUS781kdyJH1VuOYjSXPyFa+M7aKyBuAJuHiW5lJ9KjjcgKEoqDPgFsDrWyANUtGn
	kZyT0hecNrD25dmicMIfoK6ppBMZC/QnYGJd7spAEi75Q6Lk7ICWGK5f0Khx0ONVBhjBz0TdPz6
	jdjV79omK7HVWppCFnNRaJZzI8UOfYdc3QPUcCOGE9x6iZg0oRzWJ2KaEoO7mRhqAZFtDuIOYJf
	n6/fG38d6DMVOuVT/ZI6uZxvnv4Db+5OJbeNj+sNZIkLj7EMxxZZtP7q3kO+EQiuO77lu9olpgq
	APM6d3hUAZRai7FseJOsa3UfC3+B2extQZkwMyxtuGdgkjCJyoG61uh3GB9D3LBom+jeDILeb+c
	A63HFs
X-Received: by 2002:a05:6000:25e2:b0:47f:537b:d5d0 with SMTP id ffacd0b85a97d-47f840c95admr7850328f8f.28.1784747969382;
        Wed, 22 Jul 2026 12:19:29 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26dc::3df:4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c67339sm8862982f8f.31.2026.07.22.12.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:19:28 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH net v3] veth: convert frag_list skbs before running XDP
Date: Wed, 22 Jul 2026 20:19:25 +0100
Message-ID: <20260722191925.2192070-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

A frag_list skb can reach veth with data_len set but nr_frags zero.
veth_convert_skb_to_xdp_buff() only converts skbs that are shared,
locked, have frags[], or do not have enough headroom. It later uses
skb_is_nonlinear() to decide whether to set XDP_FLAGS_HAS_FRAGS and
xdp_frags_size.

That exposes frag_list data to XDP as if it were stored in frags[], but
frags[] is empty. AF_XDP copy mode can then trust the bogus XDP fragment
metadata, walk an empty fragment entry, and crash in memcpy() from
__xsk_rcv().

Route non-linear skbs through skb_pp_cow_data() before exposing them to
XDP, and only advertise XDP frags when the resulting skb has frags[].
skb_copy_bits() already handles frag_list input, and skb_pp_cow_data()
builds frags[] output with skb_add_rx_frag(), which is the
representation XDP multi-buffer expects.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
Changes in v3:
- Target net instead of bpf.
- Add Return: to the skb_pp_cow_data() kerneldoc.

Changes in v2:
- Use skb_is_nonlinear() in veth_convert_skb_to_xdp_buff().
- Move the skb_pp_cow_data() comment into kerneldoc.

 drivers/net/veth.c |  4 ++--
 net/core/skbuff.c  | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 1c5142149175..00e34afd858e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	u32 frame_sz;
 
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
-	    skb_shinfo(skb)->nr_frags ||
+	    skb_is_nonlinear(skb) ||
 	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
 		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
 			goto drop;
@@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
 			 skb_headlen(skb), true);
 
-	if (skb_is_nonlinear(skb)) {
+	if (skb_shinfo(skb)->nr_frags) {
 		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
 		xdp_buff_set_frags_flag(xdp);
 	} else {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9cfa..ba3dbac80fb4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -927,6 +927,18 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
+/**
+ * skb_pp_cow_data() - copy skb data into page-pool backed storage
+ * @pool: page pool to allocate from
+ * @pskb: pointer to skb pointer, replaced with the copied skb on success
+ * @headroom: headroom to reserve in the copied skb
+ *
+ * skb_copy_bits() handles both frags[] and frag_list input. If the copied
+ * skb remains non-linear, it uses frags[], which is the representation used
+ * by XDP multi-buffer.
+ *
+ * Return: 0 on success or a negative errno on failure.
+ */
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -936,12 +948,6 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 	int err, i, head_off;
 	void *data;
 
-	/* XDP does not support fraglist so we need to linearize
-	 * the skb.
-	 */
-	if (skb_has_frag_list(skb))
-		return -EOPNOTSUPP;
-
 	max_head_size = SKB_WITH_OVERHEAD(PAGE_SIZE - headroom);
 	if (skb->len > max_head_size + MAX_SKB_FRAGS * PAGE_SIZE)
 		return -ENOMEM;
-- 
2.43.0

