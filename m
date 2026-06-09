Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45335E55D
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017016; cv=none; b=XJfRakQ03qQW4yfgk/l2DxDaVykRWD/EcAHxuhsw+ztU0UDPRdsYnZjewDZXDjaJHGpHZS8tucvXZWw5nF1qFZYAMweQfPgD2DbU8tzn37yg32oxxgT6+JNTLLpUiVA5RehuK3nDbW0AV1WDa02KavrNb9ytNMHYRzcRWnUBVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017016; c=relaxed/simple;
	bh=GIDLiSB6/bfR2KCnN6EIAmwRNYS/DkRKAGn1xuQZ2/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+dVcjFdE5itiDOd/uQCyliJ+QuHXCUvIw1kWoLLN98+zFsayWxJf8LIwqIw+c7a3rqmwLlianOyk6/pxiSypFLY98AL+HFpJIyyYojx/RRoam+XwGr1yzh1Yar9myXeSxmfwrholrINM5eYlBsbCnCt6nic1xfTvbZEOfMCe/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5yxa8tU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5yxa8tU"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3966c0d5ac9so53637251fa.2
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781017010; x=1781621810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlcJ5nf2UKqYYECLIi9kaBUS8dEwUkuhF8Ti5HDx8Jc=;
        b=C5yxa8tUZ4smXhKNmm9i9pfwrTRsdTwOyaaVC2sKzAMXQVrUY0PZZaACuWUjs/b0Bw
         sJPPIXnVuwXq5RhP25Fcn5l/NESfQBDDgmGXV+h5fGVs8FKxKeJqwBSxCK/aC/DZseIF
         Dquk9g6PTgwai9RyofY+oB13hxQkYWK9MNg045BMbR8WTtJl/5S1LH+Wrj9cSBfwlV4U
         j54ias3xU/5Misiku4mNgTu/vopEo4HQfCYJDsfMeXf+91LU/uL7ZHx2IPMqKY2Y7XF6
         OPtVa6bpj+lz29pMx9EdJUhPy1PbWbsMG0ONFg+pm/En77CQWXiuYL0XjXh569ApHUbO
         //fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781017010; x=1781621810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlcJ5nf2UKqYYECLIi9kaBUS8dEwUkuhF8Ti5HDx8Jc=;
        b=tK8ZehbUDtwvxqyyur64DoUp8AVzUejkgjgkJ0FNHhgu6mbtieWJJNUx1/74Im+dgG
         /MzBv5vQbAeNWi1OZSefKCTYv6lDol72/zDGbs6Qnm4k6gD6mAiZbZ/nT1ap01NRrKZj
         PplTAYxW4ZdgPrrX/izxoN/x8NVMuDYYgG5rclNY3t7L16N05w20MKayvi4zzr35frPv
         rxZ6PJwhplOBllQW109zEYifONiV1ZqvzI7c/vsql10wHo0El7iwIbTg9GVbTTW95OvL
         0t86GVJzNxkFiO5wleEKhMIF+l4gTARE+b6slsZK395BXVkZDYBjEbHUHA3xOkumDvHP
         0rPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kbLRGgk4mTsQlx6wv8i1jxJYR48u11hxqFacbO1SKCwE4j/Bi2fCnKfxwLczh/nYry1ob1HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiA53g6Mj1o1LlN/oI8r9DMB4E4EvuH0nIofzPe8hbGwQlYaBJ
	qTkN8lr8OQ6MmE5VaoaxsDl42W0a0pCa0vBxQqgRL0ug5IkQ9YJJXZat
X-Gm-Gg: Acq92OE1wIU0ssZHmLfxRkdHuWYDgm+0Al3O0AsI8BLd6YXNL/uZTuSg6tLZ4o4LMaQ
	/4LFCuovkvP7VBwOuUKJPlseLX66616KjFSQJ/Ex7keZtxBqobP1/GFXYQus3o0gdoYi1/kMW0a
	6iokqz0re1fBIUW+Lbjw9huyCYTIb5MYPajcetiq3JdM+lGJaOt8+EkbGQZ2sbPyzzTENyGqYTm
	Z5M8fTcnDx0KazR5cuKH2DWDppTz8isQ0R7tAL79t8phuoiNyTb2MS76ukjqlPV+S+x54Jb4I95
	q5Cu+knxvlONxCB3BvioCVFzEoNujHp6kp7iTeXuzn6DYZ6XeqpbQiJ1lO1Iqj0/glXwQYU45+Q
	UccJzm9gMxVfEPzacKWGabP0sM1yUFG8F+Rl6j7R0zrx9vJJe1zJgyy3YS1lrUB+nvb3Lqli9ct
	Tl8kf+HIFwC6M2gBP1Bzf7p+jTgg7134BXWBYTFQFNCEce24zxSNjohS1EIjgJ1ZQ8VAPP
X-Received: by 2002:a05:6512:a93:b0:5a4:496:5bac with SMTP id 2adb3069b0e04-5aa87bd5171mr5971444e87.36.1781017009987;
        Tue, 09 Jun 2026 07:56:49 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed8f6sm4644476e87.6.2026.06.09.07.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:56:49 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 5.10/5.15] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date: Tue,  9 Jun 2026 17:56:27 +0300
Message-ID: <20260609145638.1849-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605-stable-reply-0021@kernel.org>
References: <20260605-stable-reply-0021@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, Jun 05, 2026 at 03:37:28PM -0400, Sasha Levin wrote:
> I'm dropping this for now; it isn't right for either branch as submitted:
>
>  - 5.15.y: the bug doesn't exist there -- the task locks are already
>    spin_lock_init()'d on the QP-create error path.
>  - 5.10.y: mis-targeted -- it patches rxe_qp_do_cleanup(), but the 5.10
>    error-unwind path doesn't call rxe_cleanup_task() there.

Thanks for checking this.

I rechecked the 5.10.y and 5.15.y code paths, and I agree with your
assessment. This is not a correct backport for these branches.

Sorry for the noise.
