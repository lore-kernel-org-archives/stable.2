Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4EE42BC48
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074371; cv=none; b=jkAtMIFW9IcWMqDvTi9qa/1Tya1L/ZEDKW94XdRoY6vUk9kZKsp7N4+/IOZozuwCsN122AYGBrkpnqzCoGJ+1RhO8sBzatjd3gBoL74zJWL/tyHvQmIR0XZo8vMIhuP5UliUHNdiOHhr0ibajsm8A/k0jKqHLhZkNlovNaRCyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074371; c=relaxed/simple;
	bh=taLLJUHCAAJDBVLhdMtUDP9La9KynmUOgU7bF5Erpqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuzwzyepaHiefdF8zGjSXPItz01xPK1KKrDeiNA3PWmANRbwKebhu3RlbGEFsO0Gx2/B8V8ZRpl7/uwGg6SbyTNQXtjdX/VWv0PJQdFCG6IfhHGPo93F7PZ4jO8kHZlK0bruRdAg46k+qYYJl5KkLiTtlb1JEvQW5uymnknNkU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0IU0F4x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0IU0F4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6E41F00A3D;
	Wed, 15 Jul 2026 00:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074370;
	bh=kNQ9zwYbVOa8h4hZ9CVI7+RPLtvHGm/rUoa+9VQ18Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P0IU0F4xiu0Iz8FbtnPLsX3Ida6aQ/LlK3Yc9FrGJkY+dpyfcJ/r/FYMe1/jEd86o
	 uVEBJqx24tGCKq9OLJT2il0C5Iq24NGoUhtYiZSSO4otThflgJw6YiNGKLTl5FIvBq
	 3hLinwh0zdveyFepK+/c0ifxonRunXXIS7ckmtoO3yWo8A0gqa1z6EdByoFUUAMoWY
	 Vspnotc+qCHZ5TQh+v399U9XBCqLTuIEj9JHkG0K4xzCD7dYWnC2/JfJUAU1GlvDQA
	 AhCbE6VJaJUaLWoLJBQIlLrA9O6LmHKFP/AlSYtJHPkHvU3exZddIzClunu+Sf06rK
	 Ri8gVNHReRhbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6.1.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Tue, 14 Jul 2026 20:12:34 -0400
Message-ID: <20260714200600.stable0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153441.98488-1-liviu.stan@analog.com>
References: <20260713153441.98488-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Initialize n_wires = 2 to match the binding default and ensure the
> rotation check fires correctly when the property is absent.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
