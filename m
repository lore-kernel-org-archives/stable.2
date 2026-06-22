Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894A27A12F;
	Mon, 22 Jun 2026 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139384; cv=none; b=Gm7uGPyxf9HPGFWYl0uC+C9k85a5zdRIfHX7A9w6Raid9Oe6TStPzJWMA9ew0bqMgiKAzBXNzmRzT1733OYz2l6JWYzS+BLrlzMPLyfEUScZOePJ3ZdmEymx8BcEkXXUlC3nOh2gWp8j8/cCr7zChM/WBPXOxmSWUn/XBhCblec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139384; c=relaxed/simple;
	bh=8WxJA3u1727kdZkX03oHBEPKTiW3RdUCl5GOAh53v9M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hWhaiogwQjrIc+w3hGcro8fJtGs2/3lw1g4QIEoSqquC8WanS5cwpUfEuIbpWey786sPCylYaaBXWAerZxM61lAsRhw+KXAvl/vDteC69+zAgGWXaqjmFJZiXUOkURcTasSHNebbQRGBwqfEO9au7wigKtDoFxmbH5z/bWPDfVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJyOx7FD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5/EV6RCw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJyOx7FD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5/EV6RCw"
Date: Mon, 22 Jun 2026 14:42:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782139381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZRvN3grLHdYgpJB1Xh1qMr/IVyYSjbqjYUSyEl3cvI=;
	b=WJyOx7FDarOTnWpUqfxmpsBM3bFH7857GIUTQyhnPxEgiqFCLT2QZIuDQ20gCnww3iGvF1
	xjaiE0lSRm2inC2oTHukgzqUQPKnhYHdqbRl5h/ueTYEUZVjv/Qt6dJP+7n+MGAIzIzt9B
	sjjSVJvC8hMgkXtZ3d5swgi1vvb+YvTwK4Pa17ixH+0BJktvBQcYiDBl4qDG6XR4QcqX4O
	Xg8WIBTTHl6Hn/e3m987Y9QjkxZyEmCieK1/VR1TFHClB0ZjSNUh9trdogZee4KrLt+euQ
	/ZngfdfkilYreO2xXjhhMZFh5VPD0fTP5u5BGX7JVWwEM19JuecBLj6S4N85nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782139381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZRvN3grLHdYgpJB1Xh1qMr/IVyYSjbqjYUSyEl3cvI=;
	b=5/EV6RCwdAOOPqp6jZ4wmtZAiRbOUqgboHDqJw7PKl5E/3gOezc9aPvxhkVkqEQ/ALYTc/
	CNJVMZjXKydlDkDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/urgent] debugobjects: Plug race against a concurrent OOM disable
Cc: syzbot+5e8dda76ca21dae314b6@syzkaller.appspotmail.com,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <874iiwlzlb.ffs@fw13>
References: <874iiwlzlb.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178213937887.2745857.7200288274976162334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     b81dde13cc163450dcb402dcc915ef13ba241e01
Gitweb:        https://git.kernel.org/tip/b81dde13cc163450dcb402dcc915ef13ba2=
41e01
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sun, 21 Jun 2026 16:47:44 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 22 Jun 2026 16:38:57 +02:00

debugobjects: Plug race against a concurrent OOM disable

syzbot reported a puzzling splat:

   WARNING: kernel/time/hrtimer.c:443 at stub_timer+0xa/0x20

stub_timer() is installed as timer callback function in
hrtimer_fixup_assert_init(), which is invoked when
debug_object_assert_init() can't find a shadow object. In that case debug
objects emits a warning about it before invoking the fixup.

Though the provided console log lacks this warning and instead has the
following a few seconds before the splat:

     ODEBUG: Out of memory. ODEBUG disabled

So the object was looked up in debug_object_assert_init() and the lookup
failed due a concurrent out of memory situation which disabled debug
objects and freed the shadow objects:

debug_object_assert_init()
        if (!debug_objects_enabled)
        	return;                         obj =3D alloc();
                				if (!obj) {
							// Out of memory
                                                	debug_objects_enabled =3D fa=
lse;
                                                        free_objects();
        obj =3D lookup_or_alloc();

        // The lookup failed because the other side
        // removed the objects, so this returns
        // an error code as the object in question
        // is not statically initialized

	if (!IS_ERR_OR_NULL(obj))
        	return;
        if (!obj) {
        	debug_oom();
                return;
        }

        print(...)
           if (!debug_objects_enabled)
                return;

        fixup(...)

The debug object splat is skipped because debug_objects_enabled is false,
but the fixup callback is invoked unconditionally, which makes the timer
disfunctional.

This is only a problem in debug_object_assert_init() and
debug_object_activate() as both have to handle statically initialized
objects and therefore must handle the error pointer return case
gracefully. All other places only handle the found/not found case and the
NULL pointer return is a signal for OOM. Otherwise they get a valid shadow
object.

Plug the hole by checking whether debug objects are still enabled before
invoking the print and fixup function in those two places.

Fixes: b84d435cc228 ("debugobjects: Extend to assert that an object is initia=
lized")
Reported-by: syzbot+5e8dda76ca21dae314b6@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/874iiwlzlb.ffs@fw13
---
 lib/debugobjects.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 6fb00e0..877f767 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -894,6 +894,14 @@ int debug_object_activate(void *addr, const struct debug=
_obj_descr *descr)
 	}
=20
 	raw_spin_unlock_irqrestore(&db->lock, flags);
+
+	/*
+	 * lookup_object_or_alloc() might have raced with a concurrent
+	 * allocation failure which disabled debug objects.
+	 */
+	if (!debug_objects_enabled)
+		return 0;
+
 	debug_print_object(&o, "activate");
=20
 	switch (o.state) {
@@ -1071,6 +1079,15 @@ void debug_object_assert_init(void *addr, const struct=
 debug_obj_descr *descr)
 		return;
 	}
=20
+	/*
+	 * lookup_object_or_alloc() might have raced with a concurrent
+	 * allocation failure which disabled debug objects. Don't run the fixup
+	 * as it might turn a valid object useless. See for example
+	 * hrtimer_fixup_assert_init().
+	 */
+	if (!debug_objects_enabled)
+		return;
+
 	/* Object is neither tracked nor static. It's not initialized. */
 	debug_print_object(&o, "assert_init");
 	debug_object_fixup(descr->fixup_assert_init, addr, ODEBUG_STATE_NOTAVAILABL=
E);
