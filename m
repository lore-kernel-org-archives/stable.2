Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792999392;
	b=3xhdP0u6UC/cXM1lcbm15XmsGlFKjzHcIz0Mu5IQWhvTV9u0MvOBjvlMsL0Nu6I4P/F4
	 iihU0ONHFiWzLT2t2zox0y/TJLD6e26nTsLcsfADCl4NrPSQpFQ3oSEov01aNWOPKrT+n
	 O+gwIsB/xTxInbX29nHR2F9wc0wRkcB720okYZLnGBEWzfbThf9uGSE8XUIxE2MlqjVYJ
	 z/ww/6nBbu9+vk9ujpmvWK9tZHgYHqmPf4kUDxXZkKvEblIWwPUE8EZjpuB1EHikOJaJD
	 scqkbhqT9Qg681G6iDlMcqVFyT7ekNnCU2LU5y419o0rRkE6RQdp6gQ847OTYnfmaGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999392;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=gL4Y4LLW2G3VJwIBXj9jDelLMgccnmv4YV0UaBDP1+Q=;
	b=uKfpUdYbyJYj811qOa6eIPNktfabcaJyytg/dQE3NoxEVQt4ljFhP6Qu4ZOZBhHtEasr
	 A3V7yrfuEGwDEBeFPPSEWrVR9C52vKaY7wlrX5Mil4ID4coM5XXNEYV3zpoFZzUCX/vlH
	 70LWt0KyFPRosH1QGBivqD4MJ4+1wq/fJKCNzAJgjHyaNld4+M/ZDUWfiq69yUM711qN7
	 K3yVasK17UBLmmPAe8VbnMdtZbDFchuL7H1+g7LUhIlWjxddrNaqVLUmwEwfJ8VUTSs2s
	 LdKtoF34FiCnX+wEbo/knaI9r9wpM28zMh2V63XMbO963rpxWcFUtBOYjQWMdyL82hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwcsoOIh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295CB606A31B;
	Mon, 26 Oct 2026 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZwcsoOIh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792999390;
	b=1uHATkRNaiCFPvI+w4S2Ha/fItRC0ElH92cR2IS0+w6TqH0xrDVe1yLVUQ+s7oIaFRqU
	 Vrxc8XEZN0kvyJHAg60e6mA2OWKqkKersmECJWf/+d2ZENDMk4mrO7TPJ5oMDdmrq5Njx
	 qXOUzDZlNa3eW2bma2rfi2UA7UJNsauEtrUG32mzUh0U92p6+b+iWsQEvLYplfl1ZhVEq
	 lC41Go1jnQym/mqCIGvWe5U3iK8MuDjdFR5wnbG8wgq6sYm0WMpuchkslDNDgV/ddzMSu
	 TH+fMI9i8CeDlI8wgQ5ffxr3ZuoxTfjwJTLOsGfqgyT4irbPT0WVypvg8612WhrGzng==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792999390;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=gL4Y4LLW2G3VJwIBXj9jDelLMgccnmv4YV0UaBDP1+Q=;
	b=FQjAGlZul4hz/L2JzYVHxDfm9P+Q6PZ/7AS8w7Hxr40UgUOGv7O7DzwG5aX983Onq0s6
	 JEmLBIwow7QkjQFQ0QW6DZJrOfxRQh6eGLxcdGggupEdtbQ1LfV76yF/A2EJJe+vXHdhy
	 Yw9UMuxq4Z+KCk3EC7n7RK3S1eKrzkIt9Eo1SUFeBVo6eWDVoDQBobXUPgF/2E5v+JrI6
	 TJ5QLar16+IQepNa7YXuLNuxUz2MUXBdQqV+sb9Hvg8PiuFNkMGtfHOUjW6tEWHSITk6K
	 Db6kOtsIJcHfHnCAxLFslqcJKLcCCo/qdXBd8SCHITT4xESw39vuQ3cSxWBD/Dg3AhQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3E2661F01825;
	Mon, 26 Oct 2026 07:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999390;
	bh=gL4Y4LLW2G3VJwIBXj9jDelLMgccnmv4YV0UaBDP1+Q=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ZwcsoOIh97NogTnRDp/9R0PVea18/TOaCQ1mmcvhCLQEz+Set1y5naNcfnetzY0jF
	 y2O88qwWb6ZtWhx39wpCFqI1ctDOMbNqCAQiiq2lWFrnKpWu/uecwIQNMrjgowtft8
	 wSOtpPw3A/azXVma2cMgC/NvNKdEZStzyi0RqNZPxU9b5z9C79YGSHRtGT0I147Z5C
	 Ceg7l3CvxGWAcEQhlyOL/pJKM5bFkElnp0aD9JEMEgOou2H7+3r7z6vRkgZHecE62S
	 Uian5GSLXSNESgDEjl97s4joBQQNkMbx9neHJ8MUG/1oRvyUU0xiOw2IaNUU3qcrjm
	 MyBvGB2sVijTQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C477244C43;
	Mon, 26 Oct 2026 07:23:09 +0000 (UTC)
From: Esko Mobius via B4 Relay <devnull+echoowall.gmail.com@kernel.org>
Subject: [PATCH net 0/2] Revert advertising the TCP MSS from the configured
 MTU
Date: Mon, 26 Oct 2026 15:23:07 +0800
Message-Id: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANv/3moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINZNTCnLLS7WBapNLSrRNbUwME1JNTQ3NrNMUwLqKShKTcusAJsXrZS
 XWqIUCxEsLk3KSk0uAZmkVFsLAFqhlOV2AAAA
X-Change-ID: 20261026-advmss-revert-5805de17369f
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Esko Mobius <echoowall@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792999388; l=1884;
 i=echoowall@gmail.com; s=20261026; h=from:subject:message-id;
 bh=XaR0Gk8SmZ1BSXypb/zmzgZFcyeFs/xIK7D652IwkuE=;
 b=1UtGo0a2fgm7Z14XWVa6/EaFpZ4ZKjTgedpVnVQW7PmVrgnzJb5IAT2ykAQfhMa27+gN/Y4Su
 9CVc7UOGdAYCpkkdt3jSZAgu/96ThC6LY37mBdYYOdPI1tHLgZrpP84
X-Developer-Key: i=echoowall@gmail.com; a=ed25519;
 pk=9XP6JhqjjPsHCF6UZZZTeqTRnXIa4+ufggnxXtTJ+no=
X-Endpoint-Received: by B4 Relay for echoowall@gmail.com/20261026 with
 auth_id=1323
X-Original-From: Esko Mobius <echoowall@gmail.com>
Reply-To: echoowall@gmail.com

Commit 2640e6419594 ("net: advertise TCP MSS from the configured MTU,
not the learned PMTU") breaks TCP for clients behind networks that
filter inbound ICMP, when the server reaches them through a hop with a
smaller MTU: the handshake completes, then the connection stalls as
soon as the client sends full-size segments. This was reported in [1]
and confirmed on 7.3-rc7; reverting the commit on top of 7.3-rc7 fixes
it. Details and numbers are in patch 2.

The asymmetric (DSR-style) case that commit targets can still be served
by the existing per-route advmss metric, which overrides the default
after the revert; patch 2 includes a test of that as well. If you would
rather keep the new behaviour as an explicit opt-in some other way, I
am happy to test or rework this.

Patch 1 removes the packetdrill tests that assert the reverted
behaviour, patch 2 is the revert itself.

[1] https://lore.kernel.org/regressions/4F0FAEB6-A13B-47F3-BFF1-C706686C6F64@gmail.com/

Signed-off-by: Esko Mobius <echoowall@gmail.com>
---
Esko Mobius (2):
      Revert "selftests: net: packetdrill: add tests for advertised MSS with PMTU exceptions"
      Revert "net: advertise TCP MSS from the configured MTU, not the learned PMTU"

 include/net/ip.h                                   | 25 --------
 include/net/ip6_route.h                            | 37 ------------
 net/ipv4/route.c                                   |  4 +-
 net/ipv6/route.c                                   |  2 +-
 .../net/packetdrill/tcp_advmss_pmtu_ipv4.pkt       | 67 ----------------------
 .../net/packetdrill/tcp_advmss_pmtu_ipv6.pkt       | 67 ----------------------
 6 files changed, 3 insertions(+), 199 deletions(-)
---
base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
change-id: 20261026-advmss-revert-5805de17369f

Best regards,
--  
Esko Mobius <echoowall@gmail.com>


