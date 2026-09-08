Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04935C6BE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889280; cv=none; b=JchOLXu7i27K6EPlds6X4SDlb996WbR1ki3Zu9D+u1haHyAsb2aETNvbjQHMorcaOlr3SP8h1STcol3TtBn+USsaHgiHGtpJuliJHjM7GMsUw5dh23WvQxkg7/hPqgnyR4ItjDWOhYuuQpxWOwXKpfSRc7tfInDMQPKJChiwC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889280; c=relaxed/simple;
	bh=Ytx1hEFa/xasZYUIT8ijXqAaMHfvaCW9tvN6etmMfrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gnp1dk6LDWVtMEiUxSnPF8S+uWQRqHeHeFeLz/jJW2CBZKCLHsN+SUL7RePC8PT1HjQh7f8YHoyQzZp/xCb8wzBOdO6hvF1+ptlodq4ZHumdfbmeriBVwjuLz5TASE5QYY5Mrmu4q1qr0Mc5kAXuw4wb0dAszLJUIloMGQ7hzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fejTFRg4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fejTFRg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD681F00A3A;
	Tue,  8 Sep 2026 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788889279;
	bh=xtcfpGTonxz5aOwPWq+sdvNglMJLV7izrfvPlUEmOJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fejTFRg4TyWt47r8bTrqoflYfdNmalJDfGPtsaE+SMZL+Whu2bvFZyslAm3CzrZrd
	 eUFhNJmOHaGcB9ifHPWs2s2+FrgBssIUhytCk32tUz+AUJIhtQsgTarUeRUwZnzjKn
	 HvT5RAHDmvXbIuqk9zJMNTHrJXDiQkDnU1aOC+eurFWXjpUqHz/gW17wcAX9kNgUJf
	 ptMCMd5BaLnivKCGWGgPd06X2uH3cAdWwOTYD1OGsSVi7r1PjJyS8yGLrtdrWGkWL6
	 eoxqqsiXrHirla+jX0Oyj7kfZEk9EmyGeehmb+OYpL29GdNwcdG067PQhGFVobYiOp
	 gmk0enNxZLr5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Chaignon <paul@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] ip_tunnels: Add new flow flags field to ip_tunnel_key
Date: Tue,  8 Sep 2026 13:41:14 -0400
Message-ID: <20260908174116.123019-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-reflux-womanly-dd73@gregkh>
References: <2026090359-reflux-womanly-dd73@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Chaignon <paul@isovalent.com>

[ Upstream commit 451ef36bd229f8aa329cb2258a859b4c636d08ef ]

This commit extends the ip_tunnel_key struct with a new field for the
flow flags, to pass them to the route lookups. This new field will be
populated and used in subsequent commits.

Signed-off-by: Paul Chaignon <paul@isovalent.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Link: https://lore.kernel.org/bpf/f8bfd4983bd06685a59b1e3ba76ca27496f51ef3.1658759380.git.paul@isovalent.com
Stable-dep-of: 6776efe4a52f ("ipip: fix skb leak in collect_md mode when metadata_dst allocation fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip_tunnels.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index b4be1f90f1495..31b0d1b17874d 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -54,6 +54,7 @@ struct ip_tunnel_key {
 	__be32			label;		/* Flow Label for IPv6 */
 	__be16			tp_src;
 	__be16			tp_dst;
+	__u8			flow_flags;
 };
 
 /* Flags for ip_tunnel_info mode. */
-- 
2.53.0

