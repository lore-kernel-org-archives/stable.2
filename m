Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A89408616
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930715; cv=none; b=id2FBFZGf0EydYLn1ASNRMg8I3LyG0wW/kOmLf/stlMz3JauBBdr7vMwc1UP4G2BLOb6PKrhdVFCDY1nc4dpD6ZpJRaBjU5To9z85JRPhBz93xmst6akkDXdJRwV3UZdbNkvFauf9zxgjh9OGM2gR0XZAKDgkUmbbjXh09xW7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930715; c=relaxed/simple;
	bh=Ld/wS7rp+k+60ju85h/avqZuJos61qGFsY6Lm2elJ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwZeUpRVLLa8HzuQuQ7sOlca+Npl5Hk5j5T/OmHbMbxwN+DszS7FNx/BKeMPhqiq1nBgq0HC6/n4jk5tEJPv2/82M3VEstmfWqGTCyZEsyubtDHxfpbA0euNWZHEuxWixt/MDQndc08iFcBk9zfbefYEvcSC3BTzuITzPESkryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=CnYJjjDp; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="CnYJjjDp"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-48657fc84a3so3847735b6e.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1780930706; x=1781535506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynytDHRd76bMUHNmTQQewW2EWsRcgHarOHL+9T2G+3M=;
        b=CnYJjjDpeQ3/8AcSkDLdtwDnCEbOcKNUdtexOde7xaKwKMtNE3141sEOIn3QqhOoHi
         om3Fa7yWB0jLTXNJ6zjV/nwyWmGjz9U87xfCDE4g09bvBbRr6DK/RETSP43eOx9JKcnK
         E3aYCP02LwKxkXFhkv3SyLYf009J3q2m71+QQ4yhyLF+G5ZpcBn5MeNU3LqJtYqUB+DA
         WIi95NPNR4wXSyI2WzGwr+3WN/10qgj4olw5sLKXipYQhD2CPyrZt/+VgIZgUO3eXn7H
         9ekePteF1oAB4Cy1BznUk2r4dCeTEIFACBKA+an5Ty3SLUvqHeWxQfKcK0movjlG7MLj
         Bizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930706; x=1781535506;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ynytDHRd76bMUHNmTQQewW2EWsRcgHarOHL+9T2G+3M=;
        b=ps12tS61zhPkuPTtkozZHsz/4DwLe1elnZkZ3kxIksEwULpxYzyfSyRR8zMwMHVNG4
         a0J17Z+NbpT1EXcbvqrxRgNNKFlb3lgt9wYbgrLiSxfRG7eRdJatwTP1i/QcyP2pyr42
         9SqQNAaED2X3AxDJoW0mro4pvgJ/PLDns85gq2UgIedPHZgAlxr0snpwqKoncq4XR9n/
         yWNReA8w2Q1jhOmi7EhK+G1JACGMqJQ4X90UaxI4Z3d9mgrwVQN8Xtnu1M3x2Mb7YjEy
         ZQMyGooRw5Lx691at2tpaf3EmcSv9iaAkQDSdqx5noaHU/9/eMf4I9QaWzkO221VoSjg
         U6wA==
X-Forwarded-Encrypted: i=1; AFNElJ+MHByl3yH5uPudJ179JC2pvCKBPWaNf4zHF7ozHnL1xwk3E/rV+Ig5+5X3xZMTQZJdp2MNsoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLy9Xf196C3dyQWNeQ8niNPQKk8PBFExu+lSp1ob6gDFC3R5G
	NJVx/r0KmTqBxy1HjIYp/1YO/ShenD48mK4qtMSSEtEAPQDSHBdzF+FLEN/YaEFOWb0=
X-Gm-Gg: Acq92OE/v+QQ9CD2qEpNeKjsY+kdDpq+5xDFBk+Ue0IGmFQrKroBQMCXxXCQknUtFpe
	pRdCH5kv4wNILj4qO6GKhQJXGnwgxyZ6WnxxDLRIdlOAYJQWSlq1wYDyPKMFbNRXuQsIwyk9VSd
	4M/LvVX2UM/TL7Nr/efQxVbuVk13zovT2Fmal7MpKnBRKsxObcS3rCz2djF/cBbk+0schT1Em0b
	xNNyZfBbxmQjOT2OREHFtMApd4h06I3xMa1Ky66yjiEnLHqidWNdHDl5uNZtQ9PLB7HC5qiQWiS
	9tMdbQ8y8oblhSluKixiUcDTvHMXt1kuVO8QM9oFIgyUE+kgH2JkHTxXFugWPha3DfcTMbc4NnX
	WEwEcrF46TBEIrvrRl7q2CQKq7k2lQ+kxVHX3R6GkUbc/67LuavabNr9+p6ZErEs1HCm504E48P
	id2qPS75eV2uNColHBItPQiUAiCXLNjuCu0NZPUcfheVUxjKN8IwPp2Th7BXMjzsi+ZfpLa+RgY
	H0rRPvgFu4/oVOkBuSo1AZutnk=
X-Received: by 2002:a05:6808:4f0d:b0:479:db65:8dbc with SMTP id 5614622812f47-4868df59fd2mr10212483b6e.30.1780930705722;
        Mon, 08 Jun 2026 07:58:25 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:cbbe:5d8b:b4d0:52d4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b745773sm14464153b6e.6.2026.06.08.07.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:58:24 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:58:19 -0500
From: Corey Minyard <corey@minyard.net>
To: Rui Qi <qirui.001@bytedance.com>
Cc: Corey Minyard <minyard@acm.org>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] ipmi: Fix rcu_read_unlock to srcu_read_unlock in
 handle_read_event_rsp
Message-ID: <aibYi72tthY8VX8V@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20260525063235.990101-1-qirui.001@bytedance.com>
 <20260608112000.1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608112000.1-qirui.001@bytedance.com>

On Mon, Jun 08, 2026 at 11:27:54AM +0800, Rui Qi wrote:
> Hi Corey,
> 
> I'm following up on this patch which was originally submitted on
> March 25 and resubmitted as v2 on May 25. I haven't received any
> feedback so far, so I wanted to bring it back to your attention.
> 
> To recap, this is a one-line fix for handle_read_event_rsp() where
> rcu_read_unlock() is incorrectly called instead of srcu_read_unlock()
> on the error path, leaving the SRCU read-side lock held.
> 
> This patch is specifically targeted at stable branches (v6.12 and
> earlier) that still carry the original SRCU-based locking. In
> mainline, commit 3be997d5a64a ("ipmi:msghandler: Remove srcu from
> the ipmi user structure") has already restructured this function to
> use a mutex, effectively eliminating the bug. However, that commit
> is part of a larger SRCU removal series that is not suitable for
> stable backport.
> 
> Since the affected code no longer exists in mainline or your
> for-next tree, this patch cannot follow the usual path of being
> applied there first and then cherry-picked by stable. Could you
> please review and provide an Acked-by so the stable team can pick
> it up directly?

I can give an:

Acked-by: Corey Minyard <corey@minyard.net>

on this, as it is obviously correct.  However, it might be better to
backport the changes removing SRCU.  Using SRCU here was a mistake to
begin with.  But that might be too big a change.

-corey

> 
> No changes since v2. The patch is reproduced below for convenience.
> 
> From: Rui Qi <qirui.001@bytedance.com>
> Subject: [PATCH v2] ipmi: Fix rcu_read_unlock to srcu_read_unlock in
>  handle_read_event_rsp
> 
> Fix a bug where rcu_read_unlock() was used instead of srcu_read_unlock()
> in handle_read_event_rsp() when ipmi_alloc_recv_msg() fails.
> 
> This mismatch leads to an SRCU read-side critical section imbalance: the
> entry uses srcu_read_lock(&intf->users_srcu) but the error path
> incorrectly calls rcu_read_unlock(), which is a no-op for SRCU and
> leaves the SRCU lock held.
> 
> The offending code was restructured in mainline by commit 3be997d5a64a
> ("ipmi:msghandler: Remove srcu from the ipmi user structure"), which
> replaced the SRCU locking with a mutex in this function, effectively
> eliminating the mismatch. However, that commit is part of a larger
> SRCU removal series that is not suitable for stable backport. This
> minimal fix addresses the SRCU imbalance for 6.12 and earlier stable
> branches that still carry the original locking scheme.
> 
> Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> 
>  drivers/char/ipmi/ipmi_msghandler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 188722ec0337..41ae4dac4eeb 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -4395,7 +4395,7 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
> 
>  		recv_msg = ipmi_alloc_recv_msg(user);
>  		if (IS_ERR(recv_msg)) {
> -			rcu_read_unlock();
> +			srcu_read_unlock(&intf->users_srcu, index);
>  			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
>  						 link) {
>  				list_del(&recv_msg->link);
