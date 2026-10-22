Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659056;
	b=gy2sWCGkzNMaV3FI8RAH0HVm93ZZ+XqDsWna4+BI9111jdEHOiIeP8u4ib9LtrrNa+aJ
	 WZxtgs4/hI4z7pgRqw1VtNPHqTCBuMKDuhJW7S4WtZT5FnjbZZqx4wW9+wVl+29h/uint
	 QJpHD2w/bnsoqykujYsjfQTp+GIFtLAvCJpoDs4GC5J0L762b5nS5nBH9O4BN27WfkeT8
	 42zx7bVDKR4dnAxu12wxD08bohLwVviZl1NtRElZWfcq97VO+k9wnTSpJmNJLN9ibwOAY
	 /ffwKiWkp4CZm16ooM3kLf6ATrF3cRI5xEJWjU1dN9XtFo4oHXAjXCy5sVNHf4TUcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gArmKloCONmWsNnso4T8+VfV7ei+OVH+qReeovhn4bA=;
	b=Rxmwdf/9Tcse0+ccrBNQMG+QmN8f9zDb5mX0dCxz1E57lba0uiPyvFxvTsdovsDfHUQF
	 MpLMgj3YvahP+zp6um/8DAx3I41TNnNf/uzj3ktSeO+kFVh28aDgYJIPDagNXRAnWrRTw
	 xtlGQPtTjKtIk5R9kVJ7l7mApL5zYEf5aukMVzFKE9EZIHQhZkz0/5NVy0rwh5AIjRTwr
	 cdXmfplrLJaB6iQeQXmsc99oPgs8tUb1hvVtnaE3gRN2NgdX5f0b09111boSesFJOCFGv
	 24kokb5vEFONUDGJS9ku2TFVCeW4nWYyqqCJTWNdQPBdfOBEJ23py2SkRK4KUytHlMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=onG2Z9aL;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224A606A321
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 08:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7224A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=onG2Z9aL
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514b90bb89so4315797eec.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792659055; x=1793263855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gArmKloCONmWsNnso4T8+VfV7ei+OVH+qReeovhn4bA=;
        b=onG2Z9aLx6Ax1aaAlun8GwguRPLvi0tHmVKDDm7hVfweu9CiLSbMQwrSLTW3bEFzER
         hx2SPnGlNRWFmnfEjNZ6f2sFGOnT+HO3XeTR5tyJzrEpctuUmE5C3pUj7WERzlJw/nPX
         Q/MiZx+DUwHosZtbPjStzR7DErUYqdbYVx0jHTeaAutlpxuSXg90CDtbmYXLllKnmqeY
         +MFMurp7/2SyusyqLZLv+jfBC0CyWQ3qvess0/UL1NADdVq9qSov4uU+LLvYjt15fBBf
         CL4lrQBqmFC65a7xJelCdShYebApGK8VjR+18pRtt4Qs3l7ZsakD7hMHm9xoRAYsafLl
         ZKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659055; x=1793263855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gArmKloCONmWsNnso4T8+VfV7ei+OVH+qReeovhn4bA=;
        b=1mSlM8R00Ss/P6a0zRHRBRUKUN9nSSV3a2gcXbGIKq7yD/sFELsq2iXwIcysGBOwlR
         TK5ScsCBQvIjcdJB8N1+tyFMHeM90zxNrEYlRMLweYGyB1+h9xySwToFSqNmwPRb/kc5
         9jyqbFs9LS55wxaQp07TL0udr0HtE4mUJx2/iQWR2F5c7TTfvPy9pZmWWSE7PaQg/qCo
         V6eBEm3Z+02qDquZp9Yh5shfT3sWjX4BrsEMtJN0RcfHL7ks7a/yrw8WBpRApejGRTim
         zDfv6G5ds3K5L9Z9ilofGa22D117kSMTOVyu8xvQRCjdM+oFYZyTdus3MmynaZyuoMQE
         uomQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzGkjE1NVvyjuv9ya6WGTQgmrxQ5Z9fuSHJWZbpl8INiTN6JNfm9eQleXIHSDPKp9hdm0LrGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdaNt8aqVGPB2yrjpCFFiC35+KBbQWMkoH1MG3C4bIhlkH42Uy
	Bznh8mWEdeH5rPs+rEP+by18/H7/9IIZGnoqkK2IbPclypbvPbgXT+S3
X-Gm-Gg: AYBFou2TzAHKCqEZoDXiUc40/y+KGwEGLWXIFYGtiS/88BLBnQV4cbolEP7Xj9+HpuA
	Btfkx5fHOOrYya/Dx7p41jR2gBY1AlMsVqbWn3jV8DZ2Fam1ZBtRZ9fUQk1rjUe4FvIfWQRiQ+u
	QJtUsOjLM1SvUYnSjSOPx40Q32X+PFSl6hbzzLZ+vWUj43dPkkemT7tv/O5Z5FTR/a6coE1pQjm
	9hbKjGy0p6UEJGHyz+pbMmhh4AyfNO2Cj8LuA/iyne0Jozog6UXPkG8CF4pcWA/46/eMlWC0VP/
	lVXlVKcu1161U8q1OTY1z6MPtFrZtKigpUvckP7mQVijLkgaKp45bnR462C7mY+FhBkamuAHCr3
	CozKPhn7FFnTdyQdDjWGgIu0VGiGr4bcWWQEwPYzXUyptqc155OMaZuaQGyk3mzHfDZ267yFGEb
	j63alECdSPiE3YH8PqMFr9TlGwJoVHnIqFU/++jYFt38aO3akXjOiHcmdsCW6e3b3r7koOQjGQk
	bjCFVehEaWfFpeILl8JS/zoE9ilvmAB4r4j5d5WtMRRY6ULZIY+wRsK/uZt9UAIWilYSoRapBUP
	Fck17Q==
X-Received: by 2002:a05:693c:42c9:b0:35c:e696:2d4a with SMTP id 5a478bee46e88-3674d347be8mr1064378eec.24.1792659055419;
        Thu, 22 Oct 2026 01:50:55 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm25343328eec.2.2026.10.22.01.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:50:55 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v6 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Thu, 22 Oct 2026 08:50:41 +0000
Message-ID: <20261022085041.211318-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022085041.211318-1-w453y.me@gmail.com>
References: <20261022085041.211318-1-w453y.me@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a..52031288b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4445,6 +4445,123 @@ endpoint_tests()
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
+			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
+
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+			wait_mpj 2
+			chk_mptcp_info subflows 2 subflows 2
+			chk_join_nr 2 2 2
+		else
+			mark_as_skipped "unable to set the filter rules"
+		fi
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
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
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		# the ESTABLISHED event comes before the PM worker accounts the
+		# initial subflow endpoint: check the subflow is really gone
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+		chk_subflow_nr "after delete" 0
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 1
+		chk_mptcp_info subflows 1 subflows 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 1 1 1
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
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		# the ESTABLISHED event comes before the PM worker accounts the
+		# initial subflow endpoint: check the subflow is really gone
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+		chk_subflow_nr "after delete" 0
+		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow,fullmesh
+		wait_mpj 1
+		chk_mptcp_info subflows 1 subflows 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 1 1 1
+	fi
+
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

