Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7832D28314C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781818529; cv=none; b=sB3RGeWR/nad38tvDPohAq9REYvh3kxPC/rgh68t04oCpkDNneI9drhFKhdLjFyn/QFEwTG54CSbhHKxp+XRbEcJ9VeN8nQLJWMB7Uef6MQsRuR7Zf50u3iKW6VbnJxiiVXVLWkNS3FOxIUkw38Wi5sBKszwSMgoF7rD2S2b/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781818529; c=relaxed/simple;
	bh=BJTA1SJINh8QjjGqCnPxManFF1esMCyXGVVbEO/W0Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usYlSNOOWL17HBqix4IYI94S5GH54hjeiqQgXk6iOnHZaThweYNGzsh/CZmpsV3ThmlvBa5vxxgzIT+cEsKTWhr99zpllYl5p+3TDg6JypXr/z33LzjcefsvKPJLi6YLXfa/hCSOhSipuiWVz9wKWXlCLK2CeQHhZ8SX9MGirus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB6aeWQA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB6aeWQA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2C81F00A3D;
	Thu, 18 Jun 2026 21:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781818528;
	bh=zmSQ5/Kef24VChpTyiGbY9lG+wUNBMtY3H2EPqgOMec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QB6aeWQAPBmTnJBPH1Zi2g95X5IV/uzTd0ffD8eVfQko25cCfp5Wllzzu0dv6kdKh
	 x9VUQaSUT7juKJW4pqErLop98auM9bZ/j/yXUK3pGza4XzpkIorNGvpW5GKrULIdvw
	 FgRF37Vsu5h9YXzMnMutt8PrE/pjoo9zsW7hSdMxfNM9chfmgKHmPq927Xcgp1Xuc3
	 x2LU/daQp7ynKD4/GjvmzMal1dP5VZAEw8d6KGSaZMzXBvHfo1jOMRf3gBT5CQ3qBE
	 7GcSDByIX73xhvMW3W3rkVHzBR9ZTaax0ftlOBtObS0r/W5aD5A+6r42+FtlfSRNii
	 QlZIhDMBjo5nw==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id D66E9F40072;
	Thu, 18 Jun 2026 17:35:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 18 Jun 2026 17:35:26 -0400
X-ME-Sender: <xms:nmQ0asm41JR4g2SxSwTIneetUEwtePKAYOnEvPD7vCp2hll4hvHe-w>
    <xme:nmQ0ajz62ScBlLC5kO8BWhXYGNrv89WWUNRgV8ZQjHWAhy4RE3DpDMr0YURunsSH4
    WCrjI_o7BQePWjItGlYEfOfodNn6DBx_DQcwGsRXnbC_N1QTZG8LQ>
X-ME-Received: <xmr:nmQ0ah19l5tNyWqmoklb8DNB5J36mN122nSSHsg9iWdwJA1NuaN4N4jjlfWzWdyjY92l01clR6qF0ADvLuujyztUu6124kdI>
X-ME-Proxy-Cause: dmFkZTEtHF4oNSejv4x+CZMGJFwI1mcILDHxvbFxtmFlokkfkWG6eZOripul+SulmTdRna
    SrKg0p02oqdK7Tbs4WrcVLhKd/1F9KXpfcjbCeFbqr9x5ulJV5P13uLxTTfMZZiGALIKEG
    aXurplv31qP+6zDumS7dTogYcQ1dbnoUsef08ttgugpyOlfUJp4OAkYVakMJqHcUYZV1Eq
    I4g4O6G4aKhKDcUW5rL92nsjtqp6p2BpnQYdQJXUtI5f2WszMVc080C5qE7a8EA9HOD02M
    1iVc/sR7QujHoPZdPO3PxXWX5qnq3+LKxUjKCI0l1sXn9cRIfCLExqmlYhenRTj19yoOTq
    IbCJQhUjhdeAQAx6wFUqu1DJWngNDnHQU3ZTMSu5RR+qYNdavaJcMJAJAHeJFTQuc5bDeb
    Rzw6079uvFdqIfSZvv06HdHG2lwRSBYA6cT2PRmCJCHly/ITopVZhC/aLcxdgj5SHAEFb1
    BqCMQNHLEL0qjrP2eu8F5p0zhM+5a1vr6wxG7xl4Ux+EDrGQpYLITIgdFoKrY9WYaU6ks6
    GVenPVlA01mj8jjAJEu4Hh9d9x/rPlLqdjWNjWpvI6TRg8K4H6TcTbH7KD75xp6TklJpzl
    o60GAEa1rKKNKaSEp7FBRB7o52wg9Ug4bAb+fLlWHF1uO6DYAeG+/2V7g0lQ
X-ME-Proxy: <xmx:nmQ0avCwh-v-luvrB2ifmb_34CuMi1Fb9Y7rJhpDIUlV62PuYN0c5A>
    <xmx:nmQ0am9I7SAGJts3dwX3XXVJOUGoaquoyeRoKclkB8nPwc6MwMm8iw>
    <xmx:nmQ0al_JJWF0q0uaTLZnjCE68kLaShmKI7UrBZZrGvDM9pURmBv5ug>
    <xmx:nmQ0au0L9W_Kl8FRyrt609Lk686ajDsK0iCDHueAlf_PSrYs3CR64g>
    <xmx:nmQ0al_ZWtWW1c6mIR6g_fel5pVs2EJFM9A6iHbG4OxUlg5OZZDRS5rg>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 17:35:26 -0400 (EDT)
Date: Thu, 18 Jun 2026 14:35:25 -0700
From: Boqun Feng <boqun@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: lossin@kernel.org, gary@garyguo.net, ojeda@kernel.org,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, lyude@redhat.com,
	deborah.brouwer@collabora.com, rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/2] rust: revocable: fix race between concurrent revokers
Message-ID: <ajRknQIsXaHtDzzJ@MacBook-0RXW5>
References: <20260618193951.601239-1-dakr@kernel.org>
 <20260618193951.601239-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618193951.601239-3-dakr@kernel.org>

On Thu, Jun 18, 2026 at 09:32:59PM +0200, Danilo Krummrich wrote:
> There is a potential race condition when two paths try to revoke a
> Revocable concurrently.
> 
> It can happen with e.g. Devres, where the driver core's
> devres_release_all() calls Revocable::revoke() via the devres callback,
> while Devres::drop() calls revoke_nosync() on another CPU.
> 
> The revoker that does not claim the is_available swap returns
> immediately, but the revoker that did may still be executing
> drop_in_place() on the inner data. This can cause a use-after-free when
> the other revoker's caller proceeds to drop adjacent resources that
> drop_in_place() still references (e.g., Devres<DmaMappedSgt> racing with
> SGTable freeing the backing sg_table and pages).
> 
> Fix this by adding a Completion to Revocable. The revoker that claims
> the swap signals the Completion after drop_in_place() finishes, and any
> concurrent revoker waits for it before returning. This ensures the
> wrapped object is fully torn down before either path continues.
> 

I'm not sure this issue is a Revocable issue or even Devres issue,
because normally if you have a

struct Foo {
    revoke: Revocable<T>
    data: U
}

and if `revoke` referenced `data`, then `T` will have a refcount on `U`
(of course this requires `U` to be a `Arc` or `ARef`, not very
effecient, but correct). And we won't have this issue because either
revoker will be responsible for the finally drop.

This issue happens particularly when we want to save the extra refcount
(and indirect reference), and I think this is the issue that `Foo`
should handle instead of `Revocable`. So maybe we should move the fix
into `Devres` layer? Thoughts?

(I'm still hoping there could be some lightweight usage of Revocable
other than Devres, hence the ask.)

Regards,
Boqun

> If needed, a revoke_no_wait() variant that does not wait for concurrent
> revocations to complete can be added in the future.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20260612202841.2577C1F000E9@smtp.kernel.org/
> Suggested-by: Gary Guo <gary@garyguo.net>
> Fixes: 05aa6fb1c21d ("rust: scatterlist: Add abstraction for sg_table")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
[...]
