Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926700;
	b=BkubEA+W3p53rBFx8NL+LoI32sND2H+HnoKxiy0nbYGhcNBJb7oZlyGLveOJGzPkE2lr
	 f1f4hYLGAhtUyOAFCgoCZiqVOBOJuzaXQ3QCXNK4NW8gkoULT2OiLt2cFDBijBAoW8nD+
	 GRFlzzSWieQAjn6o84hLinYid9hRLgewILgeLjMuiPUNxEFgfPl1S1FnFnMwFHIUt6n4h
	 UyZh97LQtoNh0IKaKq0Jfg+VY90WtL7i1Uc123LB0mgSfnbhymd8iKIOX799xSQ+XYoEK
	 S2V3eMb1dZCo7CDO9KnzFNWCoLNg6h1FwKn9psJI+QqA1w/1i9srshkuGU/PZnlp/Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vjOXYVDqRH2HgoUzugKNvV8yU/Hk2+a8jJ4AiDy3/mo=;
	b=kjtyAZAJ5Q+tGKvBAojXwJ1f2eL+xaviD18PFhHZ++y/gBCmnIXhMNZKjcKEFRuIQYPj
	 xgxtx8dVKmwPLfZTo8Uk09vIdFMu/3PTxhL9YUZ2WAto2By928j6NIewbcapyop7D1+RZ
	 EHMIDEKbcqOnLx4MoloVsp2Bru/m2qq4eWD8eQ8BjsrbqcsXeKvgCKm7L6zhvG8fnngMH
	 wNxFYzKHv/oV/1/Jw6bkRh0KP7u9ZYE5XbiLOtQISlzG5rojs/XqFyYPwxn8xFQFSi82u
	 VsGwyt+QkFLXciQIyladU2ZwVTwGfJ5fq0FMd2mqm8uGwQsqKnPl+jLaKhGhOj53x9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsdcK2Nj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E5606A31B;
	Fri,  6 Nov 2026 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsdcK2Nj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D714E1F008A5;
	Fri,  6 Nov 2026 00:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926700;
	bh=vjOXYVDqRH2HgoUzugKNvV8yU/Hk2+a8jJ4AiDy3/mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsdcK2NjqIxUuSprRJR1YX930JwKVBJYJjhMiUN79i/9pCTIA7LP3Na30+GqiJzhs
	 ruZKnpJ10ha84jILNfzy5F/NjkJFKIMaqIaYIow7F9+RYody5YR8uH9Ypm/WhiJuN5
	 +AIqGKvVlGp6DFieUb6ql/HQt3RWJxlIyMFtNMnFnTi/q3OkPVCxIvVM4NlM8t6Uqg
	 I4twseP80qEo5XYgBNxxDMERXHg40cn0zqDkHSJiQOApxtmcAoeiaL0XV0S2dUiCWk
	 Kl6+CDEGCKhrXizZFfPLQ6jzvErQXUlziFAQTVj56p370eCk/+1qIuJg7ZUHgKm4iv
	 GKR9DogOA+Rag==
From: Danilo Krummrich <dakr@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Won Chung <wonchung@google.com>
Subject: Re: [PATCH] driver core: fix memory leak in physical location error path
Date: Fri,  6 Nov 2026 01:58:17 +0100
Message-ID: <20261106005817.1353792-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102083018.1275566-1-johan@kernel.org>
References: <20261102083018.1275566-1-johan@kernel.org>
X-Patch-Reply: applied
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon,  2 Nov 2026 09:30:18 +0100, Johan Hovold wrote:
> [PATCH] driver core: fix memory leak in physical location error path

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] driver core: fix memory leak in physical location error path
      commit: c890943b295b

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
