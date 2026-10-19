Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436771;
	b=RP380xeq+xmx3iPeZ/h+P05hrfxBef1UCf92HU/HpG8rON+X63L9SW9HH+IBPOMLF17n
	 ji0YJYQG3ejXS4iRusK5AY8LMYt+ELfDDLP+EahuMr1yjzjw/VmWIGjkv9g3PINkpeFjt
	 26G6/TUbW61os/AYqUsmuDemBtTNMU0474mPQ/rRFdBGWzXOx7GpeAH4FqcvnlGHDxvwu
	 Pp5+qtE4zceAjx8K8QXvjxFcgAC1/oBp3Rf/5+/R95r35yGTA6QJtCglByCxmIr9DnT+k
	 cAw5Whj4t4GpouAB1dp7+LC+O2U7mPOM3vfBteMLSoxvbIs7eDVnD7tAFC5rS7JaLQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=87YrPJQRW0ht/hlLWXKgy3RMFVyUxz+R3l3bADmTWwo=;
	b=Hmwf1b+UK8zpJg2aWriRPhAcNpuxLy+X7ChRBCv3ZOYmzPkTdJb+z3zk3xrFzEdMuIg+
	 M4bJXIdqNWtOzZnlEVYO3H/x1GGbOyx/hmPKMiRz+rVgMmX7u1Y2W+dlb7PiiAUdAfuT6
	 OH1BnczIyR4yiZz8KHzwm+jYk53rwsGImkP3oPDFbZQrRa/NxTPy8LqkJEmAxcVQwlzny
	 WwTCPiIbbhDaQcS0wbSen/N4GiKwwFP5qC070fM7s0GWgaqdu5/vvzOWAfBqis2cHkrGC
	 drKa367nXqBKDw1uRegkqa0zeTZxeC73xjK3G5dAbeZNSmWnjrQuH4nR7rqjEptHwrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ahyrG6fF;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2948606A322
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 19:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2948606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ahyrG6fF
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35f036b17easo821685eec.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436770; x=1793041570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87YrPJQRW0ht/hlLWXKgy3RMFVyUxz+R3l3bADmTWwo=;
        b=ahyrG6fFX2JHX8PKVpei4gTnmtBsliE212qIwSbwr3LVROCsGh2RG/RxElzFyvcaaj
         6HJyoCXQQy4Z5z1KS7nZOi7fzGUD+9zwz74PzgR9QmoFcTnCZrNS+5ix69iKopBRPQ7p
         C/CNLaIw2+DI//aZ9LA5U6KraMIwQ7C/5hoX01dxMwP8IFL9JIhJnwvIfZCZiFzK7M5Q
         CTwqtmFYAHilMxiHXbCrLHZNQEoTVpN8I/3kBMlOHCBO5Wyjr/+brvbrX5Iw/NAFw1F3
         OATCVyMGEHZ5qmMRhhvherH6dWT7mGMZv4AYli4v1IUfu0XKh056/Mg6wtXNOADz54P4
         a6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436770; x=1793041570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=87YrPJQRW0ht/hlLWXKgy3RMFVyUxz+R3l3bADmTWwo=;
        b=DkDt9RtTNCt9gzD6DA/ijQ6XqU9QAB47FrFx5+S6bwnsUrAJxQMUBIRHOI2AWqknzO
         U55JvfA974fxosapTiE/eZbd4AVCkiI8rGYoqubLrAMyKCTQQRK1Fww6gucKuYgcv8gO
         rDq0Pc84bPx/chQ9WP1d43WHR/rXGcJkZ33x5aGCdGAtTY+gN7N1FpMxfEXC9Xz7s7SS
         hl8yfvcXdSQSeWEoBO6aH2JPLc2ieWW0ccNGfpIMgJRi/w7V1TpIDvlpiXU18Fa8HQSn
         l3r6scgFdAZo5zeccyP4H8hQRK3JAc3zeM++Enk+HuYJ35eGTsYqV51o5CItI8THTDr/
         i6zQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtSJuk46PWOeYTWDAzl7SxxlQe2Xjd0hdL0wupoC6Rxy1HETuNgJVcISK6xLmMHl+KwC6rl7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0NfRyoeppr8uUGfS8eqSkumhz7cpGIzAl5PNcfYM4rdv1LC+3
	RidfVTe5BJBjjQPTI6z9P+U7SQ4Je3ePPzkWy7MtvEe+64K7eOks1nUm
X-Gm-Gg: AYBFou2ffw0+cw0yC/hrbRtiDiMSEKkNJN+UQ6C/Ppv8auRX7cH3ziLWv5BvgrMPjAs
	rExPfWwFWvWuGxEazncy/ZAqEubya+dGApPFRY1dnBiZlWRQQ7Fw95ezalFJnSLC/hjxmBjo9FS
	5Q79gFLwfAsGmohVMYgWRsa/UzgwKuSUiOUstRivfKgdsGzL8ZiHc7Y0kbNLf0dMHs+0U1BdeO4
	5iugEzrewAMjNvM0c5cGbNkreTVer7g+ZToQym4xowEi/sGfTbiTujUnGET3N51kwdo/9PxKtT3
	tXszgqmNI2AoyvQ9G7KBi8AcqSvMO5hpCaZES9JZpUgtpWFCnQGs6IuJTgsuWphuUQuyas8FXju
	55vcSbixn1gdTDnHxeTIKpaZT4TJNW93+R6JX1GpR5SYovmIY9NfLleeGr2ssNQzidL8m8mmrvN
	4BoFancj7OW0CknCarX/9vqN2TDIEJeECUaJHHPyVJ5CjqwVUVpmm2IBOABRAFRHfnGta2FkMjn
	sAGkiQ=
X-Received: by 2002:a05:7301:fd81:b0:35d:bd18:58a8 with SMTP id 5a478bee46e88-361a2b34f83mr11220056eec.37.1792436769914;
        Mon, 19 Oct 2026 12:06:09 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm62848024eec.24.2026.10.19.12.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:06:09 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v4 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Mon, 19 Oct 2026 19:05:58 +0000
Message-ID: <20261019190558.465270-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019190558.465270-1-w453y.me@gmail.com>
References: <20261019190558.465270-1-w453y.me@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a..25fedf5b1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4445,6 +4445,67 @@ endpoint_tests()
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
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-- 
2.43.0

