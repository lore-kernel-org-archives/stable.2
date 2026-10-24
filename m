Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840734;
	b=vb3+t8y3hNGAQ7Vy8MtKRW55fRgoKEtViMliWeCGmzht5735MvBKK63z1JLZAg/c92pb
	 Zg8bb9MvJ9DpMZM+g1/iQ00/SxqjwU14hSokr+AbrT7X/sEFRwj6BE6Ud3oJgORbgUvcm
	 CWFGshpsgodgXrQcxElEd/MgSxAK/V2YpP7CoOzDGWe7PQyofVN4JXeCyoyS8e1vjnHDv
	 NCMZNIOCIMlm9WroL6O1j7qWvWd/VvEaXNd73koE2BJ+Zei2/cMOJyjxr+3tmMUcpqCcY
	 bVzfcOYX1pfLVJ/Ba8aobx3NmeNass97K38/C/daCkql1hRJedJ1yIoUWZYfq0qE2qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a5n0iRolx9qO6lWkQ1qQ0FT1Aj0ylHE72a9G8Xcc39s=;
	b=FFLTMHNxBC4Mf5eCb54mm/3/oOnjEIo+mjqGK2AHuKtgD6WDQyo6+Xjar5BD2T/xNYtM
	 U/11cbFVX/DwSfxGWRxPfp2fe5cOp7OhLHbJ3uGJnDrHB+gagtoJdndqkS3ob/2ENyn3R
	 qisMYZlc88+lcAEB/wHf3SY6WycHxKoUswA3RUabeIPFjXYHww6qx5qXPUby87oHeP1O2
	 QHuJnkLGjJWnImqJUZ3OIowtmIVRb6pvr0jTW6/pJqRGyop5YOCJh4/+b4w9HQDAmG7hf
	 WEItWptFHBaMWnlhT4xYWxg+B74B41athoSY/r0CyECdLRd77xoiyvTBT9EGxDvFEcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s61xxMrP;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C2606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 11:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E14C2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s61xxMrP
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso2912256eec.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 04:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792840733; x=1793445533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5n0iRolx9qO6lWkQ1qQ0FT1Aj0ylHE72a9G8Xcc39s=;
        b=s61xxMrPLZtFBFp+ojpkAqzNhGrQKMW1txkBc/0u9zwrdMBUzbcSZRi3FP4JGlx7Di
         3nUb906J/ojhte2INqtZuMAAWtWGPsdRJ793v8lNyxpmnyyasRmQagmNrYBtIk2dcNrL
         nq4IcPtkLbEuGOg9fwh6QR88k+R+Z7G7fPCeGBLW+ooEO2XWVC+vr/GNjlalma0ql3dM
         YLAgMhmi1GPpGRLXxZwXW+HLtXw315YdWH1LylEdfrBdUHAnJJSbxX8ekEi4LZ1s5FQ/
         dw+LS6F3+n8BhAMRgrKtF4y7hlB+WUPeAWUq+Vu6s89KLhM5xr54rlfmKvPzM69yTXEl
         oB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792840733; x=1793445533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a5n0iRolx9qO6lWkQ1qQ0FT1Aj0ylHE72a9G8Xcc39s=;
        b=ZDNFPgs8/Cdgs0l0y7qLMIZHZmZj05jJfNE+2stM2VB3yK6y7LXkm4rkdauzuxjI2Y
         /Rx0oUQhSzdZKsOtjhnikcieDyZ0LicbaylgVRPuLLlQjgq/N+w5PvPHvQEicKHLclBv
         Iy351GmrXhlbS9DJwRCKtYTsAStK03FTZOPRUMuTBvR+4TykdNEYHz7bx5CFxETSWump
         5GYQAhpxEi834CngwPo0KBhipRmi15sYhKHJbO/kvv6S0PbAxAit6YhD8CqsDpFOkYxp
         hqnbFXUFooCLSF4htb8CikwiuBqvQLNfF0A7KRe2mMdTtRMHFZ9J6ZseUH/kbd8AZEyh
         Nz8g==
X-Forwarded-Encrypted: i=1; AKwUvBzg5nfbB8DmFkdYjn0/St4a+D9xBKnxWJdE0G/V64SkPIYncRyovNbQokbqCBenkXVE5FJHFdo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyQiqrm0gZWczkeX7NoRWggU9Daa7aL5YV6cZqKG1hrHRTxkbb
	LgGj/fv4SX+Lq7AQWqPuu5NS46dWcNgyhVEL/bU2ubaKeYjlM6JA3WAi
X-Gm-Gg: AYBFou2LPkD3Nyo9gSGqLO0s91WUFtej7FIecf3+twZSHSV45PdenPJWruOReGhTVyk
	jOu+cT+ZoYIDcX4kFXm6Eyxy0GTitIpQcH9Fftfs9Oi88DR2Bwyug5zvcFQrBo/hn0r8ZJ2EiBf
	M56fw8x1FgkBpvj6wHowsca5obxj1XbeVECjzgSFw6cV1WNlRbYDtDHf4zTnKxZlfstNglSw1m/
	bQBSxWjzLAYh3/0lVIqLrUmr5X0qWIbmQZJb+wXjHzYLcaekBTU+rynGhh/XYFV+9jtDFB9VmN6
	dEUnoWvmodnuE8lmIC66xJLnvV6NUAigpvdEb/sac8gANYWq0D2FvSd6iq6i7qa5f+2MGQRCYPv
	xDjpnZkD+DTn0oMbfxqG5fqdM15BMh+RjzYDm+KM7MRJAiLN0I2SEIe9QNVkviBIEXLEceLLmgZ
	TIant7hYCGFaspM6XQoXiQc1Fn15s5DDW6SLWHjU8rtV9po1ERptTKaNEXFVKUpSjbReb8LgWOx
	khGsCBPLoODEpm1bPAaAiP/5YyhMwcLkCxPRz5I/JpgPx8Io7kBsjTGbbLz
X-Received: by 2002:a05:7300:fb01:b0:351:4a80:d94c with SMTP id 5a478bee46e88-369e862a0d5mr2640530eec.21.1792840732876;
        Sat, 24 Oct 2026 04:18:52 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8afd64fsm7458774eec.0.2026.10.24.04.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:18:52 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v8 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Sat, 24 Oct 2026 11:18:42 +0000
Message-ID: <20261024111842.1069878-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024111842.1069878-1-w453y.me@gmail.com>
References: <20261024111842.1069878-1-w453y.me@gmail.com>
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

Do the same with the fullmesh flag: with a second subflow, after a reset
of the initial subflow, and with the initial subflow only, then re-adding
its endpoint or adding another one. Without the previous patch, no new
subflow is created, except when adding another endpoint.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..65ba01356112 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4424,6 +4424,139 @@ endpoint_tests()
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
+		local filtered=0
+		init_nftables
+		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
+				ip saddr "10.0.1.2" meta l4proto tcp \
+				tcp option mptcp exists reject with tcp reset; then
+			filtered=1
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			ip netns exec "${ns1}" nft flush chain ip filter INPUT
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+			wait_mpj 2
+			chk_mptcp_info subflows 2 subflows 2
+			chk_join_nr 2 2 2
+		fi
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+		# after the cleanup: this exits when all features are expected
+		[ "${filtered}" = 1 ] || mark_as_skipped "unable to set the filter rules"
+	fi
+
+	# only the initial subflow: once its endpoint is removed, no live subflow
+	# is left to take the remote address from
+	if reset_with_events "delete and re-add, fullmesh, single subflow" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		# the PM worker accounts the initial subflow endpoint after the
+		# ESTABLISHED event, in the same run where it creates the subflows:
+		# a join on another endpoint shows it is done, then remove it
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 dev ns2eth3 flags subflow
+		wait_mpj 1
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		sleep 0.5
+		chk_subflow_nr "after delete" 0
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 2 2 2
+	fi
+
+	# same, but another endpoint is added after the removal
+	if reset_with_events "delete and add another, fullmesh, single subflow" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		{ timeout_test=120 test_linkfail=128 speed=5 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		# the PM worker accounts the initial subflow endpoint after the
+		# ESTABLISHED event, in the same run where it creates the subflows:
+		# a join on another endpoint shows it is done, then remove it
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 dev ns2eth3 flags subflow
+		wait_mpj 1
+		pm_nl_del_endpoint $ns2 3 10.0.3.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
+		sleep 0.5
+		chk_subflow_nr "after delete" 0
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		wait_mpj 2
+		chk_mptcp_info subflows 1 subflows 1
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

