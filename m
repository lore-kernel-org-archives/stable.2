Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B83803D6
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488556; cv=none; b=OjGBb+2wpwaSmGeMg/ucXHLgFQfaTU/rPxh6+Ov3P0yMivV4ZEljH8ufCHsscahhs6UwlzaN9mcIIyJ6eSFGV32X0RLImtGrhuw6M88n7PXTF4qAWC7VhHPhRmcHWhSxPCMeVnWu+u5gWtDEg/8eaDkl8cQ3jNFBMezv+/tx2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488556; c=relaxed/simple;
	bh=2WmkWOQUFedXlAeRWs1rCF6F6EEDQs0fH4tiKIsLUIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4Q93s1ruc2Q7Cdz3uLK9eN5a+BwrSJsNzmOZzckImAfYVHz9WOpUFySe0Z8sdCAd/NrP61R0Diyar/P0htldy/dv+UGVF327kaktJGutrYqIp2i4cy222+raacpfeiEChRM1hU2hESBnLwBroQWbz31lcn7bqBJa0Ek4gOtl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJIOG83L; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJIOG83L"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15df0c154dso5607066b.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785488552; x=1786093352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0UMcq6cX22VzKYCYw8MtlB1VO1OK1eK2jVGQy/sBkLM=;
        b=WJIOG83LzDVDx/FobzqTDDTkzBk65Mky9KryDU39TuCT6hM6ENg/dIor5uvxDNkwgt
         MudusRxXIaxAnqkB9HuPjf19B1Y7NfmEC5XIWGyuTG5w9BGe0722ZfTdFHXsPr3queLY
         WwybDusesw0DQJyILd25+t2RqYMD9foRJ5Xzo4fhU2rFNtwzWgDAuHevasc8jO69CfpG
         Ec+SuVZMK51NXVyQQxPCSKG4AgU4MY3kwK0Fm4WHeSxh6EHuF0YgpcPkd3PVDv7duop6
         CgZFQ/5DAo0fQRIyja9T8G7udDb1xhuyUMldie6zlZVVClmJGCWq96bq2H0xR/DBANCx
         O//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785488552; x=1786093352;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0UMcq6cX22VzKYCYw8MtlB1VO1OK1eK2jVGQy/sBkLM=;
        b=dS7QvVmtqBmTZlCEOP95DZT1E5e6MagISWKYPwJVf0Gkl68RyxEXt2Dm53R/iiFvTg
         ddOYLSSWCEpi+VSZxVm6KuKNTsutzDxaI0thuo8X7I/Og6E6nxnThaqgkUw4h56RUmXq
         4DydijMkwPVPa8fiyAZBXC8T/9dHTM8TyF7Mrme/Cq1ZGSpU4JApWv9Bo0V5r65yhW2o
         RyFGRro2HjZhfsWneftBZmPh3iZGZi9G5PA1tl1cz7/4IiVuRRBmQV32A38aPRBN8Moo
         BB8qvvoayIAl9y834Wvsz/IIj95PthlhXpbHt7wKOvHO6u5NE+LmZq5sv8tveZEY8zGJ
         LhiA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6rBpAQbRVWGwRbB2ivXgz6zHeecRN+eqCKsu6FkiBfmv64l/t2DBKiDCJ3lV635E2d8yLOlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgDijMeDTerqAM1JoY2/miRRW7ZyyJpI2Yb7DUldQYeGQjvJiD
	SV6h1QgKwpfrGSzQkvjstGPiEtCid+2CNWKGVdWpJncw+/QHYUNDeIph
X-Gm-Gg: AR+sD10Iw3VYUC352lgvZV/VaOZTVXxsD2phNfbwudsKRijlmy3uJn4ZjzhkPXQnRBV
	f1SEHcpSIKLvYprKFoaD+bVzE2SpI85KNpmyuqh+XHlJkgliWGt8IQRHWG23hgbxTN4WK8z++4P
	KpKtErLH9WwmsmfMrxEOLiOflETNBYXh17X6Xgw147nisD66BhgYthXCbUvu49McbqFO27Qcuzq
	FDnNC4XMGc2JajH9c15gIH5aqJgCyxAIEuVYFlJ9IRh7z6gmY9Y5/dbifBuURZOBK0O78vkmFTw
	IYgylD7WL28RxeKLOBv1F2356ibvghNtHe3WQXl7JRA9lONWCpzVEO35MPAczE1cHT0ztVKcaWq
	42HUqH8VWubkv84s3UD4BWbW32z7+a90kopbFiREOu6yK4Xckbm79LU9xxWz+8WnlTYod82pNA6
	txYPXZbqDm1yclVRj1PV9eKRWdDKyWL8J7mk9TG38jbp54u0VyNKvbZbpj1CmdxB5S+ojZ5kKHE
	qXnqbNiKZyJ1yiM3VbtOhv83twgU/2g89cWM9GguLzqxxtF26acKz1BMb6oWuUiUInlZGUX5PtR
	lzoey3UHmE9HlYcEJ8RAYg==
X-Received: by 2002:a17:907:ea8c:b0:c12:6db4:4bf4 with SMTP id a640c23a62f3a-c1fd1cecb3fmr87595766b.0.1785488551469;
        Fri, 31 Jul 2026 02:02:31 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-184-219-058.77.184.pool.telefonica.de. [77.184.219.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1a58sm2965051f8f.7.2026.07.31.02.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:02:30 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	kees@kernel.org,
	petr.wozniak@gmail.com,
	qingfang.deng@linux.dev,
	fmaurer@redhat.com,
	luka.gejak@linux.dev,
	bigeasy@linutronix.de,
	xiaoliang.yang_1@nxp.com,
	skhawaja@google.com,
	stable@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net v3 4/4] selftests: net: hsr: add GRO super-packet forwarding test
Date: Fri, 31 Jul 2026 11:02:23 +0200
Message-ID: <20260731090224.18-5-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731090224.18-1-xiexinet@gmail.com>
References: <20260731090224.18-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a test exercising the HSR forward path with GSO super-packets:
a TSO-enabled SAN behind the interlink streams TCP through an HSR
DUT to a peer node. The test verifies that:

* enslaved devices have GRO and HW-GRO disabled automatically,
* the HSR master does not advertise GSO/TSO features (including
  tx-tcp6/udp/gso-list, to catch future hw_features leaks),
* super-packets really leave the SAN (TX average frame size above a
  fixed threshold) while bulk output on the DUT's LAN legs stays at
  per-frame size — aggregate counter evidence that GSO enters the
  forward path and is unfolded at the forward entry. Zero TCP
  retransmits is reported as a secondary health signal.

The one-shot iperf3 server lives in a private mktemp -d workdir
(mode 0700): its exact PID is retained only after numeric, alive,
comm==iperf3 and netns-membership checks, its real exit status is
propagated through an rc file, and cleanup kills by exact PID with a
bounded wrapper reap plus a namespace-scoped iperf3 sweep. Server
startup failure, client failure and a never-published PID are all
bounded exits with no process or directory leaks. Environments whose
iproute2 lacks the HSR interlink syntax are skipped with ksft_skip.

Without this series the feature checks fail, and on drivers that hand
GRO super-packets to the HSR receive path the stream degrades or
stalls.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 tools/testing/selftests/net/hsr/Makefile      |   1 +
 .../selftests/net/hsr/hsr_gro_superpacket.sh  | 462 ++++++++++++++++++
 2 files changed, 463 insertions(+)
 create mode 100755 tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh

diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
index 31fb9326cf53..0d105476e7c5 100644
--- a/tools/testing/selftests/net/hsr/Makefile
+++ b/tools/testing/selftests/net/hsr/Makefile
@@ -3,6 +3,7 @@
 top_srcdir = ../../../../..
 
 TEST_PROGS := \
+	hsr_gro_superpacket.sh \
 	hsr_ping.sh \
 	hsr_redbox.sh \
 	link_faults.sh \
diff --git a/tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh
new file mode 100755
index 000000000000..288de3a60b89
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/hsr_gro_superpacket.sh
@@ -0,0 +1,462 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test HSR handling of GRO/GSO super-packets:
+#
+#  1. Enslaving a device to an HSR master disables GRO on it
+#     (dev_disable_gro()).
+#  2. The HSR master does not advertise GSO/TSO features.
+#  3. A TCP stream from a TSO-enabled SAN (which therefore emits GSO
+#     super-packets) is unfolded at the HSR forward entry. Evidence:
+#     interface-counter deltas show super-packet-sized frames leaving
+#     the SAN and per-frame-sized traffic leaving the DUT's LAN ports.
+#
+# Topology (100.64.0.0/24):
+#
+#   ns_san                    ns_dut                      ns_peer
+#  +-----------+  interlink  +---------------+  LAN A/B  +-----------+
+#  | s0 [0.1]  |-------------| d_il   hsr0   |-----------| hsr1 [0.3]|
+#  +-----------+             | d_a / d_b     |           | p_a / p_b |
+#                            +---------------+           +-----------+
+#
+# SAN traffic reaches ns_peer only through hsr0's forward path
+# (interlink RX -> LAN A/B TX), so every SAN frame is tagged and
+# forwarded by the DUT.
+
+source ./hsr_common.sh
+
+san_ip="100.64.0.1"
+peer_ip="100.64.0.3"
+
+# Aggregate counter thresholds for the stream test (bytes/packets):
+# SAN_AVG_MIN proves GSO super-packets left the SAN; LAN_AVG_MAX is a
+# guard with margin, not the protocol maximum (see do_tso_stream_test).
+SAN_AVG_MIN=2048
+LAN_AVG_MAX=1514
+
+iperf_pid=""
+server_wrapper=""
+workdir=""
+pidfile=""
+rcfile=""
+
+cleanup()
+{
+	# exact-PID kill only after RE-validating identity (guards against
+	# PID reuse between publication and cleanup)
+	if [ -n "${iperf_pid}" ] && valid_server_pid "${iperf_pid}"; then
+		kill "${iperf_pid}" 2>/dev/null
+	fi
+	iperf_pid=""
+	if [ -n "${server_wrapper}" ]; then
+		# the wrapper waits on the server; reap it with a 5s bound so a
+		# live-but-unpublished server can never hang cleanup
+		for _ in $(seq 1 50); do
+			kill -0 "${server_wrapper}" 2>/dev/null || break
+			sleep 0.1
+		done
+		kill "${server_wrapper}" 2>/dev/null
+		wait "${server_wrapper}" 2>/dev/null
+		server_wrapper=""
+	fi
+	# last resort, namespace-scoped only: TERM the iperf3 processes that
+	# actually live in the peer netns, poll for bounded exit, then
+	# SIGKILL any survivor before touching the namespace name. A blind
+	# pkill would scan the host PID space and hit unrelated tests.
+	local _p _still
+	for _p in $(ip netns pids "$ns_peer" 2>/dev/null); do
+		if is_iperf3_pid "$_p"; then
+			kill "$_p" 2>/dev/null
+		fi
+	done
+	for _ in $(seq 1 50); do
+		_still=0
+		for _p in $(ip netns pids "$ns_peer" 2>/dev/null); do
+			if is_iperf3_pid "$_p"; then
+				_still=1
+				break
+			fi
+		done
+		[ "$_still" -eq 0 ] && break
+		sleep 0.1
+	done
+	for _p in $(ip netns pids "$ns_peer" 2>/dev/null); do
+		if is_iperf3_pid "$_p"; then
+			kill -9 "$_p" 2>/dev/null
+		fi
+	done
+	# remove only the known non-empty private directory
+	if [ -n "${workdir}" ] && [ -d "${workdir}" ]; then
+		rm -rf "${workdir}"
+	fi
+	workdir=""
+	pidfile=""
+	rcfile=""
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+check_tool()
+{
+	if ! command -v "$1" > /dev/null 2>&1; then
+		echo "SKIP: Could not run test without $1"
+		exit $ksft_skip
+	fi
+}
+
+nsx()
+{
+	ip netns exec "$1" bash -c "$2"
+}
+
+is_iperf3_pid()
+{
+	[ "$(cat /proc/"$1"/comm 2>/dev/null)" = "iperf3" ]
+}
+
+# Decimal-counter validation for the snapshot blocks: every value must
+# be a plain decimal number. A parse failure in read_tx_counters yields
+# empty/garbled fields, which this check turns into an immediate FAIL.
+valid_decimals()
+{
+	local v
+
+	for v in "$@"; do
+		[[ "$v" =~ ^[0-9]+$ ]] || return 1
+	done
+	return 0
+}
+
+setup_topo()
+{
+	setup_ns ns_dut ns_san ns_peer || exit $?
+
+	ip link add d_a netns "$ns_dut" type veth peer name p_a netns "$ns_peer"
+	ip link add d_b netns "$ns_dut" type veth peer name p_b netns "$ns_peer"
+	ip link add d_il netns "$ns_dut" type veth peer name s0 netns "$ns_san"
+
+	# HSR tags add 6 bytes per frame; give the LAN legs headroom.
+	for iface in d_a d_b; do
+		nsx "$ns_dut" "ip link set $iface mtu 1600; \
+			ip link set $iface up"
+	done
+	for iface in p_a p_b; do
+		nsx "$ns_peer" "ip link set $iface mtu 1600; \
+			ip link set $iface up"
+	done
+
+	nsx "$ns_dut" "ip link set d_il up"
+	nsx "$ns_san" "ip link set s0 up; ip addr add $san_ip/24 dev s0"
+
+	nsx "$ns_dut" "ip link add hsr0 type hsr \
+		slave1 d_a slave2 d_b interlink d_il proto 0; \
+		ip link set hsr0 up"
+	nsx "$ns_peer" "ip link add hsr1 type hsr \
+		slave1 p_a slave2 p_b proto 0; \
+		ip link set hsr1 up; ip addr add $peer_ip/24 dev hsr1"
+
+	# Let the nodes see each other's supervision frames.
+	sleep 2
+}
+
+check_feature()
+{
+	local ns="$1"
+	local iface="$2"
+	local feature="$3"
+	local want="$4"
+
+	if nsx "$ns" "ethtool -k $iface" | grep -q "^$feature: $want"; then
+		echo "INFO: $ns/$iface $feature is $want [ OK ]"
+	else
+		echo "FAIL: $ns/$iface $feature is not $want" 1>&2
+		ret=1
+	fi
+}
+
+# Off-or-absent variant: fails only when the feature is present AND on,
+# so devices that simply do not list the feature do not fail it.
+check_feature_not_on()
+{
+	local ns="$1"
+	local iface="$2"
+	local feature="$3"
+
+	if nsx "$ns" "ethtool -k $iface" | grep -q "^$feature: on"; then
+		echo "FAIL: $ns/$iface $feature is on" 1>&2
+		ret=1
+	else
+		echo "INFO: $ns/$iface $feature not on [ OK ]"
+	fi
+}
+
+do_gro_feature_checks()
+{
+	echo "INFO: Checking that enslavement disabled GRO."
+	check_feature "$ns_dut" d_a generic-receive-offload off
+	check_feature "$ns_dut" d_b generic-receive-offload off
+	check_feature "$ns_dut" d_il generic-receive-offload off
+	stop_if_error "GRO not disabled on enslaved devices."
+
+	echo "INFO: Checking that enslavement disabled HW-GRO."
+	check_feature "$ns_dut" d_a rx-gro-hw off
+	check_feature "$ns_dut" d_b rx-gro-hw off
+	check_feature "$ns_dut" d_il rx-gro-hw off
+	stop_if_error "HW-GRO not disabled on enslaved devices."
+
+	echo "INFO: Checking that the HSR master does not advertise GSO/TSO."
+	check_feature "$ns_dut" hsr0 generic-segmentation-offload off
+	check_feature "$ns_dut" hsr0 tcp-segmentation-offload off
+	check_feature_not_on "$ns_dut" hsr0 tx-tcp6-segmentation
+	check_feature_not_on "$ns_dut" hsr0 tx-udp-segmentation
+	check_feature_not_on "$ns_dut" hsr0 tx-gso-list
+	stop_if_error "HSR master still advertises GSO-family features."
+}
+
+alloc_workdir()
+{
+	# Allocated only here, long after the initial topology cleanup, so
+	# cleanup() at setup_topo() time can never remove it. mktemp failure
+	# is a hard test failure.
+	workdir=$(mktemp -d /tmp/hsr_gro_test.XXXXXX) || {
+		echo "FAIL: mktemp -d failed" 1>&2
+		exit 1
+	}
+	chmod 700 "${workdir}"
+	pidfile="${workdir}/iperf.pid"
+	rcfile="${workdir}/iperf.rc"
+}
+
+# Numeric, alive, comm == iperf3, and really owned by the peer netns.
+valid_server_pid()
+{
+	local p="$1"
+
+	[[ "$p" =~ ^[0-9]+$ ]] || return 1
+	kill -0 "$p" 2>/dev/null || return 1
+	[ "$(cat /proc/"$p"/comm 2>/dev/null)" = "iperf3" ] || return 1
+	ip netns pids "$ns_peer" 2>/dev/null | grep -qx "$p"
+}
+
+start_iperf_server()
+{
+	local candidate_pid
+
+	# One-shot server, no -D: the wrapper records its exact PID and its
+	# real exit status (netns shares the PID namespace and the host fs).
+	alloc_workdir
+	( nsx "$ns_peer" "iperf3 -s -1 > /dev/null 2>&1 & \
+		echo \$! > ${pidfile}; \
+		wait \$!; \
+		echo \$? > ${rcfile}" ) &
+	server_wrapper=$!
+	# the wrapper writes the pidfile asynchronously; wait for it to
+	# appear instead of racing the read
+	for _ in $(seq 1 50); do
+		[ -s "${pidfile}" ] && break
+		sleep 0.1
+	done
+	if [ ! -s "${pidfile}" ]; then
+		echo "FAIL: iperf3 server did not publish a pid" \
+			"(no pidfile)" 1>&2
+		ret=1
+		return 1
+	fi
+	candidate_pid=$(<"${pidfile}")
+	if ! valid_server_pid "${candidate_pid}"; then
+		echo "FAIL: iperf3 server pid '${candidate_pid}'" \
+			"failed validation" 1>&2
+		ret=1
+		return 1
+	fi
+	# publish only after full validation
+	iperf_pid="${candidate_pid}"
+	sleep 1
+	return 0
+}
+
+# Print "<bytes> <packets>" for exactly one TX record of ns/dev; anything
+# else (missing, duplicated, non-numeric) is a hard FAIL.
+read_tx_counters()
+{
+	local ns="$1" dev="$2"
+	local out cnt
+
+	out=$(nsx "$ns" "ip -s link show $dev" | \
+		awk '/^ +TX:/{getline; print $1, $2}')
+	cnt=$(echo "$out" | grep -c '^[0-9]* [0-9]*$')
+	if [ "$cnt" -ne 1 ]; then
+		echo "FAIL: cannot parse TX counters of $ns/$dev" \
+			"(records=$cnt)" 1>&2
+		return 1
+	fi
+	echo "$out"
+	return 0
+}
+
+eval_counter_delta()
+{
+	local name="$1" b0="$2" p0="$3" b1="$4" p1="$5" op="$6" limit="$7"
+	local bd pd
+
+	if ! [[ "$b0" =~ ^[0-9]+$ && "$b1" =~ ^[0-9]+$ && \
+		"$p0" =~ ^[0-9]+$ && "$p1" =~ ^[0-9]+$ ]]; then
+		echo "FAIL: non-numeric counter input for $name" 1>&2
+		ret=1
+		return 1
+	fi
+	bd=$((b1 - b0))
+	pd=$((p1 - p0))
+	if [ "$bd" -lt 0 ] || [ "$pd" -le 0 ]; then
+		echo "FAIL: counter delta invalid for $name" \
+			"(bytes=$bd pkts=$pd)" 1>&2
+		ret=1
+		return 1
+	fi
+	if [ "$op" = "gt" ]; then
+		if [ "$bd" -le $((pd * limit)) ]; then
+			echo "FAIL: $name bytes/packets $bd/$pd <= $limit" 1>&2
+			ret=1
+			return 1
+		fi
+	else
+		if [ "$bd" -gt $((pd * limit)) ]; then
+			echo "FAIL: $name bytes/packets $bd/$pd > $limit" 1>&2
+			ret=1
+			return 1
+		fi
+	fi
+	echo "INFO: $name counter delta bytes=$bd packets=$pd" \
+		"(op $op limit $limit) [ OK ]"
+	return 0
+}
+
+do_tso_stream_test()
+{
+	local out sender_retr server_rc
+	local san_b0 san_p0 san_b1 san_p1
+	local a_b0 a_p0 a_b1 a_p1 b_b0 b_p0 b_b1 b_p1
+
+	echo "INFO: Enabling TSO/GSO on the SAN interface."
+	nsx "$ns_san" "ethtool -K s0 tso on gso on"
+	check_feature "$ns_san" s0 tcp-segmentation-offload on
+	stop_if_error "Could not enable TSO on the SAN interface."
+
+	echo "INFO: Running 10s TCP stream SAN -> peer through the HSR DUT."
+	start_iperf_server || return
+
+	# Counter snapshots around the stream window. The SAN-side average
+	# must exceed SAN_AVG_MIN (aggregate proof that GSO super-packets
+	# really left the SAN); each DUT LAN leg must stay under LAN_AVG_MAX
+	# (aggregate proof that bulk output was segmented per-frame). These
+	# are aggregate discriminators, not a per-frame maximum proof.
+	san_b0=0; san_p0=0; a_b0=0; a_p0=0; b_b0=0; b_p0=0
+	read -r san_b0 san_p0 <<EOF
+$(read_tx_counters "$ns_san" s0)
+EOF
+	read -r a_b0 a_p0 <<EOF
+$(read_tx_counters "$ns_dut" d_a)
+EOF
+	read -r b_b0 b_p0 <<EOF
+$(read_tx_counters "$ns_dut" d_b)
+EOF
+	if ! valid_decimals "$san_b0" "$san_p0" "$a_b0" "$a_p0" \
+		"$b_b0" "$b_p0"; then
+		echo "FAIL: baseline TX counter snapshot invalid" 1>&2
+		ret=1
+		return 1
+	fi
+
+	# rate-capped: the PRIMARY discriminator is the counter inequality
+	# above, not max throughput; retransmits are informational only.
+	# Uncapped runs flap at VM/CI edge rates without indicating a
+	# functional problem.
+	if ! out=$(nsx "$ns_san" "timeout 60 iperf3 -c $peer_ip -M 1446 \
+		-b 2G -t 10" 2>&1); then
+		echo "FAIL: iperf3 client failed:" 1>&2
+		echo "$out" 1>&2
+		ret=1
+		return
+	fi
+
+	read -r san_b1 san_p1 <<EOF
+$(read_tx_counters "$ns_san" s0)
+EOF
+	read -r a_b1 a_p1 <<EOF
+$(read_tx_counters "$ns_dut" d_a)
+EOF
+	read -r b_b1 b_p1 <<EOF
+$(read_tx_counters "$ns_dut" d_b)
+EOF
+	if ! valid_decimals "$san_b1" "$san_p1" "$a_b1" "$a_p1" \
+		"$b_b1" "$b_p1"; then
+		echo "FAIL: final TX counter snapshot invalid" 1>&2
+		ret=1
+		return 1
+	fi
+
+	eval_counter_delta "SAN s0 TX" "$san_b0" "$san_p0" "$san_b1" "$san_p1" \
+		gt "$SAN_AVG_MIN"
+	eval_counter_delta "DUT d_a TX" "$a_b0" "$a_p0" "$a_b1" "$a_p1" \
+		le "$LAN_AVG_MAX"
+	eval_counter_delta "DUT d_b TX" "$b_b0" "$b_p0" "$b_b1" "$b_p1" \
+		le "$LAN_AVG_MAX"
+	[ "${ret:-0}" -eq 0 ] || return
+
+	# success path: the one-shot server exits by itself; reap the
+	# wrapper, then REQUIRE the rcfile with the server's real status
+	wait "${server_wrapper}"
+	server_wrapper=""
+	if [ ! -s "${rcfile}" ]; then
+		echo "FAIL: iperf3 server status file missing (${rcfile})" 1>&2
+		ret=1
+		return
+	fi
+	server_rc=$(cat "${rcfile}")
+	if ! [[ "$server_rc" =~ ^[0-9]+$ ]] || [ "$server_rc" -ne 0 ]; then
+		echo "FAIL: iperf3 server exited with rc='${server_rc}'" 1>&2
+		ret=1
+		return
+	fi
+	iperf_pid=""
+
+	# secondary health signal only: anchored, single-match, numeric —
+	# any parse anomaly is a loud FAIL, but the value itself no longer
+	# gates (the counter inequalities above are the primary evidence).
+	sender_retr=$(echo "$out" | awk '/sec .* sender$/ {print $(NF-1)}')
+	if [ "$(echo "$sender_retr" | grep -Ec '^[0-9]+$')" -ne 1 ]; then
+		echo "FAIL: cannot parse sender retransmits reliably" 1>&2
+		echo "$out" 1>&2
+		ret=1
+		return
+	fi
+	echo "INFO: TCP stream done;" \
+		"sender retransmits=$sender_retr (secondary signal)"
+	echo "$out" | grep -E "sender|receiver"
+}
+
+check_prerequisites
+check_tool ethtool
+check_tool iperf3
+check_tool timeout
+
+# iproute2 must know the HSR interlink syntax.
+if ! ip link help hsr 2>&1 | grep -qi interlink; then
+	echo "SKIP: iproute2 has no HSR interlink support"
+	exit $ksft_skip
+fi
+
+setup_topo
+
+echo "INFO: Initial validation ping (SAN -> peer through the DUT)."
+do_ping "$ns_san" "$peer_ip"
+stop_if_error "Initial validation failed."
+
+do_gro_feature_checks
+do_tso_stream_test
+stop_if_error "GSO super-packet stream test failed."
+
+echo "INFO: All good."
+cleanup
+exit $ret
-- 
2.43.0

