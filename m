Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F3583AD9
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888793; cv=none; b=gkB/K8IbCIzFrgPnYOu3FY163L6Z0US2Dj1TRm/RTRDeKD2XJrbXLwpfJn6foxFAgeh/vB9jfp6DHU2TV+SQN9JFLwf23uOWMb/uxbSJFffl2PgSIO+xmKbfvwcqKDge8ySug6p1as/kUWHrEalW6jI8dNx+04/2s/nFt1/x3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888793; c=relaxed/simple;
	bh=qFN/7ptYnQvMhQLwcNxpAb45nJF7Fo6fTL6IBuMppcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Os+nSnac1ebi7f/9mteubCJTZNOj1sLmxVzC62h9oTiX1KWXg+f0ZcKt16RDH4IXUUlHIuqJJo3IXEevYjDMaT3ZB5/cCmI2Kjib9PAGeAqiwd4NwvmRo6KOVQHF62Qgac8YYKohRZunSgg7cK6GvligKyNsopPnTq3+/h04QOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpS8Ih8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpS8Ih8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F691F00A3A;
	Tue,  8 Sep 2026 17:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888791;
	bh=KSgSnuTFaw+U5j+cIU7yLVo+YME5jflc5dP4beX11dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UpS8Ih8kWl2Ci5wzbF3wWBibuMa5TJwZ02Y7vg79D7iSRMF7TYVOluoXBEiF/ZvL5
	 BRZ8TVSIH38gsGwo4GWRA3j4A96+B/3cfq1rxTChSlsXCBuVIPoEroAu14w7cHc55b
	 7YAyXYupfUKCypLov2VP37zANM4fdbyc+SMeQ9YMHhCoyZ7U26StMH0UDR8MfYj1uL
	 XhpWqPJSqlTpC0cA9jWwfQPSvgz7Hs8qM1ZJt6/uKYvOLasM0PA4zldrqoWeZoeI31
	 Gnr+SrkkkYez91k8LwgJ9Sqb3WZzUSCDwdADeBXu7xsvaC89iRcX5x0JxhsPLxKAq1
	 IyvyCk7VhKZUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Chaignon <paul@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ip_tunnels: Add new flow flags field to ip_tunnel_key
Date: Tue,  8 Sep 2026 13:33:07 -0400
Message-ID: <20260908173309.106466-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-hurry-disagree-2db4@gregkh>
References: <2026090359-hurry-disagree-2db4@gregkh>
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
index 0d71e7c4c6916..f858df8325d15 100644
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

