Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753419;
	b=KZUKIu1eYanR4owBfhW4tDZv7TDFIqZIgIZxrgzCRVBXWkri4OtopbS9YC3XwC3TOEmB
	 T6QEw/XYriwaWNW2h8ETXvNXOUb02UDe83lCOzjVO70i1LO9FCcq5xLoiAMZeRq5xR0/q
	 +1Z0iQykTrsNLYCY99HpAqruYnecZMlzDk2jTtDN+hKj2gB7PZTlZ2dCJJ6RX6zT4o21b
	 0UMFZMu7UUDUh+HMzMZI8e77Pewp9smJR+8vnVOQujeI+RQXPe58yuFjMo8Sj+smwssG+
	 xLzWrQ18UCWFZmJPthPxOrWC8tLEdbAf04ZdgNyhx0AhjPFiIUyFRoagBaCWYReyQJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D8WSvsqYPXwHzuflPXXQhy6iU9YbbeyU05E1t9Ks6co=;
	b=atoG5m5U/AhY/VgKsEdiHEM984zgk3W/vsY/OPJgVZhoQv11dj+5+sRjHc0EAcUk1Lsh
	 h9ENxQQIfU7oaQTofxSwEv0VCr++RHvPgGEjXRAmwlLpLlL/2X/APWmcen7G4++lbT47f
	 lQo+Ab/YVacWLcDUFQbMaZO0FD2yW3lvfu8aQP8uMbgdnUfwgqAFCsb4QAoXonuFq7SpL
	 3Gq8r3n+NOMImrOcrn8wPpx7mspVKDRuYL4uvdXBP3onIip2jFVDkI37NPNfSjw5zwvv9
	 YmI/SITIvot8kKfq0fYtIcCtKQ6+N2xEWzQJAAl5fJnXzL5VA7nSWKSaLpoyM8PkLuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sIYEI+pI;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2FC606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD2FC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sIYEI+pI
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3514b90bb89so1711609eec.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792753418; x=1793358218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D8WSvsqYPXwHzuflPXXQhy6iU9YbbeyU05E1t9Ks6co=;
        b=sIYEI+pIVUW/a+naNWARgVWwIg7E8zMUeAmCBHH7jgEBcveN5LQsV8I3o9UwksBkH3
         a1UX2ndJLs5Ub3G8oqmymSG6e8KE1eAvipb+Mu/+1BtRtqU92MYyBdhAQJK1036EbXPY
         YFjwJsRN8uaUWF0LIvHyKGJI56BWbipkyypLKpXgN0RQ1rwBUE/q9VxqiMgTBNhRMkO0
         GfS2BO51iKsU5yD+ZUp0fDgADyO1jVwJ752NcfJOQNA6VUGtFtdH4/OZ5Gbr4JE/NM9z
         VcbEPZ9l8bFMUNcpquhQxAxPpI3YoKRF9QQd2+ubiN0r+qjBnBkRTPQ6nv7e3s0EsLz8
         NHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792753418; x=1793358218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D8WSvsqYPXwHzuflPXXQhy6iU9YbbeyU05E1t9Ks6co=;
        b=rC/leRP00PiQ7F7b7AB2WkApslh2+E676npMd9OtI5G/3BBtSN7hVcsg9KwtULBE5+
         J7bznXVDYmnXocTkQOfzkDqLFvQqYhJK7Jv312fuXeqrFiIqtmTmrnQ7JDXHm2XkF27T
         HavA+gN3CttrZXaXRBS0pbLb082NO/fO9QvJtWvxNzgHDNLAx1NESa0L9CAk+wLPUbzc
         UjKeLFfKXp5t9UhEmcQXKsrok2JT5aMWeD/9V0ueTsr9Eq4ZrBO9OVMT+8hFsKlFR5LO
         qjnvmpx+9tU/YOODdjmjYcycWF3YyJ37zgRsGJMcaGOwTBA1qnDu4mev8FF4FEjsA0X0
         dXQA==
X-Forwarded-Encrypted: i=1; AKwUvByQwoIPVjip681qn5ZZ/FrA1s6bhdYoTNg33k8RACY7j6yQbksWbDjy5IJnq8RUMnIcs1aFVlk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTc57x4M8NS1Use1JrXQbvVIWXcNOuE4nZoHyW8jL7ZlNpPGBE
	8Ym3IJhU+SSopsB0BwfoM2I210XDftcvemiseA5bhbVVFZEB45lYJ4RU
X-Gm-Gg: AYBFou2WBveaNwp6Sm9EmBo4MdAySQOG2ePj+4gp3lLqgOb30q7Imqh7VbIALH6EJrM
	dAwkcPqMcZVa6dGSzkQdM9+wfNNHQ5EP6bIgnms+qbDB1RJHI3xWtyIt2JkhysrQLnjxiYPTVo0
	YvelQjO8ScbcE/+VGvd2CbfsFb5VsL33S7LaYWbpAbwCJHJpkprA6M7Be/w5jZ2EDtvQygY6b+u
	WSQPgHwOqsvKoA2DZ8kBgGY82b9p2jnMN8+j1sTijBWGeH/lGzddh8e1B/jLREguXOo+qvg+aPd
	4YuyqckLv8TxbYZydTwwKZ6YBOVLTk/dCjqnbrVrsI2P5gPLVEevWP7tE8UUqOSmQBxO/tkni+f
	uVEvropovZ+hq7ddPxmjbghtRpNFt1skdXy4/mYI47L8aM9M0iv7Onz+AgIPsY/zaMfyVpZ11lO
	/UlXrCeKfVlUWmHwqW+NSXzx7L7it0fRdVUvyZj5MsBHgaGYqKBFTmGo0N1DHOughKe5uj3jplH
	LUzRGgggR6h8HcbWyZTf9TFtJP9rM1nf4qTwg++kGgSQDesyRdfko7QmdkP
X-Received: by 2002:a05:7301:c011:b0:353:5908:36fc with SMTP id 5a478bee46e88-369d980d5a6mr2342769eec.17.1792753417585;
        Fri, 23 Oct 2026 04:03:37 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9defcdcsm12695186eec.23.2026.10.23.04.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:03:37 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	Abdul Wasey <w453y.me@gmail.com>
Subject: [PATCH mptcp-net v7 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Fri, 23 Oct 2026 11:03:21 +0000
Message-ID: <20261023110321.403874-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023110321.403874-1-w453y.me@gmail.com>
References: <20261023110321.403874-1-w453y.me@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a..4cb3a546b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4445,6 +4445,135 @@ endpoint_tests()
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

