Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815491;
	b=ok0WCNx/3YLDw6nZd4CUM/nl32SD812kfJAqk8BKgnoaVinmU/YjcQcF+sSeFqT5vicW
	 scEVx4mTfDq5dfWNKeXZklU3pIoq2nEXDJT7xXGrz1pGulxmUAfc1FiHHKXfnVkhACukK
	 k7Td6qsjvglirmDX2fzN1XYf9o10YpmsK5UKki/++VEopFZ5BlzefwnDc8PS90mN6LWq9
	 za5Zej7ZxQRjQ+Jd4n1NKf6lkiL8wW4jxpD161KXviktJwBZ4twUTTpuD8B/pEgV84d1/
	 tqWdE6Yo5myx9FwtWZ3bW5wzRN628RtCL9Nz3iGUJzlAm6OwBM35/izvjuIF6juI9cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KEy3cE2hk9xojmlHWE13kqd99is+7EkDwJwCTfWgSu8=;
	b=k5e1SMiltjlqNZl0CsEDCxjUF5dA0wAJL5IyC/nztLpL0DkulX+fIb1LEpOqMkc+RfSz
	 vh9jnlnSJT1GVtiGlp/imeuPL5353r/I44yTCv+h8nd4A6L/5AgUIscUMe8KkOuTwaew5
	 GkWmG1suuwi33TNkgYpgrpXdglkglrj1ZG9QGSW5ct48nuLVOsDlgdlCN0It+aHqlvcwr
	 H5hn8GmDarnEGSqKoGsV6zGj/V59ulMRAvoQnYhFns3AJW7KDe2pwieIgX/Fz0Snfio5M
	 0apEBeZ8rpZS2VUfXDGN3L7VIMU5DrPCTW4PnxryjYhaNc481EambQKP/pSYGZZoKXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ccTh9Q0M;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07C606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 21:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F07C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ccTh9Q0M
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b59dfe466bso887461c88.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815490; x=1796420290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEy3cE2hk9xojmlHWE13kqd99is+7EkDwJwCTfWgSu8=;
        b=ccTh9Q0M6DgZ5/9qv2yOuSIvNqQDQ/sugySMh58+pY24xfMTdQKOyt+r0JfSUDuDaT
         DeCBynOhAAj9Ug9xy/RRNbXPFLQX7OsWbYVkW5jAtqDMyXHNSeJltwi+0XYxN59CoHhm
         //d1xWwt9c8X814D2zGC4VDkL3HsvJyrKH3S0m79hSodRye7dlsXqHrtQkyDzMdo96z0
         wCvoFNC/dogDVRxds7D2Vf6TmWxjYfI+tu88sQIO+kYMzXM+leOj1touj20LqniWHMxD
         ADGEi/K/N0mxtYjQ9g8pqDok/O2u68l/d3hm1KRcbvnRYHvs3ZGfvgN1mAAG2vP0Cdr8
         laWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815490; x=1796420290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KEy3cE2hk9xojmlHWE13kqd99is+7EkDwJwCTfWgSu8=;
        b=Dsae6wEhvgIlVX9BP0viZ7w8JFtLaJes50gTpa2M+lSWL9SZCsXtKegD1wVT87hEJq
         0miErBmkQmRcR1tY6BOk2rkyO5NCVfP0G/PIYz0BmfUgOl+OnLPzj6ua5vzmJBniZMGZ
         gYOY6afcSMsL52HtKLekKQWEjNv65VrsIjkYoOwAfo7Bk1t1EZSKJhO7r1hUFV73V9vy
         Crh1thi7kx9+Dn6YHR5tGNJXDyoYOe74+6R+tnn0oiMccw+uSa5g9/ESseK6/44cVsHC
         nll9ZHCg+mz+Hz7+eJAPq+M71dUuTZ0o2dX7ZmhZMBQ361NGWI2rsJV1UbyrlSTZc5C7
         ynMQ==
X-Forwarded-Encrypted: i=1; AL+hErEOljTo7khtd6DzouN+lyho9Hb/ER8v2hN96vRphZv6HAOXfz7H1ATIEkrNDEdNUke6WcK0j/o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Uis5rDBQmpQVAJ5slfD5iWzhYdCVzHZCEudyEu8JbbfZ6OUDV
	ovmeu2wZ6qCCTkvG24uN3JAN40aKvSKVTtOLOYcliEoZh10XGiNaIjzT
X-Gm-Gg: AZFdTZcPGEy/wcGPmh258zN8L9cpM7A20LpXheSHSOICGVIi8GczYB3mX9gzJihbiN6
	tFKMXFTIeuamvZXus75DeJQEl6L6fSp+8+LvgNaxWA2b03MqufbnoObQYAoaCWDniys0/O9XLas
	59xuq9LaLxJ/LiNu7JUdGngTxFE2XS6qcmvFj2fplLeeGd3M7cqaCy7GuvsFDVm7QcQuQrVk+eC
	xN7oZOpEJQYSSbr0Urj1swCO0HzLgvcj2QKyVnn12S8u6oyaOHzxEKNzcfWU+kTAV2EnCeXmcVw
	TYtG57SxUaDknPJnEJvWw7NFhrhlAj2sFG+CpioVTzhOvLvTN+bZtbRXAPFb9lmswrgskVcYWsE
	OEBNEWXLIYyooBk1quk1tx69Z4i/63FXE9gWROp5NF50d33F/InBnc57aDNIMk4g5+pWYsCTPff
	5MnGmmJwSeITbsCSyup6WmkGWPD3poNEkP2hLUeVCRT8G//hMQVvBz3scgIXBE/uLvwNwP6qdr7
	JgU+jtjiWjF89favFa8kHzqwGNCs/lChv6at4mggk1FCx+YTuQrnlMmdXgSCaF4qglmxebPNkJb
	7rCLUodEbQkb1hw9rSgH6gJIVU5HrsciwbY=
X-Received: by 2002:a05:7022:f509:b0:1b2:41af:c21c with SMTP id a92af1059eb24-1b55694689amr22796843c88.39.1795815490207;
        Fri, 27 Nov 2026 13:38:10 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm67825547c88.6.2026.11.27.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 13:38:09 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	Gang Yan <gang.yan@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v10 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Fri, 27 Nov 2026 21:37:56 +0000
Message-ID: <20261127213756.4154872-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127213756.4154872-1-w453y.me@gmail.com>
References: <20261127213756.4154872-1-w453y.me@gmail.com>
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

Do the same with the fullmesh flag: with a second subflow, then once no
subflow is left, and after a reset of the initial subflow. Without the
previous patch, no new subflow is created.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8c4eb17e5ed7..a9c106819b21 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4433,6 +4433,85 @@ endpoint_tests()
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
+		# no live subflow left to take the remote address from
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		wait_rm_addr $ns1 1
+		pm_nl_del_endpoint $ns2 2 10.0.2.2
+		sleep 0.5
+		chk_subflow_nr "after delete all" 0
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow,fullmesh
+		wait_mpj 3
+		chk_subflow_nr "after re-add id 0 alone" 1
+
+		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
+
+		chk_join_nr 3 3 3
+		chk_rm_nr 3 3
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
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

