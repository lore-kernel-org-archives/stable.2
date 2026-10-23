Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753412;
	b=ae3MazkKTxmeFh1gXjTI31zQJGTtCrKP9v6a7StR+grczf1VPwqUCYJ1Ofdp8evrusYA
	 549yYDVHmxClbz8M/wbTPTrgbVUlq4XqP1UK9A8A62Lne3rtFyoxHy+dhSnpGRrRN9Zz1
	 DMxjWI+yLakhy9ENn0+rjtV0ruagRcMrkg5ZhwQMDZYdYJGU36TpORMKZQtBstso+M3ON
	 pykym/xpX8Cc94Kh82xccdFmGuh3YNGoKUsAT53V88aGxzdLDtRmUlju6b1WCDifNGwez
	 0/Y3i6vPOBvAmPhbbr+fw2t4Q07A5vfn0HKzOonxj0Ox0knoPoTChJ/gQQZQ7iVh0oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vEo38iKS1cVn8oUkfPI6+BGq9Pc+MWzOJphLGvvXjjE=;
	b=y2BJOOFqI0ePv0QDEdap3EyYK3mLKm75kmLaPM7V5bONNhsKU9oST+lvikoD/Bl+Xi/8
	 qsu5M9vgUYC8OC7Qnd65Hb10TFWitnXqDjtyDiTOWnwLnU/W5E9HaqvezJhoBQUUgQ5r8
	 b5UwN76PSeYAd9b7ScmTdE2UI+pWM2wuE7C8atPNcMWHa2DoMHY+/cY/5Z+mTof9YLV4U
	 VxRpIRFaoDInQoWneaSZlcngRAhqmHULN/KBL5aAw8M3gHjLNygyZwqSrc4XPV790L1jB
	 CxRJ9gUfPYdQOW3k52AumbI3y5W07R3aZotLEQcpROYug6xJkqXGeGlcl11ia1impxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AX71klU9;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A3606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A8A3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AX71klU9
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3550c917fd3so1146118eec.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792753411; x=1793358211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vEo38iKS1cVn8oUkfPI6+BGq9Pc+MWzOJphLGvvXjjE=;
        b=AX71klU92PCA5rQXxjzLfkDHfWVhBJ1U6LaQsKUNzzlNbmt1gv/SYQxtoukW2lPhCU
         6oObjhYXcmpIsfJ1PjyBTQ7VtbINWHEcKWqbdcGlLclItu2cDyJ0u6XP/v/DvoqYIkl1
         RcaLajum6CoEozwk1D0TcdejGWnbxW4NQyMZzK3u1oOV8t0CIHeiiGIayquUi+C5LPyJ
         CBKZN07dhFkahn27VZj3CnY0nOVw+Yl3nXqwHvWwVDSDMk0iUy4T9cW3hawN8Mv6d7OU
         QcdlHmd17q9Qq1A01ldGJWzIX7DikEtQ1HbFlkQG9xAdKy+Mi6yz+EC1dWIxRNnLa/g1
         CguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792753411; x=1793358211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vEo38iKS1cVn8oUkfPI6+BGq9Pc+MWzOJphLGvvXjjE=;
        b=vXg/cIexbfgH7MEhZuvxs8SBdlHgK7zmqGbTUwQA9mvGAjRJcRkqt+3LrEsGW+Hdfe
         VHYUB1DU60MatYFwv5ILo+V7aF9ky43U1oDGN8/wxNlZ5AN6ht4+MiH4Oj0l6YJ6c10F
         vvuoOZkc9xsWmZJzVelaAG/AmXMFVLLjYv/+mnOuZzf7g1n/c098g8i4qGQGvzMZG1/T
         99MeVGyABjNEtDmoeVoor5MBDqozk5PJ/aucn5ZlAKW++qrQRYl6tMxuNWPJR71cxyeh
         ps7YGhQ03PK21GaTlxJEaXBsBIhF42wAiNRKSajmqAJ8sa3kjy1OyT1RYKF4QqbjF8XE
         9PYA==
X-Forwarded-Encrypted: i=1; AKwUvBxqpi/VfUw5FqWPuZI7hHOhw3R/Bbi4q+x5DfZWSRh0wDRNIfJcNgHJXRM64Ff0387xyVOd3w8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTWDjXpuWC0LyXfUQsT+MiV+sJ4pjPsdpb33Sgde0asXd5uk9R
	Ss+qXdYX1EVfeWfV1rZ/XPWARCyzRSAW2eCETEC+7wej3jJn//+C0CBs
X-Gm-Gg: AYBFou33AhmLkrrUQBKjeEL2qbIlG3gBQmpaBF/ZbzwQj5ULUzy2Q+y7fUlqUgnytjB
	bA9behCvsaotImLtQQzkG3nZ4eEtrxvPt7O55NThQQHNoHqcAbrfIynOdOdUCcKBP4zzeFWDUGy
	zZMCP/RUkEcbhhW2AczGRzi0xFcQCY18n5zwycsbZa/Qj0h6pA8mTKZmPxAn9WJzy7crToua3fZ
	rPUDhi36uZNHhrmKV/O6vWrV09XYQcgDj6+i6d96qkMGJUUvcAaH9cWc1Ix7B3v80sJ3WnaJrAm
	/EFTuadfRCQzD96J2SuCG0HV70J1x6mqixfsMz6JYSV9cQa5zi91L1lmIQyi2VINB1tKegYVBZu
	lQyeRQe4eH8GAgL8Qs1RjTbtLC3B/HaSDuk1OlLpOopsdFixil6MHLp5uLDBKl0TOB6p5dKTfNS
	4kSz3bsSAk1rXMd8CyWI0jL4ykLOHtzLXYokyr1BaPDCvafj7c67ha16fV0Z+2IhyeBe1oSlQO1
	cVflI9vuLwSKyfdv5EF/sAzULTkJM4XeRJ4ILskKyhJ4v9JV8OEoC2jigI+
X-Received: by 2002:a05:7300:e9d5:10b0:351:35b3:c5b6 with SMTP id 5a478bee46e88-369d9854d17mr2857439eec.27.1792753411305;
        Fri, 23 Oct 2026 04:03:31 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9defcdcsm12695186eec.23.2026.10.23.04.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:03:30 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	Abdul Wasey <w453y.me@gmail.com>
Subject: [PATCH mptcp-net v7 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Fri, 23 Oct 2026 11:03:19 +0000
Message-ID: <20261023110321.403874-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
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

With fullmesh endpoints, removing and re-adding the endpoint used by the
initial subflow never creates a new subflow from it: the closed initial
subflow stays in the conn_list, and makes the PM think the remote ID 0
is already used, or picks its reset remote address. If the initial
subflow was the only one, no address is left for the remote ID 0 at all.

Patch 1 fixes that, patch 2 adds tests for it.

Found with a router flapping one of its links: the link carrying the
initial subflow never rejoined the existing connections. Tested on top
of export-net: the new tests fail without patch 1, except the one adding
another endpoint, which already worked and guards against breaking it.
The whole mptcp_join.sh passes with patch 1.

Patch 2 uses iptables like the other tests in export-net. On net-next,
mptcp_join.sh now uses nftables (be3b69f3cedf), and ${iptables} is
empty there: this is why the CI failed on v6, it applies the series on
top of net-next. When merging with net-next, the "after reset" test
needs the same conversion as the others. Tested on top of export, with
the endpoint tests passing:

		init_nftables
		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
				ip saddr "10.0.1.2" meta l4proto tcp \
				tcp option mptcp exists reject with tcp reset; then
			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
			ip netns exec "${ns1}" nft flush chain ip filter INPUT

Changes in v7, after the review of v6 by Sashiko on netdev:
- Patch 2: in the two tests with the initial subflow alone, wait until
  the PM worker has accounted the initial subflow endpoint before
  removing it: a join on a third endpoint is created in the same worker
  run, then that endpoint is removed. v6 only detected the race.
- Patch 2: wait a bit before counting the subflows after the removal,
  as the other tests do: the closed subflow can still be listed.
- v6: https://lore.kernel.org/mptcp/20261022085041.211318-1-w453y.me@gmail.com/

Changes in v6, after the review of v5 by Sashiko on netdev:
- Patch 1: in the commit message, the closed initial subflow keeps its
  remote address: only the destination port is zeroed, not the address.
- Patch 2: skip the "after reset" test if the iptables rule cannot be
  added, instead of passing, and check that the reset closed the
  subflow.
- Patch 2: in the two tests with the initial subflow alone, check it is
  gone after the removal of its endpoint: the ESTABLISHED event comes
  before the PM worker accounts that endpoint, so a removal right after
  it can miss the subflow.
- v5: https://lore.kernel.org/mptcp/20261021070324.50533-1-w453y.me@gmail.com/

Changes in v5:
- Patch 1: when no subflow is left to take the remote ID 0 address from,
  use the remote address of the MPTCP socket, as fill_remote_addr()
  does. Without it, v4 also broke adding another endpoint after the
  removal of the initial one, when it was the only subflow (Sashiko on
  netdev).
- Patch 2: add two tests for the initial subflow alone: re-adding its
  endpoint, and adding another endpoint.
- v4: https://lore.kernel.org/mptcp/20261019190558.465270-1-w453y.me@gmail.com/

Changes in v4:
- Patch 2: only check the joins when the iptables rule has been added
  (Sashiko).
- v3: https://lore.kernel.org/mptcp/20261019185512.458313-1-w453y.me@gmail.com/

Changes in v3:
- Patch 2: use iptables instead of init_nftables(), which is only in
  net-next (Sashiko).
- v2: https://lore.kernel.org/mptcp/20261019180306.382039-1-w453y.me@gmail.com/

Changes in v2:
- Patch 1: also skip the subflows in TCP_CLOSE: the initial subflow can
  be disconnected and its context reset, clearing the 'closing' flag and
  zeroing its remote address (Sashiko).
- Patch 2: validate this case too, by resetting the initial subflow
  before removing its endpoint.
- v1: https://lore.kernel.org/mptcp/20261019170751.200446-1-w453y.me@gmail.com/


Abdul Wasey (2):
  mptcp: pm: in-kernel: fullmesh: skip closed subflows
  selftests: mptcp: join: re-add the initial subflow endp with fullmesh

 net/mptcp/pm_kernel.c                         |  33 ++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 129 ++++++++++++++++++
 2 files changed, 161 insertions(+), 1 deletion(-)

-- 
2.43.0

