Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B439989B
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548419; cv=none; b=dI7nMz8GzhcdQilLElSoN1pHrHuU6gRUN+s65wDN6RcQcoJ07+CzOsQpNdJaya0w/mZgX2Uzx77oY8QQE0bDBLVtKkOZmxdbn9VzYbefr2HGbIPAhqk1WJJq6rG3QO+M1kosAdT33uUTuX1sMD2Wav60vCjSEIAU1hocJ/37kXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548419; c=relaxed/simple;
	bh=N9vcDaGOYTzjSo82ksjfU9D1ScnnsW8tFovwnCDBHbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upIjlSeFLk+POn3B7y+MwItUA2UK9M+acwfwP5iAnUdgNe6wnprytI/u51cmfUHkXuE00zlwP8lPw4zaHOd6+qOF2buSNk+r6QjWjJ4L5VBs7Kj7rXdWtfLpJ8P2Jk0gu/IvXxV9+HzzIZ9dFBmJOUnblqvFssCZ4Npfh3dcPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXoUpWZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXoUpWZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0C51F00ACA;
	Sat,  1 Aug 2026 01:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548417;
	bh=I/Kz5gB/50FiMKWjtv+kY2Pc/J/vBsIoVIOik+/9tHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXoUpWZ4R2W2dxk5EjX7h6ZdkhTlsT5eKqJU0K1rN+jS1/VgEzlHxa750sdSyPoH1
	 vgHJswvk5TNkElY6uVb7r0ZMkPpd+WSF61TajLy9oKakzHckTYU8quAxgb1bb5enRC
	 LaaaY+owea0fRDQmvN0BSWGZAyQiwtadVbFsyvug3heGJ191oF/Usto+guW2hF4bYB
	 I3m/+q4OmcHxuaNEkg3I1rHJs64T6pKl44o10bfB6msy/ercmOncvZcIBvwhhu16Ey
	 i4LEfZlNVguMldXsUCjGH+rd3tkixC7wGEkIbfCOwsMgwhF8b17kulLxJkIqxvxBuE
	 obEapOcLo1dMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Isaac Scott <isaac.scott@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 5.15.y 1/2] media: uvcvideo: Implement dual stream quirk to fix loss of usb packets
Date: Fri, 31 Jul 2026 21:40:07 -0400
Message-ID: <20260731211005.stable-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731104833.709405-1-ribalda@chromium.org>
References: <2026072041-shame-chaplain-6dce@gregkh> <20260731104833.709405-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 10:48:32AM +0000, Ricardo Ribalda wrote:
> [Added JPEG_MARKER_SOI definition, jpeg header does not exist yet]

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
