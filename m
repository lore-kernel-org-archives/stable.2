Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795586765;
	b=N2hH+waOpQbhgCmHxCD2hsAp0sUzxVkR15sWsR5xwRp4+sINuYqbt1HE2tgQfDy39e/i
	 MONsroUy6fcKZaBXeElaf/+gG7eFFazQ44ke+Cjvxu9SH9kD9GCx8+++JqQMms8e+qzJI
	 MAFBbKu7Hv8ey2gwd18lBPZqYCp+seLIlmnvyNVkHlqp3zaLp6uh5ohJfzv/2uu27k8Ci
	 PlYSxX4vt8zv9WxsFOGSlPuHFkx26Z8hE4e+mDSygP4lN5dh8BrtQtIlwXETuiC9sKLqw
	 4UwOEFnuu4DMnd0hI5Zg13d5lfsA3wz6C4VYRUCrfs+IlCeYjETOIhTjbcpdjhRussg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795586765;
	h=Received:DKIM-Signature:Date:To:Cc:From:Message-Id:Subject;
	bh=g/ssngzRXqqQDbgCsWRnVVg1QMJmqj/2MMTLvet6xuU=;
	b=5NOX54pdWNgKF3NLwGx3qCAE02pgVniiE0HMvwBWnOGiqBOPH1mjdgfOUElzb6xfKoGw
	 NpAETAQ+EoQVEmJt7H7J86dIpwuO8hvRHq8JeQoF60jIe9cxLM71c8p7G4a27XqEvdh/j
	 u/5wCztZlmf9Zb582kGOQMYurXe5k8qmUjlVLuF9GCfZvVMeD2oDdhLPp9BFqz/aPzNiU
	 0sV2u9TSKnNuXO6FbMSK1RD/QMNEmb++c3O69Cwowjj2lrtOCb/38E5UGOw4uIZNWBT1M
	 J61/hUoLDX8D+OUJXJmbRRaKIoVqwFIcdIk9bltJy4GEOoW5diOqaEW6GbMuT4sgVEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KizzSOx7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBC606A323;
	Wed, 25 Nov 2026 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=KizzSOx7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B557B1F000C0;
	Wed, 25 Nov 2026 06:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795586764;
	bh=g/ssngzRXqqQDbgCsWRnVVg1QMJmqj/2MMTLvet6xuU=;
	h=Date:To:Cc:From:Subject;
	b=KizzSOx7RzBBn9Ol1D2dp1k0wuvsJPl89+5sYWb46AfGHdXUSv7il+syZ0DoJ3Ww9
	 +7fYsfLAAcbolJFAe4xUollhHPVwokUL6rPhMadHBXNlnHW2r9nlIszlTxAuI3QvA9
	 8JgmDcdmFarfihxgHJpysmqbEtQzjVIbZuPVfhmw=
Date: Tue, 24 Nov 2026 22:06:04 -0800
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Maximilian Heyne <mheyne@amazon.de>,
 Christian Brauner <christianvanbrauner@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Shuah Khan <shuah@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, stable@vger.kernel.org
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <3179ee5792a7421ba74dbfebe2838617.1@linux-foundation.org>
Subject: [PATCH] selftests: uevent filtering: don't shrink the socket buffer
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Maximilian Heyne <mheyne@amazon.de>
Subject: selftests: uevent filtering: don't shrink the socket buffer
Date: Fri, 19 Jun 2026 11:24:29 +0000

The uevent_filtering test shrinks the uevent socket buffer to 4 KB
although the default socket buffer size is much higher.  This leads to
this test being flaky when too many unrelated uevents are fired on the
machine.  They might fill up the netlink receive buffer leading to ENOBUFS
errors when trying to receive the uevents.  For example, I could trigger
test failures when running triggering a lot of udev events in the
background:

  $ # run multiple of that in the background:
  $ while :; do sudo udevadm trigger --action=change; done &
  $ sudo ./uevent_filtering
    # Starting 1 tests from 1 test cases.
    #  RUN           global.uevent_filtering ...
    add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=304458
    add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=304471
    add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=304481
    add@/devices/virtual/mem/fullACTION=addDEVPATH=/devices/virtual/mem/fullSUBSYSTEM=memSYNTH_UUID=0MAJOR=1MINOR=7DEVNAME=fullDEVMODE=0666SEQNUM=349156
    No buffer space available - Failed to receive uevent
    # uevent_filtering.c:463:uevent_filtering:Expected 0 (0) == ret (-1)
    # uevent_filtering: Test failed
    #          FAIL  global.uevent_filtering
    not ok 1 global.uevent_filtering

The default receive buffer size (SK_RMEM_MAX) is far larger than the
requested 4 KB, so keep this to make the test less flaky.

Link: https://patch.msgid.link/20260619-get-swam-a1cd4cca@mheyne-amazon
Fixes: 9d3df886d17b ("selftests: uevent filtering")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <christianvanbrauner@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: <stable@vger.kernel.org>

 tools/testing/selftests/uevent/uevent_filtering.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/tools/testing/selftests/uevent/uevent_filtering.c~selftests-uevent-filtering-dont-shrink-the-socket-buffer
+++ a/tools/testing/selftests/uevent/uevent_filtering.c
@@ -78,7 +78,6 @@ static int uevent_listener(unsigned long
 {
 	int sk_fd, ret;
 	socklen_t sk_addr_len;
-	int rcv_buf_sz = __UEVENT_BUFFER_SIZE;
 	uint64_t sync_add = 1;
 	struct sockaddr_nl sk_addr = { 0 }, rcv_addr = { 0 };
 	char buf[__UEVENT_BUFFER_SIZE] = { 0 };
@@ -96,13 +95,6 @@ static int uevent_listener(unsigned long
 		return -1;
 	}
 
-	ret = setsockopt(sk_fd, SOL_SOCKET, SO_RCVBUF, &rcv_buf_sz,
-			 sizeof(rcv_buf_sz));
-	if (ret < 0) {
-		fprintf(stderr, "%s - Failed to set socket options\n", strerror(errno));
-		goto on_error;
-	}
-
 	sk_addr.nl_family = AF_NETLINK;
 	sk_addr.nl_groups = __UEVENT_LISTEN_ALL;
 
_
