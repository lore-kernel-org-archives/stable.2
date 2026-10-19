Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07233F8891
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417485; cv=pass; b=d8q8EQ0oNkJRs9xkfNPAHeEnrFpdBi67U9buFBNSx1axjwFnt4LK0wE8zR6mJ4Uf3nqb/UCDiqsu598gohbOhso2qQLlCEWGo3wK/sYGm9FX90I9/SQxCnjC4xUJcjfMbsMqbh9Y5L43C9uzXXUhjQlPSgu/SSD9dXv7/w5O2LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417485; c=relaxed/simple;
	bh=N6otFQ+2tvXWfIAg1Rmz2WPlSNDcEmt3lrNhdwAkn1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBf4cEzdm+ZNl9wUIyOibsk7imde8M/a1j1ZsnMvlQTP11pn/+68pkOZVWq/lbiOrn+ElOb0oal17DTSE1nn6thmHC7wdlN0mB4kR54TzeW4fg3xKegxJYwf6BSYtKafqfhGMqcyzgg/QP5wCANxqlxmoV1fpBD7p71gJLAF2Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMJkUPsu; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMJkUPsu"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66fca0709caso1583076d50.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792417483; cv=none;
        d=google.com; s=arc-20260327;
        b=Wrw5A7/GRWVDzX6dG3Qtv4YYFj8e2kXZp9KgIGuakJLGr+vd4sl1Bd5+45cMwhuoBv
         6m+WpmXbpSRRHp+X1domKdBYEyovrQ2XP6AC1+KLP+RSl97T8Ry/whpyQMzOT9lAVD9q
         YcQ836/Xgk6ny0i8898E3gArhDuHP+/IsYM0B1kL6VZwBENi5Q7x4Al+5m8MKbIQynI8
         YAzGPzuklPD7RmS1T8zxpn7cZbF25dYGU4wTYpyy2C4WGi7j+1hL+fwNrKsICFnzdWf3
         SWFkw93rcifH12pTnIxzNzqwCMzsF8Sv/qn0QoxgCIRZVbBKZwM0hJDt2VTWgUJr0939
         +rXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c6zrnlMaydst9vfRtkenLVpyYJzF31Gchs+iCqt4/Js=;
        fh=Z+6pijKxJRSUsxZcc7qhCtpNbXj3N2kNT56sVll8KIo=;
        b=YnimNL7qbcq4qAPKyNneAqUcBixQmLyIm2Bui+gZTX46ygqtfqaiUgk7w/Kk4k4X6S
         LNJ1Ais9gK2UtaVK0RvfqIclAH9nI1grToBnrP4+kmsKbPp8pD82nPii9f1FdSIPoAwu
         ONdJ0Y1QDL2h5yoS6oESrpn8OHcgpaUcxgl3tPri2m8pulvlgn8qSioPSX2fpN3TBsy3
         O8J9Q9Bt6AtY5jukLcuT9kA35dwV3amSY8uW8sBi3NnackzQghh7CRk3YuMvoim2BRnV
         jInZ5gUFIe1pFIHSOC9OShNwt9qBdg91EU0h7qXw3QnPkymz2NEJ2s7fjJz32yDW6khP
         jauA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792417483; x=1793022283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c6zrnlMaydst9vfRtkenLVpyYJzF31Gchs+iCqt4/Js=;
        b=XMJkUPsu1t0oqb5FTHAqh0nN0qy6nwNumSAxhKyxdMBQDWkyz8dvy3OwUdcMdYKav9
         J7rUr990EwuAOO6+Rf7p/N/RdPKOv+vXlT3m/8Y/UnN6mBv8f0kDzMbMi6w1qhRuN6Fm
         KLLIizDyQU0/nF48oxtIlGvUkKbwuADh5oop+9YCoXq4LqBMsOYBn2ig3jlq41J2MoNN
         sQM4asFhIokTdJ0aTkxh51Xz3TF7ne74++5EvVb5dIdPgHnZuNB33kwDpFUX6qgOt2Mg
         vv3j+qgvllqrBqbnL85i8Sbsr8sRix5zTjOODraxLih9YbAZcbwTLz4S4pJF1iuTBWKp
         i8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417483; x=1793022283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c6zrnlMaydst9vfRtkenLVpyYJzF31Gchs+iCqt4/Js=;
        b=l9bt+G6J5dBJkwzqzIp8LhzCC69fOePLE1jJwD7OK8YCgOFk8aBVGxJddPbYiK7pg6
         D7g7pWfa2DETCNU/95f8IPjeb8mTQp/wi0czgofVBZQaY5q1Omkh77unv8sYosRlqhjM
         QBgL/X0Pi6w/PjO59ii+XvNjTWIuuCJssKPwk/v17FLVJQFCN3d4p0FceuthtQumFP0z
         HreF1EYMR+YDAjsrcVhWXbSiqDFHF3AFTk7haBSGGK4soO0WVoxA+mimRW/LsnbS2oLf
         EmdRQFgl4xFh+n61OHlErsS83TdPRc7zhI+qtYwi3w3bbYdKZpOiG/0QrFCKno8N3xEN
         ub/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwdTtShw8DID1tsVlkcu6GrgHoAnx62BLkC7aIxhWWpPKr9iy9jn4OCshwkW8fOD5yrxZiAJcY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyfWWG7E134e6yec5PaGU1cXpIq3JCz44WNkxEDUJuXz3dHDtT
	EZVYewcIfhjrVqcz1BHInwRW0Jbquv6vbnZ0bWZFOVZKSsQs+UDUkSAHF/tKJyI3qGJ7yu656Gd
	2utE1t+cQldbsR9ant5X3gs6JmodU4ts=
X-Gm-Gg: AYBFou1e80bQLYF+zviloznIxTqsDIli59EvXuQoP9i33OwoLIkl8/+v2lkK9LY0CkE
	3dHLD6g+xA7fJ2oGaRWO6A0aNfX7T6C1pXXizNRBlQSq/ue+50BPA6nfeorcXHjd2sLMwTPkfDy
	/iJcX9iM/bYRuXukt/st7ibaSccjs34pbBNA8kfoNuOjwQpOFwksViHrLywltx5t25m3YO9FBv5
	wpq3ZuOawYaYVTOSJPk56lJAbDJn0hIdFMFlGW1761c6/CszBSi+UNkuvhhkjJWrq9uTXQ63lhP
	bY5thZEyWtLkdx4lUx4R2otlzwjlC0xPLiTfmFksl4PomU9/nVUC2eFIM06FBXDchUP8Rn01Ed8
	qqBpz/BsKUA==
X-Received: by 2002:a05:690e:400b:b0:677:d31f:5a6b with SMTP id
 956f58d0204a3-679ca744115mr2203453d50.16.1792417483474; Mon, 19 Oct 2026
 06:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-ocfs2-objects-candidate-0012-v5-a0413a339b72c02fc885@gmail.com>
 <b273a680-6b96-4fd6-94e6-c1a79922efc2@linux.alibaba.com>
In-Reply-To: <b273a680-6b96-4fd6-94e6-c1a79922efc2@linux.alibaba.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 19 Oct 2026 21:44:31 +0800
X-Gm-Features: AclHuK-1bDPBzjxBFC-g5JhoX08zvMpID73JpPkYTgaCzs0JQP3z-Kv1Dhf22ZY
Message-ID: <CAFRLqsXdt0sDKAkKmWH0aL=urZgWWEwhGjnWpkx5CyDkDqnukA@mail.gmail.com>
Subject: Re: [PATCH] ocfs2: Keep the dentry lock inode alive until callbacks drain
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com, jack@suse.cz, 
	akpm@linux-foundation.org, rgoldwyn@suse.de, srinivas.eeda@oracle.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joseph,

Joseph Qi <joseph.qi@linux.alibaba.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=B8=80 19:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Commit 9f70968af3e6e ("ocfs2: Re-order iput in ocfs2_drop_dentry_lock")
> is what moved iput() above ocfs2_simple_drop_lockres() to begin with, and
> it was a deliberate move:
>
>   Do this to avoid a theoretical (I haven't seen this in practice) race w=
here
>   the downconvert thread might drop the dentry lock, allowing a remote un=
link
>   to proceed before dropping the inode locks. This could bounce access to=
 the
>   orphan dir between nodes.
>
> With the new order the downconvert thread gives up the dentry lockres and
> only afterwards reaches iput() -> ocfs2_evict_inode() ->
> ocfs2_delete_inode(), which takes the nfs_sync lock in shared mode and
> then the inode lock exclusive.
>
> Thanks,
> Joseph

Thank you for the review and pointing out the history.

I will preserve iput() before ocfs2_simple_drop_lockres(). The stale
access is in ocfs2_get_dentry_osb(),
which obtains osb through dl_inode->i_sb after the final inode
reference may have been dropped.

For v2, I plan to store osb in the lock resource=E2=80=99s existing l_priv
field, use the default osb lookup, and recover
the containing dentry lock with container_of(). The mount context is
freed after DLM shutdown, so the callbacks
can obtain it without accessing the inode.

This preserves the existing inode and open lock release order. I will
send a revised patch soon.

Best regards,
Cen Zhang
