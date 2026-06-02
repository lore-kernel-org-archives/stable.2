Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129E6284883
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429329; cv=none; b=MwjaaB9aP6BpnupZH3+Hf9+PAoTm42yaq9PPxmY/6PRfEpmyIqsJYrmuXDHIK4ba3XGg+oYE6wI2nR48LJew4i3BDnKJsQzKfZzXQSR9iKdVHEvG5d+1Ct9xMymNL7MtHUa8Lx7G2dX5C+unpTbDFdjYkjWJJKr2L/ad0uVtBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429329; c=relaxed/simple;
	bh=iHnw+zlUdLX2Bmv1zxrwHVdGjmne5/b3cN3v/XXOKgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpxcLl/kvQDBHANUaMSraOWLz6cPgFtQt5pPvMnxijNXVCGD1OL01ZfzbWpGYctWToVjzF0nEwS7FX9/xWUer5ywzLdVEye6yghKxQAK5+PUm0hGNe+336W+EwrSwb0QYoqZjLWZmlU9poGQbzCQ6iUM2JS7Z4NnfgqdW/Lo+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjnbFYoR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjnbFYoR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so6880024f8f.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429327; x=1781034127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3avFx0A9QgfhfceL6t9aFiIED/MQqU54kLZ5/p/Cs0=;
        b=EjnbFYoRRIKCdObfOJIbHvXrcVf21UiDKSKwhy6Zi8I9KMpZP2+YxIRyGpCNk6jQN6
         bBv3KTKArZr0ZeDSCN71pJur7zyqObbbXusWIyA3QeKTPhRj4yKRllrjhHzboeYAoNJh
         BTSOqxqItmqa51W3u296NJ9jhNRqLC3mM+jUUTtjbzjlrdOnM9aDiP68TLjYZ+ndcCGS
         jMY86nCGgpnVjDyo9OI40trSXd/3QQL12cMiwd3PI9JywT3sBtsEcrZ/FITXtzxZYpKU
         ZS2BIpZi4uyCFnEEllvk+/YHb10tC8UdVVVLcx5092uSf+B1GkNCJrxsiHgYuer+uiR+
         Ynbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429327; x=1781034127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3avFx0A9QgfhfceL6t9aFiIED/MQqU54kLZ5/p/Cs0=;
        b=nNVKUr0TLQI5PmtY0GSFZmS6YVvRJnnYAJOmnRigNQDfcSCSGHPj/q16kQ1PQjQLLy
         Q8KqLgGd3GXBO9XIpnDoUu+iHk1Chs+t+1LaAie1vqwKi9ZOD+cVoA+faO2e00DrieQ8
         pOkQ4NwwW9dZ0xISQ1USa0UujLdNpqPaibdDTyaHwHmCb7KpJDX42dr5Bc7YYOUp88Vb
         CyvoaFk/fS3Ncxq63rxm95qTcvwL/jO4MKlHhJ0c0EtSbEyCaTt0GxB0ThUfKHBzeAb+
         0YMWg3bDZTN0/m9Q4Gt7+3Tptw4NPhqk2HSO32B3FI6X/qcVicv1KhGAUQOAxf1RdEKl
         AMzQ==
X-Gm-Message-State: AOJu0Yxo/8JELkUR4bRrYBxmu7R0U3jMtC8MAvHmRQLEOWd0uUUazeQZ
	rRpzxfLn3gePhW5CUTsQ5Nclt4K60R/VTZDDE7jxZVUZfUxnPyJ/Xgx4v+ZgIgFi
X-Gm-Gg: Acq92OHj7rM7xwtoTdWZFF3HpMEkgiurZDi02a5rjVp2OZojW3l461vCWpPUXb9o/Ki
	F/2QM9gwthidfv6Ff9/ocXeYwy7lkKuVeGBdmg+yVMC5QLnvRrdKdAaS8GDL+8uXrQ8tC9AP7T0
	ufogQPzQXhw0OevQUyeZbZyw3JBrjLsNFuaLla0iRSzq2IZ94ZLMzuymbkLYwg5xMzsJj4sl0Df
	Zf4Xs45iteKOh5umnJTDQgLsEa+rYw2ubSdmsmsAAKExLknaQVgrQkdYS9jdhMkbCUV8MOtZfRE
	NqfVggGFRGKbpuTckLV1mDylV9Uic9Mqexa88vuySbvu4Hj8zyU7JoPa18eLpKlzLHp81UbD/j7
	9+Tp7ZV3sbmV5LTTOYv3BJohMCkYbi63PatXM/Be+BbAPTwkP4lr9iqupcFw+brcj5yPiMsdqjM
	DbHdwDADyRL16H1sJyf2ytQINC/kaTDrm/dE5PnE19gTk4tlw1Ug3AgRdw3nYTJwThuupXSgIsL
	cslmP22u8aouh3RQDzcgTGwR9EjH4razAeddDGPCrN8VlyMbfEH466WtyFDLBpaVArWL9bpqLJM
	88NcvJ4i2LBZ6Qol4Y65M05fIrhz4D5saJ380aK2WGp5eagDhrnn+g==
X-Received: by 2002:a05:600c:4fcc:b0:490:aeae:1eea with SMTP id 5b1f17b1804b1-490b5ea0f17mr3438085e9.7.1780429326584;
        Tue, 02 Jun 2026 12:42:06 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b616d6a9sm1714715e9.7.2026.06.02.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:42:05 -0700 (PDT)
Date: Tue, 2 Jun 2026 21:42:04 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y v2 11/11] selftests/bpf: S/iptables/iptables-legacy/ in
 the bpf_nf and xdp_synproxy test
Message-ID: <c4ce7431c23201ee36d4a652c22e8f74ddcc7c26.1780427227.git.paul.chaignon@gmail.com>
References: <cover.1780427227.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780427227.git.paul.chaignon@gmail.com>

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit de9c8d848d90cf2e53aced50b350827442ca5a4f ]

The recent vm image in CI has reported error in selftests that use
the iptables command.  Manu Bretelle has pointed out the difference
in the recent vm image that the iptables is sym-linked to the iptables-nft.
With this knowledge,  I can also reproduce the CI error by manually running
with the 'iptables-nft'.

This patch is to replace the iptables command with iptables-legacy
to unblock the CI tests.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: David Vernet <void@manifault.com>
Link: https://lore.kernel.org/bpf/20221012221235.3529719-1-martin.lau@linux.dev
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c       | 6 +++---
 tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index b2998896f9f7..b30ff6b3b81a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -49,14 +49,14 @@ static int connect_to_server(int srv_fd)
 
 static void test_bpf_nf_ct(int mode)
 {
-	const char *iptables = "iptables -t raw %s PREROUTING -j CONNMARK --set-mark 42/0";
+	const char *iptables = "iptables-legacy -t raw %s PREROUTING -j CONNMARK --set-mark 42/0";
 	int srv_fd = -1, client_fd = -1, srv_client_fd = -1;
 	struct sockaddr_in peer_addr = {};
 	struct test_bpf_nf *skel;
 	int prog_fd, err;
 	socklen_t len;
 	u16 srv_port;
-	char cmd[64];
+	char cmd[128];
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in = &pkt_v4,
 		.data_size_in = sizeof(pkt_v4),
@@ -69,7 +69,7 @@ static void test_bpf_nf_ct(int mode)
 
 	/* Enable connection tracking */
 	snprintf(cmd, sizeof(cmd), iptables, "-A");
-	if (!ASSERT_OK(system(cmd), "iptables"))
+	if (!ASSERT_OK(system(cmd), cmd))
 		goto end;
 
 	srv_port = (mode == TEST_XDP) ? 5005 : 5006;
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
index 879f5da2f21e..13daa3746064 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_synproxy.c
@@ -94,12 +94,12 @@ static void test_synproxy(bool xdp)
 	SYS("sysctl -w net.ipv4.tcp_syncookies=2");
 	SYS("sysctl -w net.ipv4.tcp_timestamps=1");
 	SYS("sysctl -w net.netfilter.nf_conntrack_tcp_loose=0");
-	SYS("iptables -t raw -I PREROUTING \
+	SYS("iptables-legacy -t raw -I PREROUTING \
 	    -i tmp1 -p tcp -m tcp --syn --dport 8080 -j CT --notrack");
-	SYS("iptables -t filter -A INPUT \
+	SYS("iptables-legacy -t filter -A INPUT \
 	    -i tmp1 -p tcp -m tcp --dport 8080 -m state --state INVALID,UNTRACKED \
 	    -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460");
-	SYS("iptables -t filter -A INPUT \
+	SYS("iptables-legacy -t filter -A INPUT \
 	    -i tmp1 -m state --state INVALID -j DROP");
 
 	ctrl_file = SYS_OUT("./xdp_synproxy --iface tmp1 --ports 8080 \
-- 
2.43.0

