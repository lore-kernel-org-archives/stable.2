Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E0336A02E
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392676; cv=none; b=DeWyYPNjbaFkyoWYFooBpBBqnrjyYQLD38KvIXW1svAAKuY+86nyNN62tHCaDReV/VZuPgzKDS31vs4jBpcnp+CwG1ZSbi6HKdlZTxxPdVAwDhFe7xx2zb1Uk27+s/aSH3MrBvVgXQSLwf1dWu//uhYlQgsWmupr4ZrsgZezink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392676; c=relaxed/simple;
	bh=iHnw+zlUdLX2Bmv1zxrwHVdGjmne5/b3cN3v/XXOKgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOw059hNtwMEqGNu2E+G42YgM6uIqHdpVpkB0KrS5pPCOzOWazA4dQL37u+qwIRUUbACXHf8zztCLWFOCBIwSeoi6VvqOs0fK2XW6DkOLDQ2yAVnF96RtATVamKafoHq4XL6lpJQn8jo69Rjb6m1W7ugxvSdDN8vtG/8BXae2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owGKsDd2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owGKsDd2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so113351475e9.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392669; x=1780997469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3avFx0A9QgfhfceL6t9aFiIED/MQqU54kLZ5/p/Cs0=;
        b=owGKsDd2NCjKfNrM2Uu/I/eI2RCweV3SOO9e2KtrE56Sx7gVcek6ECpmTdYFh2oQFZ
         OIQ+q0LCMEhncTzbCrQNdU3sYi8FaSd3cdlvmi3lRViVaAoILDpl3VXrm3GY16SZJAb3
         pKAHRi4zY3dX3b1vhWiUr2EQszMgelp8/xV5v5rdWDlY+f31m3unSbeVxKWlMUI+jHYq
         X/f9jVazHOjDQuSB0Bawng39IZ06v/Lb0jWfJxL+rhQyvsbaWZNs8oZn13ub8wPJsDe6
         A8b6T9eHi4SwCEaJH1+93XPzJdVkoGWmA5jMQiYy3dOnEReWbqRm2pTG39ldDkxo3SDk
         noiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392669; x=1780997469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3avFx0A9QgfhfceL6t9aFiIED/MQqU54kLZ5/p/Cs0=;
        b=gwkz3fP7x0XqWGfIgfoXhM/ucuCSig8u6HE8kWgjEFU038zxjOL77QCF8lnbrIbRH8
         Zy0RLZ+EJOZuOLgcsPxt2l/CSvCSjpSX6PkwXWCfL04zHI5i5JcO45nJWpOAITJ2RN3X
         ldj/x3uf6+54Sn8I4LCsVbDM/kar7OHokgv5BHF+KKI6KyyLKx+ks2AZXPMK4LL2udNV
         NbAszNWmSQ8stK6KMpEx8Mx97iLeQtIOwQ93Fr0HQcVCkEEd24vTJG7I9/xug8MnwrMx
         Hlzaanu/1jejY8m1teEjHbPUVbU56skxoJcEs6cnzI1aMltYP9Cke+vtgchPSbZngmf0
         6hyg==
X-Gm-Message-State: AOJu0YzEM89QlaBUOzArXXjRc4IBKUlNoUJQsn2rfLE43hnkapUn4Fd3
	N2fRftnZnCzmNitXeBzAZO8lCV6mYETy/QGk9/vn/y3GKZM61MLPNPmorJ1IAT7r
X-Gm-Gg: Acq92OHsEIDffHnI3aWM65/EBaKHGXvbgI2cbdfIMO5DGKb/zmhu+sFULkx2xiV7ClF
	nsuSl2Kte1SwsUQ2jZWKplGexAt14axaMTQg5KpPjXztTUZzwrMuJuIaxW+SEnv31o8pdLkTb2I
	wLWb2b8/dKrC6h2bV0SbgzeZyvL0UmYEWR5W1cVXeQ1kK3NY7Z8oNageWvSS9WndLx5Zg91DWBj
	T/h8KHaQjV1beZeARJ+UHYzqrJkne9dFChvoPxIxR2yGfun1iZ1VeX0sxoTah7P3ZwhGxVC3zAU
	eO2nWM1h6IqUwKtENrKQUO1KM0VoR/dJ+XuIJOzcQAJ855JZ4unkdlEwqK/CPvYPk0xWvbd7+1B
	wkzxUVPKCRWnaKBrCNQfb+G2E5IZKlO/lxzu9/Xmyeu7X5O5f6+UX1F40WQe9OHm/rqbfReEsJN
	0RQVTI8nWP9e3linKwl6iWgO4PDysBqd3t34I85SRJs3Sz4W30cfRAs0IRSYzhNNWy1gF/U6E7g
	BlKYp7EMYQEqiePdMjm0jZjcCeheeU6d2eW2g0yYXTx7ohfR5H8mHDhbdBb665UItE1Wss4hSyE
	2fAdBQzC/zJx7S6eN6S4P6OnF2Dw8FlL4etNF9Axm4Hf2OQcgdFBDw==
X-Received: by 2002:a05:600c:8b31:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-490a91c3b40mr178484695e9.5.1780392668681;
        Tue, 02 Jun 2026 02:31:08 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00d5a27cd7dcd113c6.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:d5a2:7cd7:dcd1:13c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e239f4sm83355985e9.7.2026.06.02.02.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:31:08 -0700 (PDT)
Date: Tue, 2 Jun 2026 11:31:06 +0200
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
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 6.1.y 11/11] selftests/bpf: S/iptables/iptables-legacy/ in
 the bpf_nf and xdp_synproxy test
Message-ID: <de99d5b77561a13240766c0c37141854fa60eaf0.1780392093.git.paul.chaignon@gmail.com>
References: <cover.1780392092.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1780392092.git.paul.chaignon@gmail.com>

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

