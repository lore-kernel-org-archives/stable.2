Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD23845A9
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199343; cv=pass; b=XKX69g7C3XpSK4Ws64609ridLfF8aLc4l/DC7YjcRAuvwIKbN8Marzy+9tKz40MSyNEXXO4ieBW9YXcft2FKz1GF+KIUevOgCR3mTYZSRBbHew5yemsi6K4mNNSEt8HBdYYZYw5BuncURlN/pPQwW51ktc7WVzQYuG/vkMYsTTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199343; c=relaxed/simple;
	bh=75Peh7ssm8phsUJD3ZkLZHFwYmM3QKn/tUwpbiHhidg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xnt0J+llqkVqhZenPs5GezZn3Rc97SweoGIcURumvoT9oF6F44kNe4nkGGQDV+53kSKsQ9EIKxzTh33naghfXXwpwj2NHviRJhQAWXuInLKPEeU6PvlQ5DuF1ofIksBVFKgmTfVwO6+F5kzfsYWdlITGesvuI5XNwsyAcejaAWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XvmSV75I; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvmSV75I"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so1110a12.1
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 11:02:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788199340; cv=none;
        d=google.com; s=arc-20260327;
        b=chpj2DvaS51riIUa+b1FM6d/7lUE+DMODQMqi6c/jC/3NtZ5OT/1b4TZtuyN+g98Zt
         Rzji0P8r19xgeAJAAj83XQg0jX4qCBgUNzXH//o59E/WgXoYnpyqLTa6S8CqQ6yiTcEU
         Jz2Hd0c/x7pngiBlVX6nX04JgCVsVHNg1CplsyN0/lUcSdjRpPhX9N8iz/50EMRBCKJq
         7eR7Q64BlOwPWEY08Kn5VZ2Obb9IzyE6BcDElYodrX33h4yxQ2c+IPH82MBe1Gc/hON7
         g6uN89uBOwXV74E2T5tsDebU9B/WOuJ040UDq7ibcGtJyakY/82M+AhiuEBwyj0Q+m/k
         8hig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=75Peh7ssm8phsUJD3ZkLZHFwYmM3QKn/tUwpbiHhidg=;
        fh=gtHTNTpml83/RFFqzJxpqJaFEXOM1dFMheGhxY96T3Q=;
        b=cTHoYyEXQIObWI7XESBsS1ZNfECUHHTsmAHlCtAPVRtQBVEwRrlh/NzrEhnpNEtduQ
         6AObP7FkxMXvG7yIjNpMAHQHtV/Zt56MSSSg3Aq+mbICuGACexpjDb4mEtKENQOwuvzz
         MwRuz7S6kCqyOnsiloOi6f+gdZyjiNrr8e8Q14BbqMRhlajBO3yFCauVWLRt/AtE5pXO
         hhe7auu/lawaeBnp7vdEA7QzSwavG9AvR6xm3J+wlqbopryuJlcFy8HOG92CqzvKPVKI
         dlCZUJqi4L3Ywhg7SMyWZhsWbNz2u09RsBu3hpO66L1yvqduxtqBf4U/BuP6H4WY+6pP
         yaQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788199340; x=1788804140; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75Peh7ssm8phsUJD3ZkLZHFwYmM3QKn/tUwpbiHhidg=;
        b=XvmSV75IGw/P5cvyNGDtsONwapenqLlDkfpkWchR8ps9lLd2rQ40bXF++IPwMNMq0O
         r1UExgWmn0seAhP/OozrlUh9194yb2hATqXzcJx9b0z4YjLxMszTH1eV7B63VxcTi4jk
         yJqnt4gbltW6mmNcBoqVsEI5pNicWU0YKrI+jPH8a/u1ZUrTMP4Hzum8yOy02iALDFZ/
         OVKa6WwR7TGtOMczxIGO5aM2YldvZE9uNUkPyAg7SGy/gp2doLvRFX5KqrspNusbhECh
         OwsS0hYSx7LSffb1INnsZjpNKsuEwx+yxs/9t6pxQzMqhQCx6XBINrnST/lhmhXziaz7
         0Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788199340; x=1788804140;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=75Peh7ssm8phsUJD3ZkLZHFwYmM3QKn/tUwpbiHhidg=;
        b=Um2CLBc+wIUsgwavnyPTNZKrsqYGDsbywhQsJjLLHt6kXXFhdkRbXA/93bUmYjK9n3
         /Ya0DgRKO9JIfKIsANsA8p2e1es1DQYnlOWXnCjm/ngngxZiQ0RXFn51qVSA2PAkaEGF
         E27xapmSRCDu/L3v5rVpu/uZw4BziLxFXQz96XikLgbwEY9h2ZNy8dAI2ly+wvbzVXDz
         NpjZcEKnLa1UYG/3XhMhDwuJE8Siq1F9pYLOk6+9vBb2Hw/UR2uxwf1ApmXs0BiOL8Gq
         r4KwDDBH3DFKYanERWsXtEWrt9yaxiSjaadAeBssYsm48XOz3w3c05QIww+yl3egGAwz
         ulsw==
X-Forwarded-Encrypted: i=1; AKwUvBzDNL+Pb9w3viW/E40aIW8hllowAWpZ8hzj6nm7BzX/uMRBgIab1QgLMjxkpCKjRbV4ZHMjVO8=@vger.kernel.org
X-Gm-Message-State: AFuF++kdY0xXtGOeHVoG6XZHIMLPSLhXPAGYFFzJmsXLk1oP1JCuKwld
	SVIOhQtRfBt9U9xddfDEaFOObbxf/HT+MkQ9urzyJdOT2mplDUo8xv/Tj4l2XsTRe+x9mMwR21w
	RBS8YjUkNoSsXYb7IafdsatMUCTOw75hAqp7zAD2F
X-Gm-Gg: AYBFou3ZbI47UCWYQa09/P4bPqjJYUY4CvbVPrAJrsQjK6MnfUQdCxFTPTbGh38eGbw
	S6LyhHES3lRriiDnaneA2jri+8feTT+NgMK2f+g0JFxVLN5Jl+fziC/AjoUR3ZwYkvFjBpby9Pq
	BKLEhiZFA8yen+wgNlQRYF6jaSRePxatmBd0LlpzU/EzqE/Xmzsf/YC0b00347L+iYDS873jqf0
	ioqjhLJoSd8pZR1XNQFJvgJQcs4eNJ+b1a2EKq1SRSGFXO+OqCy6qhnjYD81mQKRXyYeLnpTTMn
	brGsR3/kAhxvi0K+yYcQbdZ/hfwN8SKoDGYAJqbJHj2pDk0WcyeVIa2VYBCUmRP+POh/ijpIaav
	VXA==
X-Received: by 2002:a05:6402:22d1:b0:6a3:ec9b:9dfe with SMTP id
 4fb4d7f45d1cf-6a66a17d251mr2710a12.8.1788199340005; Mon, 31 Aug 2026 11:02:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828215252.4126811-1-eperot@google.com> <ceef3a1e4e86deef2970e80d94925bac@kernel.org>
In-Reply-To: <ceef3a1e4e86deef2970e80d94925bac@kernel.org>
From: Etienne Perot <eperot@google.com>
Date: Mon, 31 Aug 2026 11:01:40 -0700
X-Gm-Features: AcwNN1UnnEGdSnQdQ17OP7lths-5KZ15H5ByB4zkfrtDMak_OBA1OLjNz_lVuJA
Message-ID: <CAFKBtDL9jBTy8BQL8poUCqckwmSRDByCQMfLyo3SMV3wnpaN3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: fix spurious SIGKILL of CLONE_INTO_CGROUP children
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks Tejun, and thanks Shakeel for the review.

- Etienne
