Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795739713;
	b=GpGpn5+2QM7SFippEerWCrMS1vOKXqiKjBmUQrH8ctMzvf52D1CbYrrmXwTBeng8U0rU
	 F6+EpwLjTpbOT+XEK3GQCxRFEvcuDzmXNgIPT7aArXXNzsijHM8s+BsMBzxcQ5S9WFalY
	 UuwIMQV7Rj7g+RB7Kb4h90vfuoBtaR2cdeJY2DZX523/z7c0IP2E1JDEOgKHIzqJvoz4f
	 8VjLpQX0VeIOusYMx9xXb1ni0KSa9pXCbeBnhIhI3JvBndQLe6Tm68hkR0Xx/NK95wzC9
	 HV+/udM4oha4oP/peHtgu4/AnDJbg3FmY7O+Nfv4xsgoTdTpagjK/isSyDhpwhx8jHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795739713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=3OPfHOQKezyfH22MUdFSqfCGWM0ieUYy/o1MAmiR0LI=;
	b=zVp2Hs13cF0yf9ZJ6tig8r9EHTuqMa5+qwl1IiNmUfLzgGdvB4HubSk3RaQzQ1HDrYbN
	 sDmTJPrBVGSfmP/Gboaup4W4DydMMBN6fv810VwSck8+GfOj5qNZpN8mjPRQSsMwbpiJG
	 PKuSPKO6w8lUjkslA553/jcZ80s/wYjVL+Q6sEw5WO8lHOwYxzQ+sC49GM8AJ5V6hSLbZ
	 lqOUuCjZS/wFNdKkxiHRPq+L4cVDX9KqOCbwxvIUQtWakFAHjlmbVU2EUTLz4prRidE1q
	 wECGBo8gO2JyUB5ByB3bLE82acUFGm/LnUm3bhiHDd3KjjGY4sxz6Ni94jRNjauNrYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=PJmHnSzU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D7B606A335
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56D7B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=PJmHnSzU
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b8815693e2so8592742a12.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:35:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795739710; cv=none;
        d=google.com; s=arc-20260327;
        b=kVq12TGkQuhr4CQJd7RZrxCaK9HowelOnHhaSA1IxqwXbOs1y/sOGpsVmGswvqoYkl
         wdUgLd8PnXrwEyPqUxqkTSlG87cicn0XP7qfREYZd3ghsmCYZyYWY7Lpl4Nd+x4uZE66
         H0dpnqT2zd1uxSXPraLwdLVfp681sBErfGviaXfdRFzproqICwa0brGsUQ9XewyXHESn
         l/EONWogrm4GuQbNA8uTHZIlOZi08xbFEtthNqzV1OqinzFOr6GcFDCncTltIN6EIXte
         mmwbLFpV2LB2QiSi1m+Nx+o7g3Nnj8t6bgHWnpcEKKSOZl1KsljX6idp396CxRNJm2SO
         7/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3OPfHOQKezyfH22MUdFSqfCGWM0ieUYy/o1MAmiR0LI=;
        fh=LZsNAqT3IXOv8a/QJncmfaGVd5TotLfDt6VOEnFzYW8=;
        b=CljFdDJ4PbKrqS5v1zCyX8mWyAc6yHq4Wx53/ApLQGuFbZMJWtaQzoyhLfje9IlXIc
         oSZ+g/MoM7bRi2+YYcl2ZyWUYuVweaSNiXgoSRNH28t+2wa/LBp11GdFs341hSnwH9sW
         1XszAszg0DqvHTzWv9EoAUYj0z/don7T2GsECreX+VxOHfAqApm5TIC8mzNoi2GyXNnV
         UlwB2mtuLULbuBCSPBtmOID8z+Tv9FycNr+smqJE/SQEi8a8efncxa6Djp8/OFoYeP5g
         rgGfwaJy3tTLQq9BgWAi5uBpjtniPkunoeHfPPay1pwKZPzrr4bsGYeSd7oSkv0pwZqv
         mWmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1795739710; x=1796344510; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3OPfHOQKezyfH22MUdFSqfCGWM0ieUYy/o1MAmiR0LI=;
        b=PJmHnSzU6XtO6FIvEAIjv2s9ZHkuxwGCypQreOL5hKKBzDXLYw8nkeTiMqYNUwuHEH
         toYhvei1VRUvL2ut1CXSO341YJ6CM7bMx2VlxDNPDLRnzPjqxmjTTpW43Ghnh1eadgjv
         uxYQLbhifjHf2oksPwb0L6svFJ4nCBLDYa9gBp7YEesWgasxl1N6aIyOG6cItlDhB//Z
         UVPZkOjPLZuWbyro0GnX8XrBrePhIRYimmxEVwWzgTP18SiIRnwmQbn5JwyjOnaZiXOE
         JC9NZP9knC0wg1dSLJuhj8HOyHTEZynahu4MRcYR9smFsqi/j89kyAtYEnYvY3b2Hh7L
         bz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795739710; x=1796344510;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3OPfHOQKezyfH22MUdFSqfCGWM0ieUYy/o1MAmiR0LI=;
        b=NJ5HgnV8xutxxTvqxB+wICMXNqfS7C+Dp6tahCTCEelQPvGOyR7+yvTYJDidWOwLUC
         ZgCne3qDk6nzO3CM0lrtS9GyxOfBWrLbwxCdEQRnvQEFO3HGnc/W8x4JdHyvNo40pXQH
         0XrA50TDwT/zBDk9u89atHYIicT93F8zEF6qBQLaCuOJ9HQuxCr1JXBeMdDT5/4wAH8A
         Hm4VDy09KTmiXTd6cvDiol9Rzjv+WIWhD7aNyU2O5DobZw4Pt4VQ8FpqGrSLyBkvgkSH
         VpeX8vJoNzojLdXKJimZq7Rn6HkKV1T7vSJtv6TmGVZFwF0TQBLeVEe5xuw0e+U6jb3y
         bzcQ==
X-Forwarded-Encrypted: i=1; AL+hErGCsCJ7ll296ptC4UxqbkvlCrcz6vWSAwhLR4C/o3FGyK5Otsq/u8Qzt2JPBBVKIRDFN3XXACI=@vger.kernel.org
X-Gm-Message-State: APuU4Z88jwVTXMW0pccnV+4b9SZqRLpGX5AdwhIkJGZ6NGCDAUa414PA
	4dMBeXu2+twtST043h9SvtA7SMSJ5gYM1awupVlzcSOTBAHWOuDu2s4WVRYNUCEn2zNUeF2cwHA
	CvaYMEr+EaB0pUpA7YyHZU1DlRc8BDHH+SQbyW7ANrPuM7mPJOboeV7cZzQ==
X-Gm-Gg: AZFdTZdIoRdYb9crdXHS//yyQVdvYF9dM7hmMfR7NzjXpOlyG20Er8xXDENCorqGWZ9
	XVBQxAf9uCLWUVdc6gMUCG+l56rsEfManjbah1qakQmd9aJYJmg3Ag3HKYo3xy7S5S89XuDEiBF
	lU3nEhil8OPXbvyXVQQMmEjJ0c+/dopX3OG//JPI1ZlgRdAx2MG8mSgg4fUSwZrohSc7tKNr+kj
	u2WFwbTKWXM3wDAySeQPIS2vTcEcwGFPZMxZUoqom8mscs9hK+DbQ3jbtO0VI/UMWJU8GCRkBcq
	emPimLtcQx9UlasfrPGTXji8x84zSW9/0ieuuFxQafC9qNaGKyE7Ky5Lsjq6dyxBnUmjTQIBdsA
	3I4fOxSgxRgr4GSw5qRKk12njEAdaDlJyE7ocsmxezxc/ig==
X-Received: by 2002:aa7:df18:0:b0:6b9:c43d:88f with SMTP id
 4fb4d7f45d1cf-6ba37d5c69dmr12692955a12.9.1795739710360; Thu, 26 Nov 2026
 16:35:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126032756.265377-2-kj2864@nyu.edu>
In-Reply-To: <20261126032756.265377-2-kj2864@nyu.edu>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 27 Nov 2026 02:34:59 +0200
X-Gm-Features: Aa3M54ptrl_WV_O1NFAZHq5_aaKdq5Wou8KIWA-tM-jRnpleYlFaLeK88Z4UKcg
Message-ID: <CAOJNxR+mG_fn1Ru0dpzSeWVMwONBF6NYcfoeWTtP90AQp0QBvg@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: Use unsigned types for snapshot split counts
To: Kaho Jiang <kj2864@nyu.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	co+408fcc361565713f@bugs.sh
Content-Type: text/plain; charset="UTF-8"

Hi Kaho,

On 11/26/26 11:27, Kaho Jiang wrote:
> ceph_handle_snap() stores the unsigned 32-bit split counts from the
> message header in signed integers. Values with the high bit set become
> negative and, on 64-bit systems, cause the subsequent pointer arithmetic
> to move backwards before the message buffer.

[...]

> Use u32 for both counts and validate both split arrays against the
> remaining message buffer before advancing the decode pointer. Use
> size_mul() to detect multiplication overflow on 32-bit systems, and
> ceph_decode_skip_n() for checked skips in the non-split branch.

This changelog only describes the first half of the patch.  v4 also
moves the blocklist out of ceph_update_snap_trace(), adds a fence work
and changes handle_reply() and the umount path, and none of that is
mentioned (the subject still says "Use unsigned types ...").

Could you split it into two patches?  The u32 + bounds checks are a
small stable fix on their own; the fence rework is not ready yet, see
below.

I tested v4 on a KASAN + lockdep kernel with a 2-active-MDS vstart
cluster, using a test-only module param patch that corrupts incoming
snap messages: num_split_inos/num_split_realms forced to 0xfffffff0,
or the snap trace in a CLIENT_SNAP, in a reply snapblob or in a cap
IMPORT truncated to 4 bytes.  Same injection on the base tree and on
v4, mount_timeout=20 unless said otherwise.

v4 no longer applies to the testing branch, since 11add64882a2 ("ceph:
remove BLOG instrumentation") removed the ceph_blog_exit() context
lines.  The conflicts are trivial; I tested it rebased onto testing
3f90412e989c.

> Fixes: 963b61eb041e ("ceph: snapshot management")
> Cc: stable@vger.kernel.org
> Reported-by: co+408fcc361565713f@bugs.sh
> Assisted-by: LLM
> Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> ---
>  fs/ceph/mds_client.c | 34 +++++++++++++++++++++++++++++++++-
>  fs/ceph/mds_client.h |  3 +++
>  fs/ceph/snap.c       | 33 +++++++++++----------------------
>  3 files changed, 47 insertions(+), 23 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 15df9d22008d..4b416fa2ad1a 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
[...]
> @@ -4435,7 +4436,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
>
>       /* Defer closing the sessions after s_mutex lock being released */
>       if (close_sessions)
> -             ceph_mdsc_close_sessions(mdsc);
> +             ceph_mdsc_schedule_snap_fence(mdsc);

With this change a corrupt reply snapblob deadlocks the msgr worker
and umount.

Earlier in handle_reply() the target inode is looked up/created with
ceph_get_inode() before the snapblob is parsed, and it is only
unlocked later in ceph_fill_trace().  When ceph_update_snap_trace()
fails we jump to out_err and the inode stays hashed in I_NEW.  That
part is old; on the base tree it shows up at umount as

  WARNING: fs/inode.c:1987 at iput_final+0x626/0x870, CPU#17: umount/5384

On the base tree the sessions are torn down synchronously right here in
the same msgr worker, which is most likely why no later message looks
the inode up.  With the deferred fence the sessions stay open for
another mount_timeout, a cap message for that inode arrives, and the
msgr worker waits on the I_NEW inode forever; umount then blocks
flushing the msgr workqueue:

  kworker/10:2 (ceph-msgr):
   wait_on_new_inode+0x1d1/0x3f0
   ilookup5+0x18f/0x1c0
   ceph_handle_caps+0x8a6/0x23c0 [ceph]
   mds_dispatch+0x21d/0x490 [ceph]
  umount:
   __flush_workqueue+0x3ad/0x10c0
   ceph_mdsc_pre_umount+0x1c3/0x410 [ceph]
   ceph_kill_sb+0x100/0x840 [ceph]

With a corrupt snapblob in the reply to a create in a snapshotted
directory, v4 hung like this in 4 out of 4 runs and the base tree in
0 out of 4.  The out_err path needs to discard_new_inode() the target
inode (or the snapblob has to be parsed before ceph_get_inode()),
whatever the fence ends up looking like.

[...]
> +static void ceph_mdsc_snap_fence_workfn(struct work_struct *work)
> +{
> +     struct ceph_mds_client *mdsc =
> +             container_of(work, struct ceph_mds_client, snap_fence_work);
> +     struct ceph_client *cl = mdsc->fsc->client;
> +     int ret;
> +
> +     ret = ceph_monc_blocklist_add(&cl->monc, &cl->msgr.inst.addr);
> +     if (ret)
> +             pr_err_client(cl, "failed to blocklist %s: %d\n",
> +                           ceph_pr_addr(&cl->msgr.inst.addr), ret);

The "was blocklisted, do remount to continue" warning that
ceph_update_snap_trace() used to print is gone.  The base tree prints

  ceph: ... ceph_update_snap_trace <addr> was blocklisted,
  do remount to continue after corrupted snaptrace is fixed

and with v4 nothing tells the admin why the mount stopped working.
Please print it here when the blocklist succeeds.

> +
> +     ceph_mdsc_close_sessions(mdsc);

Two problems here.

First, the client has just been blocklisted, so the MDSs never ack the
REQUEST_CLOSE and ceph_mdsc_close_sessions() always waits the full
mount_timeout (20.3 s in every run).  With mount_timeout=0 it waits
forever.  The base tree does the same thing in the ceph-msgr worker
(verified: kworker/23:1+ceph-msgr stuck in ceph_mdsc_close_sessions()
<- ceph_handle_snap()).  v4 frees the msgr worker, but the wait now
blocks umount instead, see ceph_mdsc_destroy() below.

With a non-zero mount_timeout, ceph_kill_sb() stops waiting for the
stopping blocker after mount_timeout ("umount timed out") and runs its
own ceph_mdsc_close_sessions() while this one is still running, so the
two teardowns overlap:

  [1456.265977] ceph: INJ close_sessions begin comm=kworker/u199:5 pid=10748
  [1476.083255] ceph: ... umount timed out, 0
  [1476.083614] ceph: INJ close_sessions begin comm=umount pid=14578
  [1476.084088] ceph: INJ close_sessions end comm=umount pid=14578 took 1 ms
  [1476.594193] ceph: INJ close_sessions end comm=kworker/u199:5
pid=10748 took 20329 ms

(the INJ lines come from my test patch.)

Second, ceph_mdsc_close_sessions() is the umount teardown, not a fence.
After the wait it unregisters the sessions and calls
ceph_cleanup_snapid_map() and ceph_cleanup_global_and_empty_realms()
while the mount is still alive and snapshot inodes still hold their
snapid maps.  Every run with a snapshot inode cached hit:

  WARNING: snap.c:1365 at ceph_cleanup_snapid_map+0x40e/0x660 [ceph]
   ceph_mdsc_close_sessions+0x5cf/0x739 [ceph]
   ceph_mdsc_snap_fence_workfn.cold+0x8/0x23 [ceph]
  ...
  BUG: KASAN: slab-use-after-free in atomic_dec_and_lock+0x1b/0xa0
  Write of size 4 at addr ffff888107909ba8 by task umount/7518
   ceph_put_snapid_map+0x36/0x2d0 [ceph]
   ceph_evict_inode+0x59c/0x9a0 [ceph]
  Allocated by: ceph_get_snapid_map <- ceph_fill_inode <- handle_reply
  Freed by:     ceph_cleanup_snapid_map <- ceph_mdsc_close_sessions
                <- ceph_mdsc_snap_fence_workfn

This one is old too (the base tree hits the same UAF through the
synchronous call), but moving the call into a work doesn't fix it, and
Alex's point about retaining the required references until the
deferred cleanup finishes applies here.  The teardown also leaves
in-flight MDS requests waiting: on the base tree a snapshot mkdir that
raced with the corrupt CLIENT_SNAP sat in ceph_mdsc_wait_request()
until it was killed.

So I don't think ceph_mdsc_close_sessions() belongs in this path.
CEPH_MOUNT_FENCE_IO is already set (new writes and creates got -EIO in
all my runs); after the blocklist this should fail the pending MDS
requests with -EIO and drop each session's caps, as the
force-umount/session-reject paths do, without the snapid map and realm
cleanup and without waiting for a close ack that can't come.  The full
teardown should stay in umount.

> +     ceph_dec_osd_stopping_blocker(mdsc);
> +}
[...]
> @@ -7120,6 +7151,7 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
>       wake_up_all(&mdsc->reset_state.blocked_wq);
>
>       cancel_work_sync(&mdsc->reset_work);
> +     cancel_work_sync(&mdsc->snap_fence_work);

With mount_timeout=0 this never returns, because the work is stuck in
ceph_mdsc_close_sessions() above, and umount hangs in D state until the
box is reset:

  kworker/u110:5+events_unbound:
   ceph_mdsc_close_sessions+0x432/0x739 [ceph]
   ceph_mdsc_snap_fence_workfn.cold+0x8/0x23 [ceph]
  umount:
   cancel_work_sync+0x81/0xa0
   ceph_mdsc_destroy+0x200/0x850 [ceph]
   destroy_fs_client+0x127/0x3b0 [ceph]
   ceph_kill_sb+0x2e6/0x840 [ceph]

umount must not wait on this work without a bound.

>       ceph_mdsc_stop(mdsc);
[...]
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index e03d89db61fe..968486b0c2d4 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
[...]
> @@ -924,22 +922,8 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
>        * When receiving a corrupted snap trace we don't know what
>        * exactly has happened in MDS side. And we shouldn't continue
>        * writing to OSD, which may corrupt the snapshot contents.
> -      *
> -      * Just try to blocklist this kclient and then this kclient
> -      * must be remounted to continue after the corrupted metadata
> -      * fixed in the MDS side.
>        */
>       WRITE_ONCE(mdsc->fsc->mount_state, CEPH_MOUNT_FENCE_IO);
> -     ret = ceph_monc_blocklist_add(&client->monc, &client->msgr.inst.addr);
> -     if (ret)
> -             pr_err_client(cl, "failed to blocklist %s: %d\n",
> -                           ceph_pr_addr(&client->msgr.inst.addr), ret);

ceph_update_snap_trace() has a third caller that this patch doesn't
convert: ceph_handle_caps() for CEPH_CAP_OP_IMPORT still calls
ceph_mdsc_close_sessions() directly.  So with this removal a corrupt
snap trace in a cap IMPORT fences the client but no longer blocklists
it, and the close still runs (and waits) in the msgr worker:

  base:  blocklisted=1, close_sessions in kworker/10:1 (ceph-msgr), 20105 ms
  v4:    blocklisted=0, close_sessions in kworker/4:2  (ceph-msgr), 20082 ms

[...]
> @@ -1079,10 +1063,12 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
>                * child.
>                */
>               split_inos = p;
> +             ceph_decode_need(&p, e, size_mul(num_split_inos, sizeof(u64)), fail);
>               p += sizeof(u64) * num_split_inos;
>               split_realms = p;
> +             ceph_decode_need(&p, e, size_mul(num_split_realms, sizeof(u64)), fail);

These checks are good.  On the base tree, forcing either count to
0xfffffff0 reproduces your report on both the SPLIT and the non-split
paths:

  BUG: KASAN: slab-out-of-bounds in ceph_update_snap_trace+0xe11/0x12a0 [ceph]
  Read of size 8 at addr ffff88816738cff8 by task kworker/17:0/5385
   ceph_update_snap_trace+0xe11/0x12a0 [ceph]
   ceph_handle_snap+0x3ec/0xea0 [ceph]

and with v4 the same messages are rejected with "corrupt snap message
from mds0" and no out-of-bounds access.

[...]

Thanks,
- Xiubo
