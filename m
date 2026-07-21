Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B712343BE;
	Tue, 21 Jul 2026 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595411; cv=none; b=cemqn2UG1LCOzV2XT7ybCk0IjMKsAAWx0cmzu/nOYKdJcMnAF+XAlbw5W+7E0TfiN29I8NU+r0PkMevXy2ZSXmaItnCcdsAfMhTQj3FvfFF0X9F/hm0IqzLuC/wny/HZShWH4ytZZElQke0jRumWRB5QnGMtNg5k/5QmB1CHDZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595411; c=relaxed/simple;
	bh=JVwnFGCAnbjB/qSE/g8BJHZsuhAls8GNPLWblFmdOto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIp+/zXMm63RR9imcC2I4UzzVU4MC/gmmO1GJnIYhVQ5WvBBRy+TbAucU/9ZihyQJZZ9IPuhRo0QilL2paq5n7L0gp4kbDVzMm4YxqwSWfpp0q21+AN45YCfrSbRaBx+GIPqhVo2w/aQAsV+EdqUSTJk5NpdmI2anHMnVcJKWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHV5SGCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHV5SGCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DBB1F00A3E;
	Tue, 21 Jul 2026 00:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595410;
	bh=gGdWM/13jGHuz3wJTyl8SuDGKXG0eRMStW6GAOaGyR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iHV5SGCmmd8KCF3tfXYtuhTQbTdPOWM/oL1kcXqAT4OoLeErzKlWUvLEFD/E7bTPN
	 hJV9tjTH2yTAeyb0zvZKYewZolTRO5VFjdb1onkxdwArXR6hkdqSxOKiVwjqoWqR3j
	 Uofpl7be990MWQpuOAIm6III5VJt+/sbj+zlWmfciP6AuP6DqhGJJ+8Bv/Q6inCjvP
	 XbjIhA8+kcmCyCkRQoJ84ROQBaY6OgE1vxQp12Nu6cIh6DojMQ+xci8hbpfKZHF1Pv
	 JFmm6+HfYtmOoDK8cJ2ab7ix05txf2kxZ2RiY9AFT0QSkPeaOIawO5b/OuFAcGcw6O
	 L2V9bGTqauTTw==
From: Sasha Levin <sashal@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Boqun Feng <boqun@kernel.org>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 6.12.y] rust: block: `allow(deprecated)` for `fetch_update` for Rust >= 1.99.0
Date: Mon, 20 Jul 2026 20:56:23 -0400
Message-ID: <20260720175500.0016-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANiq72nLTuv2s71bNBVV85bTbWriiCdhG_O+-=t+1Ubv-sHFJw@mail.gmail.com>
References: <CANiq72nLTuv2s71bNBVV85bTbWriiCdhG_O+-=t+1Ubv-sHFJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Warning: this is a 6.12.y-only patch -- I assume you prefer something
>> local like this instead of backporting the commit that made this go away
>> later with the move to `Refcount`.
>
> Cc'ing stable here in the reply.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
