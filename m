Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC673D5234
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499684; cv=none; b=RjhXGzv7w/Z2FhBNaVJ8t/+MEyBPwHAOpdDipqSwo6AELoqr7w/0Ka5Lc6I7wwgVwjruGzLgDMs3yxbxj6ZFRJgPG0SEjqojtdSOb17RuuAIATf6otmfyMvlxB7yZP/kIXERTRqWbnndbXVjBcckzJL1XVswNGzcS7rTdiVZO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499684; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHFjjsRVUtCEWVNTogoqHrENXBKPrNqTDJZvcWpl1ZvshsLBqP3WdpxWjZ3Al9g1kHCReMlURShYve3J/ZxGOvetPQp5ubG6vaJPPFUkXIoIKWju0X0KvRGZmKKHhI4Friq5s/h5qKJlW3YeKL6Baol1gUU46eKyIt+tANPcFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEjn/KXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEjn/KXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD39A1F00899;
	Wed,  3 Jun 2026 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499683;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PEjn/KXjO1f+O7hI7oFzoX4jRaWvLpqBvq4nA+YUcQMSnKHxLCN61HpdzNwUZpgjf
	 O/Q7uBL7oOc+BBPCs0/M/QWAyzvh3AvgVWC/r4wwSHfgYml7dY92UXIKzZMo1e98BB
	 XsAnaRSOhaLlc7PdVZ7OhYJc0YpjNxWnPxnxljp9ywUIxhs4S5EgtOCvTiQ4v00i4k
	 uSsdJG5z8RyuYVbzhklecqKcRFcGM6Ci0/3fglbuJB3XWSFjj0v9A1dNAXvC9ZtMOe
	 vYiII931DyB2oq3L7kVwa8Y9C52zZIwv6XCLxsbXLb+LxGt/zpy1GAGPcTLgFq8+Wn
	 QhfcVb9wt3U0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.12.y] batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface
Date: Wed,  3 Jun 2026 11:14:08 -0400
Message-ID: <20260603111500.item018@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529181125.415543-1-sven@narfation.org>
References: <20260529181125.415543-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.6.y, 6.12.y, 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha
