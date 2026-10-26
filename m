Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029863;
	b=uoiSmoym6DKW52ewAUYVnqzMY2NcHoWM6GW96fqZddzMjBNDFDeA8/U7vjl4WhhNtL5j
	 WHdncqQCaoJAoioMz7YWL47aMghymo/KyJ9U1p371yNFP3ICliVVCCNyriWlNuha1N9Tp
	 7PnhIinFv4VXsVnYHyjPo+NUOTkG5U15yKYWSN687+KlaxAs5pp7cOU7YsnKxmDS9Ow/F
	 57iyo1h0iHeRJUCzUcx2YHcFnQj57GkiLKuw7Qh01H8WL/0bFwybUfOFfrB3vX45TxUpB
	 VAwolfr9LttU3CLGKB6Cy0WvB60lBTJcLuAkr7l8G44UeZF053+ubHEwH3Lcu9ElPGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=bKsgXgjGIkOA8iceV7p3hQ+zbnJh/tzJ+7YRE2rLUAw=;
	b=eGNOUkHW2GSPb5DT7jGJ+xreFaX+v2u8cukwWGVpzFdJKGy/TpNxBO/SdLFpfWYH+1lP
	 GnfJJl1NQpqhGFZcbOKzmdKA6dxjMxpi82anybXz16yM+wKW5aFwfFQ4rqcNT7YMDzQjE
	 vkZ28CPTkYv0NNMg7qqoPT77sfLAt/oktQF7vnQEHQNT5y7zywjdr4u3880I+uG1nNdWX
	 O8eLAGVJmkEwCN9Isd6o1NJBqUaNFpHwX44DuKF2ze9YaxpYp+cZZgIOHhyOL8rovMxUA
	 EDe2zloP0zdCxezHPl+C/hbWtxtLE3jwpu8FperIjZ3EsripnDTAQB/Sy5z901k3qzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X9ZL4rku;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8B606A337
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2C8B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X9ZL4rku
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso1955007f8f.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793029861; cv=none;
        d=google.com; s=arc-20260327;
        b=l7DtEiS/nKF04FS0BXRSxnYt5FJgRZ1rhRFoHOFgqbjhGsNgo0OFXY+MbhcCfhbzcm
         WA4DDkj3MbcjSdJhjjRp/gD91zLwBf82yS3IpbBfGzQKukktecjg4Ii+Qamd9g2w0NPW
         WJR+PuXM+5EMG5+RoBt1N8n+x9Zg8MINo7wbrZsh6sTeXFNF68ZGYKsEhhddappxpvRx
         Bwqz4/q0ReczsW5TsisPBLCpQq+WfSgjdHR4w3swkpnXploWdOGU9g+x/SeQbPTUslkO
         gydlf5dqO0iTQ3dzMdGPcKfXGTSCEnfQDDJ6xEa+MzxnWYXAE7EXvhLkcwvUgEx4b/8O
         tm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bKsgXgjGIkOA8iceV7p3hQ+zbnJh/tzJ+7YRE2rLUAw=;
        fh=BeLXO3eEBTquvoWWYp6LzUpmz0qoo9VjmzHalglQW+c=;
        b=qnDNlnSjug5nHZ/o/8AnDr/sPf/4n+QPx+plVlqu305voFeJAii2EycC1C0jbOgSde
         +ij/QHmxDI+1S/XI6e+QzfOItWtkQoyeoVxxmt52vHFjQNRt79/90FeeHrjVWqoQGpH+
         Yg4AGilygcjivxqwgDhw5bgx9fobrIR6uoGNM1P1xfBvT2ni7gjEjqf9cPpZfg8Gqa/Z
         0Aynhpxzsa/WFM8qwAUh//QWivQFlJPTF3cfqMB7YpzIzTTKkw0Ocf9KV8cNRNzepjRU
         SAoegax6Y6LB2UR1bSlWiGCCLjk7qbk5CyUPp5TmKa7HPeZUwhTG+SShlPsL8OVW9bAU
         zncw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793029861; x=1793634661; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bKsgXgjGIkOA8iceV7p3hQ+zbnJh/tzJ+7YRE2rLUAw=;
        b=X9ZL4rkugLvO7LxSdQ5vS8Il4pgnOi2qXAZyQhbKXSitZBI4ydhl7tcDP6pOCZdgyw
         QqiKsOBV6UmcyddWQSV5302hHGhASyoLLNCDpWla5S2sB6ReUrIUAHMjmq0bFAW53Eh9
         T7xHVqhRw2TSIenPNEhZ8MtXs4YA7DXJni42z1xd7lbLu3YUGuE8RZ2h55GF0+Lp1uwE
         DO+Wo5Nf/ARBC8EHNJ74CQnykrLihY9tSIOAssuLbi6E/pCT+s6233GYLy7IPr0ev51e
         1p4XwZKzZhrnW3D3VuwLlguXPzJhNKQ/M5adh5C3d+RQj2DmG3MhRgRF0yV4P3Esmnnu
         sJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029861; x=1793634661;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKsgXgjGIkOA8iceV7p3hQ+zbnJh/tzJ+7YRE2rLUAw=;
        b=ZRDzM3VSkO7tgUpcFopZD4MC6oAri1M99YL86pez6mFmO890t6q/a5i4D6ymqJNPZW
         I11Z+3vErKI2NmM+5clYbFu11attenvQyAo5gBxvUCL5xa/DejYVne4L9mbNR+yRGfZR
         OiEQKvisVwYtQeDQG0QE2l8wVChKDu0mTcNaxuUj/1zc/bWPB55/zbgokDDLz8mkicZw
         NDJRZdWnfxmMKkCETBQvMIY8LiJp9n8XdE5rfDfAhSb9+9WBqogQ4wpl07E13YBGHB22
         TOkcM4rOPe7aTaUYeR0DV4QAG1m4yzyIJIA+GzlM4/4k4t+cWTjicsb33fAZCwQ8tL88
         eClg==
X-Gm-Message-State: AFq9FYL3mBtV9xRtXuZ1zjGjJqMOEP9unvZUzH9I+cEnPAVGj+ah4FqD
	owt0zyuvNJUW0VusRoJQuvtWWmMybftbThR977gORMcOGKDOVcA6e52Jucm4SJePzFRkR3Qe7sn
	jvkdr9p3QLyzUiOcfybqpiboDhnui7iY=
X-Gm-Gg: AYBFou1LHwp1Nvoq2RC03xoNh2nfSmZ8BmBXwC0FzAZ70qj/HTc685xAqz+hh655DjB
	mWfBXdwiNvrCTl4shUHdtlaSxhC3G5dVvHgcEB/uw39H94shZfofxpJYhuGlR0wfHglfDRyzNk9
	Gsm7bPSHZHXUHtcfZhtsXPyWcX/uv8YesARFds9nFFksq9xIQQxiWd71YuyFGE4zpIsFbnOOUfa
	Ufc1TVlL3141eDVDojDezeRgbWQZnniowOdSzHgpSVg6sWsrvrPZcTOH1wiN/AjwAS4djy1iqlp
	Wx1TiYBI/xFfo0TjVt2cigxslQaFEEqYm0EJt6DdAfBiWgjm8XFGD+8KQjdQ+Ut9ODDlK/+GZv+
	rDCAdBXbU8vrmVT0uh7P6vjYsTLJFRzPlkGXzbS47pUSVY9fhIV/W62M9XYzAbQok+MSW
X-Received: by 2002:a05:6000:188e:b0:48e:3085:7cf0 with SMTP id
 ffacd0b85a97d-48e3eb989d2mr13878477f8f.51.1793029860404; Mon, 26 Oct 2026
 08:51:00 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-fix-mglru-v6-6-v2-v1-0-8c9b40f9fc24@gmail.com>
In-Reply-To: <20261024-fix-mglru-v6-6-v2-v1-0-8c9b40f9fc24@gmail.com>
From: Leno Hou <lenohou@gmail.com>
Date: Mon, 26 Oct 2026 23:50:47 +0800
X-Gm-Features: AclHuK-UIoIZifGedzig0AVlg1gdG1nFGKFJjMrT5d4WbZ_UIqNTGMQni2-e8e0
Message-ID: <CAGQVrL85gG09Uo_+PgGxNOrh+a71eLhsnZn4e93aubpMvXGK5w@mail.gmail.com>
Subject: Re: [PATCH 6.12 0/2] mm: vmscan: fix dirty folios throttling on
 cgroup v1 for MGLRU
To: lenohou@gmail.com
Cc: stable@vger.kernel.org, Wei Xu <weixugc@google.com>, 
	Zeng Jingxiang <linuszeng@tencent.com>, Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>, 
	"T.J. Mercier" <tjmercier@google.com>, Yu Zhao <yuzhao@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Hildenbrand <david@kernel.org>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, please skip 6.12 branch and just use 6.1 & 6.6 branch

Thanks

Leno Hou
E-mail :  lenohou@gmail.com


On Mon, Oct 26, 2026 at 11:46=E2=80=AFPM Leno Hou via B4 Relay
<devnull+lenohou.gmail.com@kernel.org> wrote:
>
> The series backports the following upstream commits:
>
> 1. 1bc542c6a0d1 ("mm/vmscan: wake up flushers conditionally to avoid cgro=
up OOM")
> 2. 13b6b6209104 ("mm: vmscan: fix dirty folios throttling on cgroup v1 fo=
r MGLRU")
>
> Patch 1 wakes up flushers conditionally when a memcg is about to OOM due
> to dirty caches.  It restores the flusher wakeup that was removed by
> 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle").
>
> Patch 2 handles cgroup v1, where balance_dirty_pages() does not throttle
> dirty folios.  See 9badce000e2c ("cgroup, writeback: don't enable cgroup
> writeback on traditional hierarchies").  After 6b0dfabb3555 ("fs: Remove
> aops->writepage"), reclaim no longer writes back filesystem folios
> directly.  On large memory systems, the flusher may not be able to write
> back quickly enough, leaving many folios already under writeback.  Since
> MGLRU cannot reclaim these dirty folios, the system may run out of memory
> and trigger the OOM killer.  Patch 2 throttles reclaim after waking up
> the flusher for cgroup v1, similar to 81a70c21d917
> ("mm/cgroup/reclaim: fix dirty pages throttling on cgroup v1").
>
> Signed-off-by: Leno Hou <lenohou@gmail.com>
> ---
> Changes in v2:
> - Link to v1: https://patch.msgid.link/20261024-linux-6-1-y-v1-0-cf381365=
f30b@gmail.com
>
> ---
> Leno Hou (2):
>       mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
>       mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU
>
>  mm/vmscan.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> ---
> base-commit: 0aebf2870d53a8d97e02a99e2103ea0b38950c1b
> change-id: 20261024-fix-mglru-v6-6-v2-d8bc9d4183c7
>
> Best regards,
> --
> Leno Hou <lenohou@gmail.com>
>
>
