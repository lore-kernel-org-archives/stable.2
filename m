Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F7926ED33
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926928; cv=none; b=Dj3WcuxCaOI90jIUR49vFqcmG4UUeGqmRM0LZOVZ45j3CxjEztJc7Kdoh3GfXXtu3JKA6oTrtG4p89ugzizGRg+XV3gz+1/AGW7GJlo6UPu9m0QX1k1v1/8NXrSZ7Q7WiHEwquMl8KLCWrdYHhLeVrfTrSNnVOGOleb+Xb7KO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926928; c=relaxed/simple;
	bh=lHA65J/4a9O7FOIrwW3VPTBo9d0EBd8lH7ceA+nclpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWtE9lAdlKwx11lrX+xqTGDiDwbO5gU05ZcKnfqFr6bxeFvjye1JFHzhB9etRTv9xpRUdz2V3WVpIFAkWVbLehGb9Tbn8HPriKRI/FEdP7p7uHGH4em8UmGZQb10NLHj14+5SibEW5iVAbYJbUvghO0Cds15QPpvvrPMyFjUVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfhKZ3kn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfhKZ3kn"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso5678837a91.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788926925; x=1789531725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5OlD5gWWssUWDFczse9ZxRfKKog9YLB57/AAsUi+8E=;
        b=YfhKZ3knOaU8utuUtRRGo0jkTw32ZrgnlsQSSMjSP2fPOKy9RJbELRrl6evuChmdO5
         PoS3KMxfaI3oORtfK7U7fsI9LYS1JmhDymwF8z2xOE8YvCBASic2+QQilNqfpfFdd/I/
         DpQ04F97xABd6+FndUrGcFNBwIXLMQhetNcFFueWpK/U3iA3GhYHtArhPx1jUgDSXCMS
         D50zm8wDVoWy9WW2Mdr0wsb3gOt6Y7GNEXwLL24a8WzPo1T0W0r31UQWqLmWfoO4j10r
         dDWQtzSKNOKkRfjQ5jiW0rnVAqmZP6j1xbg1Me8oHfyF4PjWQxQyETXVcsLAMtrZougy
         RqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788926925; x=1789531725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G5OlD5gWWssUWDFczse9ZxRfKKog9YLB57/AAsUi+8E=;
        b=r0wYaOGJ5B/oJhi4yHJFHKbeoYK0uKfpuVaEfHVqTY4HQiWR7sAuzyWr45xjSMKgG4
         +zyK4jrWrFz/zWSiAAK2a7w+2o/8giB4I4F3p13LFjDIf0DZRdiOERSYjllpxfhmSV/z
         DxKm2KRrhEn9eOuy/LXZqDDKKF5i2jij4JSht3G5zJHeOzdoDbBz4SlyrIXUJqtcTovv
         szxNBTeMryTqmTqSduHIdgkcUpn3WrCytpMEFKHZZemt/iQcAdB2o2gkD9UYAXhsGz/W
         y6x2Cn9Y6Jx/HKRO8sgMy+YdjJpzq7AV2st1CgUxLgo+LsSPHyLWV4ouLkHjZHpq6NmK
         awEw==
X-Forwarded-Encrypted: i=1; AKwUvByIOq5XQ0R6B8TQ+we5jsW9AYfOJ/YyFzN8PZSUrL2lKVCcYrNPOieJjSk1fd58uRIeloIysKc=@vger.kernel.org
X-Gm-Message-State: AFuF++nK+WGl/dzc/mSWJXhvQur7D7YuQrsWrnDgvZgyEqoQPVgPyE/L
	RncghfJ5CHWfHmO32zf5z/Tv6DicK3YgGrrgp4XSoGLLPWzMONFolK2g
X-Gm-Gg: AYBFou2ccLX+Ty9MVl5QlCgszopN+LLQAwWMJTrrlkyR2A34ARWBs8V4SzZSlZs8S5I
	lbIy1dYfD8K5XWQ0bXh2NC2msD4oc9Xz0GVQfQ0qxd2zxF4dv9sQB1K8ZJMCgHVKR8wcJoGJFyA
	BdvvDP2TTAA7rADkURIo3SLlxEQrj6NT8sxtqYFKo8NLbDUSz7a4EVQvE/aeuH3KFcf4B0CSGdH
	JCwySR8X/3sI9Ym3PvIBgpvjNFlmGvESyxmTrKqUu4GNhzVxicVHryKTlXl3MCHcNyScW31cifr
	2nI0/T92UAW43/F7k08PAp6VrcL9kxHbmkl7tU325RXbkA6xj272G2Tm4M4nJfOxdf263lbS2xv
	oEa6e3Y3r2xi/zOEG+mve1BWTbIMNmyRJ1hw37BSnJ5syf7Ragfy4iVqrZbetfu7c3prPcE3z4h
	ATAP+U1VVkpDzGh09QPeemO8e2e8OrovDRXl3fki6I7biEQFt3Clfnl/B/OcKLA2FH4hd/v+kGJ
	hntCCLl+mqr5P8df/pJjqUMwr3WOKFT
X-Received: by 2002:a17:90b:4c03:b0:398:cb56:e92 with SMTP id 98e67ed59e1d1-39b26130698mr45997775a91.11.1788926924938;
        Tue, 08 Sep 2026 21:08:44 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2615039asm29766867a91.15.2026.09.08.21.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 21:08:44 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lebrun <dlebrun@google.com>,
	Mathieu Xhonneux <m.xhonneux@gmail.com>,
	co+adfca3e91be95776@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2] bpf: disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
Date: Wed,  9 Sep 2026 12:08:08 +0800
Message-ID: <20260909040807.3885815-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907192129.557377-2-bestswngs@gmail.com>
References: <20260907192129.557377-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An LWT_SEG6LOCAL program can invalidate its cached SRH with
bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(). The latter
may reallocate skb->head, leaving the per-CPU SRH pointer dangling.
Post-program SRH validation then writes through that pointer.

Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL programs so the verifier
rejects this unsafe helper combination. Other LWT program types continue
to expose the helper through lwt_out_func_proto().

Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
Reported-by: co+adfca3e91be95776@bugs.sh
Closes: https://lore.kernel.org/all/GCy0KRM2IcQGoJQTjJEU9D0maBxXzEDHuQpq@bugs.sh/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Link: https://lore.kernel.org/bpf/DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL instead of adding a
  wrapper to refresh the cached SRH pointer, as suggested by Alexei.

 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8513167a858a8..2a84f9d011314 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9044,6 +9044,8 @@ static const struct bpf_func_proto *
 lwt_seg6local_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
+	case BPF_FUNC_skb_pull_data:
+		return NULL;
 #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
 	case BPF_FUNC_lwt_seg6_store_bytes:
 		return &bpf_lwt_seg6_store_bytes_proto;
-- 
2.55.0
