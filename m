Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609535;
	b=Sey29t5+WLxTd7Fgq96sGfxkgNO0CIp1JEpFwDLgFrFKOzGHlu1UhtUKGPCAim74pUgU
	 Z0gJyF5WG35iwCRXMLOpiizvf9+KhilheV0j8oZLCvrAQ9SDoZBJENEC7yrz6jw+9ftrE
	 C6GxqnytFAYR4yj4egjJeEHKaPpw6hJ81F1RTAHvRQ+h2IaEaid8xoVspP2/vL27oXnxq
	 6Gyhs7TzFm6fnpEMl0GE5+Z4gPf3GiFts3YmtRrtfpxG3r7sREbMfQSNXonNBtWhEgn8E
	 12/Zlgs8hlIAQwG2oQXnkfCKBxd/qDxDYkhmMdZzlLm6rcchYi3Glw2dswzfps1fnLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609535;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nxtDC3jdfJKgfps5gESrfwqzSgq84MOBPAMS/1JAwyE=;
	b=46cg54egFxbWJ+4Ectgw8Q1uXXP7HMKbfFlhTK0BZ0FQUdlQjvoAMGnaODMD9oQrJGYH
	 eWDSuvspiqcZaS8TAnWO6t0GQYOHk1rgMxJMVJsxKHLjO8l+aFptq/MpKFT3KRq2Q2lyj
	 FJ0gL8NLVdyrUt2OuIqyZC+BrAOLqfKV8K9imlslVEyig+ECYwlr7lKnZ0nmn/xZA3pyd
	 9BWgXWdt8UW3H6yUY1if9xlKnjRBVVyMK7EX4fWX/US9nHctLDIpF29FJ+4GXQDqxHHpI
	 zh9+NycqPMYMxjQya4cR+xQ0Yo0iw+bEFb+3UDkJAdWaQQQ70+EXKT9RXc2slaS6O4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCeAj4a8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9B606A321;
	Wed, 25 Nov 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCeAj4a8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C3A1F000D1;
	Wed, 25 Nov 2026 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795609534;
	bh=nxtDC3jdfJKgfps5gESrfwqzSgq84MOBPAMS/1JAwyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MCeAj4a8W7rINlxO/Of5E3o7tRlESKGuvFS6zHS9be26Y/3Nbmh3vUMQGLAuJwNxI
	 /utv0W/IsWq31cCt0HDg/L8zSW6eUVRMyQnFJTHAQJk9B0p0lJgC6hcIdq8SDVekcC
	 KMjb1cXYE8CBE+n+BkVzwWAVR7j/vXMExEsJwCPwlpmpk5wGJZEm2BlFFVh6jxSvBh
	 yTjOBg0FIH/cIj/5J1+BWS2AYpL9nkiAU0ktUFUyUDYfvUazGOWHeoNlwwZiVDzLb+
	 uOkybob6UmN3C/mTY1Qt2VY00p/jG1DUv0GCZ6uYil8F+4/K2hB3Sy52TCqevWFob6
	 lcZtlj3N/NWDw==
Date: Wed, 25 Nov 2026 12:25:24 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "chenglong.ma" <longpareto@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 2312891301@qq.com, blum@kernel.org, 
	co+6dcbccedc9ec6452@bugs.sh, eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com, 
	kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lirongqing@baidu.com, 
	oss.patchbox@gmail.com, p@1g4.org, phx0fer@gmail.com, physicalmtea@gmail.com, 
	sergiiushakov@google.com, shubham@octane.security, stable@vger.kernel.org, 
	stjepan.poljak@gmail.com, syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com, 
	tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu, 
	xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com, zenghui.yu@linux.dev, 
	zhaimingbing@cmss.chinamobile.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <awbTgufgR4Uge1kJ@gremlin>
References: <20261104081535-mutt-send-email-mst@kernel.org>
 <awWOpS3HR_2FTN3I@gremlin>
 <20261125060533.1296-1-longpareto@gmail.com>
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
In-Reply-To: <20261125060533.1296-1-longpareto@gmail.com>

On Wed, Nov 25, 2026 at 02:05:32PM +0800, chenglong.ma wrote:
> On Tue, Nov 24, 2026 at 01:51:29PM +0000, Lorenzo Stoakes (ARM) wrote:
> > It looks like it doesn't need VM_IO anyway, the other changes in the patch
> > make it redundant AFAICT, so you should send something like the below with
> > a Fixes pointing at bb2e6f166547:
>
> Sorry about that: it went to security@kernel.org (hence no lore thread),
> I did not test it on 7.4-rc, and you're right that VM_IO is redundant,
> since vduse_domain_set_map() is the only way vhost-vdpa entries reach
> the domain iotlb and it already rejects anything backed by the domain
> file.

Please, in future, when you submit something for a kernel release, test your
change against that kernel release :) or get your LLM to ;)

>
> I'll send the one-liner with Fixes: bb2e6f166547 and your Reported-by
> and Suggested-by once I have actually run it on current mainline.

Thanks!

>
> Thanks for catching this.

--
Cheers, Lorenzo
