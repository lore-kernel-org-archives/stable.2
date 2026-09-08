Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC2592209
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887520; cv=pass; b=O0Rjbe6XnUJveJbIxhk4oyL5MlM6c+/yWITRxGhPYrcLMVrRT+dtjfltAARjRbx3ojUTFG1HXFfXqgJ3RPHXNwy/xpQTVgajx/eHnbTbUlbEP0ogqxxjLS6tkARe0bY1uvQaRraD20IK09ASFxWhLrE8xqqyKd0I1LzLyxOrlX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887520; c=relaxed/simple;
	bh=Zsk827nev+a0SrWkdXfF+krxDDRI5B8E8B09enubrAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/w/3oUPS1bmelKrDJiMvM+M4Erx5Y/dITE+1pX3MQ+ozSRgKjZyoERjCdIzcVH3P0R54P975nKhV70zuZrmNG+xt7fmZlyXET49pmMSnoK+dX4Xg3jOksLd/nJA9x8k5ORgmM2xtg8YJ+6ZOWAHi7ulDbHg/U++gkIlnbjmGWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hooZ4emn; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hooZ4emn"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-485843aeab8so5440222f8f.1
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 10:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788887516; cv=none;
        d=google.com; s=arc-20260327;
        b=JhBZdZVRZNU3wm57vUAUN+xyhAwQ7Ve0nmAnChi2cTwcJc64d+XBmeMWsVIlDxmzYt
         gQXJiYynBeB+giZ+xXIxvhO3xNPtRbaUAzhrDRHsdB3SHNw5iyp8Cc7VVHVy788FFb4Y
         XL0fK+zl5J9wxkwzARbXj5YR7t4u7NvJGT4JVaFsTr7LgAR5thNgQRDQ2aG1MMMiyyLR
         LlTrooFYfYxJiZvPIoYkP9o+5Kl+2/9w6x6ffyPG3FhfZCNbyQpe3WmKQXFiuxus0D0+
         uOwwGxtjOQIzJibSiALHpmJxqk3GHJL2EPr+I3/bmRQ9xxg0efmp+o1HQZlKeeoOP1h5
         ybHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JbN3NlSht2VbqNXj9ZeLJWGV/jhiHsfZo6fQ2eO9Ntg=;
        fh=aa4S9SK8/LFQlMoHbmtx0g8+dTb0blNhiCehBAEO2qM=;
        b=poB3dqpkgY91tVxVwadtwWGtnCORSHouoxtMJfzQQWiTkdaRKe4wYHLP17Kz8uS+el
         og4oe+udj+qrflSpOGJl66Gb/78eXozWzQbe98R/HGWuePw2mu4UEsMc0pJfGq+KfQ8f
         t12VcZ9pVk/4gL8NzjYTb93KGrocnqHK6A+Cs6+WbgzWwExvM9UPAPii/PfqTytCO1sS
         I40MDxr3SvK9aYKd/mV+hJPAj/4nrO1KHxsi4xR+ndxS30CBSt3kduitrybb+1qzx4Rj
         g1kPxND5DJ8WJ1fx/qp+h4OkMSRQDBasiyb80FxqMAt0uMLEhqLHvMn7e9PYMcxu3JKj
         bOcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788887516; x=1789492316; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JbN3NlSht2VbqNXj9ZeLJWGV/jhiHsfZo6fQ2eO9Ntg=;
        b=hooZ4emnqQ2sz3IqFITVHOecAp8TGKrzUtuRJLJguKVV3yzjnSRDLM0oshZkV8TCr7
         E+C3yBj+7U688oJzgfCEKgrYH+fqw+66Hdv+sJRMUuwF7BtuIHqoxcr+Oo1trGE2sG/U
         szO47Ko1TF7HVjwgEr0wmFNUYjSPl29RnA8qzQahJ/4Xuhi0JBMoaut8lnHrGcV9jz4G
         T94U/hamYA5NlZccpNmeWDYYO2wWLftohJlWsmUWHeST5ZZIf2Ysdb8VMNTEZ0oifKPF
         Ii8JOGbqiPeB1OjqQ9mrmsELe5dnqy1xgWxOA+O/XrHcBtxQhVGYx7zZxDMKvU9oVhy2
         zx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887516; x=1789492316;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbN3NlSht2VbqNXj9ZeLJWGV/jhiHsfZo6fQ2eO9Ntg=;
        b=HYq8q/fOUUMkODUE7hyS3MxPiaKOoUZbBhLgGeqD1WrJRc5lOzKH8OzX0tucs7JYR5
         4utASE71eu213Z/kWohGKRJIzYm4p2dvBv/lWLRsVED5BUwAo3ex8qoH5c1/9lzyxhE2
         XQANer/0wyrELs8x1hIM077zmTwfd5XTYDCN1+Llu6fTW93k/dWL87tByHjvZ3K6Qsyb
         UdAkJo2dX6EuVk+OjvEBICyKqkRGl7Su58L9+GOVVB98gS4iE3bIUHvtV9z/selx2fBW
         A8S2sVvHwpAqUnmYwp80ifqRtf8Ak07c2tPYjDfI59QFi3Qqqv/vcBED6FutgwR9qd2C
         RXyQ==
X-Forwarded-Encrypted: i=1; AKwUvByKdbenEybdAyvXDulPkbF4CvXOYLb3iDbmP+ITsJx2zBfcX01DfcDR9owOctoBIb6rs4ElI5M=@vger.kernel.org
X-Gm-Message-State: AFuF++kMI7Xz8vJxmTWCbkw2mK5dHeIp4tUizehPctLvnrcvKl04Iase
	uHgQGTDwcnxbuaPP4HSl1GXBfyVq9j1VDo/80dhkP/Z9Xn9dFIo1S4ga7DNp/DRfX7uQTLXn5C7
	ITe4GcbDipBt8HGDC0sUF1Y0/5gnS9XQ=
X-Gm-Gg: AYBFou1CkHi8HK17ho1XLxlURdnUadrVyrORjZVKgTEyYUlZj2CZW2uYcTmeTozKjja
	Hc3SDI6GMDLCn35pkEmLSVRVKlqubeqPs9Lr5/VOVNBEUBfeWmBoszpZtr3jOi/1fo7DHZQi17w
	32c5XPPVAyDt0cYK92FQrApFnioCA9pvcA+SAqA5twwaJ4HGcT97B+Ipij7qDzi7vk1W/NlFVY5
	yI98vQg4W6rnEZGcN/XfT91Jq1zqkMZggH1kFvpzR21ZwPc55E/z+C//4SRti4RrC6GpmcNxuXf
	eMj3u9mfWLyrmdFZx8VTQeGtJCVb1z40FrQ360LVO2Q7MtYo6gwI6xxlrHvzmkSP1kB/qKNHLLw
	R
X-Received: by 2002:a05:6000:2388:b0:47f:9283:1fbe with SMTP id
 ffacd0b85a97d-48586bf25b8mr58778399f8f.0.1788887516324; Tue, 08 Sep 2026
 10:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zMhs_DQGah6mRfh2=Q_9WU4tm7SsWWGguUt4h7mXiOFRg@mail.gmail.com>
 <20260908012801.1864430-1-xialonglong2025@163.com>
In-Reply-To: <20260908012801.1864430-1-xialonglong2025@163.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 8 Sep 2026 10:11:44 -0700
X-Gm-Features: AcwNN1VdBkSgBZ-mj0Ebm5R2Qbd2WEyMj2rkIN9KM7C3VNdLM87lpTCQ2fxYk4g
Message-ID: <CAKEwX=M3axD3g2d4bT20hiicz6D57hzV6TGRYFKdd9BonoH_Kw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: publish the initial pool with list_add_rcu()
To: Longlong Xia <xialonglong2025@163.com>
Cc: yosry@kernel.org, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org, xialonglong@kylinos.cn, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 6:28=E2=80=AFPM Longlong Xia <xialonglong2025@163.co=
m> wrote:
>
> From: Longlong Xia <xialonglong@kylinos.cn>
>
> zswap_setup() publishes the pool on the zswap_pools list with a
> plain list_add(), but the list is walked by concurrent RCU readers
> holding nothing but rcu_read_lock() through zswap_total_pages(), e.g.
> /proc/meminfo and the shrinker count path.
>
>     CPU 0 (writer)                          CPU 1 (reader)
>     --------------                          --------------
>     zswap_pool_create():
>       pool->zs_pool =3D zs_create_pool(); (1)
>     list_add() -> __list_add():
>       WRITE_ONCE(zswap_pools.next,
>           &pool->list);                (2)   zswap_total_pages():
>                                                 pool =3D READ_ONCE(     (=
a)
>                                                     zswap_pools.next);
>                                                 zs_get_total_pages(   (b)
>                                                     pool->zs_pool);
>
> If (2) becomes visible to CPU 1 before (1), CPU 1 finds the pool at
> (a) but dereferences a wild pointer at (b). Publish the node with
> list_add_rcu().

Acked-by: Nhat Pham <nphamcs@gmail.com>
