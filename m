Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794365977;
	b=vf9zG5uEngD3eYo+/svX5D068nXFwfsPfaf6n88OK9icAGWTYZcShWUnIU09tqdKiPUB
	 HfZUJiy5Of1p7n24bHNYEZtRtyt/dGKX3LK5Fso/gTbnk116dnz/4XIK8raCvsK7dX7SG
	 hk2UgKrUKWnNmQjWQUvv2ya3FgHPycrYOebtm+C0qCB5njMW1UV9ksEgw7TaOhpkyJq7T
	 AC9On20InYb576OdXdIl4Cl5MU1UmGdJr5lhNdjk9MzpAvAj1LYzYpt3O73Yj6H5AW7hl
	 YwCWZXlwBTTJeaiXpBT70Ya6PycFdPlOg4g/Xj1Xn5h7eFETmMA5lX5n1N01dIuR0SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=yF/QEa+YLx6u0tDN8XzRoPCp8ufm3+8FeFeIZzxKj1M=;
	b=ZzMAGi46ZwuKEYX27th4OBZ6eAkJyNJT8rFcVCu/YsXn6eFeB0K1PFoCKO9VC6J86l9v
	 CXPby4SSSDQYQvxvPDe/hgmC57QuK+YK68dUqJKjoaVizidQqMKtUM0uagtNLZKRI8LoD
	 eu4i2vOwAMoqET89rsrs9h07J2T5nDgG7I8HyRVMJcQYGNqv/KGzcG7jFdw6eo643fWfE
	 Oa4WLeMGDMn3OOU+pOdBPAapKwlR3tuv9q+A9iE6ceHSMc6lN6HA5DLa2IFSRi2mjUtu/
	 jsUiwQIgSyI25Wcp7/JCMMUtVLPLCKBmyhoiTTzjikgX4nEImIYuoNG/TK4ttWxa2RQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oQwVURhg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25A8E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oQwVURhg
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1787294f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794365975; cv=none;
        d=google.com; s=arc-20260327;
        b=JRkMXskJISkmC7AKZchKGnBDLNUUonw6YnAp1h/lQ70e+p3AspjqwQsRneQ348/j2R
         b4PAOue2N7G0PeHFaG6gKmPLmD/o5svt4VOM5r+OlCPUeiNa7RnbQqtJJWxc4WKRyzLB
         kR+anGdVoizJNE+Uxh5TKQFmyCPpf596QGc1zW18zjvpRxbfFCABKFKeLMPu/vaDuSG7
         dLwOr5DWJyenU5nxO+nfT0IOvuii3eKAGHBiN5sQlpAiLIngA2vxp6o+8DzDMGWMSc96
         FXLOBysTTUgB6EfUbq2+YNX2/ezaN+aiZ8EPvH38n/BrdTr5Mtqad6MOWtrz1hScw/9F
         XPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yF/QEa+YLx6u0tDN8XzRoPCp8ufm3+8FeFeIZzxKj1M=;
        fh=lpMtJFqMK/4HH7HS8y962/Apx8DYFt1nAJooFpPHKIY=;
        b=oHhch96PM59kZ4I2BpbsXbg4JOwJYzvPhE5oqaL8g8P6dJz1oq+JahqO2+9LplxJ4H
         0wsnbGG0HCG5LVKJHp07x+uQYC7ZQFw9/7jpqXyxZmNm+Sf6o6JKNZdry9BJa5VXvVuf
         ODsuIUyl8hfaHEPyiqI+b7FavYzoR8Hsgf23jh2lVZNHHZCfMP4dCzzmHdUVKW2IzC5S
         GrE9d64a7T/m9oOE6NMwzAP9sDD4To7yDWH30QzKuMngtX9qYcZd7jyh3iQMNgoYqxMf
         WcFt8KA3SBJ1EKhx3OpHhCiYMXLsAdLK6Z1+aHkRvT4Zykiuq0WTovyw8F9T4KfiY2CU
         HeQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794365975; x=1794970775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yF/QEa+YLx6u0tDN8XzRoPCp8ufm3+8FeFeIZzxKj1M=;
        b=oQwVURhg8bx++jYZc1Alva74GVfw9vESSs2sR4VYghs0WyEhPqFa2LEoLl20LPEq2g
         uDjYY1NdbS+DGGT0cV/3PPoUoyuAzixHRF+Z5IW+LU33R4I7yzHpjMjgcfAMqvbVQzPj
         W3mC1lJ86TG55yqiwvOeQYeql5gtA2dgJXi7Lel04XEX6XsBbnqxIQzq+yeIkEz2N16v
         yZBtVY1nW6nupm3wsUOrsD+TC/wLAEw10HtxhOzUHl3cSdMsGCJwctimHAWh01T83/2+
         S1TxGSxYARCnZM9E45gQMvOBGFa8U+HBzytOk8fp+AkiavfSZnpUorxkwC6A7Oy/5XdQ
         u5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794365975; x=1794970775;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yF/QEa+YLx6u0tDN8XzRoPCp8ufm3+8FeFeIZzxKj1M=;
        b=VwwZY4JBwI0lkG4w/uglWsNx7mlhuVB518X6rZac0/8FmeVU8gHUJrJJi3K7M673lv
         YdWcXmwA4parWqG9uUouK7IhfMhXMxRSSfpwQbsMnD7pBG2VhjUFcjNVfv9mQh9FfOpe
         h0Cu6Tkvo+plgnGXkBMeX0Ga1+Ibcd1uib3b31ANTkKb+ErJd9F5uunZZtPnntgupGCh
         dZAcgT97peBChNXcbzEIWnBhiVb5/CR09KdwPz0g8LHN6ZrpQ9cWPFOyyMVDEyp9GHR8
         KQ+XhDnPkOtQuvRjj4+5HpWiOA0XOcxo7+cs+pP7WHj2kS0vOrjKjOSav4LsTnuPZAoQ
         k7jw==
X-Gm-Message-State: APuU4Z94UEcLFmXYErZCQjJtnuF67VkldQBca4+hcubGYJVS/KqesWRR
	AyEtgl6PmGKGuyQ+mxnHz4+8TuJW8YSNQ2bqsLxQ/+Fn/vq75l03HO4OXSTgHaIRfKfXS1ebEgG
	NpHFmUVEmTCX9Ne3V/rGIr4nHfOJlU3g=
X-Gm-Gg: AYBFou23bUO2SINjNnRRn0syGbSYLA2JJe6kg5BfwXV99XraNjCS0vmq0yv7hV5GPdV
	26zr9lUCkrGkEiC2qT8TlqsrCPw0547B949wAkioGlszo3RQhm75Z5BTRlsiK/u3mvt4fXwH3dZ
	PJT2sOmyTP2lG856+Z/yjGzRABvzOww/nknttV2ksXu1zbwbJsEwtkN7DaD4u1xOMFD9u1T0EUs
	GNFH83F8yVkGutsydBYeoDJgqld/HDIOJ029oKLHX5Sk+NjqtiGQuFP6ylBsdvoKxU6yOHlGEYv
	NDjYdgL084BNfXnLJXejS/CdhYNCyRf1o2ugSu3oK7HlF3sWqiA3oY9H0RXm1nvpz1atmk2wGtA
	9wvdIIBhXVzkMtdaRSKwyQ/2h3XIcoVs7Z9LjPw==
X-Received: by 2002:a5d:6f15:0:b0:492:aff5:da4d with SMTP id
 ffacd0b85a97d-49995ea1713mr2183397f8f.7.1794365975321; Tue, 10 Nov 2026
 18:59:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107054332-failed-6.1-7131aaa74bcc@kernel.org>
 <20261111013114.470246-1-wangjianjian3@huawei.com> <CAKFNMoneZ4jzi025V4w4Ep2N_VpHediHwwoe7TY6OowVjmq9_g@mail.gmail.com>
 <95941b27-84b0-4895-a473-a584533ff0cd@huawei.com>
In-Reply-To: <95941b27-84b0-4895-a473-a584533ff0cd@huawei.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 11 Nov 2026 11:59:17 +0900
X-Gm-Features: AclHuK8Ia3-K3RD1panpzcV1QsMkdI_22npAWLYKTkEHm9AcJYZM6TioJpH5YrY
Message-ID: <CAKFNMo=4wrPE+90dSkA06TzgiS7pWL_BOGB5ckbSJm9yx2EYwA@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] nilfs2: ignore non-fatal signals during synchronous
 log write wait
To: "wangjianjian (C)" <wangjianjian3@huawei.com>
Cc: stable@vger.kernel.org, 
	syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com, 
	Viacheslav Dubeyko <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:10=E2=80=AFAM wangjianjian (C) wrote:
>
>
> =E5=9C=A8 2026/11/11 9:59, Ryusuke Konishi =E5=86=99=E9=81=93:
> > On Wed, Nov 11, 2026 at 10:33=E2=80=AFAM Wang Jianjian wrote:
> >>
> >> From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> >>
> >> Based on a syzbot report, Wang Jianjian pointed out that following a
> >> successful directory operation in nilfs_rename(), a synchronous write
> >> requested within nilfs_transaction_commit(), triggered by a sync flag
> >> set by nilfs_commit_chunk(), could be interrupted by a user signal.
> >> This interruption leaves in-memory metadata updates intact while
> >> returning an error, causing inconsistency with the VFS dentry cache an=
d
> >> ultimately triggering a kernel warning.
> >>
> >> According to "signal(7)", local disks are not classified as "slow
> >> devices" (such as terminals, FIFOs, or pipes) and their I/O operations
> >> on disk devices are not interrupted by signals.  In kernel space,
> >> waiting for such disk I/O should therefore not be aborted by ordinary
> >> (non-fatal) signals.
> >>
> >> Suppress this issue by modifying nilfs_segctor_sync(), which waits for
> >> the log writer thread to complete synchronous writes, to catch only
> >> fatal signals via fatal_signal_pending() and return -EINTR rather than
> >> -ERESTARTSYS.  To complement this change and prevent the wait loop fro=
m
> >> busy-looping when schedule() returns immediately due to a pending
> >> non-fatal signal, switch the wait state from TASK_INTERRUPTIBLE to
> >> TASK_KILLABLE.
> >>
> >> This serves as an effective interim stabilization measure without
> >> structural changes until a comprehensive fix for metadata consistency
> >> is implemented.
> >>
> >> Reported-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=3Df6c7e1f1809f235eeb90
> >> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
> >> Tested-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com
> >> Cc: Wang Jianjian <wangjianjian3@huawei.com>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> >> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> >> (cherry picked from commit 7131aaa74bcc7c9da1f1d1c8724da75c775557a0)
> >> ---
> >
> > Hi Wang Jianjian,
> >
> > The patches that the fix patch depends on have also been submitted to
> > the stable tree, so the conflicts should be resolved.
> >
> > Considering future backports, I think Sasha Levin's approach of
> > simultaneously sending acceptable dependency patches to resolve the
> > issue is preferable.
> >
> > Could you please check the link below?
> >
> > [6.12.y] https://lore.kernel.org/all/20261110131241.1664282-1-sashal@ke=
rnel.org/
> > [6.6.y] https://lore.kernel.org/all/20261110131728.1706995-1-sashal@ker=
nel.org/
> > [6.1.y] https://lore.kernel.org/all/20261110132237.1722151-1-sashal@ker=
nel.org/
> > [5.15.y] https://lore.kernel.org/all/20261110132713.1736389-1-sashal@ke=
rnel.org
> >
> > Please let me know if your intention was different.
>
> Hi,
> ok, I misunderstood this. sorry about this confuse.>

No worries.
Thanks for taking the time to put together patches for multiple branches an=
yway.

Thanks,
Ryusuke Konishi
