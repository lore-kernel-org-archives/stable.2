Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793729942;
	b=Okcz51E9fzV2s+IkVuEhCXWROEEaYnz0hPQtDt+sPAyimcF48zkTzQN1j7orRyVMb69G
	 XiLZjZLcl4F5iAaZd7aB3xClL6qZNA+yRKu5JkY7eDDaeV9B1VcGZ1E538hOVKtGTvWdi
	 JmZkSmi4HTNbwES4LPmtawcPGfzeRlbETMe+59M3gVE1MGcdcqRu2wU1tRY8ys2rE6zWt
	 V6IDlfx6s7y/TAlDP4HOpwIiHvUFZY7qiI+lwIJxRi7qLTMBwqkqsbOyAXPGiMkPuVVca
	 EDaIV1u6qZ7/kmN9O3sJHezLIh34dHu8Ok+5FNCbUst6OWJkARzh6MdovMjtdkn1tiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729942;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IhcsKsF4c4Bor6ZjDZme0cgeE1Ch/I0WodiVCA7SelM=;
	b=P4NXIHWaoRsIb1CLuIgg9Upm5vaaS6dQ60FAoWfR3QqEJXvIMW2xkKjpBmwl1VmtGcCb
	 v77VZA+BGEn/0DuScybunu/s9qG3gpTLUYZVlpm0ju3QHUbQmmwtvXqJGgtvtoMCOB1D8
	 B4OhrNbUY1O2KUDfqTfQYWCZwaDI7FtGizvxpOuwUyYrv2Q/iAllOVgOhCUd8J2wi9hlq
	 /hOnh1P+V9CF843y360f9JoHO6GCDg4Kjv2RBtHb+nZPJTrGsvOAJql0S/Vix5bqJd2ye
	 AIk+uHn1Hx4S+NZONvH9Zs+xcbcDCOIWibkaPH97sm3Tj9qxKbjRWQUe5ViKiWxaklg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByKGCdBK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78E606A328;
	Tue,  3 Nov 2026 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByKGCdBK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793729942;
	b=UxmtYHcH++KuSzSy0auBgxwHKEdqk0FWtQe9rwHW80190P3GCSRFhcmLGpQ40RUER2n0
	 7lxPvJDzlNoft4PZS06EA5nm1pOKgxGbapqFPpuINQC64KLVKoUhrVJ6Q/ZXF3BK+lKom
	 Pn8RRayw6K0GT7BTyPRtOkubiOfpFJcfym4H3PCSQ3SlOQEuXe8pSYWR8M8Npsh07YpP/
	 14k8BHp5VEniDy+5fw6otkzagOka01BsGysj8gQwCWOKzbCPyz9JM0YmU5fFsP29Qcdy5
	 AAIVwpM4dYonvTaBA2PqXP96XOR9/gKbcZ8J1fKwqjtxNnZjkCLWCt77CtiO3VWwGYw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793729942;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IhcsKsF4c4Bor6ZjDZme0cgeE1Ch/I0WodiVCA7SelM=;
	b=Dx2xB5A2CxOaBwGAWm6cIyQaaM2r5w7O8J53GP/gy7xakO2psTej83Z+e8gBfDL30OGZ
	 ZZUJgHe/tDgKNa2o1EtNhxKbDL5e5z2sdCRhx4hV7SMCcbqN5pb+9T+3PV6DBbueGe7rH
	 zn2ITGvuMPlPMZI2A/GrKXDvR0bPGDlVzscXRRjuSDPEs0KiQCc7s2SCKyE0iCOUqIJ1c
	 ct6mjWAUBs+nyDNeI1kwJb61R+aUdb4HMuuQEoGRKLNF286I0TpKo3MRRcKNekZbqvQMT
	 Sq9bzbv4YbvKpN0ggVauP09wZb55YPiYp/P0kwu+7f26o/fvCfwqEbdJTbIsjHluK+A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9BE2D1F000C1;
	Tue,  3 Nov 2026 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793729942;
	bh=IhcsKsF4c4Bor6ZjDZme0cgeE1Ch/I0WodiVCA7SelM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ByKGCdBKMXljtwAZqJi5rrb3qtF2/R7MVUIh2EI8Osf03XSxwhHjMLu7LYcqr421l
	 gSgowfrxS5REw+1hN9gFdsCKX6AsA6S0O9Q2IfMsSZJqeRs9B24b1lL9bHh0l/+GrQ
	 a+/uFHPgSWMx0ESjvukwUpJcW1j9wj/8qLqpxj4h+hs6ylQin4WyBx3CM35wz7mzTH
	 PzJK5RLKB2LjaI6fC5eSRDow/+9jRRu6P84hV7ajNv6UJQRiSl1UzrWAOE1RttYZI1
	 ozltsMuTixIPRjEVR1OupwlERBbCiskB08Ik4gjlgose7ZFRfFARzI8hvxjUy5/7Tb
	 PAf/2tc/oFs/g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0029346A51;
	Tue,  3 Nov 2026 18:19:00 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Tue, 03 Nov 2026 13:19:01 -0500
Subject: [PATCH] eventpoll: wake the next waiter when a woken waiter is
 killed
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-epoll-killed-waiter-v1-1-36e08c16b8a2@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqDMBRG4a3IHfdCorZCt1I6SPRXbw0qiS8Q9
 260w29wzk4BXhDonezksUiQoY/Qj4TK1vQNWKpoSlX60lpljHFwjjtxDhWvRiZ4NrktapspPPO
 CYjl61LLd18/37zDbH8rpWtFxnFu4jhp3AAAA
X-Change-ID: 20261103-epoll-killed-waiter-a4b7fb30e547
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, David Rientjes <rientjes@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, stable@vger.kernel.org, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793729940; l=2916;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=E8yisygosXMPs5dY2TbIReZZXoa4ZP3lxybfZT/nZno=;
 b=aPmE12Nzr0ZXZzOHh4n1Njq5Crq6XBaG7njn8SMGIP/JOD/Z9dC6jXRYiGqBowMARDfU0qXSn
 0Y0LS0MWt62BJgfbMUG/9E4thuifNVP9VcCUMfJ3FCiwqBw1O9hHd/d
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

Processes sharing an epoll instance can sleep forever while an event is
ready.  An event wakes only one waiter, which then wakes the next one in
ep_done_scan() if events are still ready.  Since commit c257a340ede0
("fs, epoll: short circuit fetching events if thread has been killed"),
ep_send_events() returns before the scan when the waiter has a fatal
signal.  If the woken waiter is killed before it runs, nobody wakes the
next one:

  Task A                     Task B                 Task C
  epoll_wait(ep, -1)         epoll_wait(ep, -1)
                                                    write(efd)
                                                      /* wakes A only */
                                                    kill(A, SIGKILL)
  ep_send_events()
    return -EINTR
      /* skips ep_done_scan() */
                             /* still asleep */

B then sleeps until another file on the instance becomes ready, if ever.
This can hit eg a pre-fork server whose worker gets OOM killed.  Commit
7fab29e35630 ("fs/epoll: restore waking from ep_done_scan()") fixed the
same kind of hang when the wakeup in ep_done_scan() was removed.

Keep the early return so that a dying task still doesn't take events
nobody will see, but wake the next waiter there if events are ready, as
ep_done_scan() would have.  With the fix, B gets the event.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 2s.

Fixes: c257a340ede0 ("fs, epoll: short circuit fetching events if thread has been killed")
Cc: stable@vger.kernel.org
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/epollkill.c
---
 fs/eventpoll.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7a32c70bf2ad..b959af04772c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2144,10 +2144,17 @@ static int ep_send_events(struct eventpoll *ep,
 	/*
 	 * Always short-circuit for fatal signals to allow threads to make a
 	 * timely exit without the chance of finding more events available and
-	 * fetching repeatedly.
+	 * fetching repeatedly. The wakeup that got us here may have been the
+	 * only one for the events on ->rdllist, so pass it on to the next
+	 * waiter, as ep_done_scan() would have.
 	 */
-	if (fatal_signal_pending(current))
+	if (fatal_signal_pending(current)) {
+		spin_lock_irq(&ep->lock);
+		if (!list_empty(&ep->rdllist))
+			wake_up(&ep->wq);
+		spin_unlock_irq(&ep->lock);
 		return -EINTR;
+	}
 
 	init_poll_funcptr(&pt, NULL);
 

---
base-commit: a522dd871024a0f065bfa7638afdb929607f58fc
change-id: 20261103-epoll-killed-waiter-a4b7fb30e547

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


