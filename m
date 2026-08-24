Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77913FBEA5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585921; cv=pass; b=Lif5VlLnLJGS7bg8G0jcEazDuQZucaUYoXkuv5xWVZQI2IilUifMXnDjnYTH8nFxqHfeFXDQHVGgsRKPotefFzcxkRgYgqgHD9sDfteCrveAGd+l9Sta6HDYn7Jca8+EX8qoOwX3AMwEoSbz6GQF2xw/WfCNyJ1Tptaqy0Ljz58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585921; c=relaxed/simple;
	bh=r/rBsZLsnbKK56csNU7DLUDOFSeqrsm9xyXckzSU3y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGwLH3bxm1AlAHi/zJUPv0dRn2gOtzcPAFypdvSwy+t0f01JN5UV8Nna1zy/paDQdxbxI6dY6sMiarAbhcRJEMj6M6pEEf3D9yJGud6RFU3HxxpaxXN5cTTm50etmVv8s+LQMfHfotB/o+9/kv50ubVOqpXEAJ9RagCt9imsd3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggDpm/5s; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggDpm/5s"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8200b55dc47so56380747b3.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787585918; cv=none;
        d=google.com; s=arc-20260327;
        b=nJLloM0TFcHVeZhqXvyPCb8nKahhQyKHQf4myTWyNsaofluhvxMLDDuw17lzSvUrBp
         eIytlt1Jgj1qIRLr/I5su4ASquMvNN7wLfQcjJzJFPye5nY+OrJRPG1sikHAf2PXpntG
         G0WO+6ZinlFTrt1fDYL9mCQg/yGlrPyAGQAZPhI0HLk2MvdzI5dKn104F3MocF4q8OgQ
         FVCJ6H3P4o5w9FpAOfiBrxp+6uuEZkCKHHnxMtM7lIqIRPgEe5joAciYJM9HdwG4+cgE
         oYEmMtLvsmAKxhq3R5eTL51m3qQaqL3l6/Lupp0XCK9POswvK5iAhsk6NlDyxKmKUzUF
         wOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=US8S+/vV4WhR6o6yHvOZ5lAXa57QYwX5/z8fvhYXu9s=;
        fh=qU2bouraeagiglytYd3hUu/p245O8Fee4xabc9HUS5I=;
        b=ViX9ipFgstRJiqTHiDRId5k/W8rAr2kh+Y3BbaXNazyHYpM3sOC7Gl+DQfdvGKH4/p
         Ogxnr4RwZf7RYZbQeZcmAyto3aVC93ucrlw136maT6C1nT8t6Nv+eKy7UtVDhj2HRc17
         yTKHCjqm3OV9dkoh4Dbng9FkPcZEAd2vJo7K/SPwtmX2U31TOeRfYQ7YI50sw2tEFdGy
         vDorpPAsI3QrjKRXcjS0WjKka4Si4oqlx33EDyac8+mo4diOgUUQJlRZoEPZh44v1xm+
         xRGdtJUMdCpSNFlnespCN1cyoHR0Ym+MeWGHc1S8CldCVGzKF33rHUBEBN4rx8BAThuL
         9IYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787585918; x=1788190718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=US8S+/vV4WhR6o6yHvOZ5lAXa57QYwX5/z8fvhYXu9s=;
        b=ggDpm/5s4hYiD0nBQLHIv80vgLEL3P28ee8wEizRCrlGbo+qFYujhEFtwYb9G3eJZo
         6ULamtk43RdjNjFndOdW8NQe3EBWydsigJIHXYFhZPzYSck1L16pqo5gmyrVI75BOqEL
         0eJZuI3ab9LvdNHQkSqz1euZEfpJRKkVMjtOiAz5CFPwKlq6T7+Y4+MYVxcZN3lsXxwZ
         gvZq0iLNQsOCFEYAamCwQJP4+bw1Z9PORTJYgnIXl4DeNmM0oenEW15Px3RLD2Khisr4
         +q7XabsvqCAhabFe2GVvdEGcDZvddSPCvop69Pnc7Dx58tH+hXZ1BizilYY3h3BZGXlA
         fwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585918; x=1788190718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=US8S+/vV4WhR6o6yHvOZ5lAXa57QYwX5/z8fvhYXu9s=;
        b=YJbeiHde4DYWA79CWSB+DRUXvdll4YhB9/Rx6BbMPJMNigWodrZX2B89I11G4l/h9Y
         c7wk7czarPeiXJwfrzqhxvZl7ldOz4tb5SOnBb1XDortgkPMxECdDTf5Qm6pZ0Ps6CUD
         K4q+gBqGPS/WEpbkzIOZ0ZfPQxRq5gL8OVgkVcjH9EmdSz6bYikpJ4JYaFLl+0lAqhyh
         KHssi2m5QVyMMWY2BR3b1RA1SiO+4yp40mafaB8/5+qPbebVs2oPZSWgC2MKMzuzFIKo
         Z+19/hdFE675zHOujQ58OvNKSRLQq7RKu1thtMTv33GwtjRr5fNwchav3xU5ZCXwNT+X
         OLBg==
X-Forwarded-Encrypted: i=1; AHgh+RpJFU1uCU9D3cURsrMD+DQOB7QGWcAxUlVXWPGmaVaJBP7YWVFzoeE3/Dei9FNociQul1eD0As=@vger.kernel.org
X-Gm-Message-State: AFuF++nZcxMbx/pF7jktT0LOdT+lqjcGVGEJRUTtiKsbTtQNQ7T0htWu
	ybNWw3HKSE237+W7yZEyY/cNWRd4bLWHmrXOkyo3qp0SdQ477o01crnet41Sw4RDsWnsyAJwEVQ
	cy80xTYwpZ8sTfmSKa34DTjwGo9vE23kmVKWZyQjT
X-Gm-Gg: AR+sD1378zDH2tECAutn/+dA8Cmt8V5FSqW66OJE2354dq2y4s4SKO360N2NzFFe9iE
	RUmS7qS3KAGPO8xJWMndvnTnYIgk/5D3gVR0rvVFsxASpGnInr7YJ5tqeHVMg3bPxzcfPDjhCC/
	mrLmB6mqkzxfiqGoR6kEZaFWbrk+dPXglac2rUp8dbppqjGO+bpBi1zp3KiB0fKOosZ16OxzXHB
	NGYVPRLt9fVKHTs/uda/BvwPmlXv6IF6rJVvprSkyDbmEgxmULwe0pHlaaVtdFxgwyuwnlKHtrZ
	I2pOkJ/75f/DZPM2ScYp7QVQp5Pk2moqpnQJL7lYxB+n7t/f5gbqR8LTjpCSblZ8fd/bjCrficB
	kRsOek/A8sIjno5JHCmJBiugUxk0oaWskc9ZHQ075DRjJerV0aqmKtxlY
X-Received: by 2002:a05:690c:4c0c:b0:81e:ae6f:ac0a with SMTP id
 00721157ae682-84c9ab40a13mr67850447b3.24.1787585917172; Mon, 24 Aug 2026
 08:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824152331.216494-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260824152331.216494-1-nicoyip.dev@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Aug 2026 17:38:25 +0200
X-Gm-Features: AcwNN1VGaZ8jX-9PNXsGat8z4kM1LdecEHINx1LTgqGE9iX3p6f8jiKqC3XBxpk
Message-ID: <CANn89i+Ms_cWNb-EhVi+A+VekBEJPy1kNvm65y3BwJ0k3q5QLA@mail.gmail.com>
Subject: Re: [PATCH net] net: pktgen: keep device lookup under RCU protection
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Qi Zhang <marsy12010123@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Alice Mikityanska <alice.kernel@fastmail.im>, Florian Westphal <fw@strlen.de>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 5:23=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> pktgen_find_dev() releases its RCU read-side critical section before
> returning pkt_dev. __pktgen_NN_threads() then sets removal_mark through
> that unprotected pointer.
>
> The worker can concurrently remove the device and queue it for RCU
> freeing:
>
>   CPU 0 (netdevice unregister)     CPU 1 (kpktgend)
>   rcu_read_lock()
>   find pkt_dev
>   rcu_read_unlock()
>                                    list_del_rcu(&pkt_dev->list)
>                                    kfree_rcu(pkt_dev, rcu)
>                                    RCU grace period ends
>   pkt_dev->removal_mark =3D 1
>
> The mutex held by CPU 0 does not cover the worker and does not delay an
> RCU grace period, so the final write can access freed memory. KASAN
> reported:
>
>   BUG: KASAN: slab-use-after-free in __pktgen_NN_threads+0x241/0x280
>   Write of size 4 at addr ffff88810dab804c
>   Call Trace:
>    __pktgen_NN_threads+0x241/0x280
>    pktgen_device_event+0x24e/0x3d0
>    unregister_netdevice_many_notify+0xde8/0x1ec0
>    rtnl_dellink+0x35d/0xa90
>   Allocated by task 92:
>    __kasan_kmalloc+0x8f/0xa0
>    pktgen_thread_write+0x498/0x14e0
>   Freed by task 0:
>    __kasan_slab_free+0x43/0x70
>    rcu_core+0x50a/0x1850
>
> Move the existing RCU read lock into the sole caller and release it only
> after setting removal_mark. The object therefore remains alive through
> the dereference, while lookup order and control handling remain
> unchanged.
>
> Fixes: 8788370a1d4b ("pktgen: RCU-ify "if_list" to remove lock in next_to=
_run()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
