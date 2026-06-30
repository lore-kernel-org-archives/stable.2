Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9F3EBF20
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813679; cv=pass; b=PK/MF6H478CTIK0ZVau59zA0PZi72gmsKpG+UgYy661HuN9OrsRfrkH/6ua17xhL4rsF7OJxKQAfgLT4apoulhusguUFKWtWXzwMcViCW05TiZD9Y3TDROJggcMueQ3KN/hCOKxvltLDuRG78gpmt6RDSiEBo2wjxiGkyoIck5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813679; c=relaxed/simple;
	bh=H/81wjmdIjTzJqVZB8M0I1Im1tte7mRFN4YFwVEVUXk=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoF0D/3+Gu8XT0OUHCyGB4SB2PGnwIqJojXw/yCdRXYJDPwufvDkZ2+OuszTRSDkTzlyMIb6t0qHFG94hloKcSMmoAs1Gp2R1u9l75d8Hq8AQ8ISy3GkXFV9qJSBq62e4lqZBMMvxhVf10EeIO7BLXm5onEsdTCVgo/j/WpWjuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtgwsyEC; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtgwsyEC"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664ee752958so1644510d50.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 03:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782813677; cv=none;
        d=google.com; s=arc-20260327;
        b=jsxkVbS72AR98FOZdcD5KHOLsEDXkCbvTSH8wpeeDyPvTxdqPT0c0IpTQf97YPucce
         5gFZioSsCLUM5sW9FIV8ByexpBDxvlIMHpuyoZfy+/2BNGQ9YGp5JD+p8xQv7wF26Ri0
         dOwM+OkwE6wm1ZNuHMt95X7xXVs0btU7OOWEzjtjvqUwRHZvFE74CCOhvRHVDjFQhelw
         r68tn7jgnI39/ARqWhO9URkUz4dk4G4liFkDInJANUkR++pZj2eCCvLFNmV68r3OVx1z
         HBuTs2hlXrAmyo8bLilo01OGb6DLf4xo58DPNxERkoiXeUe+iVDhNyI+Tc5Zi06qEbCX
         FxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=H/81wjmdIjTzJqVZB8M0I1Im1tte7mRFN4YFwVEVUXk=;
        fh=V5NOCwlpIgrSEIv+z9v2ie+BPSmo2GaIxbf8MQym2eU=;
        b=EGSeV/BW8lqO5g6H4WNMkQXDpUJBiRzwLvIUY15FPArQ0ZebbUdoJRt0bkXTdvlwWw
         PG/E7x1CaI9HredzI5eBMHip8HMG7NGNibtU6Ad6x6UvujCif5RVAra3E25lRO7AAmQC
         IhC6G7/U3ynGRON/H+WM77VP+2pSWxceqqXDmwq9b2MxpiJrSlIz9eQBs3NMy02hT6Bq
         Y1FVq1N1b1/pGxuZGHCkcFdIs4UYsv7iOqHT14Q+LzpK9P0QPKIMtbvS+ZT44EHiDNHq
         b1eF0N0OYvNbDfgpLjPznutSQDBbSXR6IKDTwBU3yWvw/q7ECM5g4aab8LutadZ+7zZI
         shOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782813677; x=1783418477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=H/81wjmdIjTzJqVZB8M0I1Im1tte7mRFN4YFwVEVUXk=;
        b=BtgwsyEC7UjjN0ZHDDQnlp8xmDD+4xaOaOvh7uXMrYKUJN1sv8ATUzzY++OF33CCXy
         AF+ckA0Cu6IV7332hB/fXBIu4p7f3+3eW9B37EI3Bbkgi8hAtr0dC2wVQevRYsgscBC5
         AIN0bdF6mJX2b1hDBo390V4Nj7JtrW05TKfAs42Rs5Q+J1YEQPUjZ/tbFEreup3njhTY
         Z0v/ak5hD5BFpCAzIRYjW3jSecLRo9sjQ4OVrlTh3Swn0SjA2jyE5FmXCG6HdDBRvGGJ
         4orjLC4UBVFq5qMUWFzDqxZrUix9usaTlfW2R4+Q9+FfRSGin4WsjuI1rSRqQJuPsONO
         s7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813677; x=1783418477;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/81wjmdIjTzJqVZB8M0I1Im1tte7mRFN4YFwVEVUXk=;
        b=s4Vqbe5W8cH8ZpK7ivbmVznil/Pu7goyz8cQFtjEQdMdPRZ71TMNKIT+aXqDduNOTT
         7EDNM67uMFTAUpPxVTpOD6sfyA3GaB3vEBm0rfP8IKdevxrofVYgK6rEqU55Knk6iA7M
         +nQQOT44uhItRKRJFU0VOLjZRwY2e0RRWOSnP53rE87iJA3cDtXalILa9TVSGUBrQPcW
         aOb8IvqUKv/zgdBnzRutKPqVTziLINTt84C91vxwqmaAKEMgjrmjWrH/5Ksi1eqnwGoZ
         WCo15GAvF0BxsiWy6lXxu9KC4Moc+PvrR+gzIjYKSBwy08Tx61T6vypM2J2Agj9vOEn5
         0B1w==
X-Forwarded-Encrypted: i=1; AHgh+RpXUIjl8ZzwWefmuTsrDYGGmpz6wIFYJGsSgc6AaysbycuBXccbD/kylCLBupE/YbKF8UAa6OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPDmBksIUbFOL8A+iPEFElf5tOzrqzvHfWkui8+79PyQWHyRH
	wFYgBL4fsCAnUrXfwuaIiGc0bo+ss76hjx5NiZYodJ6rOoJmKcitgmpf13rSUj4s22C4rn8UH7L
	PodEsVEpA3Tqig/9LE5/lCsUVHezGUGw=
X-Gm-Gg: AfdE7cn9p6ITrBS55NQ4NcgNO5+UuSUkJslUcPYbkqyagF5FNB+wW4jI5sW1Z1B9MKZ
	fWioTjXbr9ncFUptN2Ru/hSTwIurQ9lfIdHckYtuPV13UXIkNv+OuO12cHaw0zDDd0u9f7uqs9H
	d20w3/ArTDAb94Z5CxU97NvPiBH92Pvn6RWLmWQZJ0MfRygCwtDe9vGWLkb5hpgdW9qSfZ71US5
	TzO8oxkCaW6X6ePwWlbKchEjgsrcqmzYgZsLD71J6qRhVwsMOeH7ldYh4qYQZE+ULwfRn0s
X-Received: by 2002:a05:690c:4807:b0:80a:a034:17c7 with SMTP id
 00721157ae682-810da607f74mr30469567b3.55.1782813676650; Tue, 30 Jun 2026
 03:01:16 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 30 Jun 2026 12:01:15 +0200
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 30 Jun 2026 12:01:15 +0200
In-Reply-To: <20260629201350.GC6078@frogsfrogsfrogs>
References: <20260628092513.39620-1-alhouseenyousef@gmail.com> <20260629201350.GC6078@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Tue, 30 Jun 2026 12:01:15 +0200
X-Gm-Features: AVVi8CcHFXy5WXv8Z7KDhPMawVILInCAnJXIeDL9L2Vx83obhjttyaKdCByM8rU
Message-ID: <CAMuQ4bWu3cSE-QcCY75xQdesqyoxSu6z4QVduKOVC+p_rw0VXQ@mail.gmail.com>
Subject: Re: [PATCH] xfs: initialize first bad log block in head verification
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Agreed. Log block zero is valid, so using it as the sentinel is unsafe
for exactly that wrapped-log case.

I'll send v2 initializing first_bad to XFS_BUF_DADDR_NULL and checking
explicitly against that sentinel before entering the torn-write
recovery path.

Thanks,
Yousef

On Mon, 29 Jun 2026 13:13:50 -0700, "Darrick J. Wong" <djwong@kernel.org> wrote:
> On Sun, Jun 28, 2026 at 11:25:13AM +0200, Yousef Alhouseen wrote:
> > xlog_do_recovery_pass() only writes first_bad when it reaches the common
> > error exit after processing a log record. An earlier CRC or corruption
> > failure can therefore return without initializing the out-parameter.
> >
> > xlog_verify_head() tests first_bad on those errors and may then use its
> > uninitialized stack value as a log block number while searching for the
> > last good record. Initialize it to zero, matching xlog_verify_tail(), so
> > an error without a recorded bad block is returned directly.
> >
> > Fixes: 7088c4136fa1 ("xfs: detect and trim torn writes during log recovery")
> > Reported-by: syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=b7dfbed0c6c2b5e9fd34
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > fs/xfs/xfs_log_recover.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> > index 09e6678ca487..d8125f3add4b 100644
> > --- a/fs/xfs/xfs_log_recover.c
> > +++ b/fs/xfs/xfs_log_recover.c
> > @@ -1028,7 +1028,7 @@ xlog_verify_head(
> > {
> > struct xlog_rec_header *tmp_rhead;
> > char *tmp_buffer;
> > - xfs_daddr_t first_bad;
> > + xfs_daddr_t first_bad = 0;
>
> Why is it safe to set this to the first daddr of the log? Is it
> possible that a filesystem could have a log record starting near the end
> of the log which wrapped around, and later suffered a CRC corruption in
> daddr 0?
>
> xfs_daddr_t already defines an explicit null value (XFS_BUF_DADDR_NULL);
> wouldn't it be /much/ safer to set that here and update the if test body
> later?
>
> --D
>
> > xfs_daddr_t tmp_rhead_blk;
> > int found;
> > int error;
> > --
> > 2.54.0
> >
> >
