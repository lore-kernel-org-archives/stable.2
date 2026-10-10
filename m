Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7A1A6836
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791605898; cv=pass; b=jbhkckgcxJHH2BqnF+84qDHStIja5GhCQwd9j9J8fjST5ix0jVm6bZYgjuTJ5n6kVB6VpcIc9qLvWEwueKw+0Mrj6E66vtjLGDUJp/RDJhs4IC4sUo3O4yX4sSrb6b4cm7FSosrWoUvK7MMq26n6j81JornPjnTLiBKHKd5IWPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791605898; c=relaxed/simple;
	bh=KYy6VegmlTUaxOe7PFlSpF96TjgUY4FSEQt4j5zRT20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEIwIxi9iTnVilJomhPAuXuDEJ5O7TZQhqYa4AK1kCNox3vqHdJ7pDMO7Pp3HzRL+xUvNdUuhfTtf90RknqY+Jv6HdMTzVOZlY7eWJINhuYnNbxi6P1hbWxaJYCt1fakHLZ+LTja2FbcklwWJ6HwygGt5i5NTPnt59Ka9oNNNk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxwPN3z2; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxwPN3z2"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6dfd530a2d5so245602eaf.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 21:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791605895; cv=none;
        d=google.com; s=arc-20260327;
        b=Llv3daEXXMHgEGsbETQ3Al5z04on3NMN+mz8YsUD40jZN8w4kx6JNoe6aQDc+FOnfP
         OaaVp2eT5L/fT0gIRN6NVD6u3hHVSK+M/pOJrh1RTn1wb0CMlNgDbK/TUKC6Pc2CHwkR
         rEpeQVu5ae4+kh8eZxWQnTubjuU6qRLLJQW4RsI1a+At1OTtt8km6+PfCBm1eBAfUNcZ
         C6QiSQfglbHvjxzCgX5z0VQqnS56F0gZfkodcMTgFVj0zhkDhvsJ4NfrW3Hzp4LANwd0
         ztNxtiaXOaxNQrBwv7MUJU6+8E864eUyXdHD0v3ZbD3YjnxPhQ59Y3ImE91NC4l/+88a
         Xn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ew33P9923AzoJpuAktLckP37GCcxC9qHFUOjrnQW1Ik=;
        fh=9PRQXAzD2Jo1pVYd5MTn2bLdCu+re1/rrCOO1S0iQEc=;
        b=ssdkkX52bEaJhRCTRdFuEJcFB7QJHhp8DoC79gzjILgEcWYrckityNIru/X3+gSfLw
         ihhuiZC0tLGey8x72Ue2Q+aJwtamD9+q5imOgYT8oU27TAFIEBsdax5nS5knGa0+un5v
         pfyrfPmdRZFKG+BresmZkhXtY9B0LLHwU82IiFSbnnlqCJ8zhg7my2Egd2BJR/h0kVRX
         nSpx7lc3shxZut9qcRr+pkHrQVUkWDas9LYH5FK75U6SnItaisTlW92JLIdFYkH1FVoa
         E1UffuDwO9P6lhBS0dGyPzpSU1p6Wm+LEabtBh+Po14QKZu46kA+jZJp1O5Ko6Jn5lYu
         hhWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791605895; x=1792210695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ew33P9923AzoJpuAktLckP37GCcxC9qHFUOjrnQW1Ik=;
        b=OxwPN3z2Qz8oUwvwhqV8qNluN4gvU/XIaloMEhRouQnKBX5awGvC1nhoxLjPFyIQ7u
         DV3EiJm9Ieqo4hI0bJ/MF6sbCni4DbDsLnE7s8oAWWXxzD4FXfhyk3JfNMA0vvJuRUQn
         DbjnHf5C5cI67mieFz1E36SjXNwSYq5u9iby+wu9S54Op6T1sIn54U8o4l/dEiqW7UuQ
         nGgOsf1drkrgL0CRVP1/ZgUY0Gkbe6zGIyk3wWzdCVQbL4jkQn7FH3nI7Nf6NTBrQTNf
         YdmDsbc1lfhFlsFBEObW4MODgwE+CAj0WcyV2RadszbAc0Hbd7I7rAL6D2R1x6b5CFTf
         8j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791605895; x=1792210695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ew33P9923AzoJpuAktLckP37GCcxC9qHFUOjrnQW1Ik=;
        b=rg+gpqI2wh3luZN2f5MnM7eVWTmVhR7759pC6zrFZWvooaA0oT7ge5Y0sU5Dec5vqa
         IYsBth3V9ZvSmMS+zLAXHygs9pUKGQUcUTP8F4FbCp/aITxfRELlY4kWTr5MeaCNuu6A
         UyvgXpUJKwud0hYxS1YBBIOyEAzJymaixg6f4DxNV2aGfjiCuC514lOYQJsXPRiwxfWQ
         7+D02vUpvnD9yVemOHVfprr1A7kmKkMnFivWrA5sziIwgCmuITQtpSZjj+buwvJnVKCN
         H11jxEEnnwfLUGRxjbSLZjWQW2WuapMMg0pjpQPb5og15pZF9DTjbNMa73O4a+R2HhLB
         biBQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+QLAA8DiWqmA1g8x3EcHBqLkC0BlKQc9znf0kqvjb+VcYKzgDpXambqzcYxFeWr7vCWhlMEY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJnQ61peA1Fd8U8MqPHUB9LL5eRT1i5h1ufyok0kNDOvxISbH0
	uTW0uloDGQTvown9sZUk0+7X9UVTQwRGDie8+hyiUmbOqSeCws8C6TtSJfoL2Gd9W4UEdfCpK0m
	CFb1HlQiRhd6fvG/fTzzjz+638pA3RK0=
X-Gm-Gg: AYBFou1r5T5MubhTN4gUHU6dzXfQQBbqosamErTBTuG19xG4/D/mTN82BNPexlxlOls
	hzbIcjhRQlSNtfzGF9hZqDIyE7vFEqx0VODzb1KgL0bnxzpIrMiBdBLAfsE4Be9AUpG4O8tbuky
	w4y3HfUH03+JhUC+njwv5+1ytYOu5iSPoQyle5cboB6X32Gwp0EgWYt6bpzBR2mlEosqMWOvwMJ
	bx2G24zb6fYd4GjXLRcXBXGXkmZawUqbTy7sbXpqVjkJGr/xooR0wgeTgZV0icH91YmLwGKmefQ
	KOqG0OMUZV28BOML7KKtPtONBQJEXf4hvoQrcYxgklI135Sb6uFR3gcHxUC7ONI19yrD62Vng35
	cTJOLm4D1Y/qFEEQjzc7/S4c49VMt04dINN6IgE8f0F587G/OqQZUcjo=
X-Received: by 2002:a05:6820:984:b0:6e2:3d8b:a01c with SMTP id
 006d021491bc7-6ef0e9dc2d0mr2797147eaf.19.1791605895411; Fri, 09 Oct 2026
 21:18:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com>
In-Reply-To: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 9 Oct 2026 23:18:04 -0500
X-Gm-Features: AclHuK_aaavcIOhZXQjbCJpj_zTwHfB7pXCx3pPddER2n9m6mNEdfh2htsXEqCI
Message-ID: <CACVXFVNVC4cBuL6gFMMo+FktZnXdy18YJ-Wu81NqNfW7E4_6WA@mail.gmail.com>
Subject: Re: [PATCH] block: don't quiesce the queue when setting the default elevator
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Nilay Shroff <nilay@linux.ibm.com>, Hannes Reinecke <hare@suse.de>, 
	Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:12=E2=80=AFPM Qiliang Yuan <odys.yuan@gmail.com>=
 wrote:
>
> elevator_set_default() runs from blk_register_queue() while the disk is
> still being added: the block device is not visible yet and uevents are
> suppressed, so no file system I/O can be issued. elevator_change()
> freezes the queue and cancels the dispatch work before switching, which
> is enough to drain dispatch activity from passthrough requests, as the
> comment in elevator_change() already states.
>
> elevator_switch() still quiesces the queue unconditionally, though, so
> every disk added with a default elevator waits for an RCU grace period.
> Commit 245a489e81e1 ("block: avoid to quiesce queue in
> elevator_init_mq") had removed this wait from the default elevator
> setup, and it came back when that setup was folded into
> elevator_change().
>
> The wait is paid in full by callers that add disks one at a time. ublk
> adds the disk of a single-queue device from START_DEV, which takes 7.7ms
> at p50 in a 16 vCPU KVM guest, most of it in blk_mq_quiesce_queue()
> called from elevator_set_default().
>
> Skip quiescing in elevator_switch() when setting the default elevator.
>
> ublk null target, 1000 single-queue devices created one by one:
>
>                      before      after
>   START_DEV p50      7.74ms     0.68ms
>   START_DEV p99     14.61ms     1.32ms
>   devices/s             114        971
>
> Fixes: 1e44bedbc921 ("block: unifying elevator change")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  block/elevator.c | 7 +++++--
>  block/elevator.h | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/block/elevator.c b/block/elevator.c
> index 2161b6eea680c..da9ba70ac9321 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -573,7 +573,8 @@ static int elevator_switch(struct request_queue *q, s=
truct elv_change_ctx *ctx)
>                         return -EINVAL;
>         }
>
> -       blk_mq_quiesce_queue(q);
> +       if (!ctx->no_quiesce)
> +               blk_mq_quiesce_queue(q);
>
>         if (q->elevator) {
>                 ctx->old =3D q->elevator;
> @@ -594,7 +595,8 @@ static int elevator_switch(struct request_queue *q, s=
truct elv_change_ctx *ctx)
>         blk_add_trace_msg(q, "elv switch: %s", ctx->name);
>
>  out_unfreeze:
> -       blk_mq_unquiesce_queue(q);
> +       if (!ctx->no_quiesce)
> +               blk_mq_unquiesce_queue(q);
>
>         if (ret) {
>                 pr_warn("elv: switch to \"%s\" failed, falling back to \"=
none\"\n",
> @@ -731,6 +733,7 @@ void elevator_set_default(struct request_queue *q)
>         struct elv_change_ctx ctx =3D {
>                 .name =3D "mq-deadline",
>                 .no_uevent =3D true,
> +               .no_quiesce =3D true,
>         };
>         int err;

Looks good given elevator_set_default() is only called on new added disk,

Reviewed-by: Ming Lei <tom.leiming@gmail.com>



Thanks,
Ming Lei
