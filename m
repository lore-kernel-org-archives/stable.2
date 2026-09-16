Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D629A2D7BF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789533117; cv=none; b=ewkRQKMSQGNl531+/1orLvZIHVMoVf/882zCcY2SSA21+ULESoRmKToEa1UwUAWznKMpZwzX6WjgRR96gfrRSmHq6sMKDZy8VHwS5E+wXGScDz87cadRhFD2Dkme9wlttgKGQ3gIrCZFIR1BCR+uDsJVtJISGTOZsC3plMnLWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789533117; c=relaxed/simple;
	bh=7IwvsDFXIGyQVneiPjkwDIbm4hBjCNGR6zBXmO3NAvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO3iM0ULkxEwyicsqOtS/+88vT0hLcbOz5WfJYzqlWNP3N4dbzPAgyOIpTJCntp8vRRQ3BpR0Aj8LIcosRmtyrQKiLncq2UsSk4rn4wr2v9y0WEl6La5aavFQbsSEqxzAstdgA3VJpgp9AQl9/u98hzfEI0tgviljEUHINPV8kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/lORs6L; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/lORs6L"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso3312215e9.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 21:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789533114; x=1790137914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iN5gALzSQ3UoTSX0lJ7ZMyS+cbSjkoJk3CwTBaiWM2k=;
        b=J/lORs6L4oqjsjl2DME+HghPpaLQIT7CVVnZAJyzRl3KZhkqi3+02ACQmEeP+N3mT2
         veHgJOJwjXiOMB/oG3g6EC1coEZr3ovMym9FqpSXlZnKBX0zsbMHGKSMVc4BdZTuig/N
         F2MxAt+XhMQMjptIgaESR1bedirtLBiyKdqd0Io1V1zsXt8+jmu1XspjWiUeL1IY8GnT
         tZirujxevltfcCbeVk2Rlk9xXTkZCmVdxG9VwnV1jk2PdOOyNAFXsKQQO6VPjp9a18LL
         Tl4hnDVmDnIeDBLmCm2rLw14s8xvjKrljxxfCpgs2sJTxqlYXqwiVL8awSsqfz66axaa
         VM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789533114; x=1790137914;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iN5gALzSQ3UoTSX0lJ7ZMyS+cbSjkoJk3CwTBaiWM2k=;
        b=pVEgEa2k983vzPj+tnwxbeRop7lTFkx6cMKdjJ6t0/plYugbrnf8V6nw2jZnlgLLVL
         Hu2PJzWOHhNgyaI6A72MRVUT/fOYRvg3sN2wZrcRjBRSaJuUuEWAq+pWI/eOkffRMLXC
         j5sqOOTGhFBb5aD9IMmsIZXt/JzCvZdyAwqVJN8Zrzl4H+gLVFTkga8ASYyj3dhMzeQK
         Ccsu163YaShDyK1cIObPMKXfek1dOZXJE0Wo6wcT/47rCX1O57DmRtZJgPv6HM1+I8qf
         CO6L5tg1VEhyglt80htUd8ZJAeN+1bo+WP1K3jz/XqKEtiXABM+4Ok2D1wUx4zShHr55
         Q9QA==
X-Gm-Message-State: AFuF++mt85TG8CNFVnzLhlw0+pkhDSa7b052lPk0xalmK9sDeF6o1FqS
	/ZO51hnvE8tzBuKLUmZnQcJPCsHoskb6xn6POTecj7r9qFGwbqOM0AiC
X-Gm-Gg: AYBFou3gGGA2cVunibBZ3km/jw6h7ekArMYN0FZW1AY8H1RcEMUGpzOTmo7q7HFtuIa
	FxPc3rDy8u48lRB+udxvuO5gfpdC53oia1Ycy1cqDELBgBtjpCFVER9IbfiIhjIuwTiEDOxdaRx
	WpdoV77gekl05fEHimn8xZGa7md1C78+EddL/1pm0t/1IG2VvlT22+Jhik7lFot5QHnjUtNgVPm
	BxL0j0/Tlsl1xw0NJpa3nRQijNWtxklLLkFM5zaDfIZXVARgKgVSmMdYFcLl/wMcStYV0G69PrF
	m0FadWQtL+CTFTRt7sJ7EU/YciVYZwDrBBUYkaP0xvuehU36gFZRnSkA9trMohQCOvtGR4TYO9i
	eUrkCpjdg+bg+zVB4hO/FERTbpxTL9jEQtO8An/2eGrKQ3hayNl2pVJ4LjquaZy2JGj9OdzGjYS
	A8Ajg6EHaC98YG7yHmhaJNsGrC7Ggg7cBZMFCCiFCKSPIRnCHl9qhXXFxtA230mNchvL2GQMDRi
	C1EtazkIbKl9jwoYih/jeh9cwbT8h+/r2eRFZf1ltyn9uewExQEs2yU+rLjD0Ej+np/gUwDynDp
	nnztXS5Py5ApppGfx5Gi9oSXuDJVf2kHNA98jf3NVBawLJ5a39VX2gE/xaEY9xxffkhoZ2M=
X-Received: by 2002:a05:600c:c48f:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-49eac4638e7mr16972695e9.3.1789533113835;
        Tue, 15 Sep 2026 21:31:53 -0700 (PDT)
Received: from MBP-von-Karl (dynamic-2a02-3100-adf7-5a01-5cac-d7ee-c105-a566.310.pool.telefonica.de. [2a02:3100:adf7:5a01:5cac:d7ee:c105:a566])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847ecf52sm27170775e9.2.2026.09.15.21.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 21:31:53 -0700 (PDT)
Date: Wed, 16 Sep 2026 06:31:51 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Edward Adam Davis <eadavis@qq.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15 879/935] bluetooth/l2cap: sync sock recv cb and
 release
Message-ID: <aqoaFdvSsDiiLb5I@gmail.com>
References: <2026091453-unwary-delete-b272@gregkh>
 <daily-reply-20260915-0012-re-l2cap-recv-cb-5-10-revert@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daily-reply-20260915-0012-re-l2cap-recv-cb-5-10-revert@kernel.org>

On Tue, Sep 15, 2026 at 09:52:17PM +0100, Sasha Levin wrote:
> > Now dropped from 5.10.y and 5.15.y as for some reason this is marked as
> > adep of something that is not actually in the queue.
> 
> 5.15 dropped it, but 5.10 did not: the backport of 89e856e124f9
> ("bluetooth/l2cap: sync sock recv cb and release") is in v5.10.270. So
> the recursive chan->lock deadlock Karl reproduced is live in a released
> 5.10 kernel. I have queued a revert for 5.10.
> 
> f1a8f402f13f ("Bluetooth: L2CAP: Fix deadlock") cannot fill the gap on
> either tree, since hci_sync.c and hci_sync.h do not exist there.
> 

Those files are only touched by an unrelated cleanup in that commit, a
conversion of hci_dev_cmd() off the old hci_request API. The deadlock fix
itself is the two l2cap hunks, and both apply to 5.10.y and 5.15.y
unchanged.

While testing I hit something else. Without 89e856e124f9 there is no NULL
check in l2cap_sock_recv_cb(), but l2cap_sock_destruct() still sets
chan->data to NULL, so recv_cb does lock_sock(NULL). Closing receiving
sockets while L2CAP data is inbound, under QEMU+KASAN:

  v5.15.221 as released           NULL deref in recv_cb, fatal
  v5.10.270 + the queued revert   same
  l2cap hunks + the guard         clean

  BUG: kernel NULL pointer dereference, address: 000000000000008c
  Workqueue: hci0 hci_rx_work
    lock_sock_nested
    l2cap_sock_recv_cb+0x36/0xf0
    l2cap_recv_frame

So the revert on its own trades the deadlock for this. I will send the
l2cap_core.c hunk, which also fixes the unbalanced unlock you found, plus
89e856e124f9 without the recv_cb locking. I will repeat the runs and test
on some real hardware before sending.

Thanks,
Karl
