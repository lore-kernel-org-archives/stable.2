Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794297357;
	b=EYP4oqsfw6XJ3wnbdB1j7MhWlnfgJ1lTDjrQiPvlyDZBy82Bh9AFedfKcCK9eSarh0nB
	 /yDB7t0og62zTB98kg9eLWsUZehOLIXgOMapp1YuV3diyFxFuKWdWMeGHKxiPbZXu/VkP
	 kS15TCPvAyu2Nlrsw4q2ept8unL5oxhhfvP4yj7ut8KJ79Fzytjo7yQxvuixnkAa5Gfzi
	 PrzLI1PWcciGv6UfTYyXHake+Zp2E1+JBKLChQQwhj2DSWE7GY9EPkxby5cd2pgQDJ6yp
	 cZ3jbLcSJWCvdfI/sRvqnNDYHL4gHreCUsg5BHgTlfZezZ5zujyB7RBY2GiZDdbWNHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794297357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BnNlY/us+vZG0qDZkwIWerdVJgfRG++NHY0uK525X08=;
	b=aYonCKHzC+B90xKG4rZwPS0x22IDFXaEE2lf18tzJj2Wc7dnh0fe3sjsWvhafuk4Kk6A
	 VH6O3OvTr2Id0rgp5FL2jN+TU8Unx7tDqfKalAm4zWGaGkSi5JIs3+eVY8gkGuTduS1bs
	 GV24cVCqzktNMyuOwIrXlA5xtcLnwY87YHtaY9VOUKuihm4+oEvHQuttH/xy4b+S47wNw
	 6EuiwemkfrldEXASGWqZiQz0Tn83CXYCYtWjtUIIZakKxLpJmtgOlmFeV/9UEP3wVALO6
	 XyjywGUIc3kAqm7VGJB3q1MyraHNp7Ya/sEv2yU058CavfRlHKIds9daZHxCrxE4kJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pF6zik9H;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCB606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8FCB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pF6zik9H
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso2164675e87.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 23:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794297355; x=1794902155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BnNlY/us+vZG0qDZkwIWerdVJgfRG++NHY0uK525X08=;
        b=pF6zik9HqBlnUxyUVNjaDYPeJJIaueDqrerGbI1ZJDvDiePLXsIlsxwVF4Mdu+w9Fa
         2Zfk0ByvlBzDBww56nSiYryLeVawKmGXACnac/KLGAWDq9w/nRCLpWLWYuN11rxmiJwu
         7WF9n7Ek1Sggu/UJtVZslhmOzRiYZHExgW8toGjDegiXJEfMN7Tij9XCqc4RYZtcaxv5
         Ib31OQB993JrhVIvj9uxVOEyty1sh5n0Cd5UuzrpzFkRg+MYsV/FxWcRyyzR1yHf0Qfd
         u108Mk80rcnC5yNkMBXmdVvsgMXwzHFKYXXxBvqq2rQzHENKBozwVbr/bPZdprjbN3N7
         CRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794297355; x=1794902155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BnNlY/us+vZG0qDZkwIWerdVJgfRG++NHY0uK525X08=;
        b=a78EryPLlUVaJI7GijDlYz4Zl6Le2rESnvqvaGdZ9Vg4vxy2onvEZ5AoaD2AL8DFEI
         jUANQpogrJFgzjB+/q276mgAs57IaOz1WZobE1Uyo5GaQie0QDHk2LG09ZCGns2QJ+6f
         UgDzEYH/vCrbJgZfZQMr++HXXIjjqbIOtv7wtmj8d7Im/LviW5qB23KaXRa3uXU5dU6w
         lCh0MM+Vdrlkptv/39STWXDkTGpEVw37QBYQmo8GVQjqWegpRE5ihbUkKMjqk0r0tmUr
         KdpESh0Oz5o7qBbMqHpp5MISgJBnyNCpCa9N0kyGRb2Gue1zolnFimlzz3EEee2lNKA7
         KYnQ==
X-Forwarded-Encrypted: i=1; AL+hErFJ+z93K3Len1uVUu0ELCxx4OLIJmmjjUA74PW7LjRTo531KuCpIlSTcX+zqxM5xpKwENH5V/4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9g78pPBpQt6Au5U8kZEQG2uwL4XYBDHnRcCYBPkgVW3OjYym8S
	H4gmgSz+aKqe221CBdBR6gKh0zYDOIaJTPk5lTLO31OqbvyfwmwncChn
X-Gm-Gg: AYBFou1h/bc5zyE/YqRjF8LleP/C2RRHhP86Lk7nhXhKlapSeRrNgiOmEjK886S31PL
	QsK89HEkmQf81sl5G9nabpzbShRyIGiSPJH6VknRIBgUim1WKjTCujDn2mdS6kfEwiEIKxMpsu7
	X5Dy2rBetDBFbhqEJxEMJ14KdA6MjPinzJlCgB1uxxZmkdy5eyTh185IJt/OP5jOA8nXBMxdrbJ
	lVGUmjI4oKoMf+iH2lajIRoVGkh0vcs3Avl2tuT6wTx/BlCuII0oyEpKHUd2he3mnxgQvLgVMLK
	GUzi9m64ri+XQnmPSYqi46CBsS4SfpK8lxwGQXfADdzMIwbEvejtfspaR0vLTyppJP2rXP552uo
	jNC7PqOAgwRUaasZ952g8CVFmP1Ob7QE6VBX/sThbd3llyzHd6to22Cc44sCnlu/Dx9oTK3XIY5
	ysYafvNlVn3a1rJcQIZLwPfN9EAH9TljQayj0n+sX+TY2+LOlkcjdKbqFtBXzngjH9xz6niRD4E
	GnZeFg6v1ot/Gto66N/pQY54ywbkLHq8pZXrQ+670p+R/XEUB7+yaSmgBNfTYJ6YUWmJqtp4TwM
	lMkq1xKb6m6P6KqyyHHEd/CG94ce6yuAnHtHdU3f0yfaeWMtdnYH0LsJoGSqAa042zHAZmcpvvs
	mdX6IZ1kEIfkUVYw4mWyeWBmvh08=
X-Received: by 2002:a05:6512:39c3:b0:5bb:7b64:340d with SMTP id 2adb3069b0e04-5c156ead9dfmr509262e87.28.1794297354505;
        Mon, 09 Nov 2026 23:55:54 -0800 (PST)
Received: from localhost.localdomain ([92.36.11.150])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157ced5basm249834e87.41.2026.11.09.23.55.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 23:55:54 -0800 (PST)
From: Artem Novikov <novart962@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tty: n_gsm: serialize mux configuration
Date: Tue, 10 Nov 2026 10:55:38 +0300
Message-ID: <20261110075538.51452-1-novart962@gmail.com>
X-Mailer: git-send-email 2.56.0
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

From: Artem Novikov <naa@amicon.ru>

Concurrent GSMIOC_SETCONF calls can both decide to restart the same mux.
gsm_cleanup_mux() releases gsm->mutex before gsm_config() calls
gsm_activate_mux(), so cleanup and activation from different calls can
overlap. The activation paths can register the same gsmtty minors, and
registration rollback can race with another registration or cleanup.
GSMIOC_SETCONF_EXT can restart the mux through the same paths.

A 5.10.246-syzkaller report shows a NULL dereference in the unregister
path:

 KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
 RIP: 0010:cdev_del+0x22/0x90 fs/char_dev.c:596
 Call Trace:
  tty_unregister_device drivers/tty/tty_io.c:3290 [inline]
  tty_unregister_device+0x117/0x1c0 drivers/tty/tty_io.c:3285
  gsm_register_devices drivers/tty/n_gsm.c:496 [inline]
  gsm_activate_mux drivers/tty/n_gsm.c:2286 [inline]
  gsm_config drivers/tty/n_gsm.c:2517 [inline]
  gsmld_ioctl+0x9b2/0xff0 drivers/tty/n_gsm.c:2829
  tty_ioctl+0x86a/0x16d0 drivers/tty/tty_io.c:2757
  vfs_ioctl fs/ioctl.c:48 [inline]
  __do_sys_ioctl fs/ioctl.c:753 [inline]
  __se_sys_ioctl fs/ioctl.c:739 [inline]
  __x64_sys_ioctl+0x19a/0x210 fs/ioctl.c:739
  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x67/0xd1

Current tty_unregister_device() checks for a NULL cdev. The overlapping
registration and cleanup operations in n_gsm remain unsynchronized.

Serialize the complete configuration transaction with a per-mux mutex.
Use the same mutex for GSMIOC_SETCONF_EXT, which can also restart the mux,
and for the corresponding configuration snapshots. Keep userspace copies
outside the critical sections. Use a separate mutex because
gsm_cleanup_mux() already acquires gsm->mutex.

Leave receive, transmit, timer and workqueue callbacks outside the new
lock so that control-channel shutdown can still make progress. Concurrent
configuration requests for one mux now wait for its reconfiguration to
finish; independent muxes retain separate locks.

Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
Cc: stable@vger.kernel.org
Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/tty/n_gsm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e55779ff0af2bb6328cf5f0ec70497107f1462e8..26e34e79b034a19e1b5dc1f4a87d56a74e884d56 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -273,6 +273,7 @@ struct gsm_mux {
 	struct tty_struct *tty;		/* The tty our ldisc is bound to */
 	spinlock_t lock;
 	struct mutex mutex;
+	struct mutex config_mutex;	/* Serializes mux configuration ioctls */
 	unsigned int num;
 	struct kref ref;
 
@@ -3219,6 +3220,7 @@ static void gsm_free_mux(struct gsm_mux *gsm)
 			break;
 		}
 	}
+	mutex_destroy(&gsm->config_mutex);
 	mutex_destroy(&gsm->mutex);
 	kfree(gsm->txframe);
 	kfree(gsm->buf);
@@ -3290,6 +3292,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	}
 	spin_lock_init(&gsm->lock);
 	mutex_init(&gsm->mutex);
+	mutex_init(&gsm->config_mutex);
 	kref_init(&gsm->ref);
 	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
 	INIT_LIST_HEAD(&gsm->tx_data_list);
@@ -3328,6 +3331,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	}
 	spin_unlock(&gsm_mux_lock);
 	if (i == MAX_MUX) {
+		mutex_destroy(&gsm->config_mutex);
 		mutex_destroy(&gsm->mutex);
 		kfree(gsm->txframe);
 		kfree(gsm->buf);
@@ -3341,6 +3345,8 @@ static struct gsm_mux *gsm_alloc_mux(void)
 static void gsm_copy_config_values(struct gsm_mux *gsm,
 				   struct gsm_config *c)
 {
+	guard(mutex)(&gsm->config_mutex);
+
 	memset(c, 0, sizeof(*c));
 	c->adaption = gsm->adaption;
 	c->encapsulation = gsm->encoding;
@@ -3384,6 +3390,10 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 		return -EINVAL;
 	if (c->i == 0 || c->i > 2)	/* UIH and UI only */
 		return -EINVAL;
+
+	/* gsm_cleanup_mux() takes gsm->mutex, so use a separate lock. */
+	guard(mutex)(&gsm->config_mutex);
+
 	/*
 	 * See what is needed for reconfiguration
 	 */
@@ -3451,6 +3461,8 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 static void gsm_copy_config_ext_values(struct gsm_mux *gsm,
 				       struct gsm_config_ext *ce)
 {
+	guard(mutex)(&gsm->config_mutex);
+
 	memset(ce, 0, sizeof(*ce));
 	ce->wait_config = gsm->wait_config ? 1 : 0;
 	ce->keep_alive = gsm->keep_alive;
@@ -3471,6 +3483,8 @@ static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *ce)
 	if (ce->flags & ~GSM_FL_RESTART)
 		return -EINVAL;
 
+	guard(mutex)(&gsm->config_mutex);
+
 	/* Requires care */
 	if (ce->flags & GSM_FL_RESTART)
 		need_restart = true;

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
