Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528301;
	b=z80BdZRE3HHwlBCZbNk0rnje7N6FGBOC7o9oAMIFvNbcu8fM6hGN68PnqD5r/MsLraD2
	 2jeW5cHju63NqwlEckMZ364sReMzTPD6bygYd2o0HfcKVQQw/W2HVA7MHqzcq4GIC3jX4
	 dvbUPrY/aKR9lYxHr9QSNQbJ2dzFfqno94eJNfbqDTwHtMmYyqyJX6S2LiwUt+OcuxofO
	 6AjTpHwJ2mcULb2efkTjRt2Yf8GauP1s/s9bSOnX7J06USnjHCAywWMf+FxvTAb6aRlkM
	 1vRD8XiuJNzDdGBe2evL48f8n67HXhtHYmW4cpenmFo5iNB+GC2T73nJ+ch+6BfMCdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528301;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wG3ZtixJaFFhkZXxYdcnHox9YkW7VVSHInEX8jMe+5w=;
	b=xMj/Q1VcelD0TV0GOLfhxulp4H8Be/vmtQAmSVc0JSNPxI6hnj03cOoUnTWgKeCy2IyA
	 D/uF+bzdXNY/sEb72fxOVbDqIF4ARDj/ao28hkIrML3FJC8S/r9vLSoAoczk/lJhyFxdO
	 Ld1oFn3wOsfVtSwIqdox4+QvNzCoDRxGZJ8XblX4XpJm2rwZ6KdPEFwZp3iJ58ND19hXh
	 LCGJ2JvFmilXQMCmZ+7RaJyEkgX4VMV11H3FQpfKNVbd619akUR4Fwv05KHEEGqgXO4Is
	 QGv6iOUY232uyd2bACNEvLDsN0q7WzFYZqQuocS9iJFyF6JSwC4cJsN7vA/UaIRHpDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKhJ5xLI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D4606A31E;
	Tue, 24 Nov 2026 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKhJ5xLI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160D31F000C0;
	Tue, 24 Nov 2026 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528300;
	bh=wG3ZtixJaFFhkZXxYdcnHox9YkW7VVSHInEX8jMe+5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BKhJ5xLI57wn3jcdh+k3UYMM+UZH/iP3LwGv3HpcYTAoS7feQKOPpAaR9qn3kUsth
	 vhoY/yvQd+Vbke+6trVtFw2wfac1ic3ibsn1lKpZ7h7zWG3Re5RfpxKcYWb+fRhbSO
	 vkrIYcEg0evcjLmDX6Qs24X0cPCxS5NYQ100VdjZ3HPx1rc39UbHRgyth/e+hZ3oSl
	 tDQpsNq+vvcfGOQu95049GJxDBFm2NcxzC17vmRGtf/8cZ2hyUHR7Nhko/L4bdnUUP
	 ef5f2Me+jA6dLerR0uj8pREuFrxw43n0k6GOh71YtVQ+XClfgJBkVFlbWZo6YZujpe
	 zBcg8RxjFwkkw==
Date: Tue, 24 Nov 2026 13:51:29 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	2312891301@qq.com, blum@kernel.org, co+6dcbccedc9ec6452@bugs.sh, 
	eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com, 
	kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lirongqing@baidu.com, 
	longpareto@gmail.com, oss.patchbox@gmail.com, p@1g4.org, phx0fer@gmail.com, 
	physicalmtea@gmail.com, sergiiushakov@google.com, shubham@octane.security, 
	stable@vger.kernel.org, stjepan.poljak@gmail.com, 
	syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com, tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu, 
	xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com, zenghui.yu@linux.dev, 
	zhaimingbing@cmss.chinamobile.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <awWOpS3HR_2FTN3I@gremlin>
References: <20261104081535-mutt-send-email-mst@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104081535-mutt-send-email-mst@kernel.org>

On Wed, Nov 04, 2026 at 08:15:35AM -0500, Michael S. Tsirkin wrote:
> chenglong.ma (1):
>       vduse: fix VA/PA confusion in the coherent page fault path

This has landed as commit bb2e6f166547 ("vduse: fix VA/PA confusion in the
coherent page fault path") but I don't see the patch anywhere on lore (off-list
security report?)

Anyway, clearly nobody actually _ran_ this code in 7.4, not even claude, as
it's completely broken.

Commit 99fd6bf43d5d ("mm/vma: enforce that mm-managed mappings may not set
VMA_IO_BIT") literally made setting VM_IO incorrectly, like this patch does, a
WARN_ON error on mmap(), i.e. it _refuses_ to mmap it :)

It looks like it doesn't need VM_IO anyway, the other changes in the patch
make it redundant AFAICT, so you should send something like the below with
a Fixes pointing at bb2e6f166547:

--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
-       vm_flags_set(vma, VM_IO | VM_DONTDUMP | VM_DONTEXPAND);
+       vm_flags_set(vma, VM_DONTDUMP | VM_DONTEXPAND);

--
Cheers, Lorenzo
