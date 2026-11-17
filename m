Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794877394;
	b=Yy5zCAIpBLFr4Jdax7VsEpRnXNJ1bm2xnJNvJtwtK0LDghONTTcd4vcuXYLOUYQS2TzO
	 3NV0IS39EMzh28cQ4BSK+g/4jMO725pjXSDCo8SP40VakNzrGKG0xz2DAAOgbG7S/sYv+
	 8HTalm7xOywG64WxYg6+5OJ5n6BNL+cNUZPyxOX3CW+cLzP/RUK6lZlwKLWoYJJgVvSlQ
	 HABT0uiWLASf0x2mRZvjCGvATlMKAy6M1NwUvM2bQMBmfwZQ3KHK0H+92TVo4LHzdfVyf
	 TX4YueugH7hetPFzA6wNkeNFklobB4ZSalNwPz6dSy85+2Efw+jkpoUYRdgpQq+77ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794877394;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D+f5vr6V2nk6QWkhE7QlvMsoUu3QLbLbGmfQQ4jkQyc=;
	b=0FEUPm8IhVnPcBPZfgULElbQTCJ3Arom1PjL8jOc0wIclbH9CL35kiFe+dRXkpmfMXgA
	 TDx37g1amQ4JgZQLLEsto6dtCTiYPwUF03f/mwvkqv6CM68kKikhwbEXRmPDCJT0MO6is
	 UHTlKqtNRPwBtr09gWs1kZ6DsKJBF8ykpKAyTaM4Ia4riXghdShZmWBRVcqpHs8wf2+zX
	 KAMT1eenV+ZRDw8kn57iUgkZWF31AUi2psxokORva7nAKQWC543jO9iWY5Qaq7J4pXV+O
	 6+WA1mSpRrnNaHvI1+9kR30r7V03t+SVZiXyyszumKQA6oksTDqwpOO9yBfsTWb6XLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WC1Rradb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7E606A330
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WC1Rradb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8461F000C4;
	Tue, 17 Nov 2026 01:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794877394;
	bh=D+f5vr6V2nk6QWkhE7QlvMsoUu3QLbLbGmfQQ4jkQyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WC1RradbwnkrNT/xIn6cIOCc+RobDlvm2nYQf4smvz2mqndh4Fb+vMqw+dTjDEun1
	 ygbr0vRbkJyrSnEhKFdswUwwAAUjyw5OpNGlUzXtUMT3+J+zrSrgkGNl0G/MZcxMAV
	 5COglkXptH+kSczOCZAYy3wahzlwHRj6pYfbMZbK+nchJTOR91L4B+eSSWXw76uLP5
	 MKeG3JXL7ZmMmlqdL0/E8VrPVaGVNVfHvVWzx64WeaF5KkehAoPPYDA9XfVcCaFLAQ
	 T699eqZUU31ofaU9G/1jPVl+PGxKJxRl9O/I80bZzp4I62j4PKnBz1LOWAJ48AxC7i
	 p2z1ehHgOzTwg==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Stefan Teodorescu <fane@google.com>,
	Oren Yomtov <thenameisoren@gmail.com>,
	Chris Mason <mason@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.15.y 5/5] KVM: x86: Unconditionally reset MMU context when emulating INIT
Date: Mon, 16 Nov 2026 20:03:04 -0500
Message-ID: <2026-11-16-2-daily-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avuEvfAczcRP8a0i@seanjc-mac.roam.internal>
References: <avuEvfAczcRP8a0i@seanjc-mac.roam.internal>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> NAK. Backporting 4 *optimizations* to resolve a trivial conflict is absurd.

Agreed. I dropped the series and queued the commit for 5.15 as a single patch
with your hunk.

-- 
Thanks,
Sasha
