Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A918DB26;
	Mon, 15 Jun 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532160; cv=none; b=Jx1rfqol2MbM6Z73H/ZxCyGu2d4Ses4DjY/TM44wUjYGwNiTMhzjbg4wl8kYeltnHIgPXBjetnLNbALUVB8wN+BDamkQIWBY6AZKz5ow0/ISFXcLpXmWyVM3wQo14GBr4yafWkRzlXIJmSGXUHmyS4Ka4Zyr29v54xra4w6oIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532160; c=relaxed/simple;
	bh=O2oz+YnWJmC4JgtulW/2JODfUkQWfikW4hVPPr2vh3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxCo3SjrBwNVxUVzL9RNehNOdiTIN3BJyZ0VG1iPmXRqodm0ShA/1KxS2M3kJWp1tnF8ShwJihAzNYsVvkQ2bSZAQyeu2kKIAZuao3DT4qA8Iktdli/oF+OkCQ55Mm1SCGryiGPGLbxmVn4+aWuDqa0PJWlDM0kjp7E56z6YaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8R6xhDb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8R6xhDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ADD1F000E9;
	Mon, 15 Jun 2026 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781532159;
	bh=O2oz+YnWJmC4JgtulW/2JODfUkQWfikW4hVPPr2vh3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n8R6xhDbQNeH0CpiO3pxS4wzkXwpkFOPTjjuix9kl2zZLbclLlOcjy9j362vGhm4S
	 QTwkyAEQ7eFelnlgSnwckrefqMl1sMmWz3zggI1hfw7YGnW9gzG8ZjVQxxelBchh3T
	 sudVbslxvZnc8yUscHmviLNd+JRhLn6pl5qpW8ZKW5BToHShUNlYDBAN9kgfOsv9TA
	 MJzwwZqhuxq+Gw9I7BFg2i5+pW5OEgpMvVZ1Rph4YCR01Me22nBXvfZkn3qTtPe+uk
	 62ebY8co1aqpXXuFFGi7Gcq38x4zboiWwm752cw/TweZ58FiXlBSnCGZcmPX6M9wXB
	 cn15dg91j9zRA==
From: Sasha Levin <sashal@kernel.org>
To: bpf@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org,
	Zhenzhong Wu <jt26wzz@gmail.com>
Subject: Re: [PATCH stable 6.6.y v3 0/4] bpf: linked scalar precision fixes
Date: Mon, 15 Jun 2026 10:02:34 -0400
Message-ID: <20260615132154.0001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781194510.git.jt26wzz@gmail.com>
References: <cover.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 15, 2026 at 00:58:37AM +0800, Zhenzhong Wu wrote:
> This v3 targets 6.6.y and changes the backport strategy based on review
> feedback on v2.

Queued all four for 6.6.y, thanks.

--
Thanks,
Sasha
