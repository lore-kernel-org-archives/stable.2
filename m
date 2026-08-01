Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A322F25F3
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785622414; cv=none; b=lswQFD2KkWB4R5mhBAAQ0LgOFO3XGEvUlfJfPZqktyBzJkxK6Ht9WjSsQm+U8Bhapx9GF95JJ/F+1t5I5F9fJiEQE0t4nWhyyPcBJEuqPOgQA+RBWQArGAf8VJtalA6L+nc8VCRil3Ej3WJM8xxAMzG9T8AF8AnWDpgbtbFewyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785622414; c=relaxed/simple;
	bh=Aq66OA6rbz7hD0hH0JMauMKpohFiN+RVJ0MWsUXZ91U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8KVZlnRikkI4WHptTM6THTtvn5bG9UpbBOZLl+WdKCl8pzSQDAXHOlU62Qq+CHpp24KBwnZTyVmrFYQgIQ1EEwFNOx2e32lqYKz+1ZxEu3yd5U5Bbil0/QsARCZOwZqk4KPTK3bLCCKvQYT0QISIGj0RNCGx49Fx6ensQ7mxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqK0SuPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqK0SuPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205071F00ADB;
	Sat,  1 Aug 2026 22:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785622413;
	bh=1ZYbIgAwMtofXA/xrD9Pi0z4KviCBgVVYEaEfA1DPxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UqK0SuPQ0GhLl+Szt+QIe05CmhqNIXP8SBXRyshp5Ff77ABGAZSvGno54tFzr35+0
	 gqhFkOnnx7CzELo8l9mV+1qul+0BYmSgo3+SQde9waUFFoJmxkbw+Kokorhjb2QJ1g
	 m6jwpZnYDssXcXbmM1G09sHNByebilCeUt6zlre4TViavxwUJda3mQqqz2xlFPfd5b
	 5cwBL++1EBV/ldu61Ia3sFmwxAduneKtih1ExIhekDuDkdPMq046a6j/ycqFEbj6gx
	 obeMsl+aEZreFpJcEo2Rf4p34EbUlxeDOMDJOyo6HOw1VckqDCZD1F/cOuHpveKnCe
	 Y52uXpSntkhiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eddie Phillips <eddiephillips@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 6.1.y] gve: fix Rx queue stall on alloc failure
Date: Sat,  1 Aug 2026 18:13:24 -0400
Message-ID: <20260801154223.stable-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731175209.2862108-1-eddiephillips@google.com>
References: <20260731175209.2862108-1-eddiephillips@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 10:52:09AM -0700, Eddie Phillips wrote:
> When the system is under extreme memory pressure, page allocations can
> fail during the Rx buffer refill loop. If the number of buffers posted
> to hardware falls below a critical low threshold and the refill loop
> exits due to allocation failures, the queue can stall

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
