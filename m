Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03932EEE75;
	Wed, 14 Oct 2026 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941268; cv=none; b=YUBD2rqXGaU1ogvOL9xFDu0boLUDpzYM1jmdRbb7b7t0cYYHkkrPLEpEC4yuUz/rnqKNQOhgt2Qt6XdGM1XcAvPwPrk5WoFsYPgH+9A9NJ/AJYUl1MaVkHLH0SFjapb2m0Do4Hm0J8FXs0qzQ6R9QtZ3TJhRlRscc4qswoGoypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941268; c=relaxed/simple;
	bh=FeZ7a1zxnZ9gqa7LGycL4Ig/TSE+yMydjtwWI/g2nWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3FnIVaeHxu3EQuYILMw3SKAe+Cb+t3gAOXSv3F6+iA3D/Qek9Zk+XZIyI2gmKrK7Veh+nmXppfreIhNe5C8T/VLu5+c32U5OEI4Ar2Gl5tCk0+m+lUlEGhJ/WpwlJhUBV46KmpTHrf6zm8tDsqukSu5HV/roScz9NqSRUUe9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Iit/EY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Iit/EY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA71E1F000FF;
	Wed, 14 Oct 2026 01:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941267;
	bh=uQ+vCRYu401j37CQanBPr0RHPw8amCUZkTrxbwR/6eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/Iit/EYQNi0T+MD53Siidb1SpZpBv0c8hncadLRrhByenvgG0CKpmhdWdJjPfJkt
	 V8TslYCWCp+IUgVHcu/V1DFv9EnialbtRByqD4HkjXVbx++hwPaq4AyluRlfJSYrNS
	 78n6zcwaonl8yqM2VY438wozVhvFXx5juBzeUiEOpquC1aSVwl2I7NX9hLKWwl3FV0
	 DjRzkmZtJi2st0FfLLytGRtjxqZsWIOyNe2rgyAUDjJLwxwocvewgMl5Vg5goHn8Xn
	 rvNLBVEW8lTVz65WRMeRVq9B7fzPZREKYuHViF7Wx0gprHQap+EZ3Gm6FWzqIUpchI
	 FD5sd143eenDA==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [STABLE v6.12 1/4] HID: steam: Fully unregister controller when hidraw is opened
Date: Tue, 13 Oct 2026 21:27:17 -0400
Message-ID: <2026-10-13-1-daily-reply-0027-hid-steam-6-12-series@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091146.527985-1-lee@kernel.org>
References: <20261013091146.527985-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> To avoid conflicts between anything touching the hidraw and the driver we
> had previously detached the evdev nodes when the hidraw is opened.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
