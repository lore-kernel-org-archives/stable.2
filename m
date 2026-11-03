Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732803;
	b=jbkQOWwVlrnRV1S4oA4/h20Npp+jC/B0Wi60h7+t0SvyfsYVBeSz1bpRuY15PC058TrS
	 F4G9rtGKyvyHSYz06ukdqjl41lEDElxjtaUDmG9CJlZ8QsSqTXmNPIqCqHB6HLaWKy86M
	 hz2uAtOdxwi0M1VMRGSwv/a8i2/T1pZZ6txBms7pMGD070KudN+CtZT7n/a+EXYP7Jf2T
	 rxUGY2b7v+hHMJmz79KSsZQjzLNc7FmIAwYpmfw5i3jIFI+P0RU9jls+9AnkSR00rsB0Y
	 SUQl39jt3EFlC1wYMaywrdz6KEu0bZCDve8PIi6ueN0RDsLaD2b3T2x7EPx4JrTBmSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xnhb546EvTjBiof0WQT3D0GzQYbD7f9E7QPwpqthPc0=;
	b=ouFOE9e9CLs1t7Robql936EISR6eE9UOGx27xBYaqIvE7QqgHd/Qr78+jnSPEFUZbV6W
	 +Bo7Y5Av+UeE8iSWkavjbS/90tx9w0uMp5Oov6QDwIEjlvZ0D8uR7Dq6AMRSK+B4yFoYC
	 AYlo5N7mZEl2w36DS1JTyFuD68JPkK0Q1Yra2GBCg0h8dGYjz+G1+LWtx/4QBdsOfxZcD
	 L3gs1H8p0Kz5PEVWvJCxspHHEYVpbS7IyxEX00m0WkhawPL+wAUwlYNakaczYUpwLobAu
	 2AbRa39ECkpaxy9mLommgmzGeTtj54aM10OI4/jyK5Vzr5HFdXEtT/1xPMjJI/YHhzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IFcWmSzn;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B51606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B51606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IFcWmSzn
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535a54bed9so6748079eec.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732802; x=1794337602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xnhb546EvTjBiof0WQT3D0GzQYbD7f9E7QPwpqthPc0=;
        b=IFcWmSznmlF1houPj1jWOUK4c8slHpSDEh02G7flWSjdRLzgeAssjng+o6yu4rRlOQ
         viAxaYbNIxL7nC+iioJi4n5rsFC9arOeCnD3EBkml86bzqhDwg8h3n0phu1V3MACjGIe
         QwySPA+/1tAej1B1FqBzqSzH+J/wDXydeqfAv54Rcs8HPHi0jLVHCGS2mwtjj19DRvc8
         gswOczoxpXtnCS7LNhZzdJOwtHw4cN196oykGNYhGg+M8rF5v3dfTKhFp9dh34xEEfEg
         BJ0ZO3cFpkwXRce9scokAXW1z4N+o3JF83JngnLbVZpt7vLmp5+wPMAih975KUImu/ah
         ckyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732802; x=1794337602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xnhb546EvTjBiof0WQT3D0GzQYbD7f9E7QPwpqthPc0=;
        b=okzGtlRKYc9z8kUpFWX2g1bIxJPGEksYAA3iao2JYL7hSJfhz60ik+8w5L4IGj97Eg
         0uNe9AM0TqWwELCSJBuUbVWBHzD7nTbfp3V9dbuzh+SMXhwfSN+HUt0FEWzXSvcRdmR9
         xCJ083yDRKGvX0PpjmkzTrLBxdvvo6xpjHfUuQacdRdmGfK5xm35N/hzbp/4MYNJmPX1
         Axhiwf3chiT7XFK70nTiBt/AT3jexI/13nPqVCZbIPQPVUozUSyvFRBDEUODY3fi4LtV
         GMeDavW2TOK6n2m9sDGHB2fPGbaMiN8mNbl6BJSowK0QVx8gJW4FUvmUOJxhRJXrAwPz
         DZFQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9Lw3p7d0j+b8wyqqgcTaLIGOW6UUP4dyey/DvH+FqAJ1ObUDhiJB6r2FYoTHXAAYISWSeAUY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8U4vYXv8XhYxMBCwTQau/NThu2yhUMC1d2SEZodjRAx091oB9k
	ke1Nds24e6tbhL+7HheD3gtQec+ByRTa/YBzc/notpHiea8Jx2w2TRvw
X-Gm-Gg: AYBFou0F/DhK2/E137wKJWP2UUWQ8SARgBKrH9e0O5/YuzvwMdJZhc8wAEgITyKTcOD
	4lVINbhkNd89DO3WZEr2bibvPeGrcdhrtjtGmbTJEdSljPtZWIggDd4x51wgdNPZp+FlsG0tT+L
	vi6a+X/fXCYqIqIqjbUHD824XJ15trKERUUJq5e05DiOHZ6PqDgy1HayTHZg/nh/heV+y/i//yS
	qTFtxHe0mAaVRNwa42ETGmhI8zL6jRwR4uZcAmqFGSYJ1htDYttX1PYWN/Q0Qb9db4mjtkYGlxp
	CTnpi1IWezDhBJsruLUHG/n2dLN4js+rJZGjn97e3ZNKisvqVdA/0hpn8zexCznsQljCGSdjeeI
	KCKCNuuNZFWeHVQRdcGVmv1uoHVABz1tZnV6kTn65CIvbMayhm3utYb6UpnhmG6oqzKny0Yf3gE
	TlGxHtPhSSCtN5C+bOQecZq/MRPWDF6+oTUa35a25Sppk+wROepFXscGBFDqKnZxzKGfHHYCEup
	lHmr9SdBEbfn3/cTcK9ITSsL2a09aFxZrT5kqcF7IFnhAAwOB+w4JkNs2jx8Ts2g/tynPRULG1U
	IL6xfr9iSP/QEgz6pbxwHmridsRXF4rVaqS5BU5vQBK9PG9lmBgrfuvx
X-Received: by 2002:a05:693c:20c2:10b0:369:f9b6:f486 with SMTP id 5a478bee46e88-36a4260db8cmr22262699eec.41.1793732802065;
        Tue, 03 Nov 2026 11:06:42 -0800 (PST)
Received: from bridge.. (deps54-26.deps.ufsc.br. [150.162.54.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d3754sm175927eec.14.2026.11.03.11.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 11:06:41 -0800 (PST)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] kgdb: Fix buffer overflow in the qfThreadInfo packet handler
Date: Tue,  3 Nov 2026 16:06:22 -0300
Message-ID: <20261103190622.925741-1-christian.aurichzm@gmail.com>
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
Content-Transfer-Encoding: 8bit

gdb_cmd_query() answers qfThreadInfo with a thread ID and a comma for
every online CPU, 9 bytes each, followed by the first page of tasks.
Only the tasks are paged, KGDB_MAX_THREAD_QUERY at a time, so the CPU
entries overrun remcom_out_buffer[BUFMAX] once there are enough CPUs.
On x86, where BUFMAX is 1024, a typical boot hits this from 109 online
CPUs (222 on arm64 and riscv), and GDB sends qfThreadInfo as soon as it
connects:

  BUG: KASAN: global-out-of-bounds in pack_threadid+0x2a8/0x2e0
  Write of size 1 at addr ffffffff86eecc20 by task swapper/0/1
  ...
  The buggy address belongs to the variable:
   remcom_out_buffer+0x400/0x420

Page the CPU entries together with the tasks, so no reply holds more
than KGDB_MAX_THREAD_QUERY threads. The CPUs still come first, which
scripts/gdb relies on to detect KGDB.

Fixes: 25fc99991383 ("kgdb: fix gdb serial thread queries")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---

Notes:
    Tested in QEMU with KASAN and GDB 15.1. Unpatched, connecting GDB to
    a 109-CPU guest gives the report above; patched, 109, 128 and 255 CPUs
    return the full thread list with no report.
    
    Based on v7.4-rc1.

 kernel/debug/gdbstub.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index fc6a7a8c1f6e..02f27e70993c 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -752,15 +752,20 @@ static void gdb_cmd_query(struct kgdb_state *ks)
 		i = 0;
 		remcom_out_buffer[0] = 'm';
 		ptr = remcom_out_buffer + 1;
-		if (remcom_in_buffer[1] == 'f') {
-			/* Each cpu is a shadow thread */
-			for_each_online_cpu(cpu) {
-				ks->thr_query = 0;
+		if (remcom_in_buffer[1] == 'f')
+			ks->thr_query = 0;
+
+		/* Each cpu is a shadow thread */
+		for_each_online_cpu(cpu) {
+			if (i >= ks->thr_query && !finished) {
 				int_to_threadref(thref, -cpu - 2);
 				ptr = pack_threadid(ptr, thref);
 				*(ptr++) = ',';
-				i++;
+				ks->thr_query++;
+				if (ks->thr_query % KGDB_MAX_THREAD_QUERY == 0)
+					finished = 1;
 			}
+			i++;
 		}
 
 		for_each_process_thread(g, p) {
-- 
2.43.0

