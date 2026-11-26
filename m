Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688311;
	b=xjjfmZ6VWKHztyQz62nx8DiOCCp9GTALixR1pagLFqZUkr0/NrWAR5fHZD1YRaMtTa1Z
	 PwvL3vFfqmp+jk6gvEE6JgHv49c0buoE7vKmU/xREXUTK9dDMhT8fpYTkwjBLRmIRDlPf
	 LJnLVEpAkJ7oPBeK3pgt1tzUE03T9vb1AZcySZQ6/iWQO6Fi6MEo77ZHBBF4kVcI6wa/2
	 nmdlfu6lVo3VkQYKMK8+73DDarI3x0Gafcz0nV1APU624oW7cXeslOndZA3Hrm/xzWQQH
	 oYn0R1c+IouiVP6COYgIxmEitKi91gHs880xcPNzD84DbGcnOrSOh2kNwEUDSaHFwuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ugE/krQOnUdasnCh/aZgODTXRFrG9aKhHyU/6uxiQCo=;
	b=hoXCwVSea7Zck78FnwUzDZUrWpl2at9347xKbLrLrIdGC042X5aTXcb+ytDr5aONj7h2
	 y18qhR2Y4JbA+cLSSpH2iC0Te9Hwmtj8+VO5IBAwaGBuD4A6sHcVTqTwa4OOxaJJsgioZ
	 VNMbWzYiZSoj5A+dMnTnWdYoSQ7JfkxyDrWjPvC6bhx22pi/5IVBdS/SJBqSq+0io2tmM
	 eiHvd4KCmm07CF4sma0Ljwbud2OB05UrrvkyAIyFNc5UrzGW5CiqBsIy9RVSgsge6+lfB
	 9g+/nNLlsGu+JVqxs7o2kN399nj8htVxEsKigEMbfyFVGI7hlNXacu79Ppi9SJWv5Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zxNnE4fT;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3B606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 10:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FB3B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zxNnE4fT
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso9183629c88.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688310; x=1796293110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugE/krQOnUdasnCh/aZgODTXRFrG9aKhHyU/6uxiQCo=;
        b=zxNnE4fTKqqU71N+q/Y63sp+bEnhQY9Gv31orAk84pnYGYhLMiJkr+a64ZKOvsIJYn
         reVGoYqiN0ZBjbaMAroXg/FChSxjzw/s2IKqUm8j0mCBIg39sHYyJ7rsPYswM01oupmL
         vsu/QzqJ5k+GPhp4p8B2zDcmkC0N7aZq+6VZFkaayzClg5zg6AzEADOwqImJ/HdUCrCH
         3RnyuAhYeAwAOg810DllqPeDlC3ObwO/u09wUj1dCv0E5TlCqQCHidUwUuNFQzN+1shc
         oCnxmq7b6c6cy9Q1T4wsac4eRWXVBLLuJtK+g5VDubq3Oha12K9bYO0/L6B39aJi2Swm
         5orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688310; x=1796293110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ugE/krQOnUdasnCh/aZgODTXRFrG9aKhHyU/6uxiQCo=;
        b=DDyzCxQvcjxVP7BlvbwMwRCnCRdZo5QcYxAUV5JD3dio9G1IspRjhb6dqdGHNe+4Qf
         88kpTX+EEfybyast4oj21f/oQcBp8FXYj6cJCTb6rM0XO+nr0raOYVZ/lERIaEXIzKvd
         d4JnTNvSXtJneDQ6/8pxVaK2a3iZuPZJ6TdY64lSGloOl5gSZV1PlWaN37ktdQvsv39B
         vPlYetES5He1C6S4Xp9z16CLf4nKgvfWYTkGS4Ml+W5+WimSCoLdjzvjt2PmPY4IHoMY
         DDKMHDQQ5CZ7S06aHWdFdfW+cycxFPoxh1SRcgqDuAZK1cywukiBLwg+07JfPG/S9b8s
         p2sw==
X-Forwarded-Encrypted: i=1; AL+hErH6NBHdkA+35FidFEBCjPMfTOuWcDeU+bFC3f0J9KFHJL178Ii7zYCncVxoFF2UzLZIBh9bG08=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KEz7D/oG0Fhk23xonxmj6Hb3TSepMofsqIEuViZ0m7Rd48qpL
	m3DYuXQbojU8XRg4wmuYzNKpTNWTgf1sALt/sBBqWkSHyBXjJK9SIlPn9TMklQ==
X-Gm-Gg: AZFdTZcvz67+eZQls0RE5kAu4rZ+1GlQblCqbOEwehGt3Q1x4e3ITJazslLlUuAd+qd
	viVNy/GesTHnRgF05cVPzptrcgf2Nt1bYZRB4/nI35GSU0ngWdnRv8lYR/qCerNJxNGVhk/k+fq
	4JWq0KTQ86qj96cy/BFNBtZYprmgd3mVYbwDIE1H3VS45AmWc08L98uW1myLnUMKsSbSMRbkrJS
	axwqn0p4vhwN9J+e0AkdiAEqzU1fNqYXLfIn3RGJ87hfm58dfskNUkvadbEiOmvS/49izeKP3jQ
	vMa/kFw0nv2VMEweSZKzUAtlzIYBIVzixJ1JiYv0D3vCP7ibtKjGm6cLTFjsXto7LwXTDTNTbL2
	idGpaV3wF7Zr0AbeT/mObG0ybRAH1/MVYpj2mzxfQyvS6qeu3YPWEmAl6hIf4/EOHlbKJyj9HVS
	pGXwVBR3qa4dhwY3WNGDxUdZD6SKXdkDkiQsfp3Ksp/H4TCRdOQ+9dIbiyJREwKjw5OE9QCH6WS
	Wv2xwWXIANkMbiMuaAdxsviZfF4/OILCfnyTi2otK445MOb7RNEd1eAc9orXo+tydsJlvfZ2485
	tFrkiMhn12Ghz8HBPYg0CFf2MuyoXpj/c3o=
X-Received: by 2002:a05:7301:6181:10b0:386:b2ac:1f17 with SMTP id 5a478bee46e88-386b2ac2832mr12047770eec.7.1795688310218;
        Thu, 26 Nov 2026 02:18:30 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm74221227eec.10.2026.11.26.02.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:18:29 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v9 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Thu, 26 Nov 2026 10:18:18 +0000
Message-ID: <20261126101818.3916631-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126101818.3916631-1-w453y.me@gmail.com>
References: <20261126101818.3916631-1-w453y.me@gmail.com>
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
index f4d8afaeda4f..05572c97ff48 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4424,6 +4424,85 @@ endpoint_tests()
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

