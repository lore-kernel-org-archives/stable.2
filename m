Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9317443C21
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125676; cv=none; b=cJvjuEUEh/bu/Px05jhmaMcacUt6dWitCFBykiM9yNacByMnWIkpxfOkrFQJK4IfuQqmBhob1aatfxp2xYl220jY5Sny0RMk8BkL/rKODzfT/8OxQQPD2QUKCDRAFj++Y728FPKZJdwW/OLP7VGzkI0NZVQ3/Hu5/i3XiDe1lU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125676; c=relaxed/simple;
	bh=ZbKc8ZibSxHlQNUj2vmnThv/0v4CWZRoc/IT0RCRJlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaAr06I6hrnYp/OUNHz9lWJHNUu8sNJx5GZl01m3fUGH7uiXa0NiX/ZQj+C3aSPDs+gAKohNTrt44caqdCbS5eHDmYc6Bv9EL3I0tas+nJsIws3jHeqmd+itHXuKEIuPHVa6t3NHWMCGCKF0y8uF2spBIWK+4b+ACyM2IvOw8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVwJFjqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVwJFjqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126E31F00899;
	Fri, 11 Sep 2026 11:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125670;
	bh=RF8fo+D/bpSIcFEke4mCtVIAC6W4cd1GVvkJi9wjvg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PVwJFjqDxYhKZ5jjFper+cr8kwk2a6+CLuW/dqkVtot0tNWZW4XtQc+eynHCW6Ifv
	 EcLik9Fc9RN4rK5IEfUlAmVSrZBoM9MLC5OY+5HjMukE5CGzCZsrozw9fsJRebzcbN
	 r25TzH9xBxTF7bLvY608Iky1oWjzKbkS2JTt7PNGXAJ+H02f8DCOIklbMGCWQR5ntJ
	 FFDKxTmDZmVnhyp3ZmncMC9Qk0tzAuu/At/hBMY4sIdE9Tri5kM4AfkKZHrmh7FOUm
	 l7hcnW2tE/zSn8s/bVDFyO7MLefy7cC5hwWeN1uURv/9O9nfvmOynaXOCttkhIZ3xk
	 +aMijXfvFxemg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 7.2.y] batman-adv: dat: atomically update mac addresses
Date: Fri, 11 Sep 2026 07:20:27 -0400
Message-ID: <daily-reply-0008-re-batman-adv-dat-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909182001.907058-1-sven@narfation.org>
References: <20260909182001.907058-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit e6de568d3eda3e3c01c868fabd7a9535d5ee4a73 upstream.
>
> When a MAC address is updated in batadv_dat_entry_add(), it is done
> using a simple copy function.  A parallel reader might only see parts
> of this update.

Queued for 7.2, thanks.

-- 
Thanks,
Sasha
