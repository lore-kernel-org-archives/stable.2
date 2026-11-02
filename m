Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650644;
	b=d8/NSfDtGEq3pRv468NtTNEyPARE4wJTUQZIMsqVnjfp0eVj+ckUYnBkO+HHU5g1CKBH
	 rQ8FsmzAAFLehLw/j8Gbn4zP9MgMAqXO+XUEbeJJ15lqYNBYhaW2Qs5upFM8IRkJX7M7F
	 5GOfU2nACMAHEJ8h0dGL5eM1RWTVdRj4W2a+lXxCozj7mklz/lQMz00eBC0Pixu1siim0
	 8ShvscoZUkycn7flsEIwPBhmJidS6EzXiIsEYgEaNxJfl0/7queEUyThwazPXFjAm8g+q
	 bIwLHqnlhb7LAajIrVdBgAAu/quAYi1QBGlTcKe4jGHtg16DVlelNB3q/fnn6ZML2ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650644;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aWwgMQI+hwqIrnO83Bai38J313zuKR0Qykwm63oLTJw=;
	b=UibaBeIhClR/JlmIUZMX0Ez4c68rQqy6uJCOh/u5ZF/XAOZXu+QD4Pblvzwb1NljyLj2
	 G3EsLJvIS+XIkpHg4SK3Xo7LA1mNPGoInO+Xdyj/KfLW1yk4Qd1doK45lHvgh4ac3EpEW
	 xMFx6gEV1eOJbKEiFQZAMlyKXCE5xbD+1YfGUGrcxYmKk6u6N7lyeJc+BwD++0ax+amV1
	 w0nPgdJZON+avJqpyE+zRyONRKpt4ZnO5Sg6SwqpK42LdvSdCB9x3/4vMsrbJXH42Ii7T
	 U+oYRS2JL+n7lOuACXuwPph4hhb15dURKFWv53AxcNI/66eGJXQ+0GyLDk7mNwyQaGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1hVOWzD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1E606A324;
	Mon,  2 Nov 2026 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1hVOWzD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1659B1F00A16;
	Mon,  2 Nov 2026 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650643;
	bh=aWwgMQI+hwqIrnO83Bai38J313zuKR0Qykwm63oLTJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z1hVOWzD94SQG8YzuVqEgQTekqTYFh2IWUEdatbml5WHeb7wGt4MZpWOM6cryQb2x
	 eolGuJDtsgJXI/FLHj8lB6cvHr/IQpPCqhpgfwp7hRJDuAAy6bX+bZi5xm6JdISoTZ
	 ZrhbKpruTvnS6xB4TpdGiXkjyuHTqo6gkV/V2BoIDAkUldBcB2dV91pP8KsT1kJYAo
	 cTyOFBZ/rPz+2hA5tqPTEw2eCG6hfl6LgYddhk0RS0QZ3WPStF8aQemBeQQt3fU+Ea
	 nCHgl+FMxTxo2RRfek4SO72MguxRvqxIJjRx72WfL/hZeRtNQnhqqYZapD7N1A9FMK
	 W9l07sJLWcxSw==
From: Danilo Krummrich <dakr@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Eduardo Ruiz Duarte <toorandom@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] driver core: fix unbalanced reference counting for software nodes
Date: Mon,  2 Nov 2026 21:15:17 +0100
Message-ID: <20261102201517.3305902-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023-swnode-dev-notify-balance-v2-0-948d920a79f6@oss.qualcomm.com>
References: <20261023-swnode-dev-notify-balance-v2-0-948d920a79f6@oss.qualcomm.com>
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

On Fri, 23 Oct 2026 12:14:02 +0200, Bartosz Golaszewski wrote:
> [PATCH v2 0/3] driver core: fix unbalanced reference counting for software nodes

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/3] driver core: provide a test-and-clear device flag accessor
      commit: a03f144a4a12
[2/3] driver core: provide new device flag - DEV_FLAG_SWNODE_NOTIFIED
      commit: 2d2dbe2f1bf7

      [ Fix typo in the commit subject --
        s/DEV_FLAG_SWNODE_NOTIFIER/DEV_FLAG_SWNODE_NOTIFIED/. - Danilo ]

[3/3] software node: fix unbalanced reference counting
      commit: 071bbeab6aad

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
