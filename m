Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090FA3C0A06
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795995; cv=pass; b=b/EM58wRnSROdPE3vuDab09E7K481fVp938AdrpVZMZg8xuWFeDj7A6QI/VLUvYJBsfuOi6NmhhAw/OcaW+FxSTVpxzuJsWPHj8evObtj70JX+aDtgCXARz4Fe3AnDndWzvWDPoJomDSIVuggvizPH31VazbzJ4X6DHwfgTO7a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795995; c=relaxed/simple;
	bh=DateFYEM8RUPCqkCJj0bcYedClzNO/Bshld4N7qd/Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGwp7xRyJq22RXw9GT3SDqJXu0ijQbpRZ2yVUW0gKToLvWd10N4v3368enV7pHZ/hsWwVc0gg7jPD+B3tHySbfeeuE3tqGRo6VXgnyB4iV5gpHAbhVqyWdUGBHt2gMUpwOYP50HZYYv0GfKAiagGFG5UtksN/L18LzWubBIwCnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJ3Sv9uN; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJ3Sv9uN"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-532db7db0c6so52819641cf.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790795992; cv=none;
        d=google.com; s=arc-20260327;
        b=DjgBwbVVlFKJeDUfNXssILwA22JZqYEyoS72Xm8TXjsl10oUjZPtaiZtoQyC94187J
         rSK3mt5k14gShqt8PNDQsQyodPXIQ4h8Sse72BEQpHXd/bpIVi9NE+NSMFq9AEEsHs6n
         oP5EwDBKlJXziTFyDgQlSA0tNJvsD+inbu1gjk0qmhX77gqEK1nPdXzWOjib1bIGCfTw
         8XveueaUeQsv8iwRxSejMn/ByvetRrP+YI1I/K5Nhys2F/os29F227xeXwH7BIHCEyYO
         rjDc3GDsMFAAs0KfmvszE8Ayok/gry40MrAsEahBIUrvbQ9DrLkMrYpp7+AxkcQtt3Hh
         7NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DateFYEM8RUPCqkCJj0bcYedClzNO/Bshld4N7qd/Wg=;
        fh=t/Gxy7ySqv3+rZkCiCvZoUjK3AwUMVos3h73ZtnY2o4=;
        b=UnVOrhqUf2hgpep1S1z9kwcBSFGGzNIGDn0i6IS1R+N9YGixI5DGFBW+q5RfGaHlJo
         m+fzjcPgHQIRd5td4pHy0B/UXH3fWiojpaO37WlL6VHp+PzUp5hPg4ZIyhZ9cPHXzGcp
         Br9VvdpM3Y4NW9svaKtnobXtItrWAFJV94A8khcBE1qskJXpqH202frzl6MHazVrVuXX
         sH41VelkkjyMcArggGmrWy2IDMdD6RRbSgk3TjNkvAYbUuN4WGeoKUhmrPSxfmquwG1O
         n0uCMLBEK8sRnWs7nTv2jrF3BzSe0PVvKUk6hojtyvRdQI03gXrmaDW5cYL6/h7Wir/F
         +9Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790795992; x=1791400792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DateFYEM8RUPCqkCJj0bcYedClzNO/Bshld4N7qd/Wg=;
        b=SJ3Sv9uNhnpIWRPLoH7HhGJYsfwfZyhe7O2vcwCPdOJ066HUByEwRFAbMsmDJbklV6
         l11RIdRoDHb6g9zxLwpRvP/ZiUTLsMhREnGcTKN8oElK0/sI2NyApbXWMQ+E8Fno6U1N
         6umLoYcNew4OzosHScwcdzxSRjA2HV/ECca16NudHWFZmGbg86xCbJiO2XS96Oc1aWip
         AvaXWSuY7kwCzzap0eStlT9Pnqb3CdleVCeE6JiIWmdiDu1oR4Vw6U4lXqhVAUtkawaa
         L0lRML+YxexT3M7pN8jQVyWD4r66CHEcBT5MSP5tGPXeLK3AORlrz6kMWvUH0wRtayz1
         iKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795992; x=1791400792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DateFYEM8RUPCqkCJj0bcYedClzNO/Bshld4N7qd/Wg=;
        b=1PQhSx7oQPq4sf2pujYkquVkmdSVhV9R1EYwD7Pg9a+l3D6HrBfG7c9bt2YdnznEW1
         DHbfG3DJO1lIwoQs2vVLtBGjc/eCWaCNRNjUB+mBqvIvPVYrQiPVWR+i1xDwSjgD/fVO
         5q/MlJRXiYOtpTP0z2EBisG0E86l1l+gnfwIMo69fFJgweQhC+Vtwm8oyCw9x3dKbfvA
         guhJFdUT9IXx0veLmULNu7ku2HogA3xITU1oZOJoFIjiri4Ja7tTZYgcL/5i4eG6u+wn
         ujmY1Vk/FoWWa011Op2CXPBKkVN5ETM86xbMueKOxcxbpp66wUcnSzuW811SjJ63oUZJ
         3Lqw==
X-Forwarded-Encrypted: i=1; AKwUvBybCdMcdWlWfPachcYN+QteQpZLllU4hQ6ly36rdWPCwx2oraIEyiSynCQH4qOVKYajayleZt8=@vger.kernel.org
X-Gm-Message-State: AFuF++mXPp8kxsYo4SjEEzK3HtMFgzN04NaJxQiJSCwNZP+l+b6GVnke
	WLBRDDQugQM2T4R+O8mvO8TH1Ime/7G5GGjRSufgNviLULrWLvDozOkv+i8cfxIZXE1E4h07lCH
	YcBOelgNHoaR7uouDMVulxzAxUfi9ejW7MM3JPQbR
X-Gm-Gg: AYBFou2mixFwjKnS8OTFTWesDbUpDDQqqXUKlPMzaP4IOLQMgmUo5/wyJYek6iDZm/2
	zp2ErG5BuXoGb3WFAU6ABeKCP6b+Kxf4pg6RN8YeNxw1k5SbH1+yLw8g46HBADatrQO3X60SGNW
	ekAcvEmRJr+pcyFogvyBVRuu4Ihdr0vjo7Ak1rsMa4cqiA+Y/cOX9OsGK9b3TKhzY/tpa6PXL5O
	+Eig5EGkd5jZadq+AxpUl8q7vhtB93AGhhHVo0tSrYlgM1xfB0+lThhfOAgFtfailouiwI4IUbv
	UI4EEpBTPgRmw22B1b4s94o9NUgzMR0ew+tZVjs7rKXhSdUG0PSyYU5xnhUPigMPv0voLkVaZPE
	CQaLKSSUEccgWIYVH1xIj0Mj7t3s4uPgDl6C7KdQq/rHpd5i/YLYj2J3+L91ka6zfNYFc
X-Received: by 2002:ac8:588e:0:b0:533:370c:75fe with SMTP id
 d75a77b69052e-53374be3ee5mr46752231cf.34.1790795990138; Wed, 30 Sep 2026
 12:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930181106.271547-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260930181106.271547-1-nicoyip.dev@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Sep 2026 21:19:38 +0200
X-Gm-Features: AclHuK92DSJl986_dvvpkYAOimgT3MaQg3DtlnvZZM1zBmoeCA_G_FvqALGK5WQ
Message-ID: <CANn89iLvY+GUVDQi0HLf6GSes9trxDWq_JRTiSBPTjjLib9pog@mail.gmail.com>
Subject: Re: [PATCH net v2] net-sysfs: release queue trackers before allowing reuse
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 8:11=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> An interrupted sysfs_rtnl_lock() can drop the last kobject reference to a
> removed TX queue without holding RTNL. netdev_queue_release() clears the
> kobject before releasing queue->dev_tracker, allowing the queue to be
> re-added while the old release still needs the shared tracker slot:
>
>
> RX queues have the same ordering. Their removal and re-addition are
> normally serialized by RTNL, but CONFIG_DEBUG_KOBJECT_RELEASE can defer t=
he
> release callback to workqueue context and expose the same reuse window.
>
> Release each tracker before clearing its kobject. Pair full memory barrie=
rs
> on the release and add sides so that an add which observes
> state_initialized clear cannot install a new tracker before the old relea=
se
> has finished accessing the shared tracker slot. Keep the numeric device
> reference until after the reset so that the queue storage remains alive
> throughout the callback's accesses.
>
> Fixes: b0b6fcfa6ad8 ("net-sysfs: remove rtnl_trylock from queue attribute=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
