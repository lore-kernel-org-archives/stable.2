Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B311E5B63
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788684926; cv=pass; b=F0AoJzWZW6Wib59PMAOsJcRTZr06FuNygb+SUowoM/OsocJz/H7CvQPCJEU6C7I8bRYYPHko5MGjfKijSUXBbTLxKlMNvJOI+unVrgCfXdkPNqMHI4WQMvvHl4UoJ/ny7jEzhtCBI0aD4cdX3mr7F1p6ZXPMie8utvpYgzXsLN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788684926; c=relaxed/simple;
	bh=g5rp3cyruIK/dny6JiV8J3fPMfm3QBwFQNudepca/fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K++/zQb354UTrz8wyLabahKBJtvVxh7IT99czMA2xmn8MF70xsUMi+d+7kOLSBvKJBQsWkHKQ/Hu/EvN9X6MPDliDIE0uQzhP14tR6u4MH5HyaVF0lBMHhKD8/tEXsALQYw4INpr2B9SQXfshHsYKVVfqBoQAGb5tJm/3mzifD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMNl3lbc; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMNl3lbc"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so4230880a12.2
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 01:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788684923; cv=none;
        d=google.com; s=arc-20260327;
        b=mTOZYds8Jp8kyJ5NtAdE636rgBhD1Mnbhce2s1WVUvhy/2uGtD2L9P31tibbgWoJre
         TM4JuIScMq0vo+uZGbaIKj9BTjzjOfGgKPyq611foa1Su/pJO2cyZ5cSYGupQDTmzAZt
         h9QFDxN0f6C1efMTp7LHlLjHKwoH/GQ1R43K71kDFCPwFEguVUMJeI83zSZ/E8yH/Q3l
         vzTxbVpeyY1D4Gfvgpm/Lkqv0p8Eqm1dhY7LG8b0kzT5ix2vPie59/R1G49sZeaxXnna
         jn9/P7q/wCnNVd4qvFFuvuRKpadWgBxTErXF+sJr7lerHPhouCWxyvia6c88HyuUYTd2
         j40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vlCiweKm6MaEMAHJoxQS9a5bn15JS8c/ShWtHG5O8FI=;
        fh=80WVrEaQTcqnxAfNalcQPBB1Ip2OZPjrUfnX7yHrw68=;
        b=OhouPOTGZE+VwXHcqAn5ySfw+w4elFIEN29MQc6sxAlTJnN4dJSGL1xglNt/iPJc0v
         YIV9d7eOHXcBGILzggxBk/YKzE+ZaXFExyNXPvZNvf6daYEXejesVGdTAZ7HphjUtD5k
         QOPWIhilHcQjHTUIdUucFGV5h7e8Fvgemq8YcUJMcFnAWmUsa8l24QGZiLVp9E7C/VBy
         BmH9+Tp1scy3jvwlxXy+pljERs/cftO/n+r2joj1vt7ao4FSnqffCLF+QhtUBE00Vceg
         A98Bf07QABbUnCiXcUrhgvKTmV0J4nSKDLBfOwJ0w08Acy6r6hD4m3t7qZtQMgyQsFLv
         pW0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788684923; x=1789289723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vlCiweKm6MaEMAHJoxQS9a5bn15JS8c/ShWtHG5O8FI=;
        b=eMNl3lbcs2/C2VgxceSyvJxhtRAVJu/iC+3f/V14SPreNpUDGvRllGwCqMZDN4kU7q
         zJYmVAnHXdR82rM0YCwA5474ckpwzCYYmfsGxQr+/+D7ry/BEnPf1kK/t2fnt4pH8DYE
         nZCpkdjvXpS0deMASqyBzkzQ8BTUrAxZwzfv7wUy+unyuK9pjZSUwF3bcEfZTOJKmLS5
         dlwMxV+2iAB8HjWOrR3FSl0dsXBc1rQ6cNGNxHHR3ibFny7+fRe4CCLjolVpoyiSTiad
         0UNjz2+7PeqJHATZC2N8tMXNQ+XzVXirDIErkp4byhvdjrompGP3tlr84dm/9lnz2v64
         mjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788684923; x=1789289723;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vlCiweKm6MaEMAHJoxQS9a5bn15JS8c/ShWtHG5O8FI=;
        b=aCB5d2vwgnHwpOSgbAWWtg6PWg4DDXM/mUQnG8Rf4beS4RYjEJSkf8nmjGejZzZNwh
         CP5w4S9QkPu8+WGIm0VIaCVjJNPrUy2shJDhrJh+rlhWzQ+Jy6M4rEs5wpBsWkDzC4ph
         CndE8ltOczUNkkTHWw8yf2rivajRR5vQzSFnlxNbRP6Q2Vrm0XiqBrCQRaMNuGfxaKoB
         iJMiJJK9P1LphazP2VwDa7LhS8aHf70Z8nPWXKRP0kBYrO44d/v3++1BMydd2bV9x+8q
         l+BaaNoZL1prQPkTm+QoWrG4AO0OIIZgR3CtcoThg7IW/pSmah8mIm+ajjmGqsfW/jF8
         rezw==
X-Gm-Message-State: AFuF++lifMXEMzfEYLN7JdSQjhRq32wO+jEPw9LQSh71lc4YjyQFO4Cy
	jhrceMR/AHQ4NER7zzkwUfwG6VrzeyGE3XBSGaFgJnT+4ukMBT7JS9BEwPxnloLkdg48G87EASQ
	DbxdyvWGSfPWNlIGRYPrK/QlgCu6z4F4=
X-Gm-Gg: AYBFou35Lm1im6cggw2cHXRT941spjEqKMx2utvIJrkreDehQwY/anPpu0txNRuhjXD
	AH9NJRqUuIJVhAu7/HrewGEzkozJiwMa7yzHW15PBEgdETxKt6URmpKofZbq4hSloMOlav3coZy
	24qTzMcG3ByJg6TzFlmzhjnvZ8KPw0guh2OqY5Q0yw7EtfVbJzkf2hf0mdTr0zxN5/SywOem9XE
	NAp4hqbXHUfrhak8/JmhjDJxysmHMRDQMwhqs9rgaPpwFhEUmh+ak5cTU4UChTTSPoUr5QZqN/E
	Oxl9topl5ld+e4v7N1tVKXd4v2ZyLb9NV9HiW8Ao5c6t9A==
X-Received: by 2002:a05:6402:2709:b0:6a1:b515:d2b9 with SMTP id
 4fb4d7f45d1cf-6a7e8e95b74mr244573a12.14.1788684922519; Sun, 06 Sep 2026
 01:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjNxYFJE2J3K=_Ur2LjvF2nnE2B626ef6YUWJwAoirB2w@mail.gmail.com>
 <20260906030833.3356045-1-yjkwon0026@snu.ac.kr>
In-Reply-To: <20260906030833.3356045-1-yjkwon0026@snu.ac.kr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 6 Sep 2026 10:55:11 +0200
X-Gm-Features: AcwNN1VKhWo4H9qm55g2inVvYqN-J9UxuiQgCWUwti_PXb3Wu5tat1-h_fsrtPA
Message-ID: <CAOQ4uxi9ivMeEq1oyFHDc7fdbFOq75uEokXrj8ib5vL34aWYCQ@mail.gmail.com>
Subject: Re: [PATCH 6.18.y v2 1/2] fsnotify: inotify: pass mark connector to fsnotify_recalc_mask()
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Sun Jian <sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 5:09=E2=80=AFAM Youngjae Kwon <yjkwon0026@snu.ac.kr>=
 wrote:
>
> From: Sun Jian <sun.jian.kdev@gmail.com>
>
> [ Upstream commit 4520b96b8136ba2465a3f4dc5c3fb8bdf3d92e4e ]
>
> fsnotify_recalc_mask() expects a plain struct fsnotify_mark_connector *,
> but inode->i_fsnotify_marks is an __rcu pointer.  Use fsn_mark->connector
> instead to avoid sparse "different address spaces" warnings.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> Link: https://patch.msgid.link/20260214051217.1381363-1-sun.jian.kdev@gma=
il.com
> Signed-off-by: Jan Kara <jack@suse.cz>
> (cherry picked from commit 4520b96b8136ba2465a3f4dc5c3fb8bdf3d92e4e)

This line is redundant

otherwise

Acked-by: Amir Goldstein <amir73il@gmail.com>

> Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
> ---
>  fs/notify/inotify/inotify_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify=
_user.c
> index 0d813c52ff9c..905c27e9cd38 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -573,7 +573,7 @@ static int inotify_update_existing_watch(struct fsnot=
ify_group *group,
>
>                 /* update the inode with this new fsn_mark */
>                 if (dropped || do_inode)
> -                       fsnotify_recalc_mask(inode->i_fsnotify_marks);
> +                       fsnotify_recalc_mask(fsn_mark->connector);
>
>         }
>
> --
> 2.50.1
>
