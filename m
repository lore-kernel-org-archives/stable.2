Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632826;
	b=yl2iHAKI74BDPUdd0lO4Ya6/XHNKNpJsPEJ4/lpnbikM91XAFdnOBy0xEcs/OB3GDDSz
	 2DG67Isnt59Hp2+rS+A6CAkmxKEAseL01PgIb7rQQSmtCBfvlR7Hm4l9S9Ld/RsOfYFX0
	 E/ML8dFP5mE46/GqHOoknatiX7TYHrDXHfLHIaWv4P2n3QH8KIUPZMJl+hvzZDG3je2GX
	 c+tJNKvuL+3s4esB6QZsFsdkUeA8i6qEczkfFnR0MTQYE73eUzJ4WMFKN9jGSgbKgIXPa
	 cKt0NPZdgkmEPYFb6Qm80ziKD3ULcAKOkK0mzEgpsfMpw7TDF7Mdk4kRTVdAltqo7Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632826;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=b0tmLXZBY761qj9gCg3aT/iWAmSW/9QbUZuBe8w4Uhw=;
	b=Yb9Ef+zeoeDVZQGKwOmjLK0KEydVDsm9Nwy/lKshP65vu0YEPHLhDXC8CNQ0ADcVGbHI
	 l8ehiBl11+rFlXBxnwXz5UfLfspI+GmdsrBwknLE2zbDnhMAwp8ZCo6SCwLe1SQHr++Ay
	 6bBm/yg8ELVvTjRSNYcWKXbacf/DUZMjDf5XsV6lLeGZYrY7P4XDj6nCcGdb+u6+m/6FF
	 3NGGV305jQg3V7MDApZNTDZ04SGgaSzNgCHmiCXff3S1qhUFwzX++b0sZORklJfPe9KRC
	 NP88FFKK2qL4l9eaw4Ad1MTE7p72oRBeYIjEjjH2LDePsj11fsMI++M3bd3oW7yN+Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F9FNwL8f;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87759606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87759606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F9FNwL8f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795632824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0tmLXZBY761qj9gCg3aT/iWAmSW/9QbUZuBe8w4Uhw=;
	b=F9FNwL8fYaPYAmOH0wd68zCnEc9OLMBqg41PibdcRRgJiRCqQktvaAmfOq/TVuloeTd3bw
	WOJCpZAsV/o3tRTxKm3WVXzPKmY6xbtnRlflTTW1oIz6ANEtACL+p6bxoc+RYB3mmYAYeY
	4jvy/rx4njb5o0WbRQcutbohCT2dCvM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-XidFufOUOEWYRGWrk-af-w-1; Wed,
 25 Nov 2026 18:53:38 +0000
X-MC-Unique: XidFufOUOEWYRGWrk-af-w-1
X-Mimecast-MFC-AGG-ID: XidFufOUOEWYRGWrk-af-w_1795632816
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9D061802140;
	Wed, 25 Nov 2026 18:53:35 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CD9C41F;
	Wed, 25 Nov 2026 18:53:33 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] gfs2: restart rename when a signal interrupts the glock wait
Date: Wed, 25 Nov 2026 19:53:29 +0100
Message-ID: <20261125185332.2549812-1-agruenba@redhat.com>
In-Reply-To: <20261125175007.3659558-1-hengyul@cs.unc.edu>
References: <20261125175007.3659558-1-hengyul@cs.unc.edu>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Wed, 25 Nov 2026 at 18:50, Hengyu Liang <hengyul@cs.unc.edu> wrote:
> Commit 11d763f0b0af ("gfs2: Retries missing in gfs2_{rename,exchange}")
> made gfs2_glock_async_wait() interruptible. It returns -EINTR when a
> signal is pending.
>
> However, -EINTR goes back to user space as it is, and the system call
> is not restarted. As of now, rename() and renameat2() on gfs2 fail
> with EINTR when a signal arrives while they wait for a glock, also
> when the signal only stops and continues the process.

This is indeed undesirable.

> The issue can be reproduced with:
>
>     mkfs.gfs2 -O -p lock_nolock -j 1 /dev/vda
>     mount /dev/vda /mnt
>     mkdir /mnt/a /mnt/b
>     for i in $(seq 12000); do echo > /mnt/a/$i; done
>     umount /mnt; mount /dev/vda /mnt
>     mv /mnt/a/* /mnt/b/ &
>     while kill -STOP $!; do kill -CONT $!; sleep 0.005; done
>
> Before commit 11d763f0b0af ("gfs2: Retries missing in
> gfs2_{rename,exchange}"), mv moves all 12000 files.
>
> After that commit, the result for 783 of the files is:
>
>     mv: cannot move '/mnt/a/10' to '/mnt/b/10': Interrupted system call
>
> With this patch, mv moves all 12000 files again.
>
> This patch will return -ERESTARTSYS instead, as gfs2_statfs_slow()
> does for its glock wait, so that the system call is restarted.

Why not make gfs2_glock_async_wait() non-interruptible instead?
Something like the below should work.

Thanks,
Andreas

---
 fs/gfs2/glock.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d22a088c66cd..3a49699ba9cb 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1284,9 +1284,9 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 		max_shift = BITS_PER_LONG - 2 - __fls(GL_GLOCK_HOLD_INCR);
 		incr = min(GL_GLOCK_HOLD_INCR << min(retries - 1, max_shift),
 			   10 * HZ - GL_GLOCK_MIN_HOLD);
-		schedule_timeout_interruptible(get_random_long() % (incr / 3));
-		if (signal_pending(current))
-			goto interrupted;
+		schedule_timeout_killable(get_random_long() % (incr / 3));
+		if (fatal_signal_pending(current))
+			return -EINTR;
 		timeout += (incr / 3) + get_random_long() % (incr / 3);
 	}
 
@@ -1300,21 +1300,17 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 			prepare_to_wait(waitq[i], wait + i, TASK_INTERRUPTIBLE);
 		if (!glocks_pending(num_gh, ghs))
 			break;
-		if (signal_pending(current)) {
+		ret = schedule_timeout_killable(ret);
+		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
 			break;
 		}
-		ret = schedule_timeout(ret);
 		if (!glocks_pending(num_gh, ghs))
 			break;
 		if (!ret) {
 			ret = -ESTALE; /* request timed out. */
 			break;
 		}
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
 	}
 	for (i = 0; i < num_gh; i++)
 		finish_wait(waitq[i], wait + i);
@@ -1344,10 +1340,6 @@ int gfs2_glock_async_wait(unsigned int num_gh, struct gfs2_holder *ghs,
 		}
 	}
 	return ret;
-
-interrupted:
-	ret = -EINTR;
-	goto out;
 }
 
 /**

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
-- 
2.56.1

