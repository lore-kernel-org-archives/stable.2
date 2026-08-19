Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5BF3BE641;
	Wed, 19 Aug 2026 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110365; cv=none; b=E656/9yOOlYv+Ewbo9KJvB+n4q8ZdrcCg5i3gfKW6WIhu+76mmEyhFsfEj+bb7vvbcPuBS+tTvPl7BKBOEGSFGTXXogZaPdvIbwvitOPdnrYab/GC7ZZzd3p/xVW0chM7MgTS7fdUOeWiAZ+8dN4YPpKIeQOcL48hMQXZ0PobIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110365; c=relaxed/simple;
	bh=ZA5xhq40mUnR5yaMuvTIWf1xhJ3+BDXUfM47OjNRXhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJdhfn9QoIosAmY/VqMoo5bzN+QwjjOldY7KIOc/m0L8uDH+PvSZSJFsULgaZvGG9q4RdfpOT1WvEmBeSicj+CbLoYjuK0FShWFKLQt7t3WY2ETbB+VN7PU6j3SdaDs1+zc1MmOWeZt1dWhdyTzZHVufmzV3SxvbHK71eMDzhTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxZJmqbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxZJmqbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E3F1F00A3D;
	Wed, 19 Aug 2026 03:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110364;
	bh=QLWzy/34zBexKezhKJ73RjM3h+b0H+4oMDW57GvJhOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxZJmqbqblyBNgu8MBtIZbSOyA5oGFzaFxCgUdFlRHQ2YaQ1YZxNfMdYgJqDSBb02
	 8+qgiN77OtQrrtVD35qUMOG+UbxL0wZ6hxz7kVHW7kDQpMCymgTkXgrSfdOAngfZEL
	 0kpC83uGeYJnMQZ9sIMKAee+rtSYa73G/VwbB0ZvQeO5EqVYHN5CY520kdeKOptwf/
	 gSdv6neyRTQ9uTpTmtPlsMYfIGnTYFKroK+7tOQTZBt9USMRq5nNGf55iS3xRicua0
	 cowZLMbIR04kvag6bcda4TnPe9l2ODQvHMxVyT1pmMy2kcRNqAqA1qcvx3im6ndu57
	 wri41iy39SKLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andrey Troshin <drtrosh@yandex-team.ru>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-media@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10 1/2] media: mtk-vcodec: potential null pointer deference in SCP
Date: Tue, 18 Aug 2026 23:32:25 -0400
Message-ID: <20260818220420.11@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818092842.1975-1-drtrosh@yandex-team.ru>
References: <20260818092842.1975-1-drtrosh@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 12:28:40PM +0300, Andrey Troshin wrote:
> [PATCH 5.10 1/2] media: mtk-vcodec: potential null pointer deference in SCP

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
