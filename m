Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586F41F5CA
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236307; cv=none; b=Q/oCl5Swa0XtB2sS6XqmLEdx+eFY0kLRpDQtl8eX9H5G5DnFNIqnLF5C8hOtGO5SE1FiB+KRrqIgYwTCfCy39AoENq1xDtIYUUQ+KzIz3DRa3wRA3P9K8alnKD4EmLNIZw1RlabKEK7/A896MrkXWgbPTTSbhORb3md2P1P3muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236307; c=relaxed/simple;
	bh=TRhy+/I5J77Q/1YSA/sx8GUDSoNQC6h5HCw7Plj0rt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9y/qaersPy3F1CZNxrF0DhFDSnk+XpAMEGhn9cPzbKVvjyeKBNX0yew3EPet1oyqcTGMox4yG/Td7J5uJuwoM6YgXrXwagK1Rg1cmoEGo65mMnIseyyzXW1s/P47ytGNidizdX1vosGsrFbOpTmXPkEIeFfzNUzLCJclPKDsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvySO9zc; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvySO9zc"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd5cef0so1045060a91.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790236305; x=1790841105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9EQyRWWK5qALWLPwUJRBoHZhkD+3TF7/yRx4MDMxnNM=;
        b=kvySO9zceooGMWylSC7lHqHR0rxQm/aJ1VGKgXt8e0Jav7K2ox9HpYaMF4Qclb0NOg
         NNuA0WL+FfY+BBTg1eL9hcPy+GavGfTdWLOvXfgeNJDuLn7R6pwF5AP1JWxIeKwy0HGE
         mENveACQf4p45uxtb6AcnXKcirexYkZ6Wxo+23Wo7woFyaLxskg4LGzgO/cR8BOdUcl0
         pYVuP/27html1dJD6YyYTtJ/72epF322jl9tSQiHYJfg5PGdqaVMRte/568uMApxos6C
         PqpP3NLkczwGMX7sJrFt2XY/+1WfCjBdMW9JsQ5yzrYLNutN5wZcsxmB4viy+GTVyhkt
         GJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236305; x=1790841105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9EQyRWWK5qALWLPwUJRBoHZhkD+3TF7/yRx4MDMxnNM=;
        b=Op0f/HdUS/8+kYolJSFEWTcSK4teAkLv4HQ1c7twJnHqH9oyqfT24y73jBZz+0Rsda
         57esBdPVyeAzcZ7LwOm+uTGEEuEuGRwZ7ZGyUiVm/pJQ9DeeOv4XYLBax4o8jmyJzrvu
         yXfG07pUwR1LT6cZ18otrRUv78mvlt2XQsyuLo7JYIvbZspGuSdIusaJuCuMBgxdMoFt
         99KcXzvZtW1dycTSBZoCekGnX6Ae8SKRngwKOxW5DHU+AuMdUs0WA5F76w+qFvRONu1r
         p4dzq8h0hKmsPdn8BOODearKKFh9btXfgwSsCxYb1rRtdLmUbw80UcFMMkQROhScb1fT
         frOw==
X-Forwarded-Encrypted: i=1; AKwUvByqAprW95aQHT6krJ9mV7x8Ny0aD6zamh4G6fj/ZL2AOWo4/SA8v0YwELynrlHOahuzyhbHpRM=@vger.kernel.org
X-Gm-Message-State: AFuF++kU6Zpy4lsih5f/DXm9BPNqdpfoeos+Ys0XC1bPGCP8dB9ASkkN
	GvPeBJti+Azc5x9nd6Jt2kjwOwdpJzOjod/k6TDYcktWs4tumG+AJTwQ
X-Gm-Gg: AYBFou10OY8V2Eb+2qa5V4zX7Oio6zH6kgZh2IyO8Okrwhacj3ypH4xvaTI/4rM7pt/
	Z+F/94Xh6B7BxBFPHo43+TCSUuwoYnBrRV1LCYhDiQtrAi4ryrcBtR5oGEDZFg9Xx4/yN79bTNs
	zTQCBATxu5OV2wulBSxXCl0xT5lAUQZmRYL7vnqCTp2FoDJOwPOZvN8enFG7DMcuS3ngxpXz3yV
	subb0pQM8vRaTtR0CNxmi+JYB/3dP0AHc+yWsPYO82NzCfw3TE63uA24H2jqSAfuNujm/MCBy5Y
	tm40WwP7cZtE7Dwy0jEstplvMXFAWKexnN0uf6UuusJkOq2H0GEMmy/8NMsxncC7UyU6pi+a9GN
	vYFMiKcBPEoDB//qt7CYVcUWNQ3gzF6pqS9CrgTqQc3bx1yr3WxEqrgQK72pPBdWxUc08vEmRLc
	CXeelzIn44No4rJx7sCOeWovQzFB48swLCCJNQr9yuQxRAEjId8L87e99mzmvjYtq14VUlD+E1/
	sBG+F+nEZcqsIR7wEvFwEFf04uWYnQueWCZp+LR40i9PIaZ+8Ykcn4c5+ai2p3H0IZnasVetJn9
	kNVKLYmxMCo=
X-Received: by 2002:a17:90b:3d92:b0:39e:6c69:f474 with SMTP id 98e67ed59e1d1-3a098cf4a56mr1420939a91.51.1790236305347;
        Thu, 24 Sep 2026 00:51:45 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm3540181a91.7.2026.09.24.00.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:51:44 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	andrea.mayer@uniroma2.it,
	hangbin.liu@linux.dev,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3] ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
Date: Thu, 24 Sep 2026 07:51:43 +0000
Message-ID: <20260924075143.2839886-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In seg6_genl_policy, SEG6_ATTR_DST is defined with .type = NLA_BINARY and
.len = sizeof(struct in6_addr). For NLA_BINARY, .len only enforces the
maximum payload length and permits shorter payloads (e.g., 0 bytes).
When seg6_genl_set_tunsrc() copies sizeof(struct in6_addr) bytes via
kmemdup(val, sizeof(*val), GFP_KERNEL), a short SEG6_ATTR_DST attribute
triggers a 16-byte out-of-bounds read past skb->tail into uninitialized
skb->head memory, which is stored in sdata->tun_src and leaked back to
userspace via SEG6_CMD_GET_TUNSRC.

Switch SEG6_ATTR_DST in seg6_genl_policy to
NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)) so that generic netlink
validation rejects any attribute whose length is not exactly
sizeof(struct in6_addr) with -ERANGE.

Tested in QEMU against Linux 7.3.0-rc3 by sending a SEG6_CMD_SET_TUNSRC
Generic Netlink message with a 0-byte SEG6_ATTR_DST attribute followed
by SEG6_CMD_GET_TUNSRC. On the unfixed kernel, SEG6_CMD_SET_TUNSRC
succeeds (err = 0) and SEG6_CMD_GET_TUNSRC leaks 16 bytes of
uninitialized kernel heap memory (tun_src =
836a61ecc4d25a1042a8d60411cfb378); with this patch applied,
SEG6_CMD_SET_TUNSRC is rejected by netlink policy validation with
-ERANGE (-34) and tun_src remains zeroed.

Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
Cc: stable@vger.kernel.org
Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Reviewed-by: Hangbin Liu <hangbin.liu@linux.dev>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Add Reviewed-by tag from Andrea Mayer.
- Send as a fresh standalone thread (no In-Reply-To header) as requested by
  Jakub Kicinski.

Changes in v2:
- Drop the redundant nla_len(info->attrs[SEG6_ATTR_DST]) !=
  sizeof(struct in6_addr) check in seg6_genl_set_tunsrc() since
  NLA_POLICY_EXACT_LEN() in seg6_genl_policy already enforces the exact
  length, as pointed out by Hangbin Liu.

 net/ipv6/seg6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 62a7eb779202..8c2b156c227a 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -138,8 +138,8 @@ void seg6_icmp_srh(struct sk_buff *skb, struct inet6_skb_parm *opt)
 static struct genl_family seg6_genl_family;
 
 static const struct nla_policy seg6_genl_policy[SEG6_ATTR_MAX + 1] = {
-	[SEG6_ATTR_DST]				= { .type = NLA_BINARY,
-		.len = sizeof(struct in6_addr) },
+	[SEG6_ATTR_DST]				=
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[SEG6_ATTR_HMACKEYID]		= { .type = NLA_U32, },
 	[SEG6_ATTR_SECRET]			= { .type = NLA_BINARY, },
