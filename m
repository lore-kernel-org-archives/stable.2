Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651427;
	b=cEy+mXsLFEHBZVlC0vWKwl9CbncbQ5KrJpOMTZD7NAKmX2Q3XmVTXuNwlp+x3BrrhCIl
	 m9g8l3D3EEJuwKO9iTFXdozP4cURCCHFGIU1AFkx98ZSxw6P5SPdhsACsSD6bQ8ncPS1K
	 8Pmlok+vHUyaCcWKNCq0nkrdeP8U+/LcbhHIB1LSJj9mayn78F6DSxVAYM0cy1MFDwFEX
	 zY1KTBGp7Tmy9GIdGqXnleRL1cBqDjyu+DC0YXcErMAgky3U7xXjH57Wjriau/h5gWSxA
	 nL+nZ4tx2lGi849aAd/4mWCioFY4tfGOnFlm0UwOQBgmgtrUVixOpm/6GCWusSbHD8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651427;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=j2sIvKyXb2Kt7mB+XHpCCtweDpt0F+8MgCJEPEWK2Xc=;
	b=dXMnvWEggW5ti/16Qf1JahAnX9DfN3BNkB8/W0PSY6Ahldxfe3T6MPFWy4bHU/d0WduI
	 2aHItFk90CVLBPjbJOKyPnKZdD7Ymx1rnIGBz9rptWOSu+ArjyUZWjuCSH6bL6aKOvS24
	 pvt3dgswM1yGedgCQ0SJVwqy88qTE8roExlzlPOmJf/sr0oCDrd5yyNwAfS8eICBG6sg0
	 lTBROZ/wRRGAVYFZ0rP9jDEStpx1VN0cYC5iQDY+DloHZ+f3sZg1MMvsToFG1V5IPWI+G
	 JzC0/abN0nAvXEYWbMA15OQZTn/S77iWtzAs0QSq1c+J88xTPbWwgP0bjXXciEiu0hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=QZCzYiQP;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639B606A327;
	Mon,  2 Nov 2026 20:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E639B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=QZCzYiQP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=j2sIvKyXb2Kt7mB+XHpCCtweDpt0F+8MgCJEPEWK2Xc=; b=QZCzYiQPw/iOSZ3RkhQHwQ+wdc
	NKuS99Bwi//9buZDFA97kolf51NNo8EMPA4GDb/uvxqY3F8ZPhnxU3T56ZtNB8yxZ5BtkdV6J7VF3
	TMEoMIKwc9u5qdJ3BUn/Oc66MbewEKiqcDV6LuAycsygVpNp+rF/K8wlgBMdjsY+qdxylYoaMIm+9
	XLWIaE/4sxg6QjElUuY4VqRU37YwyB0yGGaK3cOlxliPqWTgFGfNmCcovd5uoJ8qD3EIHYRKvgnyB
	GtdOTVbW6NewOzcnv7HJDj6kS2/H0ODeDk29A/HauNnEsvpcM7Wd14svBgaAGEc4AcoJEBvwEySCW
	XM3U6J/w==;
Received: from [151.115.150.205] (port=40078 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xNyfh-00000005yZD-0eEX;
	Mon, 02 Nov 2026 21:30:24 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] bpf: netns: require CAP_NET_ADMIN for link targets
Date: Mon,  2 Nov 2026 20:29:23 +0000
Message-ID: <20261102202922.2515317-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

BPF tokens allow a process to load BPF programs using CAP_NET_ADMIN in
a userns, however, netns_bpf_link_create() does not check for
CAP_NET_ADMIN in the target netns. Consequently, a token can be used
to attach a BPF program to a netns it does not control.

Require CAP_NET_ADMIN in the userns that owns the target netns for
netns BPF link creation.

Fixes: caf8f28e036c ("bpf: Add BPF token support to BPF_PROG_LOAD command")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/bpf/net_namespace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 81006a242618..0ca29c20ba85 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -2,6 +2,7 @@
 
 #include <linux/bpf.h>
 #include <linux/bpf-netns.h>
+#include <linux/capability.h>
 #include <linux/filter.h>
 #include <net/net_namespace.h>
 
@@ -488,6 +489,10 @@ int netns_bpf_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	net = get_net_ns_by_fd(attr->link_create.target_fd);
 	if (IS_ERR(net))
 		return PTR_ERR(net);
+	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
+		err = -EPERM;
+		goto out_put_net;
+	}
 
 	net_link = kzalloc_obj(*net_link, GFP_USER);
 	if (!net_link) {
-- 
2.47.3

