Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B747AF5F
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631193; cv=none; b=AijAW58F5Rmq/yCmddxsHJtkt4B+zfx6MKVcpm/sAou1acaWP6pIvOKhRIw9pdxijX6a8D1Sa5Lvcwvid7aPBZrFZPZCgQPZfbZyYOQEP1TyqGYexJX9JiSMSs7ddqNAlAWkPm7XNVhVMxbaFcekXZ1+820mXkd+0aNprF2W+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631193; c=relaxed/simple;
	bh=mbt6N7ha+a3fKF4v72gcffAXw1EdCVfHxhDpsUYhjug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtoYDrwuV62sT1HAxV4snLJZxt4KHOQG8ULTS9KmXxerymzsBM3Fr9E2TvK8mA9P0/K9fmj7tKYbJSe+hIXhtO+kD4MZwpjVm8wHkUUQ7QuKkKZtNWHlie6998GfPOyonanUPQvjmKQNZsVL+c/syQTKNtJZy3bGq4TeDHq2F2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuET7uwm; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuET7uwm"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30bc871ecdfso229280eec.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781631189; x=1782235989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9RdJUIM+VglWzfrXeQP+sYvPkbyB0OOU/7Tej3EuTU=;
        b=OuET7uwmDA//Pld42RWbLEPt44CYGUM6UxE7L3ILhhJW6/rvDWexJ3tByn3HyUyg+C
         EKkvd0A+7sOU0Yqr2/UenCphh2CWF/nEmbQI3x1Yo6QRrUzfrEqKC9fZo/5h647ZZgY2
         abmbqpZrq2vSvUESSLrT5VbSyEENE31K1B2l3bZ8wKRlQdz7+NA7AMt7609BIvxcrv6s
         9k5VWn/hMXPdkV15GtxxkmQWr59v7GUam1e6dPCGneRUk4zwInW7HKH3g4r1hGfbCYhS
         /CinyWMO2dTOYmemNEpVOd5oi4bHkf1DzDvZ3Pa421V2uk/P6n2eIWR3Q8ypT1FCvR6G
         o6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781631189; x=1782235989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9RdJUIM+VglWzfrXeQP+sYvPkbyB0OOU/7Tej3EuTU=;
        b=Pn9ubHCJRcb6U/X8RYCbpYCuSuzPyiMuyqEk5PRbrZvPHnSW7ZnesNi4ykp6fST2s/
         Ch59/wOLSHEYw9e7LCVmhFWY3LR7pleOaaogMqjHwQFjYdGX4fZ67JurFgIOYLbnG3Z2
         t6QK8yyKDUIvzPyz4lpQ4GKKECON+aodgs1EyUwPmab53gFx++O34JNNqXc/6lJEKh/q
         68De4mTlBNTfdBK1soT0OlvA0/x2sDB6lo2fDdDMNI5N0J8TT71gtx4sIkUefxSn69r0
         k4csyppzUvripEhKDo6qbfergVStc5EBAxN2PLOx3tZg+iiF13hWs/wy2itOOJ/y8Eoy
         tP8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/+Y7Q/zt68mOzv7Tb314TDEfvyiPkIuXgForRSBTWpCaB504flvF9GJTDmuJRenRD29h1xg3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQxtbVYq1tnlITm7cxE6N+HW1voojaa1t4jN+wFwhgUPYpPjV
	oAyPVII+wK3J7znSsqC4ULf4G29RrlYzyjhjhm0GB7rTkDzwGroC1amN
X-Gm-Gg: Acq92OFJ8boecdMu+mnvrj6gSltGmPBcJzPizM85RSKB31yARdHstWaD7wZEY6ft4Uy
	3T6DVHt368gk37HymDLCfkeZmoA0QWDCewS/cctp1h6z2bNMwD2fb1SQnRvx2AqGO+Vsgavm2Dz
	QFg+aPOM3vsDozA+urXuggBskts5WSC21bqjzbEE0UZ6i+o25eQMYB+3W+FbTebC/BtTAhuH2tK
	LBastGPj5xobk13bgVkE4esJsUhC2DmPJfsUwu7XHtdO3q4cEKLfSSPvil6QNhX0adStKqczco8
	jtlNIkoowDeN6PO5k4U/ItSxkD5UJViCmLZVoBYQ/al0ymkSqNEOIs51g0j+/av8TIh1WRaFqqZ
	GOrO5+H0y40zPEK0qAFMVBJh+ZiT83kl19YANPClBQSSLH1OGp6jOOkIhj/N4pKLgg2yIXcFA4y
	Ke3fnf7vT0srK265R8DUmIOfjT9GHPNA4dlTpsI0BAqSfGyIy8lf2e8eG/nIXpvYxXKXaB
X-Received: by 2002:a05:7300:3081:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-30bca090d72mr176470eec.26.1781631189193;
        Tue, 16 Jun 2026 10:33:09 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ba6b7f840sm5431554eec.19.2026.06.16.10.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:33:08 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: "Starke, Daniel" <daniel.starke@siemens.com>,
	Xiang Mei <xmei5@asu.edu>,
	linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] tty: n_gsm: fix use-after-free in gsm_queue() control frame dispatch
Date: Tue, 16 Jun 2026 10:32:39 -0700
Message-ID: <20260616173240.3665059-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616173240.3665059-1-bestswngs@gmail.com>
References: <20260616173240.3665059-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive worker (flush_to_ldisc -> gsmld_receive_buf -> gsm0_receive/
gsm1_receive -> gsm_queue) reads gsm->dlci[address] and dispatches the
frame via dlci->data() without holding gsm->mutex.  The control handlers
reached through dlci->data() then re-read gsm->dlci[]: gsm_control_reply()
re-reads gsm->dlci[0], while gsm_control_modem() (MSC), gsm_control_rls()
(RLS) and gsm_control_negotiation() (PN) re-read gsm->dlci[addr] for the
DLCI named in the command - a different channel from the one the frame
was addressed to.

Concurrently GSMIOC_SETCONF -> gsm_config() -> gsm_cleanup_mux() takes
gsm->mutex and releases every DLCI via gsm_dlci_release() -> dlci_put().
When the last reference is dropped the destructor gsm_dlci_free() clears
gsm->dlci[addr] and frees the object.  If the worker dereferences one of
those DLCIs while it is being freed, it touches freed memory.

A peer that drives DLCI 0 control frames (e.g. CMD_TEST) while the mux
owner reconfigures the line discipline with GSMIOC_SETCONF can therefore
trigger a use-after-free:

  BUG: KASAN: slab-use-after-free in gsm_control_reply.isra.0
  Read of size 8 at addr ffff888029ae9000 by task kworker/u16:2/46
  Workqueue: events_unbound flush_to_ldisc
  Call Trace:
   gsm_control_reply.isra.0 (drivers/tty/n_gsm.c:1494)
   gsm_dlci_command (drivers/tty/n_gsm.c:2477)
   gsmld_receive_buf (drivers/tty/n_gsm.c:3616)
   tty_ldisc_receive_buf (drivers/tty/tty_buffer.c:398)
   tty_port_default_receive_buf (drivers/tty/tty_port.c:37)
   flush_to_ldisc (drivers/tty/tty_buffer.c:502)
   process_one_work
   worker_thread
   kthread

  Freed by task 5110:
   kfree
   gsm_cleanup_mux (drivers/tty/n_gsm.c:3161)
   gsmld_ioctl (drivers/tty/n_gsm.c:3415)
   tty_ioctl

Pin each DLCI across the dereference with its existing tty_port reference.
gsm_dlci_open_get() looks gsm->dlci[addr] up under gsm->mutex and, if
present, takes a dlci_get() reference before dropping the mutex; the
caller releases it with gsm_dlci_unget() once it is done.  While the
reference is held the kref cannot reach zero, so gsm_dlci_free() cannot
run: the object stays live and gsm->dlci[addr] is not cleared.  gsm_queue()
pins the addressed DLCI for the UI/UIH dispatch, and gsm_control_modem(),
gsm_control_rls() and gsm_control_negotiation() each pin the DLCI they
operate on.

The reference is taken only under the mutex, around the lookup; the mutex
is released before dlci->data() and before the data-path work
(gsm_process_modem(), tty_flip_buffer_push(), gsm_data_queue(), ...), so
the receive/transmit path is not serialised by gsm->mutex and its timing
is unaffected.

Because a pinned DLCI can outlive the gsm_cleanup_mux() that released it,
a subsequent GSMIOC_SETCONF may re-create a DLCI at the same address
before the worker drops its reference.  Make gsm_dlci_free() clear the
slot only if it still points at the DLCI being freed, so the late
destructor cannot wipe a freshly installed DLCI:

	cmpxchg(&dlci->gsm->dlci[dlci->addr], dlci, NULL);

Attaching the n_gsm line discipline requires CAP_NET_ADMIN (gsmld_open()
uses capable(), not ns_capable()), so this is a local denial of service
for a privileged mux owner whose control channel is driven by an
untrusted peer on the serial link while it reconfigures; harden the
receive path regardless.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/all/DJ7OKN8EMAK8.22CE0B8NZXD73@gmail.com/
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/tty/n_gsm.c | 105 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de..e1ab3a08f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -453,6 +453,8 @@ static const u8 gsm_fcs8[256] = {
 #define GOOD_FCS	0xCF
 
 static void gsm_dlci_close(struct gsm_dlci *dlci);
+static struct gsm_dlci *gsm_dlci_open_get(struct gsm_mux *gsm, unsigned int addr);
+static void gsm_dlci_unget(struct gsm_dlci *dlci);
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
 static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk);
 static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
@@ -1694,10 +1696,8 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 		return;
 
 	addr >>= 1;
-	/* Closed port, or invalid ? */
-	if (addr == 0 || addr >= NUM_DLCI || gsm->dlci[addr] == NULL)
+	if (addr == 0)
 		return;
-	dlci = gsm->dlci[addr];
 
 	/* Must be at least one byte following the EA */
 	if ((cl - len) < 1)
@@ -1711,12 +1711,23 @@ static void gsm_control_modem(struct gsm_mux *gsm, const u8 *data, int clen)
 	if (len < 1)
 		return;
 
+	/*
+	 * Pin the addressed DLCI across the dereference: a concurrent
+	 * GSMIOC_SETCONF -> gsm_cleanup_mux() can free it otherwise. Pinning
+	 * (not gsm->mutex over the whole handler) keeps the data path lock
+	 * free.
+	 */
+	dlci = gsm_dlci_open_get(gsm, addr);
+	if (dlci == NULL)
+		return;
+
 	tty = tty_port_tty_get(&dlci->port);
 	gsm_process_modem(tty, dlci, modem, cl);
 	if (tty) {
 		tty_wakeup(tty);
 		tty_kref_put(tty);
 	}
+	gsm_dlci_unget(dlci);
 	gsm_control_reply(gsm, CMD_MSC, data, clen);
 }
 
@@ -1746,15 +1757,26 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 	/* Invalid DLCI? */
 	params = (struct gsm_dlci_param_bits *)data;
 	addr = FIELD_GET(PN_D_FIELD_DLCI, params->d_bits);
-	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr]) {
+	if (addr == 0) {
+		gsm->open_error++;
+		return;
+	}
+
+	/*
+	 * Pin the addressed DLCI across the negotiation; see gsm_control_modem()
+	 * for why. Unlike MSC/RLS this DLCI need not be open, so pin first and
+	 * check the state afterwards.
+	 */
+	dlci = gsm_dlci_open_get(gsm, addr);
+	if (dlci == NULL) {
 		gsm->open_error++;
 		return;
 	}
-	dlci = gsm->dlci[addr];
 
 	/* Too late for parameter negotiation? */
 	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN) {
 		gsm->open_error++;
+		gsm_dlci_unget(dlci);
 		return;
 	}
 
@@ -1765,6 +1787,7 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 			pr_info("%s PN failed\n", __func__);
 		gsm->open_error++;
 		gsm_dlci_close(dlci);
+		gsm_dlci_unget(dlci);
 		return;
 	}
 
@@ -1785,6 +1808,7 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 			pr_info("%s PN in invalid state\n", __func__);
 		gsm->open_error++;
 	}
+	gsm_dlci_unget(dlci);
 }
 
 /**
@@ -1800,6 +1824,7 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 
 static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
 {
+	struct gsm_dlci *dlci;
 	struct tty_port *port;
 	unsigned int addr = 0;
 	u8 bits;
@@ -1816,15 +1841,21 @@ static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
 	if (len <= 0)
 		return;
 	addr >>= 1;
-	/* Closed port, or invalid ? */
-	if (addr == 0 || addr >= NUM_DLCI || gsm->dlci[addr] == NULL)
+	if (addr == 0)
 		return;
 	/* No error ? */
 	bits = *dp;
 	if ((bits & 1) == 0)
 		return;
 
-	port = &gsm->dlci[addr]->port;
+	/*
+	 * Pin the addressed DLCI across the dereference; see gsm_control_modem()
+	 * for why. gsm_cleanup_mux() can free it concurrently otherwise.
+	 */
+	dlci = gsm_dlci_open_get(gsm, addr);
+	if (dlci == NULL)
+		return;
+	port = &dlci->port;
 
 	if (bits & 2)
 		tty_insert_flip_char(port, 0, TTY_OVERRUN);
@@ -1835,6 +1866,7 @@ static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
 
 	tty_flip_buffer_push(port);
 
+	gsm_dlci_unget(dlci);
 	gsm_control_reply(gsm, CMD_RLS, data, clen);
 }
 
@@ -2694,7 +2726,14 @@ static void gsm_dlci_free(struct tty_port *port)
 	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
 
 	timer_shutdown_sync(&dlci->t1);
-	dlci->gsm->dlci[dlci->addr] = NULL;
+	/*
+	 * Only clear the slot if it still points at us. A receive worker can
+	 * pin this DLCI across gsm_queue() dispatch with dlci_get(); if a
+	 * concurrent GSMIOC_SETCONF tears the mux down and re-creates a DLCI
+	 * at the same address before the worker drops its reference, the slot
+	 * already refers to the new DLCI and must not be cleared here.
+	 */
+	cmpxchg(&dlci->gsm->dlci[dlci->addr], dlci, NULL);
 	kfifo_free(&dlci->fifo);
 	while ((dlci->skb = skb_dequeue(&dlci->skb_list)))
 		dev_kfree_skb(dlci->skb);
@@ -2711,6 +2750,42 @@ static inline void dlci_put(struct gsm_dlci *dlci)
 	tty_port_put(&dlci->port);
 }
 
+/**
+ *	gsm_dlci_open_get	-	look up a DLCI and pin it
+ *	@gsm: GSM mux
+ *	@addr: DLCI address
+ *
+ *	Look up gsm->dlci[addr] under gsm->mutex and, if present, take a
+ *	tty_port reference so it cannot be freed while a control-frame handler
+ *	dereferences it. A concurrent GSMIOC_SETCONF -> gsm_cleanup_mux()
+ *	releases DLCIs under the same mutex, so the lookup and the pin are
+ *	atomic with respect to the teardown. Returns the pinned DLCI or NULL.
+ *	The caller must release it with gsm_dlci_unget(). Callers that require
+ *	a particular state must check dlci->state themselves.
+ */
+static struct gsm_dlci *gsm_dlci_open_get(struct gsm_mux *gsm, unsigned int addr)
+{
+	struct gsm_dlci *dlci;
+
+	if (addr >= NUM_DLCI)
+		return NULL;
+	mutex_lock(&gsm->mutex);
+	dlci = gsm->dlci[addr];
+	if (dlci != NULL)
+		dlci_get(dlci);
+	mutex_unlock(&gsm->mutex);
+	return dlci;
+}
+
+/**
+ *	gsm_dlci_unget		-	drop a reference from gsm_dlci_open_get()
+ *	@dlci: DLCI to release
+ */
+static void gsm_dlci_unget(struct gsm_dlci *dlci)
+{
+	dlci_put(dlci);
+}
+
 static void gsm_destroy_network(struct gsm_dlci *dlci);
 
 /**
@@ -2839,11 +2914,23 @@ static void gsm_queue(struct gsm_mux *gsm)
 	case UI|PF:
 	case UIH:
 	case UIH|PF:
+		/*
+		 * Pin the DLCI so a concurrent gsm_cleanup_mux() cannot free
+		 * it while dlci->data() and the handlers it reaches use it.
+		 * The mutex is dropped before the dispatch, so the data path
+		 * is not serialised.
+		 */
+		mutex_lock(&gsm->mutex);
+		dlci = gsm->dlci[address];
 		if (dlci == NULL || dlci->state != DLCI_OPEN) {
+			mutex_unlock(&gsm->mutex);
 			gsm_response(gsm, address, DM|PF);
 			return;
 		}
+		dlci_get(dlci);
+		mutex_unlock(&gsm->mutex);
 		dlci->data(dlci, gsm->buf, gsm->len);
+		dlci_put(dlci);
 		break;
 	default:
 		goto invalid;
-- 
2.43.0

