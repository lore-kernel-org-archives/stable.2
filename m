Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB2635C695
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355023; cv=none; b=rNAwNgadgZePto+nwjqOh8dv5XfmN47J73ts519I5V9T4AoAJaM+tr1HwKlSQQUgzlIoE0SKXEeYtDG5ZlQVDoMRky/09yklkqkvyMalsyMUsyJQn7lm6zC6Abd+4cVUoS9qW/m4hQ8QcodAYYoimY3gQ8ih+Q26luH6W+zhrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355023; c=relaxed/simple;
	bh=RuTKuPFktpEoDl5zVXisimDFOH1lexIQG3ZY1GWZamU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gngolMYRPNjCs6ey4kb4Q3GiJ0g7wbeUihrxAJ/yOdR1o9mGgJ1vPG9syrnKEUQZs6OZURW310oOGmoJ/kWWGZtlRRQBz/uZLEkoXe0L70Hz/QZLZFGKTDLFvQq+5xzsuVWl9PfD17qgYi1gJ7xc//3OSRIX12zCfHe613M1r48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMINSRiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMINSRiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EB21F000E9;
	Mon, 10 Aug 2026 09:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786355021;
	bh=PE3la7kJoE92Zs2PXzBN9WmBrRf1yXIrmM2DdbArnXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hMINSRiYZ4Yx1LMwLCAhYdw2AYMzlLyUmH3sjk1nGdnVFbIGysVzDZkYY0L7xBOmv
	 lsxYACj0IZHXm4wrplC3MxPDGwqjQXylCuaDvNoDfhMgqIzMv+2d8pfqJ8EBlYL9Sq
	 QDFJTRSlxQIlMP17JrZUJhJRbgooKBe3MbViWxOuC9XOzS70lgyA0CrI44M8fuGf0T
	 vBnn90TjQhykCie9QWcZQ9oGlqV8SFdw95xPKkekXpVl7Xb5mccU63vKO0E3esaagr
	 sPp/ERIPYzQwoBZhxrt5IZZ3+qsoc0bCyPOWL+6D2y3rRueDmzfNbh3uXgQqql4hZ1
	 xt6eEKxpAxiXw==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org,
	John Harrison <John.Harrison@Igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Daniel Stone <daniel@fooishbar.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH] drm/connector/hdmi: Fix out of bounds memory read
Date: Mon, 10 Aug 2026 11:43:37 +0200
Message-ID: <178635501197.53478.18079946297287958635.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723220652.533345-1-John.Harrison@Igalia.com>
References: <20260723220652.533345-1-John.Harrison@Igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 23 Jul 2026 15:06:52 -0700, John Harrison wrote:
> A helper function was copying a given audio infoframe into the
> connector's copy but using the size of the destination (a generic
> target, sized to accept many different data blocks) not the source (a
> very specific type of data block). Thus, it was copying 60 bytes of
> data from a 28 byte allocation.
> 
> Fix that by using the source size instead, together with a build bug
> on the source size actually being smaller than the destination.
> 
> [...]

Applied to misc/kernel.git (drm-misc-fixes).

Thanks!
Maxime
