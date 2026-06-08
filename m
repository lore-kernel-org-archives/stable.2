Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E33BFAFC
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945166; cv=pass; b=HBtET/BfGW7LhWwff4J2kUCLPrlVT9Jphzkkye1/qPNWq5eoazl78M0ALrLqkTNFJcFe/1TA+Z6Dn6IyksG2nRGEAPddHZpgwan5qXxmMw4vlRMePIC7X9fzuhiOTIPF7Dr5EY/hZD0dZlwjzZXPM0z0EAu4b7j04FC5V9N+rY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945166; c=relaxed/simple;
	bh=yBJFqXmRzaKdzw96fX2rukiJ4HnKelLlRI4gR0TmbCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tE8hCzMFyQywifEDPvmLOsJz0kCFuTGBssPzEvEdq5UtCxEQ3TZZ5tjIdu64YeiFAtKQk8lfPBMbtEEEWSSIQ4Z96pXr3JR+OTdKmxFd6W7SP2fEAVDVyBe4a1+S3kmAk7NOTxVrRMFKtdO7257QMjDSTe0LrUt7kypo77Y0dLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP510bYq; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP510bYq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso32507055e9.2
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 11:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780945163; cv=none;
        d=google.com; s=arc-20240605;
        b=W/FzWq7Oo+bonlOQ+9ojQNtlsO/A2fbrr5c4uPd4B22kIzCpaohoI/jHY5RxF4jMGV
         ZrC1OlMawHC8OqaEjGjtoppuhPOA7NId2/h603sqWZ+RQGB3de2rye1xXpvMQsJzWcdr
         WUvX4naWFGtnLREc2wft1ZthEicb9YukeaCmitUAYB5pzCcHgflK2y5kbKyVMDmzLptJ
         663Pa4pfUcvCVqjqiuDOaqPVvt1XPjz+4CPb6xwhvjqk5hSEp6+2K+N2hhmb3Xlyqcy/
         ci0oOiEGCkn0oPdXF2WsC4MRk8mn7PdvM7BHkeYgMeDJQPdj9PBFiC7zauhTgt4d78wU
         E5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O/5pQNMaPJqr0ufRp1ogIfZe7v/+zI1ZvqEwfPYmE0c=;
        fh=6HQFX2O0gcqhvTMvxdsPMAdEH9TPIO/q9Zc+33LYSjQ=;
        b=iJtzeC0PWfbitOC0J8aiQdgQhl68MEJAFEplXNfHiaFrzcUwYRyo/Kr/n92LeWr/i0
         +FWkAocNqmkkkKUefRDMm8QGvkwTtT6jQ9LW6hxTUWONVVSzmcpee8vy8+rJA31E4yvH
         O1pB3pwvW1i8WB4mNZf7RHsESHFPojCIrzkVMUsV3TskPowArrbUA9eKmLNBQrq3Kyki
         17ZIpCVpQxGzdGRNFvvhlMH0CpVuzKnwAHnh9jiSrdbfWv9Gy/ueVaF3Awb4N7tjLGou
         AtzeqX13SYJawbBxomhbLJGWEwZF2AWaBlJ1p/cOQpD4WR0DLgewkgvpVgyuL5qPjGHf
         K9/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780945163; x=1781549963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/5pQNMaPJqr0ufRp1ogIfZe7v/+zI1ZvqEwfPYmE0c=;
        b=KP510bYqpvOOoh9xFX1KEGLGWT4crZV9EmyIaOFCi+k4CIvjz3n2XpG5nRapdNVNL2
         QxiZmV+hWzY1gP4RU0O3aMtJ1xl+wTGaPnAy7HolQ2TWB/+WGDIenDzugmfrWuvkd6Em
         752tWjUISnolTIybbYCjz75vJqfYq9dOjUKraGIvfIuE6Zu5pC/YyWohe7ybqkgeTiMr
         Yauo8oSvLay2MbtS6Kv6us2zZIu/PrFBwaG6XicweRi2iu26zK2tWJg6Uuo18Mp+Oi+3
         59sjZ8wJZZg7eM/M1DZfqT+AVpGg2bMz4FvXj+ndL8pQlNvs2lPZxRwSfD6/CX3ors5J
         Ow6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780945163; x=1781549963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O/5pQNMaPJqr0ufRp1ogIfZe7v/+zI1ZvqEwfPYmE0c=;
        b=GxOlqnegXXT++5Jx+g69DsHkEMfKM0haqghyjUqy1Qo6rquH5mWzdR3ujsBFVSfjbO
         O7BfzbSPidat5x8W+XURoemG9gl3v8+SRqPpFKw7Qjx2AAkkaRJH+3HQCF3+NIyI3eNB
         fSWbFTV+VFGoOUUtWurzycBP3XWbkjqidwKDq3Iqt14hxHlX+17SIc/h7JaGGvjXIa93
         4Va4NwI/k8+5xKFSeIisv5+dG7JCXl5Hsw5GwMcMMROi0mgiJEgzMkrPgkXVplswPAvm
         q4TY7tMiJ5AOpGLunSgSE6yXcclzVpzFhzh65IEYb1YVdY3cL2QGwZtfKX8VaOZtflkm
         p0CA==
X-Forwarded-Encrypted: i=1; AFNElJ9Gm3vrCy1QChS9I+Mr+YM6hMF0gCM1Y1q8eIkc9LHTSt9HwjHeI8pO84RVN+fra8WGzNiWvyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKOXwNbmhyAIvSqk0wiBMtrUF8mbsPtJY4uEKKPWU2JmATKGC
	N9MeH8JcpQ1TpVaeS9xg2NQymHY2/GIADvcSsdBJgQvEvSk5o6tHnIfMYEhiEI+YsrKp7ugbjQy
	w6BxFo3Tyny/ps4GaY5IM+Rz1v5cQ1RA=
X-Gm-Gg: Acq92OHzl/YuvAnyyWJNAE5at3jMHQrwI9BpoBj44aMB93esvep5pPcQrmGnbY5xBn1
	sy41V88AqUEECPnsZSW4G5AhxH+Cnj8Weay+gTJnzQ4yvG6U329EPh4H++XH0coTPMGkPNumU2i
	VgWVOO1WrcEKkx9TmxT8U5AmE1XywE3Nr2qAgkiRSIn4C3u3djgbzSBq2Y5kkMmscYd6jo3ltSE
	232xbxW98vIRYQEPsRt1LxflLu/AGRQ1qvxHAMMGqfrAck1xLVMlNoXQjHMLrDgH+HH61CXedMq
	g/ov/p/wtSDsB3bZ
X-Received: by 2002:a05:600c:81c9:b0:490:b724:507d with SMTP id
 5b1f17b1804b1-490c259f6e2mr237393135e9.11.1780945163426; Mon, 08 Jun 2026
 11:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516021138.2759874-1-joannelkoong@gmail.com> <20260516021138.2759874-4-joannelkoong@gmail.com>
In-Reply-To: <20260516021138.2759874-4-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 8 Jun 2026 11:59:11 -0700
X-Gm-Features: AVVi8CceSKxQPUcEdfuHmSg_2xCefzXjumilBU8h8X_tuH8z485L4Aep2A-hRG8
Message-ID: <CAJnrk1bPQczAmaKkGOKAnKBb-FDb1Exmn1r_=HLPkJnKqd3T+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fuse: fix moving cancelled entry to
 ent_in_userspace list
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev, bernd@bsbernd.com, ali@ddn.com, 
	horst@birthelmer.de, Heechan Kang <gganji11@naver.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 7:12=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> fuse_uring_cancel() moves entries that are available (these have no reqs
> attached) to the ent_in_userspace list. ent_list_request_expired()
> checks the first entry on ent_in_userspace and dereferences
> ent->fuse_req unconditionally, which will crash on a cancelled entry
> that was moved to this list.
>
> Fix this by freeing the entry and dropping queue_refs directly in
> fuse_uring_cancel(). This is safe because cancel is the cancel handler
> itself - after io_uring_cmd_done(), no more cancels will be dispatched
> for this command, and teardown serializes with cancel via queue->lock.
>
> Since cancel now decrements queue_refs, fuse_uring_abort() must no
> longer gate fuse_uring_abort_end_requests() on queue_refs > 0, as
> cancelled entries may have already dropped queue_refs while requests are
> still queued. Remove the gate so abort always flushes requests and stops
> queues.
>
> Reported-by: Heechan Kang <gganji11@naver.com>
> Tested-by: Heechan Kang <gganji11@naver.com>
> Fixes: 4fea593e625c ("fuse: optimize over-io-uring request expiration che=
ck")
> Cc: stable@vger.kernel.org
> Co-developed-by: Jian Huang Li <ali@ddn.com>
> Co-developed-by: Horst Birthelmer <horst@birthelmer.de>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Bernd added his Reviewed-by to this as well [1], but had accidentally
added it to v1 instead of this v2 series, but this patch is identical
for both series.

Thanks,
Joanne

[1] https://lore.kernel.org/all/e55945b3-99a1-40b3-a145-b4867053930e@bsbern=
d.com/

> ---
>  fs/fuse/dev_uring.c   | 6 ++++--
>  fs/fuse/dev_uring_i.h | 6 +++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index d9108b5b5db8..f4ba64a1796a 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -511,8 +511,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *cm=
d,
>         queue =3D ent->queue;
>         spin_lock(&queue->lock);
>         if (ent->state =3D=3D FRRS_AVAILABLE) {
> -               ent->state =3D FRRS_USERSPACE;
> -               list_move_tail(&ent->list, &queue->ent_in_userspace);
> +               list_del_init(&ent->list);
>                 need_cmd_done =3D true;
>                 ent->cmd =3D NULL;
>         }
> @@ -521,6 +520,9 @@ static void fuse_uring_cancel(struct io_uring_cmd *cm=
d,
>         if (need_cmd_done) {
>                 /* no queue lock to avoid lock order issues */
>                 io_uring_cmd_done(cmd, -ENOTCONN, issue_flags);
> +               kfree(ent);
> +               if (atomic_dec_and_test(&queue->ring->queue_refs))
> +                       wake_up_all(&queue->ring->stop_waitq);
>         }
>  }
>
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 368f4d0790eb..22ec67e39ee0 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -150,10 +150,10 @@ static inline void fuse_uring_abort(struct fuse_cha=
n *fch)
>         if (ring =3D=3D NULL)
>                 return;
>
> -       if (atomic_read(&ring->queue_refs) > 0) {
> -               fuse_uring_abort_end_requests(ring);
> +       fuse_uring_abort_end_requests(ring);
> +
> +       if (atomic_read(&ring->queue_refs) > 0)
>                 fuse_uring_stop_queues(ring);
> -       }
>  }
>
>  static inline void fuse_uring_wait_stopped_queues(struct fuse_chan *fch)
> --
> 2.52.0
>
