Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971569;
	b=1DFqrcL17zoAjBw8vaZuXkFD7zXEWkvJS7n8idiI+HUe5x/pZKeDFTbpBK/xyu5JXdV/
	 UftKzq4iHWGnnWOLDqQDaZTtUzdk8+WNzG47EuZchrv1fNJN4rylPkQdoySH/3VXGmRcQ
	 PPbYgM094zokwEI4lc294voINgFAgyHBPPfdmHOn/y/Bbe4C7bX/77kIe3WZye61MM6wd
	 1DT0iy3MMgPl96bIZZLPxvUz3adCW1+BFQk79hPynxfGbkyV4+s1zNCjoCV7PcitlT6bx
	 IcaPCyCvTtXHoI8Ek+Vqvbc85RJ/k5PiVsiFGYboXh3cvV/j7a/KNs1fV5OggNuV9ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971569;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=LhMPudYkOtb9w/6jA+5Qtcary7Z+OOpKoB//TNR+IsM=;
	b=F3YtqSJy9OTkVjqI72nx0qiiaW2Is7+sMVnT/okOuQCRHj+jrY+uQe5ub8LF4lxsn6dL
	 a+sfwi2o+MzACRxtKwQLd1EWDZKDaEvTLMtZ9tvCMOzlGG6getlTZ3FR2bAQvfYEP65Xf
	 jvh/42g+n7BsQ4Bi2oTOfrBuYcvlqD+p7b0gzFc7Xd0GJFSvNnf575TPu73vlA01MkZlv
	 iyafq9RUcBy81gIBJY6p/mMEHpsns0Zq4QiKgjc8qy/gJufbhRPL2dBgbaJmniuf/7U5y
	 AhnXKpESBtVjIfZUk/lfKgM6lG0vxbIzBgw+DiHolbMiD32eAClBPNeAhMOX5j71gCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJUy2Xgg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA56606A329;
	Fri,  6 Nov 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJUy2Xgg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662BE1F0089F;
	Fri,  6 Nov 2026 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971568;
	bh=LhMPudYkOtb9w/6jA+5Qtcary7Z+OOpKoB//TNR+IsM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jJUy2XggSeYfC08VrXAlFI3aF3pE2X9jBDo/Ll60t8/0vjuhdp8KSWpN3EmT/w91P
	 lZKiOYqxBPVWym6ycaRZeY6ViHjOwXINvnFJuZo+fXtApUWMZ9d9S6dRTgwrMUF7pB
	 1xvUlLr8S1Tj2kr1A5Sqy0k4kXX9EGqbrlj7FHm7wAugVfSNXCI7k3QqEGekslbqKq
	 V/PQMvKoNXac8nJm5N0apUafVNmIhNnfGdZSwb+AoB6NykCN4VTllMOrZXhj2lkGCR
	 y5weJAwONk8vmDHcuCniJIyvOG+1d0TqGWlVbw7Lo2qNuSu5+agdMrAV03vXR6Xsfg
	 L3DsbkOyPwweA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Benjamin LaHaise <bcrl@kvack.org>, Jeff Moyer <jmoyer@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org, 
 Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org
In-Reply-To: <20261030-work-aio-exit_aio-v1-1-83942022a4c4@kernel.org>
References: <20261030-work-aio-exit_aio-v1-1-83942022a4c4@kernel.org>
Subject: Re: [PATCH] aio: don't let exit_aio() return before complete() is
 done
Message-Id: <20261106-evakuieren-lackieren-professionell-d298e362144c@brauner>
Date: Fri, 06 Nov 2026 14:26:04 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-ce4c1

On Fri, 30 Oct 2026 17:15:21 +0100, Christian Brauner wrote:
> exit_aio() kills all contexts in one go and waits for them with a
> single on-stack struct ctx_rq_wait. The count starts at table->nr, each
> killed context drops one count in free_ioctx_reqs() and exit_aio()
> subtracts the empty slots afterwards. Whoever drops the last count
> either calls complete() or, if it is exit_aio(), skips the wait.
> 
> With a full table skipped is zero and atomic_sub_and_test(0, ...) only
> tells us whether the count already hit zero. free_ioctx_reqs() runs from
> the percpu_ref RCU callback, so if exit_aio() is off the CPU long enough
> the last callback can have done its atomic_dec_and_test() but not yet
> called complete():
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] aio: don't let exit_aio() return before complete() is done
      https://git.kernel.org/vfs/vfs/c/ac4b449b39e6

