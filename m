Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC974921A1;
	Wed,  2 Sep 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358437; cv=none; b=hLG1N3qW2tuSx1zhVI1JeuI0j0iCffXNTVEmGUM5XpLi/tX1N4WkRn8vQagAXBHPOLEgQTcPeFdE3IYQp3UdTyBgQp4IlmTwCsrcC1dvogJ1gFut0IxhOFAsB2jNUjl75QEDgpObXYUWby3+uFqO0ZChWvB13iB9CFXTL7618mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358437; c=relaxed/simple;
	bh=dOK7fI1VcPTwRcA9wNF1yj6a+h3tgrU6RE4i5eS3SBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=canOR0Hqm9kDxOKRN2qfA5Xi0A9PfeXVROFoD6krWzW79Vu+Fkz0ZuQ5Y/aAxJxGUVgl93KfriZ8c4tu2J2gkWobjYjbhKnWge0IqWKKmwGq1LP+dGdzTMedkDVLulH5yIH3ciU8toZl9uDFnmuNU/Q+8Iax+YRlRziMS6/etNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GveyguU3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GveyguU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED03D1F000E9;
	Wed,  2 Sep 2026 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358436;
	bh=/sY7iQ8sPr77cH4aM3sTeT7wFW0GP7eesI1PHSHpEgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GveyguU3ESZbjw9mrZcN+gKwl14Um+a67M0pjqmHBKAfGaH12EGa4poXgUz15a+p1
	 Ld7ko03aZH/1UwEetlHA9wPUj0aSl3BskI3AxGgwQ4F3DMwyk0Mu18hBOKbl9TEgjU
	 9x0Tvi1mCuX21yj+oMftISrmfQvSiX+z76odon0feaIvVjCWDGqXpNc9fMu/stc8P/
	 2xcqbgTyuwSNIMrfwXDiysh6D4DLIxBWrB8gBjzgAiQ+l2Vn8EQ0JZRWYrbKTXBxxo
	 CchbzB+bjMYLw0vBRqw0XkRn4Cnxofeovu0V0XMl2CzXWaVQwyHK6sR5vFrMIN/IMD
	 Y96xjI3CeWSLA==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: allow esz to be set to zero
Date: Wed,  2 Sep 2026 07:13:48 -0700
Message-ID: <20260902141349.86896-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902082050.19566-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Sep 2026 16:20:50 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> When the temporal quota goal tuner determines that the goal has been
> achieved (score >= 10000), it sets esz_bp to zero so that the effective
> quota (esz) becomes zero.  However, damos_set_effective_quota() clamps
> the quota to min_region_sz, preventing the quota from ever reaching
> zero.

Where in the code it is clamped to min_region_sz, when?  And what user issue
this can cause?


Thanks,
SJ

[...]
