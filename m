Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784189;
	b=JurCIfKbBewwkIX+U88WJxcusXld//p7KL6OGgrndMlx/Cfpjew4eGmHoZEuLhUc8aOC
	 0DbhXCXSO2vyuJIzId0HCofyEeXRl5TSUri/FCgsOA4D4xXd0O0/7O1Z+dye/oiNv4w+u
	 wyHZhSPLmxnLRFnI1j16QAdDQnxrcrg0SbrcJoL6EZ9azMrQexmBSY5n/B9oThdBZSxZz
	 MbOLqv3h0eFsw6H6MRdxXBDseY6jkz3h23FCvw0y2wKYYoe+FkXO0Lj+43Gx3fXE5moJ7
	 Ik3J355yyukuIp0s93/d1PuZtfcaf35LWgczMJK/CLlbhVx4sjX3jZj2ZPlME/mdy7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784189;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bmXVSSlN45L+rv4ubBxKKCnM10XnTPIhgH058pVIBqk=;
	b=U5Y7kdDcsqxYbXSteOmXftDq7mfkAfWiCtVYUWvr+g6KjjlG3z6qovtGvxeZD06aBn2o
	 QImsbKWWxmV6+uGDJPFO9xue7Dri83vjL3rBir1+nWfK8reYW/kagGAhz7NmZjt6fiBDU
	 C7pehPh1ObARsKXBR9oyA3weudoq4qh9h/Mhpx2cjNIW/yatz3wccBkDrNB5PYfu6bjbA
	 cHkxTPxqDAwt9+ZZo0wXTYr41Cweq3J8mNvwiMx5i332zfgitJ31YbRrqFIJFs2Yf9RMb
	 gtt2XGxxvGTHHozFj8NsYEgZuK8PqOsVEcV9TV2lUv+TMZ0ghQL4e91LORGHRNj3vCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Yuo2h5l8;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698AB606A32E;
	Wed,  4 Nov 2026 09:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 698AB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Yuo2h5l8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Yuo2h5l87UV4o0gWUa4o4VALrLc2KJegur7qOWc388cIJSMKpjFWL5lxnL+0VXf3JWNG5dqOQPsbB
	 jWY8eVH1YouWxbIGPD9RMwFiNshML03+1XazcuXhLWjjGMMDTHNiY8FMzR5blCS7CpCEe7OYuPIPSY
	 JU7RXOmrOnVkLqBk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aeaf97ab15-6931f;
	Wed, 04 Nov 2026 17:23:06 +0800 (CST)
X-RM-TRANSID:2ee66aeaf97ab15-6931f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86aeaf9799c5-1cd8e;
	Wed, 04 Nov 2026 17:23:06 +0800 (CST)
X-RM-TRANSID:2ee86aeaf9799c5-1cd8e
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	willemb@google.com
Subject: [PATCH net v2 2/2] selftests: net: exercise SO_MARK on connected sockets
Date: Wed,  4 Nov 2026 17:22:53 +0800
Message-ID: <20261104092252.15712-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
References: <20261104092240.15649-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

cmsg_so_mark.sh sends to an explicit destination without connecting the
socket, so it does not exercise the route cached by connect(). This left
the IPv6 SO_MARK cache bug uncovered.

Add a cmsg_sender option to connect before sending and omit msg_name in
that mode. Keep the existing cases and add connected IPv4 and IPv6 UDP,
ping and raw sends with a per-message mark equal to the socket mark,
prohibited by a policy rule, or explicitly zero.

On UML, the added IPv6 UDP and ping cases with the prohibited mark fail
before the kernel fix. With the fix, all 54 cases pass.

Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
v2:
  - New patch; add 18 connected-socket cases alongside the existing 36.

The test gap was noted during automated review of v1:
https://lore.kernel.org/netdev/179371875338.488856.4546363285391899557@kernel.org/

Tested the same selftest on baseline, v1 and v2 UML kernels: baseline
fails 2/54 cases; v1/v2 pass all 54. Both versions of cmsg_sender build
with GCC 12.3.1. ShellCheck 0.11.0 reports the same 13 existing SC2086
diagnostics before and after the change.

 tools/testing/selftests/net/cmsg_sender.c   | 21 ++++++++++++++++++---
 tools/testing/selftests/net/cmsg_so_mark.sh | 16 ++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -34,6 +34,7 @@
 	ERN_CMSG_RD,
 	ERN_CMSG_RCV,
 	ERN_SEND_MORE,
+	ERN_CONNECT,
 };
 
 struct option_cmsg_u32 {
@@ -48,6 +49,7 @@
 	unsigned int size;
 	unsigned int num_pkt;
 	bool msg_more;
+	bool connected;
 	struct {
 		unsigned int mark;
 		unsigned int dontfrag;
@@ -93,6 +95,7 @@
 	printf("Usage: %s [opts] <dst host> <dst port / service>\n", bin);
 	printf("Options:\n"
 	       "\t\t-s      Silent send() failures\n"
+	       "\t\t-k      Connect before sending\n"
 	       "\t\t-S      send() size\n"
 	       "\t\t-4/-6   Force IPv4 / IPv6 only\n"
 	       "\t\t-p prot Socket protocol\n"
@@ -121,8 +124,12 @@
 {
 	int o;
 
-	while ((o = getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H:Q:")) != -1) {
+	while ((o = getopt(argc, argv,
+			   "46ksS:p:P:m:M:n:d:tf:F:c:C:l:L:H:Q:")) != -1) {
 		switch (o) {
+		case 'k':
+			opt.connected = true;
+			break;
 		case 's':
 			opt.silent_send = true;
 			break;
@@ -521,6 +528,12 @@
 
 	ca_set_sockopts(fd);
 
+	if (opt.connected && connect(fd, ai->ai_addr, ai->ai_addrlen)) {
+		fprintf(stderr, "Can't connect socket: %s\n", strerror(errno));
+		err = ERN_CONNECT;
+		goto err_out;
+	}
+
 	if (clock_gettime(CLOCK_REALTIME, &time_start_real))
 		error(ERN_GETTIME, errno, "gettime REALTIME");
 	if (clock_gettime(CLOCK_MONOTONIC, &time_start_mono))
@@ -530,8 +543,10 @@
 	iov[0].iov_len = opt.size;
 
 	memset(&msg, 0, sizeof(msg));
-	msg.msg_name = ai->ai_addr;
-	msg.msg_namelen = ai->ai_addrlen;
+	if (!opt.connected) {
+		msg.msg_name = ai->ai_addr;
+		msg.msg_namelen = ai->ai_addrlen;
+	}
 	msg.msg_iov = iov;
 	msg.msg_iovlen = 1;
 
diff --git a/tools/testing/selftests/net/cmsg_so_mark.sh b/tools/testing/selftests/net/cmsg_so_mark.sh
--- a/tools/testing/selftests/net/cmsg_so_mark.sh
+++ b/tools/testing/selftests/net/cmsg_so_mark.sh
@@ -68,6 +68,22 @@
     done
 done
 
+# Check per-message marks after connect() has populated the route cache.
+for i in 4 6; do
+    [ "$i" = 4 ] && TGT=$TGT4 || TGT=$TGT6
+
+    for p in u i r; do
+	for mark in "$((MARK + 1))" "$MARK" 0; do
+	    expected=0
+	    [ "$mark" -eq "$MARK" ] && expected=1
+
+	    ip netns exec "$NS" ./cmsg_sender -"$i" -p "$p" -k \
+		-M "$((MARK + 1))" -m "$mark" -s "$TGT" 1234
+	    check_result "$?" "$expected" "IPv$i $p connected mark $mark"
+	done
+    done
+done
+
 # Summary
 if [ $BAD -ne 0 ]; then
     echo "FAIL - $BAD/$TOTAL cases failed"


