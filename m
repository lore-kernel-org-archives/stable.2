Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188744;
	b=oynEtUvSgE5ONdTYtfpLtHf/c9YzzGLpD2m5vJrCv/U/XLhOHQWLOk4mzYWGmPOrBdUG
	 sZ7hEO+6pY9fhfyYE46dUcpjRL4ix8MmnPHP9TaX64Q7Nau1lOoBWnW+JC6DHQacg/HEM
	 50rEJsuY1ck++iUo70A53o+0aYy9bJOIbyIJvtBcdyRKiLCa4ragNyp5RQlwP6zJ6A+O8
	 3gcm4RHUKpKnsmml/mDzZqLjnMCupG5k8wLGytN/vHwmlk+pTAGbrJeRiwrAnYSUsygrV
	 mT7DC3BWIyD9wcgea1fVSlk5IWnraVHPcUdsBFJaLq/6tv5S0CxwY5gLZ8h4xFYoY4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188744;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dJtHGHDtZtmjbOKJHErtajvv0VrvqMou54t9YxCKM0o=;
	b=ouRyu2UiZTtQmiKFdHMRezNqYdmOueGo+zPgu8C7qnxF/W1wX5cXMXVWURQ/vl77Xdcv
	 /A1d9WOsG84XgcBCwfMIAvycd3uo75jOMrAltmwaQSJ9kgMKPR+HnFyzPz9jOzWPmYpFT
	 Y7YryrrltJm70VpfGLuGG9V2whstAN2hsJUqH7MIq1Ej9+W3nHwWaftKLbTg9uT90jSSv
	 74zypaXgzXKXjivKuSRBXlXSFA3/iTfmyHlQr6tCAU4GS4qkUrxHGcumfp2+dH8qI9AKP
	 GINWQLEFdG1uYgEfUFBgSCw15v/EjeZHKEPN7oiuYXBGhTRvX9DzDTUqAcKc8rVugbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ZCTsIWQC;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB3606A323;
	Mon,  9 Nov 2026 01:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFFB3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ZCTsIWQC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ZCTsIWQC3uvYimIqtqZrylff+56BGKJHKpKwpaU5Cfuz3bUDPtX3EwWWAvqfl7xXjo+y1LyVfRs7c
	 wnXw33m0+kHd/0iiqbS1iWT+FHjzuKUq+qvNo8PWqUvwcWp/JJIPzrsIzAM+XYhn3VpPnocEo7i5VX
	 dAEfzoNP+QhB3fmc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af125c3ba6-fa8ff;
	Mon, 09 Nov 2026 09:45:40 +0800 (CST)
X-RM-TRANSID:2ee26af125c3ba6-fa8ff
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.102])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af125c1671-7c028;
	Mon, 09 Nov 2026 09:45:40 +0800 (CST)
X-RM-TRANSID:2eea6af125c1671-7c028
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
	willemb@google.com,
	tpluszz77@gmail.com
Subject: [PATCH net v3 2/2] selftests: net: exercise SO_MARK on connected sockets
Date: Mon,  9 Nov 2026 09:45:26 +0800
Message-ID: <20261109014400.9025-2-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
References: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
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

cmsg_so_mark.sh sends to explicit destinations, so it does not test the
route cached by connect().

Add -k to cmsg_sender to connect first and send without msg_name.
Check connected IPv4 and IPv6 UDP, ping and raw sockets with equal,
prohibited and zero per-message marks.

Add an exact mark 0 prohibit rule before the connected cases. Connect
with an allowed socket mark, then require rejection of a mark 0 cmsg.

The same test fails four IPv6 cases before the kernel fix and passes
all 54 with it.
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
v3:
  - Add an exact mark 0 prohibit rule for the connected cases.
  - Require rejection of a mark 0 cmsg after an allowed connect().

v2: https://lore.kernel.org/netdev/20261104092252.15712-1-yanxia@cmss.chinamobile.com/T/

 tools/testing/selftests/net/cmsg_sender.c   | 21 +++++++++++++++++---
 tools/testing/selftests/net/cmsg_so_mark.sh | 22 +++++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index 67a72b1..035ab54 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -34,6 +34,7 @@ enum {
 	ERN_CMSG_RD,
 	ERN_CMSG_RCV,
 	ERN_SEND_MORE,
+	ERN_CONNECT,
 };
 
 struct option_cmsg_u32 {
@@ -48,6 +49,7 @@ struct options {
 	unsigned int size;
 	unsigned int num_pkt;
 	bool msg_more;
+	bool connected;
 	struct {
 		unsigned int mark;
 		unsigned int dontfrag;
@@ -93,6 +95,7 @@ static void __attribute__((noreturn)) cs_usage(const char *bin)
 	printf("Usage: %s [opts] <dst host> <dst port / service>\n", bin);
 	printf("Options:\n"
 	       "\t\t-s      Silent send() failures\n"
+	       "\t\t-k      Connect before sending\n"
 	       "\t\t-S      send() size\n"
 	       "\t\t-4/-6   Force IPv4 / IPv6 only\n"
 	       "\t\t-p prot Socket protocol\n"
@@ -121,8 +124,12 @@ static void cs_parse_args(int argc, char *argv[])
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
@@ -521,6 +528,12 @@ int main(int argc, char *argv[])
 
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
@@ -530,8 +543,10 @@ int main(int argc, char *argv[])
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
index 772ad0c..341abfc 100644
--- a/tools/testing/selftests/net/cmsg_so_mark.sh
+++ b/tools/testing/selftests/net/cmsg_so_mark.sh
@@ -68,6 +68,28 @@ for ovr in setsock cmsg both; do
     done
 done
 
+# Reject an explicit zero mark while leaving the socket mark allowed.
+ip -netns "$NS" rule add fwmark 0/0xffffffff lookup 300 || exit 1
+ip -6 -netns "$NS" rule add fwmark 0/0xffffffff lookup 300 || exit 1
+
+# Check per-message marks after connect() has populated the route cache.
+for i in 4 6; do
+    [ "$i" = 4 ] && TGT=$TGT4 || TGT=$TGT6
+
+    for p in u i r; do
+	for mark in "$((MARK + 1))" "$MARK" 0; do
+	    expected=0
+	    if [ "$mark" -eq "$MARK" ] || [ "$mark" -eq 0 ]; then
+		expected=1
+	    fi
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


