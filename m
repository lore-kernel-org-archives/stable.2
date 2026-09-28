Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E083DB994;
	Mon, 28 Sep 2026 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635158; cv=none; b=ZtFp86wBFtERioU9e+ooipOaoqe0MbLOXh4yPYkak6Cb/55pzL55p8PANCyt6NbzqAln66pT8wnN1j1JDyTyvW9dIDPN9F4lC3vLyEA5jkVWIpTNQjMyhHvjMJjISFrmO7LV0RYK2oRbX9U78NE/qJPCbWRDLHetLL8dKKtYCio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635158; c=relaxed/simple;
	bh=tiGFA5eQ2TrA5fy2aLNrAdcm7I8dIuJ0HcowIT++P34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2PrePens6vk2/9iA9hIQtyzT6Bri/AXLEOZOexEdQkgOI6TTcjhC5qL2MMfCb5quNHwblJOO/PX89wypdduQiKhRDlsSG6M4fgsbW/3ho9Zo/BmkbNQQEdvapXt01IaO1PGSzSvi6/lO7cHhq852xenJ8ugATWpvW+PUdspKpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FznzPWNX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FznzPWNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A6F1F00898;
	Mon, 28 Sep 2026 22:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635157;
	bh=o6dIBaBZIY9PXiAQdOxcI1i2RcvtjldVupfsGO8WQL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FznzPWNX7WSLNhn7SIVt7a/BS/4alhmR8K8CunOn1DXiBbNhBn9fB7a7UBe20X5Tr
	 dtWqD/oIwmT0XgaE5wkpn9uqC1Njvyn2VFWkQfsQfln+OVu75iPTZlDIUt0DHzxN4O
	 hfxjDLZ27XWcc+kdfpAsoadlcGxU+ShMJ30Vx2Mbq/5RfRABSXMTv/vEIMFVAvg03G
	 a8NawOIsWyzgRcAcTh/OprtaGVATi5oK2t6hRp6zpb3fBVh0Z5NBVM5JW583lB2YCF
	 v4GK7ll9aZfKoTq0EoEjhXAH7Ihs+HdWpMqDPH5NJlBLlQoDosZNwTLJG0ngaO50Wb
	 q4/K4aL0xHoHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kenta Akagi <k@mgml.me>
Subject: Re: [PATCH 5.15.y v4 00/11] KVM: fixes for CVE-2026-46113 and related issues
Date: Mon, 28 Sep 2026 18:39:06 -0400
Message-ID: <2026-09-28-2-daily-reply-0002-re-kvm-shadow-paging-cve-v4-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928164427.4699-1-k@mgml.me>
References: <20260928164427.4699-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is a backport of the CVE-2026-46113 and CVE-2026-53359 fixes to 5.15.y.

Queued the series for 5.15, thanks. Patches 07 and 08 are David
Matlack's upstream, so I fixed the author on those two.

-- 
Thanks,
Sasha
