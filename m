Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC74AEBC5
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950804; cv=none; b=UhcmBajfy2GJlBCUT0mPo/JJ5qHyzB377O9orieOXDMrc5cLipb+/3nY84lXDvDpH5UQHAY8MCTvI8N5HSLS8d8CdS8uelMQ2JfHmuBcg+yKr0tEf9kUAci0GVke+i6dOv5Y7fRSLozq/3xNGujD9N3YwgtHrdm9U4ijrlIW/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950804; c=relaxed/simple;
	bh=zszdNhVvYaVn9VVRmNDRd9hW0yvZe4N4HuWdJIypIY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kt69DJhfLZaH5+IiInYdOp5OhsKdvIHWs9cRd27JbjaRIbY3ky1Qh5reY2ZiXiqR9clA3csOJe0sOxTzyLIuukTHRERMO0kl1NI3FLHOsyzPrOFg/7WKH6uJMojzpSyhjhUDj2YpHMSX6tSntwwwK5EQZ/Nujcr9WUejMjWS/so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfpCZNNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfpCZNNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7E31F00899;
	Fri,  2 Oct 2026 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950802;
	bh=7FT2VSgA1u8SGWVtbOj/H+qCGzsf/DWX2l5M9DLMwLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IfpCZNNxJwbCoYRlaut/5wAvbGz9sc7QSQnzU1RqP/RSHg1iYdgGedRM5T6BW83sT
	 h6kJdWcCL8hs4G944masvs7497I2uRhpflBg9OArW38GtdVYgiGybXgBEsLqjw9K3Z
	 kvBmqgZaJoRk4mttlkJVqIYGpRDheQiEk4avC1Z4UVpqI/XIItP06gXl40JreztFOs
	 q2Ihnz4W5dHTx1mJlU1llxuZkkPORod5egILrBqB5eYzW9DwaB0MMoMutHngIcxH1k
	 txgJMwwws/iJzGzJCfKwFqbOodPPsv7VXFXX9NirUX1kx3+sGdUemPPYKzcKw3BmC8
	 u4rry/6sDzMaw==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Lu Wang <wanglu.priv@gmail.com>,
	Davi Chaves Azevedo <davichazbh@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 7.2.y 0/7] Fixes for cache aware scheduling
Date: Fri,  2 Oct 2026 10:19:46 -0400
Message-ID: <2026-10-01-1-daily-reply-0002-re-cache-aware-sched-fixes-7-2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790790344.git.tim.c.chen@linux.intel.com>
References: <cover.1790790344.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Here is a series of patches backported to v7.2.8 (commit 9a66fdc0d7fd)
> to fix cache aware scheduling.

Queued for 7.2, thanks. Patches 4 and 7 were already queued.

-- 
Thanks,
Sasha
