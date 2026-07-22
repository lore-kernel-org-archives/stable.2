Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B1353A6C
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733208; cv=none; b=Wl3EVHZblMfpvn/eqBppTyxMVqmF52AFMT1qhYFN+4DMPuNHyTgw0RtopZHQS/qfvQhq6XNg2LBg+/SsxtWWr3FvmKOap9G2SJCtv6DuDJXB1uV+MH+2N9CG+LH21p3NH9XyPMzWY2+qmpjkLSX6OKhpSFT/bM6O+ybZj2gYnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733208; c=relaxed/simple;
	bh=cBdLWEY/T9ZXnMY8rZ7+95KGHHOx4XJ5/t8WwUctC4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=toSh0aHZViFItMOf50gab4dYLGbwoMxxX2cb/Wf9N4RbT0Qs6+8002qMdOCYLwalO9POxq/GUwbigVPXph1yOkESO5c+C/jlohhK37suSx5CQrclI9oJpHw9Tn12MqtFrQ217xUnL9O3yA795A5ITOrrW61iYes4mRdTHZV7Fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRqud/5+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRqud/5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C991F000E9;
	Wed, 22 Jul 2026 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784733206;
	bh=+uI0JguM/H2V3yLk4F/XlFJCiNt8dqbw3dZLSKN4ADs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=eRqud/5+bp3Uvpp0xJ5dc2TseWS1Ijlc2m8cdxE9CuiayeqnouWK1sXfkej9D2O6m
	 pEAS9u4HrVhh6e4L9LCg0YUH1hT8B7l2kgGmvKASOW+D0YLlIpZZXzPuuxG3KZcWw8
	 AxUMXNQdJPkilDd+6saz3g8RN7+S7nS4etlyN1TCEboKKoCKBDq3yOP04hBc7mZHeK
	 2+TuYvpD55Tf7k06gXxYs19RY/qUbrts6gvcDXQ5ychedAOeSjbsQVfotSPjBWFDxs
	 WkQ0sPMz0YUB53E7vV5oz7RkPhBRLJO92ktJxUUKVIVZtlxDyoC+vvbcdSh/o91QhB
	 34ANtcilL0bzg==
From: Thomas Gleixner <tglx@kernel.org>
To: gregkh@linuxfoundation.org, eilaimemedsnaimel@gmail.com
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] futex/requeue: Prevent NULL pointer
 dereference in" failed to apply to 5.10-stable tree
In-Reply-To: <2026072141-striking-reaffirm-3311@gregkh>
References: <2026072141-striking-reaffirm-3311@gregkh>
Date: Wed, 22 Jul 2026 17:13:23 +0200
Message-ID: <87se5bjbvw.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 21 2026 at 17:13, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 74e144274af39935b0f410c0ee4d2b91c3730414

As I said before this commit should not be backported as it is buggy and
got reverted upstream:

  39def6d250d3 ("futex/requeue: Revert "Prevent NULL pointer dereference in remove_waiter() on self-deadlock""")

The one which fixes the actual problem is:

   40a25d59e85b ("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued")

That one does not apply to 5.10/15 either as the prerequisite

    3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")

has not been backported presumably because the Fixes tag in that commit
points to a commit which got introduced post 5.15. Though the bug it
fixes got introduced way earlier.

Let me backport these two:

   3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")
   40a25d59e85b ("locking/rtmutex: Skip remove_waiter() when waiter is not enqueued")

to 5.10.y and 5.15.y. I'll send a series later.

Thanks,

        tglx
