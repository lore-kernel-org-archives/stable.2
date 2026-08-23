Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFEC3644D1
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787477221; cv=none; b=MRq4iMI+6J+BRrvyM2XWBicqmivjuz4tbgX0X+pjO1NGN7oBS/oI3IjGT6BXQQv/EO1ftTFgs0w4sR8IRtf06a2M1En2ruvrXF9cgfCKlV8RtWDGJoQbdFOulHUtMO9Ud0b/IyrXArAKAFKDi1aL4E3stljQoI3i7SzvaZ2l450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787477221; c=relaxed/simple;
	bh=t0sZ979wz/Kzf3He4S0uIarjFp1HP9gkH0S80Fo68GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6Gcvg1Va2zycJcuTxuyg2IsVAVkvW75VBUc4Vxb5ELB2YYUsuqtjAq4kdFui2uPrf4bHxETbJ4RbpPY5zFfV3ksJEAvflSIryKX0IGOBZvXs49zg7Rbz0sU3kf3+J7dMQqGieqqe8LGI3fUS1bJFoLeQlMwP5bUin2vbzR+DLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYuiCQbQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYuiCQbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3B91F000E9;
	Sun, 23 Aug 2026 09:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787477219;
	bh=e5yPIQh3O3nq2q0KgfeAefC247ZtIWn5Bcanl1rzdX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DYuiCQbQBkk13k5SkPxxfC5cQJKMQuwY5by9p14ykAbO+zUT+LHa/ezN3DhWGT8ZF
	 9o7MRNEK3UV6DbJfHJt3h+IA0SXPwHSBGr5tg2mtY+/41/ByT8jd0nKF9INUPWtON9
	 5YSEYcnfEjsGg4/IYs6LAWqbArrblQOGvqoIBOU2Hyo6cSochwM2YkMddPlp/EBGLu
	 jGo+kKtJNKo0Ie8CoD9dWlcmveie7/p+l5Z8HlHXDWsbjs7d/MoBUyuIzsKmZupVyU
	 AEjAoGzVdWKl/jdKh4Ak3w2CVhFQkHoCMpltsX9n1ajORcCLnlw3LO4MVY9mNa/0R6
	 6++WnQ3AWX33w==
Date: Sun, 23 Aug 2026 11:26:55 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Tien Phan <tienpp@gmail.com>, security@kernel.org,
	Greg KH <greg@kroah.com>, Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>, stable@vger.kernel.org
Subject: Re: [PATCH v3] nfsd: fix use-after-free of DRC slot in
 nfsd4_sequence()
Message-ID: <aoq83x-evWFqvOC_@gmail.com>
References: <20260819054326.1265334-1-tienpp@gmail.com>
 <20260819074701.1312702-1-tienpp@gmail.com>
 <d12a1f09d718f4b7ba7a8101806f858f2a6140bd.camel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d12a1f09d718f4b7ba7a8101806f858f2a6140bd.camel@kernel.org>


* Jeff Layton <jlayton@kernel.org> wrote:

> I think this problem is already fixed (and more comprehensively) by
> this patch in Chuck's nfsd-testing branch:
> 
>     f5d22e372f4a nfsd: don't free session slots that are still in use

Commit/patch attached below for convenience - and it's now upstream
as well already.

Thanks,

	Ingo

=========================>
# From f5d22e372f4ac3eb287037a488c29691d52a6330 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 26 May 2026 12:24:48 -0400
Subject: [PATCH] nfsd: don't free session slots that are still in use

nfsd4_sequence() can free the very slot it is currently processing.
When the session shrinker has reduced se_target_maxslots below
se_fchannel.maxreqs, the shrink path checks three conditions before
calling free_session_slots():

  1. se_target_maxslots < maxreqs  (shrink was advertised)
  2. slot->sl_generation == se_slot_gen  (slot is up-to-date)
  3. seq->maxslots <= se_target_maxslots  (client acknowledges)

However, seq->slotid is never checked against se_target_maxslots.
A client using a slot in the range [se_target_maxslots, maxreqs) can
satisfy all three conditions: its slot has the current generation
(set by a prior SEQUENCE), and it sends sa_highest_slotid <=
se_target_maxslots to acknowledge the reduction.

free_session_slots() then kfrees every slot at index >=
se_target_maxslots, including the caller's own slot. The function
continues to write sl_seqid, sl_flags, sl_generation, and stores the
dangling pointer in cstate->slot. Later, nfsd4_store_cache_entry()
copies up to maxresp_cached bytes of the compound reply into the freed
sl_data[] array, corrupting whatever slab object now occupies that
address.

Additionally, a concurrent thread processing SEQUENCE on a different
high-numbered slot can have its slot freed out from under it.
NFSD4_SLOT_INUSE is set under nn->client_lock before the lock is
released, so any concurrent thread past SEQUENCE will have its slot
marked. However, free_session_slots() does not check NFSD4_SLOT_INUSE
before freeing.

Fix both problems by:
 1. Checking that the current request's slotid is below the shrink
    boundary.
 2. Scanning slots in the to-be-freed range for NFSD4_SLOT_INUSE and
    deferring the shrink if any are active.

Fixes: fc8738c68d0b ("nfsd: add support for freeing unused session-DRC slots")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-v2-1-74a89db0639e@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8f90fba53357..0d6a7440a4e2 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4496,6 +4496,19 @@ static void nfsd4_construct_sequence_response(struct nfsd4_session *session,
 		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
 }
 
+static bool nfsd4_slots_inuse(struct nfsd4_session *ses, int from)
+{
+	int i;
+
+	for (i = from; i < ses->se_fchannel.maxreqs; i++) {
+		struct nfsd4_slot *slot = xa_load(&ses->se_slots, i);
+
+		if (slot->sl_flags & NFSD4_SLOT_INUSE)
+			return true;
+	}
+	return false;
+}
+
 __be32
 nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
@@ -4575,7 +4588,9 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
 	    slot->sl_generation == session->se_slot_gen &&
-	    seq->maxslots <= session->se_target_maxslots)
+	    seq->maxslots <= session->se_target_maxslots &&
+	    seq->slotid < session->se_target_maxslots &&
+	    !nfsd4_slots_inuse(session, session->se_target_maxslots))
 		/* Client acknowledged our reduce maxreqs */
 		free_session_slots(session, session->se_target_maxslots);
 
