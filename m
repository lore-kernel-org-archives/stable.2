Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372775;
	b=4WYxNhuuXNHzRyiVQS1UCdRC9feoMriQ9Dz0esK1KdjAKxibZf40/7vjN2aMFeLH/CXy
	 tuWGJy608JzDfciXUoATw2ik4OHBGNEe2szVMsn6+gHwieVqfNyHhql2sAjinKk08MqSh
	 EKLwa0YN4iL5s6/pFCVuVSckGksmy8jEBtjdiQVLceALG0ZoFRx1NciUWk4SBHifsHWPo
	 na83H/2OyP5iNrdxMasaygFzchGPJCRwYLSkNX7HXCESBXkt5ggcCkmyyyPs6F9ynG4/3
	 K4bxrTM2iuD2gtet+Z/KoEkoX/2ktQLMvuQO60IBNqjFTDCdsM6BbUYsYsY0zuu5yIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372775;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Va4KXTHeJA5guykEvZxhkC0KQ++llU8oxL81Jkrl0QM=;
	b=iiZryTB1HbvkSflm2iVjcS6/cipHkbO3X9UX9I/HAR5hTnMUraxhLEIOuQ+60BBQsNlI
	 Y6HI7I3RDCS5lONL3DqNfZzXnKE94HrWcY6TLCdc+CNYB3RBB4/OccAMOU4rsQNk1mqAO
	 wAOKm05zAG17cEqOuYGuMmBAcGEyilRUyG1LvneGIb10rh+LtzC9FdgheK0Ac+bOmkfOO
	 H0L7l1ZLCFY3EgVJ46Uj9/1sSIoszM85MxgPwbUZmnpNA+CZ+pmp4YV9ldtkEIXVMsbg/
	 RZQexxGfTLwlx3HpkU0K0tcRu8tSmaB+ZEh2PpIyKduDcvCUy4XIWjemFdXT9Ni0BnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEW02O3L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FCE606A321;
	Fri, 30 Oct 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEW02O3L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A061F00A15;
	Fri, 30 Oct 2026 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793372774;
	bh=Va4KXTHeJA5guykEvZxhkC0KQ++llU8oxL81Jkrl0QM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AEW02O3LMy3L7p6547tJ93TiXeeeXRFON111pjP3v/X/jhESDSfoKe6zeufn5xfea
	 4xflEpEKVpCbONOT+wcaBtISS7EzZz3PlonUhM9/LuDa51R0RyLfix98GZI2rDg4Yy
	 vfaZLJDMBff9xSFx9Gjx44cgSQPqrenII+EU1jsFfWQPpkGxM66uY9cYd2ob+au7Ps
	 Bb9wr8HxsXzs76wn5yG2zyKCapLg24EB0PCObg53MEb2HNx4yNClQg6K/ZCltJ8IKG
	 q8uueKMEl/knPstwuAkIS+W7KRRfNaP3US4MzcM4LQlwrp/0x4XtPYU+jy8N29W1Wm
	 ElVi1dkLBN5Gg==
From: Christian Brauner <brauner@kernel.org>
To: viro@zeniv.linux.org.uk, Hungyu Lin <dennylin0707@gmail.com>
Cc: jack@suse.cz, djwong@kernel.org, amir73il@gmail.com, 
 dchinner@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261026015738.46230-1-dennylin0707@gmail.com>
References: <20261026015738.46230-1-dennylin0707@gmail.com>
Subject: Re: [PATCH] fs: skip copy_file_range write limits when there is no
 data
Message-Id: <20261030-bohrmaschine-postschalter-erleben-caf22a079c0e@brauner>
Date: Fri, 30 Oct 2026 16:06:11 +0100
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

On Mon, 26 Oct 2026 01:57:38 +0000, Hungyu Lin wrote:
> generic_copy_file_checks() reduces count to zero for a source offset at
> or beyond EOF, but still checks the destination write limits. If pos_out
> is at RLIMIT_FSIZE, this sends SIGXFSZ and returns -EFBIG even though
> there is no data to write.
> 
> For example, GNU cat copying a 1024-byte regular file to another regular
> file with RLIMIT_FSIZE=1024 copies all bytes and is then killed by its
> next copy_file_range() call at EOF. A zero-length request can fail in
> the same way.
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

[1/1] fs: skip copy_file_range write limits when there is no data
      https://git.kernel.org/vfs/vfs/c/81dfa035891f

