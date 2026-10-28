Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161586;
	b=swT/VmzJODJHbUrkeW5QYOowR93t+gvksMzHC++LGBwSioMtRomy9sTwPh2qfN449RSe
	 f0uaBfUJ08+Iqsq+fquZMRRF3vHfvPAEY6dVxhuIZk/+aLi8W6hrE3td83P8gzY6iSARh
	 L5DXz5+CxfK4gmGtpl8jw8zm0K8xDEycjMfmE5juhk1/VX0LLsfn2xZXAHFJ4Kbu7UL1l
	 eiakv7EXR8NbThoh4u1E4Q9TG6W0LvTD6pCoJt0YRnGCIVF+vnDZ5DRevJURRnQeWFTvT
	 vNV72S3HUegsPQYWz84HHI0/lPhg4FusTVzgN6l3TrkY0bjfUaAtwK7P7Z9bQj8G88Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161586;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qsSJjk2iONV4ODDHOr7Ui6FDrROh+Yjjmw83BnKZCco=;
	b=un8lh5jFNvAW/JI9SCqU9UQWW3C0nHhxvgMlP6zq3VYCpE0oXUTG29+axyX9DkQQXZaD
	 oa1XfmAVy/fUmcw6GuvAd7KeSlvuHhrdtNsBtJDJIwsTSwx7KAvy0SlygcQhAopAGiY3V
	 rwOJM02Cpe50IHLlCPj3Yw0jZ4Z6QYzbRVzwRZQq4TKowzOBigl/uK7l9CZecfPCUigyz
	 mNCRwYWd9wCWDXrCbZ5M33+YYeuTLpSa0S+2/NZQGrsu4HX/pzS+oWyWb9vvuFDPPhLxD
	 iyXUSoW7uWasg5wmXu0WRw0id38V4ZyezD3kuJhQEQXt8MCSQ7HrIzkyLWmjRKmhntA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6tdC5HJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C095606A31A;
	Wed, 28 Oct 2026 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6tdC5HJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205B81F01825;
	Wed, 28 Oct 2026 04:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793161586;
	bh=qsSJjk2iONV4ODDHOr7Ui6FDrROh+Yjjmw83BnKZCco=;
	h=From:To:Cc:Subject:Date;
	b=B6tdC5HJ9k3ZB4fk7jBl3mMIc/5JBY7E3fcRpaOJwhBROFz+b73TIB+x7rOev7ArW
	 hTY2MPjSLu6meWTZNjYIN+TX3k4inwAfQUMBYcl2hgNzbJy5sKE7/+ROCiEu//cVVK
	 ATO5UDNn4IkjcAaQiyREue8O4iMqjIfDFHDNmT0N2PenX4wKRDSPuLajWmZVnwPe+m
	 yXe+/XfoJzeTx6ZmMgELRS2VUKnnsbKklLMGdY4MEGP74mVqgW5Gie9hWFaCjh6dlf
	 7j8A7KkkztoKTnAYtlVhx5oqwnH/vf8BRgvkSv54F4q8FHJLWXHrfe0VhFq6eFCD6t
	 8wnBq2HY/kYSA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6.12.y 0/2] mm/damon/sysfs: fix pid leaks from wrong error handlings
Date: Tue, 27 Oct 2026 21:26:13 -0700
Message-ID: <20261028042617.165657-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface can leak pids due to wrong error handlings.  The
issue in the mainline has been fixed with code refactoring.  The
refactoring is done with commits including 7114bc5e01cf ("mm/damon/core:
add cleanup_target() ops callback").   Porting all the refactoring
changes to old stable kernels will be challenging.  Hence submitting
this non-mainline hotfix series.

SJ Park (2):
  mm/damon/sysfs: put target pids for damon_start() failure
  mm/damon/sysfs: put target pids for apply_inputs() failure

 mm/damon/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: cdfe28f3e9f0e6bfc80fca63d2defc5eb972d56c
-- 
2.47.3
