Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29392377AB4
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199577; cv=none; b=E/0u/EY4RMH2y41foLO3UuRPGgSJbvWxR/gjfTcuTXxgoBaACAcTXo+huUmEqXjuzhBAparRDImUm9HtUxYYd5LX1ir9pIX2JaDU5OqYXQuEztekUInVr1pP23L8ApNo21Zj8NndLuwPSCvK+MY8wK4CSWihTrAdwhUWnSGv06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199577; c=relaxed/simple;
	bh=DEtoz5heS5lQfApr5ug5JETAkilzCETkLn99uSwDM1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaR8SCyEhMfxw2DIcoIYYBZJC08LeUEFGAgrvewNNGDLJSgD8dsElsZkbZKqiVbFu0SVobdGX7Rh77DD9eTrTnYCupNwh/vnULfNSH/Y9BakHSuSwvrCIxO5dFvET34cZKhs9iQN4LuWCgr32j3GDvbhCeaOTUh9bmDt0PWtOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVwRy3HC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVwRy3HC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA6C1F00A3E;
	Thu, 20 Aug 2026 04:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199576;
	bh=pbZUSYVWxIE42X/PRWPyAEIC+R0ATDk2G1BD7dCziVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iVwRy3HCfhT7heX0/VmbyH+IV201X/Mj1xtPqOj1q4vSG1AuMiXLdK1iU5f+OK7B/
	 q9QDi2laXYJxee2WZUsL78TQoYQnlSOU8KowwfN3kJnJ/FaEjSMCI8uFfSZCYUVHEu
	 QMAsOhIN1XkvIVnQSvSR4Jw8/n3T7lw3Dr766fATPc8mZyumpQcv3ieb/njIr9yfu2
	 xHrt4U9X6icll7OxksmuUr7gqIJYd7i3/UHKZK2xstSiYEKTGNG3vzahXxIeMZB3xw
	 MPvUbU7BvU17PVfbJ71kGYrZiFDwq3YHEEs5rmcxYcemG1n80JckjHFG/3mrgBfpug
	 aWMgShbFnMPmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	almaz.alexandrovich@paragon-software.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Sudheendra Sampath <giveback4fun@gmail.com>
Subject: Re: [PATCH 5.15.y v2] fs/ntfs3: Change new sparse cluster processing
Date: Thu, 20 Aug 2026 00:19:26 -0400
Message-ID: <20260820040907.5@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819023304.704604-1-giveback4fun@gmail.com>
References: <20260819023304.704604-1-giveback4fun@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 07:33:03PM -0700, Sudheendra Sampath wrote:
>  		if (lcn == SPARSE_LCN) {
> -			valid = frame_vbo + ((u64)clen << sbi->cluster_bits);
> -			if (ni->i_valid == valid) {
> -				err = -EINVAL;
> -				goto out;
> -			}
> -			ni->i_valid = valid;
> +			ni->i_valid = valid =
> +				frame_vbo + ((u64)clen << sbi->cluster_bits);

The v2 does fix the infoleak the v1 was bounced for, thanks. But this hunk
reverts 50c822fcb367 ("fs/ntfs3: prevent infinite loops caused by the next
valid being the same"), which shipped in 5.15.202, and brings back an
unprivileged local hang under inode_lock. Upstream only dropped that guard
in v7.0 as part of the delalloc rework.

> +	} else if (mode & FALLOC_FL_COLLAPSE_RANGE) {
> +		if (!is_supported_holes)
> +			return -EOPNOTSUPP;
> +	} else if (mode &
> +		   ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> +		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)) {

Two problems here. INSERT_RANGE is now accepted without attr_insert_range(),
which 5.15 does not have, so fallocate(INSERT_RANGE) falls into the plain
allocate path and returns success having merely extended the file, instead
of -EOPNOTSUPP. And upstream leaves the COLLAPSE_RANGE arm empty and puts
the !is_supported_holes guard on its own INSERT_RANGE arm; moving it onto
COLLAPSE_RANGE breaks collapse-range on non-sparse files, which works today.

Beyond those: b3e048720dee ("fs/ntfs3: Make ntfs_fallocate return -ENOSPC
instead of -EFBIG") and 560e613352b4 ("fs/ntfs3: Remove redundant assignment
to variable frame") are folded in unannounced, the two attr_data_get_block()
call sites went back to clen=0 after v1 had them right, and the
"(cherry picked from ...)" line the v1 carried is gone, so there is no
upstream reference left in the message.

Could you respin against 5.15.y matching the 6.1.y backport 406a037d93b7
("fs/ntfs3: Change new sparse cluster processing"), rather than diffing
against a newer tree?

-- 
Thanks,
Sasha
