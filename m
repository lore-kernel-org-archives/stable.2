Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566218;
	b=kJKWcH4a059bXBAwgCYviCuJ7WSRP5DTHAn1DY2RrPxIu3iok+qU0MG3wmj4Dcph4FFt
	 eN0E+iFqTmhhIn/rbAQ59/j1rxZPVm/oyviT010behpF13tn8mqD+2dOigxHATTCuOeKs
	 Jig4oEgDFHRpVqbTFyReNRfUU82EvnFABQj4CPSb+wU/dh7zXjVS77p0EXN1i6KA5rTs8
	 i3G3q96+qX7WLwPV4lCVQ5SrCuG2vNEudiRMhUtt4JYh+AtWAPt3tHv3p/Nen67tpdDST
	 sp1e66W6SBve1RLZ+5ipzTyyUB2eY2log35XhGCBu1hdwAaRATpndbwhP461boQhldQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OTuelo28LtKtv9zZAt0jyN4R/II6FPUmb0zaJoxGTxs=;
	b=gxr14BAtteArLKZ3vsD1KIlV98dVP9rJMxbghrY2lU5SZyVhzvFEwryq9AcyJP/Gamxm
	 035qMtcbBRo7bCdNX38IN8Owgz4AkjYbWqh+DHDGj/YizJpdCbeXT5961AUvg0jeqIqXh
	 mM0Z/dpiXW+ljtqQCWxrOQe5nxDA5jbeulta0y4ZMQZ4VjDIEKBvgtTZHoaHTY49k3eMb
	 NnjXdnDEOdLjOVj8JBb8WfXduZcseOxO9POW0qz1nX+DrslKI1gXWcvzrh2NmQquMixO+
	 F/nFeSZue0eUeUErxwGeRsXvRVq/gcCzBlOm+k40nnDCa0xl4MGNIFCiqlffxmPnL0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I5CGaVdU;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AF606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I5CGaVdU
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3550c917fd3so472438eec.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566217; x=1793171017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OTuelo28LtKtv9zZAt0jyN4R/II6FPUmb0zaJoxGTxs=;
        b=I5CGaVdUb80VSJalY8rzqjtRHNqAb8+jRYo3zOI+ycsxBQUtv9g8+2ZCJ6xVy0nvMR
         Rfnb7DN3dSJt/NbdMB4zgnGSpUp4fa+WyECDlejHncFYGT5nh4NJRH21t4dmSO4OzbP0
         wnWvfpjcmQs55iY1H5etbdQsu2YWa3ytEuHs9f94gi5NbEMhRp+51Z/rrlIDXjmsA9i8
         yPb9lO0ImP5muEt/3qyi04GprrQepnZIm7UaTCWiM+nwvZ3uDhq9rIfY55RKp77Kmeei
         Dkpne2ILUgjTRGTIG/yzp65C9wPEvKGyx2uHoyb9fKLUXUQif/qExc5ydKmzicU5C2xS
         Di9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566217; x=1793171017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OTuelo28LtKtv9zZAt0jyN4R/II6FPUmb0zaJoxGTxs=;
        b=Kw3jRgaSG02aJ3WdB0A7MGWDvMuZQQ6cvh26QfuXgjwlreKxbRt/8APrWauJPrZYh/
         q5BHVg1tFqft42w5PkoeE8Y+iVeNFFDSoTNdvaTeIvjUEE3kVDQr+U/Ah0Gbx2jlDLhc
         AnF91ui7BJKh4aoOKAX1TxdTxFLN3Bt6/dQo8V8gp6pmBQQx2BIyfmkKSs/4mJvKb8hR
         KVK4aXIRv0F81EGFG3fkyDNrvB4bu8gK7ryg/3pNOXEj9pNqvno9h64Bkdpz94N9AVDS
         ibiU3PjTl5Pavlzdgp6A404EzHimOAMTuGzDpO5GUE0aUbj1wfpoLD6tk3npdQFylQ9q
         N/Uw==
X-Forwarded-Encrypted: i=1; AKwUvByIa0RTs8MBJzmDzl/5Tlhv00O7CT6xDEoYzbiUIIuUsYyZ1zdlpTLuoh61Yx2bG94sAx6TuWE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7gm5IV4NtjfhZkPTUa92/QnwGvWlf444P9CQSZO+8ovWqLQSL
	pVvY6KHRKacFUrTw437UR9UZhDorMuZvwlSjQSUaEYckYufVQ/fMSv2l
X-Gm-Gg: AYBFou1udKev9hglvnkFcz2A97v8YJRjQWLkaDQvEcu2ihqoYLsG2im0OWF1mgtr0bS
	WboYA4j9gyU2tAkn8z4roJn27GNN2mpXVAytZkoghn/41+4D4+T3vOtC7uG6Kw58f27EssU10f5
	yAJEgWtb64Lzfqvx7Ok2V4RfxoBTYgKzwNBhn0IJ7FeBlw1XAw0tBTiIsh2ouSkW55eau3w8i6L
	Ec3PmenbQdfflthW9FaPxLz5cLlbYlNj/voMQlisNirjPJfm6RZwN//a4b7o1qEyM/x1LjfoDX/
	m/KNSjUJUr3QWQ77970spA0H5SfUdci9HFc5tItONtOcRi4+ATLdZnKwW/1thzC2Xzsuh8wTY/D
	Tgl6lqJSHKiMAdUxwkrzpUwVM4fynXKfrrx8P2vlfYunsfzdV/bF0BIgxdalId4RFjR57fsNM/U
	1XoeA8z5PlhkqYBHfyvqpeYelHbPk/0ObNWYNl7NcPdjAzPwxWSNrpBA020rlMpFSIDp7qUVrrV
	1wVtJGh+gQi8gkNsM4Ev5BAAqPFSAACKYgXglCvlJKnNDTBwe61cW/E7oaq5VHNCAySYZgfdpv1
	mYsImbA=
X-Received: by 2002:a05:7301:8615:b0:359:8492:20ff with SMTP id 5a478bee46e88-3674c43a7a8mr2023878eec.12.1792566216610;
        Wed, 21 Oct 2026 00:03:36 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm6468910eec.24.2026.10.21.00.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:03:36 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v5 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Wed, 21 Oct 2026 07:03:24 +0000
Message-ID: <20261021070324.50533-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021070324.50533-1-w453y.me@gmail.com>
References: <20261021070324.50533-1-w453y.me@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a..6d2cc01ac 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4445,6 +4445,114 @@ endpoint_tests()
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
+			chk_join_nr 2 2 2
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
+		sleep 0.5
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
+		sleep 0.5
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

