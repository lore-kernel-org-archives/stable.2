Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715F395AC7;
	Fri, 25 Sep 2026 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362105; cv=none; b=fe5UKFuwEj+/m24tOydrT6moVStGATQxB2YOVtu339QNhEoztVU8CpunE1d7z1vIro4JJVCymc9dRbcjZAOt/Wo/d/gcyR3BqPPOG9HNEdRnoQ3qhSTlVLrkX+W7fGtgZuXsruWMPBFuh5Kd4HRPVTU5p2DK2MkgkXb/FtC3PiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362105; c=relaxed/simple;
	bh=Pt+CqVS3nO4FdbRFiWVonyAixWWV8uVnnRxJJgGEOdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8YkZbJQe1a51LP/a+pHJPxHFeE8EKfGGN6pMP9FeHtcdei0pZcPBhmKNGRBeRJP6CsvxabRaTRgRCGRbQIowdZ7gB1jbhS7QAJUG8WBh3pReS3UaTqU5jWUdAUakWFXWbJDuh9S3zUfxpm2g0ygavqn7Lhy9XBwjqIwpOk8niI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0PaOEiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0PaOEiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588761F00899;
	Fri, 25 Sep 2026 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790362101;
	bh=jSFmNDAKnyRYZoFiFIKsqK4yVtBdCrope6nwABw46j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0PaOEiLjrcw4IPSayxwfHwLMQzk6up584New0jFING0SRgov27OrOUsCidr6qelS
	 QvK3rjVmaIZM93MgD7aYtnpmk5gVM6prMeL8O+nC2cOQ9sWJvhfjTBIHDWuoPHsDcU
	 R9gKHF3ULbl5tvoFBS3ZlmsR0DMQrfdNlAWQaXhDTG4PyDzZk0h+DtjyVLgoqgegXO
	 2ugttiGkIR8l+vwIdXZkLE/uPFR1ebat4U6NOA1Q98zq3xChOxCm5AOftQrJds2Yt3
	 97lONXsyQSXz8NCWfWpdpdeg1xPWJrD8ZEdKLUMEPSGW+2zG9wMe+m1xaVKH7R5LvJ
	 OezDZNbedvpdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Tom Rix <trix@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 6.1.y] start_kernel: Add __no_stack_protector function attribute
Date: Fri, 25 Sep 2026 14:47:58 -0400
Message-ID: <2026-09-25-daily-reply-0006-re-start-kernel-no-stack-protector-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924173100.87358-1-artem@trailofbits.com>
References: <20260924173100.87358-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Backport to 6.1.y: retain this tree's start_kernel() signature, which
>   predates its upstream __noreturn annotation, and add
>   __no_stack_protector. ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
