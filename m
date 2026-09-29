Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C40519DFE;
	Tue, 29 Sep 2026 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707875; cv=none; b=oNzw8AzeJ7L/qeBEwQAD9KFZSH0P5iv2EfjJgs6AdAVjz6mLgF5aMjcfq3m0DlHn/1BA0VMqlcKM42+hyic9dSDxCMIG2P155n0jUKZ/a+5T+3Y9/7ctDDIwdJl6H2O0snAwMjrhNYVzxV5otyr9Wj9oYDN2SrP2JDp9rFsLkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707875; c=relaxed/simple;
	bh=oBJXWkkbsLkyiDa+rzl33o5L4byAQ+UFDJoUXlg3QkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCaXEwdjfIOZPKHtWrHwRqni3xta8jCZCAmGL/68lajfp/tPWkkApYXa6wwORNq2aiHkJvpybbdXcLeosQBEVtwMvMGBiBYopvdPkrAXUrD9ZsLYRFKaSrxJVT4KYwA94/luB/IN+xI+H5D78ngT3E8Jf1HppM2iEBmMd3qvmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKCg71Ko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKCg71Ko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0531F00893;
	Tue, 29 Sep 2026 18:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707873;
	bh=L/fe21HAVUmdM6qJ1mnrLspumxlrl2x6ZLSmHA92wwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lKCg71KoPPQcig0qO9V1o5vXvuAe3+gv1/xhW9RBy6LD1/H4N8NiqVbDPdRNTExTm
	 9GuvOIePVYJ8ods8a9m7sGm2gZdD9JB+hz7IP/DH6MvOQWRFa9LZDhfq//QMXzvM30
	 6LcyoU0U7zavQ5ex9HYYCoqXSgtoeQ/6vbe/RScs/qEfwhE7tNR58xBq6flMoasDCL
	 DrpIpZlsNmTlsYaydt/D/173sCHcoVtVWHVVeckk9Lu/772JOV7OouPhLRKVMGFkF0
	 J3PfW/Wkuk81ktVCcexqWTMXQIrwWjv7baTA0tgheSGK53HaN7JHuriRO3sfaXT5Sj
	 XM4QLqx5OD7nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Allen Pan <allen.pan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <xinhui.pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Add a dc_state NULL check in dc_state_release
Date: Tue, 29 Sep 2026 14:50:51 -0400
Message-ID: <2026-09-29-daily-reply-0008-re-amd-dc-state-release-null-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929030936.86941-1-artem@trailofbits.com>
References: <20260929030936.86941-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This one addresses CVE-2024-26948. It adds upstream's NULL guard to the
> older display-state release helper.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
