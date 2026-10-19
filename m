Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433000;
	b=cHkI/Jl3EYZZX/y1xLptq+RGj1RK53EJd8Wu5DROjFPW95cJA6ufL4dlFa7Mg4sfi1v/
	 p6IEEEQqWriKF7aS0qsErI17RQ94i68XMenxpoXpe9GgEIWZDzARpAh08m7q9APVr87vs
	 1i5UXCmLa/Di5H6fXEkhfZ0H3IbeGQ5t+ZYsZoz0sni4AXjgSYWpn5qsmPQx0m2Z3XsC2
	 oKCF0g+nw7kTMS1B7/dmgJpE9SaUV70Y3THov6x7eycAPz5quCapzlbrs8GdAorPMv7zo
	 XeG4eXNcJVCUFHE36UPbGG7fSd1VePfa5TBqXi3z+LcW/22oS5rpiVfkEpyjHcwyV6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bGnOWkZ2yc/krwRLusPwIg3ZeTe70ZXarhoGMMBy+X8=;
	b=d0s9ZKxwA5QBsudakZ/JXslwUYjX3tcRoMvHQELD9KdVRk3HUMj95l8Zhn9321//t9NP
	 uvzKPka0Nvl+7YBVXNRjSPQhN/PKwgxcmZ6dV9ZdvGXYgtGUTvYqDpcObYXjpFPdwd66v
	 683zUfwRceF7NVc+39ZstHaHcP+Otjaw9OLL7Gr6cTI1XRCCscCDpLbRPfRswZqamfS6X
	 BV/Pw/i7dH6Rfhn+fjpaZ3Qlbzfis4MLl76ZBnkjwP4E+HAJG7EQB8XySOWrQTmyUKfbN
	 n3Pu/9Tg8UKdaXb3V6NthzOB3DecCnIB+DJ9ilz1Nr209TEEL8mVbzGwbBlMK/m7ymA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbrzhpZR;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B6606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 18:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E27B6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TbrzhpZR
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15354aa70e8so1999171c88.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 11:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792432998; x=1793037798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGnOWkZ2yc/krwRLusPwIg3ZeTe70ZXarhoGMMBy+X8=;
        b=TbrzhpZRt4Ca5b244FQq700b52odXp7Xb2DPir4/mErI6KJt5tgVoPU5MGMkD632Th
         zcN0Fd1Iv+DjeQdLxmoOvtA+sVQMtm6Tc3jrK2+F4PDUdNxDd2h7lq99r74psYfBFjtR
         irZvIDThYXx03k9RVs8Exv5PGyYG2uYpawBSK1VTGnHyzpb8VCYFlPpWt3GYXZBuOBBo
         GTMW16H/Xp2N25ynPfAXFeKRDOaxOv+8sv6NlC03FofQubY7S2vA6uA+sd0I7UuEtdmZ
         rnb18cBxTWDz5nVkUyPNays1nQam/VJIxKT/SNHT/Fzr8DLTcez9/I/jKM96vxujFmXF
         UY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792432998; x=1793037798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGnOWkZ2yc/krwRLusPwIg3ZeTe70ZXarhoGMMBy+X8=;
        b=ydBIE8Awbv0zTHuhOwhZzMa6ge7hcVD/o9Ud4RAbAWdtSnjtH77V75GHl6RSyN5dpN
         qWoJeAKkuhOrYbX1DycDu78Brk0Cd2ROFgLRj8z5Su0hsRO/CdKAH/yGzOqzw/N9LtbP
         S5Dwhk+ILtLFzI3WDGggn1brJXc8Du4XGrXY14oxj2rmHIEQ8pN9rUxDYY2OshrsSkav
         RO/23sEkdMrXRT9n75eBEXqPc6QfAspg3AxmR3daQT0ZGdgcOhR8kIFyT9b7JD1BZagU
         +nCs/82+fbTa33kaJp8lPBWF7bYHPQhTtGk2vnk/fKJQT4N5BEVHV52UC49BWL/OQ5bO
         7xeA==
X-Forwarded-Encrypted: i=1; AKwUvByFlFxLnkmgBTXOik60T2mGDgwYRMzA+Ya5ZiuCdubp9ZfUq1Z7dUaYfiSbcpSwM6Y9TsBcpP8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLH1qNtjXV/HkbquKbUWBIuTrzb4I0Z6+0s24Bptcl9ihvG4v1O
	4D6XeROrxoPeSgnDthBdsCz9/xTch1+BVcuYk/9i7/DbJewAu4FZJkWy
X-Gm-Gg: AYBFou1hZ4IPTA/zn1MPxYkJa7kgIDBHqEFt4r1q3m5hcwkMktCGnAGSREECFMxn1bj
	aAvVX3Rg33VHI1NGzxnLGbrH1BFSW8UzLt+Dgm6qk7B/i20JrkjND2hZC44iyRBQHfepsP0BkhL
	MP/j6CXDicRaNSh0LJ03/y8Jwcj0o2l99SQ01TUyR8UEBihb5BvqQS/m6QHF7qUI5vHae8uLGL1
	/vqIdZDniN7vWXSPl2eY9myeU854BtSeEVNhUiBKDyy/kbxPI1HcRl1fyY7tlqs1tF/XTVVCpBp
	K0f6gqCjlIMzEhfblisFenJR/jsKbyVoweHCPZ7RBiDSLOoAPNRuBletkKI1UOeNiE2xVqa2dtA
	lwSxQkrhBxkCvOntZ+KumB5E+pBqGvW+P2PV2/i8opeRQx1QtRx3PxvleNBB5lBbX1J/dtusuYC
	xpzE46bUvcbpXkbG5ywIp+vxmSROXm42PrMF31Ka53m5r69H7AKt8KSDnEES3CS3Szkbo0ej1Qt
	Yt1pso=
X-Received: by 2002:a05:701b:204f:20b0:14d:baf5:c40f with SMTP id a92af1059eb24-1851238b013mr13488897c88.14.1792432997792;
        Mon, 19 Oct 2026 11:03:17 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18319d3b880sm28400604c88.10.2026.10.19.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:03:17 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: re-add the initial subflow endp with fullmesh
Date: Mon, 19 Oct 2026 18:03:05 +0000
Message-ID: <20261019180306.382039-3-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019180306.382039-1-w453y.me@gmail.com>
References: <20261019180306.382039-1-w453y.me@gmail.com>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaed..884d635bc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4424,6 +4424,70 @@ endpoint_tests()
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
+		init_nftables
+		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
+				ip saddr "10.0.1.2" meta l4proto tcp \
+				reject with tcp reset; then
+			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
+			ip netns exec "${ns1}" nft flush chain ip filter INPUT
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

