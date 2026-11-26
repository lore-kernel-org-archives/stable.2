Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661121;
	b=AXAhm4xKZBO/brv61FTyJglEHttF+HaMgO+sjjrk2TeGYpqlNivDiCs9jLvOquxvnaXK
	 g3Db+Sz3nc+ho86KXM1NK97Vvka4DTc+TSlw19eZHjfF0c0eOEaX8Pmi0ZKIRaQREvsAb
	 AazzA+sjsUoYuX/Q7Nl/SSJGu3xzc37t0uvr4hgbKDjdh7kkjJOrt52K3epb2b97BLqaG
	 kb4zr29myRJJDhRmeaxw/OnkJDw6EVp9pqg+fyhctL8qmG3FW+I/fqB7cUkCxhD6MCaCH
	 ecOMoJLk4UUvQ6DdlK+hdrouHXnGFclP1RIG7rtNCGdFo1KsYLri4LKtfm4VLDc3pWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=BVVtxRQR2c1odrFLqnW3DKGczk+oTc7j4hOWGW8oEfo=;
	b=BLmIfQXurIlTsGupKlXpcrz+u7s6cWJjFvOCn7qm5zW0yKq6olmiMxXIkAk4SFurrjed
	 fl96M5lP0Xxa8ioCW45a/hPSHi+DBmLb9EFywjRqFMLXzl3a8d/UZ+qCWbNV3/4bSQdKN
	 z4dr3ElawVyjtT6qk+eGaYUjeLA7iLuzPZ4sfTPQHRTr6x34HsXbUCk4co7N3Z+jsC5J/
	 wfy3oSEwyrwzy3HSY+CxngAvCs5MSz+DtWk/kS9ZmcYwoE8Waeje75hfUbXN4Lq227RHV
	 5Hbuk5uBsu6d2aTrkZDbVOvp9OqktI9n6iPHwdaaFrnYd45VbN3SLF+7UeVdt+wBiWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=LVP9T3D1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E5606A6B5
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 02:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A57E5606A6B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=LVP9T3D1
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67daffde88dso3850181d50.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:45:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661120; cv=none;
        d=google.com; s=arc-20260327;
        b=kip3IwbFIFNsGzYyot65y63CEAvP3qMyfsQTTKjRh3p7xJ8t5WRm0JS6yM50/0qdVB
         Cg1PAdHV/0ca2fVN2lE7IhL2xX289Ti27RlUaJe84JUF5EKhHHxjYezta2U3ucC72f7w
         BVCdMF082B/6kP1EgVZ9GYd/hpvDHwFXQsIsGF5+Fx8UXdlDbzx0+wR4u+zZg5Urgt2L
         XgL2of4L+zNgAoV7KZowYWkyrlHMPgHyg4wm3FeI7szeKNrCM2FINOa7jTMWcGig+FdJ
         Rwsp+mgd65/vL1PaN2SJAu0hWa9K9LtuUgYvEds5oPwVN67UyKfzuTT+fPVYzik+lCz+
         II3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BVVtxRQR2c1odrFLqnW3DKGczk+oTc7j4hOWGW8oEfo=;
        fh=AIrBuAclZrkW2rl1AKI6uFjmcQF/pUVlMaxQw55Yq2o=;
        b=qZr0/yMJ8RWQMBfS8LBhJCMKLVF8y/7cRaNYpLJn2Xxx70sr64OT+kKCNQUpe5S/vk
         E06r7vFr5C7YT9BlpuFzEldLMyZiJEYPVcjTwrxlgiVxo+xHYPrRPpEv6usgjFQt6gpd
         nnerTu+WRjFtt7DmosMOeAA/ryCQQ49XdxU4+9BWhMKBsKiY1XSbShGRYm4CRxN1w1wh
         0/vXXKQ+aMFLapNnxjvC2ghiHAGr+YM5intSZy/2ChSDvzXrHh4TzipvG7ujTTXByFlw
         VQM5SIQMyN0XNFfkKeMUAUjTbO3YzAracNIqiR6KWkDeE0n+rGvX5511AuBaxJ/aTS/a
         ApeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661120; x=1796265920; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BVVtxRQR2c1odrFLqnW3DKGczk+oTc7j4hOWGW8oEfo=;
        b=LVP9T3D1P2CORJjI2mzNo2E8aivFJEsj5ZCMu0hVJFF+WOXBJZGvTJGmLusLXs1jHy
         Y2Zfk93H3xYQtAjJACTq9Io604Ujq8OwQOncjeyIpR7aUUC5HFeYjxK9Dfw5xmYpa2XQ
         TcHUeU9LG6VF4DrplhkVa0dAd/XU00pcIk4CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661120; x=1796265920;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BVVtxRQR2c1odrFLqnW3DKGczk+oTc7j4hOWGW8oEfo=;
        b=K8Dc2hlnCAuMsUhCEk39Txg3KL0oohVXGJr7Vva/MlhKK2omd1PbJJI+vbLl3hX6o9
         BRlTayyoMludsRrMmra89T0eqg9QXQhA50ZiCtf8l76yZKN9rr8B1l4DQTj8dSCXYWTG
         mLaNBzshnbmPxsjhZPckPTN4a+AIq/oG33Swwv7YA4axXnlRc9dNlqOq78MbX0eO2ESH
         Jac4ZkzwWscIPQHe671Nlx+wX6E/JpHnlAKGkXoCLZhLXcUvRcWrS1AnqgO3Rk9zHYwy
         4RxKI0krSagZMJY7xCjl54pJobRdHj8USFTJU1Ih2O10b5RIuasvkZjEhvHxEMRHSmAI
         YWoQ==
X-Gm-Message-State: APuU4Z8R/JAJhfE2davI7cO6v4nQsnMhQEYjOx0U7r22Hnr/hHOjwrd5
	NOSwp00w2+lyYE25H6E/UrgsSOAzSCHznBU8uk4OsRMoqfUKjPcpdDJ8KGNWOu2InvZ+jydVc8B
	i2TcTF8y4kRIofIkEDnjWh/3ZbdIHN7uujP/wO1RKt8As/2M93r3rfnY=
X-Gm-Gg: AZFdTZe0Y+YugONSl2hGHpaxbrdOJHxmS/F9fwRxnanLL2hLQMHZcPdPC4GM5Yj9rlx
	tjw9B6XAnZjWDowCK52NZVP5BrMskwlaYN+JKojOtRxFA0JgGuen3FIJD/DXNPWmtVMXjBhXnPs
	5ripa30K+mOPtJP/V1vpkSAgsNakN3Y/Dz0dY/j2ax7mQt4BXxzdb/gVunJvb5ZP2BqoPZl9R95
	J4nnBAb+Q5PeEVoOQ6R9Rzy4NBSik4C3WkAc99m/CdiFdp05hjjRDtgYfaqsUgqbmY4zheozPcV
	gyO0/QpyOi1eQLLnwgZEwV4r5oZtmSGStUnv7YFY6Jz4sl2BAnAmIywGVvJskAL3RY05yZy4a6a
	v/Ro2m0eSTE0FSI2fpjaxGRi6YlRG7cG5R7kO+UnN88HwB5rHLdc2IbCreAiSSPYHun4rvS3T2G
	sdWXfgECVAWTlbT59EDzb3SHWvOyeMIiyZ928VIFGqr78xJ7MKDkVAB95wdwQfer6+CX3rneVLh
	Z8CINOQ/Kc50GlTopDTx0NWo23E+gxkfHPE
X-Received: by 2002:a05:690e:400f:b0:67d:ac2c:4002 with SMTP id
 956f58d0204a3-67df4426038mr7064542d50.52.1795661119519; Wed, 25 Nov 2026
 18:45:19 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 26 Nov 2026 02:45:18 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Thu, 26 Nov 2026 02:45:18 +0000
X-Gm-Features: Aa3M54o1btClIfGPqi_HHsbGj1g4M5yJF-L-0_Xbeo7jA-sEsC8ThBYnsY2FlOk
Message-ID: <CAFaZ9epucF3AKE=B3mB9JD1sAcorBQDsgre_Wnv8Sati=tomPg@mail.gmail.com>
Subject: [PATCH 5.15.y 2/2] pid_namespace: prevent TIF_NOTIFY_SIGNAL from
 interrupting the reaper
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Christian Brauner <brauner@kernel.org>

commit 5c0985dd3c32fc2bbd0e8beaf13cf52cd97376a2 upstream.

Since commit 7fea700e04bd ("zap_pid_ns_processes: clear
TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING") zap_pid_ns_processes()
clears TIF_NOTIFY_SIGNAL before every kernel_wait4() call. Otherwise
kernel_wait4() doesn't sleep and returns -ERESTARTSYS if
signal_pending() is true and the reaper busy-waits.

But clearing TIF_NOTIFY_SIGNAL doesn't fix it. It can get raised again.
For example, klp_send_signals() sets it raw against any task that hasn't
transitioned yet. And it keeps sending it until the livepatch finishes.

The sleep loop waiting for pid_allocated to drop has the same problem
and it doesn't even clear anything. So a schedule() in
TASK_INTERRUPTIBLE returns immediately.

Use a no_notify_signal guard. signal_pending() will ignore
TIF_NOTIFY_SIGNAL and the pid namespace reaper sleeps until a child
exits or free_pid() wakes it.

Link: https://patch.msgid.link/20260824-work-tif_notify_signal-v2-5-6609e42b3157@kernel.org
Fixes: 7fea700e04bd ("zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL
along with TIF_SIGPENDING")
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ adapted to 5.15: explicit save/restore instead of guard() to avoid a
declaration-after-statement warning ]
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 40b011f88067..d3e860d3678a 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -167,6 +167,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 {
 	int nr;
 	int rc;
+	unsigned int no_notify_flags;
 	struct task_struct *task, *me = current;
 	int init_pids = thread_group_leader(me) ? 1 : 2;
 	struct pid *pid;
@@ -212,9 +213,10 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * kernel_wait4() will also block until our children traced from the
 	 * parent namespace are detached and become EXIT_DEAD.
 	 */
+	/* Task work must not busy-loop the reaper, see signal_pending(). */
+	no_notify_flags = no_notify_signal_save();
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
-		clear_thread_flag(TIF_NOTIFY_SIGNAL);
 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);

@@ -270,6 +272,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 		current->signal->group_exit_code = pid_ns->reboot;

 	acct_exit_ns(pid_ns);
+	no_notify_signal_restore(no_notify_flags);
 	return;
 }

-- 
2.43.0
