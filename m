Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793156855;
	b=TedNNGujy3M0DRL2QvPUi/LoguZadwj8JH62/VNv+BnWlhr0O0cydUdUjfxG60QnmgC5
	 9R958iHwKO2cyG/r4jEdbSRagal8ZmPBdQQRgNGrNBdqVH2S5xhWT401MqsfJHk7dUKrA
	 gau+jCBywi+NUITUiF2sjSBaX3v8qb1RQcR8OK6R4gv4b2Uvmi7UI1v4ilJPSB8gi8Ef5
	 BHqimZBUihEMf100SHLSKxpNFfIRzj+p5TE2chGsMh7h8UyE2QGgA0jvk3WavLkphkrPA
	 QcJalpkWx9upM4Osidz2oAXWNTPou+ac5jpG/Tx2Be/gd9M/sUD42RL3L37/APVYRvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J0Be1q2Mf9sv1KZdHv7WT6uB4RENkXIH8A5t3SCQfjk=;
	b=25vBintp0hvFD6mHkrFydn0sFUyq3Wlkw4reegsSkONQlIx5WQBgoZGlWJ5fbETMPQP2
	 3/mWt49g+kkVivz301npwToE+aqkYf8tE/BNaRPyA6YE5ka58Ix5msbXE7tWkeiZisoBi
	 /kaRqjHz6B02j9IHT+UwjG4x4j/VqW2nmu6EoM/DqFaKyyczE/HuV4DmdxEUdJm+1Zggf
	 yertHhsTdjbaV+JXgo+pgrAW5Lzsqmp5D6lOO8i8PnoBzoURfNcm6iOwrerRpcLyAlR+O
	 z3I9JB/rVmMHc6tB2kJ+PO6GpnRHgNxkokg/ZvYwUGjatWqWAuN73mGpDp9In0+jWOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ourcRmkO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD11606A322
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 03:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BD11606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ourcRmkO
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so888589a12.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 20:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793156853; cv=none;
        d=google.com; s=arc-20260327;
        b=ALxE4Ceak6h8rqHhU3VqSRC8eRFE830yJyfE2ORp/RwipeaEXIF+79K9GXPGzVsLNO
         biuyjPCCzFr9wUivDx6A6b5ULI3AXpvuaR/kgyvgrViTt1GZNh8vNzS5+VZ5SaDT1v9B
         kAofgUAD5+evlnGpiIP6zuOCesiViRDfDGnOgzfbqQ+9m+qKCZqMwEdqAmdukVjaeGhX
         BNJwLoG09q+KSy/wXy7x6RzPbt4mXMaGe+235XXZEeX3A+B3bCS2cA0z6z76EFLVZpgt
         dhdnTYgdSHvROIGGqtEcgCwAhHrxa4/QM1axQZzLflrMRYxjnCZOsWetud+fPPv5oT6k
         47dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J0Be1q2Mf9sv1KZdHv7WT6uB4RENkXIH8A5t3SCQfjk=;
        fh=2fu6Z5VpLh4EDod+iB6I2RIH+hpFY/9XfTxWhlMxwvU=;
        b=Y9uke7JfvyhBD/oPLztxVn8ITLWwGe7vqYuDFMENEb6C1XKo4YvU1IEGrudr+U4HN2
         n9u12bkTjsf+I5+8N22MmUtG+t82ox3CLaDeDdNr6JJ+I5GctMQKBDnLZpgciVem1e0Z
         wB2Qzf7XhzO7ETuhPJ+nqQeqPyw20HuoP/QS7fGvCLOn1uemDEqtgntG9RAnzE56AkQk
         5qRKKwS1+QiCqeh8RUDSSsCVjWzz+rC/HXthlwWj77gvFlw/fLN/jRmBEXlicFZRYNhH
         u8+S/JTZH733lbeuknPpsuBpJCsBPlTaMejJASbDd+uKsDWrhVkzg9J8t4WxBjRdhPf7
         SR4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793156853; x=1793761653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J0Be1q2Mf9sv1KZdHv7WT6uB4RENkXIH8A5t3SCQfjk=;
        b=ourcRmkOH/IjfAvfCJMqpw8JEzyGEQLLpIyM3oq32ZzxtqSCibGO/9Qw/Zk8dFF5D8
         fq//S7uF6tXiGg9nQZRB6HtoBxFSa2TVcrKRBzBk5be9hIxjLnhroFo6uiFDTIL9+COy
         GKuGIj4CWW+G7mOqoAXg8EaLp0hk8d9+L0PXgj/Vy028JFOIXvBPPhhEJjYBBEt+u805
         2+GOsDyCAQDkByjNAJiQzEGqowmLSCJGi0AtsMpvSTEiIVkZ5a9wCJ1grbRnLH9hZBH2
         l6VXiMFEwb8nUI2eKb8LXhhz+qy0r0h3R++UuQIYJn1PKvc76dEdobFz1zSbnASn4i9m
         2cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793156853; x=1793761653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0Be1q2Mf9sv1KZdHv7WT6uB4RENkXIH8A5t3SCQfjk=;
        b=QgSsh9oEqOWywOoUOtpSeavP4xwOkObZVF5aT7VEyAz7SRr6y64EAuuT0dsZduSFTf
         FP3KgV5zgM3B2bPCs9QQwUFIL1oy95jt8qP+XDuA0v/2AoKNp0a3kTRG5HbY3KkxuVOA
         8KUCWG+asm49xJifZs9YuqscSZ/XnCURD55sUn6A+R4ZUZ1ow/WkP9nBRY4I4AJQjb8o
         jcxdx+RKFWH/aeoxf99/ViNvoYpRdbZ6VQ0rvXG8k1Eb4CBY1jAErIb2aOLzd5uw8VIe
         MyfBrYdVb0W84y2J9uGRuQvaKB3ZF7LvH0Cfkh3jBpKYcB2LSG3NgsgOJMZ43HapUj1k
         TeBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeQoZKHZU7EPkPzuhmJhBuahNpvky+LeYgm2bg+5v23EtXYcoTqoSkbqrfdv/hBpJAmkwIYro=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlq1cV06zeq/wfRAqE0mPMbJX7VotPqMz3i+iQ5Kt21ZtVum42
	RQHDsEDThtKF6pHJGz4Hu8bHFf2YJn7d77wxnbt7wRLS7ENOGIviBfZa/6YkZz5JJP7ZNO3OQE9
	Kwf7B53+orjVjijpSVUajZ+QA7lSNjH3RNHq42Yw=
X-Gm-Gg: AYBFou1XdAHpiS3vRHk0CpnCJr1JfQtqlYngSmcHvCPwqusDUfoXdxwXYHmtgXxyDcj
	jhQt+GdYVbsdVw5PDouqwPmRWccHRb2MWAd2nFaBPjN4DEKNY29+lpKb12jz/0BSaeOgDXLEG9t
	FgK4QbzA4DK1J0I4FT7+yI/mKeXSpihisjNbOw9x/4d640mNyXENdWLv0/KmXlne5+V3aENpio8
	jAOGDpvO2m38CVqZuXFS6XvuFijtwPGzavIKkPyR7clOr2PA1mWQUHv0f58RgVFo+zcaHV5IwQp
	RBBefwOTAvKRCmxR3ZUv7HbkwgS4wXp0NXhzkR+Lane/z/uel1DKVnNate+2L5hvuXVS+GrxB+t
	/ZysQrE9EDqCmEo8viERctf7iSzD3leE79ir/w/Y5XO/H5DN2/Be+6H5gBPBLAvZbMq8=
X-Received: by 2002:a05:6402:42c8:b0:6ab:6e:a8e4 with SMTP id
 4fb4d7f45d1cf-6b49cc24773mr498856a12.44.1793156852883; Tue, 27 Oct 2026
 20:07:32 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027192027.8617-1-dennylin0707@gmail.com>
In-Reply-To: <20261027192027.8617-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Oct 2026 05:07:21 +0200
X-Gm-Features: AclHuK8Zk3JqjSuknFqDZQNv-pnsmVv-lUejnYaLZe-5J4JnZLEJi3oDDiYwgrk
Message-ID: <CAOQ4uxj3et_cyzD1iWHr3_z1dH1R3WQMCOm+kO2Q90TXjaV9pQ@mail.gmail.com>
Subject: Re: [PATCH v2] inotify: do not coalesce rename events
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:20=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> inotify compares the mask, watch descriptor and name when coalescing
> adjacent unread events, but ignores their rename cookies. Distinct
> IN_MOVED_FROM events can therefore be coalesced, losing the cookie needed
> to match a later IN_MOVED_TO event.
>
> For example, watch two directories with IN_MOVE. Move an entry from the
> first directory into an unwatched directory, recreate it under the same
> name, then move it from the first directory into the second watched
> directory before reading the events. The second IN_MOVED_FROM is merged
> with the first, while the IN_MOVED_TO retains the second rename's cookie.
> Userspace can no longer pair the second rename's events.
>
> The original inotify implementation compared cookies before coalescing.
> The fsnotify conversion lost this comparison. Do not coalesce
> IN_MOVED_FROM or IN_MOVED_TO events, which carry the identity of their
> respective renames. Leave coalescing of other event types unchanged.
>
> Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> Cc: stable@vger.kernel.org
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/inotify/inotify_fsnotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/ino=
tify_fsnotify.c
> index 7c326ec2e8a8..6e3af6452dcc 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -36,7 +36,7 @@ static bool event_compare(struct fsnotify_event *old_fs=
n,
>
>         old =3D INOTIFY_E(old_fsn);
>         new =3D INOTIFY_E(new_fsn);
> -       if (old->mask & FS_IN_IGNORED)
> +       if (old->mask & (FS_IN_IGNORED | FS_MOVE))
>                 return false;
>         if ((old->mask =3D=3D new->mask) &&
>             (old->wd =3D=3D new->wd) &&
> --
> 2.43.0
>
