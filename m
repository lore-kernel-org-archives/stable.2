Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485833;
	b=4jc2hYi7pnxWSnc408wuRrNsJPSVpV6+GP9z7dGeM1yOgG5U42aJyuaqFIS6WZpGHQX6
	 UffwtEQbtJ8RQNJ8uamkRISjobbE9b+k3eyO/ImyOSjb1jYF9bzThpDX0XY7HKxxmx/9F
	 8ytBYYS941YV2anjln409nuQjaH7FXrc06VqBYguI/eWfeQzUXvDMOZSSZsTKFW2SYCi/
	 Gvl/0yNJMfUguq10FZJdRwrdUXASwQDB5bjK1Lw9g9ePBKzW5o0m7S0MEVKXxU5XdxbZ3
	 cB5NN8BJIGvkyPFZfM1VqGUSE8l+qU1JXEkiQg1nRbItd1nGsns2pAFmXD1ChtjC57w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485833;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=YPGrZtQTSZxURuuST0ifATlw9hrQHZEhB5CNPEdDARA=;
	b=L13FGYNkqV85UIkWWIS8idQNDg7+jufbAMINNWuUr4DeWSRmf+HUI5JhykImg4cu6Owz
	 jbVpiR3m2tPuFRZ2ZV5XbQCWmPDhwlpGgVZBWitxHr2EzqDnp2N3VTHo0PFFhcCn4CnsZ
	 Tx0qx/UfJhQtgDtIL3IliTWUQ/X5jHesLIGmdqxiCFkSaH7sErr4LQu3Kndx/MDc/32P4
	 CN0+YhrsIPUx8cM8uGH/oeAkqkx4rxQJtZbGcWhmX7EGhMkKiOF1yAQujaL+r4jR42sr1
	 1AXwiZtX76gzCvwBekOH+UMYOeIhUXZ5k5YF6T746Oa/QiMQElSXVCL27uf6FPsWW8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=HYZ6aL4v;
	arc=none smtp.remote-ip=54.92.39.34
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9D606A337
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C9D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=HYZ6aL4v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794485827;
	bh=YPGrZtQTSZxURuuST0ifATlw9hrQHZEhB5CNPEdDARA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HYZ6aL4vSbb3X9ysZnG5qwP2CDphHhaTWsCplLDRHTupluUoxu29jjgV5a+ol76JZ
	 ePLd8KEKy9Ew2mUI+vkY+JwULBXRGYSRqvrp7a+H8cZUC3d9zKDzlHHo4RfApjNlAQ
	 z8kwfyrpyrHMdktX6FO1wsxrgd2INhWqeI6mmxnQ=
X-QQ-mid: zesmtpgz8t1794485812t43c5ec44
X-QQ-Originating-IP: JL79jULWRDamYAJoOF8fuylu44LwFj2biUTYVg1xBn0=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Nov 2026 20:16:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6304755034306503568
EX-QQ-RecipientCnt: 13
From: raoxu <raoxu@uniontech.com>
To: valentina.manea.m@gmail.com
Cc: shuah@kernel.org,
	i@zenithal.me,
	luiz.von.dentz@intel.com,
	pengpeng@iscas.ac.cn,
	brgl@kernel.org,
	pmenzel@molgen.mpg.de,
	raoxu@uniontech.com,
	gregkh@linuxfoundation.org,
	ihadzic@research.bell-labs.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usbip: Close all listening sockets in request workers
Date: Thu, 12 Nov 2026 20:16:48 +0800
Message-ID: <E063498E65C71B8D+20261112121648.1458957-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
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
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NMMSTmykDl9bNJoFlxnndTCTMIIE8oS4PG3qy8p7EzvNMH3P6F33cwZI
	tcE2OZHrB8Jo0XenV2+MwiuAxyaBJuXEApJ8sanEsBdZ2daU4pjOZ6XVvAF+GNQTDot/dvm
	H6fMgs+y1E756kfEBopFsn19zjQ+oyTDH7vJY3yBXqCl+WKTAk+BAN8wQEuEJi+5nSSyIaw
	cl66vDPKAkyrw3rnp5kPjTmln1ccheXBlWPzAZWmXVKk0m6Z2cYaJ8hmtXnv0xEe6gJyGp4
	Mr0rE++oeW8nLOAIAWBhF0ZsK8ylnryhkcpQOdTSjxg95XVVmyOLF+0Ia2sEzwJL8VPmeOQ
	Z55ByGEhLRqaTLJrpl16KVLWlgnoj7MYXnY1WFWW1efutlyXhPy1CXCRYow/4FksyDsVs3h
	Z4hlNNWj+y3Sn8oIr9nyFOZ26xigdte5BjNWFAbEkJnwHTGr4oDlkRo7clW7M/d+rxSD3nC
	1pw+3r1jCxiJAo8Cv2hg/BOmcYZZkSDhsHfcutV859G+cQsbOjwKcVQS0HcxLGRMBzYbFOS
	+fwBa0zA+M+IyFra3hvnBQKO4Xus0oF1ZwM5Cff5ZM1bv8CLTSM9USJnFbh1727HwqF2JPp
	LYaS4XNP0Cq7R40fDucq7LWWZoaSLBRVKmHKA/trGCQNHANLoTcMQ9Rs+ZlB2J6OwOXfVxo
	1GGySE4ICga2rvrw/g3pcPUm/LyLGK6cwYcaCghhgqwksln3SPKgadsyn4aRMCfXo6wQci0
	uQgatJH5ejOoEkB/X54CC7iEIm5CF3gEaOl5j+zYZApA+OK2nhD4UEEDsbUXIntLMhhsy/8
	kludwBkqIq8PnGf7l1XC6sAIF2aakYn1mymuqL7qbcjhYvb1iUEh/k4BXifr91yQ0hxdui2
	kHuaD8NHlr/nM6Zmlep+ARk28ncHS2A/hCdoaTlLKuwxmAkPcZgknu7x0qWoXAr0NpQxZLH
	XA1rk+e5oyM8p5ynTMS5t3Uvhv2r2y2bRr3pjRJdpgkxCTeTiiOC+oLJgpmyXJJkPpveIRX
	W4G4JRyv6XEJz5Vg1wJ3/D+adbTtUnOCLjw0geHYRwMq62wa/4BDqzPTQH1UuGmILfJXzGJ
	w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

process_request() forks a worker after accepting a connection, but the
child only closes the listener used for that connection. All other
listening sockets are inherited and remain open until the worker exits.
This occurs when usbipd listens on multiple addresses, including the
default IPv4 and IPv6 setup.

A worker waiting for a client request can therefore keep an unrelated
listener alive after the main daemon exits. Restarting usbipd then fails
to bind that address with EADDRINUSE, or starts with only the addresses
that are still available. A single-listener configuration is unaffected.

Pass the complete listening socket array and its count to
process_request(), and close every listener in the child before handling
the request. The accepted connection remains open, and the parent's
descriptors are unaffected. Make process_request() static as its only
caller is in the same file.

Fixes: 328f7f8a0a1c ("staging: usbip: userspace: eliminate glib dependency")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 tools/usb/usbip/src/usbipd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
index 3e22b651c754..5ff5b46674a2 100644
--- a/tools/usb/usbip/src/usbipd.c
+++ b/tools/usb/usbip/src/usbipd.c
@@ -339,17 +339,20 @@ static int do_accept(int listenfd)
 	return connfd;
 }

-int process_request(int listenfd)
+static int process_request(int listenfd, const int *listenfds, int nlistenfds)
 {
 	pid_t childpid;
 	int connfd;
+	int i;

 	connfd = do_accept(listenfd);
 	if (connfd < 0)
 		return -1;
 	childpid = fork();
 	if (childpid == 0) {
-		close(listenfd);
+		/* Do not keep unrelated listening sockets alive in workers. */
+		for (i = 0; i < nlistenfds; i++)
+			close(listenfds[i]);
 		recv_pdu(connfd);
 		exit(0);
 	}
@@ -568,7 +571,8 @@ static int do_standalone_mode(int daemonize, int ipv4, int ipv6)
 				if (fds[i].revents & POLLIN) {
 					dbg("read event on fd[%d]=%d",
 					    i, sockfdlist[i]);
-					process_request(sockfdlist[i]);
+					process_request(sockfdlist[i], sockfdlist,
+							nsockfd);
 				}
 			}
 		} else {
--
2.50.1

