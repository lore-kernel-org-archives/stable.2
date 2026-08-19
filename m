Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5A3C1D5E;
	Wed, 19 Aug 2026 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110364; cv=none; b=fZYCZL8gRPHdk10JJMb1IkP7cY6VrOwofDpzBOwAFy1AzZLVyuvzgarpQkQyBw5ITYqNaDWlO4WCbhPtyGvgwTgOVfIXS8TjOrb9gssreM8xT+zv/+xOCDzS1tq0nUCN8yYgSl60eI4qq6Qj1lXZU5HbfIW+MUYhC5bORlqujTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110364; c=relaxed/simple;
	bh=/xzpzrGNxju3CcQye01W6vxWLQvUH1QltGr0WL/hEI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mr3PVXWa2IDRYZUZkg+Z9H5r8jEpfpENMHby0NrX+5pfwsPgjooU8dP8Y+cGtpkoDCVv72CJFdJ5JzKWTXp7yeehTsMuxpRyK2OXvWS8jY5rGK6Vz+BliPrwW0Cqyk5VTaTQv4GQKJ+5aQMiO6BOhpfq9C4i/EmzlqbT6hy/Pog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LobSjv75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LobSjv75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF731F00A3E;
	Wed, 19 Aug 2026 03:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110362;
	bh=HIIEWW8C9iGaABve4afTTMBswbWKuKf9Ygf+gA1/1fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LobSjv753b5d69gP1mIW38JZHWcnn8n7W1/saaGORE1/6LTlkGmbgl7gI/JFrce84
	 3ig8Hn4/dEV2raAbI+Xi5CRZHu2CdJxtqp9BexKcCtc0oghNflhA7/83YWZyi0WSVe
	 6ExZHx4Uan/+ec2g3ZyzlEb/lV7IWWZEkbJY60S4GBivTnFjimUxLIhGBTVTEB2YfV
	 nkZLIT1dVCpEksuYDm24yw7/VW2+ihuYzaJ9K6C2CbYCZttm+ZzkZPLv7yxsUZ/qjU
	 KotqdbyJWKfIaFyrqJc3kY/htbb9MSQKjpuvzoZ8D4aFv/sKvYlTQc63up35/Uf6SE
	 wJ7E6JB+kLjag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD}
Date: Tue, 18 Aug 2026 23:32:24 -0400
Message-ID: <20260818220420.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818063041.94512-1-sj@kernel.org>
References: <20260818063041.94512-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 17, 2026 at 11:30:39PM -0700, SJ Park wrote:
> [PATCH 6.12.y] mm/damon: adjust isolated pages stat for DAMOS_MIGRATE_{HOT,COLD}

Queued for 6.12, thanks - it went in after the ops-common backport, as
your note asked.

-- 
Thanks,
Sasha
