Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436124;
	b=mqTHW2EZJR5YbWz8eYjvZmtetho/xAUBQ8wmIHp70EnHS4Zn9j0xbKYIITmqxSBAyxIR
	 1HdyxOSn8TXMcwwxNnNwE6Dji3uWcqdbutR9vXi1hs+WkJir21LFXYSx8Lgw4ZkpnEZ2O
	 kqj3jq8EoCrZ22m/MNoGEnYopuitS8rWVoqOIktZBBhbndmb5eMr5AFrnlCXvnh60aNRX
	 oHD9n2SI8wXwFg0uncnbOpCVAoHx/bwtU9mahTa1QcOl7vOuKoW8cZ3tNYoJgo39FzFaJ
	 JwL6P6ZM3XI8JdcCpW61/6RzEQyFjiIP7hBZTH8OAWdtHDC7JQeDaD1hpUDax49x+MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3LcyZcPyLsm5vLv8GmntQeIR91Jnxb10et9/VffjMj8=;
	b=Q8h7/fjqCkYtegh7FgQ3MdP8F7Vdl5fIHD6d7yjCympx8GHsrATUiVvSz7f4IAUZ899H
	 ixTUtcNV9701TUXFTe4k/tUCkafhsAfff0ed8153+cpRC6qWIktCJTXT6EaTbbMlHdU0H
	 Af+L3YRbQbMrPAgWRDV0op2attapR+F5Q5yT31lEW8ePiXn1RDMI9jIJO2vlM30gJobqE
	 KZKWcVkq4UJ7SpBvE+vMWywLW2Z7dt1iSL68bZ/Lo/ufH8OQwDDNcSoX0v6vEoVGw01/z
	 Tm+ian14pw3CewN0WCi7TqrPAhU+Qwha8XSBmp4Ys5r6Bqh3d3GD2V6sI1PvBsylTdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YDdWx442;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA80606A31E
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA80606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YDdWx442
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35d7fa491deso2969618eec.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436123; x=1793040923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LcyZcPyLsm5vLv8GmntQeIR91Jnxb10et9/VffjMj8=;
        b=YDdWx442/Si5J1oi5fkTffDEygXte8NlzCODMpE89a3FHQ4roa//xRgPkkV230qbQX
         gR/Z7Ssj5POVpat3c+ZRtY9qG86T+fQH+2QvBBfFQyHIjTTgxe3VFxPGCrV4TkIbJxiL
         8+HPgODbBfrZVYKAAtF0oRlMG4IE8lSUsu9UX6NL4zXs2Uf3XLA0cqNIviq033D8Ao1N
         tn8737UxTTXYBbDnadW3fyzVrGhy8AOWpCefeDHKx+SvyFuYKbIj3Ka4tluESwGLqp0/
         scpab7IbR6/KYwHSYCsYwo42hY7Ya+NX0KntZQ8urO8LFWms11haQK43apc4Jceem0fe
         IhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436123; x=1793040923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LcyZcPyLsm5vLv8GmntQeIR91Jnxb10et9/VffjMj8=;
        b=LUg0Szy5S7zUUQKbfqtboKfuk0tjxRvVwOnG3QFfvFCU9PFgrLPWFvg0078q/bOEKS
         Fra9KONhjdczNUI6prbH4sZh9YdEdTB3W4N64wp7zJCgCEyFu7SfpwWIgi/+WMnf35AJ
         qKzCKC0BY0PEvdTroAU5b+aLqEIpbqf7WAMVzVePHX4YlJL362J1vwNGNGtGF6sXcoQx
         MhLTwOgX6izJAJ9Vjt2zKrMTqwgiItM0nynyGBhq1+Qu5513JiRV/sl09zq9iKXaiFMS
         zcLiNohpfXLDZU6b5WIGaQK1QGqVauC7I2CTBY04Rp10ypOoY1sNCNDJEVMG7pw6feaH
         zCXw==
X-Forwarded-Encrypted: i=1; AKwUvBzpfTS95/XkWLvdyoYvLOTqCmMu5oVX71ZgapLSmBI1yx0KDZOYRnQ6360CwcSuA3tBJPamnEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaOKrN5qaBOmc4k1R8GddR2rBOosgrc+g7Tc3NNY2npaW/uiR/
	N5J3o7b1fSp1SO0L/bvfDA6cPAoPx4RyQtfApXCrg/pVp5yHwxH8oTySfPbkCg==
X-Gm-Gg: AYBFou1zmK9zNaRp9UI2sva3dXKJ9NUmnqqv6B0D6aaStGeQDiexli86Votygc6hzJj
	sR0Hu3dydZq0b3WcWiG+C1HXg7DYwf0iUXYvSrYmilwyyhrzqyStdr9XxYqB99rHqbk3YRTbvxt
	WXbBxBAyZ8kxRUOnfYQsMVBjxAVnFzfWMwBReQKWpYVmmTfoZ6iAEfNFTvBXdYMhWju01JQ66cg
	asxr7a60NXuPPvgNHnfLFdv5vhXNkFNKoIE8WfMlyiJ+KO1om1cJOwp2JOR/zrqnRciOTmFkC2j
	hEVi4ZswtKvBTfdn6009C1wcs9DeyvRjeDimpiss8IrNxKj01TC4vrznig8Nc3b8QxLjrGnd3PO
	644C/OIBmuFH0BBdht03wdxu8hRLJoonn3lMqoKze1zokJXv6PsYIlXozPS+XZ7h8tH2pKBicOZ
	i9+fbZdJQ97r3fOTFIpie19VlI8twjPdMbab6RJjMjdSgovr0LO5FQgGlFEq7qby/NMw1rAcEDG
	GWaAM4v9c3YWFmJasT8f1Cjfz7iJv/XD7OBi884IexsGXwNrrBcsjUqngJoUAxpSEbJJ+32VwBI
	oHue8+UOmm8=
X-Received: by 2002:a05:7300:e7a4:b0:353:5d7a:cabe with SMTP id 5a478bee46e88-365fad8dd2dmr5511eec.13.1792436123052;
        Mon, 19 Oct 2026 11:55:23 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm35749512eec.7.2026.10.19.11.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:55:22 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v3 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Mon, 19 Oct 2026 18:55:12 +0000
Message-ID: <20261019185512.458313-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019185512.458313-1-w453y.me@gmail.com>
References: <20261019185512.458313-1-w453y.me@gmail.com>
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

The "delete and re-add" test validates the removal and the re-addition
of the endpoint used by the initial subflow, but without the fullmesh
flag.

Do the same with the fullmesh flag, and also after a reset of the
initial subflow, before the removal of its endpoint. Without the
previous patch, no new subflow is created after the re-addition.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a..d2d105cef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4445,6 +4445,68 @@ endpoint_tests()
 		chk_rm_nr 4 4
 	fi
 
+	# remove and re-add the endpoint of the initial subflow, with fullmesh
+	if reset_with_events "delete and re-add, fullmesh" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		wait_mpj 1
+		chk_subflow_nr "before delete id 0" 2
+
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		sleep 0.5
+		chk_subflow_nr "after delete id 0" 1
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 2
+		chk_subflow_nr "after re-add id 0" 2
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 2 2 2
+		chk_rm_nr 1 1
+	fi
+
+	# same, but the initial subflow is reset before removing its endpoint
+	if reset_with_events "delete and re-add, fullmesh, after reset" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		wait_mpj 1
+		chk_subflow_nr "before reset" 2
+
+		if ip netns exec "${ns1}" ${iptables} -A INPUT -s "10.0.1.2" \
+		      -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset; then
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			ip netns exec "${ns1}" ${iptables} -F INPUT
+
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+			wait_mpj 2
+			chk_mptcp_info subflows 2 subflows 2
+		fi
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 2 2 2
+	fi
+
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

